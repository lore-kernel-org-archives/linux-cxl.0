Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493491;
	b=fEBBxNd4tUstii/2G3hp2/B21xoaWJPCX4gMjrz8jUdvE6wwHW8qeaBqNllwHByoXft1
	 pzBr+P7ImhZl0srFA2Tp8UF8J/6XX1hOHBB+aQ6kztzrr3j9sw2ATrRAdXx3QBvc1Hgp6
	 7/FGcSqGSb89H2pSLa4zrgVnKd42fSJXcp2tCbK5G5QbudVgP1KvMBwfuJxtUiNPlTl3Q
	 k/eSVHdY7sB4q85Da6vz2/Kkk3/6WDjTJ9DqY1OOIwlWQCdhjlzQYIVLUdIoOcZdt/rfJ
	 9pCsj/yzPYr2JEIvybpuUz9RFG2JVk3G5k2tuoGGVoGoeO1XwM8oqLM7imnIGvSDIpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493491;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=0exBW/XllTPTbSwFohqKA2w8apHuJMdvUCko9RJ056E=;
	b=ImNgXI9cZFNphRqWgXlpal3qChL4NR1Rk3zJV/L8dSQsJ/z2bXuiP8uxrx2Gck9dgiqW
	 eCmsWESgXxUVAM3jIzP0ocapAxqqDM5ykEblhFgU/q6zJMosadyope9C6/vAcOf3BDFd3
	 a+cdI6/s/oBjtWVY3XdmiVn0tu0au+6pGvGKaEsYPKfd7WNYFbX7Nj/1ylmsYpb9cbUz0
	 HmPqgIcKcaJoiwEAxa+wlzTUJBkL5yXw6mVVS2JQapb4SWxKwwXhWKzTv5UdzTgR2WCMQ
	 3v1ExsH0JPByCwHvpwQmp8WvAOmy5XKlx49StEHdJBQno747NjPI5ZgkDBscZCeIygA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pma88dWq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A731606A335
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A731606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pma88dWq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0exBW/XllTPTbSwFohqKA2w8apHuJMdvUCko9RJ056E=;
	b=Pma88dWqnTmc4FPmMNkYkgNUTRvQZ2HY3kR7RsYoRLUoQJ0FXkp8KgmATBtb+RTbDvRM9N
	ZZCVCo/bsC3Uv1XcTFzW+AOuAEAKgb2gt+q+ZXtf5Re27G4KejpIzMnvk+z20sPWf/v5z7
	wUVcfzqLGrrEepRyA6SU4O6Oq3itDdA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-se9LWCHqPrS8GDVKoZHxeg-1; Tue,
 20 Oct 2026 10:51:26 +0000
X-MC-Unique: se9LWCHqPrS8GDVKoZHxeg-1
X-Mimecast-MFC-AGG-ID: se9LWCHqPrS8GDVKoZHxeg_1792493482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E2BF1800878;
	Tue, 20 Oct 2026 10:51:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CCCA18005B3;
	Tue, 20 Oct 2026 10:51:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:14 +0400
Subject: [PATCH v7 57/65] target/riscv: convert PropertyInfo definitions to
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
Message-Id: <20261020-qom-qapi-v7-57-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5488;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XKjrfhJ2Z/vpJVDltF2KXqS9w+wUXXQdOLcco6lHE08=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10Zc82i8KNdsFK3/pKeHfVnxA4m/fOSulmH97
 UqyLuCWFoWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXAAKCRDa6OEJdZac
 5Z6cD/40rHcZVYX8wDxKQt8xTbOSbGFHhrkGBp+FJMr/D3qXf1CzfRM/zrW7BsamxNoTKamLgia
 vG/IF1pMis4auL226bPWZSNCw1wM64OiZLp34N3g6ajQDAnS4jfnerIAq7txzCCJUbSjDZABnY+
 O/X/WwsFuXapBnFcvD2GRf7OtzeasFepDj3L1mQI9qlcIH41qkSHstkXLXEuCxStBNzaQuJ+1nT
 f8elVasH3Qez1yhQlVLkdcseJ+WxT9culB/RhJzlcYMOY3ijoorNNWBmNMniKWqUHM380+dg4mi
 s5Xym63nleHU9QrcqKokpmXEO6nqQXGl5BVpG/+GI8J37DOJEBt7FopbJ8Qa/Prf2L0HVZ2F4Ri
 v52x6jhQ2cVDf52+6cx4EEUH1NulOv3VMoE+O/9QeuJjD6NvDl0kfVkgV83mliwEwc7vahuvnT6
 MZHRXzDT5gm/k1ueiE/SDcCEv9mGmfnj3XnZ7GWpLcbscFJebhqv5NagTK8eB75QcE5f7Li5RfK
 wc2VMbA5H3KXsbPLwfv0Bwcz8Ok9gFGyw0cb4nah/uS/gLpuvZSH3RlnyRCw3dHiiNOvmw9ktLa
 bEN7ShgjTnPCfdQW49hOPBZARpkjinKmx6OFPDecrZiaNqDlQaduXgMnp5B749lfM7OBJ8Ch+S8
 7b7viGC9MASEqng==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: isZYwFDmO_1om5AZjc7YyyAMp6oaUfpuHgtJYneair8_1792493482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Mechanical conversion of all local PropertyInfo definitions in
