public class Lightning.Views.ColorPickerView : Gtk.Box {

    public Gtk.Label color_picked_label;
    public Gtk.Button color_picker_button;
    public Lightning.ExtRGBA current_color;


    public ColorPickerView () {
        Object(
            orientation: Gtk.Orientation.VERTICAL
        );
    }
    
    construct {

        color_picker_button = new Gtk.Button () {
            can_focus = false,
            image = new Gtk.Image.from_icon_name ("ionicons-eyedrop-symbolic", Gtk.IconSize.BUTTON),
            always_show_image = true,
            label = "Pick a Color"
        };

        color_picker_button.get_style_context ().add_class ("color-picker-button");

        current_color = ExtRGBA ();
        current_color.parse ("#edb2f7");

        color_picked_label = new Gtk.Label ("") {
            can_focus = false
        };

        color_picked_label.override_background_color(Gtk.StateFlags.NORMAL, current_color);

        color_picked_label.get_style_context ().add_class ("color-picked");

        var format_stack = new Lightning.Widgets.FormatStack ();


        color_picker_button.clicked.connect (() => {
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
            });

            //var win = mouse_position.get_window ();

            mouse_position.picked.connect ((t, color) => {
                var ext_active_color = (ExtRGBA) color;
                //printf("%s", ext_active_color.to_uppercase_hex_string ());
                print("Pickeado");               
                mouse_position.close ();
            });
        });


        pack_start (color_picked_label, false, false, 0);
        pack_start (color_picker_button, false, false, 0);
        pack_start (format_stack, false, false, 0);


    }
}