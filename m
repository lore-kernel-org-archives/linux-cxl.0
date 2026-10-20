Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493333;
	b=K/9kV3aomqEfv4DWXUy/StCuAsVL3TFNpra9G8b+1pgMkiu25d9Oa3B2+H5bfU/bk/Qp
	 HG6sE0qFQ6E5UQLLdMtsFXfNhXU+zIdcungKmnsPvVck8pbztZIm45Gxz/SvqOsVKsTKj
	 UdpoUoBXq9kRdLeKw/xKlAgNDlXDp9N+fk4bYja4LHfp041pxRh6fk7Uwa4LclJQdL+LZ
	 L/41Zmh+Kvj4SrFbbD2gDLaXsQV2CJaSBhYlowv8UWBEn2g9GOLggggLKYeca3nXs2dJB
	 9y76XVIc7mP8ety4NLZ61uw6ln0Q5TvPUlVhMW1uaIX5rZ2XP2FRKFpy5QR0HrQVsPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493333;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=ITZAmzqb42SOieKlyK1KvmCdBEM4ZFKVGJMc/HmGp5k=;
	b=zImFGBpoM4v6ChZF1peoGTmzXjqVz8/MoQkMkS/VZicbdN1Aoh9gcIRnGNuhg1M3Ocbt
	 DwBDgFWNLTwibNz6soc58H5gMFyngAvB3NCwO/ZfZ87+cixUz39bQFcVTc+BFR8hPAa/S
	 uKJpTuyMuCZwv0SaPegQeAj25lVvc/0uwB2IDndIKMO/l852H7P2tkcef1WAWS3ig7LxJ
	 +aF2+r9+z3YzxadgbTiABSbYZCCRg2VXYVf85JV0POPShLdug6xEP7g+u/6nwtIlbWsyK
	 MXsa9fbTUJ7Sl7FnIjNcjRys+8iDzkFvl8jEeOqyOFkPXcG4g88qrqzJqQKJFSOup6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="JCJit/yy";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD412606A338
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD412606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JCJit/yy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITZAmzqb42SOieKlyK1KvmCdBEM4ZFKVGJMc/HmGp5k=;
	b=JCJit/yyp+w4uCtBxlQ7FlBWBWcri0e09WOjyciMVunktBf1haZiXW+tk5/w9dHzd6xpKl
	TWdowu2f70FRV+VNgDP7JMl/Z2j4DNhNqRNQh1drKDLxHvCM6/RqL1nePonbuTiaJr12Xc
	i5F+Af30OT0T9wlb8XK/b39QLf6R3Ms=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-PGS6jTcAOfWke_074JgvdA-1; Tue,
 20 Oct 2026 10:48:48 +0000
X-MC-Unique: PGS6jTcAOfWke_074JgvdA-1
X-Mimecast-MFC-AGG-ID: PGS6jTcAOfWke_074JgvdA_1792493324
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 607CC1955DCB;
	Tue, 20 Oct 2026 10:48:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C7E018002B1;
	Tue, 20 Oct 2026 10:48:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:45 +0400
Subject: [PATCH v7 28/65] sev: convert OnOffAuto legacy-vm-type property to
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
Message-Id: <20261020-qom-qapi-v7-28-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2932;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e2zxmMhmJGF0dwc0SRzZuUR5qMnfM/36nnJtEEhS5HU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZaPCLOl/jTkrNhGvjvoErUEYn1j7um/aMo0
 ZI7dyqyzT6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5bBPD/9YSzBj8rYL1VR6mIizfqkgB0/PpThetAFKK6VOJ5UwsrSCvay3ut/gvIfOk0yHdhdHVWq
 Uz2ZKUkj9DO9sRX39BQCuKmjIsfoY3siZbaDChTtbShjPxhuFraX/nC2nvPuqd3vJJCy6AOeiCN
 0ihLqhJPkeYoPKVqVd8jLDAt24/RSLOtUiuCXK3ZjSyXPiQCI7Q+c4ObrWUqfFSKoZuD/WjUmpI
 Ydb1AYXzIDBSx6VHn33zxDswViVybQV5ahY7osUUBE7KAI28mVSFrxFOCGWT58Hpz/xomG0JKq8
 9VXoJNH+E5shv0v0VhMSnm+pvNmz0id2LZty8354Pi1CZ+KdmxSwz7Kxqdc0NCFER77a7+xn7J6
 x0S9Zu85aLRNnCRSOJ5auSHQgryCGQvKSOlqFFL+SCOVftpsiiUH4bd8CAKJCIPeqw7j7beCCGY
 KNB6BsQL6TDT7zaAQmMPNVZur/l87U4iJmPZjBF6c3RiM/10WKCnxRb3MWcocawkttpcuS9FLxg
 B9ud9eSGegnwhA1PxzXyburB+4c8MbRt5hdLKQvae+gUTUK0Z3BG3jbmybChBhoNKRREWEUepvd
 LkDhvCIHcfCmtyY2QCNu5qT/nkPIDzUZOqpHc0Oq8GA49cI/MvabenocOgTLTS9BEKBuQDZRWKY
 jeq3wdMr+xiPpNg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: ZvY6p0bOCOrG-6-nZ-j09XJzfW-0FG8M7QHMcIWtgms_1792493324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the legacy-vm-type OnOffAuto property from manual
visitor-based callbacks to property_add_qapi_enum().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/sev.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index cc16c6b07123..b2c7260c80a4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -20,6 +20,7 @@
 #include <sys/ioctl.h>
 
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -2939,23 +2940,16 @@ sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
     SEV_GUEST(obj)->session_file = g_strdup(value);
 }
 
-static void sev_guest_get_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static int sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-    OnOffAuto legacy_vm_type = sev_guest->legacy_vm_type;
-
-    visit_type_OnOffAuto(v, name, &legacy_vm_type, errp);
+    return sev_guest->legacy_vm_type;
 }
 
-static void sev_guest_set_legacy_vm_type(Object *obj, Visitor *v,
-                                         const char *name, void *opaque,
-                                         Error **errp)
+static void sev_guest_set_legacy_vm_type(Object *obj, int value, Error **errp)
 {
     SevGuestState *sev_guest = SEV_GUEST(obj);
-
-    visit_type_OnOffAuto(v, name, &sev_guest->legacy_vm_type, errp);
+    sev_guest->legacy_vm_type = value;
 }
 
 static void
@@ -2981,11 +2975,14 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
                                   sev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
-    object_class_property_add(oc, "legacy-vm-type", "OnOffAuto",
-                              sev_guest_get_legacy_vm_type,
-                              sev_guest_set_legacy_vm_type, NULL, NULL);
-    object_class_property_set_description(oc, "legacy-vm-type",
-            "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "legacy-vm-type",
+        .description = "use legacy VM type to maintain measurement "
+                       "compatibility with older QEMU or kernel versions.",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = sev_guest_get_legacy_vm_type,
+        .set = sev_guest_set_legacy_vm_type,
+    ));
 }
 
 static void

-- 
2.56.0.116.g6de20f6092dc

