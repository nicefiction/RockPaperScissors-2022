/// Source:
/// https://www.hackingwithswift.com/guide/ios-swiftui/2/3/challenge

import SwiftUI


struct ContentView: View {
    
    // MARK: - PROPERTY WRAPPERS
    @State private var currentGameRound = 0
    @State private var gameOptions: Array<String> = [
        "🪨", "📄", "✂️"
    ]
    @State private var optionSelectedByGame = Int.random(in: 0...2)
    @State private var gameScore: Int = 0 {
        didSet {
            if gameScore < 0 {
                gameScore = 0
            }
        }
    }
    @State private var gameFeedback: String = ""
    @State private var isShowingEndScoreAlert: Bool = false
    
    
    
    // MARK: - PROPERTIES
    let maxGameRound: Int = 3
    let challengeText: Text = Text("Your Pick?")
    var optionSelectedByHuman: Int = 0
    
    
    
    // MARK: - INITIALIZERS
    // MARK: - COMPUTED PROPERTIES
    
    var body: some View {
        
        VStack(spacing: 50) {
            VStack(spacing: 10) {
                Text("I have chosen.")
                    .font(.subheadline)
                    .fontWeight(.medium)
                challengeText
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            HStack {
                ForEach(gameOptions,
                        id: \.self) { (option: String) in
                    Button {
                        print("\(option) was tapped.")
                        determineResult(with: option)
                        startNewRound()
                        if currentGameRound == maxGameRound {
                            isShowingEndScoreAlert.toggle()
                        }
                    } label: {
                        Text(option)
                            .font(.system(size: 75))
                            .padding(8)
                    }
                }
            }
            Text(gameFeedback)
                .font(.title)
                .fontWeight(.medium)
        }
        .alert("Your end score is \(gameScore).",
               isPresented: $isShowingEndScoreAlert) {
            Button("Start New Game.",
                   role: .none,
                   action: startNewGame)
        }
    }
    
    
    
    // MARK: - METHODS
    
    func determineResult(with option: String)
    -> Void {
        
        switch (gameOptions[optionSelectedByGame], option) {
        case ("🪨", "🪨"):
            gameScore += 0
            gameFeedback = "Rocks cancel each other out, try again."
            
        case ("🪨", "📄"):
            gameScore += 1
            gameFeedback = "Paper envelops rock, you win."
            
        case ("🪨", "✂️"):
            gameScore -= 1
            gameFeedback = "Rock crushes scissors, you loose."
            
        case ("📄", "🪨"):
            gameScore -= 1
            gameFeedback = "Paper envelops rock, you loose."
            
        case ("📄", "📄"):
            gameScore += 0
            gameFeedback = "Papers cancel each other out, try again."
            
        case ("📄", "✂️"):
            gameScore += 1
            gameFeedback = "Scissors cut paper, you win."
            
        case ("✂️", "🪨"):
            gameScore += 1
            gameFeedback = "Rock crushes scissors, you win."
            
        case ("✂️", "📄"):
            gameScore -= 1
            gameFeedback = "Scissors cut paper, you loose."
            
        default:
            gameScore += 0
            gameFeedback = "Scissors cancel each other out, try again."
        }
    }
    
    
    func startNewRound()
    -> Void {
        
        optionSelectedByGame = Int.random(in: 0...2)
        currentGameRound += 1
    }
    
    
    func startNewGame()
    -> Void {
        
        currentGameRound = 0
        optionSelectedByGame = Int.random(in: 0...2)
    }
    
    
    
    // MARK: - HELPER METHODS
}





// MARK: - PREVIEWS

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        Group {
            ContentView().preferredColorScheme(.dark)
        }
    }
}
