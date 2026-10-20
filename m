Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493369;
	b=V/ysGUoUoqetsnA88v3ZGXGlw6ov34VxPsVueA4UU3e862Ci0Lt+1vwh6XQNJyEISUVt
	 qvWUXWlLE8gYGHUtgWJfPRazfMkejmAecG9vfbV1fkbiOZnIa6tefAl+Lk4TvdIcgEViv
	 CwqHljYBeQ+XJddkIv1KlPTQYbRdmWemUbY09LFc+mD3iWcROsNHYG/cMnLJTjyAz3Rn3
	 JmT3gtlASSxB9tcJwuxsipLy9Oh1GgktVPPPyTTCkUXN6SF8DyfgaNeEz2CWC2wMDNvp/
	 rSY//sL16H5sDwX9HsS3w2Xbs4WqTmrEfS/UL3TGZ7/zt2WsMmGNmdDBeA2JDt88vlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493369;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=G0tJqQA4vjH1OewDrlPPbV755lqj6OJV4iLGYLxe1dQ=;
	b=fsVDFNKn9+IGuQ5+85Cl8a5XaCfDwro/ULzKzyyHc7jNXO5azoVjsinAnyp3MHzmtFcc
	 Q759jx8GXbWIZRxpw+2LhABeN7/g+ZmMZfzj6wzwqeRkj/uPLvZBVE85HWr6LJR5+1gQE
	 OjlqgyJmXCOM3xs9w8uVfaoIOuPceQZ6uwig2mJT4Fb1jGWz80RMz71H6gXWwNqrH564n
	 +j7MXPreVJ6L7WPNcAZ0nrGvcMmIKw+Lc2iuv1yCvciLMwdXgM6ecAAC84YXnWyPJRf18
	 3Zdtl1LSfFu0jwJXpg/NlG8N4FzjgYFccB0TnMd8cVEWRuX5rdPz5O7AJt6Oy7sC7zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QC8YQnI+;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301960A2601
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 10:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F301960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QC8YQnI+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0tJqQA4vjH1OewDrlPPbV755lqj6OJV4iLGYLxe1dQ=;
	b=QC8YQnI+rwTo5TVIyAHdJ0suxxgCt8Q1ye5bGlBv5zTRgtaO6Cir+PBOQBXEHDe5v5QDrS
	6cQZrQMfKyAy+qLH+j0ubZraRFfRixdwhJ1LgNKWApv4qlm5STLX6y3u5hJCtoPAmf9QSb
	faqlSua5Y7Q61RQ0yHgUX5lRc5y1/2U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-AU63UEb8PQ-MadFO--Yndg-1; Tue,
 20 Oct 2026 10:49:20 +0000
X-MC-Unique: AU63UEb8PQ-MadFO--Yndg-1
X-Mimecast-MFC-AGG-ID: AU63UEb8PQ-MadFO--Yndg_1792493356
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EE4D1955DE9;
	Tue, 20 Oct 2026 10:49:16 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1701A418;
	Tue, 20 Oct 2026 10:49:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:45:51 +0400
Subject: [PATCH v7 34/65] ppc/spapr-caps: convert to QAPI-aware property
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
Message-Id: <20261020-qom-qapi-v7-34-431a86b02b58@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6963;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h0OiLsI4rZp+v/Mhu46aHZ2MeGUSC4RGBbFRwR/fgso=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZafzwZrCef0nnjKmQFgGHI7d1DU4j3tcKg8
 rfJ8YYSxbiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGWgAKCRDa6OEJdZac
 5ZNiD/9uJkrnfIq0f1AAFb55zRGcmM6E9/bY9PjcQwic7qZwiIF30FoVEyW+LS1V4LBV8lFxJNS
 PQU7j6R+CB6v9HoMI64E1PyApDwdLlnaHAJlXcyEPUzd2BVafhj1hHbaYhLxkEy1FKLnJgXjLkJ
 gdIwysLCQIt8EXWXa5PEr9we5qawBjwypQ0Lag+ls7M/dEH/0Kh1uzOi9w8a2krYIDQZcarZN7i
 E4LtOP390qyqqA6YnMhP59VMT+qvfxHzc/ZQswUOQyZJDTsWt5bsBXzpOFFpbBXuTXpDT9AtofO
 ID8iow8Lpz1Tszo5kP/m/Lm4S8UWRsm6FmK1PFXmwtWWlyXJh+CUFxiKOxoxpS5FTXbRJGSv05O
 ZMYDLHTHu8+gadlaJjYgyFbJVyKlNsrAGTmFvM/RU3rpVkTt06dMhmHo8K8rWEYHAwUYB4Ks35l
 E6S+GJ02O0X284mnQwikHn+fLhcivRrqM+9mynA/bGmrsWZIK4DhT6Cp8zFSPLW47Oshjun/E64
 G1PIDvecXY/KRp7V24XZJYFMStRWq10r6lNpi654+g4kT2EsUxLVHwoqsQTcV+XoNk/+hsNx570
 AStfbHcS7MyUnY6GxM7Pl2zFwIbukx86j8jruO3yrSjE+v6CcaPGGLJ2oigWATENvOZrnqpgn3Y
 yk4mypdVxiZikCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: maBKrrmlMF5-AXziJBRWSvvJ15QKsf8b5pgHc1RWfU8_1792493356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Replace the type string in SpaprCapabilityInfo with a QAPITypeInfo
