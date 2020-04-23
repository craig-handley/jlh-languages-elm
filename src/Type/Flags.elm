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
        }
    }
