//
//  AddingBooksData.swift
//  addingBooksData
//
//  Created by Adii I on 12/06/24.
//
import SwiftUI
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class Coordinator: NSObject, UIDocumentPickerDelegate {
    var parent: AddingBooksData

    init(parent: AddingBooksData) {
        self.parent = parent
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            return
        }
        parent.handleFileSelection(url: selectedFileURL)
    }
}


struct DocumentPicker: UIViewControllerRepresentable {
    var parent: AddingBooksData

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: parent)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.item], asCopy: true)
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {}
}


struct AddingBooksData: View {
    @State private var showDocumentPicker = false
    @State private var csvData: [[String]] = []

    var body: some View {
        NavigationStack {
            VStack {
                if csvData.isEmpty {
                    Text("No data loaded")
                        .padding()
                } else {
                    List {
                        ForEach(0..<csvData.count, id: \.self) { rowIndex in
                            HStack {
                                ForEach(csvData[rowIndex], id: \.self) { column in
                                    Text(column)
                                        .padding(5)
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("Add Books")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showDocumentPicker = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker(parent: self)
            }
        }
    }

    func handleFileSelection(url: URL) {
        do {
            let content = try String(contentsOf: url)
            csvData = readCSV(inputString: content, separator: ",")
        } catch {
            csvData = [["Failed to read file content: \(error.localizedDescription)"]]
        }
    }
    
    func readCSV(inputString: String, separator: String) -> [[String]] {
        let rows = inputString.components(separatedBy: .newlines)
        return rows.map { $0.components(separatedBy: separator) }
    }
}

#Preview {
    AddingBooksData()
}
