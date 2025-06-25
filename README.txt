After a build, these statements need to be executed in the terminal:

docker cp source/settings.php graingenes_drupal:/var/www/html/GG3/sites/default
docker cp source/drupal_prvt_files/ graingenes_drupal:/data/drupal_prvt_files


docker cp-a source/gg3_modules/all/libraries/ graingenes_drupal:/var/www/html/GG3/sites/all
docker cp -a source/gg3_modules/all/modules/ graingenes_drupal:/var/www/html/GG3/sites/all
docker cp -a source/gg3_modules/all/themes/ graingenes_drupal:/var/www/html/GG3/sites/all

# all these need to be chowned to www-data:www-data inside the containe


docker cp source/apache/000-default.conf graingenes_drupal:/etc/apache2/sites-available/

docker cp source/adaptivetheme/ graingenes_drupal:/var/www/html/GG3/sites/default/files

docker cp -a files graingenes_drupal:/var/www/html/GG3/sites/default/
@ will need to be chowned

docker cp source/GG3_3.png graingenes_drupal:/var/www/html/GG3/sites/default/files/

in docker_graingenes: mkdir /var/www/html/images
docker cp USDA_logo_trans.png graingenes_drupal:/var/www/html/images

other things to do:

a2enmod rewrite




to reload apache:

/etc/init.d/apache2 reload

To login to drupal: https://testing.graingenes.org/GG3/user/login?graingenes=gguser


