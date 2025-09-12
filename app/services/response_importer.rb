# app/services/response_importer.rb

require 'csv'

class ResponseImporter
  attr_reader :file

  def initialize(file:)
    @file = file
  end

  def get_qid(string)
    match_data = string.match(/^QID\d+/)
    match_data
  end

  def process
    puts "[Importer] Starting file processing."
    file_content = File.read(file.path)

    csv = CSV.parse(file_content, headers: false)

    if csv.length < 3
      raise "Invalid CSV format: The file must contain at least 2 header rows and 1 data row."
    end

    # Deconstruct the array of rows
    headers = csv.shift
    questions_headings = csv.shift
    data_rows = csv
    qualtrics_question_id = headers

    record_id_index = headers.index('_recordId')
    unless record_id_index
      raise "CSV file must have a '_recordId' column."
    end

    csv_response_ids = data_rows.map { |row| row[record_id_index] }.compact.uniq

    if csv_response_ids.any?
      existing_response_count = Response.where(unique_id: csv_response_ids).count

      if existing_response_count == csv_response_ids.length
        raise "All responses in this file have already been imported."
      end
    end

    question_info = headers.zip(questions_headings).to_h
    puts "[Importer] Headers parsed."

    data_rows.each_with_index do |row, index|
      row_data = Hash[headers.zip(row)]

      begin
        ActiveRecord::Base.transaction do
          program_id = row_data['ProgramID__c']
          puts "[Importer] Program ID: #{program_id.inspect}"

          survey = Survey.find_or_create_by!(program: program_id)
          response_id = row_data['_recordId']

          response = survey.responses.find_by(unique_id: response_id)
          if response.present?
            puts "[Importer] Response #{response_id} has already been imported! Skipping this row."
            next
          end
          response = survey.responses.create!(unique_id: row_data['_recordId'], uploader_id: Current.user.id)

          row_data.each do |header, value|
            question = survey.questions.find_by(name: header)
            unless question
              question = survey.questions.create!(name: header, heading: question_info[header])
            end

            if question
              response.answers.create!(question: question, value: value)
            end
          end
        end
      rescue => e
        puts "!!!!! [Importer] ERROR on row #{index + 1}: #{e.message} !!!!!"
        puts "[Importer] Failing row data: #{row_data.inspect}"
        puts e.backtrace.join("\n")
        raise e
      end
    end
    puts "[Importer] Finished file processing."
    true
  end
end
