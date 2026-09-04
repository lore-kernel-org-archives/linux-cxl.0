Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1E51123E
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788552113; cv=none; b=b3CSHcgH8z4rLCPOX6BjkSqOT+8yKze3rPKAWmvF4T21Ue/UIqkITOkyieIyCvszWhLz6Rrnzurbgfg2Zzb97//dPRroGwYzNwQR3TbbC5i9jfo7p8LSj23BAjj6D+GhS3gGiyDcz52d1SG6yz3Z7n5KgjNnbF+ReCIMW1g1Yig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788552113; c=relaxed/simple;
	bh=EAQeZe1XEuAWHJARuU6IDW2Xx2TnIuJB2OqRLsbMlaA=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=ktzLpwgAGEkJdEuYeML1zsDc+kLXZOuJMduR/7uZQHXtcMFqYsuWzi1BEqFhAIPvCnzsfV5isL+pRUhYK8ysIaov4KtqiKQt6f6Rdi5hEgJvk1JUMDfYILduHtkbexzs8qzVHr/AGWKHMtj9bWhBRavFU8l2GdOcMRAiFyk2jCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9CaR0nH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9CaR0nH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788552106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPypAJmHalIuZO8Qh6uXAHLk6oL+F+SAlk4t9kCAeHs=;
	b=S9CaR0nHgfEgGP+CNFg6InTk3GlSXSToOEecI8DriusVLpWktQNkB/RAJTBKN9WeNT5TCL
	isK+A/Xjyjp44nOs94z8KtmLo6ZVBjG6/b7kSu9wDp3eMOcVsUpxnzSL3Fnk6eSJb/ha9T
	Ass0PxwYtN/nzY22SupwFq3be/gtABQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-6aozs-zTPCGR6zY2a3Tb7g-1; Fri,
 04 Sep 2026 16:01:43 -0400
X-MC-Unique: 6aozs-zTPCGR6zY2a3Tb7g-1
X-Mimecast-MFC-AGG-ID: 6aozs-zTPCGR6zY2a3Tb7g_1788552102
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9DEC19091F0;
	Fri,  4 Sep 2026 20:01:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD70A1800641;
	Fri,  4 Sep 2026 20:01:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:40 +0400
Subject: [PATCH v4 57/75] include: add QEMU_REPEAT helper macro
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260904-qom-qapi-v4-57-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 Jonathan Cameron <jic23@kernel.org>, qemu-arm@nongnu.org, 
 linux-cxl@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5015;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EAQeZe1XEuAWHJARuU6IDW2Xx2TnIuJB2OqRLsbMlaA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLLs3TFoQc+S1P2SjUmG3epX/4GVf+GJ/nCx
 bEz2OFB3rSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiywAKCRDa6OEJdZac
 5QPoD/wIH+SUgoKMu9UwFjY+P5SjH3odo7pduJLtODqpTRBA9HshfbdMjjms/WXXmESeCqOuZJp
 VqHnRmXFFPoSdyxv2roiuAXGt95QCnNvXTsS6na8Al6RAcSjmjoS2gAq2sKyqkUizrJKEL9ivxo
 RAeeao/r0RTYe1hgu6KC5GlKOdYsvUCq5FuEhg1FKfQxGX2tnMDwAtsDZDnBQx31GPWQjKDAWvj
 I3bUJdS1MSf0mswUj7+ANUQhaJNjLH4DYvOW1U6f/dl4UXPpjDg8j55HGiBjEpVGXZKXJilKG/F
 MqsxoeYcmm7longgtjntTB/7GeYItquBerqVVHfDNtoBcBN/++nWa+sN8yiNAQR88sSjLqi4Hsc
 5w4XO0FYnX7r7Koo85OeTDt1vEU4AkGQZrkGqBEHdZQ3LCWChOQKlFRRcTkDV3NA5LfIhrXWeDE
 zX1R5ufU2oQDU9QgoejcSdteWr9JR5YjxEw2auq5pAZuTZ7k0o6i5LRpZyXRZkW6i2Zp5KaN8qW
 DumpUxldYGVJeh9oWtGqsiWjBg2Fbu49f1iht0Wq0kLmLRQR0STIhN9GXZjE3jXH/t2XnInB7jp
 +0jPJeBhIOY0ELAEWgoXjEH8xmX19sK8eOs9xCS1wGkwhJstPGLaxAzhnA8trbFAgGX6MPKF152
 dTXf6oLZBHzSzNA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: Eg6_a53E8TtueXq1d6r4gn3QZULKNLxM15o2Kjq0FEg_1788552102
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Introduce a macro used in following commit, and convert a few existing
candidates. Inspired by a similar macro in Linux kernel/trace/bpf_trace.c

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/misc/tz-ppc.c               | 19 ++-----------------
 hw/remote/vfio-user-obj.c      | 17 +++--------------
 include/hw/cxl/cxl_component.h |  5 +----
 include/qemu/osdep.h           | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 6f820430eed8..5f09ce164c19 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -303,26 +303,11 @@ static const VMStateDescription tz_ppc_vmstate = {
 
 #define DEFINE_PORT(N)                                          \
     DEFINE_PROP_LINK("port[" #N "]", TZPPC, port[N].downstream, \
-                     TYPE_MEMORY_REGION, MemoryRegion *)
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 
 static const Property tz_ppc_properties[] = {
     DEFINE_PROP_UINT32("NONSEC_MASK", TZPPC, nonsec_mask, 0),
-    DEFINE_PORT(0),
-    DEFINE_PORT(1),
-    DEFINE_PORT(2),
-    DEFINE_PORT(3),
-    DEFINE_PORT(4),
-    DEFINE_PORT(5),
-    DEFINE_PORT(6),
-    DEFINE_PORT(7),
-    DEFINE_PORT(8),
-    DEFINE_PORT(9),
-    DEFINE_PORT(10),
-    DEFINE_PORT(11),
-    DEFINE_PORT(12),
-    DEFINE_PORT(13),
-    DEFINE_PORT(14),
-    DEFINE_PORT(15),
+    QEMU_REPEAT(TZ_NUM_PORTS, DEFINE_PORT)
 };
 
 static void tz_ppc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 7e6819f670b5..84c3ff05cfb8 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -496,22 +496,11 @@ static size_t vfu_object_bar_rw(PCIDevice *pci_dev, int pci_bar,
                                  buf, count, is_write);                        \
     }                                                                          \
 
