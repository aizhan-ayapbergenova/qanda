require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create :question }

  describe 'Post #create' do
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js} }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { answer: FactoryBot.attributes_for(:answer), question_id: question }, format: :js
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question}, format: :js }.to_not change(Answer, :count)
      end

      it 're-renders question show view' do
        post :create, params: { answer: FactoryBot.attributes_for(:invalid_answer), question_id: question }, format: :js
        expect(response).to redirect_to question_path(question)
      end
    end
  end

  describe 'PATCH #update' do
    let(:answer) { create(:answer, question: question) }
    sign_in_user
    it 'asssigns the requested answer to @answer' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns the question' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer) }, format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, question_id: question , answer: { body: 'new body' } }, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render udpate template' do
      patch :update, params: { id: answer, question_id: question , answer: attributes_for(:answer) }, format: :js
      expect(response).to render_template :update
    end
  end
  
    
end
