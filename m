Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493302;
	b=buFWQE9u7EyGCMTnUva979l20P4d40LY3B6j/WHQfGvUfYEo3PxwNNeHMvVoi/7y8pSR
	 fwxt+ysVdzjyVhdHtqSVu2VVBufijs8wPyNUr2jYEBtFUFEVe710h3wpnXyy9owi9Hdja
	 MC8ti5WnjQMX9amLvjsVJ92L/zWcglCysNnpr8PRLJQANj1yGxjKyU2g/r4XuwWqg9vRE
	 gi+uIKhl47A/H/GiNTd00qQhdx/YTvK4uy5J9TQURndABvXfjwlpvEzDUfo4JO3/ADpG1
	 R3cZHWwlpHao8sQtCHywwKG+vCXHu9DtcZr0bCiNnbWFlaWlhbkmOvFIkwroz+Ii4Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493302;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=v686T4nh/NM1oflx6vG+8Is5DSOwiopIdEkbzupk+MM=;
	b=VQ2vB4gat1Ox0gsJRqmJdB7u3tQ5CxXTdfH48okDoJzkzwNmaBDuY+C3YF/sHD+JNxiO
	 +eq4bluYd9c/46WuT9fFYeWe1ykw9HMQDjqN1ie1sJ3fbtGpT/GPSErhI8293fI561dfp
	 O3fEEE7nPp/4FukMYUFZ+D31+PTjSFkegkyfe9b9h2nvpsAPVHjTdcujlwkcstqbZLzSg
	 JoR4FgL5yO4fze5Jy0yUAc0E+1Jsfm08/fWFvoWSFX5sdDCSh4qhO/TnC+rXodxl9FUck
	 L2hqrs/Y2YB03lhINJL/xsT2agB3o+v4iDJujqDUB+5SJe11mvAfGs+DSK7on1YvHOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QFA2PU4s;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF9606A328
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CF9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QFA2PU4s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v686T4nh/NM1oflx6vG+8Is5DSOwiopIdEkbzupk+MM=;
	b=QFA2PU4s0TnsFE34V7S99UWvPj0oEMe7ELQGDeQVvoKs97Tw+kxN4DNFNRFS6XoKem9MIa
	aCvg5fLuJNh5BAMuXYxE9oQ91UjE/lhssnyd75Bux5FbyXlL3t1uLgYqieD75BRp1bC9nx
	Qn1y4C2mGIojK6lda4VdFjNn9swEx/Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-UHV1rinTOJ-bbp-udAPWMg-1; Tue,
 20 Oct 2026 10:48:17 +0000
X-MC-Unique: UHV1rinTOJ-bbp-udAPWMg-1
X-Mimecast-MFC-AGG-ID: UHV1rinTOJ-bbp-udAPWMg_1792493293
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7010C1955F45;
	Tue, 20 Oct 2026 10:48:13 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF5DA418;
	Tue, 20 Oct 2026 10:48:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:39 +0400
Subject: [PATCH v7 22/65] microvm: convert OnOffAuto properties to
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
Message-Id: <20261020-qom-qapi-v7-22-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5556;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Me58f9fSeK/487LTdlmbScljyoJV9DEvmYyKKbHzwr8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZ3f4zIw9e9fAooGIYWl6vTVthCVQrX3AkP
 XVN/peDhQSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5fnHD/9CAoB6HxmaaNMY3yvic/Ns1VSzlrGDD64+/ws7znbkXJRUTZsOARrXI1NAeSpDHhCFWE9
 aZd/g/x4iqjEreGL3YZPfURomCbgx6ZL2TF6AlB55TgCTVe2XtDQj/SGRMvYlYCtnJe3WSvBZBn
 bny6tC2hWorruBkFGA9yBI4JdjJxyjim1tl/WHPghkn15F+IpLYBgDkEgq9qbfhj/fESSetVQsd
 VQZXlEfUCCztjvdJMJ6jQ1SXe0VGxUP7DZ7a9Vf02O93B4Opigh9XHf6vMHYabAMFIlN1mDwkN5
 2vBVXdmcRf5b9i2TQmJlbvINqUpEpmL6PuTWsNEwkdlrdajGL23/Ah/EqGP5GubDFp5GKvUuv09
 jziOpT7fKZL5DyiwQH4hIklap6S/uF2suc4dqlOXxwBfx22kMvSzUwB2XGLS5gczCvmza/9I8XI
 OcA43WSJrdXDy6E+kDt4DBuYIxX5W67D4waFpayENO54YxTxUAv3KMq6X6TXxElumjQ02BrlzCD
 DuOMlSu50VP3qJ9Y/LWPvABZIDvnuDAthAqtbNK8n2L9dYMrSLuXHBP4okOZgG2EU0Ao9AR5j5p
 fq9wzqn7yXllRZPlm4J9ZzPhMQtbmpGNzSaX1iz4/BgOytGx+cqURRn+3yGlIzcqzlrBQvF3sTb
 tU860q8EJkGq3cQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: mHXeImgqBgiNZIQatoyo8HbdtJvy5CxEsxOqg-J0OEI_1792493293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the rtc, pcie, and ioapic2 OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/microvm.c | 80 +++++++++++++++++++++++--------------------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a49de3374979..1d1ca172bfbd 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -21,7 +21,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "system/system.h"
 #include "system/cpus.h"
 #include "system/numa.h"
