module Integral
  # Front end tags controller
  class TagsController < BlogController
    before_action :find_tag, only: [:show]

    # GET /
    # List blog tags
    def index
      add_breadcrumb t('integral.breadcrumbs.tags'), nil
      @tags = Integral::Post.all_tag_counts(order: 'count desc').paginate(page: params[:page])
    end

    # GET /:id
    # Presents blog tags
    def show
      add_breadcrumb t('integral.breadcrumbs.tags'), :tags_url
      add_breadcrumb @tag.name, nil

      @meta_data = {
        page_title: @tag.name,
        page_description: t('integral.tags.show.description', tag_name: @tag.name)
      }

      @tagged_posts = Integral::Post.tagged_with(@tag.name).published.paginate(page: params[:page])
    end

    private

    def find_tag
      @tag = Integral::Post.all_tags.find_by_name!(params[:id])
    end

    def set_breadcrumbs
      super
      add_breadcrumb t('integral.breadcrumbs.blog'), :posts_url
    end
  end
end
