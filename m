Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0712047DF99
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773483; cv=none; b=r1cUjiW6YMyLJSmPra67jvoQVea6Mw7RjxTodJKeDLBg9SXKIeYYDgU5zIdyA9sDhO5M0zFb4Rr1L9bKd+NBOvaUZ9EIbbMkwqsffEtDhR2Lw7a6IWOvnLJwMaGFtRNS4XK1HxdeSdap/bmS6LaiMTrT/rREYrnTfc77TqeXiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773483; c=relaxed/simple;
	bh=Jm1B9WsjAn5YKZqRHJXPCfTnWZMojMn7VIHRhECEAC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=umKzqrEi1ScVRQKZHXnnkGlKXh98XO28Ku3Dgo9HE+YC3uk722t/KDrKAWtBnUpZY9KUowxV/hMkQKJ8pb+J2eI0Cn6219k80uFlzDW9AvaONsZVJtp8Lnx29FWO24YoCx+x4tuaKvtNGnn1JKQ6Sj+Xh2GuENkSnqlX/rcy2e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK9KnujL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK9KnujL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whyI5oC0NF+JVwl/7FlcO+qvyiVZzFrkdTzPuV3wTHU=;
	b=UK9KnujLDj/XhxkMhXKINdWPIDjz8Vqv3kb1ZRbfh+4Z/sO9j2nr5oxlM/jBNVFtaIvH14
	MsIC0FkeeNj7TeZPpKis/Gd97jX1hOEBSh7xGxmQ4L1wwvvcicOqdzKWy3Y7SVEq5QyFM0
	ZMVlfAYgdzLmX2UxXSKMZVWLUEGgj50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-DQ6FDxxeNY6Anr5zLD0l5w-1; Wed,
 26 Aug 2026 15:44:23 -0400
X-MC-Unique: DQ6FDxxeNY6Anr5zLD0l5w-1
X-Mimecast-MFC-AGG-ID: DQ6FDxxeNY6Anr5zLD0l5w_1787773458
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B46EA1855134;
	Wed, 26 Aug 2026 19:44:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79C8D1800577;
	Wed, 26 Aug 2026 19:44:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	John Snow <jsnow@redhat.com>,
	linux-cxl@vger.kernel.org,
	Markus Armbruster <armbru@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	qemu-trivial@nongnu.org,
	Fabiano Rosas <farosas@suse.de>,
	Kevin Wolf <kwolf@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Jiri Pirko <jiri@resnulli.us>,
	qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	linux-edac@vger.kernel.org,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Zhao Liu <zhao1.liu@intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 39/43] qapi: convert trivial intro sections for qom.json
Date: Wed, 26 Aug 2026 15:38:36 -0400
Message-ID: <20260826193840.2152000-40-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 72no-OSmzCdhBSZQlIqn5wJDyuKADRh3weTR3hXFT1c_1787773458
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/qom.json | 150 +++++++++++++++++---------------------------------
 1 file changed, 51 insertions(+), 99 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4a9b7f90884..51af9485e6d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -77,8 +77,7 @@
 
 ##
 # @qom-list:
-#
-# List properties of a object given a path in the object model.
+#     List properties of a object given a path in the object model.
 #
 # @path: the path within the object model.  See `qom-get` for a
 #     description of this parameter.
@@ -103,8 +102,7 @@
 
 ##
 # @qom-get:
-#
-# Get a property value.
+#     Get a property value.
 #
 # @path: The path within the object model.  There are two forms of
 #     supported paths--absolute and partial paths.
@@ -154,9 +152,8 @@
 
 ##
 # @qom-list-get:
-#
-# List properties and their values for each object path in the input
-# list.
+#     List properties and their values for each object path in the
+#     input list.
 #
 # @paths: The absolute or partial path for each object, as described
 #     in `qom-get`.
@@ -176,8 +173,7 @@
 
 ##
 # @qom-set:
-#
-# Set a property value.
+#     Set a property value.
 #
 # @path: see `qom-get` for a description of this parameter
 #