@@ -519,55 +519,40 @@ static void microvm_machine_reset(MachineState *machine, ResetType type)
     }
 }
 
-static void microvm_machine_get_rtc(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static int microvm_machine_get_rtc(Object *obj, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-    OnOffAuto rtc = mms->rtc;
-
-    visit_type_OnOffAuto(v, name, &rtc, errp);
+    return mms->rtc;
 }
 
-static void microvm_machine_set_rtc(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static void microvm_machine_set_rtc(Object *obj, int value, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &mms->rtc, errp);
+    mms->rtc = value;
 }
 
-static void microvm_machine_get_pcie(Object *obj, Visitor *v, const char *name,
-                                     void *opaque, Error **errp)
+static int microvm_machine_get_pcie(Object *obj, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-    OnOffAuto pcie = mms->pcie;
-
-    visit_type_OnOffAuto(v, name, &pcie, errp);
+    return mms->pcie;
 }
 
-static void microvm_machine_set_pcie(Object *obj, Visitor *v, const char *name,
-                                     void *opaque, Error **errp)
+static void microvm_machine_set_pcie(Object *obj, int value, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &mms->pcie, errp);
+    mms->pcie = value;
 }
 
-static void microvm_machine_get_ioapic2(Object *obj, Visitor *v, const char *name,
-                                        void *opaque, Error **errp)
+static int microvm_machine_get_ioapic2(Object *obj, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-    OnOffAuto ioapic2 = mms->ioapic2;
-
-    visit_type_OnOffAuto(v, name, &ioapic2, errp);
+    return mms->ioapic2;
 }
 
-static void microvm_machine_set_ioapic2(Object *obj, Visitor *v, const char *name,
-                                        void *opaque, Error **errp)
+static void microvm_machine_set_ioapic2(Object *obj, int value, Error **errp)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &mms->ioapic2, errp);
+    mms->ioapic2 = value;
 }
 
 static bool microvm_machine_get_isa_serial(Object *obj, Error **errp)
@@ -673,26 +658,29 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
-                              microvm_machine_get_rtc,
-                              microvm_machine_set_rtc,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
-        "Enable MC146818 RTC");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_RTC,
+        .description = "Enable MC146818 RTC",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_rtc,
+        .set = microvm_machine_set_rtc,
+    ));
 
-    object_class_property_add(oc, MICROVM_MACHINE_PCIE, "OnOffAuto",
-                              microvm_machine_get_pcie,
-                              microvm_machine_set_pcie,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_PCIE,
-        "Enable PCIe");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_PCIE,
+        .description = "Enable PCIe",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_pcie,
+        .set = microvm_machine_set_pcie,
+    ));
 
-    object_class_property_add(oc, MICROVM_MACHINE_IOAPIC2, "OnOffAuto",
-                              microvm_machine_get_ioapic2,
-                              microvm_machine_set_ioapic2,
-                              NULL, NULL);
-    object_class_property_set_description(oc, MICROVM_MACHINE_IOAPIC2,
-        "Enable second IO-APIC");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = MICROVM_MACHINE_IOAPIC2,
+        .description = "Enable second IO-APIC",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = microvm_machine_get_ioapic2,
+        .set = microvm_machine_set_ioapic2,
+    ));
 
     object_class_property_add_bool(oc, MICROVM_MACHINE_ISA_SERIAL,
                                    microvm_machine_get_isa_serial,

-- 
2.56.0.116.g6de20f6092dc

