Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDAC77B60
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 23:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjDZXBB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Apr 2023 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjDZXBA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Apr 2023 19:01:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C871FE5
        for <linux-cxl@vger.kernel.org>; Wed, 26 Apr 2023 16:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682550059; x=1714086059;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k0oUPPhgbl7HRQIWNtNQo9D8yyFUo/5sKRg1Kdkadhw=;
  b=ZYSpx+KZOfUOo7bEamsVjo8sC7DreYgWr8KOcz4kInj/6v8frUkwiY5t
   j01Vwnp3WdY7KLlM2YPes03zSGixPr9PfHWlkd36x4+llKj21SW9FfuTu
   8m5j90WmkQ88uxPKlEEx+2/Eoi8qNEbZ2OXF1ebPqr1oqkss2fSieq92K
   Qg/ZC1oQt6qMWD8Bgm8dDTfhbB758pr5Sl3mmsmaH2pXIF4HSPDLpY0Nd
   SB5SKs9xQkdWSBCIIG3/RU1JcKcTlanIykveECnL0Ip0UANjc99dnBF6M
   rb5GSgT8GF/xEN3d3GTR10pYNT145V4ohex8J8H9ZRXSQzjL+fYBow+y4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="327580649"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="327580649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 16:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="868467355"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="868467355"
Received: from saberggr-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.120.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 16:00:59 -0700
Subject: [PATCH] cxl: Add warning comment to cxl_root_decoder
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Wed, 26 Apr 2023 16:00:58 -0700
Message-ID: <168255005846.53394.2779436232786699829.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 'cxl_switch_decoder' member in 'cxl_root_decoder' must be the last
element due to 'cxl_switch_decoder' has a flexible array at the
end of the struct. Any variables placed after will be corrupted.
Add a warning comment to 'cxl_root_decoder'.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxl.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..999c0aa5ed54 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -419,6 +419,7 @@ struct cxl_root_decoder {
 	cxl_calc_hb_fn calc_hb;
 	void *platform_data;
 	struct mutex range_lock;
+	/* This must be the last member of the struct. It contains a flexible array */
 	struct cxl_switch_decoder cxlsd;
 };
 


