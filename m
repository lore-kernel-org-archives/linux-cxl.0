Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25744FA373E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 20:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiJYUnp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiJYUnn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 16:43:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B9210AC2E
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:43:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29PJjfCB011628
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:43:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=rFZ7IYqIrWVgDeyetSQpmznBNqUbt+SnQfjCYOWywZw=;
 b=HdgEF4h9qGcSobUfi2D6LbF1fsokaRzX8kTUQ9jG15x8i8D6g6INNGlh7LmZfMjN2Zpr
 jOWZDMYn63wSOfnhxDB6F1sw9wP7EyWUYcQ5WuDwAczytdkaClpiOsR61hWXDbsgYLC+
 83MkSkHZlJK2DQxj9flz7WNefU8e+FkspB4A0SlnlBJhpGZ6if7Vw/k5F+wVjin5ILzI
 lMb43QrpeQGhMjyt68wgQcZjiNSMisLC6ojifZ8tY7csfgGHKRk97jP2B14XpkszrfN8
 mBale6pvqfG5zILtAZUh0G5azWKDsvwbAgcT4K9wHlk0kalbxt0UdL0BpdzYzwqPBWmv BQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kefbfdkug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 13:43:42 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 13:43:41 -0700
Received: by devvm7073.vll0.facebook.com (Postfix, from userid 175343)
        id 9955124C5BFF; Tue, 25 Oct 2022 13:43:33 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@meta.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <wzhang@meta.com>
CC:     Jonathan Zhang <jonzhang@fb.com>,
        Jonathan Zhang <jonzhang@meta.com>
Subject: [ndctl PATCH V2 1/2] libcxl: add accessors for Get Alert Configuration CCI output
Date:   Tue, 25 Oct 2022 13:43:19 -0700
Message-ID: <20221025204320.290354-2-jonzhang@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221025204320.290354-1-jonzhang@meta.com>
References: <20221025204320.290354-1-jonzhang@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 801g5K2xZhUaP8UU1u9GQy3Va8fJfpr4
X-Proofpoint-ORIG-GUID: 801g5K2xZhUaP8UU1u9GQy3Va8fJfpr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-25_13,2022-10-25_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Zhang <jonzhang@fb.com>

CXL 3.0 spec section 8.2.9.8.3.2 "Get Alert Configuration
(Opcode 4201h) defines the get-alert-config command to
retrieve the devices's critical alert and programmable
warning configurations.

Add the methods to issue the command and get the fields
defined.

Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
---
 Documentation/cxl/lib/libcxl.txt |   1 +
 cxl/lib/libcxl.c                 | 163 +++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym               |  23 +++++
 cxl/lib/private.h                |  38 +++++++
 cxl/libcxl.h                     |  35 +++++++
 5 files changed, 260 insertions(+)

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
index e8c5d44..c604331 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3140,6 +3140,169 @@ do {									\
 	return !!(c->field & mask);					\
 } while(0)
=20
+CXL_EXPORT struct cxl_cmd *
+cxl_cmd_new_get_alert_config(struct cxl_memdev *memdev)
+{
+	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_ALERT_CONFIG)=
;
+}
+
+#define cmd_alert_get_valid_alerts_field(c, m)                          =
       \
