require "csv"

class SalesforceExporter
  def self.export_responses
    answers = Answer.joins(:question).where.not(questions: { salesforce_id: nil }).select('answers.response_id', 'answers.value', 'questions.salesforce_id')
    answers_by_response_id = answers.group_by { |answer| answer.response_id }
    headers = answers.map { |answer| answer.salesforce_id }.uniq.sort

    CSV.generate(headers: true) do |csv|
      csv << headers

      answers_by_response_id.each do |response_id, answers_for_response|
        row_data = answers_for_response.each_with_object({}) do |answer, hash|
          hash[answer.salesforce_id] = answer.value
        end

        row = headers.map { |header| row_data[header] }
        csv << row
      end
    end
  end
end
