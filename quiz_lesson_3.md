1. What's the difference between rendering and redirecting? What's the impact with regards to instance variables, view templates?
A: There is a new HTTP request when redirecting whereas there isn't when rendering. When redirecting, you loose the data saved in the instance variables. We use render when there is an error so that we can display the error message attached to the instance variable. 

2. If I need to display a message on the view template, and I'm redirecting, what's the easiest way to accomplish this?
The easiest way to do this is to use a flash as it passes temporary objects between actions. 

3. If I need to display a message on the view template, and I'm rendering, what's the easiest way to accomplish this?
We can use flash.now.

4. Explain how we should save passwords to the database.
Passwords shouldn't be saved to the database. It is more secure to use one way hashes. We can use a gem like bcrypt to create the hashes that are stored.

5. What should we do if we have a method that is used in both controllers and views?
For methods that are used for formatting we can use helpers.

6. What is memoization? How is it a performance optimization?
Memoization is used when there are multiple calls to the database that are identical on a single request. It saves the data to an instance variable so that it can be accessed by the other calls and therefore the database will only be called once.

7. If we want to prevent unauthenticated users from creating a new comment on a post, what should we do?
We'll have to do two things. One is to create a method in the controller that checks if the user is logged in, and if not redirect to a landing page when they try to access a page to create a comment. The second thing to do is to add a condition in the template that hides the form when users are not logged in.

8. Suppose we have the following table for tracking "likes" in our application. How can we make this table polymorphic? Note that the "user_id" foreign key is tracking who created the like.

id  user_id  likeable_type  likeable_id
 1     4          video         12
 2     7          post           3
 3     2          photo          6


9. How do we set up polymorphic associations at the model layer? Give example for the polymorphic model (eg, Vote) as well as an example parent model (the model on the 1 side, eg, Post).

class like <ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true
end

class user < ActiveRecord::Base
  ...
  has_many :likes
end

class photo < ActiveRecord::Base
  ...
  has_many :likes, as: :likeable
end

class video < ActiveRecord::Base
  ...
  has_many :likes, as: :likeable
end

class post < ActiveRecord::Base
  ...
  has_many :likes, as: :likeable
end

10. What is an ERD diagram, and why do we need it?
An ERD diagram stands for Entity Relationship Diagram. It is used to describe and model relational databases. We need it for planning the development of such databases. 