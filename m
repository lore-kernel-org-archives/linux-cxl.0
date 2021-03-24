Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66EBC433DB
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 21:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6D161A1F
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhCXVCK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 17:02:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:30382 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238211AbhCXVBw (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 24 Mar 2021 17:01:52 -0400
IronPort-SDR: DqWSWnr3O4E05rBcm4l5E41h659Q43kQ9HDRpJZrWslCWbUvDu6XKqRvGJU/hJObsXOsHEeHYN
 xi+3l6S12/KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178339680"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="178339680"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:01:51 -0700
IronPort-SDR: +h+Qkwic+CIAtKQUJDKNTnT/xM+JK0uS140eNzAFR+lbYjtFgT+m82jaHIwXDWvlZKjXVhtj7p
 ZRulJxBPkWNg==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="409024171"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:01:51 -0700
Subject: [PATCH 1/4] cxl/mem: Use sysfs_emit() for attribute show routines
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:01:51 -0700
Message-ID: <161661971101.1721612.16412318662284948582.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161661970558.1721612.10441826898835759137.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
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

