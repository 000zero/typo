@focus
Feature: Merge Articles Security
  As a blog administrator
  In order to secure the blog
  I want to only allow admins to merge articles

  Scenario Outline: Admin and Non-Admin article merge
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
    Given I am logged in as "<user>" with password "<pw>"
    When I go to edit the "<title>" article
    Then I should <action>

    Examples:
      | user  | pw       | title    | action                   |
      | admin | aaaaaaaa | Foobar   | see "Merge Articles"     |
      | test  | bbbbbbbb | Universe | not see "Merge Articles" |

