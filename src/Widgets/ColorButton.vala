class Lightning.Widgets.ColorButton : Gtk.Button {

    public ExtRGBA color;

    public ColorButton (ExtRGBA color) {
        Object (
            can_focus: false,
            label: ""
        );

        this.color = color;
        this.override_background_color(Gtk.StateFlags.NORMAL, this.color);
        this.override_background_color(Gtk.StateFlags.ACTIVE, this.color);
    }

    construct {
        get_style_context ().remove_class ("text-button");
        get_style_context ().add_class ("color-button");
    }

}