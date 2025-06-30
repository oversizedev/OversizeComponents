# OversizeComponents

A comprehensive SwiftUI components library providing ready-to-use UI components for modern iOS, macOS, tvOS, and watchOS applications. OversizeComponents offers a rich collection of specialized components ranging from basic UI elements to complex interactive components for photos, health, and weather applications.

## Features

### Core Components (OversizeComponents)
- **FolderView** - Customizable folder views with different sizes and states
- **AsyncIllustrationView** - Asynchronous illustration loading from CDN with caching
- **WebView** - Web content display and interaction
- **ActivityViewController** - iOS activity sharing functionality
- **NoteEditor** - Rich text note editing interface
- **SelectableSurface** - Interactive selectable UI surfaces
- **ScreenMockup** - Device screen mockups for presentations
- **CalendarMonthView** - Comprehensive calendar component with month navigation
- **MailView** - Email composition interface for iOS
- **ImagePicker** - Image selection and picking functionality
- **LocationPicker** - Map-based location selection with search
- **PhoneSheet** - Phone call interface and dialing
- **CurrencyPicker** - Currency selection with international support
- **FieldScreenView** - Form field screens and input validation
- **FloatingTabBar** - Modern floating tab bar implementation
- **MapView** - Interactive map display and location handling
- **RatingPickerView** - Star rating and review input
- **IconNamePicker** - System icon selection interface
- **SortingPicker** - Customizable sorting options

### Photo Components (OversizePhotoComponents)
- **ImageGridView** - Grid layout for image collections
- **PhotosFieldView** - Photo input fields with validation
- **AvatarPicker** - Avatar image selection and cropping
- **GalleryPicker** - Full-featured photo gallery picker
- **CameraView** - Camera capture interface
- **PhotoShowView** - Photo display with zoom and navigation
- **MediaPickerView** - Universal media selection interface

### Health Components (OversizeHealthComponents)
- **BMIView** - BMI calculation and health metrics display

### Weather Components (OversizeWeatherComponents)
- **DayFullRowView** - Detailed daily weather display
- **DayShortRowView** - Compact daily weather view
- **DayColumnView** - Vertical weather layout
- **WeatherBackgroundView** - Dynamic weather-based backgrounds

## Platform Support

- **iOS** 15.0+
- **macOS** 14.0+
- **tvOS** 16.0+
- **watchOS** 9.0+

## Package Structure

OversizeComponents is organized into four specialized modules:

1. **OversizeComponents** - Core UI components and utilities
2. **OversizePhotoComponents** - Photo and media handling components
3. **OversizeHealthComponents** - Health and fitness related components
4. **OversizeWeatherComponents** - Weather display and visualization components

## Installation

### Swift Package Manager

Add OversizeComponents to your project using Xcode or by adding it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/oversizedev/OversizeComponents.git", from: "1.0.0")
]
```

Then import the modules you need:

```swift
import OversizeComponents
import OversizePhotoComponents
import OversizeHealthComponents
import OversizeWeatherComponents
```

## Usage Examples

### Basic Components

```swift
import SwiftUI
import OversizeComponents

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var noteText = ""
    
    var body: some View {
        VStack {
            // Folder view with custom content
            FolderView(size: .large) {
                Text("Documents")
                    .font(.caption)
            }
            
            // Async illustration loading
            AsyncIllustrationView("welcome-illustration")
                .frame(height: 200)
            
            // Note editor
            NoteEditor("My Notes", text: $noteText)
                .frame(height: 150)
        }
    }
}
```

### Photo Components

```swift
import SwiftUI
import OversizePhotoComponents

struct PhotoView: View {
    @State private var selectedImages: [UIImage] = []
    @State private var avatar: UIImage?
    
    var body: some View {
        VStack {
            // Avatar picker
            AvatarPicker(avatar: $avatar)
            
            // Photo grid display
            ImageGridView(
                selectedImages.map { Image(uiImage: $0) },
                columnCount: .constant(3)
            )
        }
    }
}
```

### Location and Map Components

```swift
import SwiftUI
import OversizeComponents
import CoreLocation

struct LocationView: View {
    @State private var coordinates = CLLocationCoordinate2D()
    @State private var locationName: String?
    
    var body: some View {
        VStack {
            // Location picker with map
            LocationPicker(
                label: "Choose Location",
                coordinates: $coordinates,
                positionName: $locationName
            )
            
            // Map preview
            MapPreviewView(coordinate: coordinates)
                .frame(height: 200)
        }
    }
}
```

### Calendar Component

```swift
import SwiftUI
import OversizeComponents

struct CalendarView: View {
    @State private var selectedMonth = Date()
    
    var body: some View {
        CalendarMonthView(selectedMonth: $selectedMonth) { date in
            Text("\(Calendar.current.component(.day, from: date))")
                .font(.system(size: 16))
                .foregroundColor(.primary)
        }
    }
}
```

## Requirements

- Swift 6.0+
- Xcode 16.4+
- iOS Deployment Target: 15.0+
- macOS Deployment Target: 14.0+
- tvOS Deployment Target: 16.0+
- watchOS Deployment Target: 9.0+

## License

OversizeModels is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

---

<div align="center">

**Made with ❤️ by the Oversize**

</div>
