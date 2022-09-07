Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C3DC6FA8A
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Sep 2022 17:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiIGRAw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Sep 2022 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGRAu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Sep 2022 13:00:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF098A7F7
        for <linux-cxl@vger.kernel.org>; Wed,  7 Sep 2022 10:00:48 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287FnG76019914
        for <linux-cxl@vger.kernel.org>; Wed, 7 Sep 2022 10:00:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=T64Tsr0tG4Gh/S/o5zgJp75M75p56aS5SKTk11sS3gQ=;
 b=PcZTqbQUhPp2x/X6xUHqZUaVvv78BwNmxmI8vnOAJmnHSktVLSsNQq8EhWqxpQlPcvbZ
 /xPQrALrlhSaz+UxU9czl7SZaqid8KhN1yeHbKpNMN2Dq6AriNj5EWTBNoomh84OVImX
 AtDoOYRxieHbDcyQGevVDXRvMYOv48G43G8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jdwuqupkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-cxl@vger.kernel.org>; Wed, 07 Sep 2022 10:00:47 -0700
Received: from twshared11415.03.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 10:00:46 -0700
Received: by devvm2259.atn0.facebook.com (Postfix, from userid 175343)
        id 978D11AEFD83B; Wed,  7 Sep 2022 10:00:37 -0700 (PDT)
From:   Jonathan Zhang <jonzhang@fb.com>
To:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>
CC:     Jonathan Zhang <jonzhang@fb.com>
Subject: [PATCH] [RFC]cxl: add get-alert-config command
Date:   Wed, 7 Sep 2022 10:00:35 -0700
Message-ID: <20220907170035.1603015-1-jonzhang@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5OZAYgPtVUYnm5UAnDdHOrJjHLizjT4P
X-Proofpoint-ORIG-GUID: 5OZAYgPtVUYnm5UAnDdHOrJjHLizjT4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This is a RFC patch. If the idea looks okay, I think this patch
should be split into 3 patches: one for libcxl, another to add
the get-alert-config command, another to add the man page.

TESTED=3Don a CXL 1.1 host + CXL 2.0 device (RCRB mode) configuration:
[root@suncl2h1 cxlcli-test]# ../tmp/cxl get-alert-config mem0
alert_config summary
    valid_alerts: 0x8
    programmable_alerts: 0x8
    life_used_critical_alert_threshold: 0x0
    life_used_prog_warn_threshold: 0x0
    dev_over_temp_crit_alert_threshold: 0x0
    dev_under_temp_crit_alert_threshold: 0x0
    dev_over_temp_prog_warn_threshold: 0x0
    dev_under_temp_prog_warn_threshold: 0x0
    corr_vol_mem_err_prog_warn_thresold: 0x0
    corr_pers_mem_err_prog_warn_threshold: 0x0

Signed-off-by: Jonathan Zhang <jonzhang@fb.com>
---
 Documentation/cxl/cxl-get-alert-config.txt | 28 ++++++++
 Documentation/cxl/lib/libcxl.txt           |  1 +
 Documentation/cxl/meson.build              |  1 +
 cxl/builtin.h                              |  1 +
 cxl/cxl.c                                  |  1 +
 cxl/lib/libcxl.c                           | 76 ++++++++++++++++++++++
 cxl/lib/libcxl.sym                         |  1 +
 cxl/libcxl.h                               |  1 +
 cxl/memdev.c                               | 18 +++++
 9 files changed, 128 insertions(+)
 create mode 100644 Documentation/cxl/cxl-get-alert-config.txt

diff --git a/Documentation/cxl/cxl-get-alert-config.txt b/Documentation/c=
xl/cxl-get-alert-config.txt
new file mode 100644
index 0000000..edebd74
--- /dev/null
+++ b/Documentation/cxl/cxl-get-alert-config.txt
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+cxl-get-alert-config(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+cxl-get-alert-config - Get Alert Configuration
+
+SYNOPSIS
+--------
+[verse]
+'cxl get-alert-config' <mem0> [<mem1>..<memN>] [<options>]
+
+This command retrieves the device's critical alert and programmable warn=
ing
+configuration. In the multi-memdev case the data is concatenated.
+
+OPTIONS
+-------
+-o::
+--output::
+	output file
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+CXL-3.0 8.2.9.8.3.2
diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/lib=
cxl.txt
index fd2962a..fd054be 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -125,6 +125,7 @@ struct cxl_cmd *cxl_cmd_new_read_label(struct cxl_mem=
dev *memdev,
 					unsigned int offset, unsigned int length);
 struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev, void =
*buf,
 					unsigned int offset, unsigned int length);
