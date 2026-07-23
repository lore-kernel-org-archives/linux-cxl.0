Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EB3749F4
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782564; cv=none; b=eiKOPrn5YWeGNiYI83Cwd1AauGKJy9FbfmH9qmV68/caSzjv8HWw5dgrwHW9Ge9o/HDW5jflBrmSkCMRyoY43fUwqte1NAGZ5QujEI0wXUD8IV1nJff9Kfg3SK3uCFpXzhxXaeHhYhJN5A+hYPdHM8N6EZKkdCre3jhGIZoDecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782564; c=relaxed/simple;
	bh=qme0KhCqc0ALf42sTgfNTv6/zZ4KERwfN8NpQ5kHkdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=KumGml6lN/LNmUu/rX/oKCSogKSG2G71tdBlo+eAMn3ZP0v8MGZBExKi7A0dU7jqdz9S3EcvxwTeTmiyU4Qne+RhASfxuqT252bWg+K8PqXg9+Hodsqt+Gh1GEO76XVH9L8xC3likDSq87GtcyKhvUSCUovzfiXpaSjZq+k5c8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fz90D0iY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fz90D0iY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+QDeFBwgjejev9Us3uKchsWQc+5y6CyBFG5cfqQApw=;
	b=Fz90D0iYvDlUuodBXJawCqkkctYsTYOkLf+YRrQxmibg2OQpsSAHL5V0avJlZlYihYgGpO
	2eJ0LTboOBNCQPux4kBWLl+iaVwHb5Xv4HeGUKhs1n+bAmAD66gAYr0z4jhyN86GIMQj+g
	Qh8qN9scysyBpTga3nQE4M5Fd8iP+Gk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-5VjhXeaENGKb1wMnUtpGgg-1; Thu,
 23 Jul 2026 00:55:38 -0400
X-MC-Unique: 5VjhXeaENGKb1wMnUtpGgg-1
X-Mimecast-MFC-AGG-ID: 5VjhXeaENGKb1wMnUtpGgg_1784782535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1B781805F17;
	Thu, 23 Jul 2026 04:55:35 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95AAF180029D;
	Thu, 23 Jul 2026 04:55:23 +0000 (UTC)
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
Subject: [PATCH v2 44/44] qapi: convert trivial intro sections for block-core.json
Date: Thu, 23 Jul 2026 00:48:05 -0400
Message-ID: <20260723044805.527643-45-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: A57x3hM_M7ETP9kHjUL0yPUne1MCmNIoN1-a27m8m2M_1784782535
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 646 +++++++++++++++++--------------------------
 1 file changed, 255 insertions(+), 391 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f87b078505..bd98af2f298 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -132,8 +132,7 @@
 
 ##
 # @VmdkExtentInfo:
-#
-# Information about a VMDK extent file
+#     Information about a VMDK extent file
 #
 # @filename: Name of the extent file
 #
@@ -257,9 +256,8 @@
 
 ##
 # @ImageInfoSpecific:
-#
-# A discriminated record of image format specific information
-# structures.
+#     A discriminated record of image format specific information
+#     structures.
 #
 # @type: block driver name
 #
@@ -341,8 +339,7 @@
 
 ##
 # @BlockNodeInfo:
-#
-# Information about a QEMU image file
+#     Information about a QEMU image file
 #
 # @filename: name of the image file
 #
@@ -386,9 +383,8 @@
 
 ##
 # @ImageInfo:
-#
-# Information about a QEMU image file, and potentially its backing
-# image
+#     Information about a QEMU image file, and potentially its backing
+#     image
 #
 # @backing-image: info of the backing image
 #
@@ -402,10 +398,9 @@
 
 ##
 # @BlockChildInfo:
-#
-# Information about all nodes in the block graph starting at some
-# node, annotated with information about that node in relation to its
-# parent.
+#     Information about all nodes in the block graph starting at some
+#     node, annotated with information about that node in relation to
+#     its parent.
 #
 # @name: Child name of the root node in the `BlockGraphInfo` struct,
 #     in its role as the child of some undescribed parent node
@@ -422,10 +417,9 @@
 
 ##
 # @BlockGraphInfo:
-#
-# Information about all nodes in a block (sub)graph in the form of
-# `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains the
-# information for the (sub)graph's root node.
+#     Information about all nodes in a block (sub)graph in the form of
+#     `BlockNodeInfo` data.  The base `BlockNodeInfo` struct contains
+#     the information for the (sub)graph's root node.
 #
 # @children: Array of links to this node's child nodes' information
 #
@@ -437,8 +431,7 @@
 
 ##
 # @ImageCheck:
-#
-# Information about a QEMU image file check
+#     Information about a QEMU image file check
 #
 # @filename: name of the image file checked
 #
@@ -481,8 +474,8 @@
 
 ##
 # @MapEntry:
-#
-# Mapping information from a virtual block range to a host file range
+#     Mapping information from a virtual block range to a host file
+#     range
 #
 # @start: virtual (guest) offset of the first byte described by this
 #     entry
@@ -520,8 +513,7 @@
 
 ##
 # @BlockdevCacheInfo:
-#
-# Cache mode information for a block device
+#     Cache mode information for a block device
 #
 # @writeback: true if writeback mode is enabled
 #
@@ -551,8 +543,7 @@
 
 ##
 # @BlockDeviceInfo:
-#
-# Information about the backing device for a block device.
+#     Information about the backing device for a block device.
 #
 # @file: the filename of the backing device
 #
@@ -668,8 +659,7 @@
 
 ##
 # @BlockDeviceIoStatus:
-#
-# An enumeration of block device I/O status.
+#     An enumeration of block device I/O status.
 #
 # @ok: The last I/O operation has succeeded
 #
@@ -684,8 +674,7 @@
 
 ##
 # @BlockDirtyInfo:
