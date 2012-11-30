Given /^the blog is set up with profiles$/ do |table|
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  
  # create testing users
  table.hashes.each do |hash|
    User.create!(hash)
  end
end

Given /^some articles exist$/ do |table|
  table.hashes.each do |hash|
    steps %Q{
      Given I am logged in as "#{hash[:login]}" with password "#{hash[:password]}"
      When I am on the new article page
      Then I fill in "article_title" with "#{hash[:title]}"
      And I fill in "article__body_and_extended_editor" with "#{hash[:content]}"
      Then I press "Publish"
      And I logout
    }
  end
end

Given /^some comments exist$/ do |table|
  table.hashes.each do |hash|
    steps %Q{
      Given I am at the "#{hash[:title]}" article page
      Then I create a comment with "#{hash[:name]}", "#{hash[:email]}", "#{hash[:web]}", "#{hash[:comment]}"
      And I press "comment"
    }
  end
end

Given /^I am at the "(.*?)" article page$/ do |title|
  visit '/'
  click_link title
end

Given /^I am logged in as "(.*?)" with password "(.*?)"$/ do |user, pw|
  visit '/accounts/login'
  
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => pw
  
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

When /^I merge "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the article should contain "(.*?)" and "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the author should be "(.*?)" or "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the title should be "(.*?)" or "(.*?)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

And /^I logout$/ do
  visit '/accounts/logout'
end

Then /^I create a comment with "(.*?)", "(.*?)", "(.*?)", "(.*?)"$/ do |name, email, web, comment|
  fill_in 'comment_author', :with => name
  fill_in 'comment_email', :with => email
  fill_in 'comment_url', :with => web
  fill_in 'comment_body', :with => comment
  click_link 'comment'
end

