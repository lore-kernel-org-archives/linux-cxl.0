Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333D38BF72
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207955; cv=none; b=QM0i7JJ7miG456kgalvcRC3xJTDIRJu1ZQy7rFY9Ov+EYZnlUZ0BAX+XfvPUZFgthU4cOEznHIGQUd80OBC+0iwDU29AZ5ZBZdW/JdxyQKVpi6+NIEKbkQS78F6cuJQNTqJlzkke3d46B1VDLKv9Bdllk2U3L8xuv1UXSHaxLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207955; c=relaxed/simple;
	bh=zGieCxkS4Rp88ezupjMov5v0sSKdiHspVKK05AzBDBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=UNKukw/U25ezO16Nh/A7Kir+OHyO2CKVEii1+zR/dtM+DsQS/Efpr3eAQ5ksw3e4mvLvSiELtR53wzE31jTR5ytzlUUnwEv8ou666JEu6LOmw4LtiDBb/5OtDssSeqv2qtRdKiPO5UCW2VOvfrSYXdNcNu0ALG27DJkNQikgT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FPMHay2y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FPMHay2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788207952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guCLIzVmZrZpBJXqrS2tsFbY+MWTzN+mPMblZhwoDNA=;
	b=FPMHay2ytpp7bZLmK/z85r/HgyEXm1judV3OKuMJvnAr8CLndTWfzt4iJF7HFdI30t3xcs
	7flujnJ567NgEbm1PnrVDU7Oy5P4xy71sAtBaOuGk+cN4ZX9BVbrmSBGv7HGgVCUlt9n9Y
	qD67HkIFLpwd5jPWsZiNPTs+8rXoJmc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-pdRSia-wNCWdmBDW_X-1mw-1; Mon,
 31 Aug 2026 16:25:48 -0400
X-MC-Unique: pdRSia-wNCWdmBDW_X-1mw-1
X-Mimecast-MFC-AGG-ID: pdRSia-wNCWdmBDW_X-1mw_1788207946
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E08C19792FE;
	Mon, 31 Aug 2026 20:25:46 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAD251800577;
	Mon, 31 Aug 2026 20:25:38 +0000 (UTC)
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
Subject: [PATCH v4 41/43] qapi: convert trivial intro sections for migration.json
Date: Mon, 31 Aug 2026 16:19:43 -0400
Message-ID: <20260831201945.287730-42-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: BWYnW_gfePYjvJ5D1yhdW51CiYst_3u0ofc8Z1Rcu4g_1788207946
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 131 ++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 83 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index b1eaf7b0545..8b6abcee2ca 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -13,8 +13,7 @@
 
 ##
 # @MigrationRAMStats:
-#
-# Detailed migration status.
+#     Detailed migration status.
 #
 # @transferred: amount of bytes already transferred to the target VM
 #
@@ -78,8 +77,7 @@
 
 ##
 # @XBZRLECacheStats:
-#
-# Detailed XBZRLE migration cache statistics
+#     Detailed XBZRLE migration cache statistics
 #
 # @cache-size: XBZRLE cache size
 #
@@ -104,8 +102,7 @@
 
 ##
 # @CompressionStats:
-#
-# Detailed migration compression statistics
+#     Detailed migration compression statistics
 #
 # @pages: amount of pages compressed and transferred to the target VM
 #
@@ -126,8 +123,7 @@
 
 ##
 # @MigrationStatus:
-#
-# An enumeration of migration status.
+#     An enumeration of migration status.
 #
 # @none: no migration has ever happened.
 #
@@ -189,8 +185,7 @@
 
 ##
 # @VfioStats:
-#
-# Detailed VFIO devices migration statistics
+#     Detailed VFIO devices migration statistics
 #
 # @transferred: amount of bytes transferred to the target VM by VFIO
 #     devices
@@ -202,8 +197,7 @@
 
 ##
 # @MigrationInfo:
-#
-# Information about current migration process.
+#     Information about current migration process.
 #
 # @status: `MigrationStatus` describing the current migration status.
 #     If this field is not returned, no migration process has been
@@ -435,8 +429,7 @@
 
 ##
 # @MigrationCapability:
-#
-# Migration capabilities enumeration
+#     Migration capabilities enumeration
 #
 # @xbzrle: Migration supports xbzrle (Xor Based Zero Run Length
 #     Encoding).  This feature allows us to minimize migration traffic
