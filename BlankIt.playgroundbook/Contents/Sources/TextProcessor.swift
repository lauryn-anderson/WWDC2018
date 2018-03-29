//
//  TextProcessor.swift
//  BlankIt
//
//  Created by Lauryn Anderson on 2018-01-19.
//  Copyright © 2018 Lauryn Anderson. All rights reserved.
//

import Foundation

// set up necessary structures, etc.
public protocol Prompt: class {
    func askForReplacement(blanks: [Blank])
}

public protocol Receiver: class {
    func receiveReplacement(word: String)
    func resetView()
}

public protocol Wordy {
    var value: String { get set }
    var type: NSLinguisticTag { get }
}

public struct Word: Wordy {
    
    public var value: String
    public var type: NSLinguisticTag
    
    init(value: String, type: NSLinguisticTag){
        self.value = value
        self.type = type
    }
}

public struct Blank: Wordy {
    public var value: String
    public var type: NSLinguisticTag
    
    init(value: String, type: NSLinguisticTag) {
        self.value = value
        self.type = type
    }
}

public class TextProcessor: NSObject {
    
    weak var delegate: Prompt?
    var wordArray = [Wordy]()
    var wordCounter = 0
    var blankIndex = 0
    var blankArray = [Blank]()
    let maximumCharacters = 5000
    
    public func processOriginal(text: String) {
        identifyPartsOfSpeech(text: text)
        pickBlanks(adjectiveRatio: 3, nounRatio: 3)
        //send blankArray to user for replacement words
        delegate?.askForReplacement(blanks: blankArray)
    }
    
    public func pickBlanks(adjectiveRatio: Int, nounRatio: Int) -> [Wordy] {
        //identify "blanks" to be replaced
        var adjectiveIndex = 0
        var nounIndex = 0
        var otherIndex = 0
        var index = 0
        
        for word in wordArray {
            switch word.type {
            case .adjective:
                if adjectiveIndex % adjectiveRatio == 0 {
                    createBlank(value: word.value, type: word.type, index: index)
                }
                adjectiveIndex += 1
            case .noun:
                if nounIndex % nounRatio == 0 {
                    createBlank(value: word.value, type: word.type, index: index)
                }
                nounIndex += 1
            case .adverb:
                let suffix = word.value.suffix(2)
                if suffix == "ly"{
                    createBlank(value: word.value, type: word.type, index: index)
                }
            case .personalName:
                createBlank(value: word.value, type: word.type, index: index)
            case .placeName:
                createBlank(value: word.value, type: word.type, index: index)
            case .organizationName:
                createBlank(value: word.value, type: word.type, index: index)
            default:
                otherIndex += 1
            }
            index += 1
        }
        return wordArray 
    }
    
    public func pickBlanksReturnOnlyBlanks(adjectiveRatio: Int, nounRatio: Int) -> [Blank] {
        //identify "blanks" to be replaced
        var adjectiveIndex = 0
        var nounIndex = 0
        var otherIndex = 0
        var index = 0
        
        for word in wordArray {
            switch word.type {
            case .adjective:
                if adjectiveIndex % adjectiveRatio == 0 {
                    createBlank(value: word.value, type: word.type, index: index)
                }
                adjectiveIndex += 1
            case .noun:
                if nounIndex % nounRatio == 0 {
                    createBlank(value: word.value, type: word.type, index: index)
                }
                nounIndex += 1
            case .adverb:
                let suffix = word.value.suffix(2)
                if suffix == "ly"{
                    createBlank(value: word.value, type: word.type, index: index)
                }
            case .personalName:
                createBlank(value: word.value, type: word.type, index: index)
            case .placeName:
                createBlank(value: word.value, type: word.type, index: index)
            case .organizationName:
                createBlank(value: word.value, type: word.type, index: index)
            default:
                otherIndex += 1
            }
            index += 1
        }
        return blankArray
    }
    
    public func createBlank (value: String, type: NSLinguisticTag, index: Int) {
        let blank = Blank(value: value, type: type)
        wordArray[index] = blank
        blankArray.append(blank)
        blankIndex += 1
    }
    
    public func identifyPartsOfSpeech(text: String) -> [Wordy] {
        let tagger = NSLinguisticTagger(tagSchemes: [.nameTypeOrLexicalClass], options: 0)
        //identify parts of speech
        tagger.string = text
        let range = NSMakeRange(0, text.utf16.count)
        tagger.enumerateTags(in: range, scheme: .nameTypeOrLexicalClass, options: []) { (tag, tokenRange, _, _) in
            if let tag = tag {
                let word = Word(value: (text as NSString).substring(with: tokenRange), type: tag)
                if wordCounter < maximumCharacters {
                    wordArray.append(word)
                }
                wordCounter = wordCounter + 1
                //print("\(word.value) \(tag)")
            }
        }
        return wordArray
    }
    
    public func createNewParagraph(newWords: [String]) -> String {
        
        var mutableBlanks = newWords
        var output: [String] = []
        
        for word in wordArray {
            if word is Blank {
                let replacement = mutableBlanks.removeFirst()
                output.append(replacement)
            } else {
                output.append(word.value)
            }
        }
        return output.joined()
    }
    
    public func resetProcessor() {
        wordArray = []
        wordCounter = 0
        blankIndex = 0
        blankArray = []
    }
}
