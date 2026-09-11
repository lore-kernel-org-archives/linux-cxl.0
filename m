Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9346A607
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117352; cv=none; b=usKev1yaW0GNjZ2lkTqhtry/R5EwKaKLxr734vmEuReARJSqdmAGweNkr9EwBizzhtO+P8NkXWkf/AgytyzO5h9KLMvH+drjmnQaPQk2kW33UcvgL6AtYmt81AgK9d42AJ81hIrtOeidcXU7ihLUx3W09J52Elow6kSQ2DCYMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117352; c=relaxed/simple;
	bh=hDeL/D4NQJMPMyXq1MCV4yYqrbR0C+glVtoJRW/Swzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OMxOoQa2HuWpk630l8BlT8Mvzcqp6+12FrU/qDOO3QQq6Ca2wdTBeJYJFBD5niq7WwXK7ei9WnalrlPQnbCks7QtJWAenLgmsANQ5EVxC6PWAZtdiUOvE0C2Aa3fNtpWDBsf02FBAxXVxi5SJdm5+NDvNWyP0avZogzuSERLB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVLsuTIM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVLsuTIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789117350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX21n48672hBN8Zfk6zuZxrqxEgRNXLThdAmJPdhE1E=;
	b=AVLsuTIMfPU08YABYFyGGaOxUS0JB1aq5tnaQAB4o5EepH12bnZmLpvehsJS9S8MqyjM/v
	uBh9e5AxBXfi9N3FlEX6+vxdkCN7kyy3FEDhHA3MPQ78Gu/qCQ8U87wkIpcLs5uubLV0R2
	xTC3y+IvJrr6YpQ5bnj1UyoMGTp/kr0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-68pQhzfENzyihlzmr8VIVQ-1; Fri, 11 Sep 2026 05:02:28 -0400
X-MC-Unique: 68pQhzfENzyihlzmr8VIVQ-1
X-Mimecast-MFC-AGG-ID: 68pQhzfENzyihlzmr8VIVQ_1789117348
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so4915005e9.2
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 02:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117347; x=1789722147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bX21n48672hBN8Zfk6zuZxrqxEgRNXLThdAmJPdhE1E=;
        b=YsYUJnFoAJ0SdbTAV6VxwoAtbRzyHK7cVnygq9smEzF5kZyW7dlxZhDGmyYfpZtQJh
         +/bkBkbR9n8SbfApDiMruGbuD49CcfsNxx9rqouk1CPF5tVMMAdR/XU/A7I1CEvBzi3P
         nFAoXUBvofBmeHzpmicujD9B7MD9/MCYsFXBMwagb99UPi34jhGkRJ2FbgJIHQtFE67E
         D7/OmIGFUKUaEGSpsN1kV45FFjNgkxwTD8HuE3rTGUrkiaJZiQKgbV0+h/IKdv/dUBoR
         l0M64jVg/4f6qVotRNJyjSBYVfBvcZpz/Z2wy0M57ebRXAMSAi6agYRSwUcDh7mfSsNc
         aWKw==
X-Forwarded-Encrypted: i=1; AKwUvBwN71Gf2cuYd+tbytzayMr8xho4YULGhz55zDJoBMMsu7NUgQwmz5YwRYHPOPgp7t3ynUMLk7nhHks=@vger.kernel.org
X-Gm-Message-State: AFuF++l0eOJjvR4DA/2DClsYeayIGe15R7ch5WPoYV1uvTYhMkqFloWQ
	3mhGz3mXmmqeaVlK7+b24PLV/duEehqKd4SrQGFiQb2priH6ffNziR2wfXZ07T14djJ3ZHpWlQY
	k0la89Toq2jnxpkg8ZzvVt8BCoQXQGo2HjguC/hiKCu+wLUNXTKYIPxrG3IRCNg==
X-Gm-Gg: AYBFou3i+mbzoQS0o2T6DQvSc0/Qd9bU7G15nJntYGE3hNlyb4utK9Sl9rJhzPu9DcN
	NFRz9EG2HkpunwaZyT2gPZPtc754IpIkUqA4LY5I83PD+0tLXb8LVz68SUR1N3v4lKPfSo8Tbkm
	OGdPYbZAVn/OjFSuSIINXKDvJILLQzTTVJ9qc2nXaR+g2vj/t2rkWKnuHxq3tdqSZpfCPCwD+Dm
	8agOH+0Icc+myI0tD8CJQ4w0NnSMSH3c0Haa+HW1Cy4Fl9Fsw4HOLnTpjiz0tNOZAd8eQBfur51
	lyhHbXa3gw0kXa2JMrk3X4H7mzFO+crJp0EXHdsKsmno3CGRljLYbaSFexvXY04D2eimKcsDgPd
	RafsGMKScUL2l/Cx6YfWoMgs=
X-Received: by 2002:a05:600c:34ca:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49e619a09d3mr34868885e9.15.1789117347337;
        Fri, 11 Sep 2026 02:02:27 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49e619a09d3mr34868105e9.15.1789117346439;
        Fri, 11 Sep 2026 02:02:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaee4sm85633975e9.14.2026.09.11.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:02:25 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>, Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>, linux-cxl@vger.kernel.org
Subject: [PULL v2 28/75] hw/cxl: Add configurable CXL Fixed Memory Window
 restriction flags
Message-ID: <f3ad29422fcf0c89d94814a1aba1d66abf7b74d9.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tiMvhKxbTxGBYjTrvznfrWcNDx-NVkQHgwMdfscUOYk_1789117348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Davidlohr Bueso <dave@stgolabs.net>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260720233242.901544-5-dave@stgolabs.net>
---
 docs/system/devices/cxl.rst | 25 ++++++++++++--------
 qapi/machine.json           | 28 ++++++++++++++++++++++
 include/hw/cxl/cxl.h        | 12 ++++++++++
 hw/acpi/cxl.c               |  2 +-
 hw/cxl/cxl-host.c           | 46 +++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 11 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 9d0771cdfd..6bee339cea 100644
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
diff --git a/qapi/machine.json b/qapi/machine.json
index 2d63c1bac3..de6460f091 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -552,15 +552,43 @@
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
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index d8cd8359d2..7cf3dc622c 100644
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
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 75edb2c0a6..77c1db6561 100644
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
index 369a985f9b..e279ce5fe3 100644
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
-- 
MST

