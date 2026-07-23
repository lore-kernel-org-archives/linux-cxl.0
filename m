Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B973932E2
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782418; cv=none; b=OtjyYoC1Exzc/25aTQkwv5Xc1/8HuBdGBFJT9NsbGLYKqMGZpErofP7kqZIhucsMBgXiFMWrdOFOzmxoNWU1sc7DmoovfV/8CuOBMdxDLA0IYpi+fx8CJDfckhab9+fVWj8SDTvJ/N5Iw9qr2iB1Q+z/0yZkv5CMU7tgIlnNvLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782418; c=relaxed/simple;
	bh=0PirwlxZ2i7yPLmiffUMiAS6RaALirfLcbahUlAfF5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eO3XM80fW7OXrPxu4DNyHwdhLY0ROEjPo32BmOPrs6QTlBiSqPib7KWDo4YhCn2cXF7ykJFL96ECXWlhV4ynlgR+rcPbup/w2YzS82YnXG0X7uLfhjawtbA6DGIN8pLnSUeL67vwYjPYMDFc9yD6AmTZ/QfZ1HSjPU+D9qphL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FXz1bgM4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXz1bgM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqpQURYzqagcZw6PUEaGQX94Y2bhPgrE5ybIwr9ASNk=;
	b=FXz1bgM4ws6TzxpDATWJL7WwUHP7n8hasn8yj75v60dHCEFC4xGIxSsznWBwSlkPmUbvIu
	zRCuIkAkR6e2YnxDfBdFrJCIW6wgAlYLMRjGBsQS/dW57VeIuoMguInMy1YYmTyocOtUKN
	oTbYacI6W5daMWDRGmIxX1PNgFj3hdQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-2u3NbkSaOaqH6BtjDhRcyA-1; Thu,
 23 Jul 2026 00:53:19 -0400
X-MC-Unique: 2u3NbkSaOaqH6BtjDhRcyA-1
X-Mimecast-MFC-AGG-ID: 2u3NbkSaOaqH6BtjDhRcyA_1784782396
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77ED41805F05;
	Thu, 23 Jul 2026 04:53:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDD4918002AE;
	Thu, 23 Jul 2026 04:53:05 +0000 (UTC)
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
Subject: [PATCH v2 30/44] qapi: convert trivial intro sections for block-export.json
Date: Thu, 23 Jul 2026 00:47:51 -0400
Message-ID: <20260723044805.527643-31-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: WhcLmTYzwovvJjIbwG9ViKm9bdSvrNMGm-iP_glif5g_1784782396
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json | 87 +++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 52 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index dd724acf1cb..e9f7e72c8ee 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -37,10 +37,9 @@
 
 ##
 # @NbdServerOptions:
-#
-# Keep this type consistent with the `NbdServerOptionsLegacy` type.
-# The only intended difference is using `SocketAddress` instead of
-# `SocketAddressLegacy`.
+#     Keep this type consistent with the `NbdServerOptionsLegacy`
+#     type.  The only intended difference is using `SocketAddress`
+#     instead of `SocketAddressLegacy`.
 #
 # @addr: Address on which to listen (since 4.2).
 ##
@@ -50,10 +49,9 @@
 
 ##
 # @NbdServerOptionsLegacy:
-#
-# Keep this type consistent with the `NbdServerOptions` type.  The
-# only intended difference is using `SocketAddressLegacy` instead of
-# `SocketAddress`.
+#     Keep this type consistent with the `NbdServerOptions` type.  The
+#     only intended difference is using `SocketAddressLegacy` instead
+#     of `SocketAddress`.
 #
 # @addr: Address on which to listen (since 1.3).
 ##
@@ -63,11 +61,11 @@
 
 ##
 # @nbd-server-start:
-#
-# Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using `nbd-server-add`.  The NBD server
-# will present them as named exports; for example, another QEMU
-# instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
+#     Start an NBD server listening on the given host and port.  Block
+#     devices can then be exported using `nbd-server-add`.  The NBD
+#     server will present them as named exports; for example, another
+#     QEMU instance could refer to them as
+#     "nbd:HOST:PORT:exportname=NAME".
 #
 # Errors:
 #     - if the server is already running
@@ -80,9 +78,8 @@
 
 ##
 # @BlockExportOptionsNbdBase:
-#
-# An NBD block export (common options shared between `nbd-server-add`
-# and the NBD branch of `block-export-add`).
+#     An NBD block export (common options shared between
+#     `nbd-server-add` and the NBD branch of `block-export-add`).
 #
 # @name: Export name.  If unspecified, the @device parameter is used
 #     as the export name.  (Since 2.12)