-#
-# Block dirty bitmap information.
+#     Block dirty bitmap information.
 #
 # @name: the name of the dirty bitmap (Since 2.4)
 #
@@ -717,8 +706,7 @@
 
 ##
 # @Qcow2BitmapInfoFlags:
-#
-# An enumeration of flags that a bitmap can report to the user.
+#     An enumeration of flags that a bitmap can report to the user.
 #
 # @in-use: This flag is set by any process actively modifying the
 #     qcow2 file, and cleared when the updated bitmap is flushed to
@@ -736,8 +724,7 @@
 
 ##
 # @Qcow2BitmapInfo:
-#
-# Qcow2 bitmap information.
+#     Qcow2 bitmap information.
 #
 # @name: the name of the bitmap
 #
@@ -753,8 +740,7 @@
 
 ##
 # @BlockLatencyHistogramInfo:
-#
-# Block latency histogram.
+#     Block latency histogram.
 #
 # @boundaries: list of interval boundary values in nanoseconds, all
 #     greater than zero and in ascending order.  For example, the list
@@ -781,9 +767,8 @@
 
 ##
 # @BlockInfo:
-#
-# Block device information.  This structure describes a virtual device
-# and the backing device associated with it.
+#     Block device information.  This structure describes a virtual
+#     device and the backing device associated with it.
 #
 # @device: The device name associated with the virtual device.
 #
@@ -852,8 +837,7 @@
 
 ##
 # @query-block:
-#
-# Get a list of `BlockInfo` for all virtual block devices.
+#     Get a list of `BlockInfo` for all virtual block devices.
 #
 # @flat: Omit nested data about the backing image, i.e. `BlockInfo`
 #     member 'inserted.image.backing-image' will be absent.
@@ -954,8 +938,7 @@
 
 ##
 # @BlockDeviceTimedStats:
-#
-# Statistics of a block device during a given interval of time.
+#     Statistics of a block device during a given interval of time.
 #
 # @interval_length: Interval used for calculating the statistics, in
 #     seconds.
@@ -1021,8 +1004,7 @@
 
 ##
 # @BlockDeviceStats:
-#
-# Statistics of a virtual block device or a block backing device.
+#     Statistics of a virtual block device or a block backing device.
 #
 # @rd_bytes: The number of bytes read by the device.
 #
@@ -1160,8 +1142,7 @@
 
 ##
 # @BlockStatsSpecificFile:
-#
-# File driver statistics
+#     File driver statistics
 #
 # @discard-nb-ok: The number of successful discard operations
 #     performed by the driver.
@@ -1181,8 +1162,7 @@
 
 ##
 # @BlockStatsSpecificNvme:
-#
-# NVMe driver statistics
+#     NVMe driver statistics
 #
 # @completion-errors: The number of completion errors.
 #
@@ -1202,8 +1182,7 @@
 
 ##
 # @BlockStatsSpecific:
-#
-# Block driver specific statistics
+#     Block driver specific statistics
 #
 # @driver: block driver name
 #
@@ -1220,8 +1199,7 @@
 
 ##
 # @BlockStats:
-#
-# Statistics of a virtual block device or a block backing device.
+#     Statistics of a virtual block device or a block backing device.
 #
 # @device: If the stats are for a virtual block device, the name
 #     corresponding to the virtual block device.
@@ -1254,8 +1232,7 @@
 
 ##
 # @query-blockstats:
-#
-# Query the `BlockStats` for all virtual block devices.
+#     Query the `BlockStats` for all virtual block devices.
 #
 # @query-nodes: If true, the command will query all the block nodes
 #     that have a node name, in a list which will include "parent"
@@ -1378,10 +1355,9 @@
 
 ##
 # @BlockdevOnError:
-#
-# An enumeration of possible behaviors for errors on I/O operations.
-# The exact meaning depends on whether the I/O was initiated by a
-# guest or by a block job
+#     An enumeration of possible behaviors for errors on I/O
+#     operations.  The exact meaning depends on whether the I/O was
+#     initiated by a guest or by a block job
 #
 # @report: for guest operations, report the error to the guest; for
 #     jobs, cancel the job
@@ -1406,9 +1382,8 @@
 
 ##
 # @MirrorSyncMode:
-#
-# An enumeration of possible behaviors for the initial synchronization
-# phase of storage mirroring.
+#     An enumeration of possible behaviors for the initial
+#     synchronization phase of storage mirroring.
 #
 # @top: copies data in the topmost image to the destination
 #
@@ -1429,9 +1404,8 @@
 
 ##
 # @BitmapSyncMode:
-#
-# An enumeration of possible behaviors for the synchronization of a
-# bitmap when used for data copy operations.
+#     An enumeration of possible behaviors for the synchronization of
+#     a bitmap when used for data copy operations.
 #
 # @on-success: The bitmap is only synced when the operation is
 #     successful.  This is the behavior always used for incremental
@@ -1450,9 +1424,8 @@
 
 ##
 # @MirrorCopyMode:
-#
-# An enumeration whose values tell the mirror block job when to
-# trigger writes to the target.
+#     An enumeration whose values tell the mirror block job when to
+#     trigger writes to the target.
 #
 # @background: copy data in background only.
 #
@@ -1467,8 +1440,7 @@
 
 ##
 # @BlockJobInfoMirror:
-#
-# Information specific to mirror block jobs.
+#     Information specific to mirror block jobs.
 #
 # @actively-synced: Whether the source is actively synced to the
 #     target, i.e. same data and new writes are done synchronously to
@@ -1481,8 +1453,7 @@
 
 ##
 # @BlockJobInfo:
-#
-# Information about a long-running block device operation.
+#     Information about a long-running block device operation.
 #
 # @type: the job type ('stream' for image streaming)
 #
