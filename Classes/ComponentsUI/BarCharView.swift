//
//  BarCharView.swift
//  RunSession
//
//  Created by Miguel Mexicano Herrera on 19/08/25.
//
import UIKit
// MARK: - BarChartView (muy ligero, solo barras + grid punteado)
final class BarChartView: UIView {
    var values: [CGFloat] = [] { didSet { recalcScaleAndRedraw() } }
    var barColor: UIColor = .green
    
    // Grid (4 líneas: 0, 1/3, 2/3, 1)
    private let tickDivisions: Int = 3
    var gridColor: UIColor = UIColor(white: 1, alpha: 0.18)
    var gridLineWidth: CGFloat = 1
    var gridDash: [CGFloat] = [3, 4]
    
    // Insets internos
    var topInset: CGFloat = 3
    var bottomInset: CGFloat = 3
    
    // Escala "bonita"
    private(set) var niceMax: CGFloat = 1      // Máximo del eje Y redondeado
    private(set) var ticks: [CGFloat] = []     // [max, 2/3 max, 1/3 max, 0]
    
    // Callback para que el VC actualice los labels del eje Y
    var onTicksChanged: (([CGFloat]) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isOpaque = false
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func recalcScaleAndRedraw() {
        let dataMax = max(values.max() ?? 0, 0.0001)
        niceMax = niceCeil(dataMax)                // 1, 2, 5 × 10^n
        let step = niceMax / CGFloat(tickDivisions) // 3 divisiones → 4 líneas
        ticks = [niceMax, 2*step, 1*step, 0]
        onTicksChanged?(ticks)
        setNeedsDisplay()
    }
    
    // Algoritmo "nice number" para redondear hacia arriba
    private func niceCeil(_ x: CGFloat) -> CGFloat {
        guard x > 0 else { return 1 }
        
        let exp = floor(log10(x))
        let f = x / pow(10, exp)      // Normalizar a rango 1..10
        
        // Redondear a números "bonitos": 1, 2, 5, 10
        let nf: CGFloat
        if f <= 1 { nf = 1 }
        else if f <= 2 { nf = 2 }
        else if f <= 5 { nf = 5 }
        else { nf = 10 }
        
        let result = nf * pow(10, exp)
        
        // Para valores muy pequeños (< 0.5), establecer mínimo en 1.0 km
        // Esto asegura que la gráfica siempre tenga una escala legible
        return max(result, 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        let drawRect = rect.inset(by: UIEdgeInsets(top: topInset, left: 0, bottom: bottomInset, right: 0))
        
        // --- GRID: 0, 1/3, 2/3, 1 (4 líneas) ---
        ctx.saveGState()
        ctx.setStrokeColor(gridColor.cgColor)
        ctx.setLineWidth(gridLineWidth)
        ctx.setLineDash(phase: 0, lengths: gridDash)
        
        for i in 0...tickDivisions { // 0,1,2,3
            let frac = CGFloat(i) / CGFloat(tickDivisions)  // 0→base ... 1→top
            let y = drawRect.maxY - frac * drawRect.height
            ctx.move(to: CGPoint(x: drawRect.minX, y: y))
            ctx.addLine(to: CGPoint(x: drawRect.maxX, y: y))
        }
        ctx.strokePath()
        ctx.restoreGState()
        
        // --- BARRAS ---
        guard !values.isEmpty else { return }
        let spacing: CGFloat = 12
        let availableWidth = drawRect.width - spacing * CGFloat(values.count + 1)
        let barWidth = max(8, availableWidth / CGFloat(values.count))
        
        for (i, v) in values.enumerated() {
            // Escala contra niceMax para que coincida con la grilla
            let h = min( (v / niceMax) * (drawRect.height - 1), drawRect.height - 1)
            let x = drawRect.minX + spacing + CGFloat(i) * (barWidth + spacing)
            let barRect = CGRect(x: x, y: drawRect.maxY - h, width: barWidth, height: h)
            let path = UIBezierPath(roundedRect: barRect, cornerRadius: 6)
            barColor.setFill()
            path.fill()
        }
    }
}
