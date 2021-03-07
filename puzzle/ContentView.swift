//
//  ContentView.swift
//  puzzle
//
//  Created by 林湘羚 on 2021/3/3.
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
    @State private var DisneyMovie:[questionDisneyMovie]=[questionDisneyMovie(question:"🔔🧚‍♂🏴‍☠️⛵️", answer:"彼得潘-Peter Pan", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"🧜‍♀🦀️🐙", answer:"小美人魚-The Little Mermaid", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"🧞‍♂🐒", answer:"阿拉丁-Aladdin", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"👸🐗🕯☕️🕰", answer:"美女與野獸-Beauty and the Beast", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"🦁️🐒👑🐗", answer:"獅子王-Lion King", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"🗡👧🐎🐲🦗", answer:"花木蘭-Mulan", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"🦍👦🌲", answer:"泰山-Tarzan", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"👦👃🦗🐳", answer:"皮諾丘-Pinocchio", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"👠👸🧹👗🐭", answer:"仙度瑞拉-Cinderella", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"🍄🐱👧🐰⏱", answer:"愛麗絲夢遊仙境-Alice in Wonderland", hint:"", type:"DisneyMovie"), questionDisneyMovie(question:"⛄️❄️👸👸", answer:"冰雪奇緣-Frozen", hint:"", type:"DisneyMovie")]
    let DisneyMovieOptions:[String]=["彼得潘-Peter Pan", "小美人魚-The Little Mermaid", "阿拉丁-Aladdin", "美女與野獸-Beauty and the Beast", "獅子王-Lion King", "花木蘭-Mulan", "泰山-Tarzan", "皮諾丘-Pinocchio", "仙度瑞拉-Cinderella", "愛麗絲夢遊仙境-Alice in Wonderland", "冰雪奇緣-Frozen", "白雪公主--Snow White and the Seven Dwarfs", "寶嘉康蒂--Pocahontas", "鐘樓怪人--The Hunchback of Notre Dame", "小鹿斑比--Bambi"]
    @State private var ACG:[questionACG]=[questionACG(question:["我是要成為OOO的男人!", "想得到我的財寶嗎?想要的話可以全部給你 去找吧 我把所有的財寶都放在那裡", "俺は海賊王になる男だ"], answer:"海賊王-One Piece", hint:"", type:"ACG"), questionACG(question:["我一向有話直說，這就是我的OO", "不懂得珍惜同伴的人，連垃圾都不如", "真直ぐ自分の言葉は曲げねぇ、それが俺の忍道だ"], answer:"火影忍者-NARUTO", hint:"", type:"ACG"), questionACG(question:["1000-7等於幾?", "錯的不是我，錯的是這個世界", "1000-7とは何ですか？"], answer:"東京喰種-Tokyo Ghoul", hint:"", type:"ACG"), questionACG(question:["獻出你們的心臟吧", "那一天，人類想起了，\n曾經被那群傢伙支配的恐懼，\n以及被囚禁在鳥籠的屈辱", "心臓を捧げよ！"], answer:"進擊的巨人-Attack on Titan", hint:"", type:"ACG"), questionACG(question:["只要有我在，你就是最強的。", "OO是永遠向上看的運動", "俺がいれば、君は最強だ!"], answer:"排球少年-Haikyu!!", hint:"", type:"ACG"), questionACG(question:["真相永遠只有一個", "我不知道你們殺人的理由是什麼，\n可我知道，救人是沒有理由的。", "真相は永遠にひとつだけあるます！"], answer:"名偵探柯南-Case Closed", hint:"", type:"ACG"), questionACG(question:["我會履行我的職責！\n不會讓在場的任何人死掉！", "無論如何，都請為自己感到自豪並且努力活下去。", "俺は俺の責務を全うする！ここにいる者は誰も死なせない"], answer:"鬼滅之刃-Demon Slayer: Kimetsu no Yaiba", hint:"", type:"ACG")]
    let ACGOptions:[String]=["海賊王-One Piece", "火影忍者-NARUTO", "東京喰種-Tokyo Ghoul", "進擊的巨人-Attack on Titan", "排球少年-Haikyu!!", "名偵探柯南-Case Closed", "鬼滅之刃-Demon Slayer: Kimetsu no Yaiba", "咒術迴戰--Jujutsu Kaisen", "鋼之鍊金術師--Fullmental Alchemist", "獵人--Hunter × Hunter", "棋靈王--Hikaru no Go", "死亡筆記本--Death Note", "七龍珠--Dragon Ball", "銀魂--Bleach"]
    @State private var Word:[questionWord]=[questionWord(question:[""], answer:"情歌小王子", hint:"Peter Pan", type:"Word"), questionWord(question:[""], answer:"戴佩妮", hint:"女歌手", type:"Word"), questionWord(question:[""], answer:"田馥甄", hint:"女歌手", type:"Word"), questionWord(question:[""], answer:"天氣之子", hint:"新海誠電影", type:"Word"), questionWord(question:[""], answer:"神隱少女", hint:"吉卜力工作室電影", type:"Word"), questionWord(question:[""], answer:"魔法公主", hint:"吉卜力工作室電影", type:"Word"), questionWord(question:[""], answer:"你的名字", hint:"新海誠電影", type:"Word"), questionWord(question:[""], answer:"貓的報恩", hint:"吉卜力工作室電影", type:"Word")]
    var body: some View {

        if questionNumber==0 {
            ZStack{
                //Image("")
                VStack{
                    Button(action:{
                        showRule=true
                    }){
                        ButtonView(text:"規則", size:30)
                    }
                    .alert(isPresented: $showRule, content: {
                        Alert(title: Text("規則"), message: Text("題目有三種題型\n1.根據顏文字猜迪士尼電影\n2.根據台詞猜動漫\n3.還原被分解的詞語\n每題一分，共十題。"), dismissButton: .default(Text("Got it!")))
                    })
                    .padding(50)
                    Button(action:{
                        //挑選DisneyMovie 4題，ACG 3題，Word 3題
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
                            ButtonView(text:"再玩一次", size:30)
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
                            //四個選項
                            VStack(alignment:.leading){
                                Button(action:{
                                    if options[0]==choosenDisneyMovie[questionNumber-1].answer {
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
                                }){
                                    ButtonView(text:"A. \(options[0])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
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
                                }){
                                    ButtonView(text:"B. \(options[1])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
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
                                }){
                                    ButtonView(text:"C. \(options[2])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
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
                                }){
                                    ButtonView(text:"D. \(options[3])", size:15)
                                }
                                .alert(isPresented: $showResult, content: {
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenDisneyMovie[questionNumber-1].answer)"), dismissButton: Alert.Button.default(
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
                            //四個選項
                            VStack(alignment:.leading){
                                Button(action:{
                                    if options[0]==choosenACG[questionNumber-1-4].answer {
                                        scores+=1
                                        result=true
                                    }else {
                                        result=false
                                    }
                                    showResult=true
                                    //亂數產生選項
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
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
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
                                    //亂數產生選項
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
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
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
                                    //亂數產生選項
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
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
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
                                    //亂數產生選項
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
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenACG[questionNumber-1-4].answer)"), dismissButton: Alert.Button.default(
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
                            Alert(title: Text("提示"), message: Text(" \(choosenACG[questionNumber-1-4].question[1])"), dismissButton: Alert.Button.default(
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
                                    Alert(title: result ? Text("答對囉") : Text("答錯囉"), message: result ? Text("") : Text("答案為-- \(choosenWord[questionNumber-1-4-3].answer)"), dismissButton: Alert.Button.default(
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
                        Alert(title: Text("提示"), message: Text(" \(choosenWord[questionNumber-1-4-3].hint)"), dismissButton: Alert.Button.default(
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
