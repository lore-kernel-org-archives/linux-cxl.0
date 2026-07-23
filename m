Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708083A451E
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jul 2026 04:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782540; cv=none; b=Xz0NKsSEaQE1hR39IhX3KUYWFBDxm50F+shlax0QL2LLYcHYT68HFZlnn3FGVBpT3eUBQsFVx33fc/Ik3iLPIYtOG/xDtV0vVcmyfwZogG68w4Kml737sRQH4K1uWgAUc2bAfVPlMVUJ0AfB+zpyqtwNoWtZYxKVlOmMfg2On9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782540; c=relaxed/simple;
	bh=/ZZCZQr1FMBRyaKelpRmG2XMPewq35kXez+rANFURro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CA78Im/d2vgQqFnpgUUegdUv9xVIVh3m0/y4BgYFbewDSLpCC0OZ6wnsU2pUAVAcB/xH6/QYxF+pdo40+nAU8YY5dmoflxRGjyTQXYfLtpDP2wzH+YeC/+bnD1+4zvuHyBSUlXTodbqhI/8h39yixjD3JR0QqwMltJDRbsNW4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Deos/DxO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Deos/DxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784782530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2vKKJq9p+mRJI1PvhlBj7i1Hep84eZpyfHuN/CbTtk=;
	b=Deos/DxOKm0BRY/c35OrQRqTXmoKfLchi5kczYI8BLCAUZGF/UUimmlBz3GSRV7UpTlZ9q
	3IwtsbUtN81Z+mQgmSRLTGQVKpIW80edact/maTNn2cBLdViPkTBZvo2h73Zn4cMxs+uD3
	1UtG89Y+8Pve5HSxwz4uP5B7Ne/5XUg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-klbCYKTsOI62KJTINKYHXg-1; Thu,
 23 Jul 2026 00:55:26 -0400
X-MC-Unique: klbCYKTsOI62KJTINKYHXg-1
X-Mimecast-MFC-AGG-ID: klbCYKTsOI62KJTINKYHXg_1784782523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C8301955DC2;
	Thu, 23 Jul 2026 04:55:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5329518002AE;
	Thu, 23 Jul 2026 04:55:12 +0000 (UTC)
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
Subject: [PATCH v2 43/44] qapi: convert trivial intro sections for machine.json
Date: Thu, 23 Jul 2026 00:48:04 -0400
Message-ID: <20260723044805.527643-44-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: yE11bG6U9XYCEtPpNtP9aE9mKMQ_xFB7EL8CLtECiQs_1784782523
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

(Trivial)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/machine.json | 261 +++++++++++++++++-----------------------------
 1 file changed, 96 insertions(+), 165 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 9b2248038fc..2b0b9757641 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -15,12 +15,11 @@
 
 ##
 # @SysEmuTarget:
-#
-# The comprehensive enumeration of QEMU system emulation ("softmmu")
-# targets.  Run "./configure --help" in the project root directory,
-# and look for the \*-softmmu targets near the "--target-list" option.
-# The individual target constants are not documented here, for the
-# time being.
+#     The comprehensive enumeration of QEMU system emulation
+#     ("softmmu") targets.  Run "./configure --help" in the project
+#     root directory, and look for the \*-softmmu targets near the
+#     "--target-list" option.  The individual target constants are not
+#     documented here, for the time being.
 #
 # @rx: since 5.0
 #
@@ -46,9 +45,8 @@
 
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
@@ -57,8 +55,7 @@
 
 ##
 # @CpuInfoS390:
-#
-# Additional information about a virtual S390 CPU
+#     Additional information about a virtual S390 CPU
 #
 # @cpu-state: the virtual CPU's state
 #
@@ -75,8 +72,7 @@
 
 ##
 # @CpuInfoFast:
-#
-# Information about a virtual CPU
+#     Information about a virtual CPU
 #
 # @cpu-index: index of the virtual CPU
 #
@@ -105,8 +101,7 @@
 
 ##
 # @query-cpus-fast:
-#
-# Return information about all virtual CPUs.
+#     Return information about all virtual CPUs.
 #
 # Since: 2.12
 #