pointer and switch spapr_caps_add_properties() from
object_class_property_add() to object_class_property_add_qapi().

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/ppc/spapr_caps.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 103b17364feb..e622c79eb52a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "system/hw_accel.h"
@@ -59,7 +60,7 @@ typedef struct SpaprCapabilityInfo {
     /* Getter and Setter Function Pointers */
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
-    const char *type;
+    const QAPITypeInfo *type;
     /* Possible values if this is a custom string type */
     SpaprCapPossible *possible;
     /* Make sure the virtual hardware can support this capability */
@@ -725,7 +726,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_HTM,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_htm_apply,
     },
     [SPAPR_CAP_VSX] = {
@@ -734,7 +735,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_VSX,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_vsx_apply,
     },
     [SPAPR_CAP_DFP] = {
@@ -743,7 +744,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_DFP,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_dfp_apply,
     },
     [SPAPR_CAP_CFPC] = {
@@ -752,7 +753,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_CFPC,
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
-        .type = "string",
+        .type = &str_type_info,
         .possible = &cap_cfpc_possible,
         .apply = cap_safe_cache_apply,
     },
@@ -762,7 +763,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_SBBC,
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
-        .type = "string",
+        .type = &str_type_info,
         .possible = &cap_sbbc_possible,
         .apply = cap_safe_bounds_check_apply,
     },
@@ -774,7 +775,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_IBS,
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
-        .type = "string",
+        .type = &str_type_info,
         .possible = &cap_ibs_possible,
         .apply = cap_safe_indirect_branch_apply,
     },
@@ -784,7 +785,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_HPT_MAXPAGESIZE,
         .get = spapr_cap_get_pagesize,
         .set = spapr_cap_set_pagesize,
-        .type = "size",
+        .type = &size_type_info,
         .apply = cap_hpt_maxpagesize_apply,
         .cpu_apply = cap_hpt_maxpagesize_cpu_apply,
     },
@@ -794,7 +795,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_NESTED_KVM_HV,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_nested_kvm_hv_apply,
     },
     [SPAPR_CAP_NESTED_PAPR] = {
@@ -803,7 +804,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_NESTED_PAPR,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_nested_papr_apply,
     },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
@@ -812,7 +813,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_LARGE_DECREMENTER,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_large_decr_apply,
         .cpu_apply = cap_large_decr_cpu_apply,
     },
@@ -822,7 +823,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_CCF_ASSIST,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_ccf_assist_apply,
     },
     [SPAPR_CAP_FWNMI] = {
@@ -831,7 +832,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_FWNMI,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_fwnmi_apply,
     },
     [SPAPR_CAP_RPT_INVALIDATE] = {
@@ -840,7 +841,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_RPT_INVALIDATE,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_rpt_invalidate_apply,
     },
     [SPAPR_CAP_AIL_MODE_3] = {
@@ -849,7 +850,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_AIL_MODE_3,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_ail_mode_3_apply,
     },
     [SPAPR_CAP_DAWR1] = {
@@ -858,7 +859,7 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .index = SPAPR_CAP_DAWR1,
         .get = spapr_cap_get_bool,
         .set = spapr_cap_set_bool,
-        .type = "bool",
+        .type = &bool_type_info,
         .apply = cap_dawr1_apply,
     },
 };
@@ -1069,9 +1070,9 @@ void spapr_caps_add_properties(SpaprMachineClass *smc)
         g_autofree char *name = g_strdup_printf("cap-%s", cap->name);
         g_autofree char *desc = g_strdup(cap->description);
 
-        object_class_property_add(klass, name, cap->type,
-                                  cap->get, cap->set,
-                                  NULL, cap);
+        object_class_property_add_qapi(klass, name, cap->type,
+                                       cap->get, cap->set,
+                                       NULL, cap);
 
         object_class_property_set_description(klass, name, desc);
     }

-- 
2.56.0.116.g6de20f6092dc

