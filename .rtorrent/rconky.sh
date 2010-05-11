#!/bin/sh
touch /tmp/rconky
test -S "$2" &&
"$@" d.multicall default \
   d.get_name= \
      d.get_up_rate= \
	     d.get_down_rate= \
		    d.get_completed_chunks= \
			   d.get_size_chunks= \
			      d.is_active= \
				  |
				  xmlstarlet sel -t -v / |
				  awk '/./ {
				     if (++i%6 == 1) name=$0
						    else if (i%6 == 2) up[name]=$0
								   else if (i%6 == 3) down[name]=$0
									      else if (i%6 == 4) done[name]=$0
											     else if (i%6 == 5) size[name]=$0
											    else if (i%6 == 0) active[name]=$0
						} END {										for(name in up) {															         if(active[name]) {																		        #up_sum += up[name]
		                          		#down_sum += down[name]
					         #if(++j<=4)
					         {
						 printf("Name: %s\n", name)
						 printf("Done: %d%%\n", 100 * done[name] / size[name])
						 printf("Up: %.1f kB/s\n", up[name] / 1024)
						 printf("Down: %.1f kB/s\n", down[name] / 1024)
						 printf("\n\b")
						 }
					}									
                               }
																				#printf("Total up: %.1f kB/s\n", up_sum / 1024)
				#printf("Total down: %.1f kB/s\n", down_sum / 1024)
		}' |  xargs -d'\b' -n1 printf '%s\0' |  sort -z |  xargs -0 -n1 printf '%s'