@@ -143,9 +138,8 @@
 
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
@@ -163,8 +157,7 @@
 
 ##
 # @MachineInfo:
-#
-# Information describing a machine.
+#     Information describing a machine.
 #
 # @name: the name of the machine
 #
@@ -213,8 +206,7 @@
 
 ##
 # @query-machines:
-#
-# Return a list of supported machines
+#     Return a list of supported machines
 #
 # @compat-props: if true, also return compatibility properties.
 #     (default: false) (since 9.1)
@@ -255,8 +247,7 @@
 
 ##
 # @CurrentMachineParams:
-#
-# Information describing the running machine parameters.
+#     Information describing the running machine parameters.
 #
 # @wakeup-suspend-support: true if the machine supports wake up from
 #     suspend
@@ -268,8 +259,7 @@
 
 ##
 # @query-current-machine:
-#
-# Return information on the current virtual machine.
+#     Return information on the current virtual machine.
 #
 # Since: 4.0
 ##
@@ -277,8 +267,8 @@
 
 ##
 # @QemuTargetInfo:
-#
-# Information on the target configuration built into the QEMU binary.
+#     Information on the target configuration built into the QEMU
+#     binary.
 #
 # @arch: the target architecture
 #
@@ -289,8 +279,7 @@
 
 ##
 # @query-target:
-#
-# Return information about the target for this QEMU
+#     Return information about the target for this QEMU
 #
 # Since: 1.2
 ##
@@ -298,8 +287,7 @@
 
 ##
 # @UuidInfo:
-#
-# Guest UUID information (Universally Unique Identifier).
+#     Guest UUID information (Universally Unique Identifier).
 #
 # @UUID: the UUID of the guest
 #
@@ -312,8 +300,7 @@
 
 ##
 # @query-uuid:
-#
-# Query the guest UUID information.
+#     Query the guest UUID information.
 #
 # Since: 0.14
 #
@@ -326,8 +313,7 @@
 
 ##
 # @GuidInfo:
-#
-# GUID information.
+#     GUID information.
 #
 # @guid: the globally unique identifier
 #
@@ -337,8 +323,7 @@
 
 ##
 # @query-vm-generation-id:
-#
-# Show Virtual Machine Generation ID
+#     Show Virtual Machine Generation ID
 #
 # Since: 2.9
 ##
@@ -346,8 +331,7 @@
 
 ##
 # @system_reset:
-#
-# Performs a hard reset of a guest.
+#     Performs a hard reset of a guest.
 #
 # Since: 0.14
 #
@@ -360,8 +344,7 @@
 
 ##
 # @system_powerdown:
-#
-# Requests that a guest perform a powerdown operation.
+#     Requests that a guest perform a powerdown operation.
 #
 # Since: 0.14
 #
@@ -379,11 +362,10 @@
 
 ##
 # @system_wakeup:
-#
-# Wake up guest from suspend.  If the guest has wake-up from suspend
-# support enabled (wakeup-suspend-support flag from
-# `query-current-machine`), wake-up guest from suspend if the guest is
-# in SUSPENDED state.  Return an error otherwise.
+#     Wake up guest from suspend.  If the guest has wake-up from
+#     suspend support enabled (wakeup-suspend-support flag from
+#     `query-current-machine`), wake-up guest from suspend if the
+#     guest is in SUSPENDED state.  Return an error otherwise.
 #
 # Since: 1.1
 #
@@ -399,9 +381,8 @@
 
 ##
 # @LostTickPolicy:
-#
-# Policy for handling lost ticks in timer devices.  Ticks end up
-# getting lost when, for example, the guest is paused.
+#     Policy for handling lost ticks in timer devices.  Ticks end up
+#     getting lost when, for example, the guest is paused.
 #
 # @discard: throw away the missed ticks and continue with future
 #     injection normally.  The guest OS will see the timer jump ahead
@@ -431,10 +412,9 @@
 
 ##
 # @inject-nmi:
