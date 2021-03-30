Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E4C433C1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE15619D0
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 23:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhC3Xgi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:36:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:39186 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232662AbhC3Xge (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 30 Mar 2021 19:36:34 -0400
IronPort-SDR: udoQywIGutk/gpHtp09KY9nm+ZSGOzWMHyHVJLuhCZh+5VJtnIFCIMPp8YGZ/w11hYzIRZ93aw
 H2nVizgVS26w==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179420782"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179420782"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:32 -0700
IronPort-SDR: iIdbyJTJO6m+aiu6caDKj6FupKs1PBMdMae1aTrxXPgjZAB0PinztRQjDxqsNME5NnaiWlDOxA
 3UN/51VxJbvA==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="377026408"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 16:36:32 -0700
Subject: [PATCH v3 1/4] cxl/mem: Use sysfs_emit() for attribute show routines
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Date:   Tue, 30 Mar 2021 16:36:31 -0700
Message-ID: <161714739187.2168142.4069783082215231589.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

While none the CXL sysfs attributes are threatening to overrun a
PAGE_SIZE of output, it is good form to use the recommended helpers.

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/161661971101.1721612.16412318662284948582.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ecfc9ccdba8d..30bf4f0f3c17 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -1066,7 +1066,7 @@ static ssize_t firmware_version_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mem *cxlm = cxlmd->cxlm;
 
-	return sprintf(buf, "%.16s\n", cxlm->firmware_version);
+	return sysfs_emit(buf, "%.16s\n", cxlm->firmware_version);
 }
 static DEVICE_ATTR_RO(firmware_version);
 
@@ -1076,7 +1076,7 @@ static ssize_t payload_max_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mem *cxlm = cxlmd->cxlm;
 
-	return sprintf(buf, "%zu\n", cxlm->payload_size);
+	return sysfs_emit(buf, "%zu\n", cxlm->payload_size);
 }
 static DEVICE_ATTR_RO(payload_max);
 
@@ -1087,7 +1087,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_mem *cxlm = cxlmd->cxlm;
 	unsigned long long len = range_len(&cxlm->ram_range);
 
-	return sprintf(buf, "%#llx\n", len);
+	return sysfs_emit(buf, "%#llx\n", len);
 }
 
 static struct device_attribute dev_attr_ram_size =
@@ -1100,7 +1100,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_mem *cxlm = cxlmd->cxlm;
 	unsigned long long len = range_len(&cxlm->pmem_range);
 
-	return sprintf(buf, "%#llx\n", len);
+	return sysfs_emit(buf, "%#llx\n", len);
 }
 
 static struct device_attribute dev_attr_pmem_size =

