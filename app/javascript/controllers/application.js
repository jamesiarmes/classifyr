import { Application } from "@hotwired/stimulus"
import { Autocomplete } from 'stimulus-autocomplete'
import RevealController from 'stimulus-reveal'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Import and register all TailwindCSS Components
import { Alert, Autosave, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('autosave', Autosave)
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('tabs', Tabs)
application.register('popover', Popover)
application.register('toggle', Toggle)
application.register('slideover', Slideover)
application.register('autocomplete', Autocomplete)
application.register('reveal', RevealController)

export { application }
