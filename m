Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5809C6FA8E
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Sep 2022 15:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiIUPjH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIUPit (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Sep 2022 11:38:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFE847BA5
        for <linux-cxl@vger.kernel.org>; Wed, 21 Sep 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663774483; x=1695310483;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ukPqBYOuTgVnjKvlbKVtSBph+np5dqkXb2a4549PHJ4=;
  b=HWkcYFJ2pDSvnr4yCKmGUWS3zcnwXDGopl+PrDgCNkRRehIOhtXmdYue
   9ym0Sat9gDyYHpQhKgY53JoD1u5xwtZHaKWnaUoTllJvVcA813Pf3QIHe
   2l4krBklKgepzSBCAj+ISf7buhHZVZl+En+hisvMcdialJDhswBHPGPEo
   c20Qqf6XuohlGcSjiiuG0AiUaYDk3FFSrw/7YZ3GosLkAYDK6PPkDw6QP
   Gd3u/Y3SuxFC8SRii4jiflkGzRxxwwxbXT7SzUUHusvhJXgVi5Art4z0v
   7SSmiXDWeDJYtbC+7FhlKt03aZUzUkTc5O3U3dHuRY/Dwo83bBhcq8syr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301438212"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="301438212"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="597034692"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 08:32:22 -0700
Subject: [PATCH v2 09/19] tools/testing/cxl: Add "Freeze Security State"
 security opcode support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net,
        Jonathan.Cameron@huawei.com
Date:   Wed, 21 Sep 2022 08:32:22 -0700
Message-ID: <166377434213.430546.16329545604946404040.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "Freeze Security State"
operation.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 40dccbeb9f30..b24119b0ea76 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -290,6 +290,30 @@ static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_
 	return 0;
 }
 
+static int mock_freeze_security(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
+
+	if (cmd->size_in != 0)
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
+	mdata->security_state |= CXL_PMEM_SEC_STATE_FROZEN;
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -392,6 +416,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
 		rc = mock_disable_passphrase(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_FREEZE_SECURITY:
+		rc = mock_freeze_security(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


