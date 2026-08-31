Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6238F250
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207973; cv=none; b=FVnGcQ2wc7Ac6LqmnVXy3qMSL2ZGoaYkcKwwCtW1PX5xOkmNrCzdn6KkFw+mvixbRfwFs4JZU7q2D3jLRf27IFMRda+Z+U57vZOdUKwI3Xv5PSSHifoKiWRSSryfNy8R8OaOZbQv3TmT1rSbtmUSf9Ce1fkrMAIAo4fEUamM1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207973; c=relaxed/simple;
	bh=7zu3sSWlsdjvf6JxmzvtHXZhxVLZ/7XmqMTMun6eZiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=qJvd/dYlMMr/cmCEdnDB+zN2RRVrfdbHnOtsOSeUQ9vaCN6QCIaIAMjG/hRVDXcGmamJFNr2LL5THo/pkY/TloaLFFDkTGVIMMiDl46+rjVJLBdEgeSqs/7cZSn0zz36YmYE/fHgNucfHYrVL27QFp7tbsrg9kgnD4TcrJwj2HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOx+Qb6W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOx+Qb6W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dmwLJ1r1XAn3heZnC7B+Oex/p3Q4OgxwaiHszUOaHE=;
	b=IOx+Qb6WBNeeZ2sW7YR/inf7LGZ5jRNSxRMguARIQALF3RlC2vdrug4OW3nr6m4lbiZvr2
	XZKgchMHDZg7nYOzlZ67uNyEspTLa1FhrfO+meYqc1B03J6PjQgHu/lmzkH0tjZzzG1zdK
	QRSUthL4N9lOx85IPDlPiJ4u9UvTd7A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Hps4sIpBP-K7zo0bGUVsYA-1; Mon,
 31 Aug 2026 16:26:05 -0400
X-MC-Unique: Hps4sIpBP-K7zo0bGUVsYA-1
X-Mimecast-MFC-AGG-ID: Hps4sIpBP-K7zo0bGUVsYA_1788207962
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 077AC1955F13;
	Mon, 31 Aug 2026 20:26:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78BF918005AD;
	Mon, 31 Aug 2026 20:25:53 +0000 (UTC)
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
Subject: [PATCH v4 43/43] qapi: convert trivial intro sections for block-core.json
Date: Mon, 31 Aug 2026 16:19:45 -0400
Message-ID: <20260831201945.287730-44-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: PIf3HxJLr5V-plJCrP69YfjLYGuWv_mwxwNJy5n0rmM_1788207962
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 431 ++++++++++++++++---------------------------
 1 file changed, 157 insertions(+), 274 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 199efc1e008..33e1147792b 100644
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
@@ -437,8 +432,7 @@
 
 ##
 # @ImageCheck:
-#
-# Information about a QEMU image file check
+#     Information about a QEMU image file check
 #
 # @filename: name of the image file checked
 #
@@ -481,8 +475,8 @@
 
 ##
 # @MapEntry:
-#
-# Mapping information from a virtual block range to a host file range
+#     Mapping information from a virtual block range to a host file
+#     range
 #
 # @start: virtual (guest) offset of the first byte described by this
 #     entry
@@ -520,8 +514,7 @@
 
 ##
 # @BlockdevCacheInfo:
-#
-# Cache mode information for a block device
+#     Cache mode information for a block device
 #
 # @writeback: true if writeback mode is enabled
 #
@@ -551,8 +544,7 @@
 
 ##
 # @BlockDeviceInfo:
-#
-# Information about the backing device for a block device.
+#     Information about the backing device for a block device.
 #
 # @file: the filename of the backing device
 #
@@ -668,8 +660,7 @@
 
 ##
 # @BlockDeviceIoStatus:
-#
-# An enumeration of block device I/O status.
+#     An enumeration of block device I/O status.
 #
 # @ok: The last I/O operation has succeeded
 #
@@ -684,8 +675,7 @@
 
 ##
 # @BlockDirtyInfo:
-#
-# Block dirty bitmap information.
+#     Block dirty bitmap information.
 #
 # @name: the name of the dirty bitmap (Since 2.4)
 #
@@ -717,8 +707,7 @@
 
 ##
 # @Qcow2BitmapInfoFlags:
-#
-# An enumeration of flags that a bitmap can report to the user.
+#     An enumeration of flags that a bitmap can report to the user.
 #
 # @in-use: This flag is set by any process actively modifying the
 #     qcow2 file, and cleared when the updated bitmap is flushed to
