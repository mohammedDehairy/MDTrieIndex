//
//  MDTrieIndex.swift
//  MDTrieIndex
//
//  Created by mohamed mohamed El Dehairy on 12/21/16.
//  Copyright © 2016 mohamed El Dehairy. All rights reserved.
//

import UIKit

class MDTrieIndex: NSObject {
    private var trie : [Character:MDTrieIndex] = [:]
    
    public init(trainList : [String]) {
        super.init()
        self.train(trainList: trainList)
    }
    
    public override init() {
        super.init()
    }
    
    /**
        Train the trie with a list of strings (index them), after clearing all strings in the trei.
        - parameter trainList : Array ot strings to be indexed.
     */
    public func retrain(trainList : [String]){
        trie = [:]
        train(trainList: trainList)
    }
    
    /**
        Train the trie with a list of strings (index them), multiple calls to train() with the same list will consum processing power but the trie will end up being the same, multiple calls to train() with different lists of strings will result in the new strings being indexed and added to the trie and old strings will be preserved.
        - parameter trainList : Array ot strings to be indexed.
    */
    public func train(trainList : [String]){
        if trainList.count == 0{
            return
        }
        
        // filter out empty strings
        var sortedTrainList = [String]()
        for str in trainList{
            if str != "" {
                sortedTrainList.append(str)
            }
        }
        // sort the training list
        sortedTrainList = sortedTrainList.sorted()
        
        var tempList = [String]()
        var tempChar : Character = sortedTrainList[0].characters[sortedTrainList[0].startIndex]
        for str in sortedTrainList{
            let currentChar = str.characters[str.startIndex]
            if currentChar != tempChar{
                if let subTrie = self.trie[tempChar] {
                    subTrie.train(trainList: tempList)
                }else {
                    self.trie[tempChar] = MDTrieIndex(trainList: tempList)
                }
                tempList = []
                tempChar = currentChar
            }
            
            let str = str.substring(from: str.index(after: str.startIndex))
            if str != "" {
                tempList.append(str)
            }
        }
        
        if let subTrie = self.trie[tempChar] {
            subTrie.train(trainList: tempList)
        }else {
            self.trie[tempChar] = MDTrieIndex(trainList: tempList)
        }
    }
    
    /**
        Finds all strings that starts with the specified prefix
     
        - parameter prefix : The prefix to find all strings that starts with it, pass an empty string or nil to get all possible strings in the trie.
        - returns : A string array containing all possible strings that starts with the specified prefix, or all possible strings indexed in the trie, in case the passed prefix is nil or empty string
     */
    public func findAllStrings(withPrefix prefix : String?)->[String]{
        
        var result = [String]()
        
        if let prefixStr = prefix, prefixStr != "" {
            
            let firstCharacter = prefixStr.characters[prefixStr.startIndex]
            
            let subTrie = trie[firstCharacter]
            
            let strings = subTrie?.findAllStrings(withPrefix: String(prefixStr.characters.dropFirst()))
            
            
            if let subStrings = strings{
                for str in subStrings{
                    result.append("\(firstCharacter)\(str)")
                }
            }
            
            return result
        }else{
            for (char,subTrie) in trie{
                let substrings = subTrie.findAllStrings(withPrefix: nil)
                
                if substrings.count > 0{
                    for str in substrings{
                        result.append("\(char)\(str)")
                    }
                }else{
                    result.append("\(char)")
                }
            }
        }
        
        return result
    }
    
    public func printTrie(indentation: Int)->String{
        var indentationStr = ""
        for _ in 0..<indentation{
            indentationStr+=" "
        }
        var str = indentationStr + "{\n"
        for (key,value) in trie{
            str += indentationStr + "\(key) : \n\(value.printTrie(indentation: indentation+1)) \n"
        }
        str += indentationStr + " }\n"
        return str
    }
}
