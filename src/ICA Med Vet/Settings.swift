import WebKit

struct Cookie {
    var name: String
    var value: String
}

let gcmMessageIDKey = "00000000000" // update this with actual ID if using Firebase 

// URL for first launch
let rootUrl = URL(string: "https://icamedvet.com.br/app")!

// allowed origin is for what we are sticking to pwa domain
// This should also appear in Info.plist
let allowedOrigins: [String] = ["icamedvet.com.br"]

// auth origins will open in modal and show toolbar for back into the main origin.
// These should also appear in Info.plist
let authOrigins: [String] = []
// allowedOrigins + authOrigins <= 10

let platformCookie = Cookie(name: "app-platform", value: "iOS App Store")

// UI options
let displayMode = "standalone" // standalone / fullscreen.
let adaptiveUIStyle = true     // iOS 15+ only. Change app theme on the fly to dark/light related to WebView background color.
let overrideStatusBar = false   // iOS 13-14 only. if you don't support dark/light system theme.
let statusBarTheme = "dark"    // dark / light, related to override option.
let pullToRefresh = true    // Enable/disable pull down to refresh page

// Guideline 3.1.1 — bloqueia rotas de compra/assinatura dentro do WebView (App Store).
let blockedSubscriptionPathPatterns: [String] = [
    "/checkout",
    "/cart",
    "/carrinho",
    "/pagamento",
    "/payment",
    "/assinatura",
    "/assinaturas",
    "/subscribe",
    "/subscription",
    "/planos",
    "/plano/",
    "add-to-cart",
    "add_to_cart",
    "woocommerce/checkout"
]

func isBlockedSubscriptionURL(_ url: URL) -> Bool {
    let path = url.path.lowercased()
    let query = (url.query ?? "").lowercased()
    let combined = "\(path)?\(query)"
    return blockedSubscriptionPathPatterns.contains { combined.contains($0) }
}
