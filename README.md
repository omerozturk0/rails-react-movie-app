# Installation

- Pull the repo first. :)
- Create a `.env.development` file at project directory and add following fields.
```yaml
SYSTEM_DB_USER=
SYSTEM_DB_PASS=
```
- Run the code on your console.
```text
rails db:migrate && rails db:seed
```
- Almost ready. We'll run the servers now. Run each of the following commands in separate console windows.
```text
rails s 
``` 

```text
bin/webpack-dev-server 
``` 

- You can check `http://localhost:3000` address from your browser.