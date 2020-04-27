module Page.AboutPage exposing (Model, Msg(..), init, update, view)

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
            [ div [ class "heading" ] [ text "About" ]
            , img [ class "small", src model.session.images.about_01 ] []
            , div [] [ text "My name is Jane Handley and I am passionate about languages." ]
            , div [] [ text "I have 20 years' experience of teaching French and German in secondary schools and primary schools as well as teaching adults in commercial settings." ]
            , div [] [ text "I have spent extended periods living and working abroad. I have worked in Tübingen (Germany), Paris, Strasbourg, Monaco, Singapore and Nigeria." ]
            , div [ class "underline" ] [ text "My qualifications:" ]
            , list1
            , div [] [ text "Contact me" ]
            , div [] [ text "Tel: 07793 556020" ]
            , div [] [ text "Email: jane@jlhlanguages.org" ]
            ]
        ]
    }


list1 : Html msg
list1 =
    ul []
        [ li [] [ text "Valid DBS" ]
        , li [] [ text "Certificate of English Language Teaching to Adults (CELTA), International Teaching and Training Centre, Bournemouth, 2001" ]
        , li [] [ text "Post Graduate Certificate of Education (PGCE), University of Sheffield, 1997" ]
        , li [] [ text "BA Honours Degree in Modern Languages (French/German) and European Studies, University of Bath, Result obtained 2.i., 1995" ]
        ]



-- HELPERS


toTitle : String
toTitle =
    "About Page"
