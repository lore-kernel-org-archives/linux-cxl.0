Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D00C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Oct 2022 23:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJCXXt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJCXXp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Oct 2022 19:23:45 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B601DF0F
        for <linux-cxl@vger.kernel.org>; Mon,  3 Oct 2022 16:23:44 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293MEFLn024770
        for <linux-cxl@vger.kernel.org>; Mon, 3 Oct 2022 16:23:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=zNkAX8fOwOQA48fhiYPD31l21a5G1fCM6fat8C7Y+AA=;
 b=ds8FTHSbcVTYMJ9GagyS+O8Bd1Hd1/F//hchWdXsFloUZDsmp3gRkJWGxZXf9BJNkZW6
 DMP+1RJ6csKjewjqI3myJ6V6VJ/bJQGE3do9KuVu+AcfxLG0oR6fv39fBw/wfXpd1UkA
 qfpWdI7ZQiG0TajBgfUxxCGO+PazJOfX/W8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jxka0p5mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Mon, 03 Oct 2022 16:23:43 -0700
Received: from twshared20183.05.prn5.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:23:41 -0700
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id C705712CA44E; Mon,  3 Oct 2022 16:23:32 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@fb.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>
CC:     Jonathan Zhang <jonzhang@meta.com>
Subject: [PATCH 1/2] libcxl: add accessors for Get Alert Configuration CCI command output
Date:   Mon, 3 Oct 2022 16:23:05 -0700
Message-ID: <20221003232306.1326511-2-jonzhang@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221003232306.1326511-1-jonzhang@fb.com>
References: <20221003232306.1326511-1-jonzhang@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mQ0yPvLHVHFIW2O_GA2sv6c6yIypwigJ
X-Proofpoint-GUID: mQ0yPvLHVHFIW2O_GA2sv6c6yIypwigJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Zhang <jonzhang@meta.com>

CXL 3.0 spec section 8.2.9.8.3.2 "Get Alert Configuration
(Opcode 4201h) defines the get-alert-config command to
retrieve the devices's critical alert and programmable
warning configuration.

Add the methods to issue the command and get the fields
defined.

Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
---
 Documentation/cxl/lib/libcxl.txt |   1 +
 cxl/lib/libcxl.c                 | 120 +++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  23 ++++++
 cxl/lib/private.h                |  28 ++++++++
 cxl/libcxl.h                     |  19 +++++
 5 files changed, 191 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/lib=
cxl.txt
index fd2962a..dec3641 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -121,6 +121,7 @@ information this call requires root / CAP_SYS_ADMIN.
 struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev, int opcode);
 struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
 struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
+struct cxl_cmd *cxl_cmd_new_get_alert_config(struct cxl_memdev *memdev);
 struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_memdev *memdev,
 					unsigned int offset, unsigned int length);
 struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev, void =
*buf,
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e8c5d44..ed5616c 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3140,6 +3140,126 @@ do {									\
 	return !!(c->field & mask);					\
 } while(0)
