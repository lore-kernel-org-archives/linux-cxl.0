Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBFD38D3ED
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207873; cv=none; b=TQ/s+GwW1ckGByxkjn6GQ+JKXdq4fmgymzqZCtX1Ah85vUEw/kpmSSLIt5IgdqS5o93GksJFhhU9iPKtXdVWog9bbClgY+W0G+EZa48dYeza4OwYNLELBA9MWidHXl5GXyOrDmGSVv67wn/g6mHaY6VVwGTHrhBWstaiSDOGX+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207873; c=relaxed/simple;
	bh=/f7tjLGZB7pBFAqeESel5wuzRKk9VBsWm5R9P0YkErM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Jpx12VMNIml1jQa6ylg94mgVITLnQkC9EgmNhq+excaeNbXkj/n32HzT3wJgRMAj57qg1dElhL/vILqNBW4zep1QgCpfio1zOzkc0tkWaJaImMGjFSXqvH2t5SIDKzqyD6/GCcxltlUQJNunkhn7FvAH4HGAakw+ogvDhguRcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGiv8Ant; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGiv8Ant"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCn/Ycwrut66144uUrLT80zpCgg+RoqrOgG6fdXeCGY=;
	b=cGiv8Antlj7IPtHmOzm8Fn3dWgANpL/M1I3ulAlEXO5EckvMrb6avge4NW+NmjaYSupRaI
	Trhd+UysV/dkSP9S9xRQ7xvzBzyviPgDz+09sIH6hlhjNf412jF1rHwVHb/vNSXm1yIrAX
	PzAb8rH/7KsIGuljlaFmSdjeySkI8yE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-w_h5KMCUOy67bYeZnNAPSA-1; Mon,
 31 Aug 2026 16:24:25 -0400
X-MC-Unique: w_h5KMCUOy67bYeZnNAPSA-1
X-Mimecast-MFC-AGG-ID: w_h5KMCUOy67bYeZnNAPSA_1788207862
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6427A18E678F;
	Mon, 31 Aug 2026 20:24:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 597B21800347;
	Mon, 31 Aug 2026 20:24:15 +0000 (UTC)
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
Subject: [PATCH v4 29/43] qapi: convert trivial intro sections for block-export.json
Date: Mon, 31 Aug 2026 16:19:31 -0400
Message-ID: <20260831201945.287730-30-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Cbns7zVo9Vquge0jD7NQ7N4Byez7YQbkGj37aTcTCYU_1788207862
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-export.json | 50 +++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index dd724acf1cb..154f07b0b95 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -80,9 +80,8 @@
 
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
@@ -97,9 +96,8 @@
 
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
@@ -121,8 +119,7 @@
 
 ##
 # @BlockExportOptionsVhostUserBlk:
-#
-# A vhost-user-blk block export.
+#     A vhost-user-blk block export.
 #
 # @addr: The vhost-user socket on which to listen.  Both 'unix' and
 #     'fd' `SocketAddress` types are supported.  Passed fds must be
@@ -143,8 +140,7 @@
 
 ##
 # @FuseExportAllowOther:
-#
-# Possible allow_other modes for FUSE exports.
+#     Possible allow_other modes for FUSE exports.
 #
 # @off: Do not pass allow_other as a mount option.
 #
@@ -195,8 +191,7 @@
 
 ##
 # @BlockExportOptionsVduseBlk:
-#
-# A vduse-blk block export.
+#     A vduse-blk block export.
 #
 # @name: the name of VDUSE device (must be unique across the host).
 #
@@ -221,8 +216,7 @@
 
 ##
 # @NbdServerAddOptions:
-#
-# An NBD block export, per legacy `nbd-server-add` command.
+#     An NBD block export, per legacy `nbd-server-add` command.
 #
 # @device: The device name or node name of the node to be exported
 #
@@ -266,8 +260,7 @@
 
 ##
 # @BlockExportRemoveMode:
-#
-# Mode for removing a block export.
+#     Mode for removing a block export.
 #
 # @safe: Remove export if there are no existing connections, fail
 #     otherwise.
@@ -289,8 +282,7 @@
 
 ##
 # @nbd-server-remove:
-#
-# Remove NBD export by name.
+#     Remove NBD export by name.
 #
 # @name: Block export id.
 #
@@ -316,9 +308,8 @@
 
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
@@ -327,8 +318,7 @@
 
 ##
 # @BlockExportType:
-#
-# An enumeration of block export types
+#     An enumeration of block export types
 #
 # @nbd: NBD export
 #
@@ -412,9 +402,8 @@
 
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
@@ -436,8 +425,7 @@
 
 ##
 # @block-export-add:
-#
-# Creates a new block export.
+#     Creates a new block export.
 #
 # Since: 5.2
 ##
@@ -470,8 +458,7 @@
 
 ##
 # @BLOCK_EXPORT_DELETED:
-#
-# Emitted when a block export is removed and its id can be reused.
+#     Emitted when a block export is removed and its id can be reused.
 #
 # @id: Block export id.
 #
@@ -482,8 +469,7 @@
 
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

