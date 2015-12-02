# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie) 
  end
  #fail "Unimplemented"
end

Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
  step %Q{I should see "#{movie}"}
  step %Q{I should see "#{director}"}
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should match /#{e1}.*#{e2}/m 
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating| 
    # \s 	Any whitespace character
    # a* 	Zero or more of a
    rating = "ratings_#{rating}"
    if uncheck 
    # uncheck returns true or false depending on the regex above
      uncheck(rating) 
      # taken from web_steps.rb
      # Capybara method
    else
      check(rating) 
      # taken from web_steps.rb
      # Capybara method
    end
  end
  #fail "Unimplemented"
end

Then /^I should (not )?see the following movies: (.*)$/ do |should_not_case, movie_list|
  movie_list.split(/,\s*/).each do |movie|
    step %Q{I should #{should_not_case}see "#{movie}"}
  end
end

Then /I should see all of the movies here/ do
  # Make sure that all the movies in the app are visible in the table
  # this is not working...
  #rows = page.all('table#movies tr').count
  #rows.should == 11 
  #rows = Movie.find(:all).length.should page.body.scan(/<tr>/).length
  #rows.should == 11
  
  rows = page.all('table#movies tbody tr').length 
  rows.should == Movie.count
  
  #Movie.pluck(:title).each do |title|
  #  step %Q{I should see '#{title}'}
  #end
  
  #expect(rows).to == 11
  #all("table#movies tr").count.should == 11
  
  #page.should have_css("table#movies tbody tr", :count => movies_count.to_i)
  #page.should have_css("table#movies tbody tr", :count => movies_count.to_i)
  # the number of rows for the table at sort_movie_list.feature
  #fail "Unimplemented"
end 



