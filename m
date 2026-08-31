Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89103101A2
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207949; cv=none; b=EMrWEAqMwzRNMju1U0piyqtj5Vie08kIgLzvhrQsiSVJNfpclN18pMWmZ0r9G/rD4hv72vOpqrQbBVTz3RtVOUeFpOvZmOAqX7cODYCmRtBDpTnedt6DyQdI77KN4G80kdsmRMS1l6cb7z1OeOZzOGMxpfqVuaRSSjk8TAOstb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207949; c=relaxed/simple;
	bh=FrWoQQ3U5krJj8ZlEZXkxiXneqqfWRAb+ixQ1ITiipo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=sUEKSFr4f+SkWpyw9JY5YtUOn7JwRi//64uoRdPXN7UQQjBJkJd3fLEkDjm7/qiqIyegrIayOaw304EX6v9sXxpW1nf/vNqtDN8cmP/Pv0pKOmeVo+KtQ+B1Eecp4qm7Ymy60YWcSd53JFU9eUlsDQpmOEWH+ZOQjBG1I3mtyLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fq2EnOE2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fq2EnOE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GT4vbniYPu2T0an15X/kc4fJpS4Ogad+KYFFAMad4RM=;
	b=fq2EnOE2PbjOJWQbY2q/dNlhi8yFqdJge6UJK/RFG357zdr6NBabd849Sgg795aS0RnPZE
	ZnMz3If9E6I6zEkUznjD+rT0+zw1uFysKb5moSfMzau+iU2ZzdmVr7UU8XMLmKaKu5fAuW
	IvswrsKrjQEm3dzCLWXCcqAyWgnZJHk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-YD3I1q7EOtmx6X9TRg2puw-1; Mon,
 31 Aug 2026 16:25:41 -0400
X-MC-Unique: YD3I1q7EOtmx6X9TRg2puw-1
X-Mimecast-MFC-AGG-ID: YD3I1q7EOtmx6X9TRg2puw_1788207938
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 971111944DF1;
	Mon, 31 Aug 2026 20:25:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23D741800577;
	Mon, 31 Aug 2026 20:25:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	linux-cxl@vger.kernel.org,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	linux-edac@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>,
	John Snow <jsnow@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Eric Blake <eblake@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-trivial@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 40/43] qapi: convert trivial intro sections for ui.json
Date: Mon, 31 Aug 2026 16:19:42 -0400
Message-ID: <20260831201945.287730-41-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3JelNpu8srctdhRdwSjUQDFF_OtVDUbXuFkxxlEjug0_1788207938
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/ui.json | 199 ++++++++++++++++++---------------------------------
 1 file changed, 68 insertions(+), 131 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index b2c42a7f578..960d02d1429 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -13,8 +13,7 @@
 
 ##
 # @DisplayProtocol:
-#
-# Display protocols which support changing password options.
+#     Display protocols which support changing password options.
 #
 # Since: 7.0
 ##
@@ -23,9 +22,8 @@
 
 ##
 # @SetPasswordAction:
-#
-# An action to take on changing a password on a connection with active
-# clients.
+#     An action to take on changing a password on a connection with
+#     active clients.
 #
 # @keep: maintain existing clients
 #
@@ -40,8 +38,7 @@
 
 ##
 # @SetPasswordOptions:
-#
-# Options for `set_password`.
+#     Options for `set_password`.
 #
 # @protocol:
 #     - 'vnc' to modify the VNC server password
@@ -64,8 +61,7 @@
 
 ##
 # @SetPasswordOptionsVnc:
-#
-# Options for `set_password` specific to the VNC protocol.
+#     Options for `set_password` specific to the VNC protocol.
 #
 # @display: The id of the display where the password should be
 #     changed.  Defaults to the first.
@@ -77,8 +73,7 @@
 
 ##
 # @set_password:
-#
-# Set the password of a remote display server.
+#     Set the password of a remote display server.
 #
 # Errors:
 #     - If Spice is not enabled, DeviceNotFound
@@ -95,8 +90,7 @@
 
 ##
 # @ExpirePasswordOptions:
-#
-# General options for `expire_password`.
+#     General options for `expire_password`.
 #
 # @protocol:
 #     - 'vnc' to modify the VNC server expiration
@@ -125,8 +119,7 @@
 
 ##
 # @ExpirePasswordOptionsVnc:
-#
-# Options for `expire_password` specific to the VNC protocol.
+#     Options for `expire_password` specific to the VNC protocol.
 #
 # @display: The id of the display where the expiration should be
 #     changed.  Defaults to the first.
