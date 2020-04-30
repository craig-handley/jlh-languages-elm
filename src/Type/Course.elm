module Type.Course exposing (Course, coursesDecoder)

import Json.Decode as Decode exposing (at, list, string)
import Json.Decode.Pipeline exposing (required)


type alias Course =
    { day : String
    , time : String
    , location : String
    , abilityLevel : String
    }


coursesDecoder : Decode.Decoder (List Course)
coursesDecoder =
    at [ "courses" ] (list courseDecoder)


courseDecoder : Decode.Decoder Course
courseDecoder =
    Decode.succeed Course
        |> required "day" string
        |> required "time" string
        |> required "location" string
        |> required "abilityLevel" string
