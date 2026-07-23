Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF533F385
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782486; cv=none; b=iLkhlFyaCDCL1PZZlB7h7QboDvDP/g2gZwUFeAJSjAwIm62wH1bk+BmV8EODCSfHE6yhQkRBLBMqvgyTCu/5O2A57v9Qo/qYXGWYblYLmM2DPI3oQWYDYEMGpRDKMeAIIiq5JZUOVFelx71oGlzOXcOAkRxOVaVb6lx0LwrA7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782486; c=relaxed/simple;
	bh=ISAzgi24BofVd7hNAgVVzaqb5yG1gM8QhKXgpR7D7kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=nC/31J65VTeYu5IL2sflKWG8P6gKSwAxv8wGZtcEqL9PtdG1SU1lgiA8kxVVPXkiVkXL3Lj6PsDBIx7NMxmPhjx1Ke1L7qf4EDUYsRTGsOsk/xKiUe3SjnMJnZy6IL67ZW12s8MXh8c0XZz70YIgFu4y7y3mH5nybXsN2eqF5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iiO+F3qg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiO+F3qg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2l6GvJOHZN3iItpA5ipqrT2gVM1c+L15Fe47ufdVcE=;
	b=iiO+F3qgUJtiQZr+51Ka/p+0fsnjSE7lrdfKBI4y539bhT4vDEsyNgVSedkhvbEJWXEopk
	mLlt75c2KDmY0In4nnAxByR2+H4U4sWaBfJP0A6w84KQ3spIoN9HkIKYwPWRThkWEZepx3
	e5umBxUnLwG4+1SsdulpiiTKU7KVtAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-cP_UqyUjPW6VzT4_S0CN1A-1; Thu,
 23 Jul 2026 00:54:26 -0400
X-MC-Unique: cP_UqyUjPW6VzT4_S0CN1A-1
X-Mimecast-MFC-AGG-ID: cP_UqyUjPW6VzT4_S0CN1A_1784782464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF1FC1944F10;
	Thu, 23 Jul 2026 04:54:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B26918002AE;
	Thu, 23 Jul 2026 04:54:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Lukas Straub <lukasstraub2@web.de>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Alex Williamson <alex@shazbot.org>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hanna Reitz <hreitz@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	John Snow <jsnow@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Igor Mammedov <imammedo@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-edac@vger.kernel.org,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	qemu-trivial@nongnu.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 37/44] qapi: convert intro sections for char.json
Date: Thu, 23 Jul 2026 00:47:58 -0400
Message-ID: <20260723044805.527643-38-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3TjX2UDItl7xyJvqSPepP-N40us1X5si7vMNzpRecW0_1784782464
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/char.json | 90 +++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 60 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index abaccefa97e..7ae67eedff8 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -12,8 +12,7 @@
 
 ##
 # @ChardevInfo:
-#
-# Information about a character device.
+#     Information about a character device.
 #
 # @label: the label of the character device
 #
@@ -35,8 +34,7 @@
 
 ##
 # @query-chardev:
-#
-# Return information about current character devices.
+#     Return information about current character devices.
 #
 # Since: 0.14
 #
@@ -68,8 +66,7 @@
 
 ##
 # @ChardevBackendInfo:
-#
-# Information about a character device backend
+#     Information about a character device backend
 #
 # @name: The backend name
 #
@@ -79,8 +76,7 @@
 
 ##
 # @query-chardev-backends:
-#
-# Return information about character device backends.
+#     Return information about character device backends.
 #
 # Since: 2.0
 #
@@ -108,8 +104,7 @@
 
 ##
 # @DataFormat:
-#
-# An enumeration of data format.
+#     An enumeration of data format.
 #
 # @utf8: Data is a UTF-8 string (RFC 3629)
 #
@@ -122,8 +117,7 @@
 
 ##
 # @ringbuf-write:
-#
-# Write to a ring buffer character device.
+#     Write to a ring buffer character device.
 #
 # @device: the ring buffer character device name
 #
@@ -154,8 +148,7 @@
 
 ##
 # @ringbuf-read:
-#
-# Read from a ring buffer character device.
+#     Read from a ring buffer character device.
 #
 # @device: the ring buffer character device name
 #
@@ -189,8 +182,7 @@
 
 ##
 # @ChardevCommon:
-#
-# Configuration shared across all chardev backends
+#     Configuration shared across all chardev backends
 #
 # @logfile: The name of a logfile to save output
 #
@@ -209,8 +201,7 @@
 
 ##
 # @ChardevFile:
-#
-# Configuration info for file chardevs.
+#     Configuration info for file chardevs.
 #
 # @in: The name of the input file
 #
@@ -229,8 +220,7 @@
 
 ##
 # @ChardevHostdev:
-#
-# Configuration info for device and pipe chardevs.
+#     Configuration info for device and pipe chardevs.
 #
 # @device: The name of the special file for the device, i.e.
 #     /dev/ttyS0 on Unix or COM1: on Windows
@@ -243,8 +233,7 @@
 
 ##
 # @ChardevSocket:
