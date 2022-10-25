Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB986C38A2D
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 20:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiJYUon (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiJYUom (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 16:44:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC34E578A2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:44:41 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJjf5J028978
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:44:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=7ytum0hRlV6SbbsJqGTpU3I/ZAavdT2sbo70T2ibQt4=;
 b=KWAz+ImzfPVzphkXsAbNzx1nJMB0E4CJNInCfAuiwL9h+uULz4lyEzO6j04zgLTVOWHE
 z7mTa2shHt0R1B5PmZ1hH+j5D6z5zPnyju01EtLHWdxeGas0r4XFOy2rTY4bPHOoVWTT
 aeY4s+444s8w1V2UUNnz7ttJv8lTZSXtjnbYpMCwHHsMM3tLbjpytUCdcC01HdEU0OmN
 dJFZP9LoriM/FLEAkAmZ8fvcvc+HbR5UrqMpRQfyViX6KomkFDTVLMIhzbtw6nH21I+Q
 4bR/3NKt+BMjMJLao0aN34nfS7CMvR/4cwKfF7L4zKrvIXlFU6maLbxnhB3Z5naDsZFD Vw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ke64gtatw-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:44:41 -0700
Received: from twshared13931.24.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 13:43:48 -0700
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id AC64524C5C13; Tue, 25 Oct 2022 13:43:36 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@meta.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>
CC:     Jonathan Zhang <jonzhang@fb.com>,
        Jonathan Zhang <jonzhang@meta.com>
Subject: [ndctl PATCH V2 2/2] cxl: display alert configuration fields
Date:   Tue, 25 Oct 2022 13:43:20 -0700
Message-ID: <20221025204320.290354-3-jonzhang@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025204320.290354-1-jonzhang@meta.com>
References: <20221025204320.290354-1-jonzhang@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: czw06QgGMbvpXy1alEIYWu1y8UseR14l
X-Proofpoint-ORIG-GUID: czw06QgGMbvpXy1alEIYWu1y8UseR14l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Zhang <jonzhang@fb.com>

CXL device's critical alert and programmable warning configurations
are displayed when:
* list command is issued.
* "--alert-config" is issued.

Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
---
 Documentation/cxl/cxl-list.txt |  33 ++++++
 cxl/filter.c                   |   2 +
 cxl/filter.h                   |   1 +
 cxl/json.c                     | 185 +++++++++++++++++++++++++++++++++
 cxl/list.c                     |   6 +-
 util/json.h                    |   1 +
 6 files changed, 226 insertions(+), 2 deletions(-)

diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.=
txt
index 14a2b4b..c762368 100644
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
+      "dev_over_temperature_prog_warn_threshold_valid":false,
+      "dev_under_temperature_prog_warn_threshold_valid":false,
+      "corrected_volatile_mem_err_prog_warn_threshold_valid":true,
+      "corrected_pmem_err_prog_warn_threshold_valid":false,
+      "life_used_prog_warn_threshold_writable":false,
+      "dev_over_temperature_prog_warn_threshold_writable":false,
+      "dev_under_temperature_prog_warn_threshold_writable":false,
+      "corrected_volatile_mem_err_prog_warn_threshold_writable":true,
+      "corrected_pmem_err_prog_warn_threshold_writable":false,
+      "life_used_crit_alert_threshold":0,
+      "life_used_prog_warn_threshold":0,
+      "dev_over_temperature_crit_alert_threshold":0,
+      "dev_under_temperature_crit_alert_threshold":0,
+      "dev_over_temperature_prog_warn_threshold":0,
+      "dev_under_temperature_prog_warn_threshold":0,
+      "corrected_volatile_mem_err_prog_warn_threshold":0,
+      "corrected_pmem_err_prog_warn_threshold":0
+    },
+  }
+]
+----
=20
 -B::
 --buses::
diff --git a/cxl/filter.c b/cxl/filter.c
index 56c6599..beb64de 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -686,6 +686,8 @@ static unsigned long params_to_flags(struct cxl_filte=
r_params *param)
 		flags |=3D UTIL_JSON_TARGETS;
 	if (param->partition)
 		flags |=3D UTIL_JSON_PARTITION;
+	if (param->alert_config)
+		flags |=3D UTIL_JSON_ALERT_CONFIG;
 	return flags;
 }
=20
diff --git a/cxl/filter.h b/cxl/filter.h
index 256df49..cd514c9 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -26,6 +26,7 @@ struct cxl_filter_params {
 	bool human;
 	bool health;
 	bool partition;
+	bool alert_config;
 	int verbose;
 	struct log_ctx ctx;
 };
diff --git a/cxl/json.c b/cxl/json.c
index 63c1751..2f74452 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -185,6 +185,185 @@ err_jobj:
 	return NULL;
 }
