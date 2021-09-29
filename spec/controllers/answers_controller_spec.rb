require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'Post #create' do
    let(:question) { create :question }
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js} }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { answer: FactoryBot.attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question} }.to_not change(Answer, :count)
      end

      it 're-renders question show view' do
        post :create, params: { answer: FactoryBot.attributes_for(:invalid_answer), question_id: question }
        expect(response).to redirect_to question_path(question)
      end
    end
  end
end
