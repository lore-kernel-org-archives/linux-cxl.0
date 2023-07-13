Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C88AEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 01:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjGMBuk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 21:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjGMBuj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 21:50:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830F4B0
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689213038; x=1720749038;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=udcdwjxpF7URdNHmndDcYW8BAHvjB294d/omZ49+8oY=;
  b=DhWwb0TtjqTcYPuBMiG1m9+zunv8LB0Q/55OR28yES066DOZQzh+YAVm
   6j6FSnKOovt2ligHWtpzV93xwA65v6VMMsNpAsxvq/g8a+NrqHn+CtR7H
   DaTSy+8lP/6Cr7PDhuoflA6XyNmHxmaMLviejtCav71jToiMd7143VCBd
   8hHeyYtzg+aaamJPXdL7LnbfblmXe/4cM3IQvuvR48yIPfMChmalc9BA/
   wuiQq4mPx89ClWkg+SJle+uS2HBfikzjgvNrXgmx38SIYLxb1WFG4Fz8j
   PFfjFcKcfu6neAG+BodF5duxPX+dMUg/G3pCppGubZw7MJq2S5jbcy7x+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428806436"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="428806436"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 18:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="787256821"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; 
   d="scan'208";a="787256821"
Received: from bpulavar-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.97.133])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 18:50:36 -0700
Subject: [PATCH v2] cxl: Update MAINTAINERS
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Date:   Wed, 12 Jul 2023 18:50:36 -0700
Message-ID: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ben, thank you for all the work to get the CXL subsystem off the ground
and establishing QEMU as a place where hardware vendors can collaborate
on the new advancements and mechanisms appearing in the CXL
specification.

Jonathan, thank you for your continued review and collaboration, you have
been a defacto CXL maintainer for a while now.

Davidlohr, thank you for getting the background command infrastructure
off the ground and your leadership on and off the lists.

Dave Jiang, thank you for yor continued attention to all the
cross-subsytem plumbing issues that CXL continues to create.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes in v2:
- Show Dave Jiang his due as well.

 MAINTAINERS |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..82de99b6b340 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5140,10 +5140,12 @@ S:	Maintained
 F:	include/linux/compiler_attributes.h
 
 COMPUTE EXPRESS LINK (CXL)
+M:	Davidlohr Bueso <dave@stgolabs.net>
+M:	Jonathan Cameron <jonathan.cameron@huawei.com>
+M:	Dave Jiang <dave.jiang@intel.com>
 M:	Alison Schofield <alison.schofield@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
-M:	Ben Widawsky <bwidawsk@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained

