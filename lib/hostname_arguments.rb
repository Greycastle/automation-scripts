require 'optparse'

def parse_hostname(opts, output)
  opts.on('-h', '--hostname <hostname>', 'Hostname to create') do |h|
    output[:hostname] = h
  end
end

def parse_browser(opts, output)
  opts.on('-b', '--browser <browser>', 'Browser to create') do |b|
    output[:browser] = b.to_sym
  end
end

def parse_commandline_options
  output_args = { browser: :chrome }
  parser = OptionParser.new do |opts|
    opts.banner = 'Usage: create_hostname.rb -h <hostname>'
    parse_hostname(opts, output_args)
    parse_browser(opts, output_args)
  end
  parser.parse!
  output_args
end
