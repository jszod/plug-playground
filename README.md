# PlugPlayground

A simple playground for exploring Plug/Cowboy functionality.

The playground consists of the following simple components:  

  - Router - the routes
  - ProjectController - simple controller for handling project routes
  - Project - simple module that represents a model or external app

These components are for illustrative purposes to show how Plug/Cowboy plumbing works. They return return and display simple text output.

## Starting The application

```elixir
%> mix mix run --no-halt
```

Browse to
 
```
http://localhost:8080
```

Try some routes:

```
/project/123
/project/123/error (simulate a project id not found error)
/project/abc  (invalid project id)
```