@@ -202,8 +198,7 @@
 
 ##
 # @ObjectTypeInfo:
-#
-# This structure describes a search result from `qom-list-types`
+#     This structure describes a search result from `qom-list-types`
 #
 # @name: the type name found in the search
 #
@@ -219,8 +214,7 @@
 
 ##
 # @qom-list-types:
-#
-# Return a list of types given search parameters.
+#     Return a list of types given search parameters.
 #
 # @implements: if specified, only return types that implement this
 #     type name
@@ -238,8 +232,7 @@
 
 ##
 # @qom-list-properties:
-#
-# List properties associated with a QOM object.
+#     List properties associated with a QOM object.
 #
 # @typename: the type name of an object
 #
@@ -258,8 +251,7 @@
 
 ##
 # @CanHostSocketcanProperties:
-#
-# Properties for can-host-socketcan objects.
+#     Properties for can-host-socketcan objects.
 #
 # @if: interface name of the host system CAN bus to connect to
 #
@@ -275,8 +267,7 @@
 
 ##
 # @ColoCompareProperties:
-#
-# Properties for colo-compare objects.
+#     Properties for colo-compare objects.
 #
 # @primary_in: name of the character device backend to use for the
 #     primary input (incoming packets are redirected to @outdev)
@@ -323,9 +314,8 @@
 
 ##
 # @CryptodevBackendProperties:
-#
-# Properties for cryptodev-backend and cryptodev-backend-builtin
-# objects.
+#     Properties for cryptodev-backend and cryptodev-backend-builtin
+#     objects.
 #
 # @queues: the number of queues for the cryptodev backend.  Ignored
 #     for cryptodev-backend and must be 1 for
@@ -344,8 +334,7 @@
 
 ##
 # @CryptodevVhostUserProperties:
-#
-# Properties for cryptodev-vhost-user objects.
+#     Properties for cryptodev-vhost-user objects.
 #
 # @chardev: the name of a Unix domain socket character device that
 #     connects to the vhost-user server
@@ -359,8 +348,7 @@
 
 ##
 # @DBusVMStateProperties:
-#
-# Properties for dbus-vmstate objects.
+#     Properties for dbus-vmstate objects.
 #
 # @addr: the name of the DBus bus to connect to
 #
@@ -375,9 +363,8 @@
 
 ##
 # @NetfilterInsert:
-#
-# Indicates where to insert a netfilter relative to a given other
-# filter.
+#     Indicates where to insert a netfilter relative to a given other
+#     filter.
 #
 # @before: insert before the specified filter
 #
@@ -390,8 +377,7 @@
 
 ##
 # @NetfilterProperties:
-#
-# Properties for objects of classes derived from netfilter.
+#     Properties for objects of classes derived from netfilter.
 #
 # @netdev: id of the network device backend to filter
 #
@@ -423,8 +409,7 @@
 
 ##
 # @FilterBufferProperties:
-#
-# Properties for filter-buffer objects.
+#     Properties for filter-buffer objects.
 #
 # @interval: a non-zero interval in microseconds.  All packets
 #     arriving in the given interval are delayed until the end of the
@@ -438,8 +423,7 @@
 
 ##
 # @FilterDumpProperties:
-#
-# Properties for filter-dump objects.
+#     Properties for filter-dump objects.
 #
 # @file: the filename where the dumped packets should be stored
 #
@@ -455,8 +439,7 @@
 
 ##
 # @FilterMirrorProperties:
-#
-# Properties for filter-mirror objects.
+#     Properties for filter-mirror objects.
 #
 # @outdev: the name of a character device backend to which all
 #     incoming packets are mirrored
@@ -498,8 +481,7 @@
 
 ##
 # @FilterRewriterProperties:
-#
-# Properties for filter-rewriter objects.
+#     Properties for filter-rewriter objects.
 #
 # @vnet_hdr_support: if true, vnet header support is enabled
 #     (default: false)
@@ -512,8 +494,7 @@
 
 ##
 # @InputBarrierProperties:
