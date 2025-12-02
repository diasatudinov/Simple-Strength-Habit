struct HabitProgressBar: View {
    let progress: Decimal
    let goal: Decimal

    private var ratio: Double {
        guard goal > 0 else { return 0 }
        let value = progress.doubleValue / goal.doubleValue
        return max(0, min(value, 1))   // clamp 0...1
    }

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // фон
                Capsule()
                    .fill(Color.gray.opacity(0.2))

                // заполненная часть
                Capsule()
                    .fill(Color.blue)
                    .frame(width: geo.size.width * ratio)
            }
        }
        .frame(height: 8)  // высота прогресс-бара
    }
}