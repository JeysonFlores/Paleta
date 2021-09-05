public class Lightning.MainWindow: Hdy.Window {
        
    ExtRGBA ext_active_color = ExtRGBA ();
    private Hdy.Deck deck;
            
    public MainWindow (Gtk.Application application) {
        Object (application: application);
    }        
    
    construct {

        Hdy.init ();

        deck = new Hdy.Deck () {
            can_swipe_back = true,
            can_swipe_forward = true,
            vhomogeneous = true,
            hhomogeneous = true
        };


        var icon_mode = new Granite.Widgets.ModeButton ();
        icon_mode.append_icon ("view-grid-symbolic", Gtk.IconSize.BUTTON);
        icon_mode.append_icon ("view-list-symbolic", Gtk.IconSize.BUTTON);
        icon_mode.append_icon ("view-column-symbolic", Gtk.IconSize.BUTTON);
        icon_mode.set_active (0);
        icon_mode.can_focus = false;

        var header = new Hdy.HeaderBar ();
        header.decoration_layout = "close:";
        header.has_subtitle = false;
        header.show_close_button = true;
        header.custom_title = icon_mode;
        header.can_focus = false;

        var header_context = header.get_style_context ();
        header_context.add_class ("flat");

        var grid = new Gtk.Grid ();
        grid.column_homogeneous = true;
        grid.expand = true;
        grid.orientation = Gtk.Orientation.VERTICAL;

        var pick_color_button = new Gtk.Button.with_label ("Pickea");
        pick_color_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);         
        pick_color_button.visible = false;

        var window_x = settings.window_x;
        var window_y = settings.window_y;
        
        if (window_x != -1 ||  window_y != -1) {
            move (window_x, window_y);
        }

        var label1 = new Gtk.Label ("Hola 1");
        var label2 = new Gtk.Label ("Hola 2");
        
        deck.add (label1);
        deck.add (label2);
        deck.visible_child = label1;

        deck.child_switched.connect((index, duration) => {
            stdout.printf("Se cambió");
            //icon_mode.set_active ((int) index);
        });

        var format_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);          
        //format_box.pack_start (pick_color_button);
        format_box.pack_start(deck);
        format_box.homogeneous = true;
        
        grid.add (header);
        grid.add (format_box);

        add (grid);  
                                                                
        // activate color picker    
        pick_color_button.clicked.connect (() => {
            var mouse_position = new Lightning.Widgets.Picker ();
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