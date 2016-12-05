//
//  main.swift
//  ReadWriteFile_DoOperationsWithComments
//
//  Created by Aleksandr Zholnerovskij on 11/24/16.
//  Copyright © 2016 Aleksandr Zholnerovskij. All rights reserved.
//

import Foundation


//-----------functions--------

func commentAllLines(text : String) -> String {
    
    var commentedText = text.replacingOccurrences(of: "\n", with: "\n//")
    
    if !commentedText.hasPrefix("//") {
        commentedText = "//" + commentedText
    }
    return commentedText
}

func collectFullComments (text : String) -> String {
    var fullComments = ""
    
    for subsubfull in text.components(separatedBy: "/*") {
        
        if subsubfull.range(of: "*/") != nil {
            fullComments = fullComments + subsubfull.components(separatedBy: "*/").first! + "\n"
        }
    }
    return fullComments
}

func collectLineComments (text : String) -> String {
    
    var lineComments = ""
    
    for substring in text.components(separatedBy: "\n") {
        
        let subsubstrings = substring.components(separatedBy: "//")
        
        for index in 0...subsubstrings.count-1 {
            
            if !subsubstrings[index].isEmpty && index != 0 {
                
                lineComments = lineComments + subsubstrings[index] + "\n"
                
            }
        }
    }
    
    
    return lineComments
}

func removeAllComments (text : String) -> String {
    //remove FullComments
    var textWhithotFullCommens = ""
    
    if let firstPart = text.components(separatedBy: "/*").first {
        if !firstPart.hasPrefix("/*") {
            textWhithotFullCommens = textWhithotFullCommens + firstPart
        }
    }
    
    for substring in text.components(separatedBy: "/*") {
        if substring.range(of: "*/") != nil {
            textWhithotFullCommens = textWhithotFullCommens + substring.components(separatedBy: "*/").last! + "\n"
        }
        
        print ("4a-withoutfull: \n", textWhithotFullCommens,"-----------------")
        
    }
    //remove LineComments
    var textWhithotAllCommens = ""
    
    for substring in textWhithotFullCommens.components(separatedBy: "\n") {
        
        if substring.hasPrefix("//") {continue}
        
        if !substring.components(separatedBy: "//").isEmpty {
            textWhithotAllCommens = textWhithotAllCommens + substring.components(separatedBy: "//").first! + "\n"
        }
      
    }
    return textWhithotAllCommens
    
}

func commentLinesExceptExisted (text : String) -> String {
    var commentedText = ""
    
    for substring in text.components(separatedBy: "\n") {
        
        if !substring.hasPrefix("//") {
            commentedText = commentedText + "//"
        }
        commentedText = commentedText + substring + "\n"
        
    }
    
    return commentedText
}

print("DON'T FORGET STRINGS")


let fileInput = "fe_files.swift" //this is the file. we will write to and read from it
let fileCommented = "fileCommented.swift" //will be file comented
let fileLineComments = "fileLineComments.swift" //will be file with line comments
let fileFullComments = "fileFullComments.swift" //will be file with full comments
let fileWithoutComments = "fileWithoutComments.swift" //will be file without comments
let fileLineCommentedExpectExisted = "fileLineCommentedExpectExisted.swift" //will be file with all line commented expect existed

var textFromFile = "some text" //just a text

if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
   
    
    
    func writeToFile(fileName : String, text: String) {
        //writing
        
        do {
            try text.write(to: dir.appendingPathComponent(fileName), atomically: false, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}

    }
    
    var path = dir.appendingPathComponent(fileInput)
    
    //reading
    do {
        textFromFile = try String(contentsOf: path, encoding: String.Encoding.utf8)
    }
    catch {/* error handling here!!! */}
    
    
    //1 Commit all lines
    print ("------1-----")
    print (commentAllLines(text: textFromFile))
    
    writeToFile(fileName: fileCommented, text: commentAllLines(text: textFromFile))
    
    //2 Collect full comments
    
    print ("------2-----")
    print (collectFullComments(text: textFromFile))
    
    writeToFile(fileName: fileFullComments, text: collectFullComments(text: textFromFile))
    
    //3 Collect single comments
    
    print ("----3-----")
    print(collectLineComments(text: textFromFile))
    
    writeToFile(fileName: fileLineComments, text: collectLineComments(text: textFromFile))
    
    // 4 Remove all coments
    
    print ("----4-----")
    print(removeAllComments(text: textFromFile))
    
    writeToFile(fileName: fileWithoutComments, text: removeAllComments(text: textFromFile))
    
    //5 Comment all lines expect existed
    
    print("------5-------")
    print(commentLinesExceptExisted(text: textFromFile))
    
    writeToFile(fileName: fileLineCommentedExpectExisted, text: commentLinesExceptExisted(text: textFromFile))

}


