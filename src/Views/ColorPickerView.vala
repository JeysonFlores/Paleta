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

        color_picker_button = new Gtk.Button.from_icon_name ("ionicons-eyedrop-symbolic", Gtk.IconSize.BUTTON) {
            can_focus = false
        };

        color_picked_label = new Gtk.Label ("") {
            can_focus = false
        };

        var format_stack = new Lightning.Widgets.FormatStack ();

        pack_start (color_picked_label, false, false, 0);
        pack_start (color_picker_button, false, false, 0);
        pack_start (format_stack, false, false, 0);


    }
}