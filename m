Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493481;
	b=hFb1DrcPFSKttokCAcnIUMqOXitDP/x9/tL4zsDxZwCqF2UOmF3THxxBmmjRGo5Yk0Ka
	 18qaZexMBLdLvohtb+FqHF75zIaG4ifc0nT9VuO84GeOBsgGHjdQTUKlt9J/3fQFRsaf+
	 8uUi8t/XkWepZ68xGR1I7TyFelFcdCLR/FnLZk+ULX0O5bpS3+26BGB1Y7E0xiIasC6uz
	 baz/Oyu9Cbg8IyrQQT3/komoF6Cu2VtwxSX+dTwqhXSo96Nb9MxanBE0QgITEjXAfRvbk
	 XV73a2ByXKVL7CPLNMEeDhT/sW/ORKSI7bXbLDlnaRKHIBd42jBpi2m+mQXOwGasnXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493481;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=kVlgXy2vPG5I3mKp16fhq+bJb3obYLJd/3IFPjDdE9g=;
	b=gqXsWtBtieGqlo1WxIL04YvX1vByXFNapZVLVZWoup5ypPfO2ppfLHRKenMG/wBCOQbz
	 ZqavxCzXvLP6h3Bm6kiXqENoJV1IodbG785uNay8uY14cCC+TFR/H0nk4133OnGgZm3+A
	 KokrTovqcnxQ3HOx28/9GOpBgeiYmyOt7dKlJKGAyXdnw6J0Otp0NBMddJDXqwZwS3c4n
	 cUXAnI1oMx5ml5bX6Mz1PlknJ7droi9LF0YEXeySWi5XQRMS/FJBfawUKKiuh0OX/cODt
	 AOlkEKGtA6b8aRnWuneGBCEE2FFnbVlop7CHNxzigiI0PYJogp01TMRLIJC4eVfNCCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=it9mQHG8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739E606A323
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D739E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=it9mQHG8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVlgXy2vPG5I3mKp16fhq+bJb3obYLJd/3IFPjDdE9g=;
	b=it9mQHG8/Hecad+OF2JbP33N0MnUEh+3qV/6Ypfcl+Ie/ekolDrOWTakhhpOfRyL0mtvHz
	4v0Zo/Vhm8agwUj/wIoKbqx20bAoJVN18Kv84KrljpPYKTYYwP5ZcZcnyp2YlUa7LKhbjE
	7tauaez4gchNju4TUNgpRN75dS/nlDc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-wpfby2pGOJyKwLe7dRoy5g-1; Tue,
 20 Oct 2026 10:51:16 +0000
X-MC-Unique: wpfby2pGOJyKwLe7dRoy5g-1
X-Mimecast-MFC-AGG-ID: wpfby2pGOJyKwLe7dRoy5g_1792493472
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59F701956058;
	Tue, 20 Oct 2026 10:51:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E20D1956088;
	Tue, 20 Oct 2026 10:51:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:12 +0400
Subject: [PATCH v7 55/65] qdev: convert system PropertyInfo definitions to
 use qapi_type
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261020-qom-qapi-v7-55-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16488;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bKJiGjLc93NMNQe/axyuBXbCYEzkRfYsjB6tY47k/ME=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZcE6NcoIi2kkZhgPlwo4cwnMvIG9Khmkeki
 3B164oT25KJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5X4UD/oDIy4uzsDDKJ07Mwj4Le45Vv+5f8w9BOVeka0VijEf6x5pFmvuYTSqEfaovLHlXgeSaEI
 zRulvXe5KuGodBABZfg89LkkU5r2EBsPvVQVTz36tFtr/RA9tZ5OtkaUG4KoKgg1D84YjYZBKYC
 Dk7TuM+jRsDKwGYy9VsZ8RbLtkeZYVkKQ47Ekt/kYAgAbfRS6HL0GjcKqnMhKmZy4bFDxIEZtzd
 0Zxv6JkIMu/i85FepDnytt2YCwhT6mvnL2ScEExHqyED7UcBzuU9VNMIEQSEAubvjd+MjJTK3RI
 5q04XcpN4cpum2fvygKb8Trpj87BED6uoFvqmN48XHYwvPraPB3A8R9QYjPirdeq2e7K8SiblBq
 vliHBphsgAVgdcD1TuoFYOjqePJRz6v/Y/2M5pEg4m/MUBMWxvgP+O1qKuanj4WpOpXOG6xMlj9
 pPUbKIIOtP6V1WUU7l5JRxfNPSGI4nhqjUO6LuQAwQWZE1zl+QKxMNgfWZledVaSyNLWWxAwHnO
 PHlyxs6OELk7p+QbfVeRnCQExc9dguQA8maKFafKmWIv91WwQ5KyX7D0OKHowXAosPoJ38fqbha
 5UVZ5QSnmbDWHl/Qu80RjzcHcFsVx39BDAbueT4Ue3krKr40/8NsJQcY3lboVJN0DEmse+TPH0o
 9Mdq/H0L6fXU0Cg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: nidsr89RmbN44WTO1rWwpql5xiy8G09QlmhSNpJ551U_1792493472
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Replace .type string and .enum_table pointer with .qapi_type in all
PropertyInfo definitions in qdev-properties-system.c

