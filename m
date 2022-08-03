Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D0C19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 07:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiHCHY0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCHYZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 03:24:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E971CFF8
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659511464; x=1691047464;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s/f6F02clECnp9UMok7z/iDc6nTP9DI5CBuQ8iEcWFM=;
  b=FJRATpnCxelDJxRmZ81vmIdyI4qVej1aGhbTu16sPOD4hQMXIXAsVXIv
   m60LPhh54IvgdqDirjJBR3Ty+NiKZ0TXbqk3jqPaWIgmf/Ug2WMZ7IElW
   ebTbqihTkYU/Glj0vXRmOLtLGYaJMIww620qaJv84e5hVTMojuuRpG1lE
   +OOv2PS7rr4BglZIAxD1M4/coYBdxjSmmrnmiLf/Wl4aqftoGpfytuo9P
   LYO11slqu5cmlCHbJ8XEU1WaTn0mbZfqiP0tTqI6EPnSTl97AXQ/9O+TJ
   8ABfC5KDo2+oDKxI/EKMHjL9DqWf1XDyGwM4ICZoGaSAPD+G2WuD2ji27
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290380804"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="290380804"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="606294170"
Received: from jplumb-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.28.212])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:24:23 -0700
Subject: [PATCH 1/4] cxl/region: Fix decoder interleave programming
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        ira.weiny@intel.com, dave.jiang@intel.com
Date:   Wed, 03 Aug 2022 00:24:23 -0700
Message-ID: <165951146336.967013.11160153960900111443.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan notes:

"Curiously interleave ways = 1 for the EPs which is obviously wrong"

...while testing the latest CXL development branch on QEMU.

It turns out the region creation process failed to program the endpoint
decoders. This was missed because the default settings of x1 at 4K
intereleave still results in the region appearing to function. Jonathan
caught the bug by reverse mapping the translations that need to happen
for the QEMU support.

Link: https://lore.kernel.org/r/62e95fdf9f6e2_30440294e4@dwillia2-xfh.jf.intel.com.notmuch
Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cf5d5811fe4c..8e6ff3f39755 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1294,6 +1294,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
+	cxled->cxld.interleave_ways = p->interleave_ways;
+	cxled->cxld.interleave_granularity = p->interleave_granularity;
+
 	return 0;
 
 err_decrement:

