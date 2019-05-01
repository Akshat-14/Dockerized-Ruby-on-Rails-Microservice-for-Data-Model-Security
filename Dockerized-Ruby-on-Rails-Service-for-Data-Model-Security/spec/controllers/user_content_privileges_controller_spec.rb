# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserContentPrivilegesController do
  describe '#create' do
    let(:user_content_privilege) { FactoryBot.create(:user_content_privilege, content_id: 321, user_grouping_type: 'qwert', user_grouping_id: 'group-32') }
    let(:expected_json) do
      {
        id: user_content_privilege.id + 1,
        role: user_content_privilege.role,
        content_id: user_content_privilege.content_id,
        user_grouping_type: user_content_privilege.user_grouping_type,
        user_grouping_id: 'group-43',
        client_id: user_content_privilege.client_id,
        created_at: user_content_privilege.created_at,
        updated_at: user_content_privilege.updated_at
      }.as_json
    end

    context 'when parameters are valid' do
      it 'creates new user_content_privilege' do
        post :create, params: { role: user_content_privilege.role,
                                content_id: '321', user_grouping_type: 'qwert',
                                user_grouping_id: 'group-43', client_id: user_content_privilege.client_id }.as_json
        expect(JSON.parse(response.body)).to eq(expected_json)
      end
    end
    context 'when parameters are invalid' do
      it 'renders bad_request' do
        post :create, params:
        {
          role: 'owner',
          content_id: 4321,
          user_grouping_type: 'group-11',
          user_grouping_id: '23'
        }
        expect(response.status).to eq(400)
      end
    end
  end
  
  describe '#index' do
    let(:user_content_privilege) { FactoryBot.create(:user_content_privilege) }

    before do
      get :index, params: { client_id: user_content_privilege.client_id }
    end
    let(:expected_json) do
      [{
        id: user_content_privilege.id,
        role: user_content_privilege.role,
        content_id: user_content_privilege.content_id,
        user_grouping_type: user_content_privilege.user_grouping_type,
        user_grouping_id: user_content_privilege.user_grouping_id,
        client_id: user_content_privilege.client_id,
        created_at: user_content_privilege.created_at,
        updated_at: user_content_privilege.updated_at
      }].as_json
    end
    context 'when the id is valid Id' do
      it 'returns http success' do
        expect(response.status).to eq(200)
      end
      it 'contains expected attributes' do
        expect(JSON.parse(response.body)).to eq(expected_json)
      end
    end
    context 'when the id is invalid' do
      it 'shows not found' do
        get :show, params: { id: 'invalid' }
        expect(response.status).to eq(404)
      end
    end
    context 'show Valid Id' do
      it 'returns 200' do
        get :show, params: { id: user_content_privilege.id }
      end
    end
  end

  describe '#delete' do
    let(:user_content_privilege) { FactoryBot.create(:user_content_privilege) }

    context 'when the id is valid' do
      it 'deletes successfully' do
        delete :destroy, params: { id: user_content_privilege.id }
        expect(response.status).to eq(204)
      end
    end
    context 'when the id is invalid' do
      it 'delete fails' do
        delete :destroy, params: { id: 'invalid' }
        expect(response.status).to eq(404)
      end
    end
  end

  describe '#update' do
    let(:user_content_privilege) { FactoryBot.create(:user_content_privilege) }

    context 'when id is valid' do

      it 'updates successfully when parameters are valid' do
        put :update, params: { id: user_content_privilege.id ,role: 'owner'}
        expect(response.status).to eq(204)
      end

      it 'update fails when parameters are invalid' do
        put :update, params: {id: user_content_privilege.id,role: 'invalid'}
        expect(response.status).to eq(400)
      end
    end

    context 'Update Unsuccessful' do
      it 'Invalid parameters' do
        put :update, params: { id: 1000 }
      end

    end
  end
end
