/*
 * Copyright (C) 2015 - Holy Lobster
 *
 * Nuntius is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * Nuntius is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Nuntius. If not, see <http://www.gnu.org/licenses/>.
 */

namespace Nuntius {

/* Just a temporary UI to send actions, this should go in the main UI */
public class TestSmsView : Gtk.Window {

    SmsNotification sms_notification;

    public TestSmsView(SmsNotification sms_notification) {
        this.sms_notification = sms_notification;

        // Sets the title of the Window:
        this.title = _("Answer to the sms");

        // Center window at startup:
        this.window_position = Gtk.WindowPosition.CENTER;

        // Sets the default size of a window:
        this.set_default_size(500,150);

        // Whether the titlebar should be hidden during maximization.
        this.hide_titlebar_when_maximized = false;

        // Method called on pressing [X]
        this.destroy.connect(() => {
            stdout.printf("Bye!\n");
        });

        Gtk.Box vertical_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        vertical_box.set_margin_left(20);
        vertical_box.set_margin_right(20);
        this.add(vertical_box);

        var label_message = "%s: %s".printf( sms_notification.sender, sms_notification.message);
        var label = new Gtk.Label(label_message);
        label.set_xalign( (float) 0.5);
        vertical_box.pack_start(label, true, true, 0);

        Gtk.Box reply_area = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 10);
        vertical_box.pack_start(reply_area, true, false, 0);

        Gtk.Entry message_entry = new Gtk.Entry();
        message_entry.set_width_chars(40);
		reply_area.add(message_entry);

        var reply_button = new Gtk.Button.with_label("Reply");

        message_entry.activate.connect(() => {
			var str = message_entry.get_text();
			if (str != "") {
                sms_notification.send_sms_message(str);
                destroy();
            }
		});

        reply_button.clicked.connect(() => {
            var str = message_entry.get_text();
            if (str != "") {
                sms_notification.send_sms_message(str);
                destroy();
            }
        });

        reply_area.pack_start(reply_button);
    }
}

}
