module Api::V1::OrdersHelper
  def calculate(lat1, long1, lat2, long2)
    Geocoder::Calculations.distance_between([lat1, long1], [lat2, long2])
  end

  def getDistanceFromLatLongInKm(lat1,long1,lat2,long2)
    r = 6371
    dLat = deg2rad(lat2 - lat1)
    dLong = deg2rad(long2 - long1)
    a =  Math.sin(dLat/2) * Math.sin(dLat/2) +
         Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
         Math.sin(dLong/2) * Math.sin(dLong/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = r * c
    d.round(1)
  end

  def deg2rad(deg)
    deg * (Math::PI/180)
  end

  def current_voucher
    session[:voucher] ||= {}
  end
end