-#
-# Properties for input-barrier objects.
+#     Properties for input-barrier objects.
 #
 # @name: the screen name as declared in the screens section of
 #     barrier.conf
@@ -545,8 +526,7 @@
 
 ##
 # @InputLinuxProperties:
-#
-# Properties for input-linux objects.
+#     Properties for input-linux objects.
 #
 # @evdev: the path of the host evdev device to use
 #
@@ -569,8 +549,7 @@
 
 ##
 # @EventLoopBaseProperties:
-#
-# Common properties for event loops
+#     Common properties for event loops
 #
 # @aio-max-batch: maximum number of requests in a batch for the AIO
 #     engine, 0 means that the engine will use its default.
@@ -591,8 +570,7 @@
 
 ##
 # @IothreadProperties:
-#
-# Properties for iothread objects.
+#     Properties for iothread objects.
 #
 # @poll-max-ns: the maximum number of nanoseconds to busy wait for
 #     events.  0 means polling is disabled (default: 32768 on POSIX
@@ -626,8 +604,7 @@
 
 ##
 # @MainLoopProperties:
-#
-# Properties for the main-loop object.
+#     Properties for the main-loop object.
 #
 # Since: 7.1
 ##
@@ -637,8 +614,7 @@
 
 ##
 # @MemoryBackendProperties:
-#
-# Properties for objects of classes derived from memory-backend.
+#     Properties for objects of classes derived from memory-backend.
 #
 # @merge: if true, mark the memory as mergeable (default depends on
 #     the machine type)
@@ -696,8 +672,7 @@
 
 ##
 # @MemoryBackendFileProperties:
-#
-# Properties for memory-backend-file objects.
+#     Properties for memory-backend-file objects.
 #
 # @align: the base address alignment when QEMU mmap(2)s @mem-path.
 #     Some backend stores specified by @mem-path require an alignment
@@ -757,8 +732,7 @@
 
 ##
 # @MemoryBackendMemfdProperties:
-#
-# Properties for memory-backend-memfd objects.
+#     Properties for memory-backend-memfd objects.
 #
 # @hugetlb: if true, the file to be created resides in the hugetlbfs
 #     filesystem (default: false)
@@ -813,8 +787,7 @@
 
 ##
 # @PrManagerHelperProperties:
-#
-# Properties for pr-manager-helper objects.
+#     Properties for pr-manager-helper objects.
 #
 # @path: the path to a Unix domain socket for connecting to the
 #     external helper
@@ -827,8 +800,7 @@
 
 ##
 # @QtestProperties:
-#
-# Properties for qtest objects.
+#     Properties for qtest objects.
 #
 # @chardev: the chardev to be used to receive qtest commands on.
 #
@@ -842,8 +814,7 @@
 
 ##
 # @RemoteObjectProperties:
-#
-# Properties for x-remote-object objects.
+#     Properties for x-remote-object objects.
 #
 # @fd: file descriptor name previously passed via `getfd` command
 #
@@ -857,8 +828,7 @@
 
 ##
 # @VfioUserServerProperties:
-#
-# Properties for x-vfio-user-server objects.
+#     Properties for x-vfio-user-server objects.
 #
 # @socket: socket to be used by the libvfio-user library
 #
@@ -871,8 +841,7 @@
 
 ##
 # @IOMMUFDProperties:
-#
-# Properties for iommufd objects.
+#     Properties for iommufd objects.
 #
 # @fd: file descriptor name previously passed via `getfd` command,
 #     which represents a pre-opened /dev/iommu.  This allows the
@@ -887,8 +856,7 @@
 
 ##
 # @AcpiGenericInitiatorProperties:
-#
-# Properties for acpi-generic-initiator objects.
+#     Properties for acpi-generic-initiator objects.
 #
 # @pci-dev: PCI device ID to be associated with the node
 #
@@ -902,8 +870,7 @@
 
 ##
 # @AcpiGenericPortProperties:
-#
-# Properties for acpi-generic-port objects.
+#     Properties for acpi-generic-port objects.
 #
 # @pci-bus: QOM path of the PCI bus of the hostbridge associated with
 #     this SRAT Generic Port Affinity Structure.  This is the same as
