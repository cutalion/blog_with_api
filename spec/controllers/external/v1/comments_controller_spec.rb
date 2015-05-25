require 'rails_helper'

RSpec.describe External::V1::CommentsController, type: :controller do
  let(:article) { create :post, draft: false }
  let(:draft)   { create :post, draft: true }

  describe "GET /external/v1/posts/:post_id/comments" do
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

    it "should not return comments for draft" do
      get :index, post_id: draft.id
      expect(JSON response.body).to eq({"error" => "Not found"})
      expect(response.status).to eq 404
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

    it "should not return comment for draft" do
      comment = create :comment, post: draft
      get :show, post_id: draft.id, id: comment.id
      expect(JSON response.body).to eq({"error" => "Not found"})
      expect(response.status).to eq 404
    end
  end
end