@@ -1534,8 +1505,7 @@
 
 ##
 # @query-block-jobs:
-#
-# Return information about long-running block device operations.
+#     Return information about long-running block device operations.
 #
 # Returns: a list of job info for each active block job
 #
@@ -1577,9 +1547,8 @@
 
 ##
 # @NewImageMode:
-#
-# An enumeration that tells QEMU how to set the backing file path in a
-# new image file.
+#     An enumeration that tells QEMU how to set the backing file path
+#     in a new image file.
 #
 # @existing: QEMU should look for an existing image file.
 #
@@ -1636,9 +1605,8 @@
 
 ##
 # @BackupPerf:
-#
-# Optional parameters for backup.  These parameters don't affect
-# functionality, but may significantly affect performance.
+#     Optional parameters for backup.  These parameters don't affect
+#     functionality, but may significantly affect performance.
 #
 # @use-copy-range: Use copy offloading.  Default false.
 #
@@ -1782,8 +1750,7 @@
 
 ##
 # @blockdev-snapshot-sync:
-#
-# Takes a synchronous snapshot of a block device.
+#     Takes a synchronous snapshot of a block device.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -1845,12 +1812,12 @@
 
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
@@ -1986,12 +1953,12 @@
 
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
@@ -2017,12 +1984,12 @@
 
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
@@ -2043,8 +2010,7 @@
 
 ##
 # @query-named-block-nodes:
-#
-# Get the named block driver list
+#     Get the named block driver list
 #
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
@@ -2140,8 +2106,7 @@
 
 ##
 # @BlockPermission:
-#
-# Enum of base block permissions.
+#     Enum of base block permissions.
 #
 # @consistent-read: A user that has the "permission" of consistent
 #     reads is guaranteed that their view of the contents of the block
@@ -2171,8 +2136,7 @@
 
 ##
 # @XDbgBlockGraphEdge:
-#
-# Block Graph edge description for `x-debug-query-block-graph`.
+#     Block Graph edge description for `x-debug-query-block-graph`.
 #
 # @parent: parent id
 #
@@ -2194,8 +2158,7 @@
 
 ##
 # @XDbgBlockGraph:
-#
-# Block Graph - list of nodes and list of edges.
+#     Block Graph - list of nodes and list of edges.
 #
 # Since: 4.0
 ##
@@ -2204,8 +2167,7 @@
 
 ##
 # @x-debug-query-block-graph:
-#
-# Get the block graph.
+#     Get the block graph.
 #
 # Features:
 #
@@ -2219,13 +2181,13 @@
 
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
@@ -2247,8 +2209,7 @@
 
 ##
 # @DriveMirror:
-#
-# A set of parameters describing drive mirror setup.
+#     A set of parameters describing drive mirror setup.
 #
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
@@ -2399,9 +2360,8 @@
 
 ##
 # @block-dirty-bitmap-add:
-#
-# Create a dirty bitmap with a name on the node, and start tracking
-# the writes.
+#     Create a dirty bitmap with a name on the node, and start
+#     tracking the writes.
 #
 # Errors:
 #     - If @node is not a valid block device or node, DeviceNotFound
@@ -2421,10 +2381,9 @@
 
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
@@ -2445,10 +2404,9 @@
 
 ##
 # @block-dirty-bitmap-clear:
-#
-# Clear (reset) a dirty bitmap on the device, so that an incremental
-# backup from this point in time forward will only backup clusters
-# modified after this clear operation.
+#     Clear (reset) a dirty bitmap on the device, so that an
+#     incremental backup from this point in time forward will only
+#     backup clusters modified after this clear operation.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2468,8 +2426,8 @@
 
 ##
 # @block-dirty-bitmap-enable:
-#
-# Enables a dirty bitmap so that it will begin tracking disk changes.
+#     Enables a dirty bitmap so that it will begin tracking disk
+#     changes.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2489,8 +2447,8 @@
 
 ##
 # @block-dirty-bitmap-disable:
-#
-# Disables a dirty bitmap so that it will stop tracking disk changes.
+#     Disables a dirty bitmap so that it will stop tracking disk
+#     changes.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2543,8 +2501,7 @@
 
 ##
 # @BlockDirtyBitmapSha256:
-#
-# SHA256 hash of dirty bitmap data
+#     SHA256 hash of dirty bitmap data
 #
 # @sha256: ASCII representation of SHA256 bitmap hash
 #
@@ -2555,8 +2512,7 @@
 
 ##
 # @x-debug-block-dirty-bitmap-sha256:
-#
-# Get bitmap SHA256.
+#     Get bitmap SHA256.
 #
 # Features:
 #
@@ -2575,8 +2531,7 @@
 
 ##
 # @blockdev-mirror:
-#
-# Start mirroring a block device's writes to a new destination.
+#     Start mirroring a block device's writes to a new destination.
 #
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
@@ -2662,8 +2617,7 @@
 
 ##
 # @BlockIOThrottle:
-#
-# A set of parameters describing block throttling.
+#     A set of parameters describing block throttling.
 #
 # @device: Block device name
 #
@@ -2746,11 +2700,10 @@
 
 ##
 # @ThrottleLimits:
-#
-# Limit parameters for throttling.  Since some limit combinations are
-# illegal, limits should always be set in one transaction.  All fields
-# are optional.  When setting limits, if a field is missing the
-# current value is not changed.
+#     Limit parameters for throttling.  Since some limit combinations
+#     are illegal, limits should always be set in one transaction.
+#     All fields are optional.  When setting limits, if a field is
+#     missing the current value is not changed.
 #
 # @iops-total: limit total I/O operations per second
 #
@@ -2814,8 +2767,7 @@
 
 ##
 # @ThrottleGroupProperties:
