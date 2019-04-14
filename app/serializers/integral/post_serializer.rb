module Integral
  class PostSerializer
    include FastJsonapi::ObjectSerializer

    attributes :title, :description, :status, :slug, :created_at, :updated_at, :published_at, :url, :body

    attribute :author do |post|
      post.author&.name
    end

    attribute :tags do |post|
      post.tags.map { |tag| tag.name }.join(',')
    end

    attribute :featured_image do |post|
      post&.featured_image&.url(:large)
    end

    attribute :preview_image do |post|
      post&.preview_image&.url(:large)
    end
  end
end
