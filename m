Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D69C00140
	for <linux-cxl@archiver.kernel.org>; Fri,  5 Aug 2022 22:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240182AbiHEWMb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 Aug 2022 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbiHEWMa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 Aug 2022 18:12:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB0C175BA
        for <linux-cxl@vger.kernel.org>; Fri,  5 Aug 2022 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659737548; x=1691273548;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=66CKOb1RF9eL97awHVpGfFmFXIqlEuTaNP95KqkHLm4=;
  b=Z6DZ0lqdvHDZ04cUonGV1Uqa4Dxlyn1s9LLLhPD7Mi6l+A0OpyZ0HYph
   e0MgpJgfNXRu5cIMtojmmAfRfIGnoBQzCk7ZUOVZWAmHYQG2VS5PFlRy5
   E0nz+2aRIPVA1UZ5/6Ftu0kVKLSDNJtcftw5aGYl5eouL/ZUg5Q4Mp+Cc
   XDtbsNzfVkrB5ds85z4JvUY4gIj/FXF1I1Gm2yofiqrPSeUF40WKRBXQp
   oknq4TeH7u72nsBIr6QYO2hMRtXkQMTT5FPFV3I1CpWgr4vxlPgKYbRKG
   +jF5p+e9D65QfgSjyunrvLn56fRdmWogxd29kP7YKHOMHCYC4MON6vnAs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287865990"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="287865990"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 15:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="931377270"
Received: from jivaldiv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.228.201])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 15:12:27 -0700
Subject: [PATCH] cxl/hdm: Fix skip allocations vs multiple pmem allocations
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Fri, 05 Aug 2022 15:12:27 -0700
Message-ID: <165973754730.1558392.15466392461645857658.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vishal notes that when attempting to define a second pmem region on a
device the DPA allocation fails with a message of the form:

    decoder11.1: failed to reserve skipped space

Recall that the skip setting is used when there is a pmem allocation in
the presence of free ram DPA space. The first pmem allocation skips over
the free ram and subsequent pmem allocations do not require a skip. The
bug is that a skip is still attempted and the DPA reservation code
flags the double skip allocation conflict.

Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Tested-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e096f74e19df..d1d2caea5c62 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -445,7 +445,16 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 		start = free_pmem_start;
 		avail = cxlds->pmem_res.end - start + 1;
 		skip_start = free_ram_start;
-		skip_end = start - 1;
+
+		/*
+		 * If some pmem is already allocated, then that allocation
+		 * already handled the skip.
+		 */
+		if (cxlds->pmem_res.child &&
+		    skip_start == cxlds->pmem_res.child->start)
+			skip_end = skip_start - 1;
+		else
+			skip_end = start - 1;
 		skip = skip_end - skip_start + 1;
 	} else {
 		dev_dbg(dev, "mode not set\n");

