#!/bin/bash
# memcached php ext install

Install_php-memcache() {
  pushd ${oneinstack_dir}/src
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
    # php memcache extension
    if [ "$(${php_install_dir}/bin/php -r 'echo PHP_VERSION;' | awk -F. '{print $1}')" == '7' ]; then
      #git clone https://github.com/websupport-sk/pecl-memcache.git
      #cd pecl-memcache
      tar xzf pecl-memcache-php7.tgz
      pushd pecl-memcache-php7
    else
      tar xzf memcache-${memcache_pecl_version}.tgz
      pushd memcache-${memcache_pecl_version}
    fi
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config
    make -j ${THREAD} && make install
    popd
    if [ -f "${phpExtensionDir}/memcache.so" ]; then
      echo "extension=memcache.so" > ${php_install_dir}/etc/php.d/ext-memcache.ini
      echo "${CSUCCESS}PHP memcache module installed successfully! ${CEND}"
      rm -rf pecl-memcache-php7 memcache-${memcache_pecl_version}
    else
      echo "${CFAILURE}PHP memcache module install failed, Please contact the author! ${CEND}"
    fi
  fi
  popd
}

Install_php-memcached() {
  pushd ${oneinstack_dir}/src
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
    # php memcached extension
    tar xzf libmemcached-${libmemcached_version}.tar.gz
    pushd libmemcached-${libmemcached_version}
    [ "${OS}" == "CentOS" ] && yum -y install cyrus-sasl-devel
    [[ "${OS}" =~ ^Ubuntu$|^Debian$ ]] && sed -i "s@lthread -pthread -pthreads@lthread -lpthread -pthreads@" ./configure
    ./configure --with-memcached=${memcached_install_dir}
    make -j ${THREAD} && make install
    popd
    rm -rf libmemcached-${libmemcached_version}

    if [ "$(${php_install_dir}/bin/php -r 'echo PHP_VERSION;' | awk -F. '{print $1}')" == '7' ]; then
      tar xzf memcached-${memcached_pecl_php7_version}.tgz 
      pushd memcached-${memcached_pecl_php7_version} 
    else
      tar xzf memcached-${memcached_pecl_version}.tgz
      pushd memcached-${memcached_pecl_version}
    fi
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config
    make -j ${THREAD} && make install
    popd
    if [ -f "${phpExtensionDir}/memcached.so" ]; then
      cat > ${php_install_dir}/etc/php.d/ext-memcached.ini << EOF
extension=memcached.so
memcached.use_sasl=1
EOF
      echo "${CSUCCESS}PHP memcached module installed successfully! ${CEND}"
      rm -rf memcached-${memcached_pecl_version} memcached-${memcached_pecl_php7_version}
    else
      echo "${CFAILURE}PHP memcached module install failed, Please contact the author! ${CEND}"
    fi
  fi
  popd
}