-#
-# Properties for throttle-group objects.
+#     Properties for throttle-group objects.
 #
 # @limits: limits to apply for this throttle group
 #
@@ -3222,8 +3174,7 @@
 
 ##
 # @BlockJobChangeOptions:
-#
-# Block job options that can be changed after job creation.
+#     Block job options that can be changed after job creation.
 #
 # @id: The job identifier
 #
@@ -3238,8 +3189,7 @@
 
 ##
 # @block-job-change:
-#
-# Change the block job's options.
+#     Change the block job's options.
 #
 # Since: 8.2
 ##
@@ -3248,8 +3198,7 @@
 
 ##
 # @BlockdevDiscardOptions:
-#
-# Determines how to handle discard requests.
+#     Determines how to handle discard requests.
 #
 # @ignore: Ignore the request
 #
@@ -3262,10 +3211,9 @@
 
 ##
 # @BlockdevDetectZeroesOptions:
-#
-# Describes the operation mode for the automatic conversion of plain
-# zero writes by the OS to driver specific optimized zero write
-# commands.
+#     Describes the operation mode for the automatic conversion of
+#     plain zero writes by the OS to driver specific optimized zero
+#     write commands.
 #
 # @off: Disabled (default)
 #
@@ -3282,8 +3230,7 @@
 
 ##
 # @BlockdevAioOptions:
-#
-# Selects the AIO backend to handle I/O requests
+#     Selects the AIO backend to handle I/O requests
 #
 # @threads: Use QEMU's thread pool
 #
@@ -3299,8 +3246,7 @@
 
 ##
 # @BlockdevCacheOptions:
-#
-# Includes cache-related options for block devices
+#     Includes cache-related options for block devices
 #
 # @direct: enables use of O_DIRECT (bypass the host page cache;
 #     default: false)
@@ -3315,8 +3261,7 @@
 
 ##
 # @BlockdevDriver:
-#
-# Drivers that are supported in block device operations.
+#     Drivers that are supported in block device operations.
 #
 # @throttle: Since 2.11
 #
@@ -3358,8 +3303,7 @@
 
 ##
 # @BlockdevOptionsFile:
-#
-# Driver specific block device options for the file backend.
+#     Driver specific block device options for the file backend.
 #
 # @filename: path to the image file
 #
@@ -3418,8 +3362,7 @@
 
 ##
 # @BlockdevOptionsNull:
-#
-# Driver specific block device options for the null backend.
+#     Driver specific block device options for the null backend.
 #
 # @size: size of the device in bytes.
 #
@@ -3438,8 +3381,7 @@
 
 ##
 # @BlockdevOptionsNVMe:
-#
-# Driver specific block device options for the NVMe backend.
+#     Driver specific block device options for the NVMe backend.
 #
 # @device: PCI controller address of the NVMe device in format
 #     hhhh:bb:ss.f (host:bus:slot.function)
@@ -3456,8 +3398,7 @@
 
 ##
 # @BlockdevOptionsVVFAT:
-#
-# Driver specific block device options for the vvfat protocol.
+#     Driver specific block device options for the vvfat protocol.
 #
 # @dir: directory to be exported as FAT image
 #
@@ -3481,9 +3422,8 @@
 
 ##
 # @BlockdevOptionsGenericFormat:
-#
-# Driver specific block device options for image format that have no
-# option besides their data source.
+#     Driver specific block device options for image format that have
+#     no option besides their data source.
 #
 # @file: reference to or definition of the data source block device
 #
@@ -3494,8 +3434,7 @@
 
 ##
 # @BlockdevOptionsLUKS:
-#
-# Driver specific block device options for LUKS.
+#     Driver specific block device options for LUKS.
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when doing a metadata-only
@@ -3512,9 +3451,9 @@
 
 ##
 # @BlockdevOptionsGenericCOWFormat:
-#
-# Driver specific block device options for image format that have no
-# option besides their data source and an optional backing file.
+#     Driver specific block device options for image format that have
+#     no option besides their data source and an optional backing
+#     file.
 #
 # @backing: reference to or definition of the backing file block
 #     device, null disables the backing file entirely.  Defaults to
@@ -3528,8 +3467,7 @@
 
 ##
 # @Qcow2OverlapCheckMode:
-#
-# General overlap check modes.
+#     General overlap check modes.
 #
 # @none: Do not perform any checks
 #
@@ -3548,12 +3486,11 @@
 
 ##
 # @Qcow2OverlapCheckFlags:
-#
-# Structure of flags for each metadata structure.  Setting a field to
-# 'true' makes QEMU guard that Qcow2 format structure against
-# unintended overwriting.  See Qcow2 format specification for detailed
-# information on these structures.  The default value is chosen
-# according to the template given.
+#     Structure of flags for each metadata structure.  Setting a field
+#     to 'true' makes QEMU guard that Qcow2 format structure against
+#     unintended overwriting.  See Qcow2 format specification for
+#     detailed information on these structures.  The default value is
+#     chosen according to the template given.
 #
 # @template: Specifies a template mode which can be adjusted using the
 #     other flags, defaults to 'cached'
@@ -3592,9 +3529,8 @@
 
 ##
 # @Qcow2OverlapChecks:
-#
-# Specifies which metadata structures should be guarded against
-# unintended overwriting.
+#     Specifies which metadata structures should be guarded against
+#     unintended overwriting.
 #
 # @flags: set of flags for separate specification of each metadata
 #     structure type
@@ -3631,8 +3567,7 @@
 
 ##
 # @BlockdevOptionsQcow:
-#
-# Driver specific block device options for qcow.
+#     Driver specific block device options for qcow.
 #
 # @encrypt: Image decryption options.  Mandatory for encrypted images,
 #     except when doing a metadata-only probe of the image.
