Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493508;
	b=Wi9nLegss1EqFFbDrAdetQjWaW520G56EWb5SPMXoN3rjmg8dWqi6xssPr1lJKWayZFM
	 A0HZTbFJLqTt49fPOwPmuLRYehg2d08rBC7iEvaQ+TSjzGvWuS/VYa8qMdjObv/QRu777
	 cGmPqezoK1yHUt8E7z0OBGCC/QcPWfeUBosMId9HV8yDzZ4DLtNvYsjty0MHBb/S8bdGU
	 8rvYzAu+4rxamI+G02d+odcmiKeT3FuuXyrKxseSf2kPFeaAfngZsxLrOkzdYWiVuajF2
	 SLwEUNcO2dTJhkk+YgG2EPTCHP4BxdexvWzIU5YZW2QA/Kd5Y0sxV1sfgcbCbDsrD2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493508;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=r8QtuizhlL08ffZvDlPlw2v2PSSFR41aZ6S3u6bs6Qs=;
	b=41K49A4xBjfPX9bAwr4FQIaGWrHaZXNq9gloJvglFNTaB5+fzlUwvEiD78aBGOFaovt1
	 n0+RjmJvPhLo/X3FLNOeLUeLUvG1vgmhrer7jFSAKUIChnxcciK5IZ0nO9hzV8xbMQST+
	 LEbgLcepgwE9lqsDw3aqT2FouKSTe2Hxkd0RFAHCXZ21e6ICsbIiR8/pSPFakbxmH/7DT
	 gqHpjXuStbncQF/F5XLW5OdnL92lUNdiLapgxhwV+WzUJ/sQ/oKyn25yokKlLzzxmJzcy
	 KeynLyd7qOAtaC4C+62nADSS+Fbpf4ZZbCXzy+LDfsSoBrBfIRbsQVZqcse+ARWH3sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iOgIBriM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E660A2630
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F14E660A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iOgIBriM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8QtuizhlL08ffZvDlPlw2v2PSSFR41aZ6S3u6bs6Qs=;
	b=iOgIBriMPHdXSqu84Q0n7kjxFeeWt2YcCdJjL8ytw/V/0bUHl23+ECwip+iCNg5lJ/srMH
	Z8wr+l8hfjU+b1o3fxjuR2Q3yDioXjk7LA9U6XHcPvvdljxr8I8o0G56kQcaRXg//MAtQt
	AfgmfxfhqaB0Qh6BcAFt0Q88H+j6H0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-ZgjA7GB6MIOQEU4UKDz0Pw-1; Tue,
 20 Oct 2026 10:51:41 +0000
X-MC-Unique: ZgjA7GB6MIOQEU4UKDz0Pw-1
X-Mimecast-MFC-AGG-ID: ZgjA7GB6MIOQEU4UKDz0Pw_1792493497
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DAA619541A2;
	Tue, 20 Oct 2026 10:51:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2887A5BC;
	Tue, 20 Oct 2026 10:51:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:17 +0400
Subject: [PATCH v7 60/65] qdev: simplify DEFINE_PROP_ARRAY and remove
 generic array PropertyInfo
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-60-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18915;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AcBmF3xK1ByT+5UwBtaglHA+LD1ebp5i6d9a8Eno2C4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZcQVsvYZthZcJnIe4I+d1Hh4MrCaE9gYxWU
 lhG/CyXLeSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5ehBD/0bQxYDrIfQP8eZONOGiv1tqlX8g1WhNB17TG+vBi5j+C3oGfzsx38lnKRAcN5xgxzz1CM
 1C6QLO3YbdB7nO7OD6wXVB2ACmBrsKt/kzhkJMRAOS2F6RZkcrxNnIvxNV64HsPCaV/bgKHptCW
 i3j8mn2meJlvQg1JeQ9c6gGf0UkYJsMGfVKnqEU6rUR5mZx0iX5zghoO+VG1oXmHXVYe7oOl7lb
 E5wtqIj6ipYyrt3nTaE84ZNyXgchLpOG3YU+afL4IA6cH4CkPrnv7B4OmnjET3jRLE+kStLOe9C
 N0izUsnNyTalfSJxy4y0Dbrewp8QQntANZnrle7jyFTW8kUQmu0G/0/80F4LxWf9y8dRpqJYDHl
 4nzzttOhpDmwqnqQoB16CcQlMNhX3vXFqO+jDwjYeS5qXdM91f88Cgn+r6fakjIYk/II637VUYV
 Pb0MHezwGN8sBTUROcVPxo65vHguUIdV1Zcp6jJ/seTaCbNFiOqFY9mqhW6PEI/dn4u8rTWLhvV
 JbZdVZyrW1STJql4uj6cX7xOhzHzd1/FtlOUJKxigqrbx8XjmLOauttoZzOnJdnnsQHcShiKuAb
 VdyqA86tVpuDQPZba/kmur0HlRnDqMuvW+V3Mb8Ij0S8aGdUuq9Zp5RscZC2sLV9VUt8bwaf8mz
 3T5spA2nBMmHtjQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: NC6PXOPqOwJM8mfbFn0GH2LxdNO8cDipEAn4JSnwbWI_1792493497
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Change DEFINE_PROP_ARRAY, the macro now uses _arrayprop##_list to
resolve the typed list PropertyInfo (introduced in the previous patch)
instead of the generic qdev_prop_array.

This means the element type and size information is carried by the
PropertyInfo itself rather than duplicated at each callsite. Since
the typed list PropertyInfos encode element_info and element_size,
the .arrayinfo and .arrayfieldsize fields are no longer set by the
macro (they will be removed from the Property struct in the next patch).

Remove qdev_prop_array, which is now unused.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c         |  8 --------
 hw/display/apple-gfx-mmio.m       |  2 +-
 hw/display/apple-gfx-pci.m        |  2 +-
 hw/display/apple-gfx.h            |  1 +
 hw/display/apple-gfx.m            |  4 ++++
 hw/input/stellaris_gamepad.c      |  2 +-
 hw/intc/arm_gicv3_common.c        |  2 +-
 hw/intc/arm_gicv5_common.c        |  4 ++--
 hw/intc/rx_icu.c                  |  4 ++--
 hw/misc/arm_sysctl.c              |  4 ++--
 hw/misc/mps2-scc.c                |  2 +-
 hw/net/rocker/rocker.c            |  2 +-
 hw/net/virtio-net.c               |  2 +-
 hw/nvram/xlnx-efuse.c             |  2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c |  2 +-
 hw/riscv/riscv_hart.c             |  6 ++----
 hw/virtio/virtio-iommu-pci.c      |  2 +-
 include/hw/block/block.h          |  2 +-
 include/hw/core/qdev-properties.h | 27 ++++++++++-----------------
 tests/unit/test-qdev.c            |  2 +-
 20 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index bace12b10e36..5c403cc2e57e 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -875,14 +875,6 @@ void default_prop_array(ObjectProperty *op, const Property *prop)
     object_property_set_default_list(op);
 }
 
-const PropertyInfo qdev_prop_array = {
-    .type = "list",
-    .get = get_prop_array,
-    .set = set_prop_array,
-    .release = release_prop_array,
-    .set_default_value = default_prop_array,
-};
-
 const PropertyInfo qdev_prop_uint8_list =
     DEFINE_PROP_ARRAY_INFO(qdev_prop_uint8, uint8_t);
 const PropertyInfo qdev_prop_uint16_list =
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 58beaadd1f10..dcd04617eb87 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -258,7 +258,7 @@ static void apple_gfx_mmio_reset(Object *obj, ResetType type)
 static const Property apple_gfx_mmio_properties[] = {
     DEFINE_PROP_ARRAY("display-modes", AppleGFXMMIOState,
                       common.num_display_modes, common.display_modes,
-                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode),
 };
 
 static void apple_gfx_mmio_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index b0694f4cb855..74f79c8b157b 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -118,7 +118,7 @@ static void apple_gfx_pci_reset(Object *obj, ResetType type)
 static const Property apple_gfx_pci_properties[] = {
     DEFINE_PROP_ARRAY("display-modes", AppleGFXPCIState,
                       common.num_display_modes, common.display_modes,
-                      qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode),
 };
 
 static void apple_gfx_pci_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index 3197bd853dab..b7eef7b9b14a 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -69,6 +69,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t guest_physical,
                                        MemoryRegion **mapping_in_region);
 
 extern const PropertyInfo qdev_prop_apple_gfx_display_mode;
+extern const PropertyInfo qdev_prop_apple_gfx_display_mode_list;
 
 #endif
 
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 77c420b30006..592d692d793d 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -16,6 +16,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qapi/qapi-builtin-type-infos.h"
+#include "hw/core/qdev-prop-internal.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
 #include "qemu/aio-wait.h"
@@ -879,3 +880,6 @@ static void apple_gfx_set_display_mode(Object *obj, Visitor *v,
     .get   = apple_gfx_get_display_mode,
     .set   = apple_gfx_set_display_mode,
 };
+
+const PropertyInfo qdev_prop_apple_gfx_display_mode_list =
+    DEFINE_PROP_ARRAY_INFO(qdev_prop_apple_gfx_display_mode, AppleGFXDisplayMode);
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 376d91abad70..20613f649977 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -80,7 +80,7 @@ static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
 
 static const Property stellaris_gamepad_properties[] = {
     DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
-                      keycodes, qdev_prop_uint32, uint32_t),
+                      keycodes, qdev_prop_uint32),
 };
 
 static void stellaris_gamepad_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index f7ba74e6d52a..1298b6b735e9 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -615,7 +615,7 @@ static const Property arm_gicv3_common_properties[] = {
      */
     DEFINE_PROP_BOOL("force-8-bit-prio", GICv3State, force_8bit_prio, 0),
     DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
-                      redist_region_count, qdev_prop_uint32, uint32_t),
+                      redist_region_count, qdev_prop_uint32),
     DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx, 0),
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b155486af65e..61c8ae493021 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -191,9 +191,9 @@ static void gicv5_common_realize(DeviceState *dev, Error **errp)
 
 static const Property arm_gicv5_common_properties[] = {
     DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
-                           cpus, TYPE_ARM_CPU, ARMCPU *),
+                           cpus, TYPE_ARM_CPU),
     DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
-                      cpu_iaffids, qdev_prop_uint32, uint32_t),
+                      cpu_iaffids, qdev_prop_uint32),
     DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
     DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
     DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 992b069ae245..125a6dcb6804 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -356,9 +356,9 @@ static const VMStateDescription vmstate_rxicu = {
 
 static const Property rxicu_properties[] = {
     DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
-                      qdev_prop_uint8, uint8_t),
+                      qdev_prop_uint8),
     DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
-                      qdev_prop_uint8, uint8_t),
+                      qdev_prop_uint8),
 };
 
 static void rxicu_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index ebc95b9bb54c..1df85593a5cb 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -626,10 +626,10 @@ static const Property arm_sysctl_properties[] = {
     DEFINE_PROP_UINT32("proc_id", arm_sysctl_state, proc_id, 0),
     /* Daughterboard power supply voltages (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-voltage", arm_sysctl_state, db_num_vsensors,
-                      db_voltage, qdev_prop_uint32, uint32_t),
+                      db_voltage, qdev_prop_uint32),
     /* Daughterboard clock reset values (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-clock", arm_sysctl_state, db_num_clocks,
-                      db_clock_reset, qdev_prop_uint32, uint32_t),
+                      db_clock_reset, qdev_prop_uint32),
 };
 
 static void arm_sysctl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index 554b504c7203..32f9e166feed 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -464,7 +464,7 @@ static const Property mps2_scc_properties[] = {
      * motherboard configuration controller to suit the FPGA image.
      */
     DEFINE_PROP_ARRAY("oscclk", MPS2SCC, num_oscclk, oscclk_reset,
-                      qdev_prop_uint32, uint32_t),
+                      qdev_prop_uint32),
 };
 
 static void mps2_scc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 910dce901b67..afbc32e99d94 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1466,7 +1466,7 @@ static const Property rocker_properties[] = {
     DEFINE_PROP_UINT64("switch_id", Rocker,
                        switch_id, 0),
     DEFINE_PROP_ARRAY("ports", Rocker, fp_ports,
-                      fp_ports_peers, qdev_prop_netdev, NICPeers),
+                      fp_ports_peers, qdev_prop_netdev),
 };
 
 static const VMStateDescription rocker_vmsd = {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 19f453fb7dfd..56194398742e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4377,7 +4377,7 @@ static const Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
     DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
-                      ebpf_rss_fds, qdev_prop_string, char*),
+                      ebpf_rss_fds, qdev_prop_string),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index b1c9ee4980a0..99c16ce76f15 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -266,7 +266,7 @@ static const Property efuse_properties[] = {
     DEFINE_PROP_UINT32("efuse-size", XlnxEFuse, efuse_size, 64 * 32),
     DEFINE_PROP_BOOL("init-factory-tbits", XlnxEFuse, init_tbits, true),
     DEFINE_PROP_ARRAY("read-only", XlnxEFuse, ro_bits_cnt, ro_bits,
-                      qdev_prop_uint32, uint32_t),
+                      qdev_prop_uint32),
 };
 
 static void efuse_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index f5d5587cb657..101320b82fd9 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -740,7 +740,7 @@ static const Property efuse_ctrl_props[] = {
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
     DEFINE_PROP_ARRAY("pg0-lock",
                       XlnxVersalEFuseCtrl, extra_pg0_lock_n16,
-                      extra_pg0_lock_spec, qdev_prop_uint16, uint16_t),
+                      extra_pg0_lock_spec, qdev_prop_uint16),
 };
 
 static void efuse_ctrl_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 32fd39737ff6..132cf8737001 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -48,11 +48,9 @@ static const Property riscv_harts_props[] = {
      * defined by "rnmi-exception-vector".
      */
     DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
-                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
-                      uint64_t),
+                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64),
     DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
