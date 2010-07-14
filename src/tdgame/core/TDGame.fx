package tdgame.core;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import tdgame.menu.HMenu;
import tdgame.menu.VMenu;
import tdgame.menu.item.gameControls;
import tdgame.menu.item.waveIn;
import tdgame.menu.item.gameParameters;
import tdgame.menu.item.towers;
import tdgame.tower.Sight;

/**
 * @author Maxim Kolchin
 */
public class TDGame extends CustomNode {

    var field: Field;
    var hMenu: HMenu;
    var vMenu: VMenu;
    public var sight: Sight;

    override function create() {
	reset();
	Group {
	    content: [
		VBox {
		    content: [
			HBox {
			    spacing: 5
			    content: [
				field,
				vMenu
			    ]
			},
			hMenu
		    ]
		},
		Group { content: bind sight }
	    ]
	}
    }

    function reset() {
	field = Field {};
	hMenu = HMenu {
		    items: [
			gameControls { field: field }
		    ]
		}
	vMenu = VMenu {
		    items: [
			waveIn { field: field }
			gameParameters { field: field }
			towers {
			    tdgame: this
			    field: field
			}
		    ]
		}
    }

}

