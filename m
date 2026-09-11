Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3B48EC8B
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144824; cv=none; b=Dc2fBer2MV5x+d6cKXcIJWXn+U+segPhfXiTORmUC/pi82+WAvbqmSoUM22ze6gQDsbQaDuD7/NXRalsH1q43OjQZjfjBf0yAtZHY2UoYSYa17ACdwcnedabgfDzPSutErU2z2zLbQsS+/XDJvB/zNJCMpQmaXvPwUSTyf49jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144824; c=relaxed/simple;
	bh=EAQeZe1XEuAWHJARuU6IDW2Xx2TnIuJB2OqRLsbMlaA=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=Et0y2CRVgL7t9IYOWwk/RnuezoZgm7CGgok+mPiWdOjAlrLtKGiCk9TmU2BHPyjOykLkywB0PFLb4tJA0FSo2HLngi5dGVSyBc6gUxRXbcNs/RUKKfkTl3Q0uTVzZlUOWKHSfZIF9a47iinHFJB0uVHCNY+4Pi+0ROxKy5ZY/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U+/cTwzW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+/cTwzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789144822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPypAJmHalIuZO8Qh6uXAHLk6oL+F+SAlk4t9kCAeHs=;
	b=U+/cTwzWb0gh2oC6A9TXsqVcK097SB3/FlXbfp1V3j3XRO8hYSWfLgV904yHpx8UHMe8mM
	fSpDXi+T0yr2gYPjugHFvtPkac301fhuNK32b3tcXcIThLFwgQM3ozzGlW7S+UuXKahkua
	fdRv7wGY3OtGtXKsqZVvdWiLZKGsRTM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-F79_-1BnPfueYsb-lUAPEg-1; Fri,
 11 Sep 2026 12:40:16 -0400
X-MC-Unique: F79_-1BnPfueYsb-lUAPEg-1
X-Mimecast-MFC-AGG-ID: F79_-1BnPfueYsb-lUAPEg_1789144815
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02EAE1954B1C;
	Fri, 11 Sep 2026 16:40:15 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02533300022B;
	Fri, 11 Sep 2026 16:40:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:19 +0400
Subject: [PATCH v5 45/62] include: add QEMU_REPEAT helper macro
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20260911-qom-qapi-v5-45-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC27e1GZ9h+t8HjfLlru0PtcsL2oxGUkDdXLw
 sXsc1WkU92JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuwAKCRDa6OEJdZac
 5SL/D/9Di4Hwl5aWMkxJtvYwk2A0TNhNdL/qDxWUmTEaa0r0EM7lBKICiTEGybKGLZAKxRsGA3i
 DD5G+JKYC2mu2p8LIAuuPQlPiybwo92BxvpW0GfZbRsRiPzu+w1NU0yjSxtlbprBMPXSxor2bhZ
 IgDf0kPbeVZoSU+h3fZx5QOxViLVZylOsWv7hOnMmaqNb2QNdn1WAVA1fsKSScgpi8sZrd4jj0+
 P8fNnsW+vcNDfAbQsWRlH2EUlzLS1C6dRPJOEuv/y0+MwpFtfNiup+QXq91Puq7YkQS/4joRQOi
 50ZY3pimp5+1hXQTBpS7oGNwUt1QEsTUgytvvEpetOVddrezRKwjr6v+QjnBMNeuuoZpkdOpsI/
 2bfAf7VYui0b7oSnP6ELjlvREUn+GXwOTKml/qFOPVDSSbYr+uJPrHGBfDCf4dpG2Oy96n/Et1k
 BBaLK4rmzCPwe+IinPPE5LIRrbyF8sUstGoLJTlcI/Pt59Vho6wY/QuHM/zUGY8VMLS7M+UBxpz
 qTye+RKZ3I7YqSMBV9Wq8leb3KnhpKNpkagD067AZIh/u2aGB2Mk6ViVqIudqluvVPKh9kRxD+C
 2ptqEv+8waQ9gIwUWAguD/z0eEAMjY66UTv7LFTjfHoYJpc9IQX7OfYkIUGAi3MJhCB9pwfGDbA
 aXtgKN7qt0b8N+g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: eUah-cjL2Yu3VjXlaFAccOkeXoOcD4YQks1tSiGvkUg_1789144815
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

