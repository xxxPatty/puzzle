//
//  ContentView.swift
//  puzzle
//
//  Created by ๆๆน็พ on 2021/3/3.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var questionNumber:Int=0
    @State private var showRule:Bool=false
    @State private var scores:Int=0
    @State private var choosenDisneyMovie:[questionDisneyMovie]=[]
    @State private var choosenACG:[questionACG]=[]
    @State private var choosenWord:[questionWord]=[]
    @State private var options:[String]=["", "", "", ""]
    @State private var showResult:Bool=false
    @State private var result:Bool=false
    @State private var wordAns:String=""
    @State private var showHint:Bool=false
    let player=AVPlayer()
    @State private var volleyBallPosX:Int=200
    @State private var volleyBallPosY:Int=Int(UIScreen.main.bounds.size.height)-250
    @State private var degrees:Double=0
    @State private var DisneyMovie:[questionDisneyMovie]=[questionDisneyMovie(question:"๐๐งโโ๐ดโโ ๏ธโต๏ธ", answer:"ๅฝผๅพๆฝ-Peter Pan", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐งโโ๐ฆ๏ธ๐", answer:"ๅฐ็พไบบ้ญ-The Little Mermaid", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐งโโ๐", answer:"้ฟๆไธ-Aladdin", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐ธ๐๐ฏโ๏ธ๐ฐ", answer:"็พๅฅณ่้็ธ-Beauty and the Beast", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐ฆ๏ธ๐๐๐", answer:"็ๅญ็-Lion King", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐ก๐ง๐๐ฒ๐ฆ", answer:"่ฑๆจ่ญ-Mulan", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐ฆ๐ฆ๐ฒ", answer:"ๆณฐๅฑฑ-Tarzan", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐ฆ๐๐ฆ๐ณ", answer:"็ฎ่ซพไธ-Pinocchio", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐ ๐ธ๐งน๐๐ญ", answer:"ไปๅบฆ็ๆ-Cinderella", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"๐๐ฑ๐ง๐ฐโฑ", answer:"ๆ้บ็ตฒๅคข้ไปๅข-Alice in Wonderland", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"โ๏ธโ๏ธ๐ธ๐ธ", answer:"ๅฐ้ชๅฅ็ทฃ-Frozen", hint:"", type:"DisneyMovie")]
    let DisneyMovieOptions:[String]=["ๅฝผๅพๆฝ-Peter Pan", "ๅฐ็พไบบ้ญ-The Little Mermaid", "้ฟๆไธ-Aladdin", "็พๅฅณ่้็ธ-Beauty and the Beast", "็ๅญ็-Lion King", "่ฑๆจ่ญ-Mulan", "ๆณฐๅฑฑ-Tarzan", "็ฎ่ซพไธ-Pinocchio", "ไปๅบฆ็ๆ-Cinderella", "ๆ้บ็ตฒๅคข้ไปๅข-Alice in Wonderland", "ๅฐ้ชๅฅ็ทฃ-Frozen", "็ฝ้ชๅฌไธป--Snow White and the Seven Dwarfs", "ๅฏถๅๅบท่--Pocahontas", "้ๆจๆชไบบ--The Hunchback of Notre Dame", "ๅฐ้นฟๆๆฏ--Bambi"]
    @State private var ACG:[questionACG]=[questionACG(question:["ๆๆฏ่ฆๆ็บOOO็็ทไบบ!", "ๆณๅพๅฐๆ็่ฒกๅฏถๅ?ๆณ่ฆ็่ฉฑๅฏไปฅๅจ้จ็ตฆไฝ  ๅปๆพๅง ๆๆๆๆ็่ฒกๅฏถ้ฝๆพๅจ้ฃ่ฃก", "ไฟบใฏๆตท่ณ็ใซใชใ็ทใ "], answer:"ๆตท่ณ็-One Piece", hint:"", type:"ACG"), questionACG(question:["ๆไธๅๆ่ฉฑ็ด่ชช๏ผ้ๅฐฑๆฏๆ็OO", "ไธๆๅพ็ๆๅไผด็ไบบ๏ผ้ฃๅๅพ้ฝไธๅฆ", "็็ดใ่ชๅใฎ่จ่ใฏๆฒใใญใใใใใไฟบใฎๅฟ้ใ "], answer:"็ซๅฝฑๅฟ่-NARUTO", hint:"", type:"ACG"), questionACG(question:["1000-7็ญๆผๅนพ?", "้ฏ็ไธๆฏๆ๏ผ้ฏ็ๆฏ้ๅไธ็", "1000-7ใจใฏไฝใงใใ๏ผ"], answer:"ๆฑไบฌๅฐ็จฎ-Tokyo Ghoul", hint:"", type:"ACG"), questionACG(question:["็ปๅบไฝ ๅ็ๅฟ่ๅง", "้ฃไธๅคฉ๏ผไบบ้กๆณ่ตทไบ๏ผ\nๆพ็ถ่ขซ้ฃ็พคๅขไผๆฏ้็ๆๆผ๏ผ\nไปฅๅ่ขซๅ็ฆๅจ้ณฅ็ฑ ็ๅฑ่พฑ", "ๅฟ่ใๆงใใ๏ผ"], answer:"้ฒๆ็ๅทจไบบ-Attack on Titan", hint:"", type:"ACG"), questionACG(question:["ๅช่ฆๆๆๅจ๏ผไฝ ๅฐฑๆฏๆๅผท็ใ", "OOๆฏๆฐธ้ ๅไธ็็้ๅ", "ไฟบใใใใฐใๅใฏๆๅผทใ !"], answer:"ๆ็ๅฐๅนด-Haikyu!!", hint:"", type:"ACG"), questionACG(question:["็็ธๆฐธ้ ๅชๆไธๅ", "ๆไธ็ฅ้ไฝ ๅๆฎบไบบ็็็ฑๆฏไป้บผ๏ผ\nๅฏๆ็ฅ้๏ผๆไบบๆฏๆฒๆ็็ฑ็ใ", "็็ธใฏๆฐธ้ ใซใฒใจใคใ ใใใใพใ๏ผ"], answer:"ๅๅตๆขๆฏๅ-Case Closed", hint:"", type:"ACG"), questionACG(question:["ๆๆๅฑฅ่กๆ็่ท่ฒฌ๏ผ\nไธๆ่ฎๅจๅ ด็ไปปไฝไบบๆญปๆ๏ผ", "็ก่ซๅฆไฝ๏ผ้ฝ่ซ็บ่ชๅทฑๆๅฐ่ช่ฑชไธฆไธๅชๅๆดปไธๅปใ", "ไฟบใฏไฟบใฎ่ฒฌๅใๅจใใใ๏ผใใใซใใ่ใฏ่ชฐใๆญปใชใใชใ"], answer:"้ฌผๆปไนๅ-Demon Slayer: Kimetsu no Yaiba", hint:"", type:"ACG")]
    let ACGOptions:[String]=["ๆตท่ณ็-One Piece", "็ซๅฝฑๅฟ่-NARUTO", "ๆฑไบฌๅฐ็จฎ-Tokyo Ghoul", "้ฒๆ็ๅทจไบบ-Attack on Titan", "ๆ็ๅฐๅนด-Haikyu!!", "ๅๅตๆขๆฏๅ-Case Closed", "้ฌผๆปไนๅ-Demon Slayer: Kimetsu no Yaiba", "ๅ่ก่ฟดๆฐ--Jujutsu Kaisen", "้ผไน้้่กๅธซ--Fullmental Alchemist", "็ตไบบ--Hunter ร Hunter", "ๆฃ้็--Hikaru no Go", "ๆญปไบก็ญ่จๆฌ--Death Note", "ไธ้พ็ --Dragon Ball", "้้ญ--Bleach"]
    @State private var Word:[questionWord]=[questionWord(question:[""], answer:"ๆๆญๅฐ็ๅญ", hint:"Peter Pan", type:"Word"), questionWord(question:[""], answer:"ๆดไฝฉๅฆฎ", hint:"ๅฅณๆญๆ", type:"Word"), questionWord(question:[""], answer:"็ฐ้ฆฅ็", hint:"ๅฅณๆญๆ", type:"Word"), questionWord(question:[""], answer:"ๅคฉๆฐฃไนๅญ", hint:"ๆฐๆตท่ช ้ปๅฝฑ", type:"Word"), questionWord(question:[""], answer:"็ฅ้ฑๅฐๅฅณ", hint:"ๅๅๅๅทฅไฝๅฎค้ปๅฝฑ", type:"Word"), questionWord(question:[""], answer:"้ญๆณๅฌไธป", hint:"ๅๅๅๅทฅไฝๅฎค้ปๅฝฑ", type:"Word"), questionWord(question:[""], answer:"ไฝ ็ๅๅญ", hint:"ๆฐๆตท่ช ้ปๅฝฑ", type:"Word"), questionWord(question:[""], answer:"่ฒ็ๅ ฑๆฉ", hint:"ๅๅๅๅทฅไฝๅฎค้ปๅฝฑ", type:"Word")]
    var body: some View {

        if questionNumber==0 {
            ZStack{
                Image("Naruto")
                    .resizable()
                    .scaledToFit()
                    .frame(height:200)
                    .position(x:150, y:UIScreen.main.bounds.size.height-200)
                Image("Rasengan")
                    .resizable()
                    .scaledToFit()
                    .frame(height:50)
                    .rotationEffect(.degrees(Double(degrees)))
                    .position(x:200, y:CGFloat(Int(UIScreen.main.bounds.size.height)-250))
                    .onAppear {
                        let baseAnimation = Animation.easeIn(duration: 1)
                        let repeated = baseAnimation.repeatForever(autoreverses:false)
                        withAnimation(repeated) {
                            degrees+=360
                        }
                    }
                Image("Rasengan")
                    .resizable()
                    .scaledToFit()
                    .frame(height:50)
                    .rotationEffect(.degrees(Double(degrees)))
                    .position(x:90, y:CGFloat(Int(UIScreen.main.bounds.size.height)-250))
                    .onAppear {
                        let baseAnimation = Animation.easeIn(duration: 1)
                        let repeated = baseAnimation.repeatForever(autoreverses:false)
                        withAnimation(repeated) {
                            degrees+=360
                        }
                    }
                VStack{
                    Button(action:{
                        showRule=true
                    }){
                        ButtonView(text:"่ฆๅ", size:30)
                    }
                    .alert(isPresented: $showRule, content: {
                        Alert(title: Text("่ฆๅ"), message: Text("้ก็ฎๆไธ็จฎ้กๅ\n1.ๆ นๆ้กๆๅญ็่ฟชๅฃซๅฐผ้ปๅฝฑ\n2.ๆ นๆๅฐ่ฉ็ๅๆผซ\n3.้ๅ่ขซๅ่งฃ็่ฉ่ช\nๆฏ้กไธๅ๏ผๅฑๅ้กใ"), dismissButton: .default(Text("Got it!")))
                    })
                    .padding(50)
                    Button(action:{
                        //ๆ้ธDisneyMovie 4้ก๏ผACG 3้ก๏ผWord 3้ก
                        DisneyMovie.shuffle()
                        choosenDisneyMovie=Array(DisneyMovie[0..<4])
                        ACG.shuffle()
                        choosenACG=Array(ACG[0..<3])
                        Word.shuffle()
                        choosenWord=Array(Word[0..<3])
                        questionNumber+=1
                    }){
                        ButtonView(text:"Start", size:30)
                    }
                }
            }
        } else if questionNumber>0 {
            if questionNumber==11 {
                ZStack{
                    Image("Hinata")
                        .resizable()
                        .scaledToFit()
                        .frame(height:200)
                        .position(x:150, y:UIScreen.main.bounds.size.height-200)
                    Image("volleyBall")
                        .resizable()
                        .scaledToFit()
                        .frame(height:50)
                        .position(CGPoint(x:volleyBallPosX, y:volleyBallPosY))
                        .onAppear {
                            let baseAnimation = Animation.easeIn(duration: 1)
                            let repeated = baseAnimation.repeatForever(autoreverses:false)
                            withAnimation(repeated) {
                                volleyBallPosX+=150
                                volleyBallPosY+=200
                            }
                        }
                    VStack{
                        Text("Scores:\(scores)")
                            .fontWeight(.bold)
                            .font(.title)
                        Button(action:{
                            scores=0
                            questionNumber=0
                            choosenDisneyMovie=[]
                            choosenACG=[]
                            choosenWord=[]
                        }){
                            ButtonView(text:"ๅ็ฉไธๆฌก", size:30)
                        }
                    }
                }
            }else{
                if questionNumber<=4 {
                    ZStack{
                        Image("Disney")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.all)
                            .opacity(0.7)
                        Text("Scores:\(scores)")
                            .position(x: UIScreen.main.bounds.size.width-40, y: 50.0)
                        VStack(spacing:10){
                            Text("Guess a Disney Movie")
                                .fontWeight(.bold)
                                .font(.title)
                            Text("Q\(questionNumber):\(choosenDisneyMovie[questionNumber-1].question)")
                                .fontWeight(.bold)
                                .font(.title)
                            //ๅๅ้ธ้ 
                            VStack(alignment:.leading){
                                Button(action:{
                                    if options[0]==choosenDisneyMovie[questionNumber-1].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
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
                                }){
                                    ButtonView(text:"A. \(options[0])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                                Button(action:{
                                    if options[1]==choosenDisneyMovie[questionNumber-1].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
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
                                }){
                                    ButtonView(text:"B. \(options[1])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                                Button(action:{
                                    if options[2]==choosenDisneyMovie[questionNumber-1].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
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
                                }){
                                    ButtonView(text:"C. \(options[2])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                                Button(action:{
                                    if options[3]==choosenDisneyMovie[questionNumber-1].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
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
                                }){
                                    ButtonView(text:"D. \(options[3])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                            }
                            .frame(width:400)
                        }
                        .frame(height:400)
                        .background(Color.white.opacity(0.5))
                    }
                    .onAppear(perform: {
                        options=DisneyMovieOptions
                        if let index=options.firstIndex(of: choosenDisneyMovie[questionNumber-1].answer){
                            options.remove(at: index)
                        }
                        options.shuffle()
                        options=Array(options[0..<3])
                        options.append(choosenDisneyMovie[questionNumber-1].answer)
                        options.shuffle()
                    })
                } else if questionNumber<=7 {
                    ZStack{
                        Image("Manga")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.all)
                            .opacity(0.7)
                        Text("Scores:\(scores)")
                            .position(x: UIScreen.main.bounds.size.width, y: 50.0)
                        VStack(spacing:10){
                            Text("Guess a Japanese Animation")
                                .fontWeight(.bold)
                                .font(.title)
                            Text("Q\(questionNumber):\(choosenACG[questionNumber-1-4].question[0])")
                                .fontWeight(.bold)
                                .font(.system(size:20))
                            //ๅๅ้ธ้ 
                            VStack(alignment:.leading){
                                Button(action:{
                                    if options[0]==choosenACG[questionNumber-1-4].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
                                    if questionNumber<7 {
                                        options=ACGOptions
                                        if let index=options.firstIndex(of: choosenACG[questionNumber-4].answer){
                                            options.remove(at: index)
                                        }
                                        options.shuffle()
                                        options=Array(options[0..<3])
                                        options.append(choosenACG[questionNumber-4].answer)
                                        options.shuffle()
                                    }
                                }){
                                    ButtonView(text:"A. \(options[0])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                                Button(action:{
                                    if options[1]==choosenACG[questionNumber-1-4].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
                                    if questionNumber<7 {
                                        options=ACGOptions
                                        if let index=options.firstIndex(of: choosenACG[questionNumber-4].answer){
                                            options.remove(at: index)
                                        }
                                        options.shuffle()
                                        options=Array(options[0..<3])
                                        options.append(choosenACG[questionNumber-4].answer)
                                        options.shuffle()
                                    }
                                }){
                                    ButtonView(text:"B. \(options[1])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                                Button(action:{
                                    if options[2]==choosenACG[questionNumber-1-4].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
                                    options=ACGOptions
                                    if questionNumber<7 {
                                        options=ACGOptions
                                        if let index=options.firstIndex(of: choosenACG[questionNumber-4].answer){
                                            options.remove(at: index)
                                        }
                                        options.shuffle()
                                        options=Array(options[0..<3])
                                        options.append(choosenACG[questionNumber-4].answer)
                                        options.shuffle()
                                    }
                                }){
                                    ButtonView(text:"C. \(options[2])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                                Button(action:{
                                    if options[3]==choosenACG[questionNumber-1-4].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //ไบๆธ็ข็้ธ้ 
                                    if questionNumber<7 {
                                        options=ACGOptions
                                        if let index=options.firstIndex(of: choosenACG[questionNumber-4].answer){
                                            options.remove(at: index)
                                        }
                                        options.shuffle()
                                        options=Array(options[0..<3])
                                        options.append(choosenACG[questionNumber-4].answer)
                                        options.shuffle()
                                    }
                                }){
                                    ButtonView(text:"D. \(options[3])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1 }
                                    ))
                                })
                            }
                            .frame(width:400)
                        }
                        .frame(height:400)
                        .background(Color.white.opacity(0.5))
                    }
                    .onAppear(perform: {
                        options=ACGOptions
                        if let index=options.firstIndex(of: choosenACG[questionNumber-1-4].answer){
                            options.remove(at: index)
                        }
                        options.shuffle()
                        options=Array(options[0..<3])
                        options.append(choosenACG[questionNumber-1-4].answer)
                        options.shuffle()
                    })
                    HStack(spacing:30){
                        Button(action:{
                            let speakTalk   = AVSpeechSynthesizer()
                            let speakMsg    = AVSpeechUtterance(string: choosenACG[questionNumber-1-4].question[2])

                            speakMsg.voice  = AVSpeechSynthesisVoice(language: "ja-JP")
                            speakMsg.pitchMultiplier = 1.2
                            speakMsg.rate   = 0.5

                            speakTalk.speak(speakMsg)
                        }){
                            Image(systemName:"speaker.3.fill")
                                .font(.system(size:15))
                                .padding(5)
                                .foregroundColor(Color.white)
                                .background(Color(red:53/255, green:53/255, blue:53/255))
                                .cornerRadius(10)
                                .padding(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red:53/255, green:53/255, blue:53/255), lineWidth: 5)
                                )
                        }
                        Button(action:{
                            showHint=true
                        }){
                            ButtonView(text:"hint", size:15)
                        }
                        .alert(isPresented: $showHint, content: {
                            Alert(title: Text("ๆ็คบ"), message: Text(" \(choosenACG[questionNumber-1-4].question[1])"), dismissButton: Alert.Button.default(
                                Text("Got it!")))
                        })
                    }
                } else {
                    ZStack{
                        Image("Word")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(.all)
                            .opacity(0.7)
                        Text("Scores:\(scores)")
                            .position(x: UIScreen.main.bounds.size.width, y: 50.0)
                        VStack(spacing:20){
                            Text("Q\(questionNumber):")
                                .fontWeight(.bold)
                                .font(.title)
                            Image("\(choosenWord[questionNumber-1-4-3].answer)")
                                .resizable()
                                .frame(width:300, height:300)
                                .scaledToFit()
                            HStack{
                                TextField("Enter your answer", text: $wordAns)
                                    .background(Color.gray.opacity(0.5))
                                    .frame(width:200)
                                Button(action:{
                                    if wordAns==choosenWord[questionNumber-1-4-3].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                }){
                                    ButtonView(text:"Enter", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("็ญๅฐๅ") : Text("็ญ้ฏๅ"), message: result ? Text("") : Text("็ญๆก็บ-- \(choosenWord[questionNumber-1-4-3].answer)"), dismissButton: Alert.Button.default(
                                        Text("Got it!"), action: { questionNumber+=1; wordAns=""}
                                    ))
                                })
                            }
                        }
                        .frame(width:400, height:400)
                        .background(Color.white.opacity(0.5))
                    }
                    Button(action:{
                        showHint=true
                    }){
                        ButtonView(text:"hint", size:15)
                    }
                    .alert(isPresented: $showHint, content: {
                        Alert(title: Text("ๆ็คบ"), message: Text(" \(choosenWord[questionNumber-1-4-3].hint)"), dismissButton: Alert.Button.default(
                            Text("Got it!")))
                    })
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

struct ButtonView: View {
    let text:String
    let size:CGFloat
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .font(.system(size:size))
            .padding(5)
            .background(Color(red:53/255, green:53/255, blue:53/255))
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red:53/255, green:53/255, blue:53/255), lineWidth: 5)
            )
    }
}
