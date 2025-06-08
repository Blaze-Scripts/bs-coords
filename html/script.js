const { createApp } = Vue;

createApp({
    data() {
        return {
            isActive: false,
            isVisible: false,
            position: 'top-right',
            coordInfo: {
                coords: null,
                heading: null,
                vector3: null,
                vector4: null,
                x: null,
                y: null,
                z: null
            },
            showCopyFlash: false,
            copyMessage: '',
            copyTimeout: null
        };
    },
    
    methods: {
        // Format a number to 4 decimal places
        formatNumber(num) {
            if (num === null || num === undefined) return '-';
            return num.toFixed(4);
        },
        
        // Copy text to clipboard
        copyToClipboard(format) {
            let textToCopy = '';
            
            switch (format) {
                case 'vector3':
                    textToCopy = this.coordInfo.vector3;
                    break;
                case 'vector4':
                    textToCopy = this.coordInfo.vector4;
                    break;
                case 'x':
                    textToCopy = this.coordInfo.x?.toFixed(4);
                    break;
                case 'y':
                    textToCopy = this.coordInfo.y?.toFixed(4);
                    break;
                case 'z':
                    textToCopy = this.coordInfo.z?.toFixed(4);
                    break;
                case 'heading':
                    textToCopy = this.coordInfo.heading?.toFixed(4);
                    break;
                default:
                    textToCopy = '';
            }
            
            if (textToCopy) {
                fetch('https://bs-coords/copyToClipboard', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        text: textToCopy,
                        format: format
                    })
                });
            }
        },
        
        // Show copy notification
        showCopyNotification(format) {
            this.copyMessage = `Copied ${format} to clipboard`;
            this.showCopyFlash = true;
            
            if (this.copyTimeout) {
                clearTimeout(this.copyTimeout);
            }
            
            this.copyTimeout = setTimeout(() => {
                this.showCopyFlash = false;
            }, 1500);
        },
        
        // Execute copy to clipboard
        execCopy(text, format) {
            // Use the document.execCommand method which is more compatible with FiveM/RedM NUI
            const textArea = document.createElement('textarea');
            textArea.value = text;
            textArea.style.position = 'fixed';
            textArea.style.left = '-999999px';
            textArea.style.top = '-999999px';
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            
            let success = false;
            try {
                success = document.execCommand('copy');
                if (success) {
                    this.showCopyNotification(format);
                }
            } catch (err) {
                console.error('Failed to copy: ', err);
            }
            
            document.body.removeChild(textArea);
            
            fetch('https://bs-coords/clipboardResult', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    success: success
                })
            });
        }
    },
    
    mounted() {
        // Listen for NUI messages
        window.addEventListener('message', (event) => {
            const data = event.data;
            
            switch (data.type) {
                case 'init':
                    this.isActive = data.active;
                    this.isVisible = data.visible;
                    this.position = data.position;
                    break;
                
                case 'setActive':
                    this.isActive = data.active;
                    if (!data.active) {
                        this.isVisible = false;
                    }
                    break;
                
                case 'setVisible':
                    this.isVisible = data.visible;
                    break;
                
                case 'updateCoords':
                    this.coordInfo = data.info;
                    break;
                
                case 'copyFormat':
                    const format = data.format;
                    let textToCopy = '';
                    
                    switch (format) {
                        case 'vector3':
                            textToCopy = data.info.vector3;
                            break;
                        case 'vector4':
                            textToCopy = data.info.vector4;
                            break;
                        case 'x':
                            textToCopy = data.info.x.toFixed(4);
                            break;
                        case 'y':
                            textToCopy = data.info.y.toFixed(4);
                            break;
                        case 'z':
                            textToCopy = data.info.z.toFixed(4);
                            break;
                        case 'heading':
                            textToCopy = data.info.heading.toFixed(4);
                            break;
                        default:
                            textToCopy = '';
                    }
                    
                    if (textToCopy) {
                        this.execCopy(textToCopy, format);
                    }
                    break;
                
                case 'execCopy':
                    this.execCopy(data.text, data.format);
                    break;
            }
        });
    }
}).mount('#app');
