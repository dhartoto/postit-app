1. Name all the 7 (or 8) routes exposed by the resources keyword in the routes.rb file. Also name the 4 named routes, and how the request is routed to the controller/action.
A: With a Post Model the routes would be: 
    get '/posts', to: 'posts#index'
    get '/posts/:id' to: 'posts#show'
    get '/posts/new' to: 'posts#new'
    post '/posts/:id' to: 'posts#create'
    get 'posts/edit' to: 'posts#edit'
    patch 'posts/:id' to: 'posts#update'
    put 'posts/:id' to: 'posts#update'
    delete 'posts/:id/' to: 'posts#destroy'

   Named Routes:
    post_path
    posts_path
    new_posts_path
    edit_posts_path


2. What is REST and how does it relate to the resources routes?
A: REST stand for Representational State Transfer and is an architecture style for designing networked applications. HTTP protocol is used in most cases to make calls between machines. Resource routes are based on HTTP protocol.

Addition from solutions: RESTful applications use HTTP requests to perform CRUD operations. Resources routes are used to map the browser request (HTTP verb and URLs) to the controller actions of our app, allowing it to work seamlessly on the web.

3. What's the major difference between model backed and non-model backed form helpers?
A: Model backed form helpers are used primarily for performing CRUD operations on model objects, while non-model backed form helpers are used for other types of forms. Model backed form helpers have a lot more conventions attached to it.

Addition from solutions: Model backed form helpers are tied to an object. There has to be a setter method, a virtual attribute or a column in the database, available for that object when using the model backed form helpers. 

4. How does form_for know how to build the <form> element?
A: form_for is a helper method that abstracts away the creation of forms. form_for looks at the model object to identify if it's a new object or an existing object. If it is new then the data submitted by the user is redirected to the 'Create' action where it is validated and then saved in to the database. The 'POST' verb is used in this case. If it's an existing object, than the existing data is retrieved and displayed in the form. The HTTP verb in this case is a 'PATCH'/'PUT'. 

Addition from solutions: A form can be created by passing form_for a string or symbol relating to the object we want to deal with.

5. What's the general pattern we use in the actions that handle submission of model-backed forms (ie, the create and update actions)?
A: The general pattern requires validation of data models and strong parameters. Only when the data is validated is it saved to the database. If it fails, data is rejected and the form is rendered again. For example:

def new
  @post = Post.new(params.require(:post).permit!)
  if @post.save
    flash[:notice] = "You post has been created"
    redirect posts_path
  else
    render 'posts/new'
  end
end

def create
  @post = Post.find(params[:id])

  if @post.update(params.require(:post).permit!)
    flash[:notice] = "You post has been updated"
    redirect post_path(@post)
  else
    render 'posts/new'
  end
end


6. How exactly do Rails validations get triggered? Where are the errors saved? How do we show the validation messages on the user interface?
A: Rails validation gets triggered at the model layer. Errors are attached to the object so error methods can be called in the view templates. For example: @posts.errors.full_message

Incorrect: Validations are triggered when the data submissions try to hit the database. 

7. What are Rails helpers?
A: Helpers are model methods that are used to manipulate data or formatting. It is accessible in the controller and view.

Addition from solutions: Rails helpers allow us to consolidate our application's logic and formatting so we can properly display information in the views. By declaring helper methods within the "application_helper.rb" file, we are able to use the methods in the views without convoluting the views with logic code.

8. What are Rails partials?
A: Rail partials are view templates that are embedded/rendered within other templates. It is used as part of the DRY principle to reduce code replication.

Addition from solutions: Partial files are named wtih an underscore at the beginning.

9. When do we use partials vs helpers?
A: We'd use partials if we have sections within templates that have similar code. Helpers would be used to manipulate data.
Addition from solutions: A partial is a view fragment with HTML code that is usually shared and used mulitple times in view files. It should consist of code that is for presentation purpose only. On the other hand, while helpers also reduce code duplications, they are meant to be used when there is some logic to be processed within a view. This will eliminate the views to be consumed by logic, and instead, the views can remain "pure" for presentation usages.

10. When do we use non-model backed forms?
A: Usually when we need to create a form other than the ones that perform CRUD operations on models.
Addition from solutions: We can think of a non-model backed form as generating pure HTML rather than binding the form with a model object.