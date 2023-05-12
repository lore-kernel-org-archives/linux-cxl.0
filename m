Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F33C77B7F
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 22:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjELWB3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 18:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjELWB2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 18:01:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE1D7AB3
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683928886; x=1715464886;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pLB4t0ObIG6fwz1i69PJ98whrgHNns1PjwJaifKMHr8=;
  b=Yz1je8TWsR4eQhMlquPE8wpSS+48bvHbVZZzMUOpWCDoNA7Zw0LisN5d
   hNKewzTyALYogqfmtiE8OnCot/Sscsy6494vAuwR7SlgiZ4ApXAQfUmcI
   NQdiqIXohim+zLrb2IeIQfT5JNIsJIwtAr9OBP2xhH0w7NsjmgJffcuIm
   VjXgqKgYYhF8vjX/UaXWRm++bFcBaFvgDbNUZcaYPpipdPXuDlMdXC+cU
   YWP9oD3XZCRBq2YjWr2pT4eHLcKMWFUXcPhsMgY4ZuErnnP8x6aMuBZj3
   cn2NZVDL9bnxnZFk8Ujz04L8TjPDMbMvlp54zAGbAWVLoMgxfj2+cPP0U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="416533152"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="416533152"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 15:01:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="677814189"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="677814189"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.160.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 15:01:25 -0700
Subject: [PATCH v3] cxl: Add checksum verification to CDAT from CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.willimans@intel.com
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Date:   Fri, 12 May 2023 15:01:24 -0700
Message-ID: <168392888452.286187.18112582667622962209.stgit@djiang5-mobl3>
In-Reply-To: <645eb1bd61964_1e6f29419@dwillia2-xfh.jf.intel.com.notmuch>
References: <645eb1bd61964_1e6f29419@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A CDAT table is available from a CXL device. The table is read by the
driver and cached in software. With the CXL subsystem needing to parse the
CDAT table, the checksum should be verified. Add checksum verification
after the CDAT table is read from device.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
Post patch series split:
v3:
- Use single error out path. (Dan)
v2:
- Split out fix for cdat_read() error path return. (Davidlohr)
- Make port->cdat consistent. (Davidlohr)

___
v5:
- Return on CDAT errors. (Dan)
v3:
- Just return the final sum. (Alison)
v2:
- Drop ACPI checksum export and just use local verification. (Dan)
---
 drivers/cxl/core/pci.c |   30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f332fe7af92b..103c27f5e2a9 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -528,6 +528,16 @@ static int cxl_cdat_read_table(struct device *dev,
 	return 0;
 }
 
+static unsigned char cdat_checksum(void *buf, size_t size)
+{
+	unsigned char sum, *data = buf;
+	size_t i;
+
+	for (sum = 0, i = 0; i < size; i++)
+		sum += data[i];
+	return sum;
+}
+
 /**
  * read_cdat_data - Read the CDAT data on this port
  * @port: Port to read data from
@@ -567,15 +577,21 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 
 	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_table, &cdat_length);
-	if (rc) {
-		/* Don't leave table data allocated on error */
-		devm_kfree(dev, cdat_table);
-		dev_err(dev, "CDAT data read error\n");
-		return;
-	}
+	if (rc)
+		goto err;
 
-	port->cdat.table = cdat_table + sizeof(__le32);
+	cdat_table = cdat_table + sizeof(__le32);
+	if (cdat_checksum(cdat_table, cdat_length))
+		goto err;
+
+	port->cdat.table = cdat_table;
 	port->cdat.length = cdat_length;
+	return;
+
+err:
+	/* Don't leave table data allocated on error */
+	devm_kfree(dev, cdat_table);
+	dev_err(dev, "Failed to read/validate CDAT.\n");
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
 