@@ -736,8 +725,7 @@
 
 ##
 # @Qcow2BitmapInfo:
-#
-# Qcow2 bitmap information.
+#     Qcow2 bitmap information.
 #
 # @name: the name of the bitmap
 #
@@ -753,8 +741,7 @@
 
 ##
 # @BlockLatencyHistogramInfo:
-#
-# Block latency histogram.
+#     Block latency histogram.
 #
 # @boundaries: list of interval boundary values in nanoseconds, all
 #     greater than zero and in ascending order.  For example, the list
@@ -852,8 +839,7 @@
 
 ##
 # @query-block:
-#
-# Get a list of `BlockInfo` for all virtual block devices.
+#     Get a list of `BlockInfo` for all virtual block devices.
 #
 # @flat: Omit nested data about the backing image, i.e. `BlockInfo`
 #     member 'inserted.image.backing-image' will be absent.
@@ -954,8 +940,7 @@
 
 ##
 # @BlockDeviceTimedStats:
-#
-# Statistics of a block device during a given interval of time.
+#     Statistics of a block device during a given interval of time.
 #
 # @interval_length: Interval used for calculating the statistics, in
 #     seconds.
@@ -1021,8 +1006,7 @@
 
 ##
 # @BlockDeviceStats:
-#
-# Statistics of a virtual block device or a block backing device.
+#     Statistics of a virtual block device or a block backing device.
 #
 # @rd_bytes: The number of bytes read by the device.
 #
@@ -1160,8 +1144,7 @@
 
 ##
 # @BlockStatsSpecificFile:
-#
-# File driver statistics
+#     File driver statistics
 #
 # @discard-nb-ok: The number of successful discard operations
 #     performed by the driver.
@@ -1181,8 +1164,7 @@
 
 ##
 # @BlockStatsSpecificNvme:
-#
-# NVMe driver statistics
+#     NVMe driver statistics
 #
 # @completion-errors: The number of completion errors.
 #
@@ -1202,8 +1184,7 @@
 
 ##
 # @BlockStatsSpecific:
-#
-# Block driver specific statistics
+#     Block driver specific statistics
 #
 # @driver: block driver name
 #
@@ -1220,8 +1201,7 @@
 
 ##
 # @BlockStats:
-#
-# Statistics of a virtual block device or a block backing device.
+#     Statistics of a virtual block device or a block backing device.
 #
 # @device: If the stats are for a virtual block device, the name
 #     corresponding to the virtual block device.
@@ -1254,8 +1234,7 @@
 
 ##
 # @query-blockstats:
-#
-# Query the `BlockStats` for all virtual block devices.
+#     Query the `BlockStats` for all virtual block devices.
 #
 # @query-nodes: If true, the command will query all the block nodes
 #     that have a node name, in a list which will include "parent"
@@ -1406,9 +1385,8 @@
 
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
@@ -1429,9 +1407,8 @@
 
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
@@ -1450,9 +1427,8 @@
 
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
@@ -1467,8 +1443,7 @@
 
 ##
 # @BlockJobInfoMirror:
-#
-# Information specific to mirror block jobs.
+#     Information specific to mirror block jobs.
 #
 # @actively-synced: Whether the source is actively synced to the
 #     target, i.e. same data and new writes are done synchronously to
@@ -1481,8 +1456,7 @@
 
 ##
 # @BlockJobInfo:
-#
-# Information about a long-running block device operation.
+#     Information about a long-running block device operation.
 #
 # @type: the job type ('stream' for image streaming)
 #
@@ -1534,8 +1508,7 @@
 
 ##
 # @query-block-jobs:
-#
-# Return information about long-running block device operations.
+#     Return information about long-running block device operations.
 #
 # Returns: a list of job info for each active block job
 #
@@ -1577,9 +1550,8 @@
 
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
@@ -1782,8 +1754,7 @@
 
 ##
 # @blockdev-snapshot-sync:
-#
-# Takes a synchronous snapshot of a block device.
+#     Takes a synchronous snapshot of a block device.
 #
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
@@ -2043,8 +2014,7 @@
 
 ##
 # @query-named-block-nodes:
-#
-# Get the named block driver list
+#     Get the named block driver list
 #
 # @flat: Omit the nested data about backing image ("backing-image"
 #     key) if true.  Default is false (Since 5.0)
@@ -2140,8 +2110,7 @@
 
 ##
 # @BlockPermission:
