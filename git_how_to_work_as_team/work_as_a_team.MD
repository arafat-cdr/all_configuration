https://yangsu.github.io/pull-request-tutorial/#:~:text=To%20create%20a%20pull%20request,the%20%22Head%20branch%22%20dropdown.


** do not merger develop with your code :
Develop is always broken or unstable 

### all cmd:

-- 1. git checkout main

-- 2. git pull origin main

-- 3. git checkout -b feature/list-page-price-html

-- 4. update the code or something else

-- 5. git add .

-- 6. git commit -m "arafat change version 2 test"

-- 7. git push origin feature/list-page-price-html

-- 8. Create PR against main (in the web github)

-- 9. git checkout develop (check out mean change the branch to my_needed_branch)

-- 10. git pull origin develop

-- 11. git merge feature/list-page-price-html

-- 13. git checkout develop (check out mean change the branch to my_needed_branch)

-- 12. confirm and 
git push origin develop