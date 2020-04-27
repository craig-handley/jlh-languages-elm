module Page.TestimonialsPage exposing (Model, Msg(..), init, update, view)

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
            [ div [ class "heading" ] [ text "Testimonials" ]
            , div [] [ text "\"It’s lively and I like the way we learn in complete sentences. The variety keeps your attention. It was fun. You learn quickly and the time passes very quickly.\"" ]
            , div [] [ text "- Sarah, Aldridge" ]
            , img [ src model.session.images.testimonials_01 ] []
            , div [] [ text "\"Jane is very approachable and goes out of her way to make our sessions lively\u{00A0}and enjoyable.\"" ]
            , div [] [ text "- Dorothy, Brownhills" ]
            , img [ src model.session.images.testimonials_02 ] []
            , div [] [ text "\"I have wanted to learn French for years but never managed to find the right class. Jane's method of teaching is one of mixing the learning with fun and empathy. I really look forward to our lessons.\"" ]
            , div [] [ text "- George, Cannock" ]
            , br [] []
            , div [] [ text "\"Never any good with foreign languages at school or since but have found a new desire to learn French and Jane's lessons are encouraging me to be confident in giving it a go!\"" ]
            , div [] [ text "- Linzi, Cannock" ]
            , br [] []
            , div [] [ text "\"I do love the variety of activities on offer.\"" ]
            , div [] [ text "- Brendan, Great Wyrley" ]
            , br [] []
            , div [] [ text "\"It is relaxed and at times there are funny moments when we got it wrong. All participants gelled and helped each other.\"" ]
            , div [] [ text "- Christine, Great Wyrley" ]
            , img [ src model.session.images.testimonials_03 ] []
            , div [] [ text "\"What I like about the lessons is that we are given information about how to learn and we are encouraged to look at things outside the lesson (a website or a radio programme) if they are of interest to us.\"" ]
            , div [] [ text "- Neil, Chelsyn Hay" ]
            , img [ src model.session.images.testimonials_04 ] []
            ]
        ]
    }



-- HELPERS


toTitle : String
toTitle =
    "Testimonials Page"
