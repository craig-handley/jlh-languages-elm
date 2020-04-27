module Session exposing (Session, init)

import Json.Decode
import Time
import Type.Flags
import Type.LocalStorage



{-
   The session is used for any data that needs to be shared globally across all pages. All pages have the session in their model.
   You can use this to store info like credentials.
   Currently, I am storing localStorage in session, however it may be better to decode what you need from localStorage and store only that value.
-}


type alias Session =
    { timeAppStarted : Time.Posix
    , windowSize : { width : Int, height : Int }
    , localStorage : Maybe Type.LocalStorage.LocalStorage
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



-- Initializes a session given some flags


init : Type.Flags.Flags -> Session
init flags =
    let
        localStorage =
            Json.Decode.decodeValue Type.LocalStorage.decode flags.localStorage

        posixTime =
            Time.millisToPosix flags.timeAppStarted
    in
    case localStorage of
        Ok storage ->
            Session posixTime flags.windowSize storage flags.images

        Err _ ->
            Session posixTime flags.windowSize Nothing flags.images



-- Getters/Setters can go here
