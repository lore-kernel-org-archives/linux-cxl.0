Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A16447B438
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773513; cv=none; b=dZ0FIQjmqj0Au0ZCY0ucomryrVWf7QZN07rm+iIBFOMWdEfoKUi3tADgb9AY9Q4flb12HaLL+esjHsn/D34zm+8xSAS04uKaSloKF9N1iKPjF29WK7/3V9x+DQBBDwyBPHIvvJ67gN8oCOZoZmYecP+FK0sp483sBZHRHRC9NNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773513; c=relaxed/simple;
	bh=RjLRnEkv2O62QEPq+B+5DliZUNxztMK71VrGABMgmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=C0VZ+wuAQty/vba9sIgzAawdcX8xpP2pCfMevulkvpxqSxC/LPWAVoCEuKRYOQJ9p+iaxrK8F92YCJUKQitK71EEjYVgvn/9eia0ES6DKCVP/fDQHeNOIXNYrt9aLwm/BBWuyTpziagnqYPGca/AHKjhG/Kll6B16jy6aUBQ98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqtmM5s6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqtmM5s6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787773493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTQIfh/5m9QZH2LXfLdLzWBOA8HLXnnjEI9dA8mmcBM=;
	b=CqtmM5s63fbR3nOp4wSC3qniDfAmT3cKNWsxp5jQvwR5rRIiLrjEruEwGHjX4joeZbYr9T
	5bPYQVICLyegKPSoyLh3pRdL8cK7flEnQVss5NEwX1sDQkEwDjBMNpjIUfnNvqvsksEiTq
	8d0waZBzHtKrEFXlEmWdjTqOoabJl7g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-_LXNbdpAOdWgqf6d00sLuw-1; Wed,
 26 Aug 2026 15:44:49 -0400
X-MC-Unique: _LXNbdpAOdWgqf6d00sLuw-1
X-Mimecast-MFC-AGG-ID: _LXNbdpAOdWgqf6d00sLuw_1787773486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB08C19560A7;
	Wed, 26 Aug 2026 19:44:46 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6AC61800598;
	Wed, 26 Aug 2026 19:44:38 +0000 (UTC)
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
Subject: [PATCH v3 42/43] qapi: convert trivial intro sections for machine.json
Date: Wed, 26 Aug 2026 15:38:39 -0400
Message-ID: <20260826193840.2152000-43-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: tWcAdq8KMzq-YsJTwBSjWKQYIbxusrAKFGUb1ijC0gc_1787773486
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 208 ++++++++++++++++------------------------------
 1 file changed, 73 insertions(+), 135 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 2d63c1bac3b..3a5c6df9cff 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -46,9 +46,8 @@
 
 ##
 # @S390CpuState:
-#
-# An enumeration of cpu states that can be assumed by a virtual S390
-# CPU
+#     An enumeration of cpu states that can be assumed by a virtual
+#     S390 CPU
 #
 # Since: 2.12
 ##
@@ -57,8 +56,7 @@
 
 ##
 # @CpuInfoS390:
-#
-# Additional information about a virtual S390 CPU
+#     Additional information about a virtual S390 CPU
 #
 # @cpu-state: the virtual CPU's state
 #
@@ -75,8 +73,7 @@
 
 ##
 # @CpuInfoFast:
-#
-# Information about a virtual CPU
+#     Information about a virtual CPU
 #
 # @cpu-index: index of the virtual CPU
 #
@@ -105,8 +102,7 @@
 
 ##
 # @query-cpus-fast:
-#
-# Return information about all virtual CPUs.
+#     Return information about all virtual CPUs.
 #
 # Since: 2.12
 #
@@ -143,9 +139,8 @@
 
 ##
 # @CompatProperty:
-#
-# Property default values specific to a machine type, for use by
-# scripts/compare-machine-types.
+#     Property default values specific to a machine type, for use by
+#     scripts/compare-machine-types.
 #
 # @qom-type: name of the QOM type to which the default applies
 #
@@ -163,8 +158,7 @@
 
 ##
 # @MachineInfo:
-#
-# Information describing a machine.
+#     Information describing a machine.
 #
 # @name: the name of the machine
 #
@@ -213,8 +207,7 @@
 
 ##
 # @query-machines:
-#
-# Return a list of supported machines
+#     Return a list of supported machines
 #
 # @compat-props: if true, also return compatibility properties.
 #     (default: false) (since 9.1)
@@ -255,8 +248,7 @@
 
 ##
 # @CurrentMachineParams:
-#
-# Information describing the running machine parameters.
+#     Information describing the running machine parameters.
 #
 # @wakeup-suspend-support: true if the machine supports wake up from
 #     suspend
