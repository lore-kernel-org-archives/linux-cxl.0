Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D79C43334
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 21:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiGOVJf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiGOVJ1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 17:09:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9FF71BEC
        for <linux-cxl@vger.kernel.org>; Fri, 15 Jul 2022 14:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657919361; x=1689455361;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmRKgFBgyiPqG7OL7LtVwwfafKuadNDkkCfVrQRh8TE=;
  b=cbskZv/BD+Itn/q0ZpNJisotmX+8sOpGoVgLUFG/WpvAO6gaDkriICgy
   Apkg62pkY+4QRslEyikaBD2UmlL8G1IXo/FUYU9On2YjJw3r+liEdiIij
   LsbBiaPJIvITX7KmzBxjqZxNIzI5zHLmAQ4iMeAEugN8xQVotace44n0Q
   8QiV9zegiAqSPsAtEEjJOObm6c28ca47AkUCg6dbBjpAXiMkPV+3b3oA/
   4G8wWbL2gywnKSNlceb2wBfTfZKMxfbf+mi7Ho1hv5lalmOefHGP5d+L2
   9DOWWcakCP5a57Rl1Bdd0RHm8BaIv2k/ZJtXYPeofhQF555qXQ4PybE8w
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="311568565"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="311568565"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:09:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="571680678"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:09:13 -0700
Subject: [PATCH RFC 07/15] tools/testing/cxl: Add "Disable" security opcode
 support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dave@stgolabs.net
Date:   Fri, 15 Jul 2022 14:09:12 -0700
Message-ID: <165791935297.2491387.8950514630973579122.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
References: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   80 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 796f4f7b5e3d..5f87a94d92ae 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -235,6 +235,83 @@ static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd
 	return 0;
 }
 
+static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct mock_mdev_data *mdata = dev_get_drvdata(cxlds->dev);
+	struct cxl_disable_pass *dis_pass;
+
+	if (cmd->size_in != sizeof(*dis_pass)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	if (cmd->size_out != 0) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
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
+			if (++mdata->master_limit == PASS_TRY_LIMIT)
+				mdata->security_state |= CXL_PMEM_SEC_STATE_MASTER_PLIMIT;
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+
+		mdata->master_limit = 0;
+		memset(mdata->master_pass, 0, NVDIMM_PASSPHRASE_LEN);
+		mdata->security_state &= ~CXL_PMEM_SEC_STATE_MASTER_PASS_SET;
+		break;
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
+			if (++mdata->user_limit == PASS_TRY_LIMIT)
+				mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PLIMIT;
+			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
+			return -ENXIO;
+		}
+
+		mdata->user_limit = 0;
+		memset(mdata->user_pass, 0, NVDIMM_PASSPHRASE_LEN);
+		mdata->security_state &= ~(CXL_PMEM_SEC_STATE_USER_PASS_SET |
+					   CXL_PMEM_SEC_STATE_LOCKED);
+		break;
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
@@ -333,6 +410,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_SET_PASSPHRASE:
 		rc = mock_set_passphrase(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
+		rc = mock_disable_passphrase(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


