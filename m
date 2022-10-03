Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E61DC433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Oct 2022 23:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJCXXs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJCXXp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Oct 2022 19:23:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B41A237
        for <linux-cxl@vger.kernel.org>; Mon,  3 Oct 2022 16:23:43 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293MAWeC019530
        for <linux-cxl@vger.kernel.org>; Mon, 3 Oct 2022 16:23:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=eo+pzF41Z3nVS0u7PbGU5zY+hwc1kC+s7iiLFMVCMOQ=;
 b=heoB65wA1S9feunSBne+dVwpB08+DuqPKgXrTHkw3IjAH9w7DvZeVzvVsWPkmJECF4i3
 jxlOwfa75+jyDu0w92ViBN65Ac4uMyWESdUZG/+tlU/dkSz/RMw3wlzdt9Qy5t43vckU
 WzytoBuR9aZImZjS2IEDVI09wO+R8HXsAEw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jxkcvp4kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 03 Oct 2022 16:23:42 -0700
Received: from twshared16308.14.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:23:41 -0700
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id 13ED912CA451; Mon,  3 Oct 2022 16:23:34 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@fb.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>
CC:     Jonathan Zhang <jonzhang@meta.com>
Subject: [PATCH 2/2] cxl: display alert configuratin fields in list command
Date:   Mon, 3 Oct 2022 16:23:06 -0700
Message-ID: <20221003232306.1326511-3-jonzhang@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221003232306.1326511-1-jonzhang@fb.com>
References: <20221003232306.1326511-1-jonzhang@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: EQ62TZdx_wSqD4O6UN_G9sXbLYniO4zh
X-Proofpoint-ORIG-GUID: EQ62TZdx_wSqD4O6UN_G9sXbLYniO4zh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Zhang <jonzhang@meta.com>

When list commands are issued, display alert config:

Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
---
 Documentation/cxl/cxl-list.txt |  33 +++++++++
 cxl/filter.c                   |   2 +
 cxl/filter.h                   |   1 +
 cxl/json.c                     | 131 +++++++++++++++++++++++++++++++++
 cxl/list.c                     |   3 +
 util/json.h                    |   1 +
 6 files changed, 171 insertions(+)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.=
txt
index 14a2b4b..66dfa15 100644
--- a/Documentation/cxl/cxl-list.txt
+++ b/Documentation/cxl/cxl-list.txt
@@ -219,6 +219,39 @@ OPTIONS
   }
 ]
 ----
+-A::
+--alert::
+	Include alert configuration in the memdev listing. Example listing:
+----
+# cxl list -m mem0 -A
+[
+  {
+    "memdev":"mem0",
+    "pmem_size":0,
+    "ram_size":273535729664,
+    "alert":{
+      "life_used_prog_warn_threshold_valid":false,
+      "dev_over_temp_prog_warn_threshold_valid":false,
+      "dev_under_temp_prog_warn_threshold_valid":false,
+      "corr_vol_mem_err_prog_warn_threshold_valid":true,
+      "corr_pers_mem_err_prog_warn_threshold_valid":false,
+      "life_used_prog_warn_threshold_programmable":false,
+      "dev_over_temp_prog_warn_threshold_programmable":false,
+      "dev_under_temp_prog_warn_threshold_programmable":false,
+      "corr_vol_mem_err_prog_warn_threshold_programmable":true,
+      "corr_pers_mem_err_prog_warn_threshold_programmable":false,
+      "life_used_crit_alert_threshold":0,
+      "life_used_prog_warn_threshold":0,
+      "dev_over_temp_crit_alert_threshold":0,
+      "dev_under_temp_crit_alert_threshold":0,
+      "dev_over_temp_prog_warn_threshold":0,
+      "dev_under_temp_prog_warn_threshold":0,
+      "corr_vol_mem_err_prog_warn_threshold":0,
+      "corr_pers_mem_err_prog_warn_threshold":0
+    },
+  }
+]
+----
=20
 -B::
 --buses::
diff --git a/cxl/filter.c b/cxl/filter.c
index 56c6599..6d71c1c 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -686,6 +686,8 @@ static unsigned long params_to_flags(struct cxl_filte=
r_params *param)
 		flags |=3D UTIL_JSON_TARGETS;
 	if (param->partition)
 		flags |=3D UTIL_JSON_PARTITION;
+	if (param->alert)
+		flags |=3D UTIL_JSON_ALERT;
 	return flags;
 }
=20
diff --git a/cxl/filter.h b/cxl/filter.h
index 256df49..ec0f74c 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -26,6 +26,7 @@ struct cxl_filter_params {
 	bool human;
 	bool health;
 	bool partition;
+	bool alert;
 	int verbose;
 	struct log_ctx ctx;
 };
diff --git a/cxl/json.c b/cxl/json.c
index 63c1751..dd83ed6 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -185,6 +185,131 @@ err_jobj:
 	return NULL;
 }
