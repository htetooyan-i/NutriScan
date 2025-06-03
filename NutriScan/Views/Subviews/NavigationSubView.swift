import SwiftUI
import Vision

struct NavigationSubView: View {
    
    @State private var selectedTab: Tab = .nutrients
    @State private var thumbnails: [String: URL] = [:]
    
    @Binding var foodQuantity: Int
    @Binding var foodWeight: String
    @Binding var foodPrice: Double?
    @Binding var selectedFood: VNClassificationObservation?
    
    @ObservedObject var results: ClassificationModel
    @ObservedObject var nutritionData: NutritionModel
    
    @Binding var totalFoodWeight: String
    @Binding var inputDisable: Bool
    @Binding var newCalories: String
    @Binding var newProtein: String
    @Binding var newFiber: String
    @Binding var newFat: String
    
    @FocusState.Binding var isWeightInputFocused: Bool
    @FocusState.Binding var isPriceInputFocused: Bool
    
    enum Tab {
        case swap, nutrients, weight, price
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                navButton(icon: "arrow.clockwise", label: "Swaps", tab: .swap)
                navButton(icon: "carrot.fill", label: "Nutrients", tab: .nutrients)
                navButton(icon: "dumbbell", label: "Weight", tab: .weight)
                navButton(icon: "dollarsign.circle", label: "Price", tab: .price)
            }
            .cornerRadius(15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            getThumbnails()
        }
        if selectedTab == .nutrients {
            NutritionSubView(
                totalFoodWeight: $totalFoodWeight,
                inputDisable: $inputDisable,
                newCalories: $newCalories,
                newProtein: $newProtein,
                newFiber: $newFiber,
                newFat: $newFat
            )
        } else if selectedTab == .weight { // Show food weight and food quantity input fields
            WeightFormSubView(foodWeight: $foodWeight, foodQuantity: $foodQuantity, isWeightInputFocused: $isWeightInputFocused)
        } else if selectedTab == .price { // Show food price input field
            PriceFormSubView(foodPrice: $foodPrice, inputDisable: $inputDisable, isPriceInputFocused: $isPriceInputFocused)
        } else if selectedTab == .swap { // show preidctions and their confidences to swap slected Food
            if let _ = selectedFood?.identifier { // check shelectedFood is nil or not (In this case it can't be nil)
                SwapSubView(
                    predictions: results.predictions,
                    selectedFood: $selectedFood,
                    thumbnails: thumbnails
                )
            } else {
                Text("No Food Selected")
            }
        }
    }
    
    // MARK: - Tab Button Builder
    func navButton(icon: String, label: String, tab: Tab, color: Color = .white) -> some View {
        Button(action: {
            withAnimation {
                selectedTab = tab
            }
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            generator.impactOccurred()
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(selectedTab == tab ? .primary : .gray)
                if selectedTab == tab {
                    Text(label)
                        .foregroundColor(.primary)
                }
            }
            .frame(minWidth: 25, minHeight: 50)
            .padding(.horizontal, selectedTab == tab ? 16 : 12)
            .background(selectedTab == tab ? Color("PriColor") : Color("DefaultRe"))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    func getThumbnails() {
        for (foodName, nutrition) in nutritionData.nutrientInfo {
            if let thumbnail = nutrition["thumbnail"] as? URL {
                thumbnails[foodName] = thumbnail
            }
        }
    }
    
}
