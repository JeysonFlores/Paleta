public class Paleta.MainWindow: Hdy.Window {
        
    ExtRGBA ext_active_color = ExtRGBA ();
    private Hdy.Deck deck;
            
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            height_request: 560,
            width_request: 312,
            resizable: false
        );
    }        
    
    construct {

        Hdy.init ();

        get_style_context ().add_class("background-mode");

        deck = new Hdy.Deck () {
            can_swipe_back = true,
            can_swipe_forward = true,
            vhomogeneous = true,
            hhomogeneous = true,
            expand = true,
            transition_type = Hdy.DeckTransitionType.SLIDE
        };


        var icon_mode = new Granite.Widgets.ModeButton ();
        icon_mode.append_icon ("ionicons-eyedrop-symbolic", Gtk.IconSize.BUTTON);
        //icon_mode.append_icon ("feathericons-hash-symbolic", Gtk.IconSize.BUTTON);
        icon_mode.append_icon ("ionicons-contrast-symbolic", Gtk.IconSize.BUTTON);
        //icon_mode.append_icon ("ionicons-color-filter-symbolic", Gtk.IconSize.BUTTON);
        //icon_mode.append_icon ("ionicons-albums-symbolic", Gtk.IconSize.BUTTON);
        //icon_mode.append_icon ("ionicons-cube-symbolic", Gtk.IconSize.BUTTON);
        //icon_mode.append_icon ("ionicons-options-symbolic", Gtk.IconSize.BUTTON);
        //icon_mode.append_icon ("java-symbolic", Gtk.IconSize.BUTTON);
        icon_mode.set_active (0);
        icon_mode.can_focus = false;
        icon_mode.get_style_context ().remove_class("linked");

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

        var label2 = new Gtk.Button.with_label ("Contrast Content");
        var label3 = new Gtk.Label ("Collections Content");
        var label4 = new Gtk.Label ("Settings Content");

        ext_active_color.parse ("#FFFF00");
                                    
        label2.clicked.connect (() => {
            int width, height, x, y;

		    get_size (out width, out height);

            print(width.to_string());
            print("\n");
            print(height.to_string());
        });
        /*var as = ExtRGBA ();
        as.parse ("#00FF00");
        var color_area = new Gtk.Label ("");
        color_area.override_background_color(Gtk.StateFlags.NORMAL, as);*/

        var color_picker_view = new Paleta.Views.ColorPickerView ();

        deck.add (color_picker_view);
        deck.add (label2);
        //deck.add (label3);
       // deck.add (label4);
        deck.visible_child = color_picker_view;

        deck.notify["visible-child"].connect (() => {
            if (!deck.transition_running) {
                if(deck.visible_child == color_picker_view)
                    icon_mode.set_active (0);

                if(deck.visible_child == label2)
                    icon_mode.set_active (1);

                if(deck.visible_child == label3)
                    icon_mode.set_active (2);

                if(deck.visible_child == label4)
                    icon_mode.set_active (3);
            }
        });

        deck.notify["transition-running"].connect (() => {
            if (!deck.transition_running) {
                if(deck.visible_child == color_picker_view)
                    icon_mode.set_active (0);

                if(deck.visible_child == label2)
                    icon_mode.set_active (1);

                if(deck.visible_child == label3)
                    icon_mode.set_active (2);

                if(deck.visible_child == label4)
                    icon_mode.set_active (3);
            }
        });

        icon_mode.mode_changed.connect ((widget) => {
            if(icon_mode.selected == 0)
                deck.visible_child = color_picker_view;

            if(icon_mode.selected == 1)
                deck.visible_child = label2;

            if(icon_mode.selected == 2)
                deck.visible_child = label3;

            if(icon_mode.selected == 3)
                deck.visible_child = label4;
        });

        //var format_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);          
        //format_box.pack_start (pick_color_button);
        //format_box.pack_start(deck);
        //format_box.homogeneous = true;
        
        grid.add (header);
        grid.add (deck);

        add (grid);  
                                                                
        // activate color picker    
        pick_color_button.clicked.connect (() => {
            var mouse_position = new Paleta.Widgets.Picker ();
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
                          
    }
    
    /*public void swipe_navigation() {
        if (!deck.transition_running) {
            if(deck.visible_child == label1)
                icon_mode.set_active (0);

            if(deck.visible_child == label2)
                icon_mode.set_active (1);

            if(deck.visible_child == label3)
                icon_mode.set_active (2);

            if(deck.visible_child == label4)
                icon_mode.set_active (3);
        }
    } */
    
    public override bool delete_event (Gdk.EventAny event) {   
        // save window position             
        int root_x, root_y;
        get_position (out root_x, out root_y);
        
        settings.window_x = root_x;
        settings.window_y = root_y;
        
        return false;
    }
}