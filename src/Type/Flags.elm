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
        , gallery_01 : String
        , gallery_02 : String
        , gallery_03 : String
        , gallery_04 : String
        , gallery_05 : String
        , gallery_06 : String
        , gallery_07 : String
        , gallery_08 : String
        , gallery_09 : String
        , gallery_10 : String
        , gallery_11 : String
        , gallery_12 : String
        , gallery_13 : String
        , gallery_14 : String
        , gallery_15 : String
        , gallery_16 : String
        , gallery_17 : String
        , gallery_18 : String
        , gallery_19 : String
        , gallery_20 : String
        , gallery_21 : String
        , gallery_22 : String
        , gallery_23 : String
        , gallery_24 : String
        , gallery_25 : String
        , gallery_26 : String
        , gallery_27 : String
        , gallery_28 : String
        , gallery_29 : String
        , gallery_30 : String
        }
    }
