#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: yarr
#
# Launch yarr
# ------------------------------------------------------------------------------

main() {
    bashio::log.trace "${FUNCNAME[0]}"

    # Run yarr
    /usr/local/bin/yarr -addr 0.0.0.0:7070 -db /data/yarr.db
}
main "$@"