-#
-# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
-# all CPUs (ppc64).  The command fails when the guest doesn't support
-# injecting.
+#     Injects a Non-Maskable Interrupt into the default CPU (x86/s390)
+#     or all CPUs (ppc64).  The command fails when the guest doesn't
+#     support injecting.
 #
 # Since: 0.14
 #
@@ -468,8 +448,7 @@
 
 ##
 # @NumaOptions:
-#
-# A discriminated record of NUMA options.  (for OptsVisitor)
+#     A discriminated record of NUMA options.  (for OptsVisitor)
 #
 # @type: NUMA option type
 #
@@ -487,8 +466,7 @@
 
 ##
 # @NumaNodeOptions:
-#
-# Create a guest NUMA node.  (for OptsVisitor)
+#     Create a guest NUMA node.  (for OptsVisitor)
 #
 # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
 #
@@ -520,8 +498,7 @@
 
 ##
 # @NumaDistOptions:
-#
-# Set the distance between 2 NUMA nodes.
+#     Set the distance between 2 NUMA nodes.
 #
 # @src: source NUMA node.
 #
@@ -541,8 +518,7 @@
 
 ##
 # @CXLFixedMemoryWindowOptions:
-#
-# Create a CXL Fixed Memory Window
+#     Create a CXL Fixed Memory Window
 #
 # @size: Size of the Fixed Memory Window in bytes.  Must be a multiple
 #     of 256MiB.
@@ -564,8 +540,7 @@
 
 ##
 # @CXLFMWProperties:
-#
-# List of CXL Fixed Memory Windows.
+#     List of CXL Fixed Memory Windows.
 #
 # @cxl-fmw: List of `CXLFixedMemoryWindowOptions`
 #
@@ -577,8 +552,7 @@
 
 ##
 # @X86CPURegister32:
-#
-# A X86 32-bit register
+#     A X86 32-bit register
 #
 # Since: 1.5
 ##
@@ -587,8 +561,7 @@
 
 ##
 # @X86CPUFeatureWordInfo:
-#
-# Information about a X86 CPU feature word
+#     Information about a X86 CPU feature word
 #
 # @cpuid-input-eax: Input EAX value for CPUID instruction for that
 #     feature word
@@ -610,9 +583,8 @@
 
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
@@ -621,11 +593,10 @@
 
 ##
 # @NumaCpuOptions:
-#
-# Option "-numa cpu" overrides default cpu to node mapping.  It
-# accepts the same set of cpu properties as returned by
-# `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
-# node-id could be used to override default node mapping.
+#     Option "-numa cpu" overrides default cpu to node mapping.  It
+#     accepts the same set of cpu properties as returned by
+#     `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`,
+#     where node-id could be used to override default node mapping.
 #
 # Since: 2.10
 ##
@@ -794,8 +765,7 @@
 
 ##
 # @memsave:
-#
-# Save a portion of guest memory to a file.
+#     Save a portion of guest memory to a file.
 #
 # @val: the virtual address of the guest to start from
 #
@@ -827,8 +797,7 @@
 
 ##
 # @pmemsave:
-#
-# Save a portion of guest physical memory to a file.
+#     Save a portion of guest physical memory to a file.
 #
 # @val: the physical address of the guest to start from
 #
@@ -856,8 +825,7 @@
 
 ##
 # @Memdev:
-#
-# Information about memory backend
+#     Information about memory backend
 #
 # @id: backend's ID if backend has 'id' property (since 2.9)
 #
@@ -897,8 +865,7 @@
 
 ##
 # @query-memdev:
-#
-# Return information for all memory backends.
+#     Return information for all memory backends.
 #
 # Since: 2.1
 #
@@ -1073,9 +1040,9 @@
 
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
@@ -1086,8 +1053,7 @@
 
 ##
 # @balloon:
-#
-# Request the balloon driver to change its balloon size.
+#     Request the balloon driver to change its balloon size.
 #
 # @value: the target logical size of the VM in bytes.  We can deduce
 #     the size of the balloon using this formula:
@@ -1121,8 +1087,7 @@
 
 ##
 # @BalloonInfo:
-#
-# Information about the guest balloon device.
+#     Information about the guest balloon device.
 #
 # @actual: the logical size of the VM in bytes.  Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
@@ -1133,8 +1098,7 @@
 
 ##
 # @query-balloon:
-#
-# Return information about the balloon device.
+#     Return information about the balloon device.
 #
 # Errors:
 #     - If the balloon driver is enabled but not functional because
@@ -1155,10 +1119,9 @@
 
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
@@ -1178,8 +1141,7 @@
 
 ##
 # @HvBalloonInfo:
-#
-# hv-balloon guest-provided memory status information.
+#     hv-balloon guest-provided memory status information.
 #
 # @committed: the amount of memory in use inside the guest plus the
 #     amount of the memory unusable inside the guest (ballooned out,
@@ -1195,9 +1157,8 @@
 
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
@@ -1238,8 +1199,7 @@
 
 ##
 # @MemoryInfo:
-#
-# Actual memory information in bytes.
+#     Actual memory information in bytes.
 #
 # @base-memory: size of "base" memory specified with command line
 #     option -m.
@@ -1272,8 +1232,7 @@
 
 ##
 # @PCDIMMDeviceInfo:
-#
-# PCDIMMDevice state information
+#     PCDIMMDevice state information
 #
 # @id: device's ID
 #
@@ -1308,8 +1267,7 @@
 
 ##
 # @VirtioPMEMDeviceInfo:
-#
-# VirtioPMEM state information
+#     VirtioPMEM state information
 #
 # @id: device's ID
 #
@@ -1331,8 +1289,7 @@
 
 ##
 # @VirtioMEMDeviceInfo:
-#
-# VirtioMEMDevice state information
+#     VirtioMEMDevice state information
 #
 # @id: device's ID
 #
@@ -1366,8 +1323,7 @@
 
 ##
 # @SgxEPCDeviceInfo:
-#
-# Sgx EPC state information
+#     Sgx EPC state information
 #
 # @id: device's ID
 #
@@ -1392,8 +1348,7 @@
 
 ##
 # @HvBalloonDeviceInfo:
-#
-# hv-balloon provided memory state information
+#     hv-balloon provided memory state information
 #
 # @id: device's ID
 #
@@ -1522,8 +1477,7 @@
 
 ##
 # @MemoryDeviceInfo:
-#
-# Union containing information about a memory device
+#     Union containing information about a memory device
 #
 # @type: memory device type
 #
@@ -1544,8 +1498,7 @@
 
 ##
 # @SgxEPC:
-#
-# Sgx EPC cmdline information
+#     Sgx EPC cmdline information
 #
 # @memdev: memory backend linked with device
 #
@@ -1561,8 +1514,7 @@
 
 ##
 # @SgxEPCProperties:
-#
-# SGX properties of machine types.
+#     SGX properties of machine types.
 #
 # @sgx-epc: list of ids of memory-backend-epc objects.
 #
@@ -1574,8 +1526,7 @@
 
 ##
 # @query-memory-devices:
-#
-# Lists available memory devices and their state
+#     Lists available memory devices and their state
 #
 # Since: 2.1
 #
@@ -1598,10 +1549,9 @@
 
 ##
 # @MEMORY_DEVICE_SIZE_CHANGE:
-#
-# Emitted when the size of a memory device changes.  Only emitted for
-# memory devices that can actually change the size (e.g., virtio-mem
-# due to guest action).
+#     Emitted when the size of a memory device changes.  Only emitted
+#     for memory devices that can actually change the size (e.g.,
+#     virtio-mem due to guest action).
 #
 # @id: device's ID
 #
@@ -1625,8 +1575,7 @@
 
 ##
 # @BootConfiguration:
-#
-# Schema for virtual machine boot configuration.
+#     Schema for virtual machine boot configuration.
 #
 # @order: Boot order (a=floppy, c=hard disk, d=CD-ROM, n=network)
 #
@@ -1710,8 +1659,7 @@
 
 ##
 # @x-query-irq:
-#
-# Query interrupt statistics
+#     Query interrupt statistics
 #
 # Features:
 #
