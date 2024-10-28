managed implementation in class zbp_i_carrierslocksingle_s unique;

strict(2);
with draft;

define behavior for ZI_CarriersLockSingleton_S alias CarriersLockSingleton
with unmanaged save
draft table zdcarr_lock
lock master
total etag LastChangedAtMax
authorization master ( global )
##DRAFT_OP_NOT_REQUIRED
{
  association _Airline { create; with draft; }

  field ( readonly ) CarrierSingletonID;

  draft action Edit;
  draft action Activate;
  draft action Discard;
  draft action Resume;
  draft determine action Prepare
  {
    validation Carrier ~ validateName;
    validation Carrier ~ validateCurrencyCode;
  }
}

define behavior for ZI_Carrier_S alias Carrier
persistent table zcarrier
draft table zdcarrier
lock dependent by _CarrierSingleton
authorization dependent by _CarrierSingleton
etag master LocalLastChangedAt
{
  update;
  delete ( features : instance );

  field ( readonly ) CarrierSingletonID;
  field ( mandatory : create, readonly : update ) AirlineID;
  field ( mandatory ) Name, CurrencyCode;

  association _CarrierSingleton { with draft; }

  validation validateName on save { create; field Name; }
  validation validateCurrencyCode on save { create; field CurrencyCode; }

  mapping for zcarrier
  { AirlineID = carrier_id;
    CurrencyCode = currency_code;
    Name = name;
    LocalCreatedBy = local_created_by;
    LocalCreatedAt = local_created_at;
    LocalLastChangedBy = local_last_changed_by;
    LocalLastChangedAt = local_last_changed_at;
    LastChangedAt = last_changed_at;
  }
}