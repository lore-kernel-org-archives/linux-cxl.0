Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FCEC4167B
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiKNUeL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiKNUeE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:34:04 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F6299
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668458044; x=1699994044;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3A6u296BD6wlOLz01NAstcJwYf5ODnG496xihrE6K4=;
  b=JV7DUtSJ+MP0HZtaNApSTzT3Ukv2Pq6Lxq7zD8ef3DPTfUWd+n3OxFr2
   YFKSlwpmOkkaaQ49dYSuFDIDndNrOwjUwIYDKX7lbFArN0Gp6URCAnfdR
   f34PFg/J6v+S1K+KZgbuLimTGCmjZD4lxIfJur4beeNUw4EEliRwSvZeZ
   6Wh4dsX37JREwJ3ygTm8AyUMO8jKuJiKE2EWZ5iuC+hZsSV1+90bVVS+Q
   bIcB3Lp9B2QeF3zUQ2T+jNE6pNfR8NmX1D2NbuXrC+UjvJaSJeqQKxyai
   Nkgz5V+odFilcmaimrg/R5yfzITH9T7RMw/BJhfQ86CDtwVjHLPG7eMfi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="299596807"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="299596807"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707460624"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="707460624"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:34:02 -0800
Subject: [PATCH v4 10/18] tools/testing/cxl: Add "Unlock" security opcode
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Mon, 14 Nov 2022 13:34:02 -0700
Message-ID: <166845804266.2496228.12502338922736446162.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "Unlock" operation.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 0cb2e3035636..90607597b9a4 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -320,6 +320,48 @@ static int mock_freeze_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return 0;
 }
 
+static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
+
+	if (cmd->size_in != NVDIMM_PASSPHRASE_LEN)
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
+	if (!(mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PLIMIT) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (!(mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (memcmp(cmd->payload_in, mdata->user_pass, NVDIMM_PASSPHRASE_LEN)) {
+		if (++mdata->user_limit == PASS_TRY_LIMIT)
+			mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PLIMIT;
+		cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+		return -ENXIO;
+	}
+
+	mdata->user_limit = 0;
+	mdata->security_state &= ~CXL_PMEM_SEC_STATE_LOCKED;
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -425,6 +467,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_FREEZE_SECURITY:
 		rc = mock_freeze_security(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_UNLOCK:
+		rc = mock_unlock_security(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