-#
-# Enum of base block permissions.
+#     Enum of base block permissions.
 #
 # @consistent-read: A user that has the "permission" of consistent
 #     reads is guaranteed that their view of the contents of the block
@@ -2171,8 +2140,7 @@
 
 ##
 # @XDbgBlockGraphEdge:
-#
-# Block Graph edge description for `x-debug-query-block-graph`.
+#     Block Graph edge description for `x-debug-query-block-graph`.
 #
 # @parent: parent id
 #
@@ -2194,8 +2162,7 @@
 
 ##
 # @XDbgBlockGraph:
-#
-# Block Graph - list of nodes and list of edges.
+#     Block Graph - list of nodes and list of edges.
 #
 # Since: 4.0
 ##
@@ -2204,8 +2171,7 @@
 
 ##
 # @x-debug-query-block-graph:
-#
-# Get the block graph.
+#     Get the block graph.
 #
 # Features:
 #
@@ -2247,8 +2213,7 @@
 
 ##
 # @DriveMirror:
-#
-# A set of parameters describing drive mirror setup.
+#     A set of parameters describing drive mirror setup.
 #
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
@@ -2401,9 +2366,8 @@
 
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
@@ -2447,10 +2411,9 @@
 
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
@@ -2470,8 +2433,8 @@
 
 ##
 # @block-dirty-bitmap-enable:
-#
-# Enables a dirty bitmap so that it will begin tracking disk changes.
+#     Enables a dirty bitmap so that it will begin tracking disk
+#     changes.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2491,8 +2454,8 @@
 
 ##
 # @block-dirty-bitmap-disable:
-#
-# Disables a dirty bitmap so that it will stop tracking disk changes.
+#     Disables a dirty bitmap so that it will stop tracking disk
+#     changes.
 #
 # Errors:
 #     - If @node is not a valid block device, DeviceNotFound
@@ -2545,8 +2508,7 @@
 
 ##
 # @BlockDirtyBitmapSha256:
-#
-# SHA256 hash of dirty bitmap data
+#     SHA256 hash of dirty bitmap data
 #
 # @sha256: ASCII representation of SHA256 bitmap hash
 #
@@ -2557,8 +2519,7 @@
 
 ##
 # @x-debug-block-dirty-bitmap-sha256:
-#
-# Get bitmap SHA256.
+#     Get bitmap SHA256.
 #
 # Features:
 #
@@ -2577,8 +2538,7 @@
 
 ##
 # @blockdev-mirror:
-#
-# Start mirroring a block device's writes to a new destination.
+#     Start mirroring a block device's writes to a new destination.
 #
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
@@ -2664,8 +2624,7 @@
 
 ##
 # @BlockIOThrottle:
-#
-# A set of parameters describing block throttling.
+#     A set of parameters describing block throttling.
 #
 # @device: Block device name
 #
@@ -2816,8 +2775,7 @@
 
 ##
 # @ThrottleGroupProperties:
-#
-# Properties for throttle-group objects.
+#     Properties for throttle-group objects.
 #
 # @limits: limits to apply for this throttle group
 #
@@ -3224,8 +3182,7 @@
 
 ##
 # @BlockJobChangeOptions:
-#
-# Block job options that can be changed after job creation.
+#     Block job options that can be changed after job creation.
 #
 # @id: The job identifier
 #
@@ -3240,8 +3197,7 @@
 
 ##
 # @block-job-change:
-#
-# Change the block job's options.
+#     Change the block job's options.
 #
 # Since: 8.2
 ##
@@ -3250,8 +3206,7 @@
 
 ##
 # @BlockdevDiscardOptions:
-#
-# Determines how to handle discard requests.
+#     Determines how to handle discard requests.
 #
 # @ignore: Ignore the request
 #
@@ -3264,10 +3219,9 @@
 
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
@@ -3284,8 +3238,7 @@
 
 ##
 # @BlockdevAioOptions:
-#
-# Selects the AIO backend to handle I/O requests
+#     Selects the AIO backend to handle I/O requests
 #
 # @threads: Use QEMU's thread pool
 #
@@ -3301,8 +3254,7 @@
 
 ##
 # @BlockdevCacheOptions:
-#
-# Includes cache-related options for block devices
+#     Includes cache-related options for block devices
 #
 # @direct: enables use of O_DIRECT (bypass the host page cache;
 #     default: false)
