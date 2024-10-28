  PRIVATE SECTION.
    CLASS-DATA go_instance TYPE REF TO zcl_flight_legacy.

    CLASS-METHODS:
      "! Calculation of Price <br/>
      "!  <br/>
      "! Price will be calculated using distance multiplied and occupied seats.<br/>
      "! Depending on how many seats in percentage are occupied the formula <br/>
      "! 3/400·x² + 25<br/>
      "! will be applied.<br/>
      "!   0% seats occupied leads to 25% of distance as price.<br/>
      "!  75% seats occupied leads to 50% of distance as price.<br/>
      "! 100% seats occupied leads to 100% of distance as price.<br/>
      "! @parameter iv_seats_occupied_percent | occupied seats
      "! @parameter iv_flight_distance | flight distance in kilometer
      "! @parameter rv_price | calculated flight price
      calculate_flight_price
        IMPORTING
          iv_seats_occupied_percent TYPE zplane_seats_occupied
          iv_flight_distance        TYPE zflight_distance
        RETURNING
          VALUE(rv_price)           TYPE zflight_price ##RELAX.

    METHODS lock_travel IMPORTING iv_lock TYPE abap_bool
                        RAISING   zcx_flight_legacy ##RELAX ##NEEDED.

    METHODS _resolve_attribute IMPORTING iv_attrname      TYPE scx_attrname
                                         ix               TYPE REF TO zcx_flight_legacy
                               RETURNING VALUE(rv_symsgv) TYPE symsgv.
    "! Final determinations / derivations after all levels have been prepared, e.g. bottom-up derivations
    METHODS _determine EXPORTING et_messages           TYPE zif_flight_legacy=>tt_if_t100_message
                       CHANGING  cs_travel             TYPE ztravel
                                 ct_booking            TYPE zt_booking
                                 ct_booking_supplement TYPE zt_booking_supplement.
    METHODS _determine_travel_total_price CHANGING cs_travel             TYPE ztravel
                                                   ct_booking            TYPE zt_booking
                                                   ct_booking_supplement TYPE zt_booking_supplement
                                                   ct_messages           TYPE zif_flight_legacy=>tt_if_t100_message ##NEEDED.
    METHODS _convert_currency IMPORTING iv_currency_code_source TYPE zcurrency_code
                                        iv_currency_code_target TYPE zcurrency_code
                                        iv_amount               TYPE ztotal_price
                              RETURNING VALUE(rv_amount)        TYPE ztotal_price.