Update file-private enum accessor functions to use .qapi_type->lookup
instead of .enum_table.

Note, this should be a faithful conversion, but it would be worth to
consider better types than just "str" for references (block node names,
chardev/netdev IDs, MAC addrs, etc)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-prop-internal.h     |  2 +
 hw/core/qdev-properties-system.c | 93 +++++++++++++++++-----------------------
 hw/core/qdev-properties.c        |  2 +-
 3 files changed, 43 insertions(+), 54 deletions(-)

diff --git a/hw/core/qdev-prop-internal.h b/hw/core/qdev-prop-internal.h
index d7b77844fe0b..c190b7b88cf4 100644
--- a/hw/core/qdev-prop-internal.h
+++ b/hw/core/qdev-prop-internal.h
@@ -8,6 +8,8 @@
 #ifndef HW_CORE_QDEV_PROP_INTERNAL_H
 #define HW_CORE_QDEV_PROP_INTERNAL_H
 
+const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info);
+
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp);
 void qdev_propinfo_set_enum(Object *obj, Visitor *v, const char *name,
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 3381de1144d6..8819a9a0b748 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -27,6 +27,7 @@
 #include "qemu/uuid.h"
 #include "qemu/error-report.h"
 #include "qdev-prop-internal.h"
+#include "qapi/qapi-type-infos.h"
 
 #include "qemu/audio.h"
 #include "chardev/char-fe.h"
@@ -238,7 +239,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_drive = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as a backend",
     .realized_set_allowed = true,
     .get   = get_drive,
@@ -247,7 +248,7 @@ const PropertyInfo qdev_prop_drive = {
 };
 
 const PropertyInfo qdev_prop_drive_iothread = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Node name or ID of a block device to use as a backend",
     .realized_set_allowed = true,
     .get   = get_drive,
@@ -315,7 +316,7 @@ static void release_chr(Object *obj, const char *name, void *opaque)
 }
 
 const PropertyInfo qdev_prop_chr = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of a chardev to use as a backend",
     .get   = get_chr,
     .set   = set_chr,
@@ -389,7 +390,7 @@ inval:
 }
 
 const PropertyInfo qdev_prop_macaddr = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Ethernet 6-byte MAC Address, example: 52:54:00:12:34:56",
     .get   = get_mac,
     .set   = set_mac,
@@ -477,7 +478,7 @@ out:
 }
 
 const PropertyInfo qdev_prop_netdev = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of a netdev to use as a backend",
     .get   = get_netdev,
     .set   = set_netdev,
@@ -514,7 +515,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
 }
 
 const PropertyInfo qdev_prop_audiodev = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "ID of an audiodev to use as a backend",
     /* release done on shutdown */
     .get = get_audiodev,
@@ -584,7 +585,8 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
     int *ptr = object_field_prop_ptr(obj, prop);
     int value;
 
