//
//  StatisticsView.swift
//  TicTacToe (iOS)
//
//  Created by Matvey Garbuzov on 07.05.2022.
//

import SwiftUI
import SwiftUICharts


struct StatisticsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    OverralGameStats()
                    MinesweeperStats()
                    TicTacToeStats()
                    ConnectFourStats()
                }
                PieChartView()
            }
            .navigationTitle(Text("Game Statistics"))
        }
        
    }
}

struct OverralGameStats: View {
    @AppStorage(UserDefaults.gamesWonInMinesweeper) var minesweeperWins = GameStatistics.gamesWonInMinesweeper
    @AppStorage(UserDefaults.gamesWonInTicTacToe) var ticTacToeWins = GameStatistics.gamesWonInTicTacToe
    @AppStorage(UserDefaults.gamesWonInConnectFour) var connectFourWins = GameStatistics.gamesWonInConnectFour
    
    @AppStorage(UserDefaults.gamesLostInMinesweeper) var minesweeperLost = GameStatistics.gamesLostInMinesweeper
    @AppStorage(UserDefaults.gamesLostInTicTacToe) var ticTacToeLost = GameStatistics.gamesLostInTicTacToe
    @AppStorage(UserDefaults.gamesLostInConnectFour) var connectFourLost = GameStatistics.gamesLostInConnectFour
    
    var body: some View {
        Section(header: Text("Total")) {
            VStack(alignment: .leading) {
                let totalWins = minesweeperWins + ticTacToeWins + connectFourWins
                let totalLost = minesweeperLost + ticTacToeLost + connectFourLost
               
                Text("Total wins: \(totalWins)")
                Text("Total lost: \(totalLost)")
            }
        }
    }
}

struct MinesweeperStats: View {
    @AppStorage(UserDefaults.gamesWonInMinesweeper) var gamesWonInMinesweeper = GameStatistics.gamesWonInMinesweeper
    @AppStorage(UserDefaults.gamesLostInMinesweeper) var gamesLostInMinesweeper = GameStatistics.gamesLostInMinesweeper
    @AppStorage(UserDefaults.totalDeaths) var totalDeaths = GameStatistics.totalDeaths
    @AppStorage(UserDefaults.flagCount) var flagCount = GameStatistics.flagCount
    
    var body: some View {
        Section(header: Text("Minesweeper")) {
            VStack(alignment: .leading) {
                Text("Total wins: \(gamesWonInMinesweeper)")
                Text("Total loses: \(gamesLostInMinesweeper)")
                Text("Total deaths: \(totalDeaths)")
                Text("Total flags count: \(flagCount)")
            }
        }
    }
}



struct TicTacToeStats: View {
    @AppStorage(UserDefaults.gamesWonInTicTacToe) var gamesWonInTicTacToe = GameStatistics.gamesWonInTicTacToe
    @AppStorage(UserDefaults.gamesLostInTicTacToe) var gamesLostInTicTacToe = GameStatistics.gamesLostInTicTacToe
    
    var body: some View {
        Section(header: Text("Tic Tac Toe")) {
            VStack(alignment: .leading) {
                Text("Total wins: \(gamesWonInTicTacToe)")
                Text("Total loses: \(gamesLostInTicTacToe)")
            }
        }
    }
}

struct ConnectFourStats: View {
    @AppStorage(UserDefaults.gamesWonInConnectFour) var gamesWonInConnectFour = GameStatistics.gamesWonInConnectFour
    @AppStorage(UserDefaults.gamesLostInConnectFour) var gamesLostInConnectFour = GameStatistics.gamesLostInConnectFour
    
    var body: some View {
        Section(header: Text("Connect Four")) {
            VStack(alignment: .leading) {
                Text("Total wins: \(gamesWonInConnectFour)")
                Text("Total loses: \(gamesLostInConnectFour)")
            }
        }
    }
}

struct PieChartView: View {
    @AppStorage(UserDefaults.gamesWonInMinesweeper) var gamesWonInMinesweeper = GameStatistics.gamesWonInMinesweeper
    @AppStorage(UserDefaults.gamesWonInTicTacToe) var gamesWonInTicTacToe = GameStatistics.gamesWonInTicTacToe
    @AppStorage(UserDefaults.gamesWonInConnectFour) var gamesWonInConnectFour = GameStatistics.gamesWonInConnectFour
    
    var body: some View {
        BarChartView(
            data: ChartData(values: [
                ("Minesweeper", gamesWonInMinesweeper),
                ("Tic Tac Toe", gamesWonInTicTacToe),
                ("ConnectFour", gamesWonInConnectFour)
            ]),
            title: "Wins",
            legend: "in different games",
            form: ChartForm.extraLarge,
            cornerImage: Image(systemName: "chart.bar"),
            valueSpecifier: "Wins:  %.0f"
        )
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
