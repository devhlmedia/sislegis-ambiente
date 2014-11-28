--- /home/sislegis/sislegis-ambiente/ferramentas/jboss/bin/init.d/wildfly-init-debian.sh	2014-11-21 02:43:21.000000000 -0200
+++ /etc/init.d/jboss	2014-11-27 22:08:23.129339221 -0200
@@ -166,11 +166,11 @@
 		if [ "$JBOSS_MODE" = "standalone" ]; then
 			start-stop-daemon --start --user "$JBOSS_USER" \
 			--chuid "$JBOSS_USER" --chdir "$JBOSS_HOME" --pidfile "$JBOSS_PIDFILE" \
-			--exec "$JBOSS_SCRIPT" -- -c $JBOSS_CONFIG >> "$JBOSS_CONSOLE_LOG" 2>&1 &
+			--exec "$JBOSS_SCRIPT" -- $JBOSS_PARAMS -c $JBOSS_CONFIG >> "$JBOSS_CONSOLE_LOG" 2>&1 &
 		else
 			start-stop-daemon --start --user "$JBOSS_USER" \
 			--chuid "$JBOSS_USER" --chdir "$JBOSS_HOME" --pidfile "$JBOSS_PIDFILE" \
-			--exec "$JBOSS_SCRIPT" -- --domain-config=$JBOSS_DOMAIN_CONFIG \
+			--exec "$JBOSS_SCRIPT" -- $JBOSS_PARAMS --domain-config=$JBOSS_DOMAIN_CONFIG \
 			--host-config=$JBOSS_HOST_CONFIG >> "$JBOSS_CONSOLE_LOG" 2>&1 &
 		fi
 
