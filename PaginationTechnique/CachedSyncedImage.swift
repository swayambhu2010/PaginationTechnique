//
//  CachedSyncedImage.swift
//  PaginationTechnique
//
//  Created by Swayambhu BANERJEE on 23/03/26.
//

import SwiftUI

struct CachedAsyncImage: View {
    
    let urlString: String?
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        
        // ✅ Return cached image immediately — no network call
        if let cached = ImageCache.shared.get(forKey: urlString) {
            self.image = cached
            return
        }
        
        // ✅ Download only if not cached
        isLoading = true
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let downloaded = UIImage(data: data) {
                    // ✅ Store in cache for next time
                    ImageCache.shared.set(downloaded, forKey: urlString)
                    await MainActor.run {
                        self.image = downloaded
                        self.isLoading = false
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
}
