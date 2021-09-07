
public class Lightning.Widgets.FormatStack : Gtk.Box {

    private Granite.Widgets.ModeButton navigation;
    private Gtk.Stack stack;
    private Gtk.Button copy_button;
    public Lightning.ExtRGBA current_color;

    public FormatStack () {
        Object(
            orientation: Gtk.Orientation.VERTICAL
        );
    }

    construct {

        navigation = new Granite.Widgets.ModeButton ();
        navigation.append_icon ("css-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("ionicons-color-filter-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("ionicons-cube-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("java-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("android-symbolic", Gtk.IconSize.BUTTON);
        navigation.append_icon ("flutter-symbolic", Gtk.IconSize.BUTTON);
        navigation.set_active (0);
        navigation.can_focus = false;
        navigation.get_style_context ().remove_class("linked");
        navigation.get_style_context ().add_class("formatbox-nav");

        stack = new Gtk.Stack ();

        var hex_label = new Gtk.Label ("#3F92AA");
        hex_label.get_style_context ().add_class ("h4");
        var rgb_label = new Gtk.Label ("rgb(211, 32, 128)");
        var gdk_label = new Gtk.Label ("Gdk.RGBA(211, 32, 128, 1)");
        var java_label = new Gtk.Label ("new Color(211, 32, 128)");

        stack.add_titled (hex_label, "Hex", "Hex");
        stack.add_titled (rgb_label, "RGB", "RGB");
        stack.add_titled (gdk_label, "GDK", "GDK");
        stack.add_titled (java_label, "Java", "Java");
        stack.get_style_context ().add_class ("formatbox-stack");

        copy_button = new Gtk.Button.from_icon_name ("edit-copy-symbolic", Gtk.IconSize.BUTTON) {
            can_focus = false
        };
        copy_button.get_style_context ().add_class ("formatbox-copybutton");

        var content_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        content_box.pack_start (stack, false, false, 0);
        content_box.pack_start (copy_button, false, false, 0);
        content_box.get_style_context ().add_class("formatbox-content");
        

        pack_start (navigation, false, false, 0);
        pack_start (content_box, false, false, 0);

        get_style_context ().add_class ("formatbox");
        get_style_context ().add_class ("card");
    }
}
