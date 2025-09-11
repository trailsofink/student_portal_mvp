# app/services/response_importer.rb

require 'csv'

class ResponseImporter
  attr_reader :file
  
  def initialize(file:)
    @file = file    
  end

  def process
    ActiveRecord::Base.transaction do
      csv = CSV.new(file.path, headers: false)

      headers = csv.shift
      questions = csv.shift
      qualtrics_import_id = csv.shift
      response = Response.new
      survey_id = Survey.find_by(program: row['ProgramId__c'])

      if survey_id 
        response.survey_id = survey_id
      else 
        new_survey = Survey.new
        new_survey.program = headers.row['ProgramId__c']
        response.survey_id = new_survey.id
      end

      new_question = Question.new
      new_question.survey_id = survey_id
      

      csv.each do |row|
        row_hash = Hash[headers.zip(row)] 
        answer = Answer.new
        row_hash.each do |value|
          answer.value = row_hash[value]
        end
      end
    end
  end
end