@@ -3317,8 +3269,7 @@
 
 ##
 # @BlockdevDriver:
-#
-# Drivers that are supported in block device operations.
+#     Drivers that are supported in block device operations.
 #
 # @throttle: Since 2.11
 #
@@ -3360,8 +3311,7 @@
 
 ##
 # @BlockdevOptionsFile:
-#
-# Driver specific block device options for the file backend.
+#     Driver specific block device options for the file backend.
 #
 # @filename: path to the image file
 #
@@ -3420,8 +3370,7 @@
 
 ##
 # @BlockdevOptionsNull:
-#
-# Driver specific block device options for the null backend.
+#     Driver specific block device options for the null backend.
 #
 # @size: size of the device in bytes.
 #
@@ -3440,8 +3389,7 @@
 
 ##
 # @BlockdevOptionsNVMe:
-#
-# Driver specific block device options for the NVMe backend.
+#     Driver specific block device options for the NVMe backend.
 #
 # @device: PCI controller address of the NVMe device in format
 #     hhhh:bb:ss.f (host:bus:slot.function)
@@ -3458,8 +3406,7 @@
 
 ##
 # @BlockdevOptionsVVFAT:
-#
-# Driver specific block device options for the vvfat protocol.
+#     Driver specific block device options for the vvfat protocol.
 #
 # @dir: directory to be exported as FAT image
 #
@@ -3483,9 +3430,8 @@
 
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
@@ -3496,8 +3442,7 @@
 
 ##
 # @BlockdevOptionsLUKS:
-#
-# Driver specific block device options for LUKS.
+#     Driver specific block device options for LUKS.
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when doing a metadata-only
@@ -3514,9 +3459,9 @@
 
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
@@ -3530,8 +3475,7 @@
 
 ##
 # @Qcow2OverlapCheckMode:
-#
-# General overlap check modes.
+#     General overlap check modes.
 #
 # @none: Do not perform any checks
 #
@@ -3594,9 +3538,8 @@
 
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
@@ -3633,8 +3576,7 @@
 
 ##
 # @BlockdevOptionsQcow:
-#
-# Driver specific block device options for qcow.
+#     Driver specific block device options for qcow.
 #
 # @encrypt: Image decryption options.  Mandatory for encrypted images,
 #     except when doing a metadata-only probe of the image.
@@ -3670,9 +3612,8 @@
 
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
@@ -3687,8 +3628,7 @@
 
 ##
 # @BlockdevOptionsQcow2:
-#
-# Driver specific block device options for qcow2.
+#     Driver specific block device options for qcow2.
 #
 # @lazy-refcounts: whether to enable the lazy refcounts feature
 #     (default is taken from the image file)
@@ -3841,8 +3781,7 @@
 
 ##
 # @BlkdebugEvent:
-#
-# Trigger events supported by blkdebug.
+#     Trigger events supported by blkdebug.
 #
 # @l1_shrink_write_table: write zeros to the l1 table to shrink image.
 #     (since 2.11)
@@ -3878,8 +3817,7 @@
 
 ##
 # @BlkdebugIOType:
-#
-# Kinds of I/O that blkdebug can inject errors in.
+#     Kinds of I/O that blkdebug can inject errors in.
 #
 # @read: .bdrv_co_preadv()
 #
@@ -3901,8 +3839,7 @@
 
 ##
 # @BlkdebugInjectErrorOptions:
-#
-# Describes a single error injection for blkdebug.
+#     Describes a single error injection for blkdebug.
 #
 # @event: trigger event
 #
@@ -3940,8 +3877,7 @@
 
 ##
 # @BlkdebugSetStateOptions:
-#
-# Describes a single state-change event for blkdebug.
+#     Describes a single state-change event for blkdebug.
 #
 # @event: trigger event
 #
@@ -3960,8 +3896,7 @@
 
 ##
 # @BlockdevOptionsBlkdebug:
-#
-# Driver specific block device options for blkdebug.
+#     Driver specific block device options for blkdebug.
 #
 # @image: underlying raw block device (or image file)
 #
@@ -4022,8 +3957,7 @@
 
 ##
 # @BlockdevOptionsBlklogwrites:
-#
-# Driver specific block device options for blklogwrites.
+#     Driver specific block device options for blklogwrites.
 #
 # @file: block device
 #
@@ -4049,8 +3983,7 @@
 
 ##
 # @BlockdevOptionsBlkverify:
