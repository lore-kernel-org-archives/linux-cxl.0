Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493299;
	b=jIg3XpSJBLro7T6CdLlUfpdWQCIr5YJm5jgzcty3TskZDeChkkVOVpKf9qmQB0nsGvk6
	 PpaN/ElCcGZ+gnihL2Lb55Ie9inu9spiZnNZmPtBuAyci2/lUpptnC1TAL/qwvRwIBnGK
	 akkkzuRtsECIYsN+HhuyQl4/TXqRn1s5mNcG19rheRLDrEgwKyQAKPczYhOEmnu7zxoc5
	 deGzby/tRnv4tYS7AIfDmG8rP+pxZg06Jh6BhKy6eb9xu3FUa5jezf8Ze7bmRlJ3cL34t
	 GhR7/TAZQJjVfLQXvTSLwhTcYy5JINA2WqqSjKRQ2PMfStDO4ajydD8QQomEJBTuoVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493299;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=6lRxJze+aC9KBEtw6tohukWxBkXDlU7+bxwjduyrfYI=;
	b=TYhrPVxv9HPJwTkq1+XlOYh0WZpuVMTPZHHRtqsXkAcTij+/cPYC165qTztfA95mcl8W
	 SL/Z7mZLPowZ3lLbXjmBhkrpdsSwofZzvZV9e+KIwyJSRe9xnmHc8zl0IhV9jUmvA6WfW
	 qy7hqRYdKJuXchjdv7Y0WTTOTnP2JgkYmlb6cRDokZaatUF9dYEpxPSsxvkoMkniZIU8k
	 R1mm4NyQzemlKdMSrg3XraegqA43AWYPC4jFWmMu9SHKCbiFGym7fbccKsBncJ1v33zVD
	 w3JDP6S078iLjk5DNqJWLKlcJ+i4iyyAM7s64r/pbqKm8dtAv5p6m5eu+98BEcNrgOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T8Hmmr0w;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BE606A332
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D5BE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T8Hmmr0w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lRxJze+aC9KBEtw6tohukWxBkXDlU7+bxwjduyrfYI=;
	b=T8Hmmr0wPxOps+cEpvT1pNBup1Ubytf8nwPcV0pEjraEq3C7mgP/SQ6t+pLNHXuTpWtM88
	cOEm92TvcIZP3wVgNs9fBrFgm+A07px1Z8DmTqsD2BNwTXLCxrUcXRs5xh+AxmWN/8fHrC
	EGXstwYWb+hRYK1excOilHJBIcmB2bo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-lr-fJuH1N7yjYLe80xUfpw-1; Tue,
 20 Oct 2026 10:48:12 +0000
X-MC-Unique: lr-fJuH1N7yjYLe80xUfpw-1
X-Mimecast-MFC-AGG-ID: lr-fJuH1N7yjYLe80xUfpw_1792493288
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EE0619560AD;
	Tue, 20 Oct 2026 10:48:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57984418;
	Tue, 20 Oct 2026 10:48:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:38 +0400
Subject: [PATCH v7 21/65] x86: convert OnOffAuto properties to QAPI-aware
 registration
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-21-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6572;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b7fcdLGC+2GPa3Wjcm0RtVCaYcyqYMRaEmGki/G6FxE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZL3Tdedh9aQxPbswLDhqZdFL2lbqwZPM3S
 vvP3WGv3QuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5ZKBEACTX7yzzr/j4WtC3RVqTKIFFKTc4t5cKUo1/m5rQXWpVE294kwdKLk1lDmvrKiKRvWP4EQ
 IXceFiuouMslZldIx6rvaH8qSwjZojuOdcYtS9kFgfcaJK8VG1oplTpXBTZyB+FZ5/Gs3aBsMEB
 t5tdVvlWE3vGgNVKnRHihfelAI1rsOCfCvhEN3PVuOpYZHZKn030ec8DuqYmBLIN4JK4NxVlOEq
 I4l+7RRUjTn+UQESYBdkTzD/7kKYnGyn1sh0NdEggBXI+qh4XVF67TCIe6Ki74Wu524pvWiTdln
 a3Zk5ywcYwrxnmqPHXrSS1L0qdbKMXK4AQgM0zIudWEbOABj6LN4FDyS8jBaTa6vmZ+6wldFjwP
 ORPV5b4B47gEo08l0vCoYvWt7VU6AifaMjSwi+P+U/W7XfjYPyU6XXZsoqfCb+ZS2MhN4qE70/R
 geuTBaQWhAXFMMHFgunyJFt2hCIcqJ0Wwerw6vSBrR6qY7x8Q+Oq5HHVjKdjCf4wdFX8VTMobJX
 f2lLxWx1ceEwmSbW9y3AQIIpTNSfdZx9uwaDx+qUSVHWy4bCIARc+2wjb1w2wN7BzvcSjKSi51x
 /DLhpKPP5A6gaSOHyxMUXd4RmFQntMM0WO6mwAlY2oD0erBahJsrhVsPBr0wSYuH41Bmo80lsiA
 bEw6ebgS3xjIi8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: iJ3TS8G-Bx-rcveb0SVRK4VUDgZSsdpxQQMzyuMYra0_1792493288
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the smm, acpi, pit, and pic OnOffAuto properties from
manual visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/x86.c | 104 +++++++++++++++++++++++++---------------------------------
 1 file changed, 45 insertions(+), 59 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f8ba3244e221..63f297a10532 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -24,7 +24,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
