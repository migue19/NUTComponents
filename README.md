# NUTComponents

[![CI Status](https://img.shields.io/travis/migue19/NUTComponents.svg?style=flat)](https://travis-ci.org/migue19/NUTComponents)
[![Version](https://img.shields.io/cocoapods/v/NUTComponents.svg?style=flat)](https://cocoapods.org/pods/NUTComponents)
[![License](https://img.shields.io/cocoapods/l/NUTComponents.svg?style=flat)](https://cocoapods.org/pods/NUTComponents)
[![Platform](https://img.shields.io/cocoapods/p/NUTComponents.svg?style=flat)](https://cocoapods.org/pods/NUTComponents)

Una colección de componentes UI reutilizables para iOS que incluye botones personalizados, extensiones de teclado y utilidades para mejorar la experiencia del usuario.

## Características

- 🎨 **NUTMaterialButton**: Botón con Material Design (elevación, ripple effect, animaciones)
- ⌨️ **NUTKeyboard Extensions**: Extensiones para manejar el teclado automáticamente
- 🎯 **UIButton Extensions**: Propiedades IBInspectable para personalizar botones fácilmente

## Tabla de Contenidos

- [Installation](#installation)
- [Components](#components)
  - [NUTMaterialButton](#nutmaterialbutton)
  - [UIButton Extensions](#uibutton-extensions)
  - [Keyboard Extensions](#keyboard-extensions)
- [Requirements](#requirements)
- [Example](#example)
- [Author](#author)
- [License](#license)

## Installation

NUTComponents está disponible a través de [CocoaPods](https://cocoapods.org). Para instalarlo, simplemente agrega la siguiente línea a tu Podfile:

```ruby
pod 'NUTComponents'
```

Luego ejecuta:

```bash
pod install
```

## Components

### NUTMaterialButton

Un botón personalizado que implementa Material Design con efectos visuales avanzados.

#### Características:

- ✨ Efecto Ripple animado al tocar
- 🌊 Elevación con sombra dinámica
- 📐 Esquinas redondeadas personalizables
- 🎨 Colores configurables desde Interface Builder
- 💫 Animaciones suaves de presión

#### Uso en Código:

```swift
import NUTComponents

let button = NUTMaterialButton()
button.elevation = 4.0
button.cornerRadius = 8.0
button.backgroundLayerColor = .systemBlue
button.rippleColor = UIColor(white: 1.0, alpha: 0.3)
button.enableRipple = true
button.setTitle("Material Button", for: .normal)
button.setTitleColor(.white, for: .normal)
```

#### Uso en Interface Builder:

1. Arrastra un `UIButton` a tu vista
2. En **Identity Inspector**, cambia la clase a `NUTMaterialButton`
3. En **Attributes Inspector**, configura las propiedades:
   - `elevation`: Altura de la sombra (default: 2.0)
   - `cornerRadius`: Radio de las esquinas (default: 4.0)
   - `rippleColor`: Color del efecto ripple
   - `backgroundLayerColor`: Color de fondo del botón
   - `enableRipple`: Activar/desactivar efecto ripple

#### Métodos Públicos:

```swift
// Cambiar elevación con animación
button.setElevation(6.0, animated: true)
```

### UIButton Extensions

Extensiones para `UIButton` que agregan propiedades IBInspectable para personalización rápida.

#### Propiedades Disponibles:

```swift
@IBInspectable var normalBorder: Bool
@IBInspectable var borderWidth: CGFloat
@IBInspectable var cornerRadius: CGFloat
@IBInspectable var borderColor: UIColor?
```

#### Ejemplo de Uso:

```swift
// En código
button.cornerRadius = 10.0
button.borderWidth = 2.0
button.borderColor = .systemBlue
button.normalBorder = true // Hace el botón circular (altura/2)
```

O simplemente configúralas en Interface Builder en el panel de **Attributes Inspector**.

### Keyboard Extensions

Extensiones para manejar automáticamente el teclado en tus vistas.

#### UITextField Extension

Agrega un botón "Hecho" en la barra de accesorios del teclado.

```swift
import NUTComponents

// En código
textField.addDoneButtonOnKeyboard()

// En Interface Builder
// Activa la propiedad IBInspectable "doneAccessory" en el Attributes Inspector
```

#### UITextView Extension

Igual que UITextField, agrega un botón "Hecho" en el teclado.

```swift
textView.addDoneButtonOnKeyboard()
```

#### UISearchBar Extension

Agrega un botón "Hecho" en el teclado del SearchBar.

```swift
searchBar.addDoneButtonOnKeyboard()
```

#### UIViewController Extension

Manejo automático del teclado con ajuste de vista y dismiss al tocar fuera.

```swift
class MyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Activar manejo automático del teclado
        // dismissOnTap: true para cerrar el teclado al tocar fuera
        self.RGDoneKeyboard(dismissOnTap: true)
    }
}
```

**Características:**

- ✅ Ajusta automáticamente la vista cuando aparece el teclado
- ✅ Evita que el teclado tape los campos de texto
- ✅ Cierra el teclado al tocar fuera de los campos (si dismissOnTap: true)
- ✅ Detecta automáticamente UITextField y UITextView
- ✅ Restaura la vista al cerrar el teclado

**Notas Importantes:**

- El método configura observers del teclado automáticamente
- La vista se ajusta solo si el campo de texto quedaría oculto por el teclado
- Incluye un margen de 8 puntos para mejor visualización

## Requirements

- iOS 11.0+
- Swift 5.0+
- Xcode 12.0+

## Example

Para ejecutar el proyecto de ejemplo:

1. Clona el repositorio
2. Navega a la carpeta `Example`
3. Ejecuta `pod install`
4. Abre `NUTComponents.xcworkspace`
5. Ejecuta el proyecto

### Ejemplo Completo:

```swift
import UIKit
import NUTComponents

class ViewController: UIViewController {
    
    @IBOutlet weak var materialButton: NUTMaterialButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar Material Button
        materialButton.elevation = 4.0
        materialButton.cornerRadius = 8.0
        materialButton.backgroundLayerColor = .systemBlue
        
        // Agregar botón "Hecho" al teclado
        textField.addDoneButtonOnKeyboard()
        textView.addDoneButtonOnKeyboard()
        
        // Activar manejo automático del teclado
        self.RGDoneKeyboard(dismissOnTap: true)
    }
}
```

## Author

**Miguel Mexicano Herrera**
- Email: miguelmexicano18@gmail.com
- GitHub: [@migue19](https://github.com/migue19)

## License

NUTComponents is available under the MIT license. See the LICENSE file for more info.

---

Made with ❤️ by NutSystems
