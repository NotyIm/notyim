module ElmHelper
  def elm_component(name, props = {}, options = {}, &block)
    options = {:tag => options} if options.is_a?(Symbol)

    html_options = options.reverse_merge(:data => {})
    html_tag = html_options[:tag] || :div

    # remove internally used properties so they aren't rendered to DOM
    html_options.except!(:tag)
    id = [name, rand(10000000)].join("-")
    html_options[:id] = id

    content_tag(html_tag, "", html_options, false, &block) + javascript_tag("app.#{name}.embed(document.getElementById('#{id}'))")
  end
end