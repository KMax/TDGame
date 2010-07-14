package tdgame.menu.item;

import javafx.scene.Group;
import javafx.scene.control.Button;
import javafx.scene.layout.VBox;
import tdgame.menu.MenuItem;

/**
 * @author Maxim Kolchin
 */
public class gameControls extends MenuItem {

    var playButton: Button = Button {
		text: "Play"
		action: function() {
		    field.play();
		}
	    }
    var pauseButton: Button = Button {
		text: "Pause"
		action: function() {
		    field.pause();
		}
	    }

    override function create() {
	Group {
	    content: [
		VBox {
		    spacing: 5
		    content: bind [
			Button {
			    focusTraversable: false
			    text: "Menu"
			    action: function() {
			    }
			},
			if (field.paused) { playButton } else { pauseButton }
		    ]
		}
	    ]
	}
    }

}