+	cmd_get_field_u8_mask(c, get_alert_config, GET_ALERT_CONFIG,           =
\
+			      valid_alerts, m)
+
+CXL_EXPORT int
+cxl_cmd_alert_config_life_used_prog_warn_threshold_valid(struct cxl_cmd =
*cmd)
+{
+	cmd_alert_get_valid_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_LIFE_USED_PROG_WARN_THRESHOLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_valid(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_OVER_TEMPERATURE_PROG_WARN_THRES=
HOLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_valid(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_UNDER_TEMPERATURE_PROG_WARN_THRE=
SHOLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_vali=
d(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_VOLATILE_MEM_ERR_PROG_WARN_THRE=
SHOLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_valid(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_valid_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_PMEM_ERR_PROG_WARN_THRESHOLD_MA=
SK);
+}
+
+#define cmd_alert_get_prog_alerts_field(c, m)                           =
       \
+	cmd_get_field_u8_mask(c, get_alert_config, GET_ALERT_CONFIG,           =
\
+			      programmable_alerts, m)
+
+CXL_EXPORT int
+cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(struct cxl_c=
md *cmd)
+{
+	cmd_alert_get_prog_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_writable(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_OVER_TEMPERATURE_PROG_WARN_THRESH=
OLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_writable(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_UNDER_TEMPERATURE_PROG_WARN_THRES=
HOLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_writ=
able(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_VOLATILE_MEM_ERR_PROG_WARN_THRES=
HOLD_MASK);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_writable(
+	struct cxl_cmd *cmd)
+{
+	cmd_alert_get_prog_alerts_field(
+		cmd,
+		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_PMEM_ERR_PROG_WARN_THRESHOLD_MAS=
K);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_get_life_used_crit_alert_threshold(struct cxl_cmd *=
cmd)
+{
+	cmd_get_field_u8(cmd, get_alert_config, GET_ALERT_CONFIG,
+			 life_used_crit_alert_threshold);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_get_life_used_prog_warn_threshold(struct cxl_cmd *c=
md)
+{
+	cmd_get_field_u8(cmd, get_alert_config, GET_ALERT_CONFIG,
+			 life_used_prog_warn_threshold);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_get_dev_over_temperature_crit_alert_threshold(
+	struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+			  dev_over_temperature_crit_alert_threshold);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_get_dev_under_temperature_crit_alert_threshold(
+	struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+			  dev_under_temperature_crit_alert_threshold);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_get_dev_over_temperature_prog_warn_threshold(
+	struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+			  dev_over_temperature_prog_warn_threshold);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_get_dev_under_temperature_prog_warn_threshold(
+	struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+			  dev_under_temperature_prog_warn_threshold);
+}
+
+CXL_EXPORT int
+cxl_cmd_alert_config_get_corrected_volatile_mem_err_prog_warn_threshold(
+	struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+			  corrected_volatile_mem_err_prog_warn_threshold);
+}
+
+CXL_EXPORT int cxl_cmd_alert_config_get_corrected_pmem_err_prog_warn_thr=
eshold(
+	struct cxl_cmd *cmd)
+{
+	cmd_get_field_u16(cmd, get_alert_config, GET_ALERT_CONFIG,
+			  corrected_pmem_err_prog_warn_threshold);
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_health_info(
 		struct cxl_memdev *memdev)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8bb91e0..d63fde9 100644
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
+	cxl_cmd_alert_config_life_used_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_val=
id;
+	cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_valid;
+	cxl_cmd_alert_config_life_used_prog_warn_threshold_writable;
+	cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_writable;
+	cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_writable=
;
+	cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_wri=
table;
+	cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_writable;
+	cxl_cmd_alert_config_get_life_used_crit_alert_threshold;
+	cxl_cmd_alert_config_get_life_used_prog_warn_threshold;
+	cxl_cmd_alert_config_get_dev_over_temperature_crit_alert_threshold;
+	cxl_cmd_alert_config_get_dev_under_temperature_crit_alert_threshold;
+	cxl_cmd_alert_config_get_dev_over_temperature_prog_warn_threshold;
+	cxl_cmd_alert_config_get_dev_under_temperature_prog_warn_threshold;
+	cxl_cmd_alert_config_get_corrected_volatile_mem_err_prog_warn_threshold=
;
+	cxl_cmd_alert_config_get_corrected_pmem_err_prog_warn_threshold;
+} LIBCXL_3;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index 437eade..777c6f1 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -228,6 +228,44 @@ struct cxl_cmd_get_health_info {
 	le32 pmem_errors;
 } __attribute__((packed));
=20
+/* CXL 3.0 8.2.9.8.3.2 Get Alert Configuration */
+struct cxl_cmd_get_alert_config {
+	u8 valid_alerts;
+	u8 programmable_alerts;
+	u8 life_used_crit_alert_threshold;
+	u8 life_used_prog_warn_threshold;
+	le16 dev_over_temperature_crit_alert_threshold;
+	le16 dev_under_temperature_crit_alert_threshold;
+	le16 dev_over_temperature_prog_warn_threshold;
+	le16 dev_under_temperature_prog_warn_threshold;
+	le16 corrected_volatile_mem_err_prog_warn_threshold;
+	le16 corrected_pmem_err_prog_warn_threshold;
+} __attribute__((packed));
+
+/* CXL 3.0 8.2.9.8.3.2 Get Alert Configuration Byte 0 Valid Alerts */
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_LIFE_USED_PROG_WARN_THRESHOLD_=
MASK   \
+	BIT(0)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_OVER_TEMPERATURE_PROG_WARN=
_THRESHOLD_MASK \
+	BIT(1)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_DEV_UNDER_TEMPERATURE_PROG_WAR=
N_THRESHOLD_MASK \
+	BIT(2)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_VOLATILE_MEM_ERR_PROG_WAR=
N_THRESHOLD_MASK \
+	BIT(3)
+#define CXL_CMD_ALERT_CONFIG_VALID_ALERTS_CORR_PMEM_ERR_PROG_WARN_THRESH=
OLD_MASK \
+	BIT(4)
+
+/* CXL 3.0 8.2.9.8.3.2 Get Alert Configuration Byte 1 Programmable Alert=
s */
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_M=
ASK    \
+	BIT(0)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_OVER_TEMPERATURE_PROG_WARN_=
THRESHOLD_MASK \
+	BIT(1)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_DEV_UNDER_TEMPERATURE_PROG_WARN=
_THRESHOLD_MASK \
+	BIT(2)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_VOLATILE_MEM_ERR_PROG_WARN=
_THRESHOLD_MASK \
+	BIT(3)
+#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_CORR_PMEM_ERR_PROG_WARN_THRESHO=
LD_MASK \
+	BIT(4)
+
 struct cxl_cmd_get_partition {
 	le64 active_volatile;
 	le64 active_persistent;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99..8b4b182 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -354,6 +354,41 @@ int cxl_cmd_health_info_get_temperature(struct cxl_c=
md *cmd);
 int cxl_cmd_health_info_get_dirty_shutdowns(struct cxl_cmd *cmd);
 int cxl_cmd_health_info_get_volatile_errors(struct cxl_cmd *cmd);
 int cxl_cmd_health_info_get_pmem_errors(struct cxl_cmd *cmd);
+struct cxl_cmd *cxl_cmd_new_get_alert_config(struct cxl_memdev *memdev);
+int cxl_cmd_alert_config_life_used_prog_warn_threshold_valid(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_valid(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_valid=
(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_=
valid(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_valid(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_writab=
le(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_writa=
ble(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_=
writable(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_writable=
(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_life_used_crit_alert_threshold(struct cxl_c=
md *cmd);
+int cxl_cmd_alert_config_get_life_used_prog_warn_threshold(struct cxl_cm=
d *cmd);
+int cxl_cmd_alert_config_get_dev_over_temperature_crit_alert_threshold(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_under_temperature_crit_alert_threshold(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_over_temperature_prog_warn_threshold(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_dev_under_temperature_prog_warn_threshold(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_corrected_volatile_mem_err_prog_warn_thresh=
old(
+	struct cxl_cmd *cmd);
+int cxl_cmd_alert_config_get_corrected_pmem_err_prog_warn_threshold(
+	struct cxl_cmd *cmd);
 struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_memdev *memdev,
 		unsigned int offset, unsigned int length);
 ssize_t cxl_cmd_read_label_get_payload(struct cxl_cmd *cmd, void *buf,
--=20
2.30.2

