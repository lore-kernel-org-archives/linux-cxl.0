Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E28C4743D
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 05:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFD2611CD
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 05:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFKFNo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 01:13:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:25251 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhFKFNn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 11 Jun 2021 01:13:43 -0400
IronPort-SDR: yo85Z61wmoynj2LI34BJzWAp8tPC7F7rzPB00D53Zs99Cn2e1PVNSS9OpKzoWNEI+5Nj68D4A/
 rD3L8saHdHhA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="203627752"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="203627752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 22:11:23 -0700
IronPort-SDR: xXL/o1yLsF3Xq8h3YaUsx8z+mJ0ow3XTW2gBntQT8WK+h+Jm10D1njzhnhQvUUKOkiPVOhzZYc
 mFcsmWpPwD8g==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="448988038"
Received: from mgecan-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 22:11:22 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] cxl/component_regs: Fix offset
Date:   Thu, 10 Jun 2021 22:11:13 -0700
Message-Id: <20210611051113.224328-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL.cache and CXL.mem registers begin after the CXL.io registers
which occupy the first 0x1000 bytes. The current code wasn't setting
this up properly for future users of the component registers. It was
correct for the probing code however.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 92db02fe7aa8..c7f956fa3ada 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -671,7 +671,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = 0x20 * decoder_cnt + 0x10;
 
 			map->hdm_decoder.valid = true;
-			map->hdm_decoder.offset = offset;
+			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
 			map->hdm_decoder.size = length;
 			break;
 		default:
-- 
2.32.0

