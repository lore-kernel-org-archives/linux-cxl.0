Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E69C05027
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBNTlp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjBNTlm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1CA2D170
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403701; x=1707939701;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f37qPrR1ekGDOnoGwr5F80wuJXu7UgW6NgExoZcGR4s=;
  b=lWAwLqYeDBeZavd3PdD8TvGJ+SRfq0KUuWgLO4QJTLVZRzMddDkOLQlQ
   j0wWgI/kpMX5xj8W+Muv/bMqzQ8Mlj+EEi5M9oWra+dFN8RUXqCLcluwh
   +GQDDRBXW4mNS8hixozHivvq2sh5nCfzEHI+rRaI9zi3Acz9RMgE5u8cn
   O/4SyL/QRQum8xlZsi3OIADiU1lDQ0LPO7zvqJX3Kh+zfopd6aC88eOFF
   AJVDaFscXG5Bal2k5rCed3Zs2QpfLpGiaDal/wwBCXof3wxjnNmYDVYHA
   PY29xrWN6PCdWXyD2jRmQGWm0mnacxDeS1xswT1RT42p7DTDcaX3bqi3X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329877782"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="329877782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812155502"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="812155502"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:41 -0800
Subject: [PATCH v5 7/7] cxl/pci: Remove locked check for
 dvsec_range_allowed()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:40 -0800
Message-ID: <167640370085.935665.13128321011001358077.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
References: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Remove the CXL_DECODER_F_LOCK check to be permissive of platform BIOSes
that allow CXL.mem to be remapped.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4eb34dee7c95..c18ed1bbb54d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -228,8 +228,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
 
 	cxld = to_cxl_decoder(dev);
 
-	if (!(cxld->flags & CXL_DECODER_F_LOCK))
-		return 0;
 	if (!(cxld->flags & CXL_DECODER_F_RAM))
 		return 0;
 

