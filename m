Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493255;
	b=oMu8uSeRZ0zhRhVmrTm8YWFpE7V6kiQxVgHNy97bzZdWTfVoayYetAgxzXB10k56SAXw
	 3H3VZJScJKBbbbWntPiZMitFdZ6qaJgmkMyopjEXSHpbCNbRIkWkCKPvZiFcuwGNtylPf
	 sn4wFS90lxQR13L2jizNzH9FU4Q+2EDwU04QlxoN2iVReoWGQYlHejHh28xjQyCN61Y83
	 ZqFRpuXdru4uvhJ1h6aFbGs8cU4/mdiLPdUtPAjU2NSCm+x18jZjfP+fxTYHVHzN2rPi/
	 ejPUmqaYu1X064DMhpzkA2xT9N+iJ24GD75+UfksYOahiw567rwK88wMrxaXlbNmNow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493255;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=PVXTIIpNbgnr5AJ+/yIbBcdA8eA5b8YMHg0i2cYvT44=;
	b=hvDrAhAjQv0hnf9Z3vltQizsq/+hL0RdezHJkdxLwsDBKWKQcYDqd8S3vXltsRiMFZdI
	 4ahIyUCqsMdoQu3xQs9rQASwYbCYVUiBCeDQYT40Fr30s0nhfToQ9SQkFq/MMVZUVTZT3
	 6f/2CwrX2S+pqk5cz8NtcVx0VtLk8VAV6VZYDCPIkZRE2L+aLEnctcVyZmx1fsWHR5KXq
	 RsCqMNazRTVNxsUiZRRSqUi9t9F8KKHCJkzqgGKOWP2ejb7WWDLvHvUeT+MRiG8uI/G+1
	 QdIF5GqAZYxiQBo/J2quTxkEWISSicsoIRsA9gLEcu7Wm2HQnrabiriDw2Cn43aw6aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bfRz6xW2;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA53606A31F
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA53606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bfRz6xW2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVXTIIpNbgnr5AJ+/yIbBcdA8eA5b8YMHg0i2cYvT44=;
	b=bfRz6xW2zwnHONGOa4IXU0k+aTAGHPvJk9VglT/XM2rFUaP11H953AC+XqHMLR2WBqoIns
	eQl0pk+Qne/h5xPV7Pz//i/uD/03go+xSU1SLyb6HjlwhmqJtWJB9TfQ9AwVX0lTRpBWzE
	VXgxXd7QbkmaetTL3FMWGcsvX4A2+r0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-QIWQbiQEOjKXo9XLY2S_-Q-1; Tue,
 20 Oct 2026 10:47:30 +0000
X-MC-Unique: QIWQbiQEOjKXo9XLY2S_-Q-1
X-Mimecast-MFC-AGG-ID: QIWQbiQEOjKXo9XLY2S_-Q_1792493246
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A06391800846;
	Tue, 20 Oct 2026 10:47:26 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26A6630000E7;
	Tue, 20 Oct 2026 10:47:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:30 +0400
Subject: [PATCH v7 13/65] qom/qmp: populate qapi-type in QMP handlers
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-13-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=i+4aNg1CWaC9FuQwQPBmrQeBSkYvF4PheLxhenOOFfo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZYDWzReLBw3m81dGDIXbwzl9a7/x3QA+lLt
 YiL2TIXOxiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWAAKCRDa6OEJdZac
 5SUfD/wJNBGKtLromvCCVRWVjPvxR5grgFUIPYxITDg41xmOLrKqK6tkYNGmFOZFpRXvHXGYvRQ
 TdQmUahRaSDpeuJbFcaYT73xbCCqya8tVq8EmWAT5UeRvgtVrubv+XmDarrnryY02yLXvkIPllC
 xD258e/Sa+caea6AEZbydm8puSKag8kjyvK+G/zuYF1znKnI8eJxFrc3NH2jpHB6n9mLR5rzuys
 KpmuOkIz/+997QlgvghfOc9I5oUvG09YZbw98d4FxVxtx5ARqn/Vp/by4sa4tu2Tu0k6JWoMyR2
 FLbIEl5NmPd/Vzzo8e0e2s7lkcsZEaa6+6GDVtgr3zcY0ceNHCAlZDAcuV2JumnHEjgGHaGDC3j
 m73n3AS2hBEShtU728GRRbYOuf5ZVmV0IHuJrD2XWVTkdWBtjjOKsTKqGgmguNhjUQn/iZ1XRs6
 AwFiABH4kHoVozldkVrlbvXe7p5VFD4ze0fzu1PCDur+7/Ays4XczNXKWN1fQ5u2ZNLW5LYbfg+
 ljEVnbaU+fg2V7agpnwf/IswI8Aw7S6ja3o33R2iu3N6LeX5VdqV5qtUy9mRVydHeEJii8A9+vl
 Yd8aU3wBZlxTyloC0tuExCV6B9nUqFz84SN6C4Bl11QPGw0u4G9nKK1ivmRDCOq3WPxaOAUae2j
 TUSTCHbBFtRj1ig==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: wYukrzTsvzZ-dqWBWbBnjaLrXJCh4i2QtskE8-CTLDw_1792493246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Wire up the new qapi-type field in all four QMP handlers that return
ObjectPropertyInfo or ObjectPropertyValue: qom-list, qom-list-get,
device-list-properties, and qom-list-properties.

When an ObjectProperty has a qapi_type set, the masked QAPI type name
is copied into the response, allowing clients to cross-reference with
query-qmp-schema.

No property has it yet, the following changes will populate it.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/qom-qmp-cmds.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index f17389c7305c..47bf3bf2937a 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -25,9 +25,23 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
+#include "qapi/qapi-type-info.h"
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
 
+static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
+{
+    ObjectPropertyInfo *info = g_new0(ObjectPropertyInfo, 1);
+
+    info->name = g_strdup(prop->name);
+    info->type = g_strdup(prop->type);
+    if (prop->qapi_type) {
+        assert(prop->qapi_type->masked_name);
+        info->qapi_type = g_strdup(prop->qapi_type->masked_name);
+    }
+    return info;
+}
+
 static Object *qom_resolve_path(const char *path, Error **errp)
 {
     bool ambiguous = false;
@@ -58,12 +72,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *value = g_new0(ObjectPropertyInfo, 1);
-
-        QAPI_LIST_PREPEND(props, value);
-
-        value->name = g_strdup(prop->name);
-        value->type = g_strdup(prop->type);
+        QAPI_LIST_PREPEND(props, qom_property_info(prop));
     }
 
     return props;
@@ -78,6 +87,10 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
 
     item->name = g_strdup(prop->name);
     item->type = g_strdup(prop->type);
+    if (prop->qapi_type) {
+        assert(prop->qapi_type->masked_name);
+        item->qapi_type = g_strdup(prop->qapi_type->masked_name);
+    }
     item->value = object_property_get_qobject(obj, prop->name, NULL);
 }
 
@@ -241,9 +254,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        info = g_new0(ObjectPropertyInfo, 1);
-        info->name = g_strdup(prop->name);
-        info->type = g_strdup(prop->type);
+        info = qom_property_info(prop);
         info->description = g_strdup(prop->description);
         info->default_value = qobject_ref(prop->defval);
 
@@ -284,11 +295,8 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info;
+        ObjectPropertyInfo *info = qom_property_info(prop);
 
-        info = g_malloc0(sizeof(*info));
-        info->name = g_strdup(prop->name);
-        info->type = g_strdup(prop->type);
         info->description = g_strdup(prop->description);
         info->default_value = qobject_ref(prop->defval);
 

-- 
2.56.0.116.g6de20f6092dc

