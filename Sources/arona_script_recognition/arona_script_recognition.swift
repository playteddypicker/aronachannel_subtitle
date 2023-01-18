import Vision
import CoreGraphics
import AppKit

@available(macOS 10.15, *)
func recognizeTextHandler(request: VNRequest, error: Error?) {
    guard let observations =
            request.results as? [VNRecognizedTextObservation] else {
        return
    }
    let recognizedStrings = observations.compactMap { observation in
        // Return the string of the top VNRecognizedText instance.
        return observation.topCandidates(1).first?.string
    }
    
    // Process the recognized strings.
    print(recognizedStrings)
}

@available(macOS 10.15, *)
@main
public struct arona_script_recognition {
    public private(set) var text = "Done"

    public static func main() {
        let image = NSImage(byReferencingFile: "/Users/teddypicker_/coding/arona_script_recognition/images/unkn21own.png")!
        print("\(image.size.width)")
        var imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height);
        let imageRef = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)!;
        print("\(imageRef.height)")
        
        let requestHandler = VNImageRequestHandler(cgImage: imageRef);
        
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)
        request.recognitionLanguages = ["ko", "ch"];

        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        print(arona_script_recognition().text);
    }

}

