Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45592C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiKNUdc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbiKNUdb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:33:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAAC645C
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668458009; x=1699994009;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f5YG+uIWnLHJyHDG0GXZgolJd39mYA+YNYTqCRa+xMU=;
  b=m6MVrHAcdOa+5fI1igfjt7yF+1Qk5pLoYCy5n9wxV2I0DDrGrYLw4i8Z
   HRQ6jOU+yI29XrFtNEyGqvueBUCDuGZbbsShr3nMzrGHnvNY/+HpLt06h
   UhltbSG9oabwji9QT8hUxwfO33VSErNUwQhjEb+95VEzs6PBjrHrSPE6M
   HaD6SVolxMiKQE7n6iTxVtJT2pb2EERmh0R0gDOFGd3uXnFznetWk123t
   /0a2EeuBajdgHPrQoH8p2hiteKdFDGGHy85Ht+97j/St8xIDIrAh5J1Ik
   d1pCUIHAdzARrDRWvgrZ056PnJ9Ca8rzkMmdg3YtcX4mMT02ICAgFMAcT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="291789910"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="291789910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:33:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="671711572"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="671711572"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:33:27 -0800
Subject: [PATCH v4 04/18] tools/testing/cxl: Add "Set Passphrase" opcode
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Mon, 14 Nov 2022 13:33:27 -0700
Message-ID: <166845800756.2496228.7914346886420621330.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device supporting the "Set Passphrase"
operation. The operation supports setting of either a user or a master
passphrase.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c       |   81 ++++++++++++++++++++++++++++++++++++
 tools/testing/cxl/test/mem_pdata.h |    6 +++
 2 files changed, 87 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9002a3ae3ea5..0fac0ca81290 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -154,6 +154,84 @@ static int mock_get_security_state(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static void master_plimit_check(struct cxl_mock_mem_pdata *mdata)
+{
+	if (mdata->master_limit == PASS_TRY_LIMIT)
+		return;
+	mdata->master_limit++;
+	if (mdata->master_limit == PASS_TRY_LIMIT)
+		mdata->security_state |= CXL_PMEM_SEC_STATE_MASTER_PLIMIT;
+}
+
+static void user_plimit_check(struct cxl_mock_mem_pdata *mdata)
+{
+	if (mdata->user_limit == PASS_TRY_LIMIT)
+		return;
+	mdata->user_limit++;
+	if (mdata->user_limit == PASS_TRY_LIMIT)
+		mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PLIMIT;
+}
+
+static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
+	struct cxl_set_pass *set_pass;
+
+	if (cmd->size_in != sizeof(*set_pass))
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_FROZEN) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	set_pass = cmd->payload_in;
+	switch (set_pass->type) {
+	case CXL_PMEM_SEC_PASS_MASTER:
+		if (mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT) {
+			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+			return -ENXIO;
+		}
+		/*
+		 * CXL spec rev3.0 8.2.9.8.6.2, The master pasphrase shall only be set in
+		 * the security disabled state when the user passphrase is not set.
+		 */
+		if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
+			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+			return -ENXIO;
+		}
+		if (memcmp(mdata->master_pass, set_pass->old_pass, NVDIMM_PASSPHRASE_LEN)) {
+			master_plimit_check(mdata);
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+		memcpy(mdata->master_pass, set_pass->new_pass, NVDIMM_PASSPHRASE_LEN);
+		mdata->security_state |= CXL_PMEM_SEC_STATE_MASTER_PASS_SET;
+		return 0;
+
+	case CXL_PMEM_SEC_PASS_USER:
+		if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PLIMIT) {
+			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+			return -ENXIO;
+		}
+		if (memcmp(mdata->user_pass, set_pass->old_pass, NVDIMM_PASSPHRASE_LEN)) {
+			user_plimit_check(mdata);
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+		memcpy(mdata->user_pass, set_pass->new_pass, NVDIMM_PASSPHRASE_LEN);
+		mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PASS_SET;
+		return 0;
+
+	default:
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+	}
+	return -EINVAL;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -250,6 +328,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_SECURITY_STATE:
 		rc = mock_get_security_state(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_SET_PASSPHRASE:
+		rc = mock_set_passphrase(cxlds, cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/tools/testing/cxl/test/mem_pdata.h b/tools/testing/cxl/test/mem_pdata.h
index 6a7b111147eb..8eb2dffc9156 100644
--- a/tools/testing/cxl/test/mem_pdata.h
+++ b/tools/testing/cxl/test/mem_pdata.h
@@ -5,6 +5,12 @@
 
 struct cxl_mock_mem_pdata {
 	u32 security_state;
+	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
+	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
+	int user_limit;
+	int master_limit;
 };
 
+#define PASS_TRY_LIMIT 3
+
 #endif


