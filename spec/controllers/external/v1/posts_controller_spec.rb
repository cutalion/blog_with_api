require 'rails_helper'

RSpec.describe External::V1::PostsController, type: :controller do
  describe "GET /external/v1/posts" do
    it "should return published posts" do
      published = create :post, draft: false
      draft     = create :post, draft: true

      get :index
      expect(JSON response.body).to eq([{
        "id"       => published.id,
        "title"    => published.title,
        "body"     => published.body,
      }])
      expect(response.status).to eq 200
    end
  end


  describe "GET /external/v1/posts/:id" do
    it "should return post details" do
      post = create :post, draft: false
      get :show, id: post.id

      expect(JSON response.body).to eq({
        "id"       => post.id,
        "title"    => post.title,
        "body"     => post.body,
      })
      expect(response.status).to eq 200
    end

    it "should return 404 if post is not published" do
      post = create :post, draft: true
      get :show, id: post.id

      expect(JSON response.body).to eq({ "error" => "Not found" })
      expect(response.status).to eq 404
    end
  end
end