@@ -3668,9 +3603,8 @@
 
 ##
 # @BlockdevOptionsPreallocate:
-#
-# Filter driver intended to be inserted between format and protocol
-# node and do preallocation in protocol node on write.
+#     Filter driver intended to be inserted between format and
+#     protocol node and do preallocation in protocol node on write.
 #
 # @prealloc-align: on preallocation, align file length to this number,
 #     default 1048576 (1M)
@@ -3685,8 +3619,7 @@
 
 ##
 # @BlockdevOptionsQcow2:
-#
-# Driver specific block device options for qcow2.
+#     Driver specific block device options for qcow2.
 #
 # @lazy-refcounts: whether to enable the lazy refcounts feature
 #     (default is taken from the image file)
@@ -3839,8 +3772,7 @@
 
 ##
 # @BlkdebugEvent:
-#
-# Trigger events supported by blkdebug.
+#     Trigger events supported by blkdebug.
 #
 # @l1_shrink_write_table: write zeros to the l1 table to shrink image.
 #     (since 2.11)
@@ -3876,8 +3808,7 @@
 
 ##
 # @BlkdebugIOType:
-#
-# Kinds of I/O that blkdebug can inject errors in.
+#     Kinds of I/O that blkdebug can inject errors in.
 #
 # @read: .bdrv_co_preadv()
 #
@@ -3899,8 +3830,7 @@
 
 ##
 # @BlkdebugInjectErrorOptions:
-#
-# Describes a single error injection for blkdebug.
+#     Describes a single error injection for blkdebug.
 #
 # @event: trigger event
 #
@@ -3938,8 +3868,7 @@
 
 ##
 # @BlkdebugSetStateOptions:
-#
-# Describes a single state-change event for blkdebug.
+#     Describes a single state-change event for blkdebug.
 #
 # @event: trigger event
 #
@@ -3958,8 +3887,7 @@
 
 ##
 # @BlockdevOptionsBlkdebug:
-#
-# Driver specific block device options for blkdebug.
+#     Driver specific block device options for blkdebug.
 #
 # @image: underlying raw block device (or image file)
 #
@@ -4020,8 +3948,7 @@
 
 ##
 # @BlockdevOptionsBlklogwrites:
-#
-# Driver specific block device options for blklogwrites.
+#     Driver specific block device options for blklogwrites.
 #
 # @file: block device
 #
@@ -4047,8 +3974,7 @@
 
 ##
 # @BlockdevOptionsBlkverify:
-#
-# Driver specific block device options for blkverify.
+#     Driver specific block device options for blkverify.
 #
 # @test: block device to be tested
 #
@@ -4062,8 +3988,7 @@
 
 ##
 # @BlockdevOptionsBlkreplay:
-#
-# Driver specific block device options for blkreplay.
+#     Driver specific block device options for blkreplay.
 #
 # @image: disk image which should be controlled with blkreplay
 #
@@ -4074,8 +3999,7 @@
 
 ##
 # @QuorumReadPattern:
-#
-# An enumeration of quorum read patterns.
+#     An enumeration of quorum read patterns.
 #
 # @quorum: read all the children and do a quorum vote on reads
 #
@@ -4087,8 +4011,7 @@
 
 ##
 # @BlockdevOptionsQuorum:
-#
-# Driver specific block device options for Quorum
+#     Driver specific block device options for Quorum
 #
 # @blkverify: true if the driver must print content mismatch set to
 #     false by default
@@ -4114,8 +4037,7 @@
 
 ##
 # @BlockdevOptionsIoUring:
-#
-# Driver specific block device options for the io_uring backend.
+#     Driver specific block device options for the io_uring backend.
 #
 # @filename: path to the image file
 #
@@ -4127,8 +4049,8 @@
 
 ##
 # @BlockdevOptionsNvmeIoUring:
-#
-# Driver specific block device options for the nvme-io_uring backend.
+#     Driver specific block device options for the nvme-io_uring
+#     backend.
 #
 # @path: path to the NVMe namespace's character device (e.g.
 #     /dev/ng0n1).
@@ -4141,9 +4063,8 @@
 
 ##
 # @BlockdevOptionsVirtioBlkVfioPci:
-#
-# Driver specific block device options for the virtio-blk-vfio-pci
-# backend.
+#     Driver specific block device options for the virtio-blk-vfio-pci
+#     backend.
 #
 # @path: path to the PCI device's sysfs directory (e.g.
 #     /sys/bus/pci/devices/0000:00:01.0).
@@ -4156,9 +4077,8 @@
 
 ##
 # @BlockdevOptionsVirtioBlkVhostUser:
-#
-# Driver specific block device options for the virtio-blk-vhost-user
-# backend.
+#     Driver specific block device options for the
+#     virtio-blk-vhost-user backend.
 #
 # @path: path to the vhost-user UNIX domain socket.
 #
@@ -4170,9 +4090,8 @@
 
 ##
 # @BlockdevOptionsVirtioBlkVhostVdpa:
-#
-# Driver specific block device options for the virtio-blk-vhost-vdpa
-# backend.
+#     Driver specific block device options for the
+#     virtio-blk-vhost-vdpa backend.
 #
 # @path: path to the vhost-vdpa character device.
 #
@@ -4191,8 +4110,7 @@
 
 ##
 # @IscsiTransport:
-#
-# An enumeration of libiscsi transport types
+#     An enumeration of libiscsi transport types
 #
 # Since: 2.9
 ##
@@ -4201,8 +4119,7 @@
 
 ##
 # @IscsiHeaderDigest:
-#
-# An enumeration of header digests supported by libiscsi
+#     An enumeration of header digests supported by libiscsi
 #
 # Since: 2.9
 ##
@@ -4212,8 +4129,7 @@
 
 ##
 # @BlockdevOptionsIscsi:
