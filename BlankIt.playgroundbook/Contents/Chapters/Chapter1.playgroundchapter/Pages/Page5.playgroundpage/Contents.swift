/*:
 ## Almost there... 
 We have nearly finished! The last step is to show the completed **Blank It** to the user.
 
 The function
 
 `processor.createNewParagraph(newWords: [String])`
 
 will do some [final]() formatting and give you a paragraph with all the blanks replaced. Some of these paragraphs can be pretty hilarious!
 
 Call the function
 
 `processor.createNewParagraph(newWords: [String])`
 
 below, replacing the word `[String]` with the word `newWords`, to get your new paragraph!
 */
//#-hidden-code
import PlaygroundSupport
import Foundation

let processor = TextProcessor()
let page = PlaygroundPage.current
var text = ""
if let keyValue = page.keyValueStore["text"],
    case .string(let paragraph) = keyValue {
    text = paragraph
}
let words = processor.identifyPartsOfSpeech(text: text)

var adjectiveRatio = 0
if let keyValue = page.keyValueStore["adjectiveRatio"],
    case .integer(let adj) = keyValue {
    adjectiveRatio = adj
}
var nounRatio = 0
if let keyValue = page.keyValueStore["nounRatio"],
    case .integer(let noun) = keyValue {
    nounRatio = noun
}
let blanks = processor.pickBlanks(adjectiveRatio: adjectiveRatio, nounRatio: nounRatio)

var wrappedStrings = [PlaygroundValue]()
if let keyValue = page.keyValueStore["newWords"],
    case .array(let newW) = keyValue {
    wrappedStrings = newW
}
var newWords = [String]()
for word in wrappedStrings {
    if case .string(let value) = word {
    newWords.append(value)
    }
}
//#-end-hidden-code
let newText = /*#-editable-code*//*#-end-editable-code*/
show("Here is your new-and-improved paragraph!")
show(newText)
//#-hidden-code
PlaygroundPage.current.assessmentStatus = .pass(message: "### You did it! 🎉 \nDid you like your result? Try going back to the first page and repeating with a new paragraph! \n\n[**Back to First Page**](@first)")
// does @first work?
//#-end-hidden-code
