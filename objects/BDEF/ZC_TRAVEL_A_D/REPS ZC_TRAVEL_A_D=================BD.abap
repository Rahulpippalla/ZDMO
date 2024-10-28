projection;
strict(2);

define behavior for ZC_Travel_A_D alias Travel
use etag
{
  use create;
  use update;
  use delete;

  use action acceptTravel;
  use action rejectTravel;
  use action deductDiscount;

  use association _Booking { create; }
}

define behavior for ZCBooking_A_D alias Booking
use etag
{
  use update;
  use delete;

  use association _BookingSupplement { create; }
  use association _Travel;
}

define behavior for ZC_BookingSupplement_A_D alias BookingSupplement
use etag
{
  use update;
  use delete;

  use association _Travel;
  use association _Booking;
}