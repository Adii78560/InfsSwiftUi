import SwiftUI

struct MembershipView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Gold Membership Card
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(red: 146/255, green: 117/255, blue: 41/255))
                    .frame(height: 150)
                    .overlay(
                        VStack {
                            Text("Gold Membership")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 237/255, green: 198/255, blue: 4/255))
                            Text("Joined : DD/MM/YYYY")
                                .foregroundColor(Color(red: 237/255, green: 198/255, blue: 4/255))
                        }
                    )
                    .padding(.horizontal)
                
                // Horizontal Cards for Member Details and Member Card Validity
                HStack(spacing: 5) {
                    // Member Details Card
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Member")
                            .font(.title3)
                            .foregroundColor(.black)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("Drishti Vig")
                            .font(.title2)
                            .foregroundColor(.black)
                        Text("9983879032")
                            .foregroundColor(.gray)
                        Text("Active")
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal, 0)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 241/255, green: 236/255, blue: 215/255)))
                    
                    // Member Card Validity
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Payment due")
                            .font(.title3)
                            .foregroundColor(.black)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("Sep 30")
                            .font(.title2)
                            .foregroundColor(.black)
                        Button(action: {
                            // Action for Pay Early button
                        }) {
                            Text("Pay Early")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                    .padding(27)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 241/255, green: 236/255, blue: 215/255)))
                }
                .padding(.horizontal)
                
                // Perks Card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Perks")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("1. 20% off on all purchases")
                        Text("2. Free shipping on orders over $50")
                        Text("3. Early access to new arrivals")
                        Text("4. Exclusive members-only events")
                        Text("5. Complimentary gift wrapping")
                    }
                    .foregroundColor(.black)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 241/255, green: 236/255, blue: 215/255)))
                .padding(.horizontal) // Apply padding to match other elements
                
                Spacer()
            }
            .navigationTitle("Membership")
        }
    }
}

#Preview {
    MembershipView()
}
