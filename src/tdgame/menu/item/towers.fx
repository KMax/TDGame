package tdgame.menu.item;

import tdgame.menu.MenuItem;
import javafx.scene.layout.VBox;
import javafx.scene.control.Label;
import javafx.scene.Node;
import tdgame.core.Tower;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import tdgame.tower.Gun;
import javafx.geometry.Insets;
import tdgame.core.TDGame;
import javafx.geometry.Point2D;
import tdgame.tower.Sight;

/**
 * @author Maxim Kolchin
 */
public class towers extends MenuItem {

    public var tdgame: TDGame;
    var selected: Tower;
    var info: Node;
    var towers: Node[] = [
		createTowerNode(Gun {}),
		createTowerNode(Gun {}),
		createTowerNode(Gun {})
	    ];

    override function create() {
	Group {
	    content: [
		VBox {
		    spacing: 5
		    content: [
			VBox {
			    //padding: Insets{left: 5 }
			    spacing: 5
			    content: [
				towers
			    ]
			},
			info = VBox {
				    padding: Insets { left: 5 }
				    visible: false;
				    content: [
					Label {
					    text: bind "Name: {selected.name}"
					},
					Label {
					    text: bind "Cost: ${selected.cost}"
					},
					Label {
					    text: bind "Radius: {selected.fireRadius}"
					},
					Label {
					    text: bind "Power: {selected.firePower}"
					},
					Label {
					    text: bind "Rate: {selected.fireRate}ms"
					}
				    ]
				}
		    ]
		}
	    ]
	}
    }

    function createTowerNode(t: Tower): Node {
	return Group {
		    content: [
			t.node,
		    ]
		    onMouseEntered: function(e: MouseEvent): Void {
			info.visible = true;
			selected = t;
		    }
		    onMouseExited: function(e: MouseEvent): Void {
			info.visible = false;
		    },
		    onMouseDragged: function(e: MouseEvent): Void {
			def x = e.dragX + e.dragAnchorX;
			def y = e.dragY + e.dragAnchorY;
			tdgame.sight = Sight {
				    field: field;
				    smallRadius: t.towerRadius;
				    bigRadius: t.fireRadius;
				    centerX: bind x;
				    centerY: bind y;
				};
		    }
		    onMouseReleased: function(e: MouseEvent): Void {
			var newTower: Tower;
			if (t instanceof Gun) {
			    newTower = Gun {};
			}
			if (tdgame.sight.isAddingAllowed()) {
			    newTower.position = field.parentToLocal(
				    Point2D {
					x: tdgame.sight.centerX - newTower.towerRadius;
					y: tdgame.sight.centerY - newTower.towerRadius;
				    });
			    java.lang.System.out.println("centerX: {
			    newTower.position.x} centerY: {newTower.position.y}");
			    field.add(newTower);
			}
			tdgame.sight = null;
		    }
		};

    }

}
