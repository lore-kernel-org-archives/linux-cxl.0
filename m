Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35549C433FE
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiDMSkV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiDMSkQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 14:40:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECFE5D1A4
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649875074; x=1681411074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9JmB6oJKPBBDOztp/9A53kUt0HnYQkAsrrNo+Sut5u0=;
  b=mWzKysbMUL2+HKo/M683rS01NTclSLHB8X6fPH1z3lgNQ6qX34tAw0Jd
   ERekZmXq5ac/J7MOMKdSH67DYA2gIjJjefB8uCx+FE1JlPVBb6dqWAkAX
   rPblTWylE60MSgj+uu2LpWnHoiqZWak83uLcjvwkIM/cS78dTnHW/MW6Z
   c/lJsJ/lxxGodRffRqxYFL9HTh6k8XIDtX0icWcnKqRRf9mblqVBM8IiL
   kYX8KIf4ISdhtNQXR8VhBhhyb375dGWHOAxidnGO3nPZpDL1ocrcB/6Dx
   3v1EImeOrtxEH3pXZEz8ShTB+YWQBmTnJYO8ozeX6N+JmgAMGOTWusAqV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261591501"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="261591501"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725013569"
Received: from sushobhi-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.131.238])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:37:47 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 02/15] cxl/core/hdm: Bail on endpoint init fail
Date:   Wed, 13 Apr 2022 11:37:07 -0700
Message-Id: <20220413183720.2444089-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413183720.2444089-1-ben.widawsky@intel.com>
References: <20220413183720.2444089-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Endpoint decoder enumeration is the only way in which we can determine
Device Physical Address (DPA) -> Host Physical Address (HPA) mappings.
Information is obtained only when the register state can be read
sequentially. If when enumerating the decoders a failure occurs, all
other decoders must also fail since the decoders can no longer be
accurately managed (unless it's the last decoder in which case it can
still work).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/hdm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index bfc8ee876278..c3c021b54079 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -255,6 +255,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 				      cxlhdm->regs.hdm_decoder, i);
 		if (rc) {
 			put_device(&cxld->dev);
+			if (is_endpoint_decoder(&cxld->dev))
+				return rc;
 			failed++;
 			continue;
 		}
-- 
2.35.1

