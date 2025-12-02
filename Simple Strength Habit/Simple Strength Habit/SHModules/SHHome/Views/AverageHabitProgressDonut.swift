struct AverageHabitProgressDonut: View {
    let habits: [Habit]

    var body: some View {
        let value = averageCompletion(for: habits)
        let percent = Int((value * 100).rounded())

        ZStack {
            // Серый фон-кольцо
            Circle()
                .stroke(
                    Color.gray.opacity(0.2),
                    lineWidth: 20
                )

            // Заполненная часть
            Circle()
                .trim(from: 0, to: value) // 0...1
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            Color.blue,
                            Color.purple
                        ]),
                        center: .center
                    ),
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)) // чтобы начиналось сверху
                .animation(.easeOut(duration: 0.4), value: value)

            // Текст в центре
            VStack(spacing: 4) {
                Text("\(percent)%")
                    .font(.system(size: 28, weight: .bold))
                Text("Average")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 140, height: 140) // размер диаграммы
    }
}