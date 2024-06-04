# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DataSets', type: :request do
  let(:user) { create(:user) }
  let(:data_set) { create(:data_set) }

  describe '#index' do
    let(:path) { '/data_sets' }

    include_examples 'unauthenticated', :get

    context 'when authenticated' do
      include_examples 'unauthorized', :get, :data_consumer
      include_examples 'unauthorized', :get, :data_reviewer

      include_examples 'authorized', :get, :data_admin
      include_examples 'authorized', :get, :volunteer
      include_examples 'authorized', :get, :data_importer

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        it "renders the 'index' template" do
          get(path)
          expect(response.body).to include(
            'List of the public data sets uploaded by Code for'
          )
        end

        it 'returns all the data sets' do
          data_sets = create_list(:data_set, 3)
          get(path)
          data_sets.each do |data_set|
            expect(response.body).to include(data_set.title)
          end
        end
      end
    end
  end

  describe '#show' do
    let(:path) { "/data_sets/#{data_set.slug}" }

    include_examples 'unauthenticated', :get

    context 'when authenticated' do
      include_examples 'unauthorized', :get, :data_consumer
      include_examples 'unauthorized', :get, :data_reviewer

      include_examples 'authorized', :get, :data_admin
      include_examples 'authorized', :get, :volunteer
      include_examples 'authorized', :get, :data_importer

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        it "renders the 'show' template" do
          get path
          expect(response.body).to include(data_set.title)
        end

        context 'when slug was changed' do
          it 'redirects to the new slug' do
            old_slug = data_set.slug
            data_set.update(title: 'Chicago Data 2022')
            expect(old_slug).not_to eq(data_set.slug)

            get("/data_sets/#{old_slug}")
            expect(response.headers['Location']).to eq('http://www.example.com/data_sets/chicago-data-2022')
          end
        end
      end
    end
  end

  describe '#new' do
    let(:path) { '/data_sets/new' }

    include_examples 'unauthenticated', :get

    context 'when authenticated' do
      include_examples 'unauthorized', :get, :data_consumer
      include_examples 'unauthorized', :get, :data_reviewer
      include_examples 'unauthorized', :get, :volunteer

      include_examples 'authorized', :get, :data_admin
      include_examples 'authorized', :get, :data_importer

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        it "renders the 'new' template" do
          get path
          expect(response.body).to include('New Dataset')
        end
      end
    end
  end

  describe '#edit' do
    let(:path) { "/data_sets/#{data_set.slug}/edit" }

    include_examples 'unauthenticated', :get

    context 'when authenticated' do
      include_examples 'unauthorized', :get, :data_consumer
      include_examples 'unauthorized', :get, :data_reviewer
      include_examples 'unauthorized', :get, :volunteer

      include_examples 'authorized', :get, :data_admin
      include_examples 'authorized', :get, :data_importer

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        it "renders the 'edit' template" do
          get "/data_sets/#{data_set.slug}/edit"
          expect(response.body).to include('Make updates to this existing dataset.')
        end
      end
    end
  end

  describe '#create' do
    let(:path) { '/data_sets' }
    let(:valid_params) do
      {
        data_set: {
          title: 'My Dataset',
          files: [
            Rack::Test::UploadedFile.new('spec/support/files/police-incidents-2022.csv', 'text/csv')
          ]
        }
      }
    end

    include_examples 'unauthenticated', :post

    context 'when authenticated' do
      include_examples 'unauthorized', :post, :data_consumer
      include_examples 'unauthorized', :post, :data_reviewer
      include_examples 'unauthorized', :post, :volunteer

      include_examples 'authorized', :post, :data_admin, :found
      include_examples 'authorized', :post, :data_importer, :found

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        context 'with invalid params' do
          it 'returns an error' do
            post '/data_sets', params: {
              data_set: {
                title: 'My Dataset',
                files: []
              }
            }

            expect(response).to have_http_status(:unprocessable_entity)
            expect(DataSet.count).to eq(0)
            expect(response.body).to include('Files can&#39;t be blank')
          end
        end

        context 'with valid params' do
          it 'creates a dataset' do
            post '/data_sets', params: valid_params

            expect(response).to have_http_status(:found)
            expect(DataSet.count).to eq(1)
            expect(DataSet.last.title).to eq('My Dataset')
          end
        end
      end
    end
  end

  describe '#update' do
    let(:path) { "/data_sets/#{data_set.slug}" }
    let(:valid_params) do
      {
        data_set: {
          title: 'My Updated Dataset'
        }
      }
    end

    include_examples 'unauthenticated', :patch

    context 'when authenticated' do
      include_examples 'unauthorized', :patch, :data_consumer
      include_examples 'unauthorized', :patch, :data_reviewer
      include_examples 'unauthorized', :patch, :volunteer

      include_examples 'authorized', :patch, :data_admin, :found
      include_examples 'authorized', :patch, :data_importer, :found

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        context 'with invalid params' do
          it 'returns an error' do
            patch "/data_sets/#{data_set.slug}", params: {
              data_set: {
                title: nil
              }
            }

            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.body).to include('Title can&#39;t be blank')
          end
        end

        context 'with valid params' do
          it 'updates a dataset' do
            patch "/data_sets/#{data_set.slug}", params: valid_params

            expect(response).to have_http_status(:found)
            expect(data_set.reload.title).to eq('My Updated Dataset')
          end
        end
      end
    end
  end

  describe '#destroy' do
    let(:path) { "/data_sets/#{data_set.slug}" }

    include_examples 'unauthenticated', :delete

    context 'when authenticated' do
      include_examples 'unauthorized', :delete, :data_classifier
      include_examples 'unauthorized', :delete, :data_consumer
      include_examples 'unauthorized', :delete, :data_reviewer
      include_examples 'unauthorized', :delete, :volunteer
      include_examples 'unauthorized', :delete, :data_importer, :found

      include_examples 'authorized', :delete, :data_admin, :found

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        context 'with invalid params' do
          it 'returns an error' do
            expect do
              delete '/data_sets/123'
            end.to raise_error(ActiveRecord::RecordNotFound)
          end
        end

        context 'with valid params' do
          it 'destroys the dataset' do
            delete path

            expect(response).to have_http_status(:found)
            expect(DataSet.count).to eq(0)
          end
        end
      end
    end
  end

  describe '#map' do
    let(:data_set) do
      create(:data_set, files: [
               Rack::Test::UploadedFile.new('spec/support/files/police-incidents-2022.csv', 'text/csv')
             ])
    end

    let(:path) { "/data_sets/#{data_set.slug}/map" }

    include_examples 'unauthenticated', :get

    context 'when authenticated' do
      include_examples 'unauthorized', :get, :data_consumer
      include_examples 'unauthorized', :get, :data_reviewer
      include_examples 'unauthorized', :get, :volunteer

      include_examples 'authorized', :get, :data_admin
      include_examples 'authorized', :get, :data_importer

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        it 'maps the dataset' do
          get path

          expect(response).to have_http_status(:ok)
          expect(response.body).to include('Map Data Fields')
        end
      end
    end
  end

  describe '#analyze' do
    let(:data_set) do
      create(:data_set, files: [
               Rack::Test::UploadedFile.new('spec/support/files/police-incidents-2022.csv', 'text/csv')
             ])
    end

    let(:path) { "/data_sets/#{data_set.slug}/analyze" }

    include_examples 'unauthenticated', :get

    context 'when authenticated' do
      include_examples 'unauthorized', :get, :data_consumer
      include_examples 'unauthorized', :get, :data_reviewer
      include_examples 'unauthorized', :get, :volunteer

      include_examples 'authorized', :get, :data_admin
      include_examples 'authorized', :get, :data_importer

      context 'when authorized' do
        let(:role) { create(:role, name: :data_admin) }
        let(:user) { create(:user, role:) }

        before { sign_in user }

        it 'analyses the dataset' do
          get "/data_sets/#{data_set.slug}/analyze"

          expect(response).to have_http_status(:ok)
          expect(data_set.reload.analyzed?).to be(true)
        end
      end
    end
  end
end
