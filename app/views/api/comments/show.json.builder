json.comment do
    json.extract! @comment, :id, :author_id, :post_id, :body, :created_at, :updated_at
end
