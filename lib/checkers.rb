class Checkers
  def Checkers.command_check(target, params)
    if target[:method] == "GET"
      Checkers.subdomain_check(target, params)
    else
      puts "#{target[:http_version]} 405 METHOD NOT ALLOWED"
      puts
      puts
      puts "Invalid Method"
    end
  end

  def Checkers.subdomain_check(target, params)
    if target[:subdomain] == "localhost:3000"
      Checkers.resource_check(target, params)
    else
      puts "#{target[:http_version]} 404 NOT FOUND"
      puts
      puts
      puts "Server Not Found"
    end
  end

  def Checkers.resource_check(target, params)
    if params[:resource] == "users"
      Checkers.id_check(target, params)
    else
      puts "#{target[:http_version]} 404 NOT FOUND"
      puts
      puts
      puts "Server Resource Not Found"
    end
  end

  def Checkers.id_check(target, params)
    if params[:id].nil?
      puts "#{target[:http_version]} 200 OK"
      puts
      puts
      USERS_LIST.each do |x|
        puts "Name: #{x[:first_name]} #{x[:last_name]}   Age: #{x[:age]}"
      end
    elsif params[:id].to_i <= USERS_LIST.length
      user = USERS_LIST[(target[:id].to_i - 1)]
      puts "#{target[:http_version]} 200 OK"
      puts
      puts
      puts "Name: #{user[:first_name]} #{user[:last_name]}   Age: #{user[:age]}"
    else
      puts "#{target[:http_version]} 404 NOT FOUND"
      puts
      puts
      puts "Requested User Not Found"
    end
  end
end
