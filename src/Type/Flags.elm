module Type.Flags exposing (Flags)

import Json.Encode
import Type.LocalStorage



-- The expected flags on initialization, sent from JavaScript (static/index.js)


type alias Flags =
    { timeAppStarted : Int
    , windowSize : { width : Int, height : Int }
    , localStorage : Json.Encode.Value
    , images :
        { logo : String
        , email : String
        , facebook : String
        , phone : String
        , tutoring_01 : String
        , tutoring_02 : String
        , schools_french : String
        , schools_spanish : String
        , schools_french_01 : String
        , schools_french_02 : String
        , schools_french_03 : String
        , schools_french_04 : String
        , schools_french_05 : String
        , schools_spanish_flyer : String
        , schools_spanish_food : String
        , schools_spanish_room : String
        , schools_spanish_staff : String
        , events_01 : String
        , about_01 : String
        , testimonials_01 : String
        , testimonials_02 : String
        , testimonials_03 : String
        , testimonials_04 : String
        , gift_voucher_01 : String
        }
    }
