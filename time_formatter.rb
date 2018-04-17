class TimeFormatter
  attr_reader :code, :body

  FORMATS = {
    'year' => '%Y-', 'month' => '%m-', 'day' => '%d',
    'hour' => '%H:', 'minute' => '%M:', 'second' => '%S'
  }.freeze

  def initialize(params)
    @formats = ''
    @unknowns = []
    @body = formatter(params)
  end

  private

  def formatter(params)
    check_params(params['format'].split(','))

    if @unknowns.empty?
      current_time
    else
      unknown_formats
    end
  end

  def check_params(params)
    params.each do |parameter|
      if FORMATS[parameter]
        @formats << FORMATS[parameter]
      else
        @unknowns << parameter
      end
    end
  end

  def current_time
    @code = 200
    Time.now.strftime(@formats)
  end

  def unknown_formats
    @code = 400
    "Unknown time format #{@unknowns}"
  end
end
