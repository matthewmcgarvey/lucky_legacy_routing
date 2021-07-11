module LuckyLegacyRouting
  VERSION = "0.1.1"

  # Define a nested route that responds to the appropriate HTTP request
  # automatically
  #
  # This works similarly to `route` but it will provide multiple parameters.
  # For example:
  #
  # ```
  # class Posts::Comments::Show
  #   nested_route do
  #     plain_text "Post: #{post_id}, Comment: #{comment_id}"
  #   end
  # end
  # ```
  #
  # This action responds to the `/posts/:post_id/comments/:comment_id` path.
  macro nested_route
    infer_nested_route

    setup_call_method({{ yield }})
  end

  # Define a route that responds to the appropriate HTTP request automatically
  #
  # ```
  # class Posts::Show
  #   route do
  #     plain_text "Post: #{post_id}"
  #   end
  # end
  # ```
  #
  # This action responds to the `/posts/:post_id` path.
  #
  # Each route needs a few pieces of information to be created:
  #
  # * The HTTP method, like `GET`, `POST`, `DELETE`, etc.
  # * The path, such as `/users/:user_id`
  # * The class to route to, like `Users::Show`
  #
  # The `route` method will try to determine these pieces of information based
  # the class name. After it knows the class, Lucky will transform the full
  # class name to figure out the path, i.e. removing the `::` separators and
  # adding underscores. The method is found via the last part of the class name:
  #
  # * `Index` -> `GET`
  # * `Show` -> `GET`
  # * `New` -> `GET`
  # * `Create` -> `POST`
  # * `Edit` -> `GET`
  # * `Update` -> `PUT`
  # * `Delete` -> `DELETE`
  #
  # If you are using a non-restful action name you should use the `get`, `put`,
  # `post`, or `delete` methods. Otherwise you will see an error like this:
  #
  # ```text
  # Could not infer route for User::ImageUploads
  # ```
  #
  # **See also** our guides for more information and examples:
  # * [Automatically Generate RESTful Routes](https://luckyframework.org/guides/actions-and-routing/#automatically-generate-restful-routes)
  # * [Examples of automatically generated routes](https://luckyframework.org/guides/actions-and-routing/#examples-of-automatically-generated-routes)
  #
  # setup_call_method is supplied by Lucky::Routable
  macro route
    infer_route

    setup_call_method({{ yield }})
  end

  # :nodoc:
  macro infer_nested_route
    infer_route(has_parent: true)
  end

  # :nodoc:
  macro infer_route(has_parent = false)
    {{ run "./run_macros/infer_route", @type.name, has_parent }}
  end
end
