Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C5EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjFOB3y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjFOB3y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:29:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C22126
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792592; x=1718328592;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52YLEOmB7ywKoy5M5dVBfgzsMeRy7+Nk1rUhsE8ftVE=;
  b=We6ZqEtx1dbHh/uL6G12mgGhbY2d5WCDGPPdrX4lxf471z7+pgE06VkY
   fkyfcCerh/oTBCgh6DJnC3gjC6FKxuO0FvW2W1eXfPQWBdfqE/b3Xgcml
   7BLlZqAsGfVS/OLlmdE6Zw4fJ9+hZRjlaexeKZ9JMHBWEHvqf4flg3muR
   RwDrFM81wlJ6bLwsymT2L7LUWGno9dZqTO9oHGPcnSHR02s+wkcMqRqVV
   qbLqn8CxMroKlxrT/KcN4OKs8jsPqH/hGNDEPkYKcIQ1Gps4NUvxBjL4B
   s8HJVHjOWytUfmTMOd84t2CtH6rj2/+jmpwoarZNcYEN0tV3/fVSbIW7V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445150645"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="445150645"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="689600009"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="689600009"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:46 -0700
Subject: [PATCH v2 02/12] tools/testing/cxl: Remove unused @cxlds argument
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Wed, 14 Jun 2023 18:29:46 -0700
Message-ID: <168679258640.3436160.7641308222525246728.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for plumbing a 'struct cxl_memdev_state' as a superset of
a 'struct cxl_dev_state' cleanup the usage of @cxlds in the unit test
infrastructure.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/mem.c |   86 +++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 47 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 34b48027b3de..bdaf086d994e 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -180,8 +180,7 @@ static void mes_add_event(struct mock_event_store *mes,
 	log->nr_events++;
 }
 
-static int mock_get_event(struct cxl_dev_state *cxlds,
-			  struct cxl_mbox_cmd *cmd)
+static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_get_event_payload *pl;
 	struct mock_event_log *log;
@@ -201,7 +200,7 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
 
 	memset(cmd->payload_out, 0, cmd->size_out);
 
-	log = event_find_log(cxlds->dev, log_type);
+	log = event_find_log(dev, log_type);
 	if (!log || event_log_empty(log))
 		return 0;
 
@@ -234,8 +233,7 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-static int mock_clear_event(struct cxl_dev_state *cxlds,
-			    struct cxl_mbox_cmd *cmd)
+static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
 	struct mock_event_log *log;
@@ -246,7 +244,7 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
 	if (log_type >= CXL_EVENT_TYPE_MAX)
 		return -EINVAL;
 
-	log = event_find_log(cxlds->dev, log_type);
+	log = event_find_log(dev, log_type);
 	if (!log)
 		return 0; /* No mock data in this log */
 
@@ -256,7 +254,7 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
 	 * However, this is not good behavior for the host so test it.
 	 */
 	if (log->clear_idx + pl->nr_recs > log->cur_idx) {
-		dev_err(cxlds->dev,
+		dev_err(dev,
 			"Attempting to clear more events than returned!\n");
 		return -EINVAL;
 	}
@@ -266,7 +264,7 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
 	     nr < pl->nr_recs;
 	     nr++, handle++) {
 		if (handle != le16_to_cpu(pl->handles[nr])) {
-			dev_err(cxlds->dev, "Clearing events out of order\n");
+			dev_err(dev, "Clearing events out of order\n");
 			return -EINVAL;
 		}
 	}
