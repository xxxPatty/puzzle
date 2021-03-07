//
//  optionButton.swift
//  puzzle
//
//  Created by 林湘羚 on 2021/3/6.
//

import SwiftUI


struct optionButton: View {
    @State private var No:Int   //1~4 代表 A~D
    @Binding var questionNumber:Int
    @Binding var showRule:Bool
    @Binding var scores:Int
    @Binding var choosenDisneyMovie:[questionDisneyMovie]
    @Binding var choosenACG:[questionACG]
    @Binding var choosenWord:[questionWord]
    @Binding var options:[String]
    @Binding var showResult:Bool
    @Binding var result:Bool
    @Binding var wordAns:String
    @Binding var DisneyMovie:[questionDisneyMovie]
    @Binding var ACG:[questionACG]
    @Binding var Word:[questionWord]
    @Binding var DisneyMovieOptions:[String]
    @Binding var ACGOptions:[String]
    
    var body: some View {
        let letter=String(UnicodeScalar(UInt8(64+No)))
        Button(letter + ". \(options[No])"){
            if options[No]==choosenDisneyMovie[questionNumber-1].answer {
                scores+=1
                result=true
            }else {
                result=false
            }
            showResult=true
            //亂數產生選項
            if questionNumber<4 {
                options=DisneyMovieOptions
                if let index=options.firstIndex(of: choosenDisneyMovie[questionNumber].answer){
                    options.remove(at: index)
                }
                options.shuffle()
                options=Array(options[0..<3])
                options.append(choosenDisneyMovie[questionNumber].answer)
                options.shuffle()
            }
        }
        .alert(isPresented: $showResult, content: {
            Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
                Text("Got it!"), action: { questionNumber+=1 }
            ))
        })
    }
}
