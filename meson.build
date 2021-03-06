project('com.github.jeysonflores.paleta', ['vala', 'c'],
    version: '0.1.2',
    license: 'GPL-3.0'
)

i18n = import('i18n')

gnome = import('gnome')
asresources = gnome.compile_resources(
    'as-resources', 'data/assets.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: 'c'
)

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')


c_args = [
  '-include', 'config.h'
]

executable(
    'com.github.jeysonflores.paleta',
    'src/Paleta.vala',
    'src/MainWindow.vala',
    'src/ExtRGBA.vala',
    'src/Widgets/Picker.vala',
    'src/Widgets/FormatStack.vala',
    'src/Widgets/ColorButton.vala',
    'src/Services/Settings.vala',
    'src/Views/ColorPickerView.vala',
    asresources,
    c_args: c_args,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libhandy-1', version: '>= 0.90.0'),
    ],
    install : true
)

meson.add_install_script('meson/post_install.py')

subdir('data')
subdir('po')
