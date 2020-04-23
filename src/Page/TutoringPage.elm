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
            [ h1 [] [ text "Tutoring" ]
            , div [] [ text "Individual tuition from £30 per hour" ]
            , div [] [ text "Group tuition price on request" ]
            , div []
                [ img [ src model.session.images.tutoring_01 ] []
                ]
            , div []
                [ img [ src model.session.images.tutoring_02 ] []
                ]
            ]
        ]
    }



{--
    <p>
      Individual tuition from £30 per hour
      <br />
      <br />
      Group tuition price on request
    </p>
    <br />
    <img alt="Tutoring1" src="/images/tutoring1.png" width="60%" padding="25px" class="center" />
    <br />
    <img alt="Tutoring2" src="/images/tutoring2.png" width="60%" padding="25px" class="center" />
    <br />
--}
-- HELPERS


toTitle : String
toTitle =
    "Tutoring Page"