@@ -941,8 +908,7 @@
 
 ##
 # @RngProperties:
-#
-# Properties for objects of classes derived from rng.
+#     Properties for objects of classes derived from rng.
 #
 # @opened: if true, the device is opened immediately when applying
 #     this option and will probably fail when processing the next
@@ -961,8 +927,7 @@
 
 ##
 # @RngEgdProperties:
-#
-# Properties for rng-egd objects.
+#     Properties for rng-egd objects.
 #
 # @chardev: the name of a character device backend that provides the
 #     connection to the RNG daemon
@@ -975,8 +940,7 @@
 
 ##
 # @RngRandomProperties:
-#
-# Properties for rng-random objects.
+#     Properties for rng-random objects.
 #
 # @filename: the filename of the device on the host to obtain entropy
 #     from (default: "/dev/urandom")
@@ -990,8 +954,7 @@
 
 ##
 # @IgvmCfgProperties:
-#
-# Properties common to objects that handle IGVM files.
+#     Properties common to objects that handle IGVM files.
 #
 # @file: IGVM file to use to configure guest
 #
@@ -1003,8 +966,7 @@
 
 ##
 # @SevCommonProperties:
-#
-# Properties common to objects that are derivatives of sev-common.
+#     Properties common to objects that are derivatives of sev-common.
 #
 # @sev-device: SEV device to use (default: "/dev/sev")
 #
@@ -1038,8 +1000,7 @@
 
 ##
 # @SevGuestProperties:
-#
-# Properties for sev-guest objects.
+#     Properties for sev-guest objects.
 #
 # @dh-cert-file: guest owners DH certificate (encoded with base64)
 #
@@ -1136,8 +1097,7 @@
 
 ##
 # @TdxGuestProperties:
-#
-# Properties for tdx-guest objects.
+#     Properties for tdx-guest objects.
 #
 # @attributes: The 'attributes' of a TD guest that is passed to
 #     KVM_TDX_INIT_VM
@@ -1181,8 +1141,7 @@
 
 ##
 # @ThreadContextProperties:
-#
-# Properties for thread context objects.
+#     Properties for thread context objects.
 #
 # @cpu-affinity: the list of host CPU numbers used as CPU affinity for
 #     all threads created in the thread context (default: QEMU main
@@ -1202,8 +1161,7 @@
 
 ##
 # @MonitorProperties:
-#
-# Properties for all monitors
+#     Properties for all monitors
 #
 # @chardev: ID of the character device providing the monitor transport
 #
@@ -1214,8 +1172,7 @@
 
 ##
 # @MonitorHMPProperties:
-#
-# Properties for the HMP monitor
+#     Properties for the HMP monitor
 #
 # @readline: whether to enable readline for line editing
 #      (default: true)
@@ -1229,8 +1186,7 @@
 
 ##
 # @MonitorQMPCloseAction:
-#
-# Action to take when the character device backend is closed.
+#     Action to take when the character device backend is closed.
 #
 # @none: take no action
 #
@@ -1244,8 +1200,7 @@
 
 ##
 # @MonitorQMPProperties:
-#
-# Properties for the QMP monitor
+#     Properties for the QMP monitor
 #
 # @pretty: whether to pretty print JSON responses (default: false)
 #
@@ -1338,8 +1293,7 @@
 
 ##
 # @ObjectOptions:
-#
-# Describes the options of a user creatable QOM object.
+#     Describes the options of a user creatable QOM object.
 #
 # @qom-type: the class name for the object to be created
 #
@@ -1416,8 +1370,7 @@
 
 ##
 # @object-add:
-#
-# Create a QOM object.
+#     Create a QOM object.
 #
 # Errors:
 #     - If @qom-type is not a valid class name
@@ -1436,8 +1389,7 @@
 
 ##
 # @object-del:
-#
-# Remove a QOM object.
+#     Remove a QOM object.
 #
 # @id: the name of the QOM object to remove
 #
-- 
2.55.0

