require 'rails_helper'
require 'factory_bot'

RSpec.describe QuestionsController, type: :controller do
  let(:question) {create(:question) }
  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before do 
      @questions = [FactoryBot.build_stubbed(:question)]
      allow(Question).to receive(:all).and_return(@questions)
      get :index 
    end

    it 'fills an array of all questions' do
      expect(assigns(:questions)).to match_array(@questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question, format: :js } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'Get #new' do
    sign_in_user
    
    before { get :new }

    it 'assigns a new question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'Get #edit' do
    sign_in_user

    before { get :edit, params: { id: question } }

    it 'assigns an edited question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { question: attributes_for(:question), format: :js} }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: FactoryBot.attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new question in the database' do
        expect { post :create, params: { question: attributes_for(:invalid_question)} }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'with valid attributes' do
      it 'asssigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question , question: { title: 'new title', body: 'new body' } }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to the udpated question' do
        patch :update, params: { id: question , question: { title: 'new title', body: 'new body' } }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question , question: { title: 'new title', body: nil} } }
      it 'does not change the question attributes' do
        question.reload
        expect(question.title).to eq 'title sample'
        expect(question.body).to eq 'text sample'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    
    before { question }

    it 'deletes the question' do
      expect { delete :destroy, params: {id: question} }.to change(Question, :count).by(-1)
    end

    it 'redirects to index view' do
      delete :destroy, params: {id: question} 
      expect(response).to redirect_to question_path
    end
  end
end
