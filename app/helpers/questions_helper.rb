module QuestionsHelper 
  def question_header(question)
    if question.new_record?
      "Добавить вопрос по курсу: #{@test.title} "
    else
      "Редактировать вопрос по курсу: #{question.test.title} "
    end
  end
end
