package tdgame.core;

import javafx.scene.CustomNode;
import javafx.scene.shape.Path;
import tdgame.resource.Resources;
import javafx.scene.Node;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import javafx.scene.Group;
import javafx.geometry.Bounds;
import tdgame.util.PathUtil;
import javafx.geometry.Point2D;
import javafx.scene.input.MouseEvent;

/**
 * @author Maxim Kolchin
 */
public class Field extends CustomNode {

    public-read var totalWaves: Integer = 8;
    public-read var cost: Integer = 0;
    public-read var kills: Integer = 0;
    public-read var timeBeforeWave: Integer = 20;
    public-read var path: Path = Resources.getPath("path");
    public-read var station: Node = Resources.getImage("station");
    public var creatures: Creature[];
    public var towers: Tower[];
    public var bullets: Bullet[];
    var amountLivePeoples: Integer = 8;
    var peoples: Node[] = for (i in [0..<amountLivePeoples]) {
		Group { translateX: 15 * i, content: Resources.getImage("man") }
	    }
    var ground: Node = Resources.getImage("ground");
    public-read var paused: Boolean = true;
    var waves: Wave[];
    public var timelines: Timeline[] = [
		Timeline {
		    keyFrames: [
			KeyFrame {
			    time: 20s
			    values: timeBeforeWave => 0
			    action: function() {
				nextWave();
			    }
			}
		    ]
		    repeatCount: Timeline.INDEFINITE;
		}
	    ];

    override function create() {
	path.translateY = 50;
	Group {
	    content: [
		Group { content: ground },
		Group { content: path },
		Group { content: bind creatures },
		station = Group {
			    translateX: 520
			    translateY: 50
			    content: station
			}
		Group { content: bind bullets },
		Group { content: bind towers },
		Group {
		    translateX: station.boundsInParent.minX + 20;
		    translateY: station.boundsInParent.minY + 50;
		    content: bind peoples }
	    ]
	    onMouseClicked: function(e: MouseEvent): Void {
//		java.lang.System.out.println("{
//		    PathUtil.intersectLineAndCircle(Point2D{x:180.5,y:342}, Point2D{x:93.475,y:385}, Point2D{x:180.5,y:342}, 20).get(0)}");
//		java.lang.System.out.println("{
//		PathUtil.angleBetweenRadius(
//		Point2D { x: 0, y: 0 }, Point2D { x: 0, y: 5 }, Point2D { x: -5, y: 0 })}");
		java.lang.System.out.println("x: {e.x} y:{e.y}");
	    }
	}
    }

    public function play() {
	paused = false;
	//nextWave();
	for (t in timelines) {
	    t.play();
	}
    }

    public function pause() {
	paused = true;
	for (t in timelines) {
	    t.pause();
	}
    }

//    public function resume() {
//	paused = false;
//	for (t in timelines) {
//	    t.play();
//	}
//    }
    public function nextWave() {
	totalWaves++;
	var w = Wave { field: this, waveNumber: totalWaves }
	w.reset();
	insert w into waves;
	w.timeline.play();
    //w.timeline.play();
    //java.lang.System.out.println("{w.monsters.size()}");
    }

    function towersContains(l: Bounds): Boolean {
	for (t in towers) {
	    if (t.intersects(t.parentToLocal(l))) {
		return true;
	    }
	}
	return false;
    }

    public function canAddHere(l: Bounds): Boolean {
	def b = path.parentToLocal(l);
	def fieldContains = this.boundsInLocal.contains(l.minX, l.minY)
		and this.boundsInLocal.contains(l.maxX, l.maxY);
	def towers: Boolean = towersContains(l);
	java.lang.System.out.println("towers: {towers}");
	def t = towers or (not fieldContains) or PathUtil.intersect(path,
		Point2D {
		    x: b.minX + b.width / 2;
		    y: b.minY + b.height / 2;
		},
		30);
	//FIXME не учитывается толщина path
	return not t;
    }

    public function add(t: Tower): Void {
	t.field = this;
	t.reset();
	insert t into towers;
	t.translate(t.position);
    }

    public function add(t: Timeline): Void {
	insert t into timelines;
	if (not paused) {
	    t.play();
	}
    }

    public function killMan() {
	if (amountLivePeoples >= 0) {
	    amountLivePeoples--;
	    //delete  peoples[amountLivePeoples];
	    peoples[amountLivePeoples] = Group {
			translateX: 15 * amountLivePeoples
			content: Resources.getImage("killedMan")
		    }
	} else {
	    java.lang.System.out.println("Конец игры");
	}
    }

}
