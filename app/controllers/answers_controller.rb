class AnswersController < ApplicationController
  def create
    pp Question.all
    puts params[:question_id]
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params)
    redirect_to question_path(@question)
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
    
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