+int cxl_memdev_get_alert_config(struct cxl_memdev *memdev);
 int cxl_memdev_zero_label(struct cxl_memdev *memdev, size_t length,
 			  size_t offset);
 int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf, size_t l=
ength,
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.buil=
d
index 147ea71..d284eb9 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -41,6 +41,7 @@ cxl_manpages =3D [
   'cxl-set-partition.txt',
   'cxl-reserve-dpa.txt',
   'cxl-free-dpa.txt',
+  'cxl-get-alert-config.txt',
   'cxl-create-region.txt',
   'cxl-disable-region.txt',
   'cxl-enable-region.txt',
diff --git a/cxl/builtin.h b/cxl/builtin.h
index b28c221..0ca3c4b 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -10,6 +10,7 @@ int cmd_read_labels(int argc, const char **argv, struct=
 cxl_ctx *ctx);
 int cmd_zero_labels(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_init_labels(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_check_labels(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_get_alert_config(int argc, const char **argv, struct cxl_ctx *ct=
x);
 int cmd_disable_memdev(int argc, const char **argv, struct cxl_ctx *ctx)=
;
 int cmd_enable_memdev(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_reserve_dpa(int argc, const char **argv, struct cxl_ctx *ctx);
diff --git a/cxl/cxl.c b/cxl/cxl.c
index dd1be7a..5c120c7 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -64,6 +64,7 @@ static struct cmd_struct commands[] =3D {
 	{ "zero-labels", .c_fn =3D cmd_zero_labels },
 	{ "read-labels", .c_fn =3D cmd_read_labels },
 	{ "write-labels", .c_fn =3D cmd_write_labels },
+	{ "get-alert-config", .c_fn =3D cmd_get_alert_config },
 	{ "disable-memdev", .c_fn =3D cmd_disable_memdev },
 	{ "enable-memdev", .c_fn =3D cmd_enable_memdev },
 	{ "reserve-dpa", .c_fn =3D cmd_reserve_dpa },
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e8c5d44..1db5b2c 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -3140,6 +3140,82 @@ do {									\
 	return !!(c->field & mask);					\
 } while(0)
=20
+struct cxl_mbox_get_alert_config_out {
+	u8 valid_alerts;
+	u8 programmable_alerts;
+	u8 life_used_critical_alert_threshold;
+	u8 life_used_prog_warn_threshold;
+	__le16 dev_over_temp_crit_alert_threshold;
+	__le16 dev_under_temp_crit_alert_threshold;
+	__le16 dev_over_temp_prog_warn_threshold;
+	__le16 dev_under_temp_prog_warn_threshold;
+	__le16 corr_vol_mem_err_prog_warn_thresold;
+	__le16 corr_pers_mem_err_prog_warn_threshold;
+}  __attribute__((packed));
+
+CXL_EXPORT int cxl_memdev_get_alert_config(struct cxl_memdev *memdev)
+{
+	struct cxl_cmd *cmd;
+	struct cxl_mbox_get_alert_config_out *alert_config_out;
+	int rc =3D 0;
+
+	cmd =3D cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_GET_ALERT_CONFIG=
);
+	if (!cmd) {
+		fprintf(stderr, "%s: cxl_cmd_new_raw returned Null output\n",
+				cxl_memdev_get_devname(memdev));
+		return -ENOMEM;
+	}
+
+	rc =3D cxl_cmd_submit(cmd);
+	if (rc < 0) {
+		fprintf(stderr, "%s: cmd submission failed: %d (%s)\n",
+				cxl_memdev_get_devname(memdev), rc, strerror(-rc));
+		goto out;
+	}
+
+	rc =3D cxl_cmd_get_mbox_status(cmd);
+	if (rc !=3D 0) {
+		fprintf(stderr, "%s: firmware status: %d\n",
+				cxl_memdev_get_devname(memdev), rc);
+		rc =3D -ENXIO;
+		goto out;
+	}
+
+	if (cmd->send_cmd->id !=3D CXL_MEM_COMMAND_ID_GET_ALERT_CONFIG) {
+		fprintf(stderr, "%s: invalid command id 0x%x (expecting 0x%x)\n",
+				cxl_memdev_get_devname(memdev), cmd->send_cmd->id, CXL_MEM_COMMAND_I=
D_GET_ALERT_CONFIG);
+		return -EINVAL;
+	}
+
+	fprintf(stdout, "alert_config summary\n");
+
+	alert_config_out =3D (void *)cmd->send_cmd->out.payload;
+
+	fprintf(stdout, "    valid_alerts: 0x%x\n", alert_config_out->valid_ale=
rts);
+	fprintf(stdout, "    programmable_alerts: 0x%x\n", alert_config_out->pr=
ogrammable_alerts);
+	fprintf(stdout, "    life_used_critical_alert_threshold: 0x%x\n",
+		alert_config_out->life_used_critical_alert_threshold);
+	fprintf(stdout, "    life_used_prog_warn_threshold: 0x%x\n",
+		alert_config_out->life_used_prog_warn_threshold);
+
+	fprintf(stdout, "    dev_over_temp_crit_alert_threshold: 0x%x\n",
+		le16_to_cpu(alert_config_out->dev_over_temp_crit_alert_threshold));
+	fprintf(stdout, "    dev_under_temp_crit_alert_threshold: 0x%x\n",
+		le16_to_cpu(alert_config_out->dev_under_temp_crit_alert_threshold));
+	fprintf(stdout, "    dev_over_temp_prog_warn_threshold: 0x%x\n",
+		le16_to_cpu(alert_config_out->dev_over_temp_prog_warn_threshold));
+	fprintf(stdout, "    dev_under_temp_prog_warn_threshold: 0x%x\n",
+		le16_to_cpu(alert_config_out->dev_under_temp_prog_warn_threshold));
+	fprintf(stdout, "    corr_vol_mem_err_prog_warn_thresold: 0x%x\n",
+		le16_to_cpu(alert_config_out->corr_vol_mem_err_prog_warn_thresold));
+	fprintf(stdout, "    corr_pers_mem_err_prog_warn_threshold: 0x%x\n",
+		le16_to_cpu(alert_config_out->corr_pers_mem_err_prog_warn_threshold));
+
+out:
+	cxl_cmd_unref(cmd);
+	return rc;
+}
+
 CXL_EXPORT struct cxl_cmd *cxl_cmd_new_get_health_info(
 		struct cxl_memdev *memdev)
 {
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8bb91e0..c6dd658 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -20,6 +20,7 @@ global:
 	cxl_memdev_get_pmem_size;
 	cxl_memdev_get_ram_size;
 	cxl_memdev_get_firmware_verison;
+	cxl_memdev_get_alert_config;
 	cxl_cmd_get_devname;
 	cxl_cmd_new_raw;
 	cxl_cmd_set_input_payload;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99..e0b9418 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -60,6 +60,7 @@ int cxl_memdev_read_label(struct cxl_memdev *memdev, vo=
id *buf, size_t length,
 		size_t offset);
 int cxl_memdev_write_label(struct cxl_memdev *memdev, void *buf, size_t =
length,
 		size_t offset);
+int cxl_memdev_get_alert_config(struct cxl_memdev *memdev);
=20
 #define cxl_memdev_foreach(ctx, memdev) \
         for (memdev =3D cxl_memdev_get_first(ctx); \
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 0b3ad02..5d8cf6c 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -371,6 +371,16 @@ static int action_enable(struct cxl_memdev *memdev, =
struct action_context *actx)
 	return cxl_memdev_enable(memdev);
 }
=20
+static const struct option cmd_get_alert_config_options[] =3D {
+	BASE_OPTIONS(),
+	OPT_END(),
+};
+
+static int action_cmd_get_alert_config(struct cxl_memdev *memdev, struct=
 action_context *actx)
+{
+	return cxl_memdev_get_alert_config(memdev);
+}
+
 static int action_zero(struct cxl_memdev *memdev, struct action_context =
*actx)
 {
 	size_t size;
@@ -809,6 +819,14 @@ static int memdev_action(int argc, const char **argv=
, struct cxl_ctx *ctx,
 	return rc;
 }
=20
+int cmd_get_alert_config(int argc, const char **argv, struct cxl_ctx *ct=
x)
+{
+	int rc =3D memdev_action(argc, argv, ctx, action_cmd_get_alert_config, =
cmd_get_alert_config_options,
+			"cxl get-alert-config <mem0> [<mem1>..<memN>] [<options>]");
+
+	return rc >=3D 0 ? 0 : EXIT_FAILURE;
+}
+
 int cmd_write_labels(int argc, const char **argv, struct cxl_ctx *ctx)
 {
 	int count =3D memdev_action(argc, argv, ctx, action_write, write_option=
s,
--=20
2.30.2

