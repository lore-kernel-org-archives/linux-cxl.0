Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD822E7377
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442755; cv=none; b=uxj4EJCdm02T9MENPZ3owpGGV+nCsALU+Y45TO1lr+9N1U0ddGtSLUm1utjGxELm1BYMV+Q6DnyYthodGI6JknzW5TeZYbVE3JvGgAZX1J5lr2Gggj7g0ZIUtw1Gn00BfFC+CqyybOAI2X7D6CdJL+w1VeWLz+o/brvZPqsivIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442755; c=relaxed/simple;
	bh=l2Bof8rxVOI/LITdWCwF6ycDYFf2O9yJJ53TsV0JSJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0m8yruW96C4CyJW6H2200BBLS5aJeHI5CwoR6AATkrRGuVSKBGezG//ET6DAwU2SWxRh3ndntYQOVQkO4EgKyIAWm1KO0TBgLekm+cIPK7r1A3oCIMqjLnM8XXzBRzYwUojzUHz5zTOI2Xb8VvTbvkStOmHKifORQf8l/gyPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=jB9pMMdH; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="jB9pMMdH"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1FE50460E21;
	Tue, 02 Jun 2026 23:18:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-101-154-94.trex-nlb.outbound.svc.cluster.local [100.101.154.94])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C4BB94629C4;
	Tue, 02 Jun 2026 23:18:52 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tart-Occur: 7771d85103379b86_1780442333042_3697789684
X-MC-Loop-Signature: 1780442333042:694014145
X-MC-Ingress-Time: 1780442333042
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.154.94 (trex/7.1.5);
	Tue, 02 Jun 2026 23:18:53 +0000
Received: from localhost.localdomain (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gVRbb3C4Dz107p;
	Tue,  2 Jun 2026 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780442332;
	bh=brLZIX1KDosdIr4n25K+Re2pc2kLmvxA2oySiv1HIo0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=jB9pMMdHrKTNeKp+LHNqemcPorD39bJzByHewKZ/tQGRdSXHtrZgb9H6w45aQTL/i
	 roPpog9jZppdGZfm1Q/u5j2J6r6W0YVoYgwjfiIbSGoMMchX4+iaYJsPB13CdAHPtN
	 hg1xDXZ+JYn2wG6Mq/A7c0fP81gLE+DGM49ubFkE5R5m+3RBIFUKhJQBcurY3betrE
	 u2pjOVGMJCUEdOjr3wo4kQHm/iA5AsyDU995xN9bv9/j1bEv2RI+HXVc481nDsH3hL
	 mwbIz2YA6I09hUopP+Fi0PSSsdbaZmjh20wnD/LXcOswvHcq1kxjAg6T25HbJWvRiF
	 sDTEoza9WDYFQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org,
	dave@stgolabs.net
Subject: [PATCH 4/4] hw/cxl: Add per-capability CXL Fixed Memory Window restriction flags
Date: Tue,  2 Jun 2026 16:18:06 -0700
Message-Id: <20260602231806.2469011-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260602231806.2469011-1-dave@stgolabs.net>
References: <20260602231806.2469011-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the CFMWS Window Restrictions as named per-capability machine
properties (device-coherent, host-only, volatile, persistent,
fixed-config, back-invalidate), making the advertised restrictions
configurable per window.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 docs/system/devices/cxl.rst | 13 +++------
 hw/acpi/cxl.c               |  2 +-
 hw/cxl/cxl-host.c           | 55 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl.h        | 12 ++++++++
 qapi/machine.json           | 29 +++++++++++++++++++
 5 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 9d0771cdfd73..cf3f2c81785c 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -384,15 +384,14 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
-An example of 4 type3 devices with volatile memory below a switch. Two of the devices
-use HDM-DB for coherence, which requires operating in Flit mode::
+An example of 2 type3 devices with volatile memory below a switch. The devices
+use HDM-DB for coherence, which requires operating in Flit mode and a CXL window
+configured to permit device-coherent Back-Invalidate model::
 
   qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
   ...
   -object memory-backend-ram,id=cxl-mem0,share=on,size=256M \
   -object memory-backend-ram,id=cxl-mem1,share=on,size=256M \
-  -object memory-backend-ram,id=cxl-mem2,share=on,size=256M \
-  -object memory-backend-ram,id=cxl-mem3,share=on,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
   -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
@@ -401,11 +400,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
   -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,x-256b-flit=on,hdm-db=on \
   -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
   -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,x-256b-flit=on,hdm-db=on \
-  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
-  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
-  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
-  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
-  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.back-invalidate=on
 
 A simple arm/virt example featuring a single direct connected CXL Type 3
 Volatile Memory device::
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 5ce5e8e083ba..77c1db6561b4 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0xe, 2);
+    build_append_int_noprefix(table_data, fw->restrictions, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f3479b19914f..7af431bf1555 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -61,6 +61,61 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
         fw->enc_int_gran = 0;
     }
 
+    if (object->device_coherent) {
+        fw->restrictions |= CXL_FMW_DEVICE_COHERENT;
+    }
+    if (object->back_invalidate) {
+        if (object->has_device_coherent && !object->device_coherent) {
+            error_setg(errp, "CFMW BI requires device-coherent");
+            return;
+        }
+        fw->restrictions |= CXL_FMW_DEVICE_COHERENT | CXL_FMW_BI;
+    }
+    if (object->host_only) {
+        fw->restrictions |= CXL_FMW_HOST_ONLY;
+    } else if (!object->has_host_only &&
+               !(fw->restrictions & CXL_FMW_DEVICE_COHERENT)) {
+        /* host-only coherent is the default when no model is requested. */
+        fw->restrictions |= CXL_FMW_HOST_ONLY;
+    }
+
+    if (!(fw->restrictions & (CXL_FMW_DEVICE_COHERENT | CXL_FMW_HOST_ONLY))) {
+        error_setg(errp, "CFMW coherency model required");
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
+    if ((fw->restrictions & CXL_FMW_DEVICE_COHERENT) &&
+        (fw->restrictions & CXL_FMW_HOST_ONLY)) {
+        error_setg(errp,
+                   "CFMW device and host-only coherency are mutually exclusive");
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
     fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
     for (i = 0, target = object->targets; target; i++, target = target->next) {
         /* This link cannot be resolved yet, so stash the name for now */
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 998f495a9847..187d5466528c 100644
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
index 685e4e29b87d..a5be531403a1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -551,15 +551,44 @@
 #     accesses will go to a given interleave target.  Accepted values
 #     [256, 512, 1k, 2k, 4k, 8k, 16k]
 #
+# @device-coherent: Window permits device-coherent (minimally HDM-D)
+#     accesses.  (since 11.0)
+#
+# @host-only: Window permits host-only coherent (HDM-H) accesses.
+#     (since 11.0)
+#
+# @volatile: Window permits volatile memory.  (since 11.0)
+#
+# @persistent: Window permits persistent memory.  (since 11.0)
+#
+# @fixed-config: Window has a fixed device configuration.  Advertised
+#     in the CEDT only; not otherwise emulated.  (since 11.0)
+#
+# @back-invalidate: Window permits Back-Invalidate (HDM-DB).  Implies
+#     @device-coherent.  (since 11.0)
+#
 # @targets: Target root bridge IDs from -device ...,id=<ID> for each
 #     root bridge.
 #
+# Coherency defaults to host-only coherent; request a device model
+# with @device-coherent or @back-invalidate instead.  @volatile and
+# @persistent are permitted unless set to false, and at least one is
+# required.  Clearing @host-only with no device model is rejected, as
+# are host-only coherent + back-invalidate and device-coherent +
+# host-only coherent.
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

