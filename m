Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04DC77B7F
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjEHUr4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjEHUrz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 16:47:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956D359CA
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683578874; x=1715114874;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VQ+b8UCBNC8s+QuBVZHNtxr6Zzk35sxJV9Sy2icjV4c=;
  b=jxfpWQY0vrKqFwGnWDplpcoZfrfpAh2wONcFuvB22H7tqVor3JUp4t3P
   gUXiU5rhMzq6ZCNQZRcC2sZnfn9pydaR5fhMGt7bJWc3Aej2QWwqueEoK
   E7SUNYhiPHydHUiZY36fNwROHShq4K71jzmvmVlGKx85NcZeLI1IKPnjH
   C+Jja/lYTPyUgX7VAtbf5B7BhXIyi9kIWoI5fVrimwxmWChOmzhw4Tl2V
   keqmpGGk4zQAxGDrWjUm9alSY+KKO6VG+qq7cGT/1QeGnZaDg3qBVQVo8
   4yDb2WamGdQzBvC9Xh5JE/Kbs4XBHLUt6Upl6ZTmkDjO/I0j480G7CvSW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="436072433"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="436072433"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="944996670"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="944996670"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.172.228])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 13:47:54 -0700
Subject: [PATCH v5 10/14] cxl: Move identify and partition query from pci
 probe to port probe
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Mon, 08 May 2023 13:47:53 -0700
Message-ID: <168357887373.2756219.10680050253858860934.stgit@djiang5-mobl3>
In-Reply-To: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Move the enumeration of device capacity to cxl_port_probe() from
cxl_pci_probe(). The size and capacity information should be read
after cxl_await_media_ready() so the data is valid.

Fixes: 5e2411ae8071 ("cxl/memdev: Change cxl_mem to a more descriptive name")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c  |    8 --------
 drivers/cxl/port.c |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ed39d133b70d..06324266eae8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -707,14 +707,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_dev_state_identify(cxlds);
-	if (rc)
-		return rc;
-
-	rc = cxl_mem_create_range_info(cxlds);
-	if (rc)
-		return rc;
-
 	rc = cxl_alloc_irq_vectors(pdev);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index b474997cc7ee..0bdb9d73a389 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -180,6 +180,14 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 	}
 
+	rc = cxl_dev_state_identify(cxlds);
+	if (rc)
+		return rc;
+
+	rc = cxl_mem_create_range_info(cxlds);
+	if (rc)
+		return rc;
+
 	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc)
 		return rc;


