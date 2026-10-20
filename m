Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493328;
	b=gBmLCVBzreGqOvoweXyUGkJmVmwIuc3SHuvRWjsg7WyF43+Y1f2BRrAwCzOBrk8iqdzR
	 W1vSxucwMWdpgX2D74HoCkBAZdvgSYRIp7e+jnz4jxNiTh/p29GglWGhayRONCn7ptMIJ
	 AojzNN0iThfBUb9FQ5un+LC4Af0Xf+ER0UP7bahsjUV+g6iXOKb5TWI1Yq6Hhfx9eklk4
	 hP4U5fwI11r8+WYU8mejdA5KKBJmcTtttOaGtfl0u/Os+gwL2ClKHMPHXdodTD3pRhj4K
	 KuHqeG1NpGsDUUqCU2tOT3cHjm1tfT0LARYjvXEFfOGLT02j3zPlkDK4+L7zan8WchQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493328;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=VsbaU0VdjEFE5/Kdiolu0QHc56Ub04+6AJsyszfha5Q=;
	b=zlFwvMB6QSD9PNZqzdYGHPjS2E/w/lvdxhrFoY0aXFkiFH83K0dV86fZjTtyxvLXPEM/
	 cBePGGCLou5sqNC3HN5iG5eufQpAjFo4EOT221gA3o/PSacpAK4SMnmcVZPE9i6eqG3EH
	 E46lNx+grzju98F9GaTEEXj+t7mQnAjlLut+hTueR3uaecVKtsRPqUwC37OVyMeEyeAxQ
	 zWTv2zr2wDVL7O5rQAt1JEjj847MqV5phTKCZ8IR5L6PZjgAfod0WN0GM2+ZWtgjqdLwq
	 QdWE9jHef0BNkyOCNKNGUjowDWEM2ZmjL0po2PuawOSMzNJPkqGbqc/nhbY1M5XB/WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kvj6Uhmx;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFE8606A338
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFE8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kvj6Uhmx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsbaU0VdjEFE5/Kdiolu0QHc56Ub04+6AJsyszfha5Q=;
	b=Kvj6Uhmx0CftacNi8fS11w2+s5+vYOuMOklkfQcL817okxj1BLEXQ5Wx0bxnDrs2S7y03u
	/igaXAem0RanY67EA4+bRDbOFopm14PF8Is+FUroEJEjxZShXK7zfrGslsQ1kCajOGRwjm
	flMBuzKO9F2N5mpB94gS69XuGdt0/A0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83--Z5Wuh_zPUyc0JzRRnv_JA-1; Tue,
 20 Oct 2026 06:48:42 -0400
X-MC-Unique: -Z5Wuh_zPUyc0JzRRnv_JA-1
X-Mimecast-MFC-AGG-ID: -Z5Wuh_zPUyc0JzRRnv_JA_1792493319
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15B921956076;
	Tue, 20 Oct 2026 10:48:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EFBA418;
	Tue, 20 Oct 2026 10:48:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:44 +0400
Subject: [PATCH v7 27/65] hostmem-file: convert OnOffAuto rom property to
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
Message-Id: <20261020-qom-qapi-v7-27-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3017;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iZFd9HvderJ8uRReytwVEg9V/BI0/W9et6yTV5n+0HQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZaUi0I/HhTBoPEm8cGvUR2Ags/oP63+/IJC
 B3aPbt5x/6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5SbrEACzpT4DA3aDgoPm1mkI7LWP4C1/KmFL4+/JVH+4dvDiHK2lfPUcj6g8+5ZAjiaZ7BNg5vr
 GU3ywL52hlZ5JZCn41HMfti/ha4z983dNfIctpiaV9RJU+A22EtAvPLpDEcFPF9PfeB/aMB6a1h
 0Dpk/O8iKpIR0ww2sHYfJ7HC8jqBpBpc5BTWLONeOzWTk3OnFRU6R0c5BPcI6cENi7juVgxXrtZ
 ispq5YrtGrp52pLe3Ewh7Z+QrKyA2oKxwo7jhh3PQ9MQf1Bv4H9XMKBZmivwnir/bT4wnDtabCG
 Z3MBE8QRfPUHzLW7s8idRTcelPr99S0+ZteQGhagDNHrC6CSQMSUQPO7daBJj8bgI/gxraF66d0
 ceIDBeRODFFyp397ZvOHRafc6G41UZt3Q09G/ONGcgNom+1IxZuqlJKhvb2/lhLdZMQFRPNkGAj
 +EpBka/x64Ny38YdXyQE79VKzddpZZLDC1bVdR+/jm4r3s6ujtMANYlwZojYhpW6CGtB8RorWmI
 BzUp4XLCDTQrGR4EZej7rnfAUKzkJ3+sMWrkIk59mZgmLJ5fXSxLqhwExH6OrIEp1ay3QZ15Bhp
 MS3Wp8RSmuhgaHr6i15QnVDly1vb0u60cJvRjNcpvjIEC40XFnirrOV6Qw6AmT4lgBoJx/CvkS4
 b2y0JppmjOhRU9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: _-_SPPjf-A7HFLTEVny_HVWwxASJjXAB3Eaunk_CpSQ_1792493319
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Convert the rom OnOffAuto property from manual visitor-based
callbacks to property_add_qapi_enum().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/hostmem-file.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 7efecf71f565..7d4d52482966 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -19,7 +19,7 @@
 #include "qom/object_interfaces.h"
 #include "qom/object.h"
 #include "qapi/visitor.h"
-#include "qapi/qapi-visit-common.h"
+#include "qapi/qapi-type-infos-common.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendFile, MEMORY_BACKEND_FILE)
 
@@ -230,30 +230,24 @@ static void file_memory_backend_set_readonly(Object *obj, bool value,
     fb->readonly = value;
 }
 
-static void file_memory_backend_get_rom(Object *obj, Visitor *v,
-                                        const char *name, void *opaque,
-                                        Error **errp)
+static int file_memory_backend_get_rom(Object *obj, Error **errp)
 {
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
-    OnOffAuto rom = fb->rom;
-
-    visit_type_OnOffAuto(v, name, &rom, errp);
+    return fb->rom;
 }
 
-static void file_memory_backend_set_rom(Object *obj, Visitor *v,
-                                        const char *name, void *opaque,
-                                        Error **errp)
+static void file_memory_backend_set_rom(Object *obj, int value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(errp, "cannot change property '%s' of %s.", name,
+        error_setg(errp, "cannot change property 'rom' of %s.",
                    object_get_typename(obj));
         return;
     }
 
-    visit_type_OnOffAuto(v, name, &fb->rom, errp);
+    fb->rom = value;
 }
 
 static void file_backend_unparent(Object *obj)
@@ -298,10 +292,13 @@ file_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "readonly",
         file_memory_backend_get_readonly,
         file_memory_backend_set_readonly);
-    object_class_property_add(oc, "rom", "OnOffAuto",
-        file_memory_backend_get_rom, file_memory_backend_set_rom, NULL, NULL);
-    object_class_property_set_description(oc, "rom",
-        "Whether to create Read Only Memory (ROM)");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "rom",
+        .description = "Whether to create Read Only Memory (ROM)",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = file_memory_backend_get_rom,
+        .set = file_memory_backend_set_rom,
+    ));
 }
 
 static void file_backend_instance_finalize(Object *o)

-- 
2.56.0.116.g6de20f6092dc