@@ -477,7 +475,7 @@ static int mock_get_log(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
-static int mock_rcd_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_rcd_id(struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_identify id = {
 		.fw_revision = { "mock fw v1 " },
@@ -495,7 +493,7 @@ static int mock_rcd_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
-static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_id(struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_identify id = {
 		.fw_revision = { "mock fw v1 " },
@@ -517,8 +515,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
-static int mock_partition_info(struct cxl_dev_state *cxlds,
-			       struct cxl_mbox_cmd *cmd)
+static int mock_partition_info(struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_partition_info pi = {
 		.active_volatile_cap =
@@ -535,11 +532,9 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-static int mock_get_security_state(struct cxl_dev_state *cxlds,
+static int mock_get_security_state(struct cxl_mockmem_data *mdata,
 				   struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
-
 	if (cmd->size_in)
 		return -EINVAL;
 
@@ -569,9 +564,9 @@ static void user_plimit_check(struct cxl_mockmem_data *mdata)
 		mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PLIMIT;
 }
 
-static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_set_passphrase(struct cxl_mockmem_data *mdata,
+			       struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
 	struct cxl_set_pass *set_pass;
 
 	if (cmd->size_in != sizeof(*set_pass))
@@ -629,9 +624,9 @@ static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return -EINVAL;
 }
 
-static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_disable_passphrase(struct cxl_mockmem_data *mdata,
+				   struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
 	struct cxl_disable_pass *dis_pass;
 
 	if (cmd->size_in != sizeof(*dis_pass))
@@ -700,10 +695,9 @@ static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_
 	return 0;
 }
 
-static int mock_freeze_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_freeze_security(struct cxl_mockmem_data *mdata,
+				struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
-
 	if (cmd->size_in != 0)
 		return -EINVAL;
 
@@ -717,10 +711,9 @@ static int mock_freeze_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return 0;
 }
 
-static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_unlock_security(struct cxl_mockmem_data *mdata,
+				struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
-
 	if (cmd->size_in != NVDIMM_PASSPHRASE_LEN)
 		return -EINVAL;
 
@@ -759,10 +752,9 @@ static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return 0;
 }
 
-static int mock_passphrase_secure_erase(struct cxl_dev_state *cxlds,
+static int mock_passphrase_secure_erase(struct cxl_mockmem_data *mdata,
 					struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
 	struct cxl_pass_erase *erase;
 
 	if (cmd->size_in != sizeof(*erase))
@@ -858,10 +850,10 @@ static int mock_passphrase_secure_erase(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_get_lsa(struct cxl_mockmem_data *mdata,
+			struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
 	void *lsa = mdata->lsa;
 	u32 offset, length;
 
@@ -878,10 +870,10 @@ static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
-static int mock_set_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+static int mock_set_lsa(struct cxl_mockmem_data *mdata,
+			struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_set_lsa *set_lsa = cmd->payload_in;
-	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
 	void *lsa = mdata->lsa;
 	u32 offset, length;
 
@@ -896,8 +888,7 @@ static int mock_set_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	return 0;
 }
 
-static int mock_health_info(struct cxl_dev_state *cxlds,
-			    struct cxl_mbox_cmd *cmd)
+static int mock_health_info(struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_health_info health_info = {
 		/* set flags for maint needed, perf degraded, hw replacement */
@@ -1117,6 +1108,7 @@ ATTRIBUTE_GROUPS(cxl_mock_mem_core);
 static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct device *dev = cxlds->dev;
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
 	int rc = -EIO;
 
 	switch (cmd->opcode) {
@@ -1131,45 +1123,45 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 		break;
 	case CXL_MBOX_OP_IDENTIFY:
 		if (cxlds->rcd)
-			rc = mock_rcd_id(cxlds, cmd);
+			rc = mock_rcd_id(cmd);
 		else
-			rc = mock_id(cxlds, cmd);
+			rc = mock_id(cmd);
 		break;
 	case CXL_MBOX_OP_GET_LSA:
-		rc = mock_get_lsa(cxlds, cmd);
+		rc = mock_get_lsa(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_GET_PARTITION_INFO:
-		rc = mock_partition_info(cxlds, cmd);
+		rc = mock_partition_info(cmd);
 		break;
 	case CXL_MBOX_OP_GET_EVENT_RECORD:
-		rc = mock_get_event(cxlds, cmd);
+		rc = mock_get_event(dev, cmd);
 		break;
 	case CXL_MBOX_OP_CLEAR_EVENT_RECORD:
-		rc = mock_clear_event(cxlds, cmd);
+		rc = mock_clear_event(dev, cmd);
 		break;
 	case CXL_MBOX_OP_SET_LSA:
-		rc = mock_set_lsa(cxlds, cmd);
+		rc = mock_set_lsa(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_GET_HEALTH_INFO:
-		rc = mock_health_info(cxlds, cmd);
+		rc = mock_health_info(cmd);
 		break;
 	case CXL_MBOX_OP_GET_SECURITY_STATE:
-		rc = mock_get_security_state(cxlds, cmd);
+		rc = mock_get_security_state(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_SET_PASSPHRASE:
-		rc = mock_set_passphrase(cxlds, cmd);
+		rc = mock_set_passphrase(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
-		rc = mock_disable_passphrase(cxlds, cmd);
+		rc = mock_disable_passphrase(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_FREEZE_SECURITY:
-		rc = mock_freeze_security(cxlds, cmd);
+		rc = mock_freeze_security(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_UNLOCK:
-		rc = mock_unlock_security(cxlds, cmd);
+		rc = mock_unlock_security(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
-		rc = mock_passphrase_secure_erase(cxlds, cmd);
+		rc = mock_passphrase_secure_erase(mdata, cmd);
 		break;
 	case CXL_MBOX_OP_GET_POISON:
 		rc = mock_get_poison(cxlds, cmd);

