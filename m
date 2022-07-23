Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09125C43334
	for <linux-cxl@archiver.kernel.org>; Sat, 23 Jul 2022 00:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiGWA6M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiGWA5q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Jul 2022 20:57:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E527C9E78
        for <linux-cxl@vger.kernel.org>; Fri, 22 Jul 2022 17:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658537770; x=1690073770;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HVfFYsLsvuf6dsq6e1YjVlXLrZXGqG8HeTC5Tk3xb1M=;
  b=Wud42ZN1D1WRcaI77jvrrPpUP2MB91SDUAxSng0JOuiu6goPZNEWZ3TS
   rj5xTnwSC+bEq7tYBWnrJBZASTKLmVfzBDED5noy3miJMio1NV5RoQZNp
   IxPgmkUNWh2ctW0vXpYHHBNOvNQRpobQ9RtwmL71teAOcz/df2p2+j7NM
   +Jz9yfv10zSsAF6Uj1G6Q3r3/47WBbEiUqlFMgShjvl4qz2SlkV7kwOU2
   9+4ojfjnNQjsQfrxG9HoifLJxJNhpKS+DB5Oh03YCiJhT4B651ktwzn/H
   TuDJLmtTDUUKhLBYGnbvMY08cwO/jUNSeKZ6MPzrVOKEjy+DPVmGvm3EZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="267206912"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="267206912"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="657415749"
Received: from jeescalx-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.116.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 17:56:09 -0700
Subject: [PATCH 3/5] cxl/acpi: Minimize granularity for x1 interleaves
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Fri, 22 Jul 2022 17:56:09 -0700
Message-ID: <165853776917.2430596.16823264262010844458.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The kernel enforces that region granularity is >= to the top-level
interleave-granularity for the given CXL window. However, when the CXL
window interleave is x1, i.e. non-interleaved at the host bridge level,
then the specified granularity does not matter. Override the window
specified granularity to the CXL minimum so that any valid region
granularity is >= to the root granularity.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index eb436268b92c..67137e17b8c9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -140,6 +140,12 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		.end = res->end,
 	};
 	cxld->interleave_ways = ways;
+	/*
+	 * Minimize the x1 granularity to advertise support for any
+	 * valid region granularity
+	 */
+	if (ways == 1)
+		ig = 256;
 	cxld->interleave_granularity = ig;
 
 	rc = cxl_decoder_add(cxld, target_map);

