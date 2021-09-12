public class Paleta.Views.ColorPickerView : Gtk.Box {

    public Gtk.Label color_picked_label;
    public Gtk.Button color_picker_button;
    public Paleta.ExtRGBA current_color;


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
        //print (current_color.to_flutter_hex_string ());

        color_picked_label = new Gtk.Label ("") {
            can_focus = false
        };

        color_picked_label.override_background_color(Gtk.StateFlags.NORMAL, current_color);

        color_picked_label.get_style_context ().add_class ("color-picked");

        var format_stack = new Paleta.Widgets.FormatStack ();


        var recent_colors_stack = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        recent_colors_stack.get_style_context ().add_class ("recent-colors");
        var recent_colors = new Gtk.Label ("Recent colors");
        recent_colors.halign = Gtk.Align.START;
        recent_colors.get_style_context ().add_class ("h4");

        var color1 = new Paleta.Widgets.ColorButton (current_color);

        var color2 = new Paleta.Widgets.ColorButton (current_color);

        var color3 = new Paleta.Widgets.ColorButton (current_color);

        var color4 = new Paleta.Widgets.ColorButton (current_color);

        var color5 = new Paleta.Widgets.ColorButton (current_color);

        var color6 = new Paleta.Widgets.ColorButton (current_color);

        var colors = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
        colors.pack_start (color1, false, false, 0);
        colors.pack_start (color2, false, false, 0);
        colors.pack_start (color3, false, false, 0);
        colors.pack_start (color4, false, false, 0);
        colors.pack_start (color5, false, false, 0);
        colors.pack_start (color6, false, false, 0);
        recent_colors_stack.pack_start (recent_colors, false, false, 0);
        recent_colors_stack.pack_start (colors, false, false, 0);

        var prueba = new Paleta.Widgets.ColorButton (current_color);

        color_picker_button.clicked.connect (() => {
            var mouse_position = new Paleta.Widgets.Picker ();
            mouse_position.show_all ();
            
            mouse_position.moved.connect ((t, color) => {
                var ext_color = (ExtRGBA) color;
                //printf("%s", ext_color.to_uppercase_hex_string ());
            });                

            mouse_position.cancelled.connect (() => {
                mouse_position.close ();
            });

            //var win = mouse_position.get_window ();

            mouse_position.picked.connect ((t, color) => {
                var ext_active_color = (ExtRGBA) color;
                //printf("%s", ext_active_color.to_uppercase_hex_string ());
                color_picked_label.override_background_color(Gtk.StateFlags.NORMAL, ext_active_color);           
                mouse_position.close ();
            });
        });


        pack_start (color_picked_label, false, false, 0);
        pack_start (color_picker_button, false, false, 0);
        pack_start (format_stack, false, false, 0);
        pack_start (recent_colors_stack, false, false, 0);


    }
}