-#
-# Driver specific block device options for iscsi
+#     Driver specific block device options for iscsi
 #
 # @transport: The iscsi transport type
 #
@@ -4415,8 +4331,7 @@
 
 ##
 # @ReplicationMode:
-#
-# An enumeration of replication modes.
+#     An enumeration of replication modes.
 #
 # @primary: Primary mode, the vm's state will be sent to secondary
 #     QEMU.
@@ -4431,8 +4346,7 @@
 
 ##
 # @BlockdevOptionsReplication:
-#
-# Driver specific block device options for replication
+#     Driver specific block device options for replication
 #
 # @mode: the replication mode
 #
@@ -4450,8 +4364,7 @@
 
 ##
 # @NFSTransport:
-#
-# An enumeration of NFS transport types
+#     An enumeration of NFS transport types
 #
 # @inet: TCP transport
 #
@@ -4462,8 +4375,7 @@
 
 ##
 # @NFSServer:
-#
-# Captures the address of the socket
+#     Captures the address of the socket
 #
 # @type: transport type used for NFS (only TCP supported)
 #
@@ -4477,8 +4389,7 @@
 
 ##
 # @BlockdevOptionsNfs:
-#
-# Driver specific block device option for NFS
+#     Driver specific block device option for NFS
 #
 # @server: host address
 #
@@ -4515,9 +4426,8 @@
 
 ##
 # @BlockdevOptionsCurlBase:
-#
-# Driver specific block device options shared by all protocols
-# supported by the curl backend.
+#     Driver specific block device options shared by all protocols
+#     supported by the curl backend.
 #
 # @url: URL of the image file
 #
@@ -4550,9 +4460,8 @@
 
 ##
 # @BlockdevOptionsCurlHttp:
-#
-# Driver specific block device options for HTTP connections over the
-# curl backend.  URLs must start with "http://".
+#     Driver specific block device options for HTTP connections over
+#     the curl backend.  URLs must start with "http://".
 #
 # @cookie: List of cookies to set; format is "name1=content1;
 #     name2=content2;" as explained by CURLOPT_COOKIE(3).  Defaults to
@@ -4576,9 +4485,8 @@
 
 ##
 # @BlockdevOptionsCurlHttps:
-#
-# Driver specific block device options for HTTPS connections over the
-# curl backend.  URLs must start with "https://".
+#     Driver specific block device options for HTTPS connections over
+#     the curl backend.  URLs must start with "https://".
 #
 # @sslverify: Whether to verify the SSL certificate's validity
 #     (defaults to true)
@@ -4591,9 +4499,8 @@
 
 ##
 # @BlockdevOptionsCurlFtp:
-#
-# Driver specific block device options for FTP connections over the
-# curl backend.  URLs must start with "ftp://".
+#     Driver specific block device options for FTP connections over
+#     the curl backend.  URLs must start with "ftp://".
 #
 # Since: 2.9
 ##
@@ -4603,9 +4510,8 @@
 
 ##
 # @BlockdevOptionsCurlFtps:
-#
-# Driver specific block device options for FTPS connections over the
-# curl backend.  URLs must start with "ftps://".
+#     Driver specific block device options for FTPS connections over
+#     the curl backend.  URLs must start with "ftps://".
 #
 # @sslverify: Whether to verify the SSL certificate's validity
 #     (defaults to true)
@@ -4618,8 +4524,7 @@
 
 ##
 # @BlockdevOptionsNbd:
-#
-# Driver specific block device options for NBD.
+#     Driver specific block device options for NBD.
 #
 # @server: NBD server address
 #
@@ -4667,8 +4572,7 @@
 
 ##
 # @BlockdevOptionsRaw:
-#
-# Driver specific block device options for the raw driver.
+#     Driver specific block device options for the raw driver.
 #
 # @offset: position where the block device starts
 #
@@ -4682,8 +4586,7 @@
 
 ##
 # @BlockdevOptionsThrottle:
-#
-# Driver specific block device options for the throttle driver
+#     Driver specific block device options for the throttle driver
 #
 # @throttle-group: the name of the throttle-group object to use.  It
 #     must already exist.
@@ -4699,8 +4602,8 @@
 
 ##
 # @BlockdevOptionsCor:
-#
-# Driver specific block device options for the copy-on-read driver.
+#     Driver specific block device options for the copy-on-read
+#     driver.
 #
 # @bottom: The name of a non-filter node (allocation-bearing layer)
 #     that limits the COR operations in the backing chain (inclusive),
@@ -4716,9 +4619,8 @@
 
 ##
 # @OnCbwError:
-#
-# An enumeration of possible behaviors for copy-before-write operation
-# failures.
+#     An enumeration of possible behaviors for copy-before-write
+#     operation failures.
 #
 # @break-guest-write: report the error to the guest.  This way, the
 #     guest will not be able to overwrite areas that cannot be backed
@@ -4735,14 +4637,13 @@
 
 ##
 # @BlockdevOptionsCbw:
-#
-# Driver specific block device options for the copy-before-write
-# driver, which does so called copy-before-write operations: when data
-# is written to the filter, the filter first reads corresponding
-# blocks from its file child and copies them to @target child.  After
-# successfully copying, the write request is propagated to file child.
-# If copying fails, the original write request is failed too and no
-# data is written to file child.
+#     Driver specific block device options for the copy-before-write
+#     driver, which does so called copy-before-write operations: when
+#     data is written to the filter, the filter first reads
+#     corresponding blocks from its file child and copies them to
+#     @target child.  After successfully copying, the write request is
+#     propagated to file child.  If copying fails, the original write
+#     request is failed too and no data is written to file child.
 #
 # @target: The target for copy-before-write operations.
 #
@@ -4778,9 +4679,8 @@
 
 ##
 # @BlockdevOptions:
