Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8A0C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Nov 2022 21:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiKPVSX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiKPVSV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Nov 2022 16:18:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910895656E
        for <linux-cxl@vger.kernel.org>; Wed, 16 Nov 2022 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633500; x=1700169500;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ajf6HubTFMIfnDgq3pFQk0wnESJOLbyI5U+4nv7STPI=;
  b=hL5sorrPXiuD8wrLWmle0ZXmm/skHPT6L8fVXMZLp+t1l/QjagfbF+MT
   F4j00jPNGhuZK2ZpY6f4OSpftP88J+VW/n8tsM38rxHiKNGpGZgKfRwWP
   WAqj5j9ppn/Tcu22glx9TSLIKcnEcmhEd4Cul/nl1dSxjNA6LYBqJJwEX
   6Rnz88QdcyTWEO1DF8vnakdZW7hkcpCTYAK38XJjXkhlOnk6z51vkwyg/
   Q26opeJaXeLrz72gFc9fWP+c1J9pAKgK5RKINA2lf5Rb6SKnom/FaBo/j
   fLT6uL49sP/9DFcK4ZItarJMkvzDg8QZDQs/RQl1fja+ffSAYD6hDwS65
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292378102"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292378102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:18:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590346609"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590346609"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:18:19 -0800
Subject: [PATCH v5 06/18] tools/testing/cxl: Add "Disable" security opcode
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        benjamin.cheatham@amd.com
Date:   Wed, 16 Nov 2022 14:18:19 -0700
Message-ID: <166863349914.80269.5110449192950675634.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
References: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "Disable Passphrase"
operation. The operation supports disabling of either a user or a master
passphrase. The emulation will provide support for both user and master
passphrase.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   74 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 0fac0ca81290..d8bb30d82a8f 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -232,6 +232,77 @@ static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return -EINVAL;
 }
 
+static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
+	struct cxl_disable_pass *dis_pass;
+
+	if (cmd->size_in != sizeof(*dis_pass))
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
+	dis_pass = cmd->payload_in;
+	switch (dis_pass->type) {
+	case CXL_PMEM_SEC_PASS_MASTER:
+		if (mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT) {
+			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+			return -ENXIO;
+		}
+
+		if (!(mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PASS_SET)) {
+			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+			return -ENXIO;
+		}
+
+		if (memcmp(dis_pass->pass, mdata->master_pass, NVDIMM_PASSPHRASE_LEN)) {
+			master_plimit_check(mdata);
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+
+		mdata->master_limit = 0;
+		memset(mdata->master_pass, 0, NVDIMM_PASSPHRASE_LEN);
+		mdata->security_state &= ~CXL_PMEM_SEC_STATE_MASTER_PASS_SET;
+		return 0;
+
+	case CXL_PMEM_SEC_PASS_USER:
+		if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PLIMIT) {
+			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+			return -ENXIO;
+		}
+
+		if (!(mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET)) {
+			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+			return -ENXIO;
+		}
+
+		if (memcmp(dis_pass->pass, mdata->user_pass, NVDIMM_PASSPHRASE_LEN)) {
+			user_plimit_check(mdata);
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+
+		mdata->user_limit = 0;
+		memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
+		mdata->security_state &= ~(CXL_PMEM_SEC_STATE_USER_PASS_SET |
+					   CXL_PMEM_SEC_STATE_LOCKED);
+		return 0;
+
+	default:
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -331,6 +402,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_SET_PASSPHRASE:
 		rc = mock_set_passphrase(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
+		rc = mock_disable_passphrase(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


