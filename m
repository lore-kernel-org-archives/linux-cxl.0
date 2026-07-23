Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2A381E8F
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782439; cv=none; b=FQQ5oVZfYiNja9T4Ki9/3GBYSekt9lnoZ8TrRmTcrqGe4xhXfOTL6YxDg0amZZwcNuF9+/TZo3YAbuoBkFdJvnyOIsJNiTVvxGN0DtT21cP+jL1MWpifbgzVwbU9DCpp363f7vFy8tJq2jWFM/3GFBPkTa+BmGwLGnUnFWLYpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782439; c=relaxed/simple;
	bh=lhIIdV7zdqpQ8sjRLqguRT+Tax+kWZ9Qu/4l0dlfwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lH2LWUxHN31o+4r+FYJMJKa8mQPuGw6UVU8zU/T4KvwgwBRK8b2tLr4og58Z5yMW2uwGHJMzYq7wXLv+Rly9D6QEIOTretd99BfLX6XemHNy5XPjcB91RLYs29aF0LDeoYjhXEBEHrfaCVc+cAgVV7A0N8oMNxHzjfp+9UO5ZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+yDxmcY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+yDxmcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvVNT9FP84PI//trYRCoAZS9q9GdrG1oeUvWQayikpo=;
	b=B+yDxmcYIa0XMD6IqGpAAjgATpVXxsOC0KLA782mXFQo9ZjxXpmsfo7fDO7H0GeFbRFTb9
	Z7vdI17LEnuhQO5o9aVbNy6LEtXscrTzkwk84yVYpMNJUNg4oX8FZjanAleNUA8J1ovUpQ
	0UItqzgKyatCYGv6YDL5DNFmfgjerKE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-Z0nYtQrROaGc1WxEnAlu_g-1; Thu,
 23 Jul 2026 00:53:40 -0400
X-MC-Unique: Z0nYtQrROaGc1WxEnAlu_g-1
X-Mimecast-MFC-AGG-ID: Z0nYtQrROaGc1WxEnAlu_g_1784782416
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 009F61977539;
	Thu, 23 Jul 2026 04:53:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DE9318002B4;
	Thu, 23 Jul 2026 04:53:27 +0000 (UTC)
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
Subject: [PATCH v2 32/44] qapi: convert trivial intro sections for block.json
Date: Thu, 23 Jul 2026 00:47:53 -0400
Message-ID: <20260723044805.527643-33-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 8Z5XtdbmKatdvlBl87Hsyc6fQ51jZpAOCpPEU1xU1vg_1784782416
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block.json | 58 +++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e3..e47592d5500 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -16,11 +16,10 @@
 
 ##
 # @BiosAtaTranslation:
-#
-# Policy that BIOS should use to interpret cylinder/head/sector
-# addresses.  Note that Bochs BIOS and SeaBIOS will not actually
-# translate logical CHS to physical; instead, they will use logical
-# block addressing.
+#     Policy that BIOS should use to interpret cylinder/head/sector
+#     addresses.  Note that Bochs BIOS and SeaBIOS will not actually
+#     translate logical CHS to physical; instead, they will use
+#     logical block addressing.
 #
 # @auto: If cylinder/heads/sizes are passed, choose between none and
 #     LBA depending on the size of the disk.  If they are not passed,
@@ -50,8 +49,8 @@
 
 ##
 # @FloppyDriveType:
-#
-# Type of floppy drive to be emulated by the Floppy Disk Controller.
+#     Type of floppy drive to be emulated by the
+#     Floppy Disk Controller.
 #
 # @144: 1.44MB 3.5" drive
 #
@@ -70,8 +69,7 @@
 
 ##
 # @PRManagerInfo:
-#
-# Information about a persistent reservation manager
+#     Information about a persistent reservation manager
 #
 # @id: the identifier of the persistent reservation manager
 #
@@ -85,9 +83,8 @@
 
 ##
 # @query-pr-managers:
-#
-# Return a list of information about each persistent reservation
-# manager.
+#     Return a list of information about each persistent reservation
+#     manager.
 #
 # Returns: a list of manager info for each persistent reservation
 #     manager
@@ -99,8 +96,7 @@
 
 ##
 # @eject:
-#
-# Ejects the medium from a removable drive.
+#     Ejects the medium from a removable drive.
 #
 # @device: Block device name
 #
@@ -264,10 +260,10 @@
 
 ##
 # @blockdev-insert-medium:
-#
-# Inserts a medium (a block driver state tree) into a block device.
-# That block device's tray must currently be open (unless there is no
-# attached guest device) and there must be no medium inserted already.
+#     Inserts a medium (a block driver state tree) into a block
+#     device.  That block device's tray must currently be open (unless
+#     there is no attached guest device) and there must be no medium
+#     inserted already.
 #
 # @id: The name or QOM path of the guest device
 #
@@ -297,9 +293,8 @@
 
 ##
 # @BlockdevChangeReadOnlyMode:
-#
-# Specifies the new read-only mode of a block device subject to the
-# `blockdev-change-medium` command.
+#     Specifies the new read-only mode of a block device subject to
+#     the `blockdev-change-medium` command.
 #
 # @retain: Retains the current read-only mode
 #
@@ -314,12 +309,11 @@
 
 ##
 # @blockdev-change-medium:
-#
-# Changes the medium inserted into a block device by ejecting the
-# current medium and loading a new image file which is inserted as the
-# new medium (this command combines `blockdev-open-tray`,
-# `blockdev-remove-medium`, `blockdev-insert-medium` and
-# `blockdev-close-tray`).
+#     Changes the medium inserted into a block device by ejecting the
+#     current medium and loading a new image file which is inserted as
+#     the new medium (this command combines `blockdev-open-tray`,
+#     `blockdev-remove-medium`, `blockdev-insert-medium` and
+#     `blockdev-close-tray`).
 #
 # @device: Block device name
 #
@@ -385,9 +379,8 @@
 
 ##
 # @DEVICE_TRAY_MOVED:
-#
-# Emitted whenever the tray of a removable device is moved by the
-# guest or by HMP/QMP commands
+#     Emitted whenever the tray of a removable device is moved by the
+#     guest or by HMP/QMP commands
 #
 # @device: Block device name.  This is always present for
 #     compatibility reasons, but it can be empty ("") if the image
@@ -414,9 +407,8 @@
 
 ##
 # @PR_MANAGER_STATUS_CHANGED:
-#
-# Emitted whenever the connected status of a persistent reservation
-# manager changes.
+#     Emitted whenever the connected status of a persistent
+#     reservation manager changes.
 #
 # @id: The id of the PR manager object
 #
-- 
2.55.0