target/riscv/cpu.c

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 664c1a767950..28bfcb36ecb7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1704,7 +1704,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1746,7 +1746,7 @@ static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_mask = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
@@ -1778,7 +1778,7 @@ static void prop_mmu_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mmu = {
-    .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "mmu",
     .get = prop_mmu_get,
     .set = prop_mmu_set,
@@ -1811,7 +1811,7 @@ static void prop_pmp_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp = {
-    .type = "bool",
+    .qapi_type = &bool_type_info,
     .description = "pmp",
     .get = prop_pmp_get,
     .set = prop_pmp_set,
@@ -1851,7 +1851,7 @@ static void prop_num_pmp_regions_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_num_pmp_regions = {
-    .type = "uint8",
+    .qapi_type = &uint8_type_info,
     .description = "num-pmp-regions",
     .get = prop_num_pmp_regions_get,
     .set = prop_num_pmp_regions_set,
@@ -1889,7 +1889,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,
@@ -1965,7 +1965,7 @@ static void prop_priv_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_priv_spec = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "priv_spec",
     /* FIXME enum? */
     .get = prop_priv_spec_get,
@@ -1998,7 +1998,7 @@ static void prop_vext_spec_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vext_spec = {
-    .type = "str",
+    .qapi_type = &str_type_info,
     .description = "vext_spec",
     /* FIXME enum? */
     .get = prop_vext_spec_get,
@@ -2041,7 +2041,7 @@ static void prop_vlen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_vlen = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "vlen",
     .get = prop_vlen_get,
     .set = prop_vlen_set,
@@ -2082,7 +2082,7 @@ static void prop_elen_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_elen = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "elen",
     .get = prop_elen_get,
     .set = prop_elen_set,
@@ -2118,7 +2118,7 @@ static void prop_cbom_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbom_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbom_blocksize",
     .get = prop_cbom_blksize_get,
     .set = prop_cbom_blksize_set,
@@ -2154,7 +2154,7 @@ static void prop_cbop_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cbop_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cbop_blocksize",
     .get = prop_cbop_blksize_get,
     .set = prop_cbop_blksize_set,
@@ -2190,7 +2190,7 @@ static void prop_cboz_blksize_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_cboz_blksize = {
-    .type = "uint16",
+    .qapi_type = &uint16_type_info,
     .description = "cboz_blocksize",
     .get = prop_cboz_blksize_get,
     .set = prop_cboz_blksize_set,
@@ -2226,7 +2226,7 @@ static void prop_mvendorid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mvendorid = {
-    .type = "uint32",
+    .qapi_type = &uint32_type_info,
     .description = "mvendorid",
     .get = prop_mvendorid_get,
     .set = prop_mvendorid_set,
@@ -2262,7 +2262,7 @@ static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_mimpid = {
-    .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "mimpid",
     .get = prop_mimpid_get,
     .set = prop_mimpid_set,
@@ -2319,7 +2319,7 @@ static void prop_marchid_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_marchid = {
-    .type = "uint64",
+    .qapi_type = &uint64_type_info,
     .description = "marchid",
     .get = prop_marchid_get,
     .set = prop_marchid_set,

-- 
2.56.0.116.g6de20f6092dc

