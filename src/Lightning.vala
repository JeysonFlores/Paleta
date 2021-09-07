
namespace Lightning {

    public Lightning.Services.Settings settings;
    
    public class Application : Granite.Application {
        
        public Application () {
            Object (application_id: "com.github.jeysonflores.lightning",
            flags: ApplicationFlags.FLAGS_NONE);
        }
        
        protected override void activate () {
            if (get_windows ().length () > 0) {
                get_windows ().data.present ();
                return;
            }
            
            settings = Lightning.Services.Settings.get_instance ();
            
            var app_window = new MainWindow (this);
            
            app_window.show_all ();

            var quit_action = new SimpleAction ("quit", null);
            
            add_action (quit_action);

            set_accels_for_action ("app.quit", {"<Control>q"});

            quit_action.activate.connect (() => {
                if (app_window != null) {
                    app_window.destroy ();
                }
            });

            var granite_settings = Granite.Settings.get_default ();
            var gtk_settings = Gtk.Settings.get_default ();

            var css_provider = new Gtk.CssProvider ();

            if (granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK)
                css_provider.load_from_resource ("/com/github/jeysonflores/lightning/style-dark.css");
            else
                css_provider.load_from_resource ("/com/github/jeysonflores/lightning/style.css");

            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );

            gtk_settings.gtk_application_prefer_dark_theme = (
                granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
            );

            granite_settings.notify["prefers-color-scheme"].connect (() => {
                gtk_settings.gtk_application_prefer_dark_theme = (
                    granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
                );

                if (granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK)
                    css_provider.load_from_resource ("/com/github/jeysonflores/lightning/style-dark.css");
                else
                    css_provider.load_from_resource ("/com/github/jeysonflores/lightning/style.css");

                Gtk.StyleContext.add_provider_for_screen (
                    Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
                );
            });
        }
        
        
                
        public static int main (string[] args) {
            
            var app = new Application ();
            
            return app.run(args);   
        }
    }
}
