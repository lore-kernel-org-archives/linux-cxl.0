Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24276C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Nov 2022 21:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiKPVS7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiKPVS6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Nov 2022 16:18:58 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551CED2CC
        for <linux-cxl@vger.kernel.org>; Wed, 16 Nov 2022 13:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633536; x=1700169536;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G74URw7M9oueTh+YyB2O0d+WftTdOtOzBbKPbYJXsWI=;
  b=lDQYJw3jLet6DGZxXDDYGD74snp3Wd2YdW8KoNGmA57cp+qtMChv7hUv
   gNvjivjr2LT/2gGdYuInak2rZYHaf+FE/5X8uO5siSCFr0yhe/CY9qHTJ
   jhspJBUswyj0SFpLllWfCHNKpmPOS+kcnAyyCOQaSI1thS1p57fw4G/ro
   8Mzq4sV0xCTFaD1dPW7mETqBxVb9raoFen1ZUP/CB56DO/4PusS5cJ6ML
   rDVqVczR01WhbeEjvpbm++4OwYnKvYZ0yEcchs1gawHzxQynQcLQE7uYz
   HBmCy24iJMRbgamzaDdwIN0oZ3enoxG6dsOaVAozu+Vn/aLPIJ6TOZFM7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="312686305"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="312686305"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:18:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="617330348"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="617330348"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:18:55 -0800
Subject: [PATCH v5 12/18] tools/testing/cxl: Add "passphrase secure erase"
 opcode support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        benjamin.cheatham@amd.com
Date:   Wed, 16 Nov 2022 14:18:54 -0700
Message-ID: <166863353476.80269.9465534200608919114.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
References: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "passphrase secure
erase" operation.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   87 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 90607597b9a4..38f1cea0a353 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -362,6 +362,90 @@ static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return 0;
 }
 
+static int mock_passphrase_secure_erase(struct cxl_dev_state *cxlds,
+					struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
+	struct cxl_pass_erase *erase;
+
+	if (cmd->size_in != sizeof(*erase))
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	erase = cmd->payload_in;
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_FROZEN) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PLIMIT &&
+	    erase->type == CXL_PMEM_SEC_PASS_USER) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT &&
+	    erase->type == CXL_PMEM_SEC_PASS_MASTER) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	switch (erase->type) {
+	case CXL_PMEM_SEC_PASS_MASTER:
+		/*
+		 * The spec does not clearly define the behavior of the scenario
+		 * where a master passphrase is passed in while the master
+		 * passphrase is not set and user passphrase is not set. The
+		 * code will take the assumption that it will behave the same
+		 * as a CXL secure erase command without passphrase (0x4401).
+		 */
+		if (mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PASS_SET) {
+			if (memcmp(mdata->master_pass, erase->pass,
+				   NVDIMM_PASSPHRASE_LEN)) {
+				master_plimit_check(mdata);
+				cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+				return -ENXIO;
+			}
+			mdata->master_limit = 0;
+			mdata->user_limit = 0;
+			mdata->security_state &= ~CXL_PMEM_SEC_STATE_USER_PASS_SET;
+			memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
+			mdata->security_state &= ~CXL_PMEM_SEC_STATE_LOCKED;
+		} else if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
+			return -EINVAL;
+		}
+		/* Scramble encryption keys so that data is effectively erased */
+		break;
+	case CXL_PMEM_SEC_PASS_USER:
+		/*
+		 * The spec does not clearly define the behavior of the scenario
+		 * where a user passphrase is passed in while the user
+		 * passphrase is not set. The code will take the assumption that
+		 * it will behave the same as a CXL secure erase command without
+		 * passphrase (0x4401).
+		 */
+		if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
+			if (memcmp(mdata->user_pass, erase->pass,
+				   NVDIMM_PASSPHRASE_LEN)) {
+				user_plimit_check(mdata);
+				cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+				return -ENXIO;
+			}
+			mdata->user_limit = 0;
+			mdata->security_state &= ~CXL_PMEM_SEC_STATE_USER_PASS_SET;
+			memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
+		}
+		/* Scramble encryption keys so that data is effectively erased */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -470,6 +554,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_UNLOCK:
 		rc = mock_unlock_security(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
+		rc = mock_passphrase_secure_erase(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


