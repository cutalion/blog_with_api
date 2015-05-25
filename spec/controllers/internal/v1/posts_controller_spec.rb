require 'rails_helper'

RSpec.describe Internal::V1::PostsController, type: :controller do
  describe "GET /internal/v1/posts" do
    it "should return posts with comments" do
      post = create :post, draft: true, title: 'Post title', body: 'Post text'
      comment = create :comment, body: 'Comment text', post: post

      get :index
      expect(JSON response.body).to eq([{
        "id"       => post.id,
        "title"    => post.title,
        "body"     => post.body,
        "draft"    => post.draft,
        "comments" => [{
          "id"      => comment.id,
          "body"    => comment.body,
          "post_id" => post.id
        }]
      }])
      expect(response.status).to eq 200
    end
  end


  describe "GET /internal/v1/posts/:id" do
    it "should return post with comments" do
      post = create :post, draft: true, title: 'Post title', body: 'Post text'
      comment = create :comment, body: 'Comment text', post: post

      get :show, id: post.id
      expect(JSON response.body).to eq({
        "id"       => post.id,
        "title"    => post.title,
        "body"     => post.body,
        "draft"    => post.draft,
        "comments" => [{
          "id"      => comment.id,
          "body"    => comment.body,
          "post_id" => post.id
        }]
      })
      expect(response.status).to eq 200
    end

    context "when not found" do
      it "should return 404" do
        get :show, id: 999999999
        expect(JSON response.body).to eq({"error" => "Not found"})
      end
    end
  end


  describe "POST /internal/v1/posts" do
    context "with valid params" do
      it "should create new post" do
        post :create, { title: 'Title', body: 'Body', draft: false }

        expect(JSON response.body).to eq({
          "id"       => Post.last.id,
          "title"    => "Title",
          "body"     => "Body",
          "draft"    => false,
          "comments" => []
        })

        expect(response.status).to eq 201
      end
    end

    context "with invalid params" do
      it "should return errors" do
        post :create, { title: '', body: '', draft: false }

        expect(JSON response.body).to eq({
          "error"  => "Invalid parameters",
          "errors" => {
            "title" => ["can't be blank"],
            "body"  => ["can't be blank"],
          }
        })

        expect(response.status).to eq 400
      end
    end
  end


  describe "PUT /internal/v1/posts/:id" do
    let(:article) { create :post }

    context "with valid params" do
      it "should update post" do
        put :update, id: article.id, title: 'Updated title'
        expect(JSON response.body).to eq({
          "id"       => article.id,
          "title"    => 'Updated title',
          "body"     => article.body,
          "draft"    => article.draft,
          "comments" => []
        })

        expect(response.status).to eq 200
      end
    end

    context "with invalid params" do
      it "should return errors" do
        put :update, id: article.id, title: ''

        expect(JSON response.body).to eq({
          "error"  => "Invalid parameters",
          "errors" => {
            "title" => ["can't be blank"],
          }
        })

        expect(response.status).to eq 400
      end
    end
  end


  describe "DELETE /internal/v1/posts/:id" do
    it "should delete the post" do
      delete :destroy, id: create(:post).id
      expect(response.body).to be_blank
      expect(response.status).to eq 204
    end
  end
end
