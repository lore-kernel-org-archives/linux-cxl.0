Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493262;
	b=wD3BCMhivdx/oK66awqpw6lAMF1Grb2f1o6JWFtcNBSE3YsEOIzu0eCNUoahVnzpugqj
	 i7HrMPva5Q7tuDFMYk0aDKeu8L98AoNQKy68s4V/Ebi16W+OYxgpzWXgcDE/9J5jJ9+Kx
	 I2EJCEKKGwBz1Xn38V398U11GtcwdJQoBlg9Jvnff5Sa2xjPNelFRBX3mbdHLe1ivCgjl
	 WbUMriDyPSv9EC9XoOPZ1wAwXsPy6GGbTvPr0ZH6mR34BYI8kHBb8mEgP2IN/EDahdb1o
	 gp5LczGMvuR6V+CfOQmA2z39HRCWCPZWGpqlkr1vBEDud8gSQQ5VIrzt8rHD5AB8V3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493262;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=xIOxZR09tVRL3LoeQ2VRl9bxdzxaCKN+MMqdzDBpGyw=;
	b=rbSaumqaeh8zPh4iEN0kfJR4vfRihvRnIA0S0O5bHlJLnJgkNmomi0Ll6M2JR9uvx2OA
	 /XWux1X/PcinZ9evFyco9jmFqptrMPSxXOovM1sV+HvVINwSiuQVELg9dEjFxJ3vRWiOT
	 eQ8WIxuX6LOL25lRjFE1PdV+KQlgcxVEcH80q8IRMACUS7PTDDRm9MOsia4v/Z3/gs/5A
	 Ow5cPTj5h8AhYiRheu4v+4D4v2dnPh+KLn3d5FY+0K2FPD20F3dRTILXQiu3L4Wzpb/b/
	 2YoDODXB7ssJpotzMBBiQH9eoq+1JZDgSjwM+M16fROPMZnNxyyCIV7Zw2fyRzm3B8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nqpux2kp;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA5606A31B
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75FA5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nqpux2kp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIOxZR09tVRL3LoeQ2VRl9bxdzxaCKN+MMqdzDBpGyw=;
	b=Nqpux2kpS03yMCCBpdmXkNo+L7YZowmm1957oBXP8uS4zWvl7XFabJyOclV13Tdoq2x7gy
	ULvT75aynkCgAIK+CnhUpxpRJ982xNvp3gmwPMmzG7tLnToWK1Jwx9pvYUnKlCvKfcVxpu
	wYzUuS0G+nPongi1ecI5on6T7mJ4SPM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-ofFqrjFmNVuI0_Rhk-bdPQ-1; Tue,
 20 Oct 2026 10:47:36 +0000
X-MC-Unique: ofFqrjFmNVuI0_Rhk-bdPQ-1
X-Mimecast-MFC-AGG-ID: ofFqrjFmNVuI0_Rhk-bdPQ_1792493252
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6E151955F2B;
	Tue, 20 Oct 2026 10:47:31 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B32B31956089;
	Tue, 20 Oct 2026 10:47:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:31 +0400
Subject: [PATCH v7 14/65] qom/qmp: populate description & default-value in
 qom_property_info()
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-14-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uHhhGddxQUOPXHn3kN1zjJ5emGyO+zAsacCmEIp7fMU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYLHL/+jjl6D3jfhu6YY8r0v/h+oK3dZuqT
 ezvQZmL6dCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5aAaD/48dANrC6kyut3XOROjrQRxjwUIv0i0xWNW1n7ucgCFOO9+fWLOIuRBmElFO8tK1LUW7VK
 /cncnMEOpfNGGxBqlK4/E7MLLWxcEJ5PONbxrrynUEl5/6iktSG9+p0FbZ+69Ig8sBSWsaKMfX/
 TjixcX9RrpcR4kM6W9+KDi3doDCw2opXnVXJs1dfbDHber2cptUgcPZg2klCeonD69YCtbh4E9V
 frLj2F6fhDEwXovHE9dmaAYXrx4MUlWNnWXF7Ghho/OQ4AT803/e68yxS2d9vGvR6oW5buPzIu1
 mlrM9vteISWAcBit+HYHv2uAYbAEKeadp5Ifyen2Y9sH0dNkfWUPOKHL3vno7uRTfS18hxD4e86
 26PatMtqKUJup7iwHq5V9QigizN31NfbU5AoBe12vGQ+E4qUTFiii1meZ1Syaz0HEsBut5DlGZB
 jKTxA5YXNzKXzh2gMr+EtfsPvTLms/u/oHjnzmZgwDvCIzLlT/lSl87AwFbhpHDBguQjcfTQ0Mg
 K1VhLdp03W/CZAUX9UALGzwbqu8DJbYjRo9rTfwd+PDdexNm4+dmZiWa48aQpfFwu3KSXV4xnXK
 BbNdAPMgYnoyiVVLq2Hy2zHqhvba3qJkOIDNjbbdfwMBrbGOpIDzaSUIS939LVbTmE62eCGjZ/p
 HPrxdrpQOIPKiOQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: gZspJiObh8ZtvTm603ZrfPWkZ1tvZAZAObFwiqQyODM_1792493252
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Move description and default_value population from the individual QMP
handlers into qom_property_info(), so all callers get them.

This also adds description and default-value to qom-list responses,
which previously only returned name and type. The handler doesn't care.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/qom-qmp-cmds.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 47bf3bf2937a..84a295905148 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -35,6 +35,8 @@ static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
 
     info->name = g_strdup(prop->name);
     info->type = g_strdup(prop->type);
+    info->description = g_strdup(prop->description);
+    info->default_value = qobject_ref(prop->defval);
     if (prop->qapi_type) {
         assert(prop->qapi_type->masked_name);
         info->qapi_type = g_strdup(prop->qapi_type->masked_name);
@@ -243,8 +245,6 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info;
-
         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") == 0 ||
             strcmp(prop->name, "realized") == 0 ||
@@ -254,11 +254,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        info = qom_property_info(prop);
-        info->description = g_strdup(prop->description);
-        info->default_value = qobject_ref(prop->defval);
-
-        QAPI_LIST_PREPEND(prop_list, info);
+        QAPI_LIST_PREPEND(prop_list, qom_property_info(prop));
     }
 
     object_unref(obj);
@@ -295,12 +291,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info = qom_property_info(prop);
-
-        info->description = g_strdup(prop->description);
-        info->default_value = qobject_ref(prop->defval);
-
-        QAPI_LIST_PREPEND(prop_list, info);
+        QAPI_LIST_PREPEND(prop_list, qom_property_info(prop));
     }
 
     object_unref(obj);

-- 
2.56.0.116.g6de20f6092dc

