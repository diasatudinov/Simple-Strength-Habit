enum HabitPeriod: String, CaseIterable, Identifiable {
    case day = "Day"
    case month = "Month"
    
    var id: String { rawValue }
}

struct PeriodTabView: View {
    @Binding var selection: HabitPeriod
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(HabitPeriod.allCases) { period in
                Button {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        selection = period
                    }
                } label: {
                    Text(period.rawValue)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            Group {
                                if selection == period {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.tabBar) // твой цвет активного таба
                                } else {
                                    Color.clear
                                }
                            }
                        )
                        .foregroundColor(selection == period ? .white : .text) // свои цвета
                }
                .buttonStyle(.plain)
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.cellBg) // фон всего сегмента
        )
    }
}