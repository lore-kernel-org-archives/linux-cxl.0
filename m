Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8939E178
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782538; cv=none; b=i9D6xv2GyIHKq0aMwjp9X7j4dAVfcLKP3gGpm+dEDXforGkVjuInrqPzlCQwkyI3Z3Rb7ryyysBjVJwcF3jiTF49Y8fbQOm3TL2MP5Y/X8SeXoNOuTx1N8Hu7qJb/02VKjUMgSb7wbcpSLciUvA0X4NNDPQ7Ml7mboedepaYeO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782538; c=relaxed/simple;
	bh=fFBK+AV8rbUkTiLjhewn05rt480tf8+CoJFRT/lQ+e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dVSpQAerhoJ/QWphBGzHY22BNK8ANH1f/kbGre+Wludcx+XdiMPouyuDbXU1X3qhp2RgNmcsEBg5q3mO50esUMEmscj2yH2bRgGK1DtnuKQBJcc9f7GrqwObQPhxGb98+60yF2IoC+ppqHqFyUSNqgsuZIJ3uYMmbaj9ImjYBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBrOBiOx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBrOBiOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50CZod/iUePAFwxf+WZghW/YZKa0XPt7IqYHe7UOp5g=;
	b=eBrOBiOxgXa8qHu7dpbgPXOArUYcBxd90w2zb/YJZa6+QNhQ/JdzNCfYI/I4W4pDbb3V98
	55sxO5Aek/x31MMke1g/wrxjC4niXVvWAS4FVbiCp3UKv824eFJxjbfMk7cpcsto97PFhg
	xrF8EyJXJFhLn4YTfbExffhvjuhdtgY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-6KLshGhfPWKysXqy8wvqgw-1; Thu,
 23 Jul 2026 00:55:15 -0400
X-MC-Unique: 6KLshGhfPWKysXqy8wvqgw-1
X-Mimecast-MFC-AGG-ID: 6KLshGhfPWKysXqy8wvqgw_1784782512
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F355195FE0B;
	Thu, 23 Jul 2026 04:55:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE85918002AE;
	Thu, 23 Jul 2026 04:55:02 +0000 (UTC)
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
Subject: [PATCH v2 42/44] qapi: convert trivial intro sections for migration.json
Date: Thu, 23 Jul 2026 00:48:03 -0400
Message-ID: <20260723044805.527643-43-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: wZ9NbJD34brteeSkVbloDjejgHUKA69E1XJ65dWF5EM_1784782512
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 201 +++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 123 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 66bd900465a..f9300c9e329 100644
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
@@ -339,9 +333,9 @@
 
 ##
 # @query-migrate:
-#
-# Return information about current migration process.  If migration is
-# active there will be another json-object with RAM migration status.
+#     Return information about current migration process.  If
+#     migration is active there will be another json-object with RAM
+#     migration status.
 #
 # Since: 0.14
 #
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
@@ -798,9 +788,8 @@
 
 ##
 # @MigrationParameter:
-#
-# Migration parameters enumeration.  The enumeration values mirror the
-# members of @MigrationParameters.
+#     Migration parameters enumeration.  The enumeration values mirror
+#     the members of @MigrationParameters.
 #
 # Features:
 #
@@ -834,8 +823,7 @@
 
 ##
 # @migrate-set-parameters:
-#
-# Set migration parameters.  All arguments are optional.
+#     Set migration parameters.  All arguments are optional.
 #
 # Since: 2.4
 #
@@ -1057,11 +1045,10 @@
 
 ##
 # @query-migrate-parameters:
-#
-# Return information about the current migration parameters.  Optional
-# members of the return value are always present, except
-# @block-bitmap-mapping, which is only present if it has been
-# previously set.
+#     Return information about the current migration parameters.
+#     Optional members of the return value are always present, except
+#     @block-bitmap-mapping, which is only present if it has been
+#     previously set.
 #
 # Since: 2.4
 #
@@ -1082,10 +1069,9 @@
 
 ##
 # @migrate-start-postcopy:
-#
-# Followup to a migration command to switch the migration to postcopy
-# mode.  The postcopy-ram capability must be set on both source and
-# destination before the original migration command.
+#     Followup to a migration command to switch the migration to
+#     postcopy mode.  The postcopy-ram capability must be set on both
+#     source and destination before the original migration command.
 #
 # Since: 2.5
 #
@@ -1098,8 +1084,7 @@
 
 ##
 # @MIGRATION:
-#
-# Emitted when a migration event happens
+#     Emitted when a migration event happens
 #
 # @status: `MigrationStatus` describing the current migration status.
 #
