class ClicksController < ApplicationController
  def create

    cookie_name = ENV['COOKIE_NAME'] || 'SHTR'

    # parse request
    request_string  = URI.parse(request.original_fullpath)
    path            = request_string.path
    slug            = path.split('/').second
    visitor_hash    = cookies[cookie_name]
    request_params  = CGI.parse(request_string.query.to_s)

    not_found unless slug

    # detect Link
    link = Link.where(slug: slug).first

    not_found unless link

    # detect or create/set Visitor
    visitor = Visitor.where(hash_string: visitor_hash).first_or_create
    cookies.permanent[cookie_name] = visitor.hash_string

    # create Click
    click = Click.create(visitor: visitor, link: link, clicked_url: path)

    # return redirect
    # response.set_header('Location', link.url)
    redirect_to link.url

  end

  protected

  def raise_error
    raise "error"
  end

  def not_found
    render :status => 404
    raise ActionController::RoutingError.new('Not Found')
  end

end