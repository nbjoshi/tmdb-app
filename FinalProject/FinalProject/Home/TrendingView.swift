//
//  TrendingView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct TrendingView: View {
    @State private var trendingVM = TrendingViewModel()

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(trendingVM.trending) { trending in
                    TrendingCardView(trending: trending)
                }
            }
        }
        .task {
            await trendingVM.getTrending()
        }
    }
}

#Preview {
    TrendingView()
}