=20
+static struct json_object *util_cxl_memdev_alert_to_json(
+		struct cxl_memdev *memdev, unsigned long flags)
+{
+	struct json_object *jalert;
+	struct json_object *jobj;
+	struct cxl_cmd *cmd;
+	int rc;
+
+	jalert =3D json_object_new_object();
+	if (!jalert)
+		return NULL;
+	if (!memdev)
+		goto err_jobj;
+
+	cmd =3D cxl_cmd_new_get_alert_config(memdev);
+	if (!cmd)
+		goto err_jobj;
+
+	rc =3D cxl_cmd_submit(cmd);
+	if (rc < 0)
+		goto err_cmd;
+	rc =3D cxl_cmd_get_mbox_status(cmd);
+	if (rc !=3D 0)
+		goto err_cmd;
+
+	rc =3D cxl_cmd_alert_config_get_life_used_prog_warn_threshold_valid(cmd=
);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "life_used_prog_warn_threshold_valid", =
jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold_valid=
(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_over_temp_prog_warn_threshold_vali=
d", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold_vali=
d(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_under_temp_prog_warn_threshold_val=
id", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold_va=
lid(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "corr_vol_mem_err_prog_warn_threshold_v=
alid", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold_v=
alid(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "corr_pers_mem_err_prog_warn_threshold_=
valid", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_life_used_prog_warn_threshold_prog(cmd)=
;
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "life_used_prog_warn_threshold_programm=
able", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold_prog(=
cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_over_temp_prog_warn_threshold_prog=
rammable", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold_prog=
(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_under_temp_prog_warn_threshold_pro=
grammable", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold_pr=
og(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "corr_vol_mem_err_prog_warn_threshold_p=
rogrammable", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold_p=
rog(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert, "corr_pers_mem_err_prog_warn_threshold_=
programmable", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_life_used_crit_alert_threshold(cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "life_used_crit_alert_threshold", jobj)=
;
+
+	rc =3D cxl_cmd_alert_config_get_life_used_prog_warn_threshold(cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "life_used_prog_warn_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_over_temp_crit_alert_threshold(cmd)=
;
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_over_temp_crit_alert_threshold", j=
obj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_under_temp_crit_alert_threshold(cmd=
);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_under_temp_crit_alert_threshold", =
jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold(cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_over_temp_prog_warn_threshold", jo=
bj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold(cmd)=
;
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "dev_under_temp_prog_warn_threshold", j=
obj);
+
+	rc =3D cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold(cm=
d);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "corr_vol_mem_err_prog_warn_threshold",=
 jobj);
+
+	rc =3D cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold(c=
md);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert, "corr_pers_mem_err_prog_warn_threshold"=
, jobj);
+
+	cxl_cmd_unref(cmd);
+	return jalert;
+
+err_cmd:
+	cxl_cmd_unref(cmd);
+err_jobj:
+	json_object_put(jalert);
+	return NULL;
+}
+
 /*
  * Present complete view of memdev partition by presenting fields from
  * both GET_PARTITION_INFO and IDENTIFY mailbox commands.
@@ -330,6 +455,12 @@ struct json_object *util_cxl_memdev_to_json(struct c=
xl_memdev *memdev,
 			json_object_object_add(jdev, "health", jobj);
 	}
=20
+	if (flags & UTIL_JSON_ALERT) {
+		jobj =3D util_cxl_memdev_alert_to_json(memdev, flags);
+		if (jobj)
+			json_object_object_add(jdev, "alert", jobj);
+	}
+
 	serial =3D cxl_memdev_get_serial(memdev);
 	if (serial < ULLONG_MAX) {
 		jobj =3D util_json_object_hex(serial, flags);
diff --git a/cxl/list.c b/cxl/list.c
index 8c48fbb..6ec4403 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -52,6 +52,8 @@ static const struct option options[] =3D {
 		    "include memory device health information"),
 	OPT_BOOLEAN('I', "partition", &param.partition,
 		    "include memory device partition information"),
+	OPT_BOOLEAN('A', "alert", &param.alert,
+		    "include alert configuration information"),
 	OPT_INCR('v', "verbose", &param.verbose,
 		 "increase output detail"),
 #ifdef ENABLE_DEBUG
@@ -113,6 +115,7 @@ int cmd_list(int argc, const char **argv, struct cxl_=
ctx *ctx)
 	case 3:
 		param.health =3D true;
 		param.partition =3D true;
+		param.alert =3D true;
 		/* fallthrough */
 	case 2:
 		param.idle =3D true;
diff --git a/util/json.h b/util/json.h
index 73bb9f0..06594b5 100644
--- a/util/json.h
+++ b/util/json.h
@@ -20,6 +20,7 @@ enum util_json_flags {
 	UTIL_JSON_HEALTH	=3D (1 << 10),
 	UTIL_JSON_TARGETS	=3D (1 << 11),
 	UTIL_JSON_PARTITION	=3D (1 << 12),
+	UTIL_JSON_ALERT	=3D (1 << 13),
 };
=20
 void util_display_json_array(FILE *f_out, struct json_object *jarray,
--=20
2.30.2

