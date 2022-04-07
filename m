Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB09C433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Apr 2022 01:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiDGBJJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 6 Apr 2022 21:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiDGBJJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 6 Apr 2022 21:09:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40215AE31
        for <linux-cxl@vger.kernel.org>; Wed,  6 Apr 2022 18:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649293631; x=1680829631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SsQP3aimL/rwpyDAlLCNOD6UA++rPmiLzDk2PHKu+o4=;
  b=AF+fsAT1ItrWhR8hpwf4gRF2xlzbZp1qcBHaGgN9Kx9Qg+k5eVqq2mx4
   p+md9ZCqHlaQiu1PMXoWYH/i+fpZDvdXf88/sxw6y5q6Wi9WtrJh6oiiu
   1aMCcRp0y5/C9RmF+gBqYrM0iLHcrcLk+kZuKC4XxC2XpSoghYA70TOqL
   T6s+JZRjr2FNiAz1WGd4vdYsOc7Vc97yDwyg+qql+XBPthY8xD6g9p2fY
   Mj51TnjGKesIbgvruH+KtPuVT1kVtt9x3ql8QhBVKC1AHpqqMhfTc/uKh
   YaoQ0zEb4nnJmhjsBbYgXwZOeB/ek/6o1Zj+c1oWa5m/cX7reOEDmUMKi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241789529"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="241789529"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:07:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="505952946"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:07:10 -0700
From:   alison.schofield@intel.com
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] cxl/mbox: Replace NULL check with IS_ERR() after vmemdup_user()
Date:   Wed,  6 Apr 2022 18:09:15 -0700
Message-Id: <20220407010915.1211258-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

vmemdup_user() returns an ERR_PTR() on failure. Use IS_ERR()
to check the return value.

Fixes: be0d0ce77aa3 ("cxl/mbox: Move build of user mailbox cmd to a helper funct
ions")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8a8388599a85..2449878d4b4b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -263,7 +263,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
 	if (in_size) {
 		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
 						in_size);
-		if (!mbox->payload_in)
+		if (IS_ERR(mbox->payload_in))
 			return PTR_ERR(mbox->payload_in);
 
 		if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {

base-commit: 7dc1d11d7abae52aada5340fb98885f0ddbb7c37
-- 
2.31.1

