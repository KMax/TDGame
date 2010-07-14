package tdgame.menu.item;

import javafx.scene.Group;
import javafx.scene.control.Label;
import tdgame.menu.MenuItem;

/**
 * @author Maxim Kolchin
 */
public class waveIn extends MenuItem {
    

    override function create() {
	Group {
	    content: [
		Label {
		    text: bind "Next wave in: {field.timeBeforeWave}"
		}
	    ]
	}
    }

}
