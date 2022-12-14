import SwiftUI

struct MemoryGameView: View {
    
    @ObservedObject
    var emoijViewModel: EmojiMemoryGameViewModel
        
    @State
    private var showingSheet = true
    
    
    var body: some View {
        HStack(alignment: .center) {
            Text("Score: \(emoijViewModel.currentScore)")
            Spacer()
            Text("HighScore: \(emoijViewModel.highScore)")
        }.padding(.horizontal)
        VStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumColumnWidth))]) {
                    ForEach(emoijViewModel.cards){ card in
                        CardView(card: card)
                            .aspectRatio(cardAspectRatio, contentMode: .fit)
                            .onTapGesture {
                                withAnimation(.linear(duration: rotationDuration)) {
                                    self.emoijViewModel.choose(card: card)
                                }
                        }
                    }
                }.foregroundColor(Color.blue)
            }.padding(.horizontal)
        }
        Button("New Game") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    SheetView(viewModel: emoijViewModel)
                }
    }
    // MARK: - Drawing Constants
    private let minimumColumnWidth = Double(65)
    private let rotationDuration = Double(0.75)
    private let cardAspectRatio = CGFloat(0.7)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let emoijGame = EmojiMemoryGameViewModel()
        
        emoijGame.choose(card: emoijGame.cards[0])
        //shapeGame.choose(card: shapeGame.cards[0])
        
        return MemoryGameView(emoijViewModel: emoijGame)
    }
}