-#
-# Driver specific block device options for blkverify.
+#     Driver specific block device options for blkverify.
 #
 # @test: block device to be tested
 #
@@ -4064,8 +3997,7 @@
 
 ##
 # @BlockdevOptionsBlkreplay:
-#
-# Driver specific block device options for blkreplay.
+#     Driver specific block device options for blkreplay.
 #
 # @image: disk image which should be controlled with blkreplay
 #
@@ -4076,8 +4008,7 @@
 
 ##
 # @QuorumReadPattern:
-#
-# An enumeration of quorum read patterns.
+#     An enumeration of quorum read patterns.
 #
 # @quorum: read all the children and do a quorum vote on reads
 #
@@ -4089,8 +4020,7 @@
 
 ##
 # @BlockdevOptionsQuorum:
-#
-# Driver specific block device options for Quorum
+#     Driver specific block device options for Quorum
 #
 # @blkverify: true if the driver must print content mismatch set to
 #     false by default
@@ -4116,8 +4046,7 @@
 
 ##
 # @BlockdevOptionsIoUring:
-#
-# Driver specific block device options for the io_uring backend.
+#     Driver specific block device options for the io_uring backend.
 #
 # @filename: path to the image file
 #
@@ -4129,8 +4058,8 @@
 
 ##
 # @BlockdevOptionsNvmeIoUring:
-#
-# Driver specific block device options for the nvme-io_uring backend.
+#     Driver specific block device options for the nvme-io_uring
+#     backend.
 #
 # @path: path to the NVMe namespace's character device (e.g.
 #     /dev/ng0n1).
@@ -4143,9 +4072,8 @@
 
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
@@ -4158,9 +4086,8 @@
 
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
@@ -4172,9 +4099,8 @@
 
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
@@ -4193,8 +4119,7 @@
 
 ##
 # @IscsiTransport:
-#
-# An enumeration of libiscsi transport types
+#     An enumeration of libiscsi transport types
 #
 # Since: 2.9
 ##
@@ -4203,8 +4128,7 @@
 
 ##
 # @IscsiHeaderDigest:
-#
-# An enumeration of header digests supported by libiscsi
+#     An enumeration of header digests supported by libiscsi
 #
 # Since: 2.9
 ##
@@ -4214,8 +4138,7 @@
 
 ##
 # @BlockdevOptionsIscsi:
-#
-# Driver specific block device options for iscsi
+#     Driver specific block device options for iscsi
 #
 # @transport: The iscsi transport type
 #
@@ -4417,8 +4340,7 @@
 
 ##
 # @ReplicationMode:
-#
-# An enumeration of replication modes.
+#     An enumeration of replication modes.
 #
 # @primary: Primary mode, the vm's state will be sent to secondary
 #     QEMU.
@@ -4433,8 +4355,7 @@
 
 ##
 # @BlockdevOptionsReplication:
-#
-# Driver specific block device options for replication
+#     Driver specific block device options for replication
 #
 # @mode: the replication mode
 #
@@ -4452,8 +4373,7 @@
 
 ##
 # @NFSTransport:
-#
-# An enumeration of NFS transport types
+#     An enumeration of NFS transport types
 #
 # @inet: TCP transport
 #
@@ -4464,8 +4384,7 @@
 
 ##
 # @NFSServer:
-#
-# Captures the address of the socket
+#     Captures the address of the socket
 #
 # @type: transport type used for NFS (only TCP supported)
 #
@@ -4479,8 +4398,7 @@
 
 ##
 # @BlockdevOptionsNfs:
-#
-# Driver specific block device option for NFS
+#     Driver specific block device option for NFS
 #
 # @server: host address
 #
@@ -4517,9 +4435,8 @@
 
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
@@ -4620,8 +4537,7 @@
 
 ##
 # @BlockdevOptionsNbd:
-#
-# Driver specific block device options for NBD.
+#     Driver specific block device options for NBD.
 #
 # @server: NBD server address
 #
@@ -4669,8 +4585,7 @@
 
 ##
 # @BlockdevOptionsRaw:
-#
-# Driver specific block device options for the raw driver.
+#     Driver specific block device options for the raw driver.
 #
 # @offset: position where the block device starts
 #
@@ -4684,8 +4599,7 @@
 
 ##
 # @BlockdevOptionsThrottle:
-#
-# Driver specific block device options for the throttle driver
+#     Driver specific block device options for the throttle driver
 #
 # @throttle-group: the name of the throttle-group object to use.  It
 #     must already exist.
