package tdgame.core;

import javafx.animation.Timeline;
import javafx.animation.KeyFrame;
import tdgame.monster.Bug;

/**
 * @author Maxim Kolchin
 */
public class Wave {

    public var field: Field;
    public var monsters: Creature[];
    public var waveNumber: Integer;
    public var timeline: Timeline;
    var index: Number = -1;
    var interval: Duration = 1s;

    public function reset(): Void {
	def numMon: Number = waveNumber;
	for (i in [1..numMon]) {
	    def c = Bug {field: field wave:this path: field.path};
	    insert c into monsters;
	}

	timeline = Timeline {
		    keyFrames: [
			for (m in monsters) {
			    KeyFrame {
				time: ++index * interval;
				action: function() {
				    m.reset();
				    //java.lang.System.out.println("Побежал");
				}
			    }
			}
		    ]
		}
	//field.add(timeline);
    }

}
