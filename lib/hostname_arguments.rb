require 'optparse'

def parse_commandline_options
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'Usage: create_hostname.rb -h <hostname>'

    opts.on('-h', '--hostname <hostname>', 'Hostname to create') do |h|
      options[:hostname] = h
    end
  end.parse!
  options
end
