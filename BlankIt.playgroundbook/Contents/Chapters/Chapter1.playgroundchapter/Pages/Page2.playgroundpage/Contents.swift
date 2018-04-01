/*:
 ## But what do we do with the paragraph?
 Now comes the technical part. The first step in creating the **Blank It** is to identify all the parts of speech in the user's paragraph.
 
 There is a function called
 
 `processor.identifyPartsOfSpeech(text: String)`
 
 that will take in the user's paragraph and return an array with all the words and their types.
 
 The processor uses NSLinguisticTagger, a remarkable natural language processor produced and used by Apple.

 In the space below, call the function
 
 `processor.identifyPartsOfSpeech(text: String)`
 
 replacing the word `String` with the word `text`
*/
//#-hidden-code

import PlaygroundSupport
import Foundation

let page = PlaygroundPage.current
var text = ""
if let keyValue = page.keyValueStore["text"],
    case .string(let paragraph) = keyValue {
    text = paragraph
}

let processor = TextProcessor()

//#-end-hidden-code
let words = /*#-editable-code*//*#-end-editable-code*/
/*:
 This next little bit of code will print out each word, along with its part of speech.
 */
for word in words {
    show("\"\(word.value)\" ➡️ \(word.type.rawValue)")
}
//#-hidden-code
PlaygroundPage.current.assessmentStatus = .pass(message: "### Nice work! \nNSLinguisticTagger is pretty great, right? \n\n[**Next Page**](@next)")
//#-end-hidden-code