@@ -97,9 +94,8 @@
 
 ##
 # @BlockExportOptionsNbd:
-#
-# An NBD block export (distinct options used in the NBD branch of
-# `block-export-add`).
+#     An NBD block export (distinct options used in the NBD branch of
+#     `block-export-add`).
 #
 # @bitmaps: Also export each of the named dirty bitmaps reachable from
 #     @device, so the NBD client can use NBD_OPT_SET_META_CONTEXT with
@@ -121,8 +117,7 @@
 
 ##
 # @BlockExportOptionsVhostUserBlk:
-#
-# A vhost-user-blk block export.
+#     A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
 #     'fd' `SocketAddress` types are supported.  Passed fds must be
@@ -143,8 +138,7 @@
 
 ##
 # @FuseExportAllowOther:
-#
-# Possible allow_other modes for FUSE exports.
+#     Possible allow_other modes for FUSE exports.
 #
 # @off: Do not pass allow_other as a mount option.
 #
@@ -195,8 +189,7 @@
 
 ##
 # @BlockExportOptionsVduseBlk:
-#
-# A vduse-blk block export.
+#     A vduse-blk block export.
 #
 # @name: the name of VDUSE device (must be unique across the host).
 #
@@ -221,8 +214,7 @@
 
 ##
 # @NbdServerAddOptions:
-#
-# An NBD block export, per legacy `nbd-server-add` command.
+#     An NBD block export, per legacy `nbd-server-add` command.
 #
 # @device: The device name or node name of the node to be exported
 #
@@ -266,8 +258,7 @@
 
 ##
 # @BlockExportRemoveMode:
-#
-# Mode for removing a block export.
+#     Mode for removing a block export.
 #
 # @safe: Remove export if there are no existing connections, fail
 #     otherwise.
@@ -289,8 +280,7 @@
 
 ##
 # @nbd-server-remove:
-#
-# Remove NBD export by name.
+#     Remove NBD export by name.
 #
 # @name: Block export id.
 #
@@ -316,9 +306,8 @@
 
 ##
 # @nbd-server-stop:
-#
-# Stop QEMU's embedded NBD server, and unregister all devices
-# previously added via `nbd-server-add`.
+#     Stop QEMU's embedded NBD server, and unregister all devices
+#     previously added via `nbd-server-add`.
 #
 # Since: 1.3
 ##
@@ -327,8 +316,7 @@
 
 ##
 # @BlockExportType:
-#
-# An enumeration of block export types
+#     An enumeration of block export types
 #
 # @nbd: NBD export
 #
@@ -349,9 +337,8 @@
 
 ##
 # @BlockExportOptions:
-#
-# Describes a block export, i.e. how single node should be exported on
-# an external interface.
+#     Describes a block export, i.e. how single node should be
+#     exported on an external interface.
 #
 # @type: Block export type
 #
@@ -412,9 +399,8 @@
 
 ##
 # @BlockExportIothreads:
-#
-# Specify a single or multiple I/O threads in which to run a block
-# export's I/O.
+#     Specify a single or multiple I/O threads in which to run a block
+#     export's I/O.
 #
 # @single: Run the export's I/O in the given single I/O thread.
 #
@@ -436,8 +422,7 @@
 
 ##
 # @block-export-add:
-#
-# Creates a new block export.
+#     Creates a new block export.
 #
 # Since: 5.2
 ##
@@ -447,10 +432,10 @@
 
 ##
 # @block-export-del:
-#
-# Request to remove a block export.  This drops the user's reference
-# to the export, but the export may still stay around after this
-# command returns until the shutdown of the export has completed.
+#     Request to remove a block export.  This drops the user's
+#     reference to the export, but the export may still stay around
+#     after this command returns until the shutdown of the export has
+#     completed.
 #
 # @id: Block export id.
 #
@@ -470,8 +455,7 @@
 
 ##
 # @BLOCK_EXPORT_DELETED:
-#
-# Emitted when a block export is removed and its id can be reused.
+#     Emitted when a block export is removed and its id can be reused.
 #
 # @id: Block export id.
 #
@@ -482,8 +466,7 @@
 
 ##
 # @BlockExportInfo:
-#
-# Information about a single block export.
+#     Information about a single block export.
 #
 # @id: The unique identifier for the block export
 #
-- 
2.55.0

