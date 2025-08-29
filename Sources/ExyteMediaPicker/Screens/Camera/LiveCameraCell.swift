//
//  Created by Alex.M on 06.06.2022.
//

import SwiftUI

struct LiveCameraCell: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.mediaPickerTheme) private var theme

    let action: () -> Void
    
    @StateObject private var cameraViewModel = CameraViewModel()
    @State private var orientation = UIDevice.current.orientation
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                LiveCameraView(
                    session: cameraViewModel.captureSession,
                    videoGravity: .resizeAspectFill,
                    orientation: orientation
                )
                .overlay(
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                )
                
                if cameraViewModel.isLoading {
                    theme.main.cameraBackground
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: theme.main.cameraText))
                                .scaleEffect(1.2)
                        )
                }
            }
        }
        .onChange(of: scenePhase) { _ in
            Task {
                if scenePhase == .background {
                    await cameraViewModel.stopSession()
                } else if scenePhase == .active {
                    await cameraViewModel.startSession()
                }
            }
        }
        .onRotate { orientation = $0 }
    }
}