@@ -138,8 +131,7 @@
 
 ##
 # @expire_password:
-#
-# Expire the password of a remote display server.
+#     Expire the password of a remote display server.
 #
 # Errors:
 #     - If @protocol is 'spice' and Spice is not active,
@@ -157,8 +149,7 @@
 
 ##
 # @ImageFormat:
-#
-# Supported image format types.
+#     Supported image format types.
 #
 # @png: PNG format
 #
@@ -171,8 +162,7 @@
 
 ##
 # @screendump:
-#
-# Capture the contents of a screen and write it to a file.
+#     Capture the contents of a screen and write it to a file.
 #
 # @filename: the path of a new file to store the image
 #
@@ -208,8 +198,7 @@
 
 ##
 # @SpiceBasicInfo:
-#
-# The basic information for SPICE network connection
+#     The basic information for SPICE network connection
 #
 # @host: IP address
 #
@@ -227,8 +216,7 @@
 
 ##
 # @SpiceServerInfo:
-#
-# Information about a SPICE server
+#     Information about a SPICE server
 #
 # @auth: authentication method
 #
@@ -241,8 +229,7 @@
 
 ##
 # @SpiceChannel:
-#
-# Information about a SPICE client channel.
+#     Information about a SPICE client channel.
 #
 # @connection-id: SPICE connection id number.  All channels with the
 #     same id belong to the same SPICE session.
@@ -267,8 +254,7 @@
 
 ##
 # @SpiceQueryMouseMode:
-#
-# An enumeration of Spice mouse states.
+#     An enumeration of Spice mouse states.
 #
 # @client: Mouse cursor position is determined by the client.
 #
@@ -285,8 +271,7 @@
 
 ##
 # @SpiceInfo:
-#
-# Information about the SPICE session.
+#     Information about the SPICE session.
 #
 # @enabled: true if the SPICE server is enabled, false otherwise
 #
@@ -325,8 +310,7 @@
 
 ##
 # @query-spice:
-#
-# Return information about the current SPICE server
+#     Return information about the current SPICE server
 #
 # Since: 0.14
 #
@@ -370,8 +354,7 @@
 
 ##
 # @SPICE_CONNECTED:
-#
-# Emitted when a SPICE client establishes a connection
+#     Emitted when a SPICE client establishes a connection
 #
 # @server: server information
 #
@@ -395,9 +378,8 @@
 
 ##
 # @SPICE_INITIALIZED:
-#
-# Emitted after initial handshake and authentication takes place (if
-# any) and the SPICE channel is up and running
+#     Emitted after initial handshake and authentication takes place
+#     (if any) and the SPICE channel is up and running
 #
 # @server: server information
 #
@@ -423,8 +405,7 @@
 
 ##
 # @SPICE_DISCONNECTED:
-#
-# Emitted when the SPICE connection is closed
+#     Emitted when the SPICE connection is closed
 #
 # @server: server information
 #
@@ -448,8 +429,7 @@
 
 ##
 # @SPICE_MIGRATE_COMPLETED:
-#
-# Emitted when SPICE migration has completed
+#     Emitted when SPICE migration has completed
 #
 # Since: 1.3
 #
@@ -468,8 +448,7 @@
 
 ##
 # @VncBasicInfo:
-#
-# The basic information for vnc network connection
+#     The basic information for vnc network connection
 #
 # @host: IP address
 #
@@ -492,8 +471,7 @@
 
 ##
 # @VncServerInfo:
-#
-# The network connection information for server
+#     The network connection information for server
 #
 # @auth: authentication method used for the plain (non-websocket) VNC
 #     server
@@ -507,8 +485,7 @@
 
 ##
 # @VncClientInfo:
-#
-# Information about a connected VNC client.
+#     Information about a connected VNC client.
 #
 # @x509_dname: If x509 authentication is in use, the Distinguished
 #     Name of the client.
@@ -525,8 +502,7 @@
 
 ##
 # @VncInfo:
-#
-# Information about the VNC session.
+#     Information about the VNC session.
 #
 # @enabled: true if the VNC server is enabled, false otherwise
 #
@@ -576,8 +552,7 @@
 
 ##
 # @VncPrimaryAuth:
-#
-# vnc primary authentication method.
+#     vnc primary authentication method.
 #
 # Since: 2.3
 ##
@@ -588,8 +563,7 @@
 
 ##
 # @VncVencryptSubAuth:
