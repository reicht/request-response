require 'minitest/autorun'
require 'minitest/pride'
require_relative '../db/setup'
require_relative '../bin/run'
# Remember to put the requires here for all the classes you write and want to use

USERS_LIST = [{:first_name => "Greg", :last_name => "Henry", :age => 34},
              {:first_name => "Mary", :last_name => "Beth", :age => 45},
              {:first_name => "Gina", :last_name => "Sue", :age => 66},
              {:first_name => "David", :last_name => "Illheim", :age => 12},
              {:first_name => "Ward", :last_name => "Deverson", :age => 24},
              {:first_name => "Miles", :last_name => "Guster", :age => 72},
              {:first_name => "Samael", :last_name => "Ouver", :age => 99},
              {:first_name => "Chuck", :last_name => "Testa", :age => 31},
              {:first_name => "Dwayne", :last_name => "Johnson", :age => 50},
              {:first_name => "Tooth", :last_name => "Fairy", :age => 83},]


def parse_params(uri_fragments, query_param_string)
  params = {}
  params[:resource]  = uri_fragments[3]
  params[:id]        = uri_fragments[4]
  params[:action]    = uri_fragments[5]
  if query_param_string
    param_pairs = query_param_string.split('&')
    param_k_v   = param_pairs.map { |param_pair| param_pair.split('=') }
    param_k_v.each do |k, v|
      params.store(k.to_sym, v)
    end
  end
  params
end
# You shouldn't need to touch anything in these methods.
def parse(raw_request)
  pieces = raw_request.split(' ')
  method = pieces[0]
  uri    = pieces[1]
  http_v = pieces[2]
  route, query_param_string = uri.split('?')
  uri_fragments = route.split('/')
  protocol = uri_fragments[0][0..-2]
  full_url = uri_fragments[2]
  subdomain, domain_name, tld = full_url.split('.')
  params = parse_params(uri_fragments, query_param_string)
  return {
    method: method,
    uri: uri,
    http_version: http_v,
    protocol: protocol,
    subdomain: subdomain,
    domain_name: domain_name,
    tld: tld,
    full_url: full_url,
    params: params
  }
end

system('clear')
loop do
  print "Supply a valid HTTP Request URL (h for help, q to quit) > "
  raw_request = gets.chomp

  case raw_request
  when 'q' then puts "Goodbye!"; exit
  when 'h'
    puts "A valid HTTP Request looks like:"
    puts "\t'GET http://localhost:3000/students HTTP/1.1'"
    puts "Read more at : http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html"
  else
    @request = parse(raw_request)
    @params  = @request[:params]
    # Use the @request and @params ivars to full the request and
    # return an appropriate response

    # YOUR CODE GOES BELOW HERE
    if @request[:subdomain] == "localhost:3000"
      if @params[:resource] == "users"
        if @params[:id].nil?
          puts "#{@request[:http_version]} 200 OK"
          puts
          puts
          USERS_LIST.each do |x|
            puts "Name: #{x[:first_name]} #{x[:last_name]}   Age: #{x[:age]}"
          end
        elsif @params[:id].to_i <= USERS_LIST.length
          user = USERS_LIST[(@params[:id].to_i - 1)]
          puts "#{@request[:http_version]} 200 OK"
          puts
          puts
          puts "Name: #{user[:first_name]} #{user[:last_name]}   Age: #{user[:age]}"
        else
          puts "#{@request[:http_version]} 404 NOT FOUND"
          puts
          puts
          puts "Requested User Not Found"
        end
      end
    else
      puts "#{@request[:http_version]} 404 NOT FOUND"
      puts
      puts
      puts "Requested Server Not Found"
    end

    # YOUR CODE GOES ABOVE HERE  ^
  end
end

class CommandCheck
  def CommandCheck.run(target, params)
    if target[:method] == "GET"
      SubDomainCheck.run(target, params)
    else
      puts ""
    end
  end
end

class SubDomainCheck
  def SubDomainCheck.run(target, params)
    if target[:subdomain] == "localhost:3000"
      ResourceCheck.run(target, params)
    else
      puts ""
    end
  end
end

class ResourceCheck
  def ResourceCheck.run(target, params)
    if target[:resource] == "users"
      continue
    else
      puts ""
    end
  end
end
