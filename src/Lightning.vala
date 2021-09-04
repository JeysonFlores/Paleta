
namespace ColorPicker {

    public ColorPicker.Services.Settings settings;
    
    public class ColorPickerApp : Granite.Application {
        
        public ColorPickerApp () {
            Object (application_id: "com.github.jeysonflores.lightning",
            flags: ApplicationFlags.FLAGS_NONE);
        }
        
        protected override void activate () {
            if (get_windows ().length () > 0) {
                get_windows ().data.present ();
                return;
            }
            
            settings = ColorPicker.Services.Settings.get_instance ();
            
            var app_window = new ColorPickerWindow (this);
            
            app_window.show_all ();

            var quit_action = new SimpleAction ("quit", null);
            
            add_action (quit_action);

            set_accels_for_action ("app.quit", {"<Control>q"});

            quit_action.activate.connect (() => {
                if (app_window != null) {
                    app_window.destroy ();
                }
            });
        }
        
        
                
        public static int main (string[] args) {
            
            var app = new ColorPickerApp ();
            
            return app.run(args);   
        }
    }
}
