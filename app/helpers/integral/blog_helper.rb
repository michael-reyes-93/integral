module Integral
  # Blog Helper which contains methods used through the blog
  module BlogHelper
    # @param post [Integral::Post] post to convert to JSON-LD
    #
    # @return [String] Javascript snippet containing JSON-LD of the provided post
    def render_post_as_json_ld(post)
      render_json_ld do
        post.to_json_ld.merge("@context": 'http://schema.org')
      end
    end

    # @param posts [Integral::Post] collection of posts to convert to JSON-LD
    #
    # @return [String] Javascript snippet containing JSON-LD of the provided posts
    def render_posts_as_json_ld(posts)
      render_json_ld do
        {
          "@context": 'http://schema.org',
          "@type": 'Blog',
          "name": t('.title'),
          "url": request.original_url,
          "description": t('.description'),
          "publisher": {
            "@type": 'Organization',
            "name": Integral::Settings.website_title
          },
          "blogPosts": posts.map(&:to_json_ld)
        }
      end
    end

    # Whether or not to display newsletter signup widget
    def display_newsletter_signup_widget?
      true
    end

    # Whether or not to display share widget
    def display_share_widget?
      return true if "#{controller_name}.#{action_name}" == 'posts.show'

      false
    end

    # Whether or not to display recent posts sidebar widget
    def display_recent_posts_widget?
      return false if "#{controller_name}.#{action_name}" == 'posts.index'

      true
    end

    # Whether or not to display recent posts sidebar widget
    def display_popular_posts_widget?
      Integral::Post.published.count > 4
    end
  end
end
