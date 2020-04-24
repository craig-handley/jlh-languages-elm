module Page.SchoolsPage exposing (Model, Msg(..), init, update, view)

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
        [ div [ class "row" ]
            [ div [ class "column" ]
                [ div [ class "content" ]
                    [ a [ class "select", href "/schools-french" ]
                        [ text "French Restaurant Experience"
                        , img [ src model.session.images.schools_french ] []
                        ]
                    ]
                ]
            , div [ class "column" ]
                [ div [ class "content" ]
                    [ a [ class "select", href "/schools-spanish" ]
                        [ text "Spanish Restaurant Experience"
                        , img [ src model.session.images.schools_spanish ] []
                        ]
                    ]
                ]
            ]
        ]
    }



-- HELPERS


toTitle : String
toTitle =
    "Schools Page"
