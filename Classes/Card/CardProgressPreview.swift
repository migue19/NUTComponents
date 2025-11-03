//  CardProgressPreview.swift
//  RunSession
//
//  Created by automated agent on 30/09/25.
//
import UIKit
import SwiftUI

// Wrapper to preview UIKit CardProgressView in SwiftUI previews
struct CardProgressViewRepresentable: UIViewRepresentable {
    // Si se pasa un ancho, la vista usará ese ancho; si es nil, se dejará que el layout lo determine.
    var containerWidth: CGFloat?
    var containerHeight: CGFloat? = 220

    func makeUIView(context: Context) -> CardProgressView {
        let view = CardProgressView(title: "5K")
        view.translatesAutoresizingMaskIntoConstraints = false

        // Si se especifica un ancho/alto, añadir constraints para forzarlos en el preview
        if let w = containerWidth {
            view.widthAnchor.constraint(equalToConstant: w).isActive = true
        }
        if let h = containerHeight {
            view.heightAnchor.constraint(equalToConstant: h).isActive = true
        }

        view.layoutIfNeeded()
        return view
    }

    func updateUIView(_ uiView: CardProgressView, context: Context) {
        // No update needed for preview
    }
}

struct CardProgressPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Usar GeometryReader para obtener el ancho disponible y pasarlo al representable
            GeometryReader { geo in
                CardProgressViewRepresentable(containerWidth: geo.size.width, containerHeight: 220)
                    .frame(height: 220)
                    .background(Color.black)
            }
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Default - full width")

            GeometryReader { geo in
                CardProgressViewRepresentable(containerWidth: geo.size.width, containerHeight: 220)
                    .frame(height: 220)
                    .background(Color.black)
                    .environment(\.colorScheme, .dark)
            }
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Dark - full width")
        }
    }
}
