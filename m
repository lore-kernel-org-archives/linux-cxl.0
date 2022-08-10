Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2942FC25B06
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Aug 2022 23:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiHJXJq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Aug 2022 19:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiHJXJk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Aug 2022 19:09:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC447B1F8
        for <linux-cxl@vger.kernel.org>; Wed, 10 Aug 2022 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660172979; x=1691708979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yYRPJ8O/nI5XLYfuqFzW+C2ugl+ImE/phG1tck5CQp0=;
  b=hAPei5T/QkQXawjP+9XwtoSUyH9MH5Ua7Uq+GpB8IPtWgzjdb5ujRWyH
   P/eyC6xIpczLkYy6mBEk/9upKFu/y7Nq1bvzg4d3fB4LogoqzYSvgj491
   vTUN0RUAQZTK373GKfqEyTVejlndcyirn405EZSR8fHNLrA4/LwhdJpAm
   o4X4IsNtzF5yYQzRV46w1iVaMVs9zZdFmyd9p5Dvcho3SL6OTOba8UwvN
   49f+j+hCZktkHT1tU48yblHt8nXxAODzqShZ3S9w9I47aGXUA1SrHmvue
   L9c5ukWbqvZ5C9GOlhGulYufZKKMv73m9Z9Z2bbWKeqjIr5BoAC4IbRl+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="270990468"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="270990468"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="581429455"
Received: from maughenb-mobl.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.209.94.5])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:09:34 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 08/10] cxl/list: make memdevs and regions the default listing
Date:   Wed, 10 Aug 2022 17:09:12 -0600
Message-Id: <20220810230914.549611-9-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810230914.549611-1-vishal.l.verma@intel.com>
References: <20220810230914.549611-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; h=from:subject; bh=yYRPJ8O/nI5XLYfuqFzW+C2ugl+ImE/phG1tck5CQp0=; b=owGbwMvMwCXGf25diOft7jLG02pJDElfrGY+ONetvvKO4LP8xgjZ2MPa4hf3PRE7yFHGtszlul7S DHv+jlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEwk7CrDP/11LlGiwT8PWW3bvZP77w Zp0wivTzr97eE53wxXLMqUOM3IcFI+Pu6e84049zl5svzzKydvZOAQOjZDo/muT62DZb0IPwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Instead of only listing regions by default (which can often be empty if
no regions have been configured), change the default listing mode to
both memdevs and regions. This will allow a plain 'cxl-list' to be a
quick health check of whether all the expected memdevs have enumerated
correctly, and see any regions that have been configured.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 cxl/list.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cxl/list.c b/cxl/list.c
index 88ca9d9..5f604ec 100644
--- a/cxl/list.c
+++ b/cxl/list.c
@@ -100,9 +100,10 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
 			param.regions = true;
 	}
 
-	/* List regions by default */
+	/* List regions and memdevs by default */
 	if (num_list_flags() == 0) {
 		param.regions = true;
+		param.memdevs = true;
 	}
 
 	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
-- 
2.37.1