@@ -4701,8 +4615,8 @@
 
 ##
 # @BlockdevOptionsCor:
-#
-# Driver specific block device options for the copy-on-read driver.
+#     Driver specific block device options for the copy-on-read
+#     driver.
 #
 # @bottom: The name of a non-filter node (allocation-bearing layer)
 #     that limits the COR operations in the backing chain (inclusive),
@@ -4718,9 +4632,8 @@
 
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
@@ -4895,8 +4808,7 @@
 
 ##
 # @BlockdevRef:
-#
-# Reference to a block device.
+#     Reference to a block device.
 #
 # @definition: defines a new block device inline
 #
@@ -4910,8 +4822,7 @@
 
 ##
 # @BlockdevRefOrNull:
-#
-# Reference to a block device.
+#     Reference to a block device.
 #
 # @definition: defines a new block device inline
 #
@@ -4930,8 +4841,7 @@
 
 ##
 # @blockdev-add:
-#
-# Creates a new block device.
+#     Creates a new block device.
 #
 # Since: 2.9
 #
@@ -5092,8 +5002,7 @@
 
 ##
 # @BlockdevCreateOptionsFile:
-#
-# Driver specific image creation options for file.
+#     Driver specific image creation options for file.
 #
 # @filename: Filename for the new image file
 #
@@ -5119,8 +5028,7 @@
 
 ##
 # @BlockdevCreateOptionsLUKS:
-#
-# Driver specific image creation options for LUKS.
+#     Driver specific image creation options for LUKS.
 #
 # @file: Node to create the image format on, mandatory except when
 #     'preallocation' is not requested
@@ -5143,8 +5051,7 @@
 
 ##
 # @BlockdevCreateOptionsNfs:
-#
-# Driver specific image creation options for NFS.
+#     Driver specific image creation options for NFS.
 #
 # @location: Where to store the new image file
 #
@@ -5158,8 +5065,7 @@
 
 ##
 # @BlockdevCreateOptionsParallels:
-#
-# Driver specific image creation options for parallels.
+#     Driver specific image creation options for parallels.
 #
 # @file: Node to create the image format on
 #
@@ -5176,8 +5082,7 @@
 
 ##
 # @BlockdevCreateOptionsQcow:
-#
-# Driver specific image creation options for qcow.
+#     Driver specific image creation options for qcow.
 #
 # @file: Node to create the image format on
 #
@@ -5211,8 +5116,7 @@
 
 ##
 # @Qcow2CompressionType:
-#
-# Compression type used in qcow2 image file
+#     Compression type used in qcow2 image file
 #
 # @zlib: zlib compression, see <http://zlib.net/>
 #
@@ -5225,8 +5129,7 @@
 
 ##
 # @BlockdevCreateOptionsQcow2:
-#
-# Driver specific image creation options for qcow2.
+#     Driver specific image creation options for qcow2.
 #
 # @file: Node to create the image format on
 #
@@ -5285,8 +5188,7 @@
 
 ##
 # @BlockdevCreateOptionsQed:
-#
-# Driver specific image creation options for qed.
+#     Driver specific image creation options for qed.
 #
 # @file: Node to create the image format on
 #
@@ -5313,8 +5215,7 @@
 
 ##
 # @BlockdevCreateOptionsRbd:
-#
-# Driver specific image creation options for rbd/Ceph.
+#     Driver specific image creation options for rbd/Ceph.
 #
 # @location: Where to store the new image file.  This location cannot
 #     point to a snapshot.
@@ -5335,8 +5236,7 @@
 
 ##
 # @BlockdevVmdkSubformat:
-#
-# Subformat options for VMDK images
+#     Subformat options for VMDK images
 #
 # @monolithicSparse: Single file image with sparse cluster allocation
 #
@@ -5359,8 +5259,7 @@
 
 ##
 # @BlockdevVmdkAdapterType:
-#
-# Adapter type info for VMDK images
+#     Adapter type info for VMDK images
 #
 # Since: 4.0
 ##
@@ -5369,8 +5268,7 @@
 
 ##
 # @BlockdevCreateOptionsVmdk:
-#
-# Driver specific image creation options for VMDK.
+#     Driver specific image creation options for VMDK.
 #
 # @file: Where to store the new image file.  This refers to the image
 #     file for monolithcSparse and streamOptimized format, or the
@@ -5418,8 +5316,7 @@
 
 ##
 # @BlockdevCreateOptionsSsh:
-#
-# Driver specific image creation options for SSH.
+#     Driver specific image creation options for SSH.
 #
 # @location: Where to store the new image file
 #
@@ -5433,8 +5330,7 @@
 
 ##
 # @BlockdevCreateOptionsVdi:
-#
-# Driver specific image creation options for VDI.
+#     Driver specific image creation options for VDI.
 #
 # @file: Node to create the image format on
 #
@@ -5464,8 +5360,7 @@
 
 ##
 # @BlockdevCreateOptionsVhdx:
-#
-# Driver specific image creation options for vhdx.
+#     Driver specific image creation options for vhdx.
 #
 # @file: Node to create the image format on
 #
@@ -5508,8 +5403,7 @@
 
 ##
 # @BlockdevCreateOptionsVpc:
-#
-# Driver specific image creation options for vpc (VHD).
+#     Driver specific image creation options for vpc (VHD).
 #
 # @file: Node to create the image format on
 #
@@ -5531,8 +5425,7 @@
 
 ##
 # @BlockdevCreateOptions:
-#
-# Options for creating an image format on a given node.
+#     Options for creating an image format on a given node.
 #
 # @driver: block driver to create the image format
 #
@@ -5577,8 +5470,7 @@
 
 ##
 # @BlockdevAmendOptionsLUKS:
-#
-# Driver specific image amend options for LUKS.
+#     Driver specific image amend options for LUKS.
 #
 # Since: 5.1
 ##
@@ -5602,8 +5494,7 @@
 
 ##
 # @BlockdevAmendOptions:
-#
-# Options for amending an image format
+#     Options for amending an image format
 #
 # @driver: Block driver of the node to amend.
 #
@@ -5651,8 +5542,8 @@
 
 ##
 # @BlockErrorAction:
-#
-# An enumeration of action that has been taken when a DISK I/O occurs
+#     An enumeration of action that has been taken when a DISK I/O
+#     occurs
 #
 # @ignore: error has been ignored
 #
@@ -5715,8 +5606,7 @@
 
 ##
 # @BLOCK_IO_ERROR:
-#
-# Emitted when a disk I/O error occurs
+#     Emitted when a disk I/O error occurs
 #
 # @qom-path: path to the device object in the QOM tree (since 9.2)
 #
@@ -5768,8 +5658,7 @@
 
 ##
 # @BLOCK_JOB_COMPLETED:
-#
-# Emitted when a block job has completed
+#     Emitted when a block job has completed
 #
 # @type: job type
 #
@@ -5808,8 +5697,7 @@
 
 ##
 # @BLOCK_JOB_CANCELLED:
-#
-# Emitted when a block job has been cancelled
+#     Emitted when a block job has been cancelled
 #
 # @type: job type
 #
@@ -5842,8 +5730,7 @@
 
 ##
 # @BLOCK_JOB_ERROR:
-#
-# Emitted when a block job encounters an error
+#     Emitted when a block job encounters an error
 #
 # @device: The job identifier.  Originally the device name but other
 #     values are allowed since QEMU 2.7
@@ -5869,8 +5756,7 @@
 
 ##
 # @BLOCK_JOB_READY:
-#
-# Emitted when a block job is ready to complete
+#     Emitted when a block job is ready to complete
 #
 # @type: job type
 #
@@ -5929,8 +5815,7 @@
 
 ##
 # @PreallocMode:
-#
-# Preallocation mode of QEMU image file
+#     Preallocation mode of QEMU image file
 #
 # @off: no preallocation
 #
@@ -6109,8 +5994,7 @@
 
 ##
 # @QuorumOpType:
-#
-# An enumeration of the quorum operation types
+#     An enumeration of the quorum operation types
 #
 # @read: read operation
 #
@@ -6125,8 +6009,8 @@
 
 ##
 # @QUORUM_FAILURE:
-#
-# Emitted by the Quorum block driver if it fails to establish a quorum
+#     Emitted by the Quorum block driver if it fails to establish a
+#     quorum
 #
 # @reference: device name if defined else node name
 #
@@ -6149,8 +6033,7 @@
 
 ##
 # @QUORUM_REPORT_BAD:
-#
-# Emitted to report a corruption of a Quorum file
+#     Emitted to report a corruption of a Quorum file
 #
 # @type: quorum operation type (Since 2.6)
 #
@@ -6283,8 +6166,8 @@
 
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