-#
-# vnc sub authentication method with vencrypt.
+#     vnc sub authentication method with vencrypt.
 #
 # Since: 2.3
 ##
@@ -603,8 +577,7 @@
 
 ##
 # @VncServerInfo2:
-#
-# The network connection information for server
+#     The network connection information for server
 #
 # @auth: The current authentication type used by the servers
 #
@@ -621,8 +594,7 @@
 
 ##
 # @VncInfo2:
-#
-# Information about a vnc server
+#     Information about a vnc server
 #
 # @id: vnc server name.
 #
@@ -655,8 +627,7 @@
 
 ##
 # @query-vnc:
-#
-# Return information about the current VNC server
+#     Return information about the current VNC server
 #
 # Since: 0.14
 #
@@ -695,8 +666,7 @@
 
 ##
 # @change-vnc-password:
-#
-# Change the VNC server password.
+#     Change the VNC server password.
 #
 # @password: the new password to use with VNC authentication
 #
@@ -712,8 +682,7 @@
 
 ##
 # @VNC_CONNECTED:
-#
-# Emitted when a VNC client establishes a connection
+#     Emitted when a VNC client establishes a connection
 #
 # @server: server information
 #
@@ -741,9 +710,8 @@
 
 ##
 # @VNC_INITIALIZED:
-#
-# Emitted after authentication takes place (if any) and the VNC
-# session is made active
+#     Emitted after authentication takes place (if any) and the VNC
+#     session is made active
 #
 # @server: server information
 #
@@ -768,8 +736,7 @@
 
 ##
 # @VNC_DISCONNECTED:
-#
-# Emitted when the connection is closed
+#     Emitted when the connection is closed
 #
 # @server: server information
 #
@@ -800,8 +767,7 @@
 
 ##
 # @MouseInfo:
-#
-# Information about a mouse device.
+#     Information about a mouse device.
 #
 # @name: the name of the mouse device
 #
@@ -820,8 +786,7 @@
 
 ##
 # @query-mice:
-#
-# Return information about each active mouse device
+#     Return information about each active mouse device
 #
 # Returns: a list of info for each device
 #
@@ -1005,8 +970,7 @@
 
 ##
 # @KeyValue:
-#
-# Represents a keyboard key.
+#     Represents a keyboard key.
 #
 # @type: key encoding
 #
@@ -1021,8 +985,7 @@
 
 ##
 # @send-key:
-#
-# Send keys to guest.
+#     Send keys to guest.
 #
 # @keys: An array of `KeyValue` elements.  All @KeyValues in this
 #     array are simultaneously sent to the guest.  A `KeyValue`.number
@@ -1050,8 +1013,7 @@
 
 ##
 # @InputButton:
-#
-# Button of a pointer input device (mouse, tablet).
+#     Button of a pointer input device (mouse, tablet).
 #
 # @side: front side button of a 5-button mouse (since 2.9)
 #
@@ -1067,8 +1029,7 @@
 
 ##
 # @InputAxis:
-#
-# Position axis of a pointer input device (mouse, tablet).
+#     Position axis of a pointer input device (mouse, tablet).
 #
 # Since: 2.0
 ##
@@ -1077,8 +1038,7 @@
 
 ##
 # @InputMultiTouchType:
-#
-# Type of a multi-touch event.
+#     Type of a multi-touch event.
 #
 # @begin: A new touch event sequence has just started.
 #
@@ -1097,8 +1057,7 @@
 
 ##
 # @InputKeyEvent:
-#
-# Keyboard input event.
+#     Keyboard input event.
 #
 # @key: Which key this event is for.
 #
@@ -1112,8 +1071,7 @@
 
 ##
 # @InputBtnEvent:
-#
-# Pointer button input event.
+#     Pointer button input event.
 #
 # @button: Which button this event is for.
 #
@@ -1127,8 +1085,7 @@
 
 ##
 # @InputMoveEvent:
-#
-# Pointer motion input event.
+#     Pointer motion input event.
 #
 # @axis: Which axis is referenced by @value.
 #
@@ -1143,8 +1100,7 @@
 
 ##
 # @InputMultiTouchEvent:
-#
-# MultiTouch input event.
+#     MultiTouch input event.
 #
 # @type: The type of multi-touch event.
 #
@@ -1226,8 +1182,7 @@
 
 ##
 # @InputEvent:
-#
-# Input event union.
+#     Input event union.
 #
 # @type: the type of input event
 #
@@ -1316,8 +1271,7 @@
 
 ##
 # @DisplayGTK:
