Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9457EC7EE25
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbjEKSAG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbjEKR74 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 13:59:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806E6A5EA
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683827975; x=1715363975;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NAX+K0/JcSAtlxkbvAEWD+I2/IMBx2Y0Ktj63jlEBrg=;
  b=FRASFHwNpkR0tuWnPffogD90MMQGC2sQXyRkX3zFTyoC7tU820YaZ/g3
   5TkPWTHFlPvmUSvUiSJOhGh9psWHdpADCDAxxmWdd3n047Inmc52giDft
   ezaoPSDmK76jWXhGcCo8DOwrvwJ90KyBzGWaTOWOVxuaQCSIFLC6hVfc6
   Rgau0uxeHB7UgBBAsEhuiYwyMxIFeoXqB3incA9tJl8sD/hMmQ+dHNtxr
   oERKpCclGQtS3zWZ7Mmq7Ydg5DQSLhFDaaBUdg0OtChpHVMkGcfrdCmY8
   wcFrxCDdNr7jE7xyY/CBXGPjWk9fziPptGa8+x5Hj5zbgO0G7pQvWS0Vq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335092006"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335092006"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:59:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="693904335"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="693904335"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.95.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:59:01 -0700
Subject: [PATCH v2 3/4] cxl: Add checksum verification to CDAT from CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Thu, 11 May 2023 10:59:01 -0700
Message-ID: <168382794106.3510737.6205740820012769763.stgit@djiang5-mobl3>
In-Reply-To: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
Post patch series split:
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
 drivers/cxl/core/pci.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f332fe7af92b..64ae45ae7ad6 100644
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
@@ -574,7 +584,15 @@ void read_cdat_data(struct cxl_port *port)
 		return;
 	}
 
-	port->cdat.table = cdat_table + sizeof(__le32);
+	cdat_table = cdat_table + sizeof(__le32);
+	if (cdat_checksum(cdat_table, cdat_length)) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, cdat_table);
+		dev_err(dev, "CDAT data checksum error\n");
+		return;
+	}
+
+	port->cdat.table = cdat_table;
 	port->cdat.length = cdat_length;
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);


