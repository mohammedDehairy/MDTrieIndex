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
