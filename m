Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A35449B30
	for <linux-cxl@vger.kernel.org>; Mon, 20 Jul 2026 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591369; cv=none; b=I0nv0m0FjbHJ7rcmBH+/yRQvt+6rNXSYfFSTR0NKbeiUvb0g655jbKw4ZX5qtmfl6FLs//LOApsg2dJPKdw/kF1MHPTHkqmqTtbPaj+xebPSrWiSVnK8/NqvUtT+aM6GaNOxYu7N5ROvoKvgsIQIftNEKfqrDQjzNpXDzQZUty0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591369; c=relaxed/simple;
	bh=/osqvEwN8lOVhzYMtndFF4UlnWIM9k/2kDRhAjHllX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWnV369q7G5WqnwV4Atfe5gCBdrxWFUTPJ/aKKm9iEfljtv9PmlRzZkBbEDY1+4UCYvFE5AdLUQvQL3oeN6GstuWq8+tDi6k82hvvKR6WZrA8kZPjW3WO2KjSqr3LVDalrzqHWGv8QIN+9DRO1TIecl19gCDhgQUtEVKmmOAlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MPd03N1l; arc=none smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MPd03N1l"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 46A76461B1A;
	Mon, 20 Jul 2026 23:33:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.103.88.67])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EDB5F462DE4;
	Mon, 20 Jul 2026 23:33:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Average: 5cf431fd61ee96b3_1784590389242_2078510123
X-MC-Loop-Signature: 1784590389242:1416080239
X-MC-Ingress-Time: 1784590389242
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.88.67 (trex/8.0.2);
	Mon, 20 Jul 2026 23:33:09 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h3xdw3fGPz1Pv;
	Mon, 20 Jul 2026 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784590388;
	bh=E1eHHKVEeF+gxzLlnh1E3junCmhJURdEk0+x5v55XeA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=MPd03N1ldJdv7Ig8Tvmc8/BTW6kj1rPD6rjQtaYX0N/RLAahQytypmN970wIJXtjV
	 azCMUTgW09ME908a1K4ezHdlo0gaPFY+DrlwnIA/0N5IeqxpfoJHxHCIlDnJAnsRhx
	 5np+C3jasFY/3ii4NmnLmBheOB6sSRSEQ2v14lAtEEeAz9ISMUZZi+K4W9thRXDRKC
	 oDymF1/ekrOY6Guhoece8GfKTQ2gkOG9fV0yGaFv8YoXuE9iZPT1tTIrCwDz+hQDeR
	 bvfrL/3j6I2F3R6H4lJxeXXG6gdkItODO+0VUBAWY7AvElHsSaZSBi4gwGTqwerP5m
	 vdCdokvckHaCg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	mst@redhat.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH v2 4/5] hw/cxl: Add configurable CXL Fixed Memory Window restriction flags
Date: Mon, 20 Jul 2026 16:32:41 -0700
Message-Id: <20260720233242.901544-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720233242.901544-1-dave@stgolabs.net>
References: <20260720233242.901544-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the CFMWS "Window Restrictions" (CXL r4.0 9.18.1.3) as named
per-window machine properties -- device-coherent, host-only, volatile,
persistent, fixed-config and back-invalidate -- so the advertised
restrictions can be configured per window rather than left at the
default.

No changes in default options.  HDM-D and HDM-H are advertised by default;
disabling one (device-coherent=off or host-only=off) narrows the window to
the other.  back-invalidate implies device-coherent (HDM-DB) and suppresses
the host-only default.  host-only coherent combined with back-invalidate is
rejected as undefined behavior per the spec.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 docs/system/devices/cxl.rst | 25 ++++++++++++--------
 hw/acpi/cxl.c               |  2 +-
 hw/cxl/cxl-host.c           | 46 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl.h        | 12 ++++++++++
 qapi/machine.json           | 28 ++++++++++++++++++++++
 5 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 9d0771cdfd73..6bee339cea72 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -384,8 +384,13 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
-An example of 4 type3 devices with volatile memory below a switch. Two of the devices
-use HDM-DB for coherence, which requires operating in Flit mode::
+An example of a mixed configuration across two host bridges, each with its
+own CXL window. Below cxl.1, two type3 volatile devices behind a switch use
+HDM-DB for coherence, which requires operating in Flit mode and a window
+that permits the device-coherent Back-Invalidate model. Below cxl.2, two
+plain host-only devices are directly attached and use the default window.
+Because a window targets a host bridge, giving each coherency model its own
+bridge keeps the window-to-device mapping explicit::
 
   qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
@@ -395,17 +400,17 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -object memory-backend-ram,id=cxl-mem3,share=on,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
-  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
   -device cxl-upstream,bus=root_port0,id=us0,x-256b-flit=on \
   -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
+  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-vmem0,sn=0x1,x-256b-flit=on,hdm-db=on \
   -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
-  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
-  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
-  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
-  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
-  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-vmem1,sn=0x2,x-256b-flit=on,hdm-db=on \
+  -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
+  -device cxl-rp,port=0,bus=cxl.2,id=root_port1,chassis=0,slot=6 \
+  -device cxl-type3,bus=root_port1,volatile-memdev=cxl-mem2,id=cxl-vmem2,sn=0x3 \
+  -device cxl-rp,port=1,bus=cxl.2,id=root_port2,chassis=0,slot=7 \
+  -device cxl-type3,bus=root_port2,volatile-memdev=cxl-mem3,id=cxl-vmem3,sn=0x4 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.back-invalidate=on,cxl-fmw.1.targets.0=cxl.2,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=4k
 
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 75edb2c0a652..77c1db6561b4 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x0f, 2);
+    build_append_int_noprefix(table_data, fw->restrictions, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 7e744312f1d8..c26247dcfa8a 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -61,6 +61,52 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
         fw->enc_int_gran = 0;
     }
 