-#
-# Options for creating a block device.  Many options are available for
-# all block devices, independent of the block driver:
+#     Options for creating a block device.  Many options are available
+#     for all block devices, independent of the block driver:
 #
 # @driver: block driver name
 #
@@ -4893,8 +4793,7 @@
 
 ##
 # @BlockdevRef:
-#
-# Reference to a block device.
+#     Reference to a block device.
 #
 # @definition: defines a new block device inline
 #
@@ -4908,8 +4807,7 @@
 
 ##
 # @BlockdevRefOrNull:
-#
-# Reference to a block device.
+#     Reference to a block device.
 #
 # @definition: defines a new block device inline
 #
@@ -4928,8 +4826,7 @@
 
 ##
 # @blockdev-add:
-#
-# Creates a new block device.
+#     Creates a new block device.
 #
 # Since: 2.9
 #
@@ -5025,10 +4922,9 @@
 
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
@@ -5090,8 +4986,7 @@
 
 ##
 # @BlockdevCreateOptionsFile:
-#
-# Driver specific image creation options for file.
+#     Driver specific image creation options for file.
 #
 # @filename: Filename for the new image file
 #
@@ -5117,8 +5012,7 @@
 
 ##
 # @BlockdevCreateOptionsLUKS:
-#
-# Driver specific image creation options for LUKS.
+#     Driver specific image creation options for LUKS.
 #
 # @file: Node to create the image format on, mandatory except when
 #     'preallocation' is not requested
@@ -5141,8 +5035,7 @@
 
 ##
 # @BlockdevCreateOptionsNfs:
-#
-# Driver specific image creation options for NFS.
+#     Driver specific image creation options for NFS.
 #
 # @location: Where to store the new image file
 #
@@ -5156,8 +5049,7 @@
 
 ##
 # @BlockdevCreateOptionsParallels:
-#
-# Driver specific image creation options for parallels.
+#     Driver specific image creation options for parallels.
 #
 # @file: Node to create the image format on
 #
@@ -5174,8 +5066,7 @@
 
 ##
 # @BlockdevCreateOptionsQcow:
-#
-# Driver specific image creation options for qcow.
+#     Driver specific image creation options for qcow.
 #
 # @file: Node to create the image format on
 #
@@ -5209,8 +5100,7 @@
 
 ##
 # @Qcow2CompressionType:
-#
-# Compression type used in qcow2 image file
+#     Compression type used in qcow2 image file
 #
 # @zlib: zlib compression, see <http://zlib.net/>
 #
@@ -5223,8 +5113,7 @@
 
 ##
 # @BlockdevCreateOptionsQcow2:
-#
-# Driver specific image creation options for qcow2.
+#     Driver specific image creation options for qcow2.
 #
 # @file: Node to create the image format on
 #
@@ -5283,8 +5172,7 @@
 
 ##
 # @BlockdevCreateOptionsQed:
-#
-# Driver specific image creation options for qed.
+#     Driver specific image creation options for qed.
 #
 # @file: Node to create the image format on
 #
@@ -5311,8 +5199,7 @@
 
 ##
 # @BlockdevCreateOptionsRbd:
-#
-# Driver specific image creation options for rbd/Ceph.
+#     Driver specific image creation options for rbd/Ceph.
 #
 # @location: Where to store the new image file.  This location cannot
 #     point to a snapshot.
@@ -5333,8 +5220,7 @@
 
 ##
 # @BlockdevVmdkSubformat:
-#
-# Subformat options for VMDK images
+#     Subformat options for VMDK images
 #
 # @monolithicSparse: Single file image with sparse cluster allocation
 #
@@ -5357,8 +5243,7 @@
 
 ##
 # @BlockdevVmdkAdapterType:
-#
-# Adapter type info for VMDK images
+#     Adapter type info for VMDK images
 #
 # Since: 4.0
 ##
@@ -5367,8 +5252,7 @@
 
 ##
 # @BlockdevCreateOptionsVmdk:
-#
-# Driver specific image creation options for VMDK.
+#     Driver specific image creation options for VMDK.
 #
 # @file: Where to store the new image file.  This refers to the image
 #     file for monolithcSparse and streamOptimized format, or the
@@ -5416,8 +5300,7 @@
 
 ##
 # @BlockdevCreateOptionsSsh:
-#
-# Driver specific image creation options for SSH.
+#     Driver specific image creation options for SSH.
 #
 # @location: Where to store the new image file
 #
@@ -5431,8 +5314,7 @@
 
 ##
 # @BlockdevCreateOptionsVdi:
-#
-# Driver specific image creation options for VDI.
+#     Driver specific image creation options for VDI.
 #
 # @file: Node to create the image format on
 #
@@ -5462,8 +5344,7 @@
 
 ##
 # @BlockdevCreateOptionsVhdx:
-#
-# Driver specific image creation options for vhdx.
+#     Driver specific image creation options for vhdx.
 #
 # @file: Node to create the image format on
 #
@@ -5506,8 +5387,7 @@
 
 ##
 # @BlockdevCreateOptionsVpc:
-#
-# Driver specific image creation options for vpc (VHD).
+#     Driver specific image creation options for vpc (VHD).
 #
 # @file: Node to create the image format on
 #
@@ -5529,8 +5409,7 @@
 
 ##
 # @BlockdevCreateOptions:
-#
-# Options for creating an image format on a given node.
+#     Options for creating an image format on a given node.
 #
 # @driver: block driver to create the image format
 #
@@ -5558,9 +5437,9 @@
 
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
@@ -5575,8 +5454,7 @@
 
 ##
 # @BlockdevAmendOptionsLUKS:
-#
-# Driver specific image amend options for LUKS.
+#     Driver specific image amend options for LUKS.
 #
 # Since: 5.1
 ##