-#
-# Configuration info for (stream) socket chardevs.
+#     Configuration info for (stream) socket chardevs.
 #
 # @addr: socket address to listen on (server=true) or connect to
 #     (server=false)
@@ -295,8 +284,7 @@
 
 ##
 # @ChardevUdp:
-#
-# Configuration info for datagram socket chardevs.
+#     Configuration info for datagram socket chardevs.
 #
 # @remote: remote address
 #
@@ -311,8 +299,7 @@
 
 ##
 # @ChardevMux:
-#
-# Configuration info for mux chardevs.
+#     Configuration info for mux chardevs.
 #
 # @chardev: name of the base chardev.
 #
@@ -324,8 +311,7 @@
 
 ##
 # @ChardevHub:
-#
-# Configuration info for hub chardevs.
+#     Configuration info for hub chardevs.
 #
 # @chardevs: IDs to be added to this hub (maximum 4 devices).
 #
@@ -337,8 +323,7 @@
 
 ##
 # @ChardevStdio:
-#
-# Configuration info for stdio chardevs.
+#     Configuration info for stdio chardevs.
 #
 # @signal: Allow signals (such as SIGINT triggered by ^C) be delivered
 #     to QEMU.  Default: true.
@@ -351,8 +336,7 @@
 
 ##
 # @ChardevSpiceChannel:
-#
-# Configuration info for spice vm channel chardevs.
+#     Configuration info for spice vm channel chardevs.
 #
 # @type: kind of channel (for example vdagent).
 #
@@ -365,8 +349,7 @@
 
 ##
 # @ChardevSpicePort:
-#
-# Configuration info for spice port chardevs.
+#     Configuration info for spice port chardevs.
 #
 # @fqdn: name of the channel (see docs/spice-port-fqdn.txt)
 #
@@ -379,8 +362,7 @@
 
 ##
 # @ChardevVCEncoding:
-#
-# Character encoding expected from the guest on a virtual console.
+#     Character encoding expected from the guest on a virtual console.
 #
 # @cp437: CP437 (8-bit Extended ASCII / VGA).  Every byte maps
 #     directly to a glyph; suitable for DOS or other guests that
@@ -397,8 +379,7 @@
 
 ##
 # @ChardevDBus:
-#
-# Configuration info for DBus chardevs.
+#     Configuration info for DBus chardevs.
 #
 # @name: name of the channel (following docs/spice-port-fqdn.txt)
 #
@@ -415,8 +396,7 @@
 
 ##
 # @ChardevVC:
-#
-# Configuration info for virtual console chardevs.
+#     Configuration info for virtual console chardevs.
 #
 # @width: console width, in pixels
 #
@@ -445,8 +425,7 @@
 
 ##
 # @ChardevRingbuf:
-#
-# Configuration info for ring buffer chardevs.
+#     Configuration info for ring buffer chardevs.
 #
 # @size: ring buffer size, must be power of two, default is 65536
 #
@@ -458,8 +437,7 @@
 
 ##
 # @ChardevQemuVDAgent:
-#
-# Configuration info for QEMU vdagent implementation.
+#     Configuration info for QEMU vdagent implementation.
 #
 # @mouse: enable/disable mouse, default is enabled.
 #
@@ -475,8 +453,7 @@
 
 ##
 # @ChardevPty:
-#
-# Configuration info for pty implementation.
+#     Configuration info for pty implementation.
 #
 # @path: optional path to create a symbolic link that points to the
 #     allocated PTY
@@ -723,8 +700,7 @@
 
 ##
 # @ChardevBackend:
-#
-# Configuration info for the new chardev backend.
+#     Configuration info for the new chardev backend.
 #
 # @type: backend type
 #
@@ -767,8 +743,7 @@
 
 ##
 # @ChardevReturn:
-#
-# Return info about the chardev backend just created.
+#     Return info about the chardev backend just created.
 #
 # @pty: name of the slave pseudoterminal device, present if and only
 #     if a chardev of type 'pty' was created
@@ -780,8 +755,7 @@
 
 ##
 # @chardev-add:
-#
-# Add a character device backend
+#     Add a character device backend
 #
 # @id: the chardev's ID, must be unique
 #
@@ -818,8 +792,7 @@
 
 ##
 # @chardev-change:
-#
-# Change a character device backend
+#     Change a character device backend
 #
 # @id: the chardev's ID
 #
@@ -859,8 +832,7 @@
 
 ##
 # @chardev-remove:
-#
-# Remove a character device backend
+#     Remove a character device backend
 #
 # @id: the chardev's ID, must not be in use
 #
@@ -876,8 +848,7 @@
 
 ##
 # @chardev-send-break:
-#
-# Send a break to a character device
+#     Send a break to a character device
 #
 # @id: the chardev's ID
 #
@@ -893,8 +864,7 @@
 
 ##
 # @VSERPORT_CHANGE:
-#
-# Emitted when the guest opens or closes a virtio-serial port.
+#     Emitted when the guest opens or closes a virtio-serial port.
 #
 # @id: device identifier of the virtio-serial port
 #
-- 
2.55.0

