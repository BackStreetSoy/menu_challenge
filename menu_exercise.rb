require 'nokogiri'
require 'open-uri'

def page_text(url)
    page = Nokogiri::HTML(open(url))
    string = page.css('p').text
    @page_text = string.gsub("\n",' ').gsub("$", '')
end 

def target_price
    @page_text.slice!(/^[1-9]\d*(\.\d+)?/).to_f
end 

def items_and_prices_array
   target_price
   @page_text.split(/(?<=\d) ()/).reject!{|el| el.empty?}
end 

def prices_hash
    hash = {}
    items_and_prices_array.each do |pair|
        key,value = pair.split(/,/)
        hash[key] = value.to_f
    end 
    hash
end 

def isolate_combinations(url)
    page_text(url)
    combinations = []
    i = 1
         until i == prices_hash.values.length
             combinations << prices_hash.values.combination(i).to_a
             i += 1 
         end 
    combinations
end 

def check_combinations(url)
    x = 0
    successful_combinations = []
    combinations = isolate_combinations(url)
        until x == combinations.length 
            combinations[x].map do |combo|
                total = combo.inject{|sum, x| sum + x}.round(2) 
                if total == target_price
                    successful_combinations << combo
                end 
            end 
            x += 1
        end 
    if !successful_combinations.empty?
            successful_combinations.map do |price|
                puts "#{prices_hash.key(price)}: #{price}"
                    end 
        puts "total: " + "#{total}"
                        puts "\n\n"
    else 
        return false
    end 
end 

def print_all(url)
    x = 0
    combinations = isolate_combinations(url)
        until x == combinations.length 
            combinations[x].map do |combo|
                total = combo.inject{|sum, x| sum + x}.round(2) 
                combo.map do |price|
                puts "#{prices_hash.key(price)}: #{price}"
                    end 
                puts "total: " + "#{total}"
                        puts "\n\n"    
            end 
            x += 1
        end 
end 

def run 
    puts "please enter the url of your menu..."
    menu_url = gets.chomp
    puts "loading"
    sleep(1)
    if menu_url.match(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/) != nil
        if !check_combinations(menu_url)
            puts "Sorry no matches. Would you like to see every item combination? (y/n)?"
            response = gets.chomp

            if response == "y"
                print_all(menu_url)
            elsif response == "n"
                puts "try different url? (y/n)?"
                response = gets.chomp
                if response == "y"
                    run
                elsif response =="n"
                    sleep(1)
                    puts "Goodbye!"
                else 
                    puts "Sorry. That is not a recognized response."
                end 
            else 
                puts "Sorry. That is not a recognized response."
            end 
        end 
    else 
        puts "Sorry. Invalid Url. Try Again? (y/n)?"
        response = gets.chomp
                if response == "y"
                    run
                elsif response =="n"
                    sleep(1)
                    puts "Goodbye!"
                else 
                    puts "Sorry. That is not a recognized response."
                end 
    end 
end 

run