@@ -188,21 +188,16 @@ bool x86_machine_is_smm_enabled(const X86MachineState *x86ms)
     return false;
 }
 
-static void x86_machine_get_smm(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static int x86_machine_get_smm(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto smm = x86ms->smm;
-
-    visit_type_OnOffAuto(v, name, &smm, errp);
+    return x86ms->smm;
 }
 
-static void x86_machine_set_smm(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
+static void x86_machine_set_smm(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->smm, errp);
+    x86ms->smm = value;
 }
 
 bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms)
@@ -213,55 +208,40 @@ bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms)
     return true;
 }
 
-static void x86_machine_get_acpi(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
+static int x86_machine_get_acpi(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto acpi = x86ms->acpi;
-
-    visit_type_OnOffAuto(v, name, &acpi, errp);
+    return x86ms->acpi;
 }
 
-static void x86_machine_set_acpi(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
+static void x86_machine_set_acpi(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->acpi, errp);
+    x86ms->acpi = value;
 }
 
-static void x86_machine_get_pit(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static int x86_machine_get_pit(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto pit = x86ms->pit;
-
-    visit_type_OnOffAuto(v, name, &pit, errp);
+    return x86ms->pit;
 }
 
-static void x86_machine_set_pit(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
+static void x86_machine_set_pit(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->pit, errp);
+    x86ms->pit = value;
 }
 
-static void x86_machine_get_pic(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static int x86_machine_get_pic(Object *obj, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-    OnOffAuto pic = x86ms->pic;
-
-    visit_type_OnOffAuto(v, name, &pic, errp);
+    return x86ms->pic;
 }
 
-static void x86_machine_set_pic(Object *obj, Visitor *v, const char *name,
-                                void *opaque, Error **errp)
+static void x86_machine_set_pic(Object *obj, int value, Error **errp)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &x86ms->pic, errp);
+    x86ms->pic = value;
 }
 
 static char *x86_machine_get_oem_id(Object *obj, Error **errp)
@@ -391,31 +371,37 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     mc->kvm_type = x86_kvm_type;
     nc->raise_nmi = x86_nmi;
 
-    object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
-        x86_machine_get_smm, x86_machine_set_smm,
-        NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_SMM,
-        "Enable SMM");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_SMM,
+        .description = "Enable SMM",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_smm,
+        .set = x86_machine_set_smm,
+    ));
 
-    object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto",
-        x86_machine_get_acpi, x86_machine_set_acpi,
-        NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_ACPI,
-        "Enable ACPI");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_ACPI,
+        .description = "Enable ACPI",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_acpi,
+        .set = x86_machine_set_acpi,
+    ));
 
-    object_class_property_add(oc, X86_MACHINE_PIT, "OnOffAuto",
-                              x86_machine_get_pit,
-                              x86_machine_set_pit,
-                              NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_PIT,
-        "Enable i8254 PIT");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_PIT,
+        .description = "Enable i8254 PIT",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_pit,
+        .set = x86_machine_set_pit,
+    ));
 
-    object_class_property_add(oc, X86_MACHINE_PIC, "OnOffAuto",
-                              x86_machine_get_pic,
-                              x86_machine_set_pic,
-                              NULL, NULL);
-    object_class_property_set_description(oc, X86_MACHINE_PIC,
-        "Enable i8259 PIC");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = X86_MACHINE_PIC,
+        .description = "Enable i8259 PIC",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = x86_machine_get_pic,
+        .set = x86_machine_set_pic,
+    ));
 
     object_class_property_add_str(oc, X86_MACHINE_OEM_ID,
                                   x86_machine_get_oem_id,

-- 
2.56.0.116.g6de20f6092dc

