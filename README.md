# Getting started
- B1: Clone project
    ```
    git clone git@github.com:framgia/tog3-202408-team2.git
    ```
- B2: Cd to BE folder
    ```
    cd be
    ```
- B3: Run docker
    ```
    docker-compose up
    ```
- B4: Exec to container 
    ```
    - docker ps 
    - select container id what want to exec
    - docker exec -it <container-id> bash
    - rails db:migrate
    - raild db:seed
    ```
- B5: Open local site and check
    ```
    Open http://localhost:3000 in browser
    ```
- B6: If you want to change rails credentials
    ```
    - exec to app container 
    - app-get update && apt-get install vim
    - rails credentials:edit
    ```
- B7: Need run rubocop before push conmit to github
    ```
    - exec to app container
    - rubocop -a ( auto fix by rubocop)
    - rubocop (check lint by rubocop)
    ```