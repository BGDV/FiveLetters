//
//  ContentView.swift
//  FiveLetters
//
//  Created by BGDV on 23.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var allWordsFiveCount = Set<String>()
    
    @State var firstChar = ""
    @State var secondChar = ""
    @State var thirdChar = ""
    @State var fourthChar = ""
    @State var fifthChar = ""
    
    @State var firstCharNo = ""
    @State var secondCharNo = ""
    @State var thirdCharNo = ""
    @State var fourthCharNo = ""
    @State var fifthCharNo = ""
    
    @State var charIn = ""
    @State var charOut = ""
    

    
    func getOnlyFive() {
        var allWords = Set<String>()
        
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            
            if let fileContents = try? String(contentsOf: fileURL, encoding: String.Encoding.utf8 ) {
                
                let text = fileContents.split(separator: "'")
                
                for item in text {
                    if !item.contains(",") {
                        allWords.insert(String(item))
                    }
                }
                
                for item in allWords {
                    if item.count == 5 {
                        allWordsFiveCount.insert(item)
                    }
                }
                
            }
        }
    }
    
    func generate() {
        
        var newSetWords = allWordsFiveCount
        var charAvailable = [Substring]()
        var charNotAvailable = [Substring]()
        var charStringIn = Set<String>()
        var charStringOut = Set<String>()
        
        if !charIn.isEmpty {
            charAvailable = self.charIn.lowercased().split(separator: " ")
            
            for i in charAvailable {
                charStringIn.insert(String(i))
                
            }
            
            for item in allWordsFiveCount {
                for i in charStringIn {
                    if item.contains(i) {
                        newSetWords.insert(item)
                    } else {
                        if newSetWords.contains(item) {
                            newSetWords.remove(item)
                        }
                        break
                    }
                }
            }
        }
        
        if !charOut.isEmpty {
            charNotAvailable = self.charOut.lowercased().split(separator: " ")
            
            for i in charNotAvailable {
                charStringOut.insert(String(i))
                
            }
            
            for item in allWordsFiveCount {
                for i in charStringOut {
                    if item.contains(i) {
                        if newSetWords.contains(item) {
                            newSetWords.remove(item)
                        }
                    }
                }
            }
        }
  
        
        func filterIN(letter: String, offsets: Int) {
            if !letter.lowercased().isEmpty {
                for item in newSetWords {
                    if item[item.index(item.startIndex, offsetBy: offsets)] != letter.lowercased()[letter.lowercased().startIndex] {
                        newSetWords.remove(item)
                    }
                }
            }
        }
        
        func filterOUT(letter: String, offsets: Int) {
            if !letter.lowercased().isEmpty {
                for item in newSetWords {
                    if item[item.index(item.startIndex, offsetBy: offsets)] == letter.lowercased()[letter.lowercased().startIndex] {
                        newSetWords.remove(item)
                    }
                }
            }
        }
        
        let arrayIn = [firstChar, secondChar, thirdChar, fourthChar, fifthChar]
        let arrayOut = [firstCharNo, secondCharNo, thirdCharNo, fourthCharNo, fifthCharNo]
        
        var count = 0
        for i in arrayIn {
            filterIN(letter: i, offsets: count)
            count += 1
        }



        count = 0
        for i in arrayOut {
            filterOUT(letter: i, offsets: count)
            count += 1
        }

 

        self.allWordsFiveCount = newSetWords
     
    }
    
    var body: some View {
                Form {
                    ScrollView {
                        
                        if !allWordsFiveCount.isEmpty {
                            Text(allWordsFiveCount.description)
                        }
                    }
                    .frame(height: 200)
                    
                    Section(header: Text("letter is this place IN")) {
                        HStack {
                            TextField("", text: $firstChar)
                                .border(.indigo)
                            TextField("", text: $secondChar)
                                .border(.indigo)
                            TextField("", text: $thirdChar)
                                .border(.indigo)
                            TextField("", text: $fourthChar)
                                .border(.indigo)
                            TextField("", text: $fifthChar)
                                .border(.indigo)
                            
                        }
                    }
                    
                    Section(header: Text("letter is this plase OUT")) {
                        HStack {
                            TextField("", text: $firstCharNo)
                                .border(.gray)
                            TextField("", text: $secondCharNo)
                                .border(.gray)
                            TextField("", text: $thirdCharNo)
                                .border(.gray)
                            TextField("", text: $fourthCharNo)
                                .border(.gray)
                            TextField("", text: $fifthCharNo)
                                .border(.gray)
                        }
                    }
                    Section(header: Text("letter is IN")) {
                        TextField("", text: $charIn)
                            .border(.indigo)
                            
                    }
                    
                    Section(header: Text("letter is OUT")) {
                        TextField("", text: $charOut)
                            .border(.gray)
                    }
                    
                    Section {
                        Button {
                            generate()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Go!")
//                                    .bold()
                                    .font(.system(size: 20))
                                Spacer()
                            }
                        }
                        .onSubmit {
                            generate()
                        }
                    }
                   
                    
                    Section {
                        Text("Total words: \(allWordsFiveCount.count)")
                    }
                    
                    Section {
                        HStack {
                            Spacer()
                            Button {
                                getOnlyFive()
                            } label: {
                                Text("Load words with 5 letters")
                            }
                        }
                    }
                }
            }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
