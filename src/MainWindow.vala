
namespace ColorPicker {
    
    public class ColorPickerWindow: Gtk.Dialog {
            
        ExtRGBA ext_active_color = ExtRGBA ();
                
        public ColorPickerWindow (Gtk.Application application) {
            Object (application: application,
                icon_name: "com.github.jeysonflores.lightning",
                    title: _("Color Picker"),
                    width_request: 500
            );
        }        
        
        construct {
            // main box                          
            
            var pick_color_button = new Gtk.Button.with_label ("Pickea");
            pick_color_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);         
            // TODO Just icon or text is displyed, but not both
            // pick_color_button.set_image (new Gtk.Image.from_icon_name ("gtk-color-picker", Gtk.IconSize.BUTTON));            
            
            pick_color_button.show();
            var window_x = settings.window_x;
            var window_y = settings.window_y;
            
            if (window_x != -1 ||  window_y != -1) {
              move (window_x, window_y);
            }
            
            var format_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);          
            format_box.pack_start (pick_color_button);
            
            var content_box = get_content_area () as Gtk.Box; 		
    		content_box.pack_start (format_box);  
                		    		    		    		        
    		// activate color picker    
            pick_color_button.clicked.connect (() => {
                var mouse_position = new ColorPicker.Widgets.Picker ();
                mouse_position.show_all ();
                
                mouse_position.moved.connect ((t, color) => {
                    var ext_color = (ExtRGBA) color;
                    //printf("%s", ext_color.to_uppercase_hex_string ());
                    print("Se mueve");
                });                

                mouse_position.cancelled.connect (() => {
                    print("Cancelado");
                    mouse_position.close ();
                    this.present ();
                });

                //var win = mouse_position.get_window ();

                mouse_position.picked.connect ((t, color) => {
                    ext_active_color = (ExtRGBA) color;
                    //printf("%s", ext_active_color.to_uppercase_hex_string ());
                    print("Pickeado");               
                    mouse_position.close ();
                    this.present ();                    
                });
            });
    		
            
            // trigger picker on startup
            this.show.connect(() => {            
                pick_color_button.clicked ();
            });
                                  
            
        }
        
        
        public override bool delete_event (Gdk.EventAny event) {   
            // save window position             
            int root_x, root_y;
            get_position (out root_x, out root_y);
            
            settings.window_x = root_x;
            settings.window_y = root_y;
            
            return false;
        }
        
    }
    
    
} 