@@ -1116,9 +1101,8 @@
 
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
@@ -1134,8 +1118,8 @@
 
 ##
 # @COLOMessage:
-#
-# The message transmission between Primary side and Secondary side.
+#     The message transmission between Primary side and Secondary
+#     side.
 #
 # @checkpoint-ready: Secondary VM (SVM) is ready for checkpointing
 #
@@ -1161,8 +1145,7 @@
 
 ##
 # @COLOMode:
-#
-# The COLO current mode.
+#     The COLO current mode.
 #
 # @none: COLO is disabled.
 #
@@ -1177,8 +1160,7 @@
 
 ##
 # @FailoverStatus:
-#
-# An enumeration of COLO failover status
+#     An enumeration of COLO failover status
 #
 # @none: no failover has ever happened
 #
@@ -1198,9 +1180,8 @@
 
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
@@ -1218,8 +1199,7 @@
 
 ##
 # @COLOExitReason:
-#
-# The reason for a COLO exit.
+#     The reason for a COLO exit.
 #
 # @none: failover has never happened.  This state does not occur in
 #     the `COLO_EXIT` event, and is only visible in the result of
@@ -1238,12 +1218,11 @@
 
 ##
 # @x-colo-lost-heartbeat:
-#
-# Tell QEMU that heartbeat is lost, request it to do takeover
-# procedures.  If this command is sent to the PVM, the Primary side
-# will exit COLO mode.  If sent to the Secondary, the Secondary side
-# will run failover work, then takes over server operation to become
-# the service VM.
+#     Tell QEMU that heartbeat is lost, request it to do takeover
+#     procedures.  If this command is sent to the PVM, the Primary
+#     side will exit COLO mode.  If sent to the Secondary, the
+#     Secondary side will run failover work, then takes over server
+#     operation to become the service VM.
 #
 # Features:
 #
@@ -1281,8 +1260,7 @@
 
 ##
 # @migrate-continue:
-#
-# Continue migration when it's in a paused state.
+#     Continue migration when it's in a paused state.
 #
 # @state: The state the migration is currently expected to be in
 #
@@ -1298,8 +1276,7 @@
 
 ##
 # @MigrationAddressType:
-#
-# The migration stream transport mechanisms.
+#     The migration stream transport mechanisms.
 #
 # @socket: Migrate via socket.
 #
@@ -1339,8 +1316,7 @@
 
 ##
 # @MigrationAddress:
-#
-# Migration endpoint configuration.
+#     Migration endpoint configuration.
 #
 # @transport: The migration stream transport mechanism
 #
@@ -1357,8 +1333,7 @@
 
 ##
 # @MigrationChannelType:
-#
-# The migration channel-type request options.
+#     The migration channel-type request options.
 #
 # @main: Main outbound migration channel.
 #
@@ -1371,8 +1346,7 @@
 
 ##
 # @MigrationChannel:
-#
-# Migration stream channel parameters.
+#     Migration stream channel parameters.
 #
 # @channel-type: Channel type for transferring packet information.
 #
@@ -1387,8 +1361,7 @@
 
 ##
 # @migrate:
-#
-# Migrates the current running guest to another Virtual Machine.
+#     Migrates the current running guest to another Virtual Machine.
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
@@ -1464,9 +1437,8 @@
 
 ##
 # @migrate-incoming:
-#
-# Start an incoming migration.  QEMU must have been started with
-# -incoming defer.
+#     Start an incoming migration.  QEMU must have been started with
+#     -incoming defer.
 #
 # @uri: The Uniform Resource Identifier identifying the source or
 #     address to listen on
@@ -1536,9 +1508,8 @@
 
 ##
 # @xen-save-devices-state:
-#
-# Save the state of all devices to file.  The RAM and the block
-# devices of the VM are not saved by this command.
+#     Save the state of all devices to file.  The RAM and the block
+#     devices of the VM are not saved by this command.
 #
 # @filename: the file to save the state of the devices to as binary
 #     data.  See `xen-save-devices-state`.txt for a description of the
@@ -1560,8 +1531,7 @@
 
 ##
 # @xen-set-global-dirty-log:
-#
-# Enable or disable the global dirty log mode.
+#     Enable or disable the global dirty log mode.
 #
 # @enable: true to enable, false to disable.
 #
@@ -1577,9 +1547,8 @@
 
 ##
 # @xen-load-devices-state:
-#
-# Load the state of all devices from file.  The RAM and the block
-# devices of the VM are not loaded by this command.
+#     Load the state of all devices from file.  The RAM and the block
+#     devices of the VM are not loaded by this command.
 #
 # @filename: the file to load the state of the devices from as binary
 #     data.  See `xen-save-devices-state`.txt for a description of the
