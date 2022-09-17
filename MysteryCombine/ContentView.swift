import SwiftUI

struct ContentView: View {
    var game = FootballGames()
    private var team1 = Int.random(in: 0..<50)
    private var team2 = Int.random(in: 0..<50)
    @State private var winner = ""

    var body: some View {
        VStack(spacing: 50) {
            HStack(spacing: 20) {
                Text("Team one: \(team1)")
                Text("Team two: \(team2)")
            }
            Button("Calculate winner") {
                winner = game.calculateWinner(teamOne: team1, teamTwo: team2)
            }
            Text(winner)
        }
    }
}

protocol GameScore {
    associatedtype TeamScore

    func calculateWinner(teamOne: TeamScore, teamTwo: TeamScore) -> String
}

struct FootballGames: GameScore {
    typealias TeamScore = Int

    func calculateWinner(teamOne: TeamScore, teamTwo: TeamScore) -> String {
        if teamOne > teamTwo {
            return "Team one winner"
        } else if teamOne == teamTwo {
            return "The teams tied"
        }
        return "Team two winner"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
