require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets list of cats" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )

      get '/cats'

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq(1)
    end
  end

  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat:{
          name: 'Stephen',
          age: 13,
          enjoys: 'digging in the trees for bird nests',
          image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
        }
      }

      post '/cats', params: cat_params
      expect(response).to have_http_status(200)

      cat = Cat.first

      expect(cat.name).to eq 'Stephen'
    end

    it "does not create a cat without a name" do
      cat_params = {
        cat:{
          age: 13,
          enjoys: 'digging in the trees for bird nests',
          image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
        }
      }

      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['name']).to include "can't be blank"
    end

    it "does not create a cat without a age" do
      cat_params = {
        cat:{
          name: 'Stephen',
          enjoys: 'digging in the trees for bird nests',
          image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
        }
      }
      
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['age']).to include "can't be blank"
    end

    it "does not create a cat without a enjoys" do
      cat_params = {
        cat:{
          name: 'Stephen',
          age: 13,
          image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
        }
      }
      
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['enjoys']).to include "can't be blank"
    end

    it "does not create a cat without a image" do
      cat_params = {
        cat:{
          name: 'Stephen',
          age: 13,
          enjoys: 'digging in the trees for bird nests'
        }
      }
      
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['image']).to include "can't be blank"
    end

  end

  describe "PATCH /update" do
    it "it can update a cat at a particular id" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )
              cat_params = {
          cat:{
            name: 'Stephen',
            age: 15,
            enjoys: 'digging in the trees for bird nests',
            image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
          }
        }

      cat = Cat.last

      patch "/cats/#{cat.id}", params: cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)


      expect(updated_cat.age).to eq 15
    end

    it "it doesn't update a cat without a name" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )
              cat_params = {
          cat:{
            name: nil,
            age: 15,
            enjoys: 'digging in the trees for bird nests',
            image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
          }
        }

      cat = Cat.last

      patch "/cats/#{cat.id}", params: cat_params
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)

      expect(json['name']).to include "can't be blank"
    end

    it "it doesn't update a cat without a age" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )
              cat_params = {
          cat:{
            name: 'Stephen',
            age: nil,
            enjoys: 'digging in the trees for bird nests',
            image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
          }
        }

      cat = Cat.last

      patch "/cats/#{cat.id}", params: cat_params
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)

      expect(json['age']).to include "can't be blank"
    end

    it "it doesn't update a cat without a enjoys" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )
              cat_params = {
          cat:{
            name: 'Stephen',
            age: 15,
            enjoys: nil,
            image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
          }
        }

      cat = Cat.last

      patch "/cats/#{cat.id}", params: cat_params
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)

      expect(json['enjoys']).to include "can't be blank"
    end

    it "it doesn't update a cat without a image" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )
              cat_params = {
          cat:{
            name: 'Stephen',
            age: 15,
            enjoys: 'digging in the trees for bird nests',
            image: nil
        }
      }
      cat = Cat.last

      patch "/cats/#{cat.id}", params: cat_params
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)

      expect(json['image']).to include "can't be blank"
    end

    it "it doesn't update, a cat if the enjoys, is less than 10 characters" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )
              cat_params = {
          cat:{
            name: 'Stephen',
            age: 15,
            enjoys: 'digging',
            image:  'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
        }
      }
      cat = Cat.last

      patch "/cats/#{cat.id}", params: cat_params
      expect(response.status).to eq(422)
      json = JSON.parse(response.body)

      expect(json['enjoys']).to include 'is too short (minimum is 10 characters)'
    end


  end
  describe "DELETE /destroy" do
    it "kills a cat" do
      Cat.create(
        name: 'Stephen',
        age: 13,
        enjoys: 'digging in the trees for bird nests',
        image: 'https://static.onecms.io/wp-content/uploads/sites/47/2020/11/30/cat-stuck-in-tree-298823311-2000.jpg'
      )
      
     cat = Cat.last 
    delete "/cats/#{cat.id}"

      expect(response).to have_http_status(200)
      cat = Cat.all
      expect(cat).to be_empty
    end
  end
end