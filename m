Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493329;
	b=nQ86M/9qv6zprtSQvrEAR4fsvQ+OlgYFYrr1mXwDaws1QfGD5w742AHCEPQxlJNTg9N/
	 iDZw6beLkqIWKQctxCMeD44AvGqmctqINi/hS0qTPNVnC11maPxsKz/mCZGehAvKNJLpC
	 SrKKdSuVrZWDYooJ9SFJ1z0N9wp+67UwpSb97mzcJDtPo7faIc0ZgXJxUSHlQ275JvWS1
	 Mnr2KIWeqLO8P1dULJ+sWRG3z9BdeX+ghL7SXL7GYDfXInHXlX9hq+K5PHCLKjNMuGDKy
	 8v8Io0NDeCNsY+Wzdr9AfbCSruMjkeR76Qe9A/SanY+3tEfqtktyqSkORiG5s4sZhyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493329;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=PV9kuqJKGQPXQgRGsKGHU0tbZKUNtph+KWyMZp45370=;
	b=BBAWjOxY5xjKKS22LA8TUM1FrUmvQwtQEH2lKKf6hlVSkUArriFjCkES7XeI731w8JH8
	 evZZjJaSrL7UY9ODgpKNqiD7h5vKRHhPdtoXSfN8gN1zs55baeZ3zjISdAlvL6UPuYRAC
	 7HvPb9ND5LQ+aapeqk1LcoB3wp0cECRFq2ynDAjzZAXIE3viXoAkJa6uxejpGde35t6bL
	 zO3ZU9tDG2OhYnsoBfCFx66dIpf/AoUtu5f5CMW5D/7ZR0yAlO6E6xMktowdUdyUYRKVL
	 xmLvn5p26gfDfePCIbWZMZLAMpT6pLmDwX0LYA6IMEW9c7u/gcyhOUbxB/3PvginrmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpWlFmnB;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B427606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B427606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TpWlFmnB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PV9kuqJKGQPXQgRGsKGHU0tbZKUNtph+KWyMZp45370=;
	b=TpWlFmnBdRUuF9+RlCvOXz1huOM59mJdNdVCwlhpbJrHDIRV3Du9T5FMMMoMUxJ9xT4xgM
	ib41fCWIdNVRCxhqQk/AXra30L/osptgj5eYtsqv9DTacrdUcswPNAcdljjAqqApT6O4cb
	3J7IhiKNxQd3KewFYF4gA1674FjWe9A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-evkX-KHbNye8aHdQO4NYlg-1; Tue,
 20 Oct 2026 10:48:38 +0000
X-MC-Unique: evkX-KHbNye8aHdQO4NYlg-1
X-Mimecast-MFC-AGG-ID: evkX-KHbNye8aHdQO4NYlg_1792493313
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF9F3180056E;
	Tue, 20 Oct 2026 10:48:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3CE130000E7;
	Tue, 20 Oct 2026 10:48:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:43 +0400
Subject: [PATCH v7 26/65] loongarch/virt: convert OnOffAuto properties to
 QAPI-aware registration
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-26-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6018;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mcn2JeHI5hIu+VBT7QhXgV3egUYPPh04IMlXvF5e4Ec=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZn4jMd/2ebsZ0FoPPbj1jDn2hGRETnXjT2
 a9TRgsJMRyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5VcbD/0XQPP+Hq6G02Te1ATdBSDCe1WOePn+q3hsXMEjoOzOBoMnryWDu8kNBch2qC8q592TwYn
 hRkWhx3p8YWF9kYFeQ23u32TqttVt/lCxq8pWndKI6GgSC5v8616dnw2YpSgsb3fosKThWBUUUk
 fCN2F7JenKbU2ahFlCWtu7UAB0XSoTl4KkhrepX20amiSBjQnvZQvYi/1xg7w2m5ZMSYMSmH/LC
 l23OSw7QCemnhrF++uLTOObyXcs8T5yYj67uh0BF19kJB3ZzZ0jaMA3li1HytdrFcV7GwnFvH0D
 LXX8Rrv5mvff1zR2spKxkS9RctUmQZdKlOZ+GhgQnZX+wyQIgSQesWnPD8JmIU9lJGXw7voOqGQ
 cnwmMtO4dkVkqgg8e8dPEOenMG0LMpxPwEXmbP1l4zz9T5pL6YEFBPe3sLJ/Q4vz+eChkhPJpnT
 kbYtHnZSNae7agOjfkGpzv0xQZnugriVrT0XMl8A8/QQEQDDkngQF3/tF2Wjp1UBd9uE9NLqTVA
 5kCV+wPxw4rBcTH/PtAQiXN2Y/UxDOIz8vsWuaQySEqGQynllWHdiPAk4QmiAgkoxO/0r0j4yWG
 zVIXphd2t3fdmg99IfAn5usbT83aXvGpab7PMeWgsXcGpLJh205ful7Mp2GUVpQTa6A92/oPOaA
 YI89h+wirCbvd3w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: iROokuKAC27GUrgKpiktWEOGw8b9qtzW5ygArWFx70s_1792493313
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the acpi, v-eiointc, and dmsi OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/loongarch/virt.c | 85 +++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9c5371af9dee..db8ea76f117c 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -36,7 +36,8 @@
 #include "target/loongarch/cpu.h"
 #include "target/loongarch/cpu-mmu.h"
 #include "hw/firmware/smbios.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/core/platform-bus.h"
