Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493450;
	b=0wjSbgrifNKRm4cUf+91AORQ1pST/RCEQ75YN7TuyzRCfs9RGfGHuBxJ5aSOxhJeIfA7
	 cj52FMjNR6AL7pFHbEKe7kCzoBWWLDR+cGwp0YLV0QWfJB0RBZpNqEyly1W6krywDB1Cn
	 c8XFX8HQayEikW/csIgC6aXE5XRxY0Lp1b3uJCoGqXzzHrrETtG22M1CJBAnX/XmJUMMk
	 cHaNuRMPmkhABUiO3ajpydVe5iok4zhmPLGY9qPoNAPHHYvXY42NFLhLP0JPTTQiZEuXU
	 kYUsUct+TwAenbHnT9/k3HwbdYMiIAzSw1xIRJwKrs25IBXu/4J17+yLbd02kQ47puQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493450;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=S8kTexksySb92RkWPQob17KtLeYJq8y0yNIndqLcc+s=;
	b=wFFG/GX4eEpKl0CYUG3+CncBfP0qaIXhgII3XTCveWq/2b9Ue2j/iiDVA9sGXwmL5t09
	 cJtSOI8CMP6bNLaV2CGPRPBeyytmgV+TaWrvVctIs06gUxcpQKn1xwjYSEKNut8sO6WNL
	 fd1fZ3VsFvdZbdDaAp+iK/HFzBfV+5iitBUgFeVPK4UZ5pc8oGzo0gm8E+S+QFwegRBji
	 27nYplmYAA6s4IgCZRh2f0O6fMl1Im0gqgO7AINQHxP060yG9a74zVlq077i7PJi79+lF
	 ZIZmMjzC4sIJTA0CgFmM8RKy/PLBn6yPwCqRUmjHRdtzaL7YjxQ/JiuQpTFZ9L9IJuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Otx9ao0F;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603460A263A
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8603460A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Otx9ao0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8kTexksySb92RkWPQob17KtLeYJq8y0yNIndqLcc+s=;
	b=Otx9ao0Ffr5GFQtO3Mun3aycMfRT8+o2o9YbRNgxF0k1uZbWmjZPe+hxQXYnMXOMIdUTOf
	C1icHzF5dodBU3GfZmLpnUz7m+qcd7x/P/6PjrnAf+fdCjtO7yCkhrlGNQP6tQQi5Xz4El
	WTqivvi0mWNPwCKSBiS9DjG8NPheAdQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-7M2NqJufMDOobZCWpwZs9w-1; Tue,
 20 Oct 2026 10:50:45 +0000
X-MC-Unique: 7M2NqJufMDOobZCWpwZs9w-1
X-Mimecast-MFC-AGG-ID: 7M2NqJufMDOobZCWpwZs9w_1792493441
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E3CE1954AF3;
	Tue, 20 Oct 2026 10:50:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CA251956095;
	Tue, 20 Oct 2026 10:50:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:06 +0400
Subject: [PATCH v7 49/65] include: add QEMU_REPEAT helper macro
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-49-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5069;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QfToyuYJOLlF7sVISH3TkcbrVSBGm2Ii2KsCu8httjE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZctD1NQTngqU/jBCkEfMek9xa0vMpb6NJE8
 n3GhucWk+2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5Ql3D/wOI62xjJd8gtsu1K015Mj1esGNk3N1OdLVzhvzC8XbQvPEjY9tEjanTvUT/tSDkebzQqp
 wfSbuNHZo2LWhz4d7Wb0804H4k/QbpWXXItKX82506hR5MwcSm8hUjY/X6b3sz99rcdsWT0OYuB
 N2PLFvmXrXrT34rd2lk3l9IEv008VGElWvHn+lGOsyEFdIi/zoDQuQTkGXQNX9r8iwDerholxzT
 +YZ5vO9NOWYzlEcvAPuA1dqTZKv0M9sHG++CE+6rKm7la2iiLolf0dIPC9Lek616L5XTeNy7Con
 EF8tZhpLovhA6XrZr2f/PiaJxHf5yCU0Sq0nNl8Fbybo63RLmGHKN3Eu3hwqRCLDy9l1/5v++ol
 S9hoHIJukwRZWnX0ts9nDy7TeFwjlL2jTa5zYCWg9W7/sdnOtFpaRYdj/lgqkMlTa+D86mUvx9a
 9InKktX0yyqWi5G5hNKi9NOS0lo8H7z0cS/vAMcv16S106YylJ7/t+pIcH0uo8VsZZRuXZ7h/LE
 P4apvjyFIb53bu2HO5H2KfwPzrSgW8jM6CGO9+0RBtkG7nQ+6OYilLtspSRo2mGJD8ejzD5m8U6
 /mj9N3MBuGZckwN2lJSTywe0n7qy4Ybb5v/f4A7HZtbB78gEulqlZppqsvIUcivzHg3tITYzqlL
 tsVVC+qXxIFzhWg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: KCjb1Z5l72E3fLqB7mmhxipxWyzcfAJ3KTEZRBu0fNU_1792493441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Introduce a macro used in following commit, and convert a few existing
candidates. Inspired by a similar macro in Linux kernel/trace/bpf_trace.c

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.56.0.116.g6de20f6092dc