@@ -268,8 +260,7 @@
 
 ##
 # @query-current-machine:
-#
-# Return information on the current virtual machine.
+#     Return information on the current virtual machine.
 #
 # Since: 4.0
 ##
@@ -277,8 +268,8 @@
 
 ##
 # @QemuTargetInfo:
-#
-# Information on the target configuration built into the QEMU binary.
+#     Information on the target configuration built into the QEMU
+#     binary.
 #
 # @arch: the target architecture
 #
@@ -289,8 +280,7 @@
 
 ##
 # @query-target:
-#
-# Return information about the target for this QEMU
+#     Return information about the target for this QEMU
 #
 # Since: 1.2
 ##
@@ -298,8 +288,7 @@
 
 ##
 # @UuidInfo:
-#
-# Guest UUID information (Universally Unique Identifier).
+#     Guest UUID information (Universally Unique Identifier).
 #
 # @UUID: the UUID of the guest
 #
@@ -312,8 +301,7 @@
 
 ##
 # @query-uuid:
-#
-# Query the guest UUID information.
+#     Query the guest UUID information.
 #
 # Since: 0.14
 #
@@ -326,8 +314,7 @@
 
 ##
 # @GuidInfo:
-#
-# GUID information.
+#     GUID information.
 #
 # @guid: the globally unique identifier
 #
@@ -337,8 +324,7 @@
 
 ##
 # @query-vm-generation-id:
-#
-# Show Virtual Machine Generation ID
+#     Show Virtual Machine Generation ID
 #
 # Since: 2.9
 ##
@@ -346,8 +332,7 @@
 
 ##
 # @system_reset:
-#
-# Performs a hard reset of a guest.
+#     Performs a hard reset of a guest.
 #
 # Since: 0.14
 #
@@ -360,8 +345,7 @@
 
 ##
 # @system_powerdown:
-#
-# Requests that a guest perform a powerdown operation.
+#     Requests that a guest perform a powerdown operation.
 #
 # Since: 0.14
 #
@@ -469,8 +453,7 @@
 
 ##
 # @NumaOptions:
-#
-# A discriminated record of NUMA options.  (for OptsVisitor)
+#     A discriminated record of NUMA options.  (for OptsVisitor)
 #
 # @type: NUMA option type
 #
@@ -488,8 +471,7 @@
 
 ##
 # @NumaNodeOptions:
-#
-# Create a guest NUMA node.  (for OptsVisitor)
+#     Create a guest NUMA node.  (for OptsVisitor)
 #
 # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
 #
@@ -521,8 +503,7 @@
 
 ##
 # @NumaDistOptions:
-#
-# Set the distance between 2 NUMA nodes.
+#     Set the distance between 2 NUMA nodes.
 #
 # @src: source NUMA node.
 #
@@ -542,8 +523,7 @@
 
 ##
 # @CXLFixedMemoryWindowOptions:
-#
-# Create a CXL Fixed Memory Window
+#     Create a CXL Fixed Memory Window
 #
 # @size: Size of the Fixed Memory Window in bytes.  Must be a multiple
 #     of 256MiB.
@@ -565,8 +545,7 @@
 
 ##
 # @CXLFMWProperties:
-#
-# List of CXL Fixed Memory Windows.
+#     List of CXL Fixed Memory Windows.
 #
 # @cxl-fmw: List of `CXLFixedMemoryWindowOptions`
 #
@@ -578,8 +557,7 @@
 
 ##
 # @X86CPURegister32:
-#
-# A X86 32-bit register
+#     A X86 32-bit register
 #
 # Since: 1.5
 ##
@@ -588,8 +566,7 @@
 
 ##
 # @X86CPUFeatureWordInfo:
-#
-# Information about a X86 CPU feature word
+#     Information about a X86 CPU feature word
 #
 # @cpuid-input-eax: Input EAX value for CPUID instruction for that
 #     feature word
@@ -611,9 +588,8 @@
 
 ##
 # @DummyForceArrays:
-#
-# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
-# internally
+#     Not used by QMP; hack to let us use X86CPUFeatureWordInfoList
+#     internally
 #
 # Since: 2.5
 ##
@@ -795,8 +771,7 @@
 
 ##
 # @memsave:
-#
-# Save a portion of guest memory to a file.
+#     Save a portion of guest memory to a file.
 #
 # @val: the virtual address of the guest to start from
 #
@@ -828,8 +803,7 @@
 
 ##
 # @pmemsave:
-#
-# Save a portion of guest physical memory to a file.
+#     Save a portion of guest physical memory to a file.
 #
 # @val: the physical address of the guest to start from
 #
