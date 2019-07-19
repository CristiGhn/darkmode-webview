# darkmode-webview
iOS Swift app that loads html inside WKWbView and has a darkmode toggle

Using this [tutorial][1] I implemented the effect with mix-blend-mode: difference.

  [1]: https://dev.to/wgao19/night-mode-with-mix-blend-mode-difference-23lm

Inject multiple WKUserScript in the webiew at document start and document end:

 1. JavaScript file with toggle function at document start
 2. Inject div container with background and blender that will make the blend difference (at document end)
 3. Inside style tags contents of CSS file at document end 

        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        // Libray script an document start
        let darkModeScript = WKUserScript(source: self.darkModeLibraryJS, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(darkModeScript)
        
        let injectDarkModeScript = WKUserScript(source: self.injectDarkModeJS, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(injectDarkModeScript)
        
        let injectCSScript = WKUserScript(source: self.injectCSS, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(injectCSScript)
        
        webConfiguration.userContentController = contentController
        
        self.webview = WKWebView(frame: CGRect.zero, configuration: webConfiguration)
        self.webview?.navigationDelegate = self
        self.view.addSubview(webview!)
        
        self.webview!.loadHTMLString(html, baseURL: nil)


JavaScript with toggle function and inject CSS (darkmode.js)

    function injectCSS(css) {
        head = document.head || document.getElementsByTagName('head')[0],
        style = document.createElement('style');
        head.appendChild(style);
    
        style.type = 'text/css';
        if (style.styleSheet){
             // This is required for IE8 and below.
            style.styleSheet.cssText = css;
        } else {
            style.appendChild(document.createTextNode(css));
        }
     }

     function showDarkMode() {
         var blender = document.getElementById('blender')
         if (blender.hasAttribute("hidden")) {
             blender.removeAttribute("hidden")
         }
      }

     function showOriginalMode() {
         var blender = document.getElementById('blender')
    
         if (!blender.hasAttribute("hidden")) {
             blender.setAttribute("hidden", true)
         }
     }

JavaScript with adding div container to DOM of the webview (inject-darkmode.js)

    var container = document.createElement('div')
    container.id = 'darkmode-container'
    document.body.appendChild(container)

    var background = document.createElement('div')
    background.classList.add('darkmode-background')
    container.appendChild(background)

    var blender = document.createElement('div')
    blender.id = 'blender'
    blender.setAttribute('hidden', true)
    container.appendChild(blender)

CSS for defining blender and background (darkmode.css)

    #blender {
        width: 100vw;
        height: 100vh;
        left: 0pt;
        top: 0pt;
        position: fixed;
        background: white;
        transition: all 1s ease;
        mix-blend-mode: difference;
     }

     img {
         isolation: isolate;
     }

     .darkmode-background {
         position: fixed;
         background: white;
         top: 0;
         left: 0;
         width: 100vw;
         height: 100vh;
         z-index: -1;
     }
