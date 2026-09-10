Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792713B993A
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789071202; cv=none; b=m9uRdGcE4ch1q2UziK0NAR+Q9WBV7/2t3Wt5vJDZDFnMHKIeb5UQ2EFeTzisNctLPiu6ibaaqqWRfsyut7xoM5bdL90T3KU1zBOPXJX+4+V5yNlIG/HaUA67MQrMYwgEUf6Fwj6aVamWSE9cZt8X0qCWiuGeJ+sJEScAAeQBb3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789071202; c=relaxed/simple;
	bh=hDeL/D4NQJMPMyXq1MCV4yYqrbR0C+glVtoJRW/Swzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jBpJ2NtVPG9lERd/BW+4hcsxr4t84hRBx4H7uQ+Yc8A5/S+WKkYOLJ3J66HEQzZ/8AsYeSDKoxaDNOcHHiB9nWH9icAXW5RACkvVG7zY6w402ttpz39b2sa7bfdZUIHISZMQR0SEIi5+WTCKME9JsDH/3gTH0jLwyAEcqlBKkVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDFnU5+9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDFnU5+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789071197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX21n48672hBN8Zfk6zuZxrqxEgRNXLThdAmJPdhE1E=;
	b=aDFnU5+9z4Yh0iaw0+1JyatwelPYMJTiiq+YNvywoM3ADqU+e9CXr4gQ3fzj36eIBWy6cl
	9Bmom4qNnOKTw7sUmpX0ZI9IgmUq5PCrcIC3Yv8/DSwNINSWS0rQu00QP2v/gOFCsCybL8
	AHwhASIfslwNS5hA9DLBFP2MpyP/RxI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-wmb9fhiiNK2inVfzrhwz4w-1; Thu, 10 Sep 2026 16:13:15 -0400
X-MC-Unique: wmb9fhiiNK2inVfzrhwz4w-1
X-Mimecast-MFC-AGG-ID: wmb9fhiiNK2inVfzrhwz4w_1789071194
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so96122f8f.2
        for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 13:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789071194; x=1789675994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bX21n48672hBN8Zfk6zuZxrqxEgRNXLThdAmJPdhE1E=;
        b=MZEPX/YV0kyD7JjmweummaMlsvau4dGrmBpEhLYaxkasvJBaTjUX0gVp7mFnEoK5Qe
         M5HrHO0GdWYSJN+vLRz4Ar/lpFu856l1vQTZuWduEi2FKyPEqoA1WzCP6v9mWfJo9FMD
         kokc5DmYmZf/MBRrxSAoNhpt8pFN2L3sqiJ9cy8A88rOM1NXJq50QQ+WXYtaoDY3iA+S
         s+Gkj94AydwcUIiq5YJSOHiPGEHTi9WdNvZpLI/VcKnoT0d/VnZVDdWsIJOtTru0lDo2
         HCKB9aLP/7zfAtmCY3PP1C+BDe9quZj7yDtH4QuQsyFGUz7jtBOObf/GpQhKvNnce2vi
         or6Q==
X-Forwarded-Encrypted: i=1; AKwUvBx/HyJ35tgeK0OguQ0w4SErj4f3Iia66dxOGBWjrr+sQ2lAjLvpNUDCXxXdXPGN3XPg++kTuXB1VTE=@vger.kernel.org
X-Gm-Message-State: AFuF++m+n29K6rx/151Mct2j1giWGEVyeUH63yb++26wBnEo7RjDBlrA
	RbE4xisUllZ9a4kgYCMiJtL/qtEpW+vJz9ARxxomUK5wqVJxogkDaK+rdFI7A+3Jps8xow2xBOE
	vYetSiPNWqrlu0ntG6MtHiQpL/SKEDyQOlyyz2VZSQuU5Z6GaTKu9IU3Bo6dvhA==
X-Gm-Gg: AYBFou3TIMuWPa/1E3TsxQm2PMM85NXVZDOs9ZgXWfdp/8LXg/QnIcUIWKZVDUIfuWK
	TYi3S+tEwLCkGFc3c9u2LPp98QEao7HJljAdXWfKu0avNp+G0kScUmjbRPzbgZWKGnjPJIrThjH
	DcVAdPffFM2mfTfANjk1Ony8SaKH/eSg9FHTks9t+8VckuNUHOlNJvZEXlZJhuC9Utq5/auZ4d3
	vvuEZcxWkylIRVpu1VdJUFSWicIJ0Upy9RXrvgSl9pFE6Y+yuL9XwyRQ9BF5T+PIZwlOdA6gicH
	ZEeoqbjgf3defU+e5lMlZqXIfcjrM19cD7aV5q3el03OwZyV7PCFCUjzfPNrhvxgYSpsQQ4fr2u
	LOchsYrsBkOMxxzMbSE8n3HM=
X-Received: by 2002:adf:f30b:0:b0:485:8c16:a33d with SMTP id ffacd0b85a97d-486eb34a466mr436138f8f.50.1789071194061;
        Thu, 10 Sep 2026 13:13:14 -0700 (PDT)
X-Received: by 2002:adf:f30b:0:b0:485:8c16:a33d with SMTP id ffacd0b85a97d-486eb34a466mr436106f8f.50.1789071193517;
        Thu, 10 Sep 2026 13:13:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea60sm779458f8f.17.2026.09.10.13.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:13:13 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:10 -0400
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
Subject: [PULL 42/90] hw/cxl: Add configurable CXL Fixed Memory Window
 restriction flags
Message-ID: <1eace36d009bae786bb89399055b55de932b2ac8.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hXO3RfieU2053l_Dckeod9AaHQNtPpZBkDBF8hddLxA_1789071194
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

