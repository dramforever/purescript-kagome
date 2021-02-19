module Kagome.DOM.Class where

import Prelude

import Data.Maybe (Maybe(..))
import Web.DOM.CharacterData as CharacterData
import Web.DOM.Document as Document
import Web.DOM.Element as Element
import Web.DOM.Node as Node
import Web.DOM.Text as Text
import Web.Event.EventTarget as EventTarget
import Web.HTML.HTMLButtonElement as HTMLButtonElement
import Web.HTML.HTMLDocument as HTMLDocument
import Web.HTML.HTMLElement as HTMLElement
import Web.HTML.HTMLInputElement as HTMLInputElement

class Is base sub where
    toBase :: sub -> base
    fromBase :: base -> Maybe sub

-- Generated code below --

instance instanceIsDocument :: Is Document.Document Document.Document where
    toBase = identity
    fromBase = Just
else instance instanceIsDocumentNode :: Is base Node.Node => Is base Document.Document where
    toBase = toBase <<< Document.toNode
    fromBase = Document.fromNode <=< fromBase

instance instanceIsNode :: Is Node.Node Node.Node where
    toBase = identity
    fromBase = Just
else instance instanceIsNodeEventTarget :: Is base EventTarget.EventTarget => Is base Node.Node where
    toBase = toBase <<< Node.toEventTarget
    fromBase = Node.fromEventTarget <=< fromBase

instance instanceIsHTMLElement :: Is HTMLElement.HTMLElement HTMLElement.HTMLElement where
    toBase = identity
    fromBase = Just
else instance instanceIsHTMLElementElement :: Is base Element.Element => Is base HTMLElement.HTMLElement where
    toBase = toBase <<< HTMLElement.toElement
    fromBase = HTMLElement.fromElement <=< fromBase

instance instanceIsElement :: Is Element.Element Element.Element where
    toBase = identity
    fromBase = Just
else instance instanceIsElementNode :: Is base Node.Node => Is base Element.Element where
    toBase = toBase <<< Element.toNode
    fromBase = Element.fromNode <=< fromBase

instance instanceIsText :: Is Text.Text Text.Text where
    toBase = identity
    fromBase = Just
else instance instanceIsTextCharacterData :: Is base CharacterData.CharacterData => Is base Text.Text where
    toBase = toBase <<< Text.toCharacterData
    fromBase = Text.fromCharacterData <=< fromBase

instance instanceIsCharacterData :: Is CharacterData.CharacterData CharacterData.CharacterData where
    toBase = identity
    fromBase = Just
else instance instanceIsCharacterDataNode :: Is base Node.Node => Is base CharacterData.CharacterData where
    toBase = toBase <<< CharacterData.toNode
    fromBase = CharacterData.fromNode <=< fromBase

instance instanceIsHTMLDocument :: Is HTMLDocument.HTMLDocument HTMLDocument.HTMLDocument where
    toBase = identity
    fromBase = Just
else instance instanceIsHTMLDocumentDocument :: Is base Document.Document => Is base HTMLDocument.HTMLDocument where
    toBase = toBase <<< HTMLDocument.toDocument
    fromBase = HTMLDocument.fromDocument <=< fromBase

instance instanceIsHTMLButtonElement :: Is HTMLButtonElement.HTMLButtonElement HTMLButtonElement.HTMLButtonElement where
    toBase = identity
    fromBase = Just
else instance instanceIsHTMLButtonElementHTMLElement :: Is base HTMLElement.HTMLElement => Is base HTMLButtonElement.HTMLButtonElement where
    toBase = toBase <<< HTMLButtonElement.toHTMLElement
    fromBase = HTMLButtonElement.fromHTMLElement <=< fromBase

instance instanceIsHTMLInputElement :: Is HTMLInputElement.HTMLInputElement HTMLInputElement.HTMLInputElement where
    toBase = identity
    fromBase = Just
else instance instanceIsHTMLInputElementHTMLElement :: Is base HTMLElement.HTMLElement => Is base HTMLInputElement.HTMLInputElement where
    toBase = toBase <<< HTMLInputElement.toHTMLElement
    fromBase = HTMLInputElement.fromHTMLElement <=< fromBase

instance instanceIsEventTarget :: Is EventTarget.EventTarget EventTarget.EventTarget where
    toBase = identity
    fromBase = Just

toNode :: forall sub. Is Node.Node sub => sub -> Node.Node
toNode = toBase

fromNode :: forall sub. Is Node.Node sub => Node.Node -> Maybe sub
fromNode = fromBase

toEventTarget :: forall sub. Is EventTarget.EventTarget sub => sub -> EventTarget.EventTarget
toEventTarget = toBase

fromEventTarget :: forall sub. Is EventTarget.EventTarget sub => EventTarget.EventTarget -> Maybe sub
fromEventTarget = fromBase

toElement :: forall sub. Is Element.Element sub => sub -> Element.Element
toElement = toBase

fromElement :: forall sub. Is Element.Element sub => Element.Element -> Maybe sub
fromElement = fromBase

toCharacterData :: forall sub. Is CharacterData.CharacterData sub => sub -> CharacterData.CharacterData
toCharacterData = toBase

fromCharacterData :: forall sub. Is CharacterData.CharacterData sub => CharacterData.CharacterData -> Maybe sub
fromCharacterData = fromBase

toDocument :: forall sub. Is Document.Document sub => sub -> Document.Document
toDocument = toBase

fromDocument :: forall sub. Is Document.Document sub => Document.Document -> Maybe sub
fromDocument = fromBase

toHTMLElement :: forall sub. Is HTMLElement.HTMLElement sub => sub -> HTMLElement.HTMLElement
toHTMLElement = toBase

fromHTMLElement :: forall sub. Is HTMLElement.HTMLElement sub => HTMLElement.HTMLElement -> Maybe sub
fromHTMLElement = fromBase
