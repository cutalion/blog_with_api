require 'rails_helper'

RSpec.describe Internal::V1::CommentsController, type: :controller do
  let(:article) { create :post }

  describe "GET /internal/v1/posts/:post_id/comments" do
    it "should return post comments" do
      comment = create :comment, body: 'Comment text', post: article

      get :index, post_id: article.id
      expect(JSON response.body).to eq([{
        "id"      => comment.id,
        "body"    => comment.body,
        "post_id" => article.id
      }])
      expect(response.status).to eq 200
    end
  end


  describe "GET /internal/v1/posts/:post_id/comments/:id" do
    it "should return post comment" do
      comment = create :comment, body: 'Comment text', post: article

      get :show, post_id: article.id, id: comment.id
      expect(JSON response.body).to eq({
        "id"      => comment.id,
        "body"    => comment.body,
        "post_id" => article.id
      })
      expect(response.status).to eq 200
    end
  end


  describe "POST /internal/v1/posts/:post_id/comments" do
    context "with valid params" do
      it "should add new comment to post" do
        post :create, post_id: article.id, body: 'Great!', draft: false

        expect(JSON response.body).to eq({
          "id"      => Comment.last.id,
          "body"    => 'Great!',
          "post_id" => article.id
        })

        expect(response.status).to eq 201
      end
    end

    context "with invalid params" do
      it "should return errors" do
        post :create, post_id: article.id, body: ''

        expect(JSON response.body).to eq({
          "error"  => "Invalid parameters",
          "errors" => {
            "body" => ["can't be blank"],
          }
        })

        expect(response.status).to eq 400
      end
    end
  end


  describe "PUT /internal/v1/posts/:post_id/comments/:id" do
    let(:comment) { create :comment, post: article }

    context "with valid params" do
      it "should update post comment" do
        put :update, post_id: article.id, id: comment.id, body: 'LOL!'
        expect(JSON response.body).to eq({
          "id"      => comment.id,
          "body"    => 'LOL!',
          "post_id" => article.id
        })

        expect(response.status).to eq 200
      end
    end

    context "with invalid params" do
      it "should return errors" do
        put :update, post_id: article.id, id: comment.id, body: ''

        expect(JSON response.body).to eq({
          "error"  => "Invalid parameters",
          "errors" => {
            "body" => ["can't be blank"],
          }
        })

        expect(response.status).to eq 400
      end
    end
  end


  describe "DELETE /internal/v1/posts/:post_id/comments/:id" do
    it "should delete the post comment" do
      comment = create :comment, post: article
      delete :destroy, post_id: article.id, id: comment.id
      expect(response.body).to be_blank
      expect(response.status).to eq 204
    end
  end
end
