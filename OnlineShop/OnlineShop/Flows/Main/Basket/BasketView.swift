//
//  BasketView.swift
//  OnlineShop
//
//  Created by NikoS on 23.09.2022.
//

import SwiftUI

enum DeliveryMethod: String, CaseIterable, Identifiable {
    case pickup, courier, postOffice
    var id: Self { self }
}

struct BasketView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var userSettings = UserSettings()
    @State var firstName: String = UserSettings().username
    @State var secondName: String = UserSettings().secondname
    @State var address: String = ""
    @State private var selectedDeliveryMethod: DeliveryMethod = .postOffice
    @State private var showingAlert = false
    @State private var promocode = ""
    @State private var phoneNumber = "+38"
    @ObservedObject var viewModel = BasketViewModel()
    var coupons = CouponsViewModel().coupons
    
    var body: some View {
        ZStack {
            if viewModel.items.isEmpty {
                emptyBasket
            } else {
                nonEmptyBasket
            }
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Thanks for choosing our shop"),
                  dismissButton: Alert.Button.default(Text("Back to home"), action: { presentationMode.wrappedValue.dismiss() }))
        }
    }
    var fullPrice: Double {
        return viewModel.items.map({$0.model.price}).reduce(0, +)
    }
    var emptyBasket: some View {
        Text("Your basket is empty")
    }
    var nonEmptyBasket: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.items, id: \.model.id) { item in
                        VStack {
                            Image(item.model.image[0])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .overlay(ButtonOverlay {
                                    viewModel.deleteFromBasket(item)
                                })
                            Text(item.model.title)
                                .frame(maxWidth: 100)
                            Text(NumberFormatter.format(String(item.model.price)))
                        }
                    }
                }
            }
            .padding([.horizontal])
            Form {
                Section(header: Text("Customer's Info")) {
                    TextField(text: $firstName, prompt: Text("First Name")) {
                        Text("")
                    }
                    TextField(text: $secondName, prompt: Text("Second Name")) {
                        Text("")
                    }
                    TextField(text: $address, prompt: Text("Address")) {
                        Text("")
                    }
                    VStack {
                        TextField(text: $phoneNumber, prompt: Text("+38(___) __ __ ___")) {
                            Text("")
                        }
                        .keyboardType(.numberPad)
                        Text(viewModel.phoneNumberPrompt(phoneNumber))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                Section(header: Text("Delivery method")) {
                    Picker("DeliveryMethod", selection: $selectedDeliveryMethod) {
                        Text("Post Office").tag(DeliveryMethod.postOffice)
                        Text("Courier").tag(DeliveryMethod.courier)
                        Text("PickUp").tag(DeliveryMethod.pickup)
                    }
                    .pickerStyle(.segmented)
                }
                TextField(text: $promocode, prompt: Text("Available promocode")) {
                    Text("")
                }
                Section(header: Text("Full price")) {
                    Text(NumberFormatter.format(String(getFormattedPrice())))
                }
            }
            Button("Purchase") {
                guard !firstName.isEmpty, !secondName.isEmpty, !address.isEmpty, viewModel.isValidPhoneNumber(phone: phoneNumber) else { return }
                
                DataStorage.shared.purchases.append(PurchaseViewModel(id: UUID(), model: viewModel.items, deliveryMethod: selectedDeliveryMethod.rawValue, firstName: firstName, secondName: secondName, address: address, fullPrice: getFormattedPrice(), phoneNumber: phoneNumber))
                viewModel.items.forEach { $0.model.inBasket = false }
                showingAlert = true
                coupons.forEach {
                    if promocode == $0.code {
                        $0.isUsed = true
                    }
                }
            }
            .modifier(ProjectButton())
            .padding(.bottom)
        }
        .onAppear {
            UITableView.appearance().isScrollEnabled = false
        }
    }
    
    func getFormattedPrice() -> Double {
        var price = fullPrice
        coupons.forEach {
            if promocode == $0.code && !$0.isUsed {
                price = fullPrice - fullPrice * $0.value / 100
            }
        }
        return price
    }

}


struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView(viewModel: BasketViewModel())
    }
}
