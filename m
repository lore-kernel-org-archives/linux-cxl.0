Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E5FC43217
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 20:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiKNUeJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiKNUdz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 15:33:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F319299
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 12:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668458033; x=1699994033;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xRWaT0/h0y6Wo37hQZwvWUDyy72U9xhoaghFwWYT/g=;
  b=lJeoGV+knxBRzuilWk3Uov+5M/3CVf6CyPS75+gkfZYYg5OqGoFZwwaH
   Q+KU6jD8CntgcfYdVJfSXvZ3hwz4S3PfEio/VaLk89xDE9AnGTrh9Wixh
   vi3CpzmTj0cnpEfUl0kpbwgVYb1R2JIlCI+iVqccLam52bEhWDxoHI82H
   KM1MJ+D5H7vCTT6tQQ5X3C70Mjm8hgA8I+nsiYMRe9Qb1jKpm2zyrcadR
   /L1F7swBHmHpXWMhrYlaVx2ZjF5iy3i3Vr247Xexaic0DnFEcwEPNzSrd
   7+S9Qh2xceZ5tH3IelepRA4uyDrLu59ojRaDkTfk9Y9aFW6qCUnwh28xs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313884414"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313884414"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:33:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707460545"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="707460545"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 12:33:51 -0800
Subject: [PATCH v4 08/18] tools/testing/cxl: Add "Freeze Security State"
 security opcode support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Mon, 14 Nov 2022 13:33:51 -0700
Message-ID: <166845803114.2496228.16843988685083613244.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
References: <166845791969.2496228.8357488385523295841.stgit@djiang5-desk3.ch.intel.com>
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