-    if (!visit_type_enum(v, name, &value, prop->info->enum_table, errp)) {
+    if (!visit_type_enum(v, name, &value,
+                         qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -604,9 +606,8 @@ static void qdev_propinfo_set_losttickpolicy(Object *obj, Visitor *v,
 QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
 
 const PropertyInfo qdev_prop_losttickpolicy = {
-    .type  = "LostTickPolicy",
+    .qapi_type = &LostTickPolicy_type_info,
     .description = "Policy for handling lost ticks (discard/delay/slew)",
-    .enum_table  = &LostTickPolicy_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_losttickpolicy,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -631,7 +632,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_blocksize = {
-    .type  = "size",
+    .qapi_type = &size_type_info,
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
     .get   = qdev_propinfo_get_size32,
@@ -644,9 +645,8 @@ const PropertyInfo qdev_prop_blocksize = {
 QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) != sizeof(int));
 
 const PropertyInfo qdev_prop_blockdev_on_error = {
-    .type = "BlockdevOnError",
+    .qapi_type = &BlockdevOnError_type_info,
     .description = "Error handling policy (report/ignore/enospc/stop/auto)",
-    .enum_table = &BlockdevOnError_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -657,10 +657,9 @@ const PropertyInfo qdev_prop_blockdev_on_error = {
 QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) != sizeof(int));
 
 const PropertyInfo qdev_prop_bios_chs_trans = {
-    .type = "BiosAtaTranslation",
+    .qapi_type = &BiosAtaTranslation_type_info,
     .description = "Logical CHS translation algorithm "
                    " (auto/none/lba/large/rechs)",
-    .enum_table = &BiosAtaTranslation_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -669,9 +668,8 @@ const PropertyInfo qdev_prop_bios_chs_trans = {
 /* --- FDC default drive types */
 
 const PropertyInfo qdev_prop_fdc_drive_type = {
-    .type = "FloppyDriveType",
+    .qapi_type = &FloppyDriveType_type_info,
     .description = "Floppy drive type (144/288/120/none/auto)",
-    .enum_table = &FloppyDriveType_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -680,10 +678,9 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 /* --- MultiFDCompression --- */
 
 const PropertyInfo qdev_prop_multifd_compression = {
-    .type = "MultiFDCompression",
+    .qapi_type = &MultiFDCompression_type_info,
     .description = "multifd compression method"
                    " (none/zlib/zstd/qpl/uadk/qatzip)",
-    .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -694,9 +691,8 @@ const PropertyInfo qdev_prop_multifd_compression = {
 QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_mig_mode = {
-    .type = "MigMode",
+    .qapi_type = &MigMode_type_info,
     .description = "Migration mode (normal/cpr-reboot)",
-    .enum_table = &MigMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -707,18 +703,16 @@ const PropertyInfo qdev_prop_mig_mode = {
 QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_granule_mode = {
-    .type = "GranuleMode",
+    .qapi_type = &GranuleMode_type_info,
     .description = "Granule page size (4k/8k/16k/64k/host)",
-    .enum_table = &GranuleMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 const PropertyInfo qdev_prop_zero_page_detection = {
-    .type = "ZeroPageDetection",
+    .qapi_type = &ZeroPageDetection_type_info,
     .description = "Zero page detection (none/legacy/multifd)",
-    .enum_table = &ZeroPageDetection_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -729,9 +723,8 @@ const PropertyInfo qdev_prop_zero_page_detection = {
 QEMU_BUILD_BUG_ON(sizeof(SsidSizeMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_ssidsize_mode = {
-    .type = "SsidSizeMode",
+    .qapi_type = &SsidSizeMode_type_info,
     .description = "ssidsize mode: auto, 0-20",
-    .enum_table = &SsidSizeMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -742,9 +735,8 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
 QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_oas_mode = {
-    .type = "OasMode",
+    .qapi_type = &OasMode_type_info,
     .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
-    .enum_table = &OasMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -824,7 +816,7 @@ out:
 }
 
 const PropertyInfo qdev_prop_reserved_region = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "Reserved Region, example: 0xFEE00000:0xFEEFFFFF:0",
     .get   = get_reserved_region,
     .set   = set_reserved_region,
@@ -904,8 +896,7 @@ static char *print_pci_devfn(Object *obj, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_pci_devfn = {
-    /* The formatted string accepted by the setter is a CLI convenience. */
-    .type  = "int32",
+    .qapi_type = &int32_type_info,
     .description = "Slot and optional function number, example: 06.0 or 06",
     .print = print_pci_devfn,
     .get   = qdev_propinfo_get_int32,
@@ -1011,7 +1002,7 @@ inval:
 }
 
 const PropertyInfo qdev_prop_pci_host_devaddr = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "Address (bus:device.function) of "
                    "the host device, example: 04:10.0",
     .get = get_pci_host_devaddr,
@@ -1021,9 +1012,8 @@ const PropertyInfo qdev_prop_pci_host_devaddr = {
 /* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
 
 const PropertyInfo qdev_prop_off_auto_pcibar = {
-    .type = "OffAutoPCIBAR",
+    .qapi_type = &OffAutoPCIBAR_type_info,
     .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
-    .enum_table = &OffAutoPCIBAR_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1062,7 +1052,8 @@ static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &speed, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &speed,
+                    qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
@@ -1072,8 +1063,8 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     PCIExpLinkSpeed *p = object_field_prop_ptr(obj, prop);
     int speed;
 
-    if (!visit_type_enum(v, name, &speed, prop->info->enum_table,
-                         errp)) {
+    if (!visit_type_enum(v, name, &speed,
+        qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -1103,9 +1094,8 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_speed = {
-    .type = "PCIELinkSpeed",
+    .qapi_type = &PCIELinkSpeed_type_info,
     .description = "2_5/5/8/16/32/64",
-    .enum_table = &PCIELinkSpeed_lookup,
     .get = get_prop_pcielinkspeed,
     .set = set_prop_pcielinkspeed,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1147,7 +1137,8 @@ static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
         abort();
     }
 
-    visit_type_enum(v, name, &width, prop->info->enum_table, errp);
+    visit_type_enum(v, name, &width,
+                    qdev_propinfo_enum_lookup(prop->info), errp);
 }
 
 static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
@@ -1157,8 +1148,8 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
     PCIExpLinkWidth *p = object_field_prop_ptr(obj, prop);
     int width;
 
-    if (!visit_type_enum(v, name, &width, prop->info->enum_table,
-                         errp)) {
+    if (!visit_type_enum(v, name, &width,
+                         qdev_propinfo_enum_lookup(prop->info), errp)) {
         return;
     }
 
@@ -1191,9 +1182,8 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_pcie_link_width = {
-    .type = "PCIELinkWidth",
+    .qapi_type = &PCIELinkWidth_type_info,
     .description = "1/2/4/8/12/16/32",
-    .enum_table = &PCIELinkWidth_lookup,
     .get = get_prop_pcielinkwidth,
     .set = set_prop_pcielinkwidth,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1241,7 +1231,7 @@ static void set_default_uuid_auto(ObjectProperty *op, const Property *prop)
 }
 
 const PropertyInfo qdev_prop_uuid = {
-    .type  = "str",
+    .qapi_type = &str_type_info,
     .description = "UUID (aka GUID) or \"" UUID_VALUE_AUTO
         "\" for random value (default)",
     .get   = get_uuid,
@@ -1254,9 +1244,8 @@ const PropertyInfo qdev_prop_uuid = {
 QEMU_BUILD_BUG_ON(sizeof(S390CpuEntitlement) != sizeof(int));
 
 const PropertyInfo qdev_prop_cpus390entitlement = {
-    .type  = "S390CpuEntitlement",
+    .qapi_type = &S390CpuEntitlement_type_info,
     .description = "auto/low/medium/high (default medium)",
-    .enum_table  = &S390CpuEntitlement_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1299,7 +1288,7 @@ static void release_iothread_vq_mapping_list(Object *obj,
 }
 
 const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
-    .type = "IOThreadVirtQueueMappingList",
+    .qapi_type = &IOThreadVirtQueueMappingList_type_info,
     .description = "IOThread virtqueue mapping list [{\"iothread\":\"<id>\", "
                    "\"vqs\":[1,2,3,...]},...]",
     .get = get_iothread_vq_mapping_list,
@@ -1310,18 +1299,16 @@ const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
 /* --- Endian modes */
 
 const PropertyInfo qdev_prop_endian_mode = {
-    .type = "EndianMode",
+    .qapi_type = &EndianMode_type_info,
     .description = "Endian mode, big/little/unspecified",
-    .enum_table = &EndianMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
 const PropertyInfo qdev_prop_vmapple_virtio_blk_variant = {
-    .type  = "VMAppleVirtioBlkVariant",
+    .qapi_type = &VMAppleVirtioBlkVariant_type_info,
     .description = "unspecified/root/aux",
-    .enum_table  = &VMAppleVirtioBlkVariant_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
@@ -1364,7 +1351,7 @@ static void release_virtio_gpu_output_list(Object *obj,
 }
 
 const PropertyInfo qdev_prop_virtio_gpu_output_list = {
-    .type = "VirtIOGPUOutputList",
+    .qapi_type = &VirtIOGPUOutputList_type_info,
     .description = "VirtIO GPU output list [{\"name\":\"<name>\"},...]",
     .get = get_virtio_gpu_output_list,
     .set = set_virtio_gpu_output_list,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index abdb380cb9ec..a9abc646d5d7 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -101,7 +101,7 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
     return info->set ? field_prop_set : NULL;
 }
 
-static const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
+const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
 {
     if (info->qapi_type) {
         assert(info->qapi_type->lookup);

-- 
2.56.0.116.g6de20f6092dc

