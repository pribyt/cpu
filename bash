server {
  listen 1501 default;
  location / {
    default_type application/json;
    content_by_lua '
      command = "/app/app.sh"
      local handle = io.popen(command);
      local result = handle:read("*a");
      handle:close();
      ngx.print(result);';
  }
}


