# app/services/response_importer.rb

require 'csv'

class ResponseImporter
  attr_reader :file

  def initialize(file:)
    @file = file
  end

  def process
    csv = CSV.new(file.path, headers: false)

    headers = csv.shift
    questions_headings = csv.shift
    qualtrics_metadata_row = csv.shift

    question_info = headers.zip(questions_headings).to_h

    csv.each do |row|
      row_data = Hash[headers.zip(row)]

      ActiveRecord::Base.transaction do
        program_id = row_data["ProgramId__c"]
        survey = Survey.find_or_create_by(program: program_id)

        response = survey.responses.create!(unique_id: row_data['ResponseId'], uploader_id: Current.user.id)

        row_data.each do |header, value|
          question = survey.questions.find_by(name: header)

          unless question
            question = survey.questions.create!(name: header, heading: question_info[header])
          end

          response.answer.create!(question: question, value: value)
        end
      end
    end
    true
  rescue StandardError => e
    Rails.logger.error "Response import failed: #{e.message}"
    false
  end
end

  
  # attr_reader :file
  #
  # def initialize(file:)
  #   @file = file
  # end
  #
  # def process
  # csv = CSV.new(file.path, headers: false)
  #
  #     headers = csv.shift
  #     questions = csv.shift
  #     qualtrics_import_ids = csv.shift
  #     survey_id = Survey.find_by(program: row_hash['ProgramId__c'])
  #
  #   if !survey_id
  #     new_survey = Survey.new
  #     new_survey.program = row_hash['ProgramId__c']
  #     new_survey.save
  #     survey_id = new_survey.id
  #   end
  #
  #   question_data = Hash[headers.zip(questions, qualtrics_import_ids)]
  #
  #   question_data.each do |header, question_heading, qualtrics_id|
  #     question = Question.new
  #     question.survey_id = survey_id
  #     question.name = header
  #     question.qualtrics_id = qualtrics_id
  #     question.heading = question_heading
  #     question.save
  #   end
  #
  #   csv.each do |row|
  #     ActiveRecord::Base.transaction do
  #       row_hash = Hash[headers.zip(row)]
  #       response = Response.new
  #       response.unique_id = row_hash['ResponseId']
  #       response.uploader_id = Current.user.id
  #       response.survey_id = survey_id
  #       response.save
  #
  #       row_hash.each do |header, value|
  #         answer = Answer.new
  #         answer.value = value
  #         answer.response_id = response.id
  #         answer.question_id = question.id
  #         answer.save
  #       end
  #     end
  #   end
  # end
  #end
