//import SwiftUI
//
//struct AnimatedMeshBackground: View {
//    private enum AnimationProperties {
//        static let animationSpeed: Double = 4
//        static let timerDuration: TimeInterval = 3
//        static let blurRadius: CGFloat = 130
//        static let backgroundColor = Color(#colorLiteral(red: 0.003921568627, green: 0.01176470588, blue: 0.07843137255, alpha: 1))
//        static let colors = [
//            Color(#colorLiteral(red: 0.003799867816, green: 0.01174801588, blue: 0.07808648795, alpha: 1)),
//            Color(#colorLiteral(red: 0.147772789, green: 0.08009552211, blue: 0.3809506595, alpha: 1)),
//            Color(#colorLiteral(red: 0.5622407794, green: 0.4161503613, blue: 0.9545945525, alpha: 1)),
//            Color(#colorLiteral(red: 0.7909697294, green: 0.7202591896, blue: 0.9798423648, alpha: 1)),
//            Color(#colorLiteral(red: 0.7909697294, green: 0.7202591896, blue: 0.9798423648, alpha: 1)),
//        ]
//    }
//
//    @State private var animatePhase = false
//    @State private var circles: [MovingCircleData] = AnimationProperties.colors.map {
//        MovingCircleData(color: $0, position: Self.randomPosition())
//    }
//
//    var body: some View {
//        ZStack {
//            ZStack {
//                ForEach(circles) { circle in
//                    Circle()
//                        .fill(circle.color)
//                        .modifier(MeshPositionModifier(position: circle.position, phase: animatePhase))
//                }
//            }
//            .blur(radius: AnimationProperties.blurRadius)
//        }
//        .background(AnimationProperties.backgroundColor)
//        .ignoresSafeArea()
//        .onAppear {
//            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
//                animatePhase.toggle()
//            }
//        }
//    }
//
//    private static func randomPosition() -> CGPoint {
//        CGPoint(x: CGFloat.random(in: -0.2...1.2), y: CGFloat.random(in: -0.2...1.2))
//    }
//}
//
//private struct MovingCircleData: Identifiable {
//    let id = UUID()
//    let color: Color
//    var position: CGPoint
//}
//
//private struct MeshPositionModifier: ViewModifier, Animatable {
//    var position: CGPoint
//    var phase: Bool
//
//    @State private var alternativePosition = CGPoint(
//        x: CGFloat.random(in: -0.2...1.2),
//        y: CGFloat.random(in: -0.2...1.2)
//    )
//
//    func body(content: Content) -> some View {
//        GeometryReader { geometry in
//            let currentPos = phase ? position : alternativePosition
//            content
//                .frame(width: min(geometry.size.width, geometry.size.height))
//                .position(
//                    x: geometry.size.width * currentPos.x,
//                    y: geometry.size.height * currentPos.y
//                )
//        }
//    }
//}
//
//#Preview {
//    AnimatedMeshBackground()
//}