@@ -1727,8 +1675,7 @@
 
 ##
 # @x-query-jit:
-#
-# Query TCG compiler statistics
+#     Query TCG compiler statistics
 #
 # Features:
 #
@@ -1745,8 +1692,7 @@
 
 ##
 # @x-query-numa:
-#
-# Query NUMA topology information
+#     Query NUMA topology information
 #
 # Features:
 #
@@ -1762,8 +1708,7 @@
 
 ##
 # @x-query-ramblock:
-#
-# Query system ramblock information
+#     Query system ramblock information
 #
 # Features:
 #
@@ -1779,8 +1724,7 @@
 
 ##
 # @x-query-roms:
-#
-# Query information on the registered ROMS
+#     Query information on the registered ROMS
 #
 # Features:
 #
@@ -1796,8 +1740,7 @@
 
 ##
 # @x-query-usb:
-#
-# Query information on the USB devices
+#     Query information on the USB devices
 #
 # Features:
 #
@@ -1828,8 +1771,7 @@
 
 ##
 # @MemorySizeConfiguration:
-#
-# Schema for memory size configuration.
+#     Schema for memory size configuration.
 #
 # @size: memory size in bytes
 #
@@ -1846,8 +1788,7 @@
 
 ##
 # @dumpdtb:
-#
-# Save the FDT in dtb format.
+#     Save the FDT in dtb format.
 #
 # @filename: name of the dtb file to be created
 #
@@ -1865,8 +1806,7 @@
 
 ##
 # @x-query-interrupt-controllers:
-#
-# Query information on interrupt controller devices
+#     Query information on interrupt controller devices
 #
 # Features:
 #
@@ -1896,8 +1836,7 @@
 
 ##
 # @query-firmware-log:
-#
-# Find firmware memory log buffer in guest memory, return content.
+#     Find firmware memory log buffer in guest memory, return content.
 #
 # @max-size: limit the amount of log data returned.  Up to 1 MiB of
 #     log data is allowed.  In case the amount of log data is larger
@@ -1911,8 +1850,7 @@
 
 ##
 # @dump-skeys:
-#
-# Dump the storage keys for an s390x guest
+#     Dump the storage keys for an s390x guest
 #
 # @filename: the path to the file to dump to
 #
@@ -1950,8 +1888,7 @@
 
 ##
 # @CpuModelExpansionType:
-#
-# An enumeration of CPU model expansion types.
+#     An enumeration of CPU model expansion types.
 #
 # @static: Expand to a static CPU model, a combination of a static
 #     base model name and property delta changes.  As the static base
@@ -1983,9 +1920,8 @@
 
 ##
 # @CpuModelCompareResult:
-#
-# An enumeration of CPU model comparison results.  The result is
-# usually calculated using e.g. CPU features or CPU generations.
+#     An enumeration of CPU model comparison results.  The result is
+#     usually calculated using e.g. CPU features or CPU generations.
 #
 # @incompatible: If model A is incompatible to model B, model A is not
 #     guaranteed to run where model B runs and the other way around.
@@ -2008,8 +1944,7 @@
 
 ##
 # @CpuModelBaselineInfo:
-#
-# The result of a CPU model baseline.
+#     The result of a CPU model baseline.
 #
 # @model: the baselined `CpuModelInfo`.
 #
@@ -2020,8 +1955,7 @@
 
 ##
 # @CpuModelCompareInfo:
-#
-# The result of a CPU model comparison.
+#     The result of a CPU model comparison.
 #
 # @result: The result of the compare operation.
 #
@@ -2152,8 +2086,7 @@
 
 ##
 # @CpuModelExpansionInfo:
-#
-# The result of a cpu model expansion.
+#     The result of a cpu model expansion.
 #
 # @model: the expanded `CpuModelInfo`.
 #
@@ -2222,8 +2155,7 @@
 
 ##
 # @CpuDefinitionInfo:
-#
-# Virtual CPU definition.
+#     Virtual CPU definition.
 #
 # @name: the name of the CPU definition
 #
@@ -2284,8 +2216,7 @@
 
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

