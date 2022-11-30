Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD76C4321E
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK3TWq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiK3TWS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 14:22:18 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36E8327D
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 11:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669836137; x=1701372137;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8pkuOsP2CGO1os2ONxl61M4rJO89vDyEQLuiH8Q0t9I=;
  b=m7G89TupDHMDin0GgrKZl0K4wDfZyMj0vCZ7IgAWnMtTSlppfI0wuo2u
   jH8qVWN1f1FDEuYyIKhOB0SCyyUZqwvkDmOekYtqN3GfK94gLSy+2WmvA
   LFNfBugCZbCV3uL5tCdjoAAYFttsoUMcKGfG9gxB0RMQX8uxBdGMfa4Ok
   tiEVuMVP2goj/U86GUd3sdSsghwGF0RQBC57KII0BeJGQpGz6FEIA2BG6
   94i41ci6EeXhA9KZ7gga/f8nb/rv/VlZjgmcvA8CRdRhfuiC3svIGAhVZ
   kepPw5zMLwERbDQlmNTenh1e75Hr6rJFZqIuPRZrlAowdOeAKjfjA+G+U
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295853916"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="295853916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 11:22:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="707768986"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="707768986"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 11:22:16 -0800
Subject: [PATCH v7 08/20] tools/testing/cxl: Add "Freeze Security State"
 security opcode support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Wed, 30 Nov 2022 12:22:16 -0700
Message-ID: <166983613604.2734609.1960672960407811362.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166983606451.2734609.4050644229630259452.stgit@djiang5-desk3.ch.intel.com>
References: <166983606451.2734609.4050644229630259452.stgit@djiang5-desk3.ch.intel.com>
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
Link: https://lore.kernel.org/r/166863351102.80269.2446125137815258720.stgit@djiang5-desk3.ch.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/mem.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 77774a951a81..45c6e6d3cfbb 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -314,6 +314,23 @@ static int mock_disable_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_
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
@@ -418,6 +435,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_DISABLE_PASSPHRASE:
 		rc = mock_disable_passphrase(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_FREEZE_SECURITY:
+		rc = mock_freeze_security(cxlds, cmd);
+		break;
 	default:
 		break;
 	}