=20
+static struct json_object *
+util_cxl_memdev_alert_config_to_json(struct cxl_memdev *memdev,
+				     unsigned long flags)
+{
+	struct json_object *jalert_config;
+	struct json_object *jobj;
+	struct cxl_cmd *cmd;
+	int rc;
+
+	jalert_config =3D json_object_new_object();
+	if (!jalert_config)
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
+	rc =3D cxl_cmd_alert_config_life_used_prog_warn_threshold_valid(cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert_config,
+				       "life_used_prog_warn_threshold_valid",
+				       jobj);
+
+	rc =3D cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_va=
lid(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_over_temperature_prog_warn_threshold_valid", jobj);
+
+	rc =3D cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_v=
alid(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_under_temperature_prog_warn_threshold_valid",
+			jobj);
+
+	rc =3D cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_thresh=
old_valid(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"corr_volatile_mem_err_prog_warn_threshold_valid",
+			jobj);
+
+	rc =3D cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_vali=
d(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"corr_pmem_err_prog_warn_threshold_valid", jobj);
+
+	rc =3D cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(cmd)=
;
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(jalert_config,
+				       "life_used_prog_warn_threshold_writable",
+				       jobj);
+
+	rc =3D cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_wr=
itable(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_over_temperature_prog_warn_threshold_writable",
+			jobj);
+
+	rc =3D cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_w=
ritable(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_under_temperature_prog_warn_threshold_writable",
+			jobj);
+
+	rc =3D cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_thresh=
old_writable(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"corr_volatile_mem_err_prog_warn_threshold_writable",
+			jobj);
+
+	rc =3D cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_writ=
able(
+		cmd);
+	jobj =3D json_object_new_boolean(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"corr_pmem_err_prog_warn_threshold_writable", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_life_used_crit_alert_threshold(cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert_config,
+				       "life_used_crit_alert_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_life_used_prog_warn_threshold(cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert_config,
+				       "life_used_prog_warn_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_over_temperature_crit_alert_thresho=
ld(
+		cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_over_temperature_crit_alert_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_under_temperature_crit_alert_thresh=
old(
+		cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_under_temperature_crit_alert_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_over_temperature_prog_warn_threshol=
d(
+		cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_over_temperature_prog_warn_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_dev_under_temperature_prog_warn_thresho=
ld(
+		cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"dev_under_temperature_prog_warn_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_corrected_volatile_mem_err_prog_warn_th=
reshold(
+		cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(
+			jalert_config,
+			"corr_volatile_mem_err_prog_warn_threshold", jobj);
+
+	rc =3D cxl_cmd_alert_config_get_corrected_pmem_err_prog_warn_threshold(
+		cmd);
+	jobj =3D json_object_new_int(rc);
+	if (jobj)
+		json_object_object_add(jalert_config,
+				       "corr_pmem_err_prog_warn_threshold",
+				       jobj);
+
+	cxl_cmd_unref(cmd);
+	return jalert_config;
+
+err_cmd:
+	cxl_cmd_unref(cmd);
+err_jobj:
+	json_object_put(jalert_config);
+	return NULL;
+}
+
 /*
  * Present complete view of memdev partition by presenting fields from
  * both GET_PARTITION_INFO and IDENTIFY mailbox commands.
@@ -330,6 +509,12 @@ struct json_object *util_cxl_memdev_to_json(struct c=
xl_memdev *memdev,
 			json_object_object_add(jdev, "health", jobj);
 	}
=20
+	if (flags & UTIL_JSON_ALERT_CONFIG) {
+		jobj =3D util_cxl_memdev_alert_config_to_json(memdev, flags);
+		if (jobj)
+			json_object_object_add(jdev, "alert_config", jobj);
+	}
+
 	serial =3D cxl_memdev_get_serial(memdev);
 	if (serial < ULLONG_MAX) {
 		jobj =3D util_json_object_hex(serial, flags);
diff --git a/cxl/list.c b/cxl/list.c
index 8c48fbb..5dd76b9 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -52,8 +52,9 @@ static const struct option options[] =3D {
 		    "include memory device health information"),
 	OPT_BOOLEAN('I', "partition", &param.partition,
 		    "include memory device partition information"),
-	OPT_INCR('v', "verbose", &param.verbose,
-		 "increase output detail"),
+	OPT_BOOLEAN('A', "alert-config", &param.alert_config,
+		    "include alert configuration information"),
+	OPT_INCR('v', "verbose", &param.verbose, "increase output detail"),
 #ifdef ENABLE_DEBUG
 	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
 #endif
@@ -113,6 +114,7 @@ int cmd_list(int argc, const char **argv, struct cxl_=
ctx *ctx)
 	case 3:
 		param.health =3D true;
 		param.partition =3D true;
+		param.alert_config =3D true;
 		/* fallthrough */
 	case 2:
 		param.idle =3D true;
diff --git a/util/json.h b/util/json.h
index 73bb9f0..ea370df 100644
--- a/util/json.h
+++ b/util/json.h
@@ -20,6 +20,7 @@ enum util_json_flags {
 	UTIL_JSON_HEALTH	=3D (1 << 10),
 	UTIL_JSON_TARGETS	=3D (1 << 11),
 	UTIL_JSON_PARTITION	=3D (1 << 12),
+	UTIL_JSON_ALERT_CONFIG	=3D (1 << 13),
 };
=20
 void util_display_json_array(FILE *f_out, struct json_object *jarray,
--=20
2.30.2

