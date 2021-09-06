public class Lightning.Views.ColorPickerView : Gtk.Box {

    public Gtk.Label color_picked_label;
    public Gtk.Button color_picker_button;
    public Lightning.ExtRGBA current_color;


    public ColorPickerView () {
        Object(
            orientation: Gtk.Orientation.HORIZONTAL
        );
    }
    
    construct {

        color_picker_button = new Gtk.Button.from_icon_name ("ionicons-eyedrop-symbolic", Gtk.IconSize.BUTTON) {
            can_focus = false
        };

        color_picked_label = new Gtk.Label ("") {
            can_focus = false
        };



    }
}