-VFU_OBJECT_BAR_HANDLER(0)
-VFU_OBJECT_BAR_HANDLER(1)
-VFU_OBJECT_BAR_HANDLER(2)
-VFU_OBJECT_BAR_HANDLER(3)
-VFU_OBJECT_BAR_HANDLER(4)
-VFU_OBJECT_BAR_HANDLER(5)
-VFU_OBJECT_BAR_HANDLER(6)
+QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER)
 
+#define VFU_OBJECT_BAR_HANDLER_PTR(BAR_NO) vfu_object_bar##BAR_NO##_handler,
 static vfu_region_access_cb_t *vfu_object_bar_handlers[PCI_NUM_REGIONS] = {
-    &vfu_object_bar0_handler,
-    &vfu_object_bar1_handler,
-    &vfu_object_bar2_handler,
-    &vfu_object_bar3_handler,
-    &vfu_object_bar4_handler,
-    &vfu_object_bar5_handler,
-    &vfu_object_bar6_handler,
+    QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER_PTR)
 };
 
 /**
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ffc82202206c..fca8b7055ccd 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -186,10 +186,7 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
 /* Support 4 decoders at all levels of topology */
 #define CXL_HDM_DECODER_COUNT 4
 
-HDM_DECODER_INIT(0);
-HDM_DECODER_INIT(1);
-HDM_DECODER_INIT(2);
-HDM_DECODER_INIT(3);
+QEMU_REPEAT(CXL_HDM_DECODER_COUNT, HDM_DECODER_INIT)
 
 /*
  * CXL r3.1 Section 8.2.4.21: CXL Extended Security Capability Structure
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230be..a5e7ff99cb89 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -191,6 +191,39 @@ extern "C" {
 
 #include "qemu/typedefs.h"
 
+/*
+ * QEMU_REPEAT(n, m) - invoke m(0) m(1) ... m(n-1)
+ *
+ * Expands to n invocations of m, each with a literal integer argument.
+ * n must be a compile-time constant in 0..16.
+ *
+ * Example - generate 4 per-index function definitions:
+ *
+ *   #define DEFINE_GETTER(i) \
+ *   static int get_##i(void) { return values[i]; }
+ *
+ *   QEMU_REPEAT(4, DEFINE_GETTER)
+ */
+#define QEMU_REPEAT_0(m)
+#define QEMU_REPEAT_1(m)   QEMU_REPEAT_0(m)   m(0)
+#define QEMU_REPEAT_2(m)   QEMU_REPEAT_1(m)   m(1)
+#define QEMU_REPEAT_3(m)   QEMU_REPEAT_2(m)   m(2)
+#define QEMU_REPEAT_4(m)   QEMU_REPEAT_3(m)   m(3)
+#define QEMU_REPEAT_5(m)   QEMU_REPEAT_4(m)   m(4)
+#define QEMU_REPEAT_6(m)   QEMU_REPEAT_5(m)   m(5)
+#define QEMU_REPEAT_7(m)   QEMU_REPEAT_6(m)   m(6)
+#define QEMU_REPEAT_8(m)   QEMU_REPEAT_7(m)   m(7)
+#define QEMU_REPEAT_9(m)   QEMU_REPEAT_8(m)   m(8)
+#define QEMU_REPEAT_10(m)  QEMU_REPEAT_9(m)   m(9)
+#define QEMU_REPEAT_11(m)  QEMU_REPEAT_10(m)  m(10)
+#define QEMU_REPEAT_12(m)  QEMU_REPEAT_11(m)  m(11)
+#define QEMU_REPEAT_13(m)  QEMU_REPEAT_12(m)  m(12)
+#define QEMU_REPEAT_14(m)  QEMU_REPEAT_13(m)  m(13)
+#define QEMU_REPEAT_15(m)  QEMU_REPEAT_14(m)  m(14)
+#define QEMU_REPEAT_16(m)  QEMU_REPEAT_15(m)  m(15)
+#define QEMU_REPEAT_(n, m) QEMU_REPEAT_##n(m)
+#define QEMU_REPEAT(n, m)  QEMU_REPEAT_(n, m)
+
 /**
  * Mark a function that executes in coroutine context
  *

-- 
2.55.0.543.g5ebe2ebe4ea8

