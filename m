Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A508448CE4
	for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787056572; cv=none; b=QQ16P5bObHm+Aq1mQBuuoGVDcfX/ezd2S1I6ptHB1AeQOR8mkdoPlAcbYCps+mmmb+f1I8IOzJ/Sawa+X2IIlzl7RVxpoiduwj3qbyrCrJOes/oTJcnTN1kctKcmpK7+XeZLdrr3g+A7GfgTAlmIipaoirFSrYXxUwvxgVsRdvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787056572; c=relaxed/simple;
	bh=EAQeZe1XEuAWHJARuU6IDW2Xx2TnIuJB2OqRLsbMlaA=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=AqaLwY31YkQ+zxXB0XELO8M7ZSK0K/2v7fUwhO2/7GJjdh2nu11479l24J84nN/V+4+u/sZj8sFBy/6DpzUK7WHvhkAVgPObrvxPHu6aDo1lCdCH+Vy04bt4AsL6TdCfXI6cwwelNN2CjfHttjQ5p47iNhPHIHbxcqaTSuJer8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MObutRhr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MObutRhr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787056568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPypAJmHalIuZO8Qh6uXAHLk6oL+F+SAlk4t9kCAeHs=;
	b=MObutRhr4oUt62aB7XPpALVt58HiVODS0LPPo3KRxFKyJ+yS5LcegNyIp1enJlCitOQzhg
	D6oHoiaZNIuNcGiicIMvRH2TivuMBeYu+1oSp8NXTG3tFKdjEMSsXSB6QcYQUzInUrLRJZ
	EXjsqiWkr6haAGBd+eBuw/0DkYbYJJk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Y_ijdr2nNtC_CScHp-b_tA-1; Tue,
 18 Aug 2026 08:36:02 -0400
X-MC-Unique: Y_ijdr2nNtC_CScHp-b_tA-1
X-Mimecast-MFC-AGG-ID: Y_ijdr2nNtC_CScHp-b_tA_1787056561
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FBBA1800614;
	Tue, 18 Aug 2026 12:35:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C2F91800348;
	Tue, 18 Aug 2026 12:35:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 16:36:35 +0400
Subject: [PATCH v3 56/74] include: add QEMU_REPEAT helper macro
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260818-qom-qapi-v3-56-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 Jonathan Cameron <jic23@kernel.org>, qemu-arm@nongnu.org, 
 linux-cxl@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5015;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EAQeZe1XEuAWHJARuU6IDW2Xx2TnIuJB2OqRLsbMlaA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhFGnIFCFCjBNBLIxXO88uv5+j5DzvPiijQDit
 xHxgw2SJouJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRRpwAKCRDa6OEJdZac
 5TG7EACuj1vgznisdZxviv8gWC681BPf8BdVNMsXxXxIqHqInI7KHkNkZZiD4GTaK97CkHkPJqN
 xrgrwTIN3sVKh9tccIWgYXwwkWYZVUccnmzjqpeVMhRfZ305EeK8WGECendXg+sqBirQAYHbBNy
 rtpTJQDKqSR3z0XVe7WCSqmmQyBRc5a2TM70VA7WZrYQxKlH3ry4BY+7siXXHZmPxELek5gGDlI
 FR1BNsCG4KPMdaxKgufqb0wUTat0NoX+OL7/jtlDL542Z1LN6EGPohqtKrW+pXCO46a+13/XbJr
 SqZC0IUZr8ujWzEpfHVRRZ8q4mi9Alqxo2AgRo+abvmA/JRYKgbK+vVHoEz+lUdlj72SuwbHjHf
 b1eQy4UhGYUjR+b4QKOpTtFCckpFTfOaNQxotlSXyr/RcfuNCJeOB6/SaUGGy3X3p1K+VJaXIL3
 S/mg5CRG5d9SI8MO+66sffHPkZexnfQTsZdWQGusdnkfgX6h87X3Q7aQMse0XSE3fWuq5BHY2QZ
 6hPc7yNkt3tVvFDjaxU/lRzirQRgC/f/lxT4HA5FfA8Of3vnBu5U4Dx4qoaMBXIZUIFyklcc7FU
 3O4HWq18W3viUixS8SbzWD1Zu3rkqooMbk2eT67ruS0oHhFGe4DOHNMunQMwz6MnFxZ9LtZLHYB
 GhwzPiluITXlIzg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: Q3NF69OtDloASHinCm8ywzmzEOV3AR4a7lY52MCvoP0_1787056561
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