@@ -857,8 +831,7 @@
 
 ##
 # @Memdev:
-#
-# Information about memory backend
+#     Information about memory backend
 #
 # @id: backend's ID if backend has 'id' property (since 2.9)
 #
@@ -898,8 +871,7 @@
 
 ##
 # @query-memdev:
-#
-# Return information for all memory backends.
+#     Return information for all memory backends.
 #
 # Since: 2.1
 #
@@ -1074,9 +1046,9 @@
 
 ##
 # @set-numa-node:
-#
-# Runtime equivalent of '-numa' CLI option, available at preconfigure
-# stage to configure numa mapping before initializing machine.
+#     Runtime equivalent of '-numa' CLI option, available at
+#     preconfigure stage to configure numa mapping before initializing
+#     machine.
 #
 # Since: 3.0
 ##
@@ -1087,8 +1059,7 @@
 
 ##
 # @balloon:
-#
-# Request the balloon driver to change its balloon size.
+#     Request the balloon driver to change its balloon size.
 #
 # @value: the target logical size of the VM in bytes.  We can deduce
 #     the size of the balloon using this formula:
@@ -1122,8 +1093,7 @@
 
 ##
 # @BalloonInfo:
-#
-# Information about the guest balloon device.
+#     Information about the guest balloon device.
 #
 # @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
@@ -1134,8 +1104,7 @@
 
 ##
 # @query-balloon:
-#
-# Return information about the balloon device.
+#     Return information about the balloon device.
 #
 # Errors:
 #     - If the balloon driver is enabled but not functional because
@@ -1156,10 +1125,9 @@
 
 ##
 # @BALLOON_CHANGE:
-#
-# Emitted when the guest changes the actual BALLOON level.  This value
-# is equivalent to the @actual field return by the `query-balloon`
-# command
+#     Emitted when the guest changes the actual BALLOON level.  This
+#     value is equivalent to the @actual field return by the
+#     `query-balloon` command
 #
 # @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
@@ -1179,8 +1147,7 @@
 
 ##
 # @HvBalloonInfo:
-#
-# hv-balloon guest-provided memory status information.
+#     hv-balloon guest-provided memory status information.
 #
 # @committed: the amount of memory in use inside the guest plus the
 #     amount of the memory unusable inside the guest (ballooned out,
@@ -1196,9 +1163,8 @@
 
 ##
 # @query-hv-balloon-status-report:
-#
-# Return the hv-balloon driver data contained in the last received
-# "STATUS" message from the guest.
+#     Return the hv-balloon driver data contained in the last received
+#     "STATUS" message from the guest.
 #
 # Errors:
 #     - If no hv-balloon device is present, guest memory status
@@ -1239,8 +1205,7 @@
 
 ##
 # @MemoryInfo:
-#
-# Actual memory information in bytes.
+#     Actual memory information in bytes.
 #
 # @base-memory: size of "base" memory specified with command line
 #     option -m.
@@ -1273,8 +1238,7 @@
 
 ##
 # @PCDIMMDeviceInfo:
-#
-# PCDIMMDevice state information
+#     PCDIMMDevice state information
 #
 # @id: device's ID
 #
@@ -1309,8 +1273,7 @@
 
 ##
 # @VirtioPMEMDeviceInfo:
-#
-# VirtioPMEM state information
+#     VirtioPMEM state information
 #
 # @id: device's ID
 #
@@ -1332,8 +1295,7 @@
 
 ##
 # @VirtioMEMDeviceInfo:
-#
-# VirtioMEMDevice state information
+#     VirtioMEMDevice state information
 #
 # @id: device's ID
 #
@@ -1367,8 +1329,7 @@
 
 ##
 # @SgxEPCDeviceInfo:
-#
-# Sgx EPC state information
+#     Sgx EPC state information
 #
 # @id: device's ID
 #
@@ -1393,8 +1354,7 @@
 
 ##
 # @HvBalloonDeviceInfo:
-#
-# hv-balloon provided memory state information
+#     hv-balloon provided memory state information
 #
 # @id: device's ID
 #
@@ -1523,8 +1483,7 @@
 
 ##
 # @MemoryDeviceInfo:
-#
-# Union containing information about a memory device
+#     Union containing information about a memory device
 #
 # @type: memory device type
 #
@@ -1545,8 +1504,7 @@
 
 ##
 # @SgxEPC:
-#
-# Sgx EPC cmdline information
+#     Sgx EPC cmdline information
 #
 # @memdev: memory backend linked with device
 #
@@ -1562,8 +1520,7 @@
 
 ##
 # @SgxEPCProperties:
