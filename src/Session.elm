module Session exposing (Session, init)

import Json.Decode
import Time
import Type.Course as Course
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
    , courses : Maybe (List Course.Course)
    }



-- Initializes a session given some flags


init : Type.Flags.Flags -> Session
init flags =
    let
        localStorage =
            Json.Decode.decodeValue Type.LocalStorage.decode flags.localStorage

        posixTime =
            Time.millisToPosix flags.timeAppStarted

        courseResult =
            Json.Decode.decodeString Course.coursesDecoder flags.courses
    in
    case localStorage of
        Ok storage ->
            case courseResult of
                Ok courses ->
                    Session posixTime flags.windowSize storage flags.images (Just courses)

                Err _ ->
                    Session posixTime flags.windowSize storage flags.images Nothing

        Err _ ->
            case courseResult of
                Ok courses ->
                    Session posixTime flags.windowSize Nothing flags.images (Just courses)

                Err _ ->
                    Session posixTime flags.windowSize Nothing flags.images Nothing



-- Getters/Setters can go here
