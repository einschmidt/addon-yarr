#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Home Assistant App: yarr
#
# Launch yarr
# ------------------------------------------------------------------------------

create_auth() {
  bashio::log.trace "${FUNCNAME[0]}"

  declare username
  declare password

  # Check user credentials
  bashio::config.require.username 'login.username'
  bashio::config.require.password 'login.password'

  # Load user credentials
  username=$(bashio::config 'login.username')
  password=$(bashio::config 'login.password')

  # Create auth file
  echo "$username:$password" > /usr/local/bin/auth

  bashio::log.info "Created auth file successfully"
}

main() {
  bashio::log.trace "${FUNCNAME[0]}"

  declare db_path

  # Create auth
  create_auth

  # Show yarr version in log
  /usr/local/bin/yarr -version

  # Set db file path
  db_path="/data/yarr.db"
  if bashio::config.has_value 'db_path'; then
    db_path=$(bashio::config 'db_path')
  fi

  # Run yarr
  /usr/local/bin/yarr \
    -addr 127.0.0.1:7099 \
    -db "${db_path}" \
    -auth-file /usr/local/bin/auth
}
main "$@"