-                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
-                      uint64_t),
+                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64),
     DEFINE_PROP_LINK("memory", RISCVHartArrayState, memory,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 7b5ffddc1e97..1f3a07c5d119 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -38,7 +38,7 @@ static const Property virtio_iommu_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
                       vdev.nr_prop_resv_regions, vdev.prop_resv_regions,
-                      qdev_prop_reserved_region, ReservedRegion),
+                      qdev_prop_reserved_region),
 };
 
 static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index df941df19f26..70bf03a8de73 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -83,7 +83,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                             _conf.account_failed, ON_OFF_AUTO_AUTO),    \
     DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
                      _conf.num_stats_intervals, _conf.stats_intervals,  \
-                     qdev_prop_uint32, uint32_t)
+                     qdev_prop_uint32)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 0c067170079d..39f95ce7a3c6 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -76,7 +76,6 @@ extern const PropertyInfo qdev_prop_size;
 extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_size32;
-extern const PropertyInfo qdev_prop_array;
 extern const PropertyInfo qdev_prop_uint8_list;
 extern const PropertyInfo qdev_prop_uint16_list;
 extern const PropertyInfo qdev_prop_uint32_list;
@@ -148,15 +147,15 @@ extern const PropertyInfo qdev_prop_link_list;
  * @_name: name of the array
  * @_state: name of the device state structure type
  * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
- *               will point to the array
- * @_arrayprop: PropertyInfo defining what property the array elements have
- * @_arraytype: C type of the array elements
+ * @_arrayfield: field in @_state which will point to the array
+ * @_arrayprop: PropertyInfo for the array elements (e.g. qdev_prop_uint32);
+ *              a corresponding list PropertyInfo named @_arrayprop##_list
+ *              must exist
  *
  * Define device properties for a variable-length array _name.  The array is
  * represented as a list in the visitor interface.
  *
- * @_arraytype is required to be movable with memcpy().
+ * The element type must be movable with memcpy().
  *
  * When the array property is set, the @_field member of the device
  * struct is set to the array length, and @_arrayfield is set to point
@@ -166,12 +165,10 @@ extern const PropertyInfo qdev_prop_link_list;
  * @_arrayfield memory.
  */
 #define DEFINE_PROP_ARRAY(_name, _state, _field,                        \
-                          _arrayfield, _arrayprop, _arraytype)          \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+                          _arrayfield, _arrayprop)                      \
+    DEFINE_PROP(_name, _state, _field, _arrayprop##_list, uint32_t,     \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
-                .arrayinfo = &(_arrayprop),                             \
-                .arrayfieldsize = sizeof(_arraytype),                   \
                 .arrayoffset = offsetof(_state, _arrayfield))
 
 #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
@@ -183,10 +180,8 @@ extern const PropertyInfo qdev_prop_link_list;
  * @_name: name of the array
  * @_state: name of the device state structure type
  * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
- *               will point to the array
+ * @_arrayfield: field in @_state which will point to the array
  * @_linktype: QOM type name of the link type
- * @_arraytype: C type of the array elements
  *
  * Define device properties for a variable-length array _name of links
  * (i.e. this is the array version of DEFINE_PROP_LINK).
@@ -195,12 +190,10 @@ extern const PropertyInfo qdev_prop_link_list;
  * where each string is the QOM path of the object to be linked.
  */
 #define DEFINE_PROP_LINK_ARRAY(_name, _state, _field, _arrayfield,      \
-                               _linktype, _arraytype)                   \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_array, uint32_t,       \
+                               _linktype)                               \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_link_list, uint32_t,   \
                 .set_default = true,                                    \
                 .defval.u = 0,                                          \
-                .arrayinfo = &qdev_prop_link,                           \
-                .arrayfieldsize = sizeof(_arraytype),                   \
                 .arrayoffset = offsetof(_state, _arrayfield),           \
                 .link_type = _linktype)
 
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 77c3eee71713..8cd004b1efab 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -23,7 +23,7 @@ static const Property my_dev_props[] = {
     DEFINE_PROP_UINT32("u32", MyDev, prop_u32, 100),
     DEFINE_PROP_STRING("string", MyDev, prop_string),
     DEFINE_PROP_ARRAY("array-u32", MyDev, prop_array_u32_nb, prop_array_u32,
-                     qdev_prop_uint32, uint32_t),
+                     qdev_prop_uint32),
 };
 
 static void my_dev_class_init(ObjectClass *oc, const void *data)

-- 
2.56.0.116.g6de20f6092dc