@@ -1597,8 +1566,7 @@
 
 ##
 # @xen-set-replication:
-#
-# Enable or disable replication.
+#     Enable or disable replication.
 #
 # @enable: true to enable, false to disable.
 #
@@ -1621,8 +1589,7 @@
 
 ##
 # @ReplicationStatus:
-#
-# The result format for `query-xen-replication-status`.
+#     The result format for `query-xen-replication-status`.
 #
 # @error: true if an error happened, false if replication is normal.
 #
@@ -1670,8 +1637,7 @@
 
 ##
 # @COLOStatus:
-#
-# The result format for `query-colo-status`.
+#     The result format for `query-colo-status`.
 #
 # @mode: COLO running mode.  If COLO is running, this field will
 #     return 'primary' or 'secondary'.
@@ -1709,8 +1675,7 @@
 
 ##
 # @migrate-recover:
-#
-# Provide a recovery migration stream URI.
+#     Provide a recovery migration stream URI.
 #
 # @uri: the URI to be used for the recovery of migration stream.
 #
@@ -1742,11 +1707,10 @@
 
 ##
 # @UNPLUG_PRIMARY:
-#
-# Emitted from source side of a migration when migration state is
-# WAIT_UNPLUG.  Device was unplugged by guest operating system.
-# Device resources in QEMU are kept on standby to be able to re-plug
-# it in case of migration failure.
+#     Emitted from source side of a migration when migration state is
+#     WAIT_UNPLUG.  Device was unplugged by guest operating system.
+#     Device resources in QEMU are kept on standby to be able to
+#     re-plug it in case of migration failure.
 #
 # @device-id: QEMU device id of the unplugged device
 #
@@ -1763,8 +1727,7 @@
 
 ##
 # @DirtyRateVcpu:
-#
-# Dirty rate of vcpu.
+#     Dirty rate of vcpu.
 #
 # @id: vcpu index.
 #
@@ -1777,8 +1740,7 @@
 
 ##
 # @DirtyRateStatus:
-#
-# Dirty page rate measurement status.
+#     Dirty page rate measurement status.
 #
 # @unstarted: measuring thread has not been started yet
 #
@@ -1793,9 +1755,8 @@
 
 ##
 # @DirtyRateMeasureMode:
-#
-# Method used to measure dirty page rate.  Differences between
-# available methods are explained in `calc-dirty-rate`.
+#     Method used to measure dirty page rate.  Differences between
+#     available methods are explained in `calc-dirty-rate`.
 #
 # @page-sampling: use page sampling
 #
@@ -1810,8 +1771,7 @@
 
 ##
 # @TimeUnit:
-#
-# Specifies unit in which time-related value is specified.
+#     Specifies unit in which time-related value is specified.
 #
 # @second: value is in seconds
 #
@@ -1824,8 +1784,7 @@
 
 ##
 # @DirtyRateInfo:
-#
-# Information about measured dirty page rate.
+#     Information about measured dirty page rate.
 #
 # @dirty-rate: an estimate of the dirty page rate of the VM in units
 #     of MiB/s.  Value is present only when @status is 'measured'.
@@ -1935,8 +1894,8 @@
 
 ##
 # @query-dirty-rate:
-#
-# Query results of the most recent invocation of `calc-dirty-rate`.
+#     Query results of the most recent invocation of
+#     `calc-dirty-rate`.
 #
 # @calc-time-unit: time unit in which to report calculation time.
 #     By default it is reported in seconds.  (Since 8.2)
@@ -1962,8 +1921,7 @@
 
 ##
 # @DirtyLimitInfo:
-#
-# Dirty page rate limit information of a virtual CPU.
+#     Dirty page rate limit information of a virtual CPU.
 #
 # @cpu-index: index of a virtual CPU.
 #
@@ -2029,8 +1987,8 @@
 
 ##
 # @query-vcpu-dirty-limit:
-#
-# Return information about virtual CPU dirty page rate limits, if any.
+#     Return information about virtual CPU dirty page rate limits, if
+#     any.
 #
 # Since: 7.1
 #
@@ -2046,8 +2004,7 @@
 
 ##
 # @snapshot-save:
-#
-# Save a VM snapshot
+#     Save a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
@@ -2118,8 +2075,7 @@
 
 ##
 # @snapshot-load:
-#
-# Load a VM snapshot
+#     Load a VM snapshot
 #
 # @job-id: identifier for the newly created job
 #
@@ -2188,8 +2144,7 @@
 
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

