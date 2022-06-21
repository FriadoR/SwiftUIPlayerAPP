//
//  ContentView.swift
//  MusicLottieAPP
//
//  Created by Сергей Саченко on 21.06.2022.
//

import AVFoundation
import SwiftUI
import Lottie

class PlayerViewModel: ObservableObject {
   @Published public var maxDuration = 0.0
    private var player: AVAudioPlayer?
    
    public func play() {
        playSong(name: "coca-cola")
        player?.play()
    }
    public func stop() {
        player?.stop()
    }
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
    }
    
    private func playSong(name: String) {
        guard let audioPath = Bundle.main.path(forResource: name, ofType: "mp3") else { return }
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            maxDuration = player?.duration ?? 0.0
       
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView: View {
    @State private var progress: Float = 0
    @ObservedObject var viewModel = PlayerViewModel()
    @State var isLoading = false
    @State var musicBox = false
    
    var body: some View {
        
        ZStack {
            Image("cosmo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack {
                if isLoading {
                    LottieView()
                        .frame(width: 400, height: 250)
                }
                
                VStack {
                    Slider(value: Binding(get: {
                        Double(self.progress)
                    }, set: { newValue in
                        print(newValue)
                        self.progress = Float(newValue)
                        self.viewModel.setTime(value: Float(newValue))
                    }), in: 0...viewModel.maxDuration).padding().foregroundColor(.white)

                    HStack{
                        
                        Button(action: {
                            self.viewModel.play()
                            self.isLoading = true
                            self.musicBox = true
                        }, label: {
                            Text("Play")
                    })
                    
                    .frame(width: 110, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(15)
                    
                    .padding(13)
                    
                    Button(action: {
                        self.viewModel.stop()
                    }, label: {
                        Text("Stop")
                    })
                    .frame(width: 110, height: 50, alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(15)
                
                    }
                    if musicBox {
                        LottieView2().frame(width: 400, height: 400)
                    }
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
