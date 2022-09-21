Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D7FC6FA8E
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiIUPix (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiIUPig (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:38:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D79CCC4
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774465; x=1695310465;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J2PH9cZxD9bCIBtWJm67M5TAik0pcRFQWorUFoXwBEw=;
  b=h8Q5Sx0JPHiy5Erb2QS2z1fYhKCco7Xl4W/x/ORReGjZqTf+LmNOR4Ye
   OAvzdqGfjYWvR2IvniMVBdvWMJWmulxZhx2wIokAGc1USvyqS4273yDee
   FFdXa8p/I4mTnJm6Bw1lsU2bTxZZY1VSN/VRa7/4cBwG6RmXCU2kn+kRx
   wMpVgX5nc2Dw3AWHyr+GdTIP2Wl/rmjkZO7rwMnvM0wEUo5wxfJaUHyB8
   3xFR3X39LcO3BUp0NgWbGEigmd2y/8wVYlnN05b3zkuPIWebfJWX4u+HH
   dPzt+Sc8co6xdKxi7NNcjAUscsD8Sp9EazuJfPoX4ewnTweEjSm/L2Sq/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="300877097"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="300877097"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597034775"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:46 -0700
Subject: [PATCH v2 13/19] tools/testing/cxl: Add "passphrase secure erase"
 opcode support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:32:46 -0700
Message-ID: <166377436599.430546.9691226328917294997.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
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
 tools/testing/cxl/test/mem.c |   56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 840378d239bf..a0a58156c15a 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -356,6 +356,59 @@ static int mock_unlock_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return 0;
 }
 
+static int mock_passphrase_erase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
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
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_FROZEN) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PLIMIT) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	erase = cmd->payload_in;
+	if (erase->type == CXL_PMEM_SEC_PASS_MASTER &&
+	    mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PASS_SET &&
+	    memcmp(mdata->master_pass, erase->pass, NVDIMM_PASSPHRASE_LEN)) {
+		if (++mdata->master_limit == PASS_TRY_LIMIT)
+			mdata->security_state |= CXL_PMEM_SEC_STATE_MASTER_PLIMIT;
+		cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+		return -ENXIO;
+	}
+
+	if (erase->type == CXL_PMEM_SEC_PASS_USER &&
+	    mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET &&
+	    memcmp(mdata->user_pass, erase->pass, NVDIMM_PASSPHRASE_LEN)) {
+		if (++mdata->user_limit == PASS_TRY_LIMIT)
+			mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PLIMIT;
+		cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+		return -ENXIO;
+	}
+
+	if (erase->type == CXL_PMEM_SEC_PASS_USER) {
+		mdata->security_state &= ~CXL_PMEM_SEC_STATE_USER_PASS_SET;
+		mdata->user_limit = 0;
+		memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
+	} else if (erase->type == CXL_PMEM_SEC_PASS_MASTER) {
+		mdata->master_limit = 0;
+	}
+
+	mdata->security_state &= ~CXL_PMEM_SEC_STATE_LOCKED;
+
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -464,6 +517,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_UNLOCK:
 		rc = mock_unlock_security(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_PASSPHRASE_ERASE:
+		rc = mock_passphrase_erase(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