-#
-# GTK display options.
+#     GTK display options.
 #
 # @clipboard: Enable host-guest clipboard sharing.  Defaults to "off".
 #     (Since 11.1)
@@ -1357,8 +1311,7 @@
 
 ##
 # @DisplayEGLHeadless:
-#
-# EGL headless display options.
+#     EGL headless display options.
 #
 # @rendernode: Which DRM render node should be used.  Default is the
 #     first available node on the host.
@@ -1370,8 +1323,7 @@
 
 ##
 # @DisplayDBus:
-#
-# DBus display options.
+#     DBus display options.
 #
 # @addr: The D-Bus bus address (default to the session bus).
 #
@@ -1393,8 +1345,7 @@
 
 ##
 # @DisplayGLMode:
-#
-# Display OpenGL mode.
+#     Display OpenGL mode.
 #
 # @off: Disable OpenGL (default).
 #
@@ -1413,8 +1364,7 @@
 
 ##
 # @DisplayCurses:
-#
-# Curses display options.
+#     Curses display options.
 #
 # @charset: Font charset used by guest (default: CP437).
 #
@@ -1425,8 +1375,7 @@
 
 ##
 # @DisplayCocoa:
-#
-# Cocoa display options.
+#     Cocoa display options.
 #
 # @left-command-key: Enable/disable forwarding of left command key to
 #     guest.  Allows command-tab window switching on the host without
@@ -1461,8 +1410,8 @@
 
 ##
 # @HotKeyMod:
-#
-# Set of modifier keys that need to be held for shortcut key actions.
+#    Set of modifier keys that need to be held for shortcut key
+#    actions.
 #
 # Since: 7.1
 ##
@@ -1471,8 +1420,7 @@
 
 ##
 # @DisplaySDL:
-#
-# SDL2 display options.
+#     SDL2 display options.
 #
 # @grab-mod: Modifier keys that should be pressed together with the
 #     "G" key to release the mouse grab.
@@ -1484,8 +1432,7 @@
 
 ##
 # @DisplayType:
-#
-# Display (user interface) type.
+#     Display (user interface) type.
 #
 # @default: The default user interface, selecting from the first
 #     available of gtk, sdl, cocoa, and vnc.
@@ -1535,8 +1482,7 @@
 
 ##
 # @DisplayOptions:
-#
-# Display (user interface) options.
+#     Display (user interface) options.
 #
 # @type: Which `DisplayType` QEMU should use.
 #
@@ -1573,8 +1519,7 @@
 
 ##
 # @query-display-options:
-#
-# Return information about display configuration
+#     Return information about display configuration
 #
 # Since: 3.1
 ##
@@ -1583,8 +1528,7 @@
 
 ##
 # @DisplayReloadType:
-#
-# Available DisplayReload types.
+#     Available DisplayReload types.
 #
 # @vnc: VNC display
 #
@@ -1595,8 +1539,7 @@
 
 ##
 # @DisplayReloadOptionsVNC:
-#
-# Specify the VNC reload options.
+#     Specify the VNC reload options.
 #
 # @tls-certs: reload tls certs or not.
 #
@@ -1607,8 +1550,7 @@
 
 ##
 # @DisplayReloadOptions:
-#
-# Options of the display configuration reload.
+#     Options of the display configuration reload.
 #
 # @type: Specify the display type.
 #
@@ -1621,8 +1563,7 @@
 
 ##
 # @display-reload:
-#
-# Reload display configuration.
+#     Reload display configuration.
 #
 # Since: 6.0
 #
@@ -1638,8 +1579,7 @@
 
 ##
 # @DisplayUpdateType:
-#
-# Available DisplayUpdate types.
+#     Available DisplayUpdate types.
 #
 # @vnc: VNC display
 #
@@ -1650,8 +1590,7 @@
 
 ##
 # @DisplayUpdateOptionsVNC:
-#
-# Specify the VNC reload options.
+#     Specify the VNC reload options.
 #
 # @addresses: If specified, change set of addresses to listen for
 #     connections.  Addresses configured for websockets are not
@@ -1664,8 +1603,7 @@
 
 ##
 # @DisplayUpdateOptions:
-#
-# Options of the display configuration reload.
+#     Options of the display configuration reload.
 #
 # @type: Specify the display type.
 #
@@ -1678,8 +1616,7 @@
 
 ##
 # @display-update:
-#
-# Update display configuration.
+#     Update display configuration.
 #
 # Since: 7.1
 #
-- 
2.55.0

