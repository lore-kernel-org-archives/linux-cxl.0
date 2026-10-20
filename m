Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493230;
	b=PSbO+QFND8+RDjwSz2VUujXP3WICpgc0jW1RTe/V8ZmBmbphvH4dvpp/xywFOH3vC05w
	 TsNHedAZGp1J7bllhTSqFXHdkbkGWedbvfGoh2DlUjKj5X6DMXJgeO8+WJ9FTe4R3jP3k
	 /ilJ6VUD/LRH9NlLhUHouV2aQ3umYie3r6RlOD1POftNbzCrdztDXfCns2EMMS8VA+t7i
	 LhnF52HTEEJgpoA7uCo+C8Ra4M+borQKCdUERZLV0jghBFz45xLZY22ckfqbEQPQLGzrb
	 byv0tinCaTjE0bjqF6LVKJn0sqYpwBMmm2/ZQ68BH40Xokb5jqcTwftclRNix4TQfTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493230;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=T4Uxxm/AUYAlgWDMQDpSo2oDR3RYBjxEx/nUKW/pClc=;
	b=e+9r4BTlsjqTPdkdHMdGui6mFuKYLlodj5TXF9Z8QLrJhrPYJGDfICgaaTMnRSrTJCWz
	 ynjw07dR9aCm43BzJ713T9OgWOC69/Ph9FNhLQNnY3+IfQrGlpl8+Pk8pAG7wPsnEREqo
	 /abCoFGtZTCUPLrQlaPzF17cpKL4E8GWoI6JvCiaDg9Sf2IqoOFVW/XMJTPvH9E/Jmj8t
	 2CCOOUyPDo9Pk++HUyyRCdfWTKKIAHfGyLSIDLfk0eDzr1O4IEs/uwlvvhhKsWWlgtA03
	 5xPl7XASW3/8FR1SCzjNCkMYRZEyR1epQcr3y2JRqPm+rGqfLHOVpiANqZNA6sIoO2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E2K2radM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AC606A31B
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC5AC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E2K2radM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4Uxxm/AUYAlgWDMQDpSo2oDR3RYBjxEx/nUKW/pClc=;
	b=E2K2radMdsPv/z5GuiUEacMLRQoFsy5QmnWbthuXZ0n750dz3TFMAedfzKGMnNSRjpPgAW
	AnKvUmnIUzisbHGnH3jWfxQVBxyuiWFhyeUJsgV2At+pcHWUXzQQWBywC/LAibKbd99pRv
	ZTTW1RtdOKuzzARm6TKQYLirxhpIuh8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-Q9FEb42bMfer0z7ZaConTg-1; Tue,
 20 Oct 2026 10:46:57 +0000
X-MC-Unique: Q9FEb42bMfer0z7ZaConTg-1
X-Mimecast-MFC-AGG-ID: Q9FEb42bMfer0z7ZaConTg_1792493213
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9809D1954B20;
	Tue, 20 Oct 2026 10:46:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2267C1800444;
	Tue, 20 Oct 2026 10:46:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:24 +0400
Subject: [PATCH v7 07/65] qapi: add QAPITypeInfo struct definition
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-7-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ncAoduk+W++XsQQC6jhXGd6nHnXr1eyWDznZbZI1kq8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYgCKdk47hapDm+FojdwVHdZciBcCELJvB+
 Yw7agAaZi2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5T9oD/9GpeJFOttXk8RI55B118B4xUvL1oaf8Lo8kCm7RluwGbnLkgkEWk3zfL95zz4jtUJwnKQ
 LkI/5HSvCywgfyFPEHSeLsTL1fdJsoyRVHSZu5kn7dXrnfwQt03BqXsZoGPyzgJ4O6dtOX+WHQ/
 p6v8cw5FjgYcyrcGkoZL25m8291Qj+cifHCodAv8D8Pwc/O0TMY9tcXyBGixECq8bhC05GlyiFL
 1HahUKZPfY5wzXAb1ZpI5IG4ebak9SIACrEGavNNow/2pr7YKP9Dv4SiziC+P1lhVrmELQbxRok
 HGAL/k9Se+GdzyvbmuU0S5/R4GZNAkxqR3Zt8oy+8jyDYnlw8M9s/RPqgkS98TF1jpcFKlp/7EA
 YNW4QBcSGFwWOBrSYO2580wx+fB01GWAv5Oxz3vyKBSQyKgmF04H7rB9l2vKNMWnxKRzNqjbmXt
 8EvxF5m5VzSm7Pv1Y7jp9cZ/hGY7hDy84syz2Amn5jd7IFzuDgcyRV5G0EZQisXAao1ed7uWeCA
 rdKBAJUAVv0WyiAVn5qgDoZcqgLGp/vBung/13PF3FFVyJdvO3llipzkXBwaLeKpimriCvSA0ag
 eO9DfBCSkrhnJUIyeTawq6BHzOMEOc9xWB+Mubdj/bUzMsWXWGu7MXSGR9kP+1Nkw0P1SbqEYCO
 SE+11f2XzLE52rQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: kljEEH07WBL_doePhkvxIM8brOuHQSBrtp8qrc4dZuU_1792493213
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Introduce a minimal struct that pairs a QAPI type's internal name with
its "masked" introspection name. Generated constants of this type will
let QOM property registration carry a reliable reference to the QAPI
schema and possibly other associated data.

The fields are populated in following commits.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qapi-type-info.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/qapi/qapi-type-info.h b/include/qapi/qapi-type-info.h
new file mode 100644
index 000000000000..6a6355568325
--- /dev/null
+++ b/include/qapi/qapi-type-info.h
@@ -0,0 +1,31 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QAPI_TYPE_INFO_H
+#define QAPI_TYPE_INFO_H
+
+#include "qapi/util.h"
+
+/**
+ * QAPITypeInfo - QAPI type metadata
+ *
+ * @name: QAPI type name (e.g. "str", "OnOffAuto", "int32List").
+ *        QOM uses this as the property type string.
+ * @masked_name: Name of the type in the QAPI introspection schema, assigned by
+ *        scripts/qapi code generator (e.g. "368").
+ * @lookup: QEnumLookup for this type, or NULL for non-enum types.
+ *        visit_type_enum(), qapi_enum_parse(), and qapi_enum_lookup()
+ *        all rely on it.
+ * @list: The list-type counterpart, or NULL if none exists.
+ *        str_type_info.list points to strList_type_info.  qdev array
+ *        properties follow this to find the list type for their element.
+ */
+typedef struct QAPITypeInfo {
+    const char *name;
+    const char *masked_name;
+    const QEnumLookup *lookup;
+    const struct QAPITypeInfo *list;
+} QAPITypeInfo;
+
+#endif /* QAPI_TYPE_INFO_H */

-- 
2.56.0.116.g6de20f6092dc