-#
-# SGX properties of machine types.
+#     SGX properties of machine types.
 #
 # @sgx-epc: list of ids of memory-backend-epc objects.
 #
@@ -1575,8 +1532,7 @@
 
 ##
 # @query-memory-devices:
-#
-# Lists available memory devices and their state
+#     Lists available memory devices and their state
 #
 # Since: 2.1
 #
@@ -1626,8 +1582,7 @@
 
 ##
 # @BootConfiguration:
-#
-# Schema for virtual machine boot configuration.
+#     Schema for virtual machine boot configuration.
 #
 # @order: Boot order (a=floppy, c=hard disk, d=CD-ROM, n=network)
 #
@@ -1711,8 +1666,7 @@
 
 ##
 # @x-query-irq:
-#
-# Query interrupt statistics
+#     Query interrupt statistics
 #
 # Features:
 #
@@ -1728,8 +1682,7 @@
 
 ##
 # @x-query-jit:
-#
-# Query TCG compiler statistics
+#     Query TCG compiler statistics
 #
 # Features:
 #
@@ -1746,8 +1699,7 @@
 
 ##
 # @x-query-numa:
-#
-# Query NUMA topology information
+#     Query NUMA topology information
 #
 # Features:
 #
@@ -1763,8 +1715,7 @@
 
 ##
 # @x-query-ramblock:
-#
-# Query system ramblock information
+#     Query system ramblock information
 #
 # Features:
 #
@@ -1780,8 +1731,7 @@
 
 ##
 # @x-query-roms:
-#
-# Query information on the registered ROMS
+#     Query information on the registered ROMS
 #
 # Features:
 #
@@ -1797,8 +1747,7 @@
 
 ##
 # @x-query-usb:
-#
-# Query information on the USB devices
+#     Query information on the USB devices
 #
 # Features:
 #
@@ -1829,8 +1778,7 @@
 
 ##
 # @MemorySizeConfiguration:
-#
-# Schema for memory size configuration.
+#     Schema for memory size configuration.
 #
 # @size: memory size in bytes
 #
@@ -1847,8 +1795,7 @@
 
 ##
 # @dumpdtb:
-#
-# Save the FDT in dtb format.
+#     Save the FDT in dtb format.
 #
 # @filename: name of the dtb file to be created
 #
@@ -1866,8 +1813,7 @@
 
 ##
 # @x-query-interrupt-controllers:
-#
-# Query information on interrupt controller devices
+#     Query information on interrupt controller devices
 #
 # Features:
 #
@@ -1897,8 +1843,7 @@
 
 ##
 # @query-firmware-log:
-#
-# Find firmware memory log buffer in guest memory, return content.
+#     Find firmware memory log buffer in guest memory, return content.
 #
 # @max-size: limit the amount of log data returned.  Up to 1 MiB of
 #     log data is allowed.  In case the amount of log data is larger
@@ -1912,8 +1857,7 @@
 
 ##
 # @dump-skeys:
-#
-# Dump the storage keys for an s390x guest
+#     Dump the storage keys for an s390x guest
 #
 # @filename: the path to the file to dump to
 #
@@ -1951,8 +1895,7 @@
 
 ##
 # @CpuModelExpansionType:
-#
-# An enumeration of CPU model expansion types.
+#     An enumeration of CPU model expansion types.
 #
 # @static: Expand to a static CPU model, a combination of a static
 #     base model name and property delta changes.  As the static base
@@ -2009,8 +1952,7 @@
 
 ##
 # @CpuModelBaselineInfo:
-#
-# The result of a CPU model baseline.
+#     The result of a CPU model baseline.
 #
 # @model: the baselined `CpuModelInfo`.
 #
@@ -2021,8 +1963,7 @@
 
 ##
 # @CpuModelCompareInfo:
-#
-# The result of a CPU model comparison.
+#     The result of a CPU model comparison.
 #
 # @result: The result of the compare operation.
 #
@@ -2153,8 +2094,7 @@
 
 ##
 # @CpuModelExpansionInfo:
-#
-# The result of a cpu model expansion.
+#     The result of a cpu model expansion.
 #
 # @model: the expanded `CpuModelInfo`.
 #
@@ -2223,8 +2163,7 @@
 
 ##
 # @CpuDefinitionInfo:
-#
-# Virtual CPU definition.
+#     Virtual CPU definition.
 #
 # @name: the name of the CPU definition
 #
@@ -2285,8 +2224,7 @@
 
 ##
 # @query-cpu-definitions:
-#
-# Return a list of supported virtual CPU definitions
+#     Return a list of supported virtual CPU definitions
 #
 # Since: 1.2
 ##
-- 
2.55.0

