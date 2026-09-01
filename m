Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B03CF1F1
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291870; cv=none; b=MEWaVTPRNP6N+/WEZmmJYDkRRnuTCpwCuIRLN7PJc1b1i7R5CCzJtA/rx0cmWYhi8mTMDN9s/nJNYSHWxEy2hUYzoGg1i2B3AwtMbu/NgLeOHPzZwcwusjupS8fvLQI2dQ2dgZnwjj5VWDYHJFg9EKdLOc+esKmTcIr2ddJAaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291870; c=relaxed/simple;
	bh=dZPvO6UqZlVf08FfkA55LrZ3gvywctigKSniRrtXM3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=NQ6O6bvzcDbz3Rnfkqf3TwIbyXZOC4hx7pRqy3ZLh3xdIyaAfRhL+/RRbGzs4yi2Jngz0UJEWHz2g3Wnw+j3IdQ0j8ZpkqBXorNrRTVOYrCJ6MCn/TgFPcmFLvrsDITGIqU2VzNw/xSDOtOO9Eoqi1dxI58pJSqWIxf6N7I5QRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WE8F4GLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE8F4GLB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788291867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXs9ZoCMIW81UKmox27vhq3w0IIdoH6Hk397Y83Mw0s=;
	b=WE8F4GLBIP88ivsjSMprsb0KC05raCUG3Nzd7ZKDVhWk2TLqBij2HtAW2OmD9K6a1q15b7
	pj6xc5y5recYffSCoTeoGxBlw0UalQd3eUdoqa0+ueju8OGvGzqX93Drz8x9bqwC/XrZ5z
	NWE9+xtsiLYbbNi1oZTgRXzecyAdBCU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-b0QSz537OYWv-ricN51PRw-1; Tue,
 01 Sept 2026 15:44:26 -0400
X-MC-Unique: b0QSz537OYWv-ricN51PRw-1
X-Mimecast-MFC-AGG-ID: b0QSz537OYWv-ricN51PRw_1788291864
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F9DD1977405;
	Tue,  1 Sep 2026 19:44:24 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6ED4A18005B8;
	Tue,  1 Sep 2026 19:44:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-block@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Fabiano Rosas <farosas@suse.de>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Peter Xu <peterx@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 12/12] qapi: convert simple command intros for block-core.json
Date: Tue,  1 Sep 2026 15:43:24 -0400
Message-ID: <20260901194324.458482-13-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: t15ZPRFON5oejudu6Hrd95BwyEyCXuV67GHsitkpvzI_1788291864
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 96 +++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 50 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 33e1147792b..29f011dc209 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1816,12 +1816,12 @@
 
 ##
 # @change-backing-file:
-#
-# Change the backing file in the image file metadata.  This does not
-# cause QEMU to reopen the image file to reparse the backing filename
-# (it may, however, perform a reopen to change permissions from r/o ->
-# r/w -> r/o, if needed).  The new backing file string is written into
-# the image file metadata, and the QEMU internal strings are updated.
+#     Change the backing file in the image file metadata.  This does
+#     not cause QEMU to reopen the image file to reparse the backing
+#     filename (it may, however, perform a reopen to change
+#     permissions from r/o -> r/w -> r/o, if needed).  The new backing
+#     file string is written into the image file metadata, and the
+#     QEMU internal strings are updated.
 #
 # @image-node-name: The name of the block driver state node of the
 #     image to modify.  The "device" argument is used to verify
@@ -1957,12 +1957,12 @@
 
 ##
 # @drive-backup:
-#
-# Start a point-in-time copy of a block device to a new destination.
-# The status of ongoing `drive-backup` operations can be checked with
-# `query-block-jobs` where the `BlockJobInfo`.type field has the value
-# 'backup'.  The operation can be stopped before it has completed
-# using the `job-cancel` or `block-job-cancel` command.
+#     Start a point-in-time copy of a block device to a new
+#     destination.  The status of ongoing `drive-backup` operations
+#     can be checked with `query-block-jobs` where the
+#     `BlockJobInfo`.type field has the value 'backup'.  The operation
+#     can be stopped before it has completed using the `job-cancel` or
+#     `block-job-cancel` command.
 #
 # Features:
 #
@@ -1988,12 +1988,12 @@
 
 ##
 # @blockdev-backup:
