require_relative 'time_formatter'

class Application
  def call(env)
    request = Rack::Request.new(env)

    if request.path_info == '/time'
      time = TimeFormatter.new(request.params)
      Rack::Response.new(time.body, time.code, { 'Content-Type' => 'plain/text' })
    else
      Rack::Response.new('Not Found', 404, { 'Content-Type' => 'plain/text' })
    end
  end
end
