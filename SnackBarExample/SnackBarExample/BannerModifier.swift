//
//  BannerModifier.swift
//  SnackBarExample
//
//  Created by solution888 on 4/25/22.
//

import Foundation
import SwiftUI

struct BannerData {
        var title: String
        var detail: String
        var type: BannerType
    }

    enum BannerType {
        case info
        case warning
        case success
        case error

        var tintColor: Color {
            switch self {
            case .info:
                return Color.blue
            case .success:
                return Color.green
            case .warning:
                return Color.yellow
            case .error:
                return Color.red
            }
        }
    }

struct BannerModifier: ViewModifier {

    @Binding var data: BannerData
    @Binding var show: Bool


    @State var task: DispatchWorkItem?

    func body(content: Content) -> some View {
        ZStack {
            if show {
                VStack {
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data.title)
                                .bold()
                            Text(data.detail)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data.type.tintColor)
                    .cornerRadius(8)
                    .shadow(radius: 20)
                }
                .padding()
                .animation(Animation.easeInOut(duration: 1.0))
                .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))

                .onTapGesture {
                    withAnimation {
                        self.show = false
                    }
                }.onAppear {
                    self.task = DispatchWorkItem {
                        withAnimation {
                            self.show = false
                        }
                    }
                    // Auto dismiss after 5 seconds, and cancel the task if view disappear before the auto dismiss
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: self.task!)
                }
                .onDisappear {
                    self.task?.cancel()
                }
            }
            content
        }
    }
}

extension View {
    func banner(data: Binding<BannerData>, show: Binding<Bool>) -> some View {
        self.modifier(BannerModifier(data: data, show: show))
    }
}
