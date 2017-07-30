#!/bin/bash
# install php redis ext

Install_php-redis() {
  pushd ${oneinstack_dir}/src
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    phpExtensionDir=`${php_install_dir}/bin/php-config --extension-dir`
    if [ "`${php_install_dir}/bin/php -r 'echo PHP_VERSION;' | awk -F. '{print $1}'`" == '7' ]; then
      tar xzf redis-${redis_pecl_for_php7_version}.tgz
      pushd redis-${redis_pecl_for_php7_version}
    else
      tar xzf redis-$redis_pecl_version.tgz
      pushd redis-$redis_pecl_version
    fi
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config
    make -j ${THREAD} && make install
    if [ -f "${phpExtensionDir}/redis.so" ]; then
      echo 'extension=redis.so' > ${php_install_dir}/etc/php.d/ext-redis.ini
      echo "${CSUCCESS}PHP Redis module installed successfully! ${CEND}"
      popd
      rm -rf redis-${redis_pecl_for_php7_version} redis-$redis_pecl_version
    else
      echo "${CFAILURE}PHP Redis module install failed, Please contact the author! ${CEND}"
    fi
  fi
  popd
}