=20
+CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_alert_config(
+		struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_ALERT_CONFIG)=
;
+}
+
+#define cmd_alert_get_valid_alerts_field(c, m)					\
+	cmd_get_field_u8_mask(c, get_alert_config, GET_ALERT_CONFIG, valid_aler=
ts, m)
+
+CXL_EXPORT int cxl_cmd_alert_config_get_life_used_prog_warn_threshold_va=
lid(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_LIFE_USED_PROG_WARN_THRESHOLD_MASK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshol=
d_valid(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_OVER_TEMP_PROG_WARN_THRESHOLD_MA=
SK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_under_temp_prog_warn_thresho=
ld_valid(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_UNDER_TEMP_PROG_WARN_THRESHOLD_M=
ASK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_thres=
hold_valid(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_VOL_MEM_ERR_PROG_WARN_THRESHOLD=
_MASK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_thre=
shold_valid(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_PERS_MEM_ERR_PROG_WARN_THRESHOL=
D_MASK);
+}
+
+#define cmd_alert_get_prog_alerts_field(c, m)					\
+	cmd_get_field_u8_mask(c, get_alert_config, GET_ALERT_CONFIG, programmab=
le_alerts, m)
+
+CXL_EXPORT int cxl_cmd_alert_config_get_life_used_prog_warn_threshold_pr=
og(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshol=
d_prog(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_OVER_TEMP_PROG_WARN_THRESHOLD_MAS=
K);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_under_temp_prog_warn_thresho=
ld_prog(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_UNDER_TEMP_PROG_WARN_THRESHOLD_MA=
SK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_thres=
hold_prog(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_VOL_MEM_ERR_PROG_WARN_THRESHOLD_=
MASK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_thre=
shold_prog(struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_PERS_MEM_ERR_PROG_WARN_THRESHOLD=
_MASK);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_life_used_crit_alert_threshold(s=
truct cxl_cmd *cmd)
+{
+	cmd_get_field_u8(cmd, get_alert_config, GET_ALERT_CONFIG,
+				life_used_crit_alert_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_life_used_prog_warn_threshold(st=
ruct cxl_cmd *cmd)
+{
+	cmd_get_field_u8(cmd, get_alert_config, GET_ALERT_CONFIG,
+				life_used_prog_warn_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_over_temp_crit_alert_thresho=
ld(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+				dev_over_temp_crit_alert_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_under_temp_crit_alert_thresh=
old(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+				dev_under_temp_crit_alert_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshol=
d(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+				dev_over_temp_prog_warn_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_dev_under_temp_prog_warn_thresho=
ld(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+				dev_under_temp_prog_warn_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_thres=
hold(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+				corr_vol_mem_err_prog_warn_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_thre=
shold(struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+				corr_pers_mem_err_prog_warn_threshold);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_health_info(
 		struct cxl_memdev *memdev)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8bb91e0..7c1e261 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -217,3 +217,26 @@ global:
 	cxl_decoder_get_max_available_extent;
 	cxl_decoder_get_region;
 } LIBCXL_2;
+
+LIBCXL_4 {
+global:
+	cxl_cmd_new_get_alert_config;
+	cxl_cmd_alert_config_get_life_used_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_get_life_used_prog_warn_threshold_prog;
+	cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold_prog;
+	cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold_prog;
+	cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold_prog;
+	cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold_prog;
+	cxl_cmd_alert_config_get_life_used_crit_alert_threshold;
+	cxl_cmd_alert_config_get_life_used_prog_warn_threshold;
+	cxl_cmd_alert_config_get_dev_over_temp_crit_alert_threshold;
+	cxl_cmd_alert_config_get_dev_under_temp_crit_alert_threshold;
+	cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold;
+	cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold;
+	cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold;
+	cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold;
+} LIBCXL_3;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 437eade..5a1a786 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -228,6 +228,34 @@ struct cxl_cmd_get_health_info {
 	le32 pmem_errors;
 } __attribute__((packed));
=20
+/* CXL 3.0 8.2.9.8.3.2 Get Alert Configuration */
+struct cxl_cmd_get_alert_config {
+	u8 valid_alerts;
+	u8 programmable_alerts;
+	u8 life_used_crit_alert_threshold;
+	u8 life_used_prog_warn_threshold;
+	le16 dev_over_temp_crit_alert_threshold;
+	le16 dev_under_temp_crit_alert_threshold;
+	le16 dev_over_temp_prog_warn_threshold;
+	le16 dev_under_temp_prog_warn_threshold;
+	le16 corr_vol_mem_err_prog_warn_threshold;
+	le16 corr_pers_mem_err_prog_warn_threshold;
+}  __attribute__((packed));
+
+/* CXL 3.0 8.2.9.8.3.2 Get Alert Configuration Byte 0 Valid Alerts */
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_LIFE_USED_PROG_WARN_THRESHOLD_=
MASK		BIT(0)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_OVER_TEMP_PROG_WARN_THRESH=
OLD_MASK		BIT(1)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_UNDER_TEMP_PROG_WARN_THRES=
HOLD_MASK		BIT(2)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_VOL_MEM_ERR_PROG_WARN_THR=
ESHOLD_MASK		BIT(3)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_PERS_MEM_ERR_PROG_WARN_TH=
RESHOLD_MASK		BIT(4)
+
+/* CXL 3.0 8.2.9.8.3.2 Get Alert Configuration Byte 1 Programmable Alert=
s */
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_M=
ASK		BIT(0)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_OVER_TEMP_PROG_WARN_THRESHO=
LD_MASK		BIT(1)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_UNDER_TEMP_PROG_WARN_THRESH=
OLD_MASK		BIT(2)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_VOL_MEM_ERR_PROG_WARN_THRE=
SHOLD_MASK		BIT(3)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_PERS_MEM_ERR_PROG_WARN_THR=
ESHOLD_MASK		BIT(4)
+
 struct cxl_cmd_get_partition {
 	le64 active_volatile;
 	le64 active_persistent;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99..8aa1c46 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -354,6 +354,25 @@ int cxl_cmd_health_info_get_temperature(struct cxl_c=
md *cmd);
 int cxl_cmd_health_info_get_dirty_shutdowns(struct cxl_cmd *cmd);
 int cxl_cmd_health_info_get_volatile_errors(struct cxl_cmd *cmd);
 int cxl_cmd_health_info_get_pmem_errors(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_get_alert_config(struct cxl_memdev *memdev);
+int cxl_cmd_alert_config_get_life_used_prog_warn_threshold_valid(struct =
cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold_valid(str=
uct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold_valid(st=
ruct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold_valid(=
struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold_valid=
(struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_life_used_prog_warn_threshold_prog(struct c=
xl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold_prog(stru=
ct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold_prog(str=
uct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold_prog(s=
truct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold_prog(=
struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_life_used_crit_alert_threshold(struct cxl_c=
md *cmd);
+int cxl_cmd_alert_config_get_life_used_prog_warn_threshold(struct cxl_cm=
d *cmd);
+int cxl_cmd_alert_config_get_dev_over_temp_crit_alert_threshold(struct c=
xl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_under_temp_crit_alert_threshold(struct =
cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_over_temp_prog_warn_threshold(struct cx=
l_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_under_temp_prog_warn_threshold(struct c=
xl_cmd *cmd);
+int cxl_cmd_alert_config_get_corr_vol_mem_err_prog_warn_threshold(struct=
 cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_corr_pers_mem_err_prog_warn_threshold(struc=
t cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_memdev *memdev,
 		unsigned int offset, unsigned int length);
 ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd, void *buf,
--=20
2.30.2

