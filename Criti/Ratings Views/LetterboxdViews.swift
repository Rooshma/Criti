//
//  LetterboxdView.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-10.
//

import SwiftUI

struct LetterboxdCondensedView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let movie: Movie
    
    var body: some View {
        VStack(spacing: 0) {
            Image(colorScheme == .light ? "lbLogoDark" : "lbLogoLight")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .alignmentGuide(.midLogos) { d in d[VerticalAlignment.center] }
            if movie.letterboxdRating.averageRating > 0 {
                Text("\(movie.letterboxdRating.averageRating.formatted())")
                    .font(.custom("Graphik-Light", size: 30))
                    .lineSpacing(0)
                StarsView(rating: movie.letterboxdRating.averageRating)
                    .frame(width: 75)
            }
        }
    }
}

struct StarsView: View {
    var rating: CGFloat

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }

        stars.overlay(
            GeometryReader { geo in
                let width = max(rating / 5 * geo.size.width, 0)
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(Color("LBGreen"))
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}

struct LetterboxdExpandedView: View {
    @Environment(\.colorScheme) var colorScheme
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(colorScheme == .light ? "lbLogoDark" : "lbLogoLight")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                Spacer()
                Text("\(movie.letterboxdRating.averageRating.formatted())")
                    .font(.title)
            }
            .padding([.top, .horizontal])
            HStack(alignment: .bottom, spacing: 1) {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10)
                    .padding(.bottom, 5)
                Spacer()
                if let mostCommonRating = movie.letterboxdRating.histogram.max() {
                    ForEach(movie.letterboxdRating.histogram, id: \.self) { rating in
                        GeometryReader { geo in
                            VStack {
                                Spacer()
                                Rectangle()
                                    .frame(height: geo.size.height * CGFloat(Double(rating) / Double(mostCommonRating)) * 0.9)
                                    .foregroundColor(Color("LBGreen"))
                            }
                        }
                    }
                }
                Spacer()
                ForEach(0..<5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .padding(.bottom, 5)

                }
            }
            .padding([.horizontal, .top])
        }
        .frame(height: 150)
    }
}

// This could be useful if histogram bars need to be recreated in other places. As is, it may be unnecessary.
//struct HistogramBar: View {
//    let rating: Int
//    let mostCommonRating: Int
//
//    var body: some View {
//        GeometryReader { geo in
//            VStack {
//                Spacer()
//                Rectangle()
//                    .frame(height: geo.size.height * CGFloat(Double(rating) / Double(mostCommonRating)) * 0.9)
//                    .foregroundColor(Color("LBGreen"))
//            }
//        }
//    }
//}

struct LetterboxdInfoView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image(colorScheme == .light ? "lbLogoDark" : "lbLogoLight")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            Text("We use a weighted calculation to compute the average rating for each film, rather than using the true mean value of all the ratings cast. Only one rating is considered per member (the rating shown when that member visits the film’s page; prior ratings from older diary entries are not considered). The ‘weighted’ part of the calculation refers to the way in which we consider the number of ratings cast as part of the average; a film with only a handful of five-star ratings has its average weighted down to account for the lower volume of ratings cast compared to a film with tens or hundreds of thousands of ratings.")
        }
        .padding(.horizontal)
    }
}
