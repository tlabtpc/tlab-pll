class Views::Layouts::Application < Views::Base
  def content
    html lang: "en" do
      head do
        meta content: "text/html; charset=UTF-8", "http-equiv" => "Content-Type"
        meta charset: "utf-8"
        meta content: "width=device-width, initial-scale=1.0", name: "viewport"
        meta content: Rails.application.config.project_description, name: "description"

        title(content_for?(:title) ? capture { yield(:title) } : Rails.application.config.site_name)

        csrf_meta_tags
        stylesheet_link_tag 'application', media: 'all'

        javascript_include_tag 'application'

        font = 'Calibri'
        link rel: "stylesheet", type: "text/css", href: "//fonts.googleapis.com/css?family=#{font}"
        link rel: "stylesheet", type: "text/css", href: "//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"

        style do
          text(<<~STYLE.html_safe)
            body, h1, h2, h3, h4, p { font-family: '#{font}', serif; }
          STYLE
        end
      end

      body class: controller_action_html_class do
        top_bar title: Rails.application.config.site_name

        flash.each do |name, msg|
          div msg, "aria-label" => name, "aria-role" => "dialog", class: ['callout', 'flash', name]
        end

        div(class: :container) do
          if content_for?(:card)
            div(class: :"card-wrapper") do
              div(class: :card) do
                yield(:progress_bar) if content_for?(:progress_bar)
                yield(:card)
              end

              render partial: "copyright"
            end
          else
            yield
          end

          if content_for?(:tip)
            div(class: :tips) { yield(:tip) }
          end
        end

        div(class: :footer) do
          div(class: "footer-flash")

          div(class: "footer__buttons-container") do
            div(class: "footer__buttons") do
              content_for?(:back) ? yield(:back) : div
              content_for?(:next) ? yield(:next) : div
              div # spacer for flexbox
            end
          end
        end

        google_analytics_js
      end
    end
  end

  private

  def google_analytics_id
    ENV['GOOGLE_ANALYTICS_ID']
  end

  def google_analytics_js
    return unless google_analytics_id

    javascript <<~JS
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

      ga('create', '#{google_analytics_id}', 'auto');
      ga('send', 'pageview');
    JS
  end
end
