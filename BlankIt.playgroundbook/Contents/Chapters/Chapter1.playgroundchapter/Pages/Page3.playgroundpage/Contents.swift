/*:
 ## A **Blank It** needs to have blanks!
 Next, we use the array from the last page, and we decide which words will be the "blanks". We don't want any of the whitespaces or punctuation to be replaced, so we will only replace words that have been tagged as any of the following: nouns, adjectives, adverbs, personal names, organisation names, and place names.
 
 > Here are some definitions in case you don't happen to be an English scholar: Noun = thing (dog, cake, bathtub) Plural noun = more than one thing (dogs, cakes, bathtubs) Adjective = describing word (fluffy, green, evil) Adverb = describing word that applies to actions (quickly, violently, unknowingly). Hope that helps!
 
 Since there won't be too many adverbs or names, we won't worry about limiting the number of times those are replaced. But nouns and adjectives are very common. If we replace every noun, our paragraph will probably become **too** nonsensical! Turns out, in a standard Mad Libs®, about every third noun/adjective is replaced.
 
 The function
 
 `processor.pickBlanks(adjectiveRatio: Int, nounRatio: Int)`
 
 will go through the array of words and mark a certain ratio of words as blanks. It will return an array of these blanks. Your job this time is to decide how many nouns and adjectives will be blanked.
 
 Supply a number for each parameter specifying what ratio of blanks to non-blanks you want. (`nounRatio = 2` means that every second noun will be replaced).
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
var words = processor.identifyPartsOfSpeech(text: text)
//#-end-hidden-code
let adjectiveRatio = /*#-editable-code*/3/*#-end-editable-code*/
let nounRatio = /*#-editable-code*/3/*#-end-editable-code*/

words = processor.pickBlanks(adjectiveRatio: adjectiveRatio, nounRatio: nounRatio)
//#-hidden-code
show("Here is the Blank It made from your paragraph: ")
let replacement = "❓"
var output = [String]()
for word in words {
    if word is Blank {
        output.append(replacement)
    } else {
        output.append(word.value)
    }
}
show(output.joined())

page.keyValueStore["adjectiveRatio"] = .integer(adjectiveRatio)
page.keyValueStore["nounRatio"] = .integer(nounRatio)

PlaygroundPage.current.assessmentStatus = .pass(message: "### Great! \nFeel free to modify the ratio settings and rerun your code until you like the selection of blanks. \n\n[**Next Page**](@next)")
//#-end-hidden-code
