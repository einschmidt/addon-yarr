#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: yarr
#
# Launch yarr
# ------------------------------------------------------------------------------

main() {
  declare db_path

  bashio::log.trace "${FUNCNAME[0]}"

  # Show yarr version in log
  /usr/local/bin/yarr -version

  # Set db file path
  db_path="/data/yarr.db"
  if bashio::config.has_value 'db_path'; then
    db_path=$(bashio::config 'db_path')
  fi

  # Run yarr
  /usr/local/bin/yarr -addr 127.0.0.1:7070 -db "${db_path}"
}
main "$@"
