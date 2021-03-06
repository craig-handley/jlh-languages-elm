module Page.TutoringPage exposing (Model, Msg(..), init, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Session
import Viewer



-- MODEL


type alias Model =
    { session : Session.Session
    }



-- INIT


init : Session.Session -> ( Model, Cmd Msg )
init session =
    ( Model session, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Viewer.Details Msg
view model =
    { title = toTitle
    , body =
        [ div [ class "content" ]
            [ div [ class "heading" ] [ text "Tutoring" ]
            , div [] [ text "Individual tuition from £30 per hour" ]
            , div [] [ text "Group tuition price on request" ]
            , img [ src model.session.images.tutoring_01 ] []
            , img [ src model.session.images.tutoring_02 ] []
            ]
        ]
    }



-- HELPERS


toTitle : String
toTitle =
    "Tutoring Page"
