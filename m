Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DAAC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Oct 2021 05:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8C06103B
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Oct 2021 05:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhJRFPM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Oct 2021 01:15:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:41073 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRFPM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 18 Oct 2021 01:15:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="251625603"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="251625603"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 22:13:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="530116042"
Received: from jrgovind-mobl.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.45.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 22:13:00 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] tools/testing/cxl: add mock output for the GET_HEALTH_INFO command
Date:   Sun, 17 Oct 2021 23:12:51 -0600
Message-Id: <20211018051251.2289112-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; h=from:subject; bh=Ky0Fcjz6rOYWX6pjC+rFlZaJBdximZ2kT3E/nutLcNs=; b=owGbwMvMwCHGf25diOft7jLG02pJDIm5TA4nOy5z7prWWMDhpvjOvsebeVK4bn8kMwP7zLCT3LPU Vrh2lLIwiHEwyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCLxZgx/RfttrAItTf5r31gR8Gh31Q aRnyuCdk2veRStIZV+m31POMM/c6lMGWeRGZdeT+edsE3qxZ7sBzeFQs7kaD9nXyB4a5E/KwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add mocked health information for cxl_test memdevs. This allows
cxl-cli's 'list' command to display the canned health_info fields.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 tools/testing/cxl/test/mem.c | 48 ++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

Changes since v2[1]:
- Fix cpu_to_leXX for 32bit fields (Jonathan)
- Collect review tags

[1]: https://lore.kernel.org/r/20211011222826.184775-1-vishal.l.verma@intel.com

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 12a8437a9ca0..ab363e475a32 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -28,8 +28,24 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
 		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
+		.effect = cpu_to_le16(0),
+	},
 };
 
+/* See CXL 2.0 Table 181 Get Health Info Output Payload */
+struct cxl_mbox_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 ext_status;
+	u8 life_used;
+	__le16 temperature;
+	__le32 dirty_shutdowns;
+	__le32 volatile_errors;
+	__le32 pmem_errors;
+} __packed;
+
 static struct {
 	struct cxl_mbox_get_supported_logs gsl;
 	struct cxl_gsl_entry entry;
@@ -156,6 +172,35 @@ static int mock_set_lsa(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
+static int mock_health_info(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_health_info health_info = {
+		/* set flags for maint needed, perf degraded, hw replacement */
+		.health_status = 0x7,
+		/* set media status to "All Data Lost" */
+		.media_status = 0x3,
+		/*
+		 * set ext_status flags for:
+		 *  ext_life_used: normal,
+		 *  ext_temperature: critical,
+		 *  ext_corrected_volatile: warning,
+		 *  ext_corrected_persistent: normal,
+		 */
+		.ext_status = 0x18,
+		.life_used = 15,
+		.temperature = cpu_to_le16(25),
+		.dirty_shutdowns = cpu_to_le32(10),
+		.volatile_errors = cpu_to_le32(20),
+		.pmem_errors = cpu_to_le32(30),
+	};
+
+	if (cmd->size_out < sizeof(health_info))
+		return -EINVAL;
+
+	memcpy(cmd->payload_out, &health_info, sizeof(health_info));
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlm->dev;
@@ -177,6 +222,9 @@ static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
 	case CXL_MBOX_OP_SET_LSA:
 		rc = mock_set_lsa(cxlm, cmd);
 		break;
+	case CXL_MBOX_OP_GET_HEALTH_INFO:
+		rc = mock_health_info(cxlm, cmd);
+		break;
 	default:
 		break;
 	}

base-commit: ed97afb53365cd03dde266c9644334a558fe5a16
-- 
2.31.1