@@ -51,26 +52,21 @@
 #include "qemu/log.h"
 #include "kvm/kvm_loongarch.h"
 
-static void virt_get_dmsi(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp)
+static int virt_get_dmsi(Object *obj, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-    OnOffAuto dmsi = lvms->dmsi;
-
-    visit_type_OnOffAuto(v, name, &dmsi, errp);
-
+    return lvms->dmsi;
 }
-static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+
+static void virt_set_dmsi(Object *obj, int value, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
+    lvms->dmsi = value;
 
-    visit_type_OnOffAuto(v, name, &lvms->dmsi, errp);
-
-    if (lvms->dmsi == ON_OFF_AUTO_OFF) {
+    if (value == ON_OFF_AUTO_OFF) {
         lvms->misc_feature &= ~BIT(IOCSRF_DMSI);
         lvms->misc_status &= ~BIT_ULL(IOCSRM_DMSI_EN);
-    } else if (lvms->dmsi == ON_OFF_AUTO_ON) {
+    } else if (value == ON_OFF_AUTO_ON) {
         lvms->misc_feature = BIT(IOCSRF_DMSI);
     }
 }
@@ -78,21 +74,16 @@ static void virt_set_dmsi(Object *obj, Visitor *v, const char *name,
 #define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 64
 #define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
 
-static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+static int virt_get_veiointc(Object *obj, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-    OnOffAuto veiointc = lvms->veiointc;
-
-    visit_type_OnOffAuto(v, name, &veiointc, errp);
+    return lvms->veiointc;
 }
 
-static void virt_set_veiointc(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
+static void virt_set_veiointc(Object *obj, int value, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &lvms->veiointc, errp);
+    lvms->veiointc = value;
 }
 
 static bool virt_get_highmem_mmio(Object *obj, Error **errp)
@@ -1025,21 +1016,16 @@ static void virt_init(MachineState *machine)
     loongarch_load_kernel(machine, &lvms->bootinfo, phys_addr_mask);
 }
 
-static void virt_get_acpi(Object *obj, Visitor *v, const char *name,
-                          void *opaque, Error **errp)
+static int virt_get_acpi(Object *obj, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-    OnOffAuto acpi = lvms->acpi;
-
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return lvms->acpi;
 }
 
-static void virt_set_acpi(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void virt_set_acpi(Object *obj, int value, Error **errp)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &lvms->acpi, errp);
+    lvms->acpi = value;
 }
 
 static char *virt_get_oem_id(Object *obj, Error **errp)
@@ -1483,20 +1469,29 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = virt_device_unplug_request;
     hc->unplug = virt_device_unplug;
 
-    object_class_property_add(oc, "acpi", "OnOffAuto",
-        virt_get_acpi, virt_set_acpi,
-        NULL, NULL);
-    object_class_property_set_description(oc, "acpi",
-        "Enable ACPI");
-    object_class_property_add(oc, "v-eiointc", "OnOffAuto",
-        virt_get_veiointc, virt_set_veiointc,
-        NULL, NULL);
-    object_class_property_set_description(oc, "v-eiointc",
-                            "Enable Virt Extend I/O Interrupt Controller.");
-    object_class_property_add(oc, "dmsi", "OnOffAuto",
-        virt_get_dmsi, virt_set_dmsi, NULL, NULL);
-    object_class_property_set_description(oc, "dmsi",
-                            "Enable direct Message-interrupts Controller.");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "acpi",
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_acpi,
+        .set = virt_set_acpi,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "v-eiointc",
+        .description = "Enable Virt Extend I/O Interrupt Controller.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_veiointc,
+        .set = virt_set_veiointc,
+    ));
+
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "dmsi",
+        .description = "Enable direct Message-interrupts Controller.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = virt_get_dmsi,
+        .set = virt_set_dmsi,
+    ));
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
 #ifdef CONFIG_TPM

-- 
2.56.0.116.g6de20f6092dc

