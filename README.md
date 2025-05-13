# SwiftFrame 

SwiftFrame, Swift dilinde geliştirilen bir veri analizi kütüphanesidir.  
SwiftNum modülü ile NDArray desteği sunar ve Apple Silicon için yüksek performans sağlar.

## Özellikler
-  NDArray: N boyutlu array desteği (reshape, transpose, slicing)
-  Veri analizi: mean, std, pivot, plot
-  Accelerate destekli hızlandırma
-  CSV, JSON, Excel okuma/yazma
-  Pandas benzeri veri çerçevesi: `DataFrame`, `Series`, `query`, `astype`

## Kurulum
```swift
.package(url: "https://github.com/kullaniciadi/SwiftFrame.git", from: "1.0.0")
