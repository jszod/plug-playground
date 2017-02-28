# PlugPlayground

A simple playground for exploring Plug/Cowboy functionality.

The playground consists of the following simple components:  

  - Router - the main router
  - APIRouter - router for API routes
  - ProjectController - simple controller for handling project actions
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
/project/9999 (simulate a project id not found error)
/project/abc  (invalid project id format)

/api/v1/projects (a json response from an api route)
```


