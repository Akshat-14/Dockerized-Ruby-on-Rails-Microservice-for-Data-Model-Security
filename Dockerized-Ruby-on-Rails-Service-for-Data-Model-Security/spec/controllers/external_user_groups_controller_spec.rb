# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalUserGroupsController do
  describe '#create' do
    let(:external_user_group) { FactoryBot.create(:external_user_group,client_id:12) }
    let(:expected_json) do
      {
        id: external_user_group.id + 1,
        name: external_user_group.name,
        role: external_user_group.role,
        source_group_id: external_user_group.source_group_id,
        content_id: external_user_group.content_id,
        external_application_id: external_user_group.external_application_id,
        client_id: "13",
        created_at: external_user_group.created_at,
        updated_at: external_user_group.updated_at
      }.as_json
    end

    context 'when parameters are valid' do
      it 'creates new external_user_group' do
        post :create, params:  { name: external_user_group.name,
                                 role: external_user_group.role, source_group_id:external_user_group.source_group_id,
                                 content_id: external_user_group.content_id, external_application_id:external_user_group.external_application_id,
                                 client_id: 13 }.as_json
        expect(JSON.parse(response.body)).to eq(expected_json)
      end
    end

    context 'when parameters are invalid' do
      it 'renders bad request' do
        post :create, params:
        {
          role: 'owner',
          source_group_id: '23',
          content_id: 4321,
          external_application_id: 43
        }
        expect(response.status).to eq(400)
      end
    end
  end

  describe '#index' do
    let(:external_user_group) { FactoryBot.create(:external_user_group) }
    let(:expected_json) do
      {
        id: external_user_group.id,
        name: external_user_group.name,
        role: external_user_group.role,
        source_group_id: external_user_group.source_group_id,
        content_id: external_user_group.content_id,
        external_application_id: external_user_group.external_application_id,
        created_at: external_user_group.created_at,
        updated_at: external_user_group.updated_at
      }.as_json
    end

    context 'when id is valid' do
      before do
        get :index
      end

      it 'returns http success' do
        expect(response.status).to eq(200)
      end

      it 'matches count from database' do
        expect(JSON.parse(response.body).length).to eq(ExternalUserGroup.count)
      end
    end

    context 'when the id is invalid' do
      it 'shows not found' do
        get :show, params: { id: 'invalid' }
        expect(response.status).to eq(404)
      end
    end

    context 'shows valid Id' do
      it 'returns 200' do
        get :show, params: { id: external_user_group.id }
        expect(response.status).to eq(200)
      end
    end
  end

  describe '#delete' do
    let(:external_user_group) { FactoryBot.create(:external_user_group)}

    context 'when the id is valid' do
      it 'deletes successfully' do
        delete :destroy, params: { id: external_user_group.id }
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
    let(:external_user_group) { FactoryBot.create(:external_user_group) }

    context 'when id is valid' do

      it 'updates successfully when parameters are valid' do
        put :update, params: {id: external_user_group.id , role: 'owner' }
        expect(response.status).to eq(204)
      end

      it 'update fails when parameters are invalid' do
        put :update, params: {id: external_user_group.id,role: 'invalid'}
        expect(response.status).to eq(400)
      end
    end

    context 'when id is invalid' do
      it 'update is unsuccessful' do
        put :update, params: { id: 'invalid'}
        expect(response.status).to eq(404)
      end
    end

  end
end
