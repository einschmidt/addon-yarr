#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: yarr
#
# Launch yarr
# ------------------------------------------------------------------------------

main() {
  bashio::log.trace "${FUNCNAME[0]}"

  ingress_port=$(bashio::addon.ingress_port)

  # Run yarr
  /usr/local/bin/yarr -addr 0.0.0.0:"${ingress_port}" -db /data/yarr.db
}
main "$@"