@@ -545,8 +538,7 @@
 
 ##
 # @MigrationCapabilityStatus:
-#
-# Migration capability information
+#     Migration capability information
 #
 # @capability: capability enum
 #
@@ -559,8 +551,8 @@
 
 ##
 # @migrate-set-capabilities:
-#
-# Enable/Disable the following migration capabilities (like xbzrle)
+#     Enable/Disable the following migration capabilities (like
+#     xbzrle)
 #
 # @capabilities: json array of capability modifications to make
 #
@@ -577,8 +569,8 @@
 
 ##
 # @query-migrate-capabilities:
-#
-# Return information about the current migration capabilities status
+#     Return information about the current migration capabilities
+#     status
 #
 # Since: 1.2
 #
@@ -598,8 +590,7 @@
 
 ##
 # @MultiFDCompression:
-#
-# An enumeration of multifd compression methods.
+#     An enumeration of multifd compression methods.
 #
 # @none: no compression.
 #
@@ -776,9 +767,8 @@
 
 ##
 # @BitmapMigrationNodeAlias:
-#
-# Maps a block node name and the bitmaps it has to aliases for dirty
-# bitmap migration.
+#     Maps a block node name and the bitmaps it has to aliases for
+#     dirty bitmap migration.
 #
 # @node-name: A block node name.
 #
@@ -1098,8 +1088,7 @@
 
 ##
 # @MIGRATION:
-#
-# Emitted when a migration event happens
+#     Emitted when a migration event happens
 #
 # @status: `MigrationStatus` describing the current migration status.
 #
@@ -1116,9 +1105,8 @@
 
 ##
 # @MIGRATION_PASS:
-#
-# Emitted from the source side of a migration at the start of each
-# pass (when it syncs the dirty bitmap)
+#     Emitted from the source side of a migration at the start of each
+#     pass (when it syncs the dirty bitmap)
 #
 # @pass: An incrementing count (starting at 1 on the first pass)
 #
@@ -1134,8 +1122,8 @@
 
 ##
 # @COLOMessage:
-#
-# The message transmission between Primary side and Secondary side.
+#     The message transmission between Primary side and Secondary
+#     side.
 #
 # @checkpoint-ready: Secondary VM (SVM) is ready for checkpointing
 #
@@ -1161,8 +1149,7 @@
 
 ##
 # @COLOMode:
-#
-# The COLO current mode.
+#     The COLO current mode.
 #
 # @none: COLO is disabled.
 #
@@ -1177,8 +1164,7 @@
 
 ##
 # @FailoverStatus:
-#
-# An enumeration of COLO failover status
+#     An enumeration of COLO failover status
 #
 # @none: no failover has ever happened
 #
@@ -1198,9 +1184,8 @@
 
 ##
 # @COLO_EXIT:
-#
-# Emitted when VM finishes COLO mode due to some errors happening or
-# at the request of users.
+#     Emitted when VM finishes COLO mode due to some errors happening
+#     or at the request of users.
 #
 # @mode: report COLO mode when COLO exited.
 #
@@ -1218,8 +1203,7 @@
 
 ##
 # @COLOExitReason:
-#
-# The reason for a COLO exit.
+#     The reason for a COLO exit.
 #
 # @none: failover has never happened.  This state does not occur in
 #     the `COLO_EXIT` event, and is only visible in the result of
@@ -1281,8 +1265,7 @@
 
 ##
 # @migrate-continue:
-#
-# Continue migration when it's in a paused state.
+#     Continue migration when it's in a paused state.
 #
 # @state: The state the migration is currently expected to be in
 #
@@ -1298,8 +1281,7 @@
 
 ##
 # @MigrationAddressType:
-#
-# The migration stream transport mechanisms.
+#     The migration stream transport mechanisms.
 #
 # @socket: Migrate via socket.
 #
@@ -1339,8 +1321,7 @@
 
 ##
 # @MigrationAddress:
-#
-# Migration endpoint configuration.
+#     Migration endpoint configuration.
 #
 # @transport: The migration stream transport mechanism
 #
@@ -1357,8 +1338,7 @@
 
 ##
 # @MigrationChannelType:
-#
-# The migration channel-type request options.
+#     The migration channel-type request options.
 #
 # @main: Main outbound migration channel.
 #
@@ -1371,8 +1351,7 @@
 
 ##
 # @MigrationChannel:
-#
-# Migration stream channel parameters.
+#     Migration stream channel parameters.
 #
 # @channel-type: Channel type for transferring packet information.
 #
@@ -1387,8 +1366,7 @@
 
 ##
 # @migrate:
-#
-# Migrates the current running guest to another Virtual Machine.
+#     Migrates the current running guest to another Virtual Machine.
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
@@ -1560,8 +1538,7 @@
 
 ##
 # @xen-set-global-dirty-log:
-#
-# Enable or disable the global dirty log mode.
+#     Enable or disable the global dirty log mode.
 #
 # @enable: true to enable, false to disable.
 #
@@ -1597,8 +1574,7 @@
 
 ##
 # @xen-set-replication:
-#
-# Enable or disable replication.
+#     Enable or disable replication.
 #
 # @enable: true to enable, false to disable.
 #
@@ -1621,8 +1597,7 @@
 
 ##
 # @ReplicationStatus:
-#
-# The result format for `query-xen-replication-status`.
+#     The result format for `query-xen-replication-status`.
 #
 # @error: true if an error happened, false if replication is normal.
 #
@@ -1670,8 +1645,7 @@
 
 ##
 # @COLOStatus:
-#
-# The result format for `query-colo-status`.
+#     The result format for `query-colo-status`.
 #
 # @mode: COLO running mode.  If COLO is running, this field will
 #     return 'primary' or 'secondary'.
@@ -1709,8 +1683,7 @@
 
 ##
 # @migrate-recover:
-#
-# Provide a recovery migration stream URI.
+#     Provide a recovery migration stream URI.
 #
 # @uri: the URI to be used for the recovery of migration stream.
 #
@@ -1763,8 +1736,7 @@
 
 ##
 # @DirtyRateVcpu:
-#
-# Dirty rate of vcpu.
+#     Dirty rate of vcpu.
 #
 # @id: vcpu index.
 #
@@ -1777,8 +1749,7 @@
 
 ##
 # @DirtyRateStatus:
-#
-# Dirty page rate measurement status.
+#     Dirty page rate measurement status.
 #
 # @unstarted: measuring thread has not been started yet
 #
@@ -1810,8 +1781,7 @@
 
 ##
 # @TimeUnit:
-#
-# Specifies unit in which time-related value is specified.
+#     Specifies unit in which time-related value is specified.
 #
 # @second: value is in seconds
 #
@@ -1824,8 +1794,7 @@
 
 ##
 # @DirtyRateInfo:
-#
-# Information about measured dirty page rate.
+#     Information about measured dirty page rate.
 #
 # @dirty-rate: an estimate of the dirty page rate of the VM in units
 #     of MiB/s.  Value is present only when @status is 'measured'.
@@ -1935,8 +1904,8 @@
 
 ##
 # @query-dirty-rate:
-#
-# Query results of the most recent invocation of `calc-dirty-rate`.
+#     Query results of the most recent invocation of
+#     `calc-dirty-rate`.
 #
 # @calc-time-unit: time unit in which to report calculation time.
 #     By default it is reported in seconds.  (Since 8.2)
@@ -1962,8 +1931,7 @@
 
 ##
 # @DirtyLimitInfo:
-#
-# Dirty page rate limit information of a virtual CPU.
+#     Dirty page rate limit information of a virtual CPU.
 #
 # @cpu-index: index of a virtual CPU.
 #
@@ -2029,8 +1997,8 @@
 
 ##
 # @query-vcpu-dirty-limit:
-#
-# Return information about virtual CPU dirty page rate limits, if any.
+#     Return information about virtual CPU dirty page rate limits, if
+#     any.
 #
 # Since: 7.1
 #
@@ -2046,8 +2014,7 @@
 
 ##
 # @snapshot-save:
-#
-# Save a VM snapshot
+#     Save a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
@@ -2118,8 +2085,7 @@
 
 ##
 # @snapshot-load:
-#
-# Load a VM snapshot
+#     Load a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
@@ -2188,8 +2154,7 @@
 
 ##
 # @snapshot-delete:
-#
-# Delete a VM snapshot
+#     Delete a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
-- 
2.55.0

