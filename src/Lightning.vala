
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
        }
        
        
                
        public static int main (string[] args) {
            
            var app = new Application ();
            
            return app.run(args);   
        }
    }
}
