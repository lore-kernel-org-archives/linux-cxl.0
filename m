Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493307;
	b=1kXM1gmkmmpQxXvVZpVIkTBvyezYNbvReC4Q63IccuZ+HQdwp0Mq5r/N4ix+r9sWUWsX
	 /HICfD69HkxNtCX0UKRCbMNBlcZB9KtDjNk4vQ5NkDWj+cyOdM6O6LUTjOoBZad6ryK53
	 fCaCvUnrt4ZESAEvDlyRTY4/Yddn09uH3GujStZPF2/Fb8/Gzv9XiNDGsE/+UdqdKGIs/
	 S7P7qJ/KPmywIfILeykn9rLpA1UBJMb3iq3e8tyffQNI/Z/rHx/D2CCtkx/xnbmcEHwa6
	 sNe3ZAwdI2PFhbON1o35zE/J/9t5w7EbU3OZCiZWlWApSK40VaQtYI59Lzt5ELCqnvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493307;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=eMqswUiLM19ojZ+xv5E964KFYfmL1usSS/p/S7HX9Dw=;
	b=hHBPtrQ8W4KdBJbuvdjfRFxUWJCfb5QnmOIjvVjCrVLTBl4SKnEl2aJc6msphyBAHpJ+
	 RJMAYhYT9/3FtEH3mdkBooBStRQTRezY24yWDApw++LwktuHoMfOcQjmvUNB8Ru0v7doN
	 nLzWJa1Bk3zWRYd+4dDIV4408Z5gv5fZl4ukyhgBPFy9hHkv3LZpQebz7LTsviUUo8z9G
	 OR01k2lBtnt7rbpbHxJbGxyERDnJB7Vi2uVG/QDqm9hN0b+hXdBFqcTgZB4WEOQkiAaF2
	 jKvG1goM3Sn6RELjnZ5MHdo3cH1fOwS7oNURrbIe4UrIbbA4CnQ0xoT7eWoGVgBAalw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TJoTGumr;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11A60A261F
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A11A60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TJoTGumr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMqswUiLM19ojZ+xv5E964KFYfmL1usSS/p/S7HX9Dw=;
	b=TJoTGumrXFWQZIEeUXM8mOvVVdei2OyjKQbtFhDOA1uDG3peUc/mNDOAhW/LxjJKHWZg9c
	4vtJqqSBYAz75ZVFT2lQRSZUD7/xfK9XPnb5fyv7WvUfgaW2w9TZedomzXMNdJzw+Yl3be
	e4JIp5PMgUVoIR5Z/+BkPQEpEV32Y4Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-cVbzbvoGOKiXjaCIGIacxQ-1; Tue,
 20 Oct 2026 10:48:22 +0000
X-MC-Unique: cVbzbvoGOKiXjaCIGIacxQ-1
X-Mimecast-MFC-AGG-ID: cVbzbvoGOKiXjaCIGIacxQ_1792493298
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F35FD1956050;
	Tue, 20 Oct 2026 10:48:17 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FEA65BC;
	Tue, 20 Oct 2026 10:48:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:40 +0400
Subject: [PATCH v7 23/65] pc: convert OnOffAuto vmport property to
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
Message-Id: <20261020-qom-qapi-v7-23-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rT4IlVA3K6hhZkzIFOmf7AHwvtTZzfc1DRg/HWfKdY4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZZM5/OPYpgkFOCrz7lC/8MWagOdQlNe9HMu
 Ryp6VHtccaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWQAKCRDa6OEJdZac
 5SEYD/9QUk3mMyoHypSwCfk0l9cp7LpdZdLAE2EvzjA5uGZIIAqBUxJDWAuzNGzj6S+fvUJlWdC
 EAhsGdZYLWEH7ASWHHvy7QL+I4sYO8Xg73A6bzHJwEOXw/X9WMYP92+xT4V4aCVSuSlgPw0vTW0
 iDGOxiKxLpni8ZM7f9KyKZ7A07apImgWr/PvLmtbAQVMyGBFVMAlRVQNHiAVAYdPfO4SqPGDtEL
 FSBHcAGWwReG+sJQLCw41zKiUg19IRx+HFFvZizprongoFMpDaugaNynZ5796k7gt/kq32gooTW
 K1HtncPs4zo3o0RQhly74rTNpbStacdnJYfkbYDra1gDQX4eyKiFqN0SjV67VE/VvdnJQ8LJ+8E
 Io6ab5QTARFKwxykGzqjoPPlbjW5eZ6GbWMq2hOGAKs7EJU3OZb880jYHppuGtTKMeUpX/uuFJ5
 eN4Qb9D4OSHbiB0FCPwmlld/4ccrph+UXo3QxiUbsq3bq2b/jfEoZkiNrexjwcvm0VgnTwhUzxZ
 8vLXrwQhyrorPwXLyf2OJODHc3WMrHl2l0U2HAnthI2rPwYhMyYDc0jK0pwPULBUOsnDcOp0HmV
 s84v32DlNvvS1/ARhP+gJq6EJ073Rob14KhIt2ElZfOtp3GUn5BAYDx7P4sYVuaJp2x6H2r0frC
 taKgfMicnsq1l+w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: pdTaVQxNZc6INwHPX_C1rAnoaMmMfRjXwqKyOxD4Zmo_1792493298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the vmport OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/pc.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2d8c87b0e34c..12de020adfbf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -46,6 +46,7 @@
 #include "kvm/kvm_i386.h"
 #include "kvm/tdx.h"
 #include "hw/xen/xen.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/acpi.h"
@@ -1417,21 +1418,16 @@ static const HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void pc_machine_get_vmport(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
+static int pc_machine_get_vmport(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-    OnOffAuto vmport = pcms->vmport;
-
-    visit_type_OnOffAuto(v, name, &vmport, errp);
+    return pcms->vmport;
 }
 
-static void pc_machine_set_vmport(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
+static void pc_machine_set_vmport(Object *obj, int value, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-
-    visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
+    pcms->vmport = value;
 }
 
 static bool pc_machine_get_fd_bootchk(Object *obj, Error **errp)
@@ -1728,11 +1724,13 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
         "Maximum ram below the 4G boundary (32bit boundary)");
 
-    object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
-        pc_machine_get_vmport, pc_machine_set_vmport,
-        NULL, NULL);
-    object_class_property_set_description(oc, PC_MACHINE_VMPORT,
-        "Enable vmport (pc & q35)");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = PC_MACHINE_VMPORT,
+        .description = "Enable vmport (pc & q35)",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = pc_machine_get_vmport,
+        .set = pc_machine_set_vmport,
+    ));
 
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
         pc_machine_get_smbus, pc_machine_set_smbus);

-- 
2.56.0.116.g6de20f6092dc

