/*:
 ## Great. Now we have a bunch of holes in the paragraph.
 Don't worry, we're doing great! Now that we've completed that behind-the-scenes stuff, we are going back to the user to get replacement words for the blanks.
 
 This time, you can take a look at the code we are using, but your [real]() job is to supply the replacements! (Better yet, quiz the people around you for even more random replacements!)
 
 > And just in case you didn't memorize these terms on the last page, here's a repeat! Noun = thing (dog, cake, bathtub) Plural noun = more than one thing (dogs, cakes, bathtubs) Adjective = describing word (fluffy, green, evil) Adverb = describing word that applies to actions (quickly, violently, unknowingly).
 */
//#-hidden-code
import PlaygroundSupport
import Foundation

let processor = TextProcessor()
var text = ""
if let keyValue = PlaygroundKeyValueStore.current["text"],
    case .string(let paragraph) = keyValue {
    text = paragraph
}
let words = processor.identifyPartsOfSpeech(text: text)

var adjectiveRatio = 0
if let keyValue = PlaygroundKeyValueStore.current["adjectiveRatio"],
    case .integer(let adj) = keyValue {
    adjectiveRatio = adj
}
var nounRatio = 0
if let keyValue = PlaygroundKeyValueStore.current["nounRatio"],
    case .integer(let noun) = keyValue {
    nounRatio = noun
}
let blanks = processor.pickBlanksReturnOnlyBlanks(adjectiveRatio: adjectiveRatio, nounRatio: nounRatio)
//#-end-hidden-code
//#-editable-code
var newWords = [String]()
/*:
 We just created the array to fill with replacement code. The code below decides what we should ask the user.
*/
for word in blanks {
    var prompt = ""
    switch word.type { // This part decides what we should ask the user
    case .noun:
        if word.value.last == "s" {
            prompt = "Type in a plural noun"
        } else {
            prompt = "Type in a noun"
        }
    case .adjective:
        prompt = "Type in an adjective"
    case .adverb:
        prompt = "Type in an adverb"
    case .personalName:
        prompt = "Type in a name"
    case .placeName:
        prompt = "Type in a place"
    default:
        prompt = "Type in a company name"
    }
    let newWord = ask(prompt)
    newWords.append(newWord)
}
//#-end-editable-code
//#-hidden-code
var wrappedStrings = [PlaygroundValue]()
for word in newWords {
    wrappedStrings.append(PlaygroundValue.string(word))
}
PlaygroundKeyValueStore.current["newWords"] = .array(wrappedStrings)
PlaygroundPage.current.assessmentStatus = .pass(message: "### Way to go! \nOnly one step left! \n\n[**Next Page**](@next)")
//#-end-hidden-code

