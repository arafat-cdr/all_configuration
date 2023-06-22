## First Delete the Public Folder Storage Shortcut.

** Then First:

### 1. Create the public/symlink.php

```php
<?php
    $targetFolder = '../site/storage/app/public';
    $linkFolder = __DIR__.'/storage';

    echo '<br/>'.$linkFolder.'<br/>';

    if(symlink($targetFolder,$linkFolder)){
        echo 'Symlink completed';
    } else {
        echo 'Symlink Failed';
    }

 ```

 *** Remember /site Is the folder name where all laravel codes exist
 In my working project::

 ### This folder: /www/century21

 ### has Below Folder:

 ** public folder
 ** site folder (all env, controller, config all laravel files lives here)
 ** index.php
 ** assets
 ** vendor
 ** uploads
 ** .htaccess


 *** Call this: http:mydomain/public/symlink.php

 ** Then Create a route call /clear

 ** use the below code:

 ```bash
# add by web_lover
Artisan::call('optimize:clear');
Artisan::call('route:clear');
Artisan::call('config:clear');
Artisan::call('config:cache');
Artisan::call('storage:link');
# add by web_lover

 ```

### *** Now call:: http:mydomain/clear

### ** Hope it fix the img issue