@@ -5587,9 +5465,8 @@
 
 ##
 # @BlockdevAmendOptionsQcow2:
-#
-# Driver specific image amend options for qcow2.  For now, only
-# encryption options can be amended
+#     Driver specific image amend options for qcow2.  For now, only
+#     encryption options can be amended
 #
 # @encrypt: Encryption options to be amended
 #
@@ -5600,8 +5477,7 @@
 
 ##
 # @BlockdevAmendOptions:
-#
-# Options for amending an image format
+#     Options for amending an image format
 #
 # @driver: Block driver of the node to amend.
 #
@@ -5617,10 +5493,9 @@
 
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
@@ -5649,8 +5524,8 @@
 
 ##
 # @BlockErrorAction:
-#
-# An enumeration of action that has been taken when a DISK I/O occurs
+#     An enumeration of action that has been taken when a DISK I/O
+#     occurs
 #
 # @ignore: error has been ignored
 #
@@ -5665,11 +5540,10 @@
 
 ##
 # @BLOCK_IMAGE_CORRUPTED:
-#
-# Emitted when a disk image is being marked corrupt.  The image can be
-# identified by its device or node name.  The 'device' field is always
-# present for compatibility reasons, but it can be empty ("") if the
-# image does not have a device name associated.
+#     Emitted when a disk image is being marked corrupt.  The image
+#     can be identified by its device or node name.  The 'device'
+#     field is always present for compatibility reasons, but it can be
+#     empty ("") if the image does not have a device name associated.
 #
 # @device: device name.  This is always present for compatibility
 #     reasons, but it can be empty ("") if the image does not have a
@@ -5713,8 +5587,7 @@
 
 ##
 # @BLOCK_IO_ERROR:
-#
-# Emitted when a disk I/O error occurs
+#     Emitted when a disk I/O error occurs
 #
 # @qom-path: path to the device object in the QOM tree (since 9.2)
 #
@@ -5766,8 +5639,7 @@
 
 ##
 # @BLOCK_JOB_COMPLETED:
-#
-# Emitted when a block job has completed
+#     Emitted when a block job has completed
 #
 # @type: job type
 #
@@ -5806,8 +5678,7 @@
 
 ##
 # @BLOCK_JOB_CANCELLED:
-#
-# Emitted when a block job has been cancelled
+#     Emitted when a block job has been cancelled
 #
 # @type: job type
 #
@@ -5840,8 +5711,7 @@
 
 ##
 # @BLOCK_JOB_ERROR:
-#
-# Emitted when a block job encounters an error
+#     Emitted when a block job encounters an error
 #
 # @device: The job identifier.  Originally the device name but other
 #     values are allowed since QEMU 2.7
@@ -5867,8 +5737,7 @@
 
 ##
 # @BLOCK_JOB_READY:
-#
-# Emitted when a block job is ready to complete
+#     Emitted when a block job is ready to complete
 #
 # @type: job type
 #
@@ -5903,11 +5772,10 @@
 
 ##
 # @BLOCK_JOB_PENDING:
-#
-# Emitted when a block job is awaiting explicit authorization to
-# finalize graph changes via `job-finalize`.  If this job is part of a
-# transaction, it will not emit this event until the transaction has
-# converged first.
+#     Emitted when a block job is awaiting explicit authorization to
+#     finalize graph changes via `job-finalize`.  If this job is part
+#     of a transaction, it will not emit this event until the
+#     transaction has converged first.
 #
 # @type: job type
 #
@@ -5927,8 +5795,7 @@
 
 ##
 # @PreallocMode:
-#
-# Preallocation mode of QEMU image file
+#     Preallocation mode of QEMU image file
 #
 # @off: no preallocation
 #
@@ -5949,12 +5816,12 @@
 
 ##
 # @BLOCK_WRITE_THRESHOLD:
-#
-# Emitted when writes on block device reaches or exceeds the
-# configured write threshold.  For thin-provisioned devices, this
-# means the device should be extended to avoid pausing for disk
-# exhaustion.  The event is one shot.  Once triggered, it needs to be
-# re-registered with another `block-set-write-threshold` command.
+#     Emitted when writes on block device reaches or exceeds the
+#     configured write threshold.  For thin-provisioned devices, this
+#     means the device should be extended to avoid pausing for disk
+#     exhaustion.  The event is one shot.  Once triggered, it needs to
+#     be re-registered with another `block-set-write-threshold`
+#     command.
 #
 # @node-name: graph node name on which the threshold was exceeded.
 #
@@ -6107,8 +5974,7 @@
 
 ##
 # @QuorumOpType:
-#
-# An enumeration of the quorum operation types
+#     An enumeration of the quorum operation types
 #
 # @read: read operation
 #
@@ -6123,8 +5989,8 @@
 
 ##
 # @QUORUM_FAILURE:
-#
-# Emitted by the Quorum block driver if it fails to establish a quorum
+#     Emitted by the Quorum block driver if it fails to establish a
+#     quorum
 #
 # @reference: device name if defined else node name
 #
@@ -6147,8 +6013,7 @@
 
 ##
 # @QUORUM_REPORT_BAD:
-#
-# Emitted to report a corruption of a Quorum file
+#     Emitted to report a corruption of a Quorum file
 #
 # @type: quorum operation type (Since 2.6)
 #
@@ -6202,11 +6067,10 @@
 
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
@@ -6234,11 +6098,11 @@
 
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
@@ -6281,8 +6145,8 @@
 
 ##
 # @DummyBlockCoreForceArrays:
-#
-# Not used by QMP; hack to let us use BlockGraphInfoList internally
+#     Not used by QMP; hack to let us use BlockGraphInfoList
+#     internally
 #
 # Since: 8.0
 ##
-- 
2.55.0