+    /*
+     * HDM-D and HDM-H are advertised by default; disabling one
+     * (host-only=off or device-coherent=off) narrows the window to the
+     * other.
+     */
+    if (!object->has_device_coherent || object->device_coherent) {
+        fw->restrictions |= CXL_FMW_DEVICE_COHERENT;
+    }
+    if (object->has_host_only ? object->host_only : !object->back_invalidate) {
+        fw->restrictions |= CXL_FMW_HOST_ONLY;
+    }
+    if (object->back_invalidate) {
+        fw->restrictions |= CXL_FMW_DEVICE_COHERENT | CXL_FMW_BI;
+    }
+
+    if (!(fw->restrictions & (CXL_FMW_DEVICE_COHERENT | CXL_FMW_HOST_ONLY))) {
+        error_setg(errp, "CFMW coherency model required");
+        return;
+    }
+
+    if (object->fixed_config) {
+        fw->restrictions |= CXL_FMW_FIXED_CONFIG; /* no-op */
+    }
+
+    /* Volatile and persistent are permitted unless explicitly disabled. */
+    if (!object->has_q_volatile || object->q_volatile) {
+        fw->restrictions |= CXL_FMW_VOLATILE;
+    }
+    if (!object->has_persistent || object->persistent) {
+        fw->restrictions |= CXL_FMW_PERSISTENT;
+    }
+    if (!(fw->restrictions & (CXL_FMW_VOLATILE | CXL_FMW_PERSISTENT))) {
+        error_setg(errp, "CFMW volatile and/or persistent memory required");
+        return;
+    }
+
+    /*
+     * Reject the undefined and conflicting coherency combinations,
+     * per CXL r4.0 9.18.1.3.
+     */
+    if ((fw->restrictions & CXL_FMW_HOST_ONLY) &&
+        (fw->restrictions & CXL_FMW_BI)) {
+        error_setg(errp, "CFMW host-only coherency + BI is undefined behavior");
+        return;
+    }
+
     fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
     for (i = 0, target = object->targets; target; i++, target = target->next) {
         /* This link cannot be resolved yet, so stash the name for now */
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index d8cd8359d2ec..7cf3dc622c07 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -27,6 +27,17 @@
 
 typedef struct PXBCXLDev PXBCXLDev;
 
+/*
+ * CEDT CFMWS "Window Restrictions" bits (CXL r4.0 9.18.1.3), advertising
+ * which capabilities the host bridges below this window support.
+ */
+#define CXL_FMW_DEVICE_COHERENT (1 << 0) /* HDM-D */
+#define CXL_FMW_HOST_ONLY       (1 << 1) /* HDM-H */
+#define CXL_FMW_VOLATILE        (1 << 2)
+#define CXL_FMW_PERSISTENT      (1 << 3)
+#define CXL_FMW_FIXED_CONFIG    (1 << 4)
+#define CXL_FMW_BI              (1 << 5) /* HDM-DB, Back-Invalidate */
+
 typedef struct CXLFixedWindow {
     SysBusDevice parent_obj;
     int index;
@@ -36,6 +47,7 @@ typedef struct CXLFixedWindow {
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
+    uint16_t restrictions;
     /* Todo: XOR based interleaving */
     MemoryRegion mr;
     hwaddr base;
diff --git a/qapi/machine.json b/qapi/machine.json
index 9b2248038fcb..7f6ffa82a551 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -551,15 +551,43 @@
 #     accesses will go to a given interleave target.  Accepted values
 #     [256, 512, 1k, 2k, 4k, 8k, 16k]
 #
+# @device-coherent: Window permits device-coherent (minimally HDM-D)
+#     accesses.  (since 11.1)
+#
+# @host-only: Window permits host-only coherent (HDM-H) accesses.
+#     (since 11.1)
+#
+# @volatile: Window permits volatile memory.  (since 11.1)
+#
+# @persistent: Window permits persistent memory.  (since 11.1)
+#
+# @fixed-config: Window has a fixed device configuration.  Advertised
+#     in the CEDT only; not otherwise emulated.  (since 11.1)
+#
+# @back-invalidate: Window permits Back-Invalidate (HDM-DB).  Implies
+#     @device-coherent.  (since 11.1)
+#
 # @targets: Target root bridge IDs from -device ...,id=<ID> for each
 #     root bridge.
 #
+# Coherency defaults to both device-coherent and host-only; disabling
+# one (host-only=off or device-coherent=off) narrows to the other.
+# @back-invalidate implies device-coherent and is not host-only.
+# @volatile and @persistent default on.  host-only coherent combined
+# with @back-invalidate is rejected as undefined behavior.
+#
 # Since: 7.1
 ##
 { 'struct': 'CXLFixedMemoryWindowOptions',
   'data': {
       'size': 'size',
       '*interleave-granularity': 'size',
+      '*device-coherent': 'bool',
+      '*host-only': 'bool',
+      '*volatile': 'bool',
+      '*persistent': 'bool',
+      '*fixed-config': 'bool',
+      '*back-invalidate': 'bool',
       'targets': ['str'] }}
 
 ##
-- 
2.39.5

