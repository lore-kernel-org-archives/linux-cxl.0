Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F30C77B7F
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 16:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjEEQfh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 12:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjEEQfg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 12:35:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7E191FD
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683304530; x=1714840530;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1GNxDYdk4epHZUHSvvoQ0imUTwfPY4327DTeGc6PJ7o=;
  b=DbwGub8NEaTM0xWYF0B1nlkS2aTlY/MNiroQWKVpVpfKgkvRZ6FaksCA
   0Tq4sZcB/boNqD/sic+8hbpmsg/zBXzuQj7oRjR4mTEWJ/hHV18g6N9lH
   9toSw5ZLyNZZM8B3/IVOTPeC8T0rNNJgKBK53gLvNGclS0TyE5JDYldYQ
   m3P1NFoK3oBnV7b9QfLAZvKtZSStJ6AUe+yNzH3OcX0VLiembvLteyfU6
   IJ208uPwqEagBwe5BlTAkyp6dF0oN/mtdTjB5NtHg2YjVOKxEY/65HgGo
   Un4UQVv7IBeDsvWONaDgLPs9gGSK6ISuISg5fPOiVj2Rg4Ho4NSy9BaW3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="435566760"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="435566760"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="821765555"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="821765555"
Received: from nkonan-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:29 -0700
Subject: [PATCH 2/3] cxl: Add checksum verification to CDAT from CXL
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 05 May 2023 09:35:28 -0700
Message-ID: <168330452895.1986478.7758561874383258080.stgit@djiang5-mobl3>
In-Reply-To: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
References: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
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
v5:
- Return on CDAT errors. (Dan)
v3:
- Just return the final sum. (Alison)
v2:
- Drop ACPI checksum export and just use local verification. (Dan)
---
 drivers/cxl/core/pci.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bdbd907884ce..046e55a9b419 100644
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
@@ -571,9 +581,17 @@ void read_cdat_data(struct cxl_port *port)
 		/* Don't leave table data allocated on error */
 		devm_kfree(dev, cdat_table);
 		dev_err(dev, "CDAT data read error\n");
+		return;
 	}
 
 	port->cdat.table = cdat_table + sizeof(__le32);
+	if (cdat_checksum(port->cdat.table, cdat_length)) {
+		/* Don't leave table data allocated on error */
+		devm_kfree(dev, cdat_table);
+		dev_err(dev, "CDAT data checksum error\n");
+		return;
+	}
+
 	port->cdat.length = cdat_length;
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);


