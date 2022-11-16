Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE22C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Nov 2022 21:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiKPVSi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiKPVSe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Nov 2022 16:18:34 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB942715
        for <linux-cxl@vger.kernel.org>; Wed, 16 Nov 2022 13:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633512; x=1700169512;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xRWaT0/h0y6Wo37hQZwvWUDyy72U9xhoaghFwWYT/g=;
  b=k5DZ4U56D4u5MzEYqlpxSTmcT7iY/Ic2ve1rMun8+Zrdl3IsUwn418eL
   JHsTYR8tLGcWPv0ytbIvP4p3kF2ALB090+FS/nU2Txq7anwF4xejmzEWm
   w6qSTlv6mKEj2iwn/S4ZoDzsXMW9aJBWzVwPZcMmSnnX2CPxOgXDiQtFq
   BH8blfePm5kF35gdBwRr5RsRG2P/S4Ak/xwweCHRnsEtapw7VjnCGYiOF
   s/foZs7/FQB0e0vbzUKxx7O9x4oll2ul2manfl4DBuVtS321mqTRR3/lB
   JFuP5+93YMFmWGUUH7lPWZzPDYKGLN+AuH8CsC+JgDMJPYFu+aQu17nB/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313821205"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313821205"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:18:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590346655"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590346655"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:18:31 -0800
Subject: [PATCH v5 08/18] tools/testing/cxl: Add "Freeze Security State"
 security opcode support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        benjamin.cheatham@amd.com
Date:   Wed, 16 Nov 2022 14:18:31 -0700
Message-ID: <166863351102.80269.2446125137815258720.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
References: <166863336073.80269.10366236775799773727.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "Freeze Security State"
operation.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d8bb30d82a8f..0cb2e3035636 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -303,6 +303,23 @@ static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_
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
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_FROZEN)
+		return 0;
+
+	mdata->security_state |= CXL_PMEM_SEC_STATE_FROZEN;
+	return 0;
+}
+
 static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
@@ -405,6 +422,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
 		rc = mock_disable_passphrase(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_FREEZE_SECURITY:
+		rc = mock_freeze_security(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


