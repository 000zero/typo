@focus
Feature: Merge Articles
  As a blog administrator
  In order manage content
  I want to be able to merge articles

  Background:
    Given the blog is set up with profiles
      | login | password | email              | profile_id | name  | state  |
      | admin | aaaaaaaa | joe@snow.com       | 1          | admin | active |
      | test  | bbbbbbbb | pparker@marvel.com | 2          | test  | active |
    And some articles exist
      | login | password | title    | content                                      |
      | admin | aaaaaaaa | Foobar   | Lorem Ipsum                                  |
      | test  | bbbbbbbb | Universe | Dolor sit amet, consectetuer adipiscing elit |
    And some comments exist
      | title    | name   | email            | web          | comment                     | 
      | Foobar   | Steven | test@nowhere.com | zero.com     | test comment                |
      | Foobar   | Dave   | dsmith@aol.com   | www.dave.com | haha that comment was funny |
      | Universe | Olivia | og@gmail.com     | google       | my comments rule!           |
      | Universe | Olivia | og@gmail.com     | google       | they still rock, you jelly? |

  Scenario: Successful merge
    Given I am logged in as "admin" with password "aaaaaaaa"
    When I merge "Foobar" with "Universe"
    Then the article should contain "Lorem" and "Dolor"
    And the author should be "admin" or "test"
    And the title should be "Foobar" or "Universe" 
    