-#
-# Start a point-in-time copy of a block device to a new destination.
-# The status of ongoing `blockdev-backup` operations can be checked
-# with `query-block-jobs` where the `BlockJobInfo`.type field has the
-# value 'backup'.  The operation can be stopped before it has
-# completed using the `job-cancel` or `block-job-cancel` command.
+#     Start a point-in-time copy of a block device to a new
+#     destination.  The status of ongoing `blockdev-backup` operations
+#     can be checked with `query-block-jobs` where the
+#     `BlockJobInfo`.type field has the value 'backup'.  The operation
+#     can be stopped before it has completed using the `job-cancel` or
+#     `block-job-cancel` command.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2185,13 +2185,13 @@
 
 ##
 # @drive-mirror:
-#
-# Start mirroring a block device's writes to a new destination.
-# target specifies the target of the new image.  If the file exists,
-# or if it is a device, it will be used as the new destination for
-# writes.  If it does not exist, a new file will be created.  @format
-# specifies the format of the mirror image, default is to probe if
-# mode='existing', else the format of the source.
+#     Start mirroring a block device's writes to a new destination.
+#     target specifies the target of the new image.  If the file
+#     exists, or if it is a device, it will be used as the new
+#     destination for writes.  If it does not exist, a new file will
+#     be created.  @format specifies the format of the mirror image,
+#     default is to probe if mode='existing', else the format of the
+#     source.
 #
 # Errors:
 #     - If @device is not a valid block device, GenericError
@@ -2387,10 +2387,9 @@
 
 ##
 # @block-dirty-bitmap-remove:
-#
-# Stop write tracking and remove the dirty bitmap that was created
-# with `block-dirty-bitmap-add`.  If the bitmap is persistent, remove
-# it from its storage too.
+#     Stop write tracking and remove the dirty bitmap that was created
+#     with `block-dirty-bitmap-add`.  If the bitmap is persistent,
+#     remove it from its storage too.
 #
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
@@ -4937,10 +4936,9 @@
 
 ##
 # @blockdev-del:
-#
-# Deletes a block device that has been added using `blockdev-add`.
-# The command will fail if the node is attached to a device or is
-# otherwise being used.
+#     Deletes a block device that has been added using `blockdev-add`.
+#     The command will fail if the node is attached to a device or is
+#     otherwise being used.
 #
 # @node-name: Name of the graph node to delete.
 #
@@ -5453,9 +5451,9 @@
 
 ##
 # @blockdev-create:
-#
-# Starts a job to create an image format on a given node.  The job is
-# automatically finalized, but a manual `job-dismiss` is required.
+#     Starts a job to create an image format on a given node.  The job
+#     is automatically finalized, but a manual `job-dismiss` is
+#     required.
 #
 # @job-id: Identifier for the newly created job.
 #
@@ -5510,10 +5508,9 @@
 
 ##
 # @x-blockdev-amend:
-#
-# Starts a job to amend format specific options of an existing open
-# block device.  The job is automatically finalized, but a manual
-# `job-dismiss` is required.
+#     Starts a job to amend format specific options of an existing
+#     open block device.  The job is automatically finalized, but a
+#     manual `job-dismiss` is required.
 #
 # @job-id: Identifier for the newly created job.
 #
@@ -6087,11 +6084,10 @@
 
 ##
 # @blockdev-snapshot-internal-sync:
-#
-# Synchronously take an internal snapshot of a block device, when the
-# format of the image used supports it.  If the name is an empty
-# string, or a snapshot with name already exists, the operation will
-# fail.
+#     Synchronously take an internal snapshot of a block device, when
+#     the format of the image used supports it.  If the name is an
+#     empty string, or a snapshot with name already exists, the
+#     operation will fail.
 #
 # Errors:
 #     - If @device is not a valid block device, GenericError
@@ -6119,11 +6115,11 @@
 
 ##
 # @blockdev-snapshot-delete-internal-sync:
-#
-# Synchronously delete an internal snapshot of a block device, when
-# the format of the image used support it.  The snapshot is identified
-# by name or id or both.  One of the name or id is required.  Return
-# `SnapshotInfo` for the successfully deleted snapshot.
+#     Synchronously delete an internal snapshot of a block device,
+#     when the format of the image used support it.  The snapshot is
+#     identified by name or id or both.  One of the name or id is
+#     required.  Return `SnapshotInfo` for the successfully deleted
+#     snapshot.
 #
 # @device: the device name or node-name of a root node to delete the
 #     snapshot from
-- 
2.55.0

