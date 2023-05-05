Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02539C77B7F
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 16:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjEEQfn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjEEQfj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 12:35:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122C18FDF
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683304536; x=1714840536;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCY0S0xa7wXeRcVtCLzY1Q8Un4fZuK5p4bmYsDRI+OY=;
  b=iXeYzU5rpcdRpaCbED4QXpJIDv+8oaueVFF69VfSuhu7kJVj95phc4UP
   fkM2jug1fXHvqGXUNRC/GVgViXLI9fiUieI8ukiUxKrv9ZD1GYdePZM4v
   GFsmMggNlO+uFaXyzM9CsT9o53foQBR2PMzBMLSM4v1Kz+f08ajMQe7Ds
   BydWc6im5Es01kINaRgjccCNMPcUxqV8yOkC6rdI+b+Wtz5yqynMj8TiG
   kWHW0t3jV8u7RoxK/7e0wLHMvsZwWDV0tagXBXPdRbW4WPLai0y5rpwQC
   S1YVH0tWlnABPCP+/5vmsPlAfTwmz2TltOtXUUyk2Jj1cvr4bPtqhP0dG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="435566787"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="435566787"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="821765571"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="821765571"
Received: from nkonan-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 09:35:35 -0700
Subject: [PATCH 3/3] cxl: Add support for reading CXL switch CDAT table
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 05 May 2023 09:35:35 -0700
Message-ID: <168330453501.1986478.10682875024496375027.stgit@djiang5-mobl3>
In-Reply-To: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
References: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add read_cdat_data() call in cxl_switch_port_probe() to allow
reading of CDAT data for CXL switches. read_cdat_data() needs
to be adjusted for the retrieving of the PCIe device depending
on if the passed in port is endpoint or switch.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v5:
- Rebase after fix [1]. (Dan)

[1]: http://lore.kernel.org/r/168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com
v4:
- Remove cxl_test wrapper. (Ira)
---
 drivers/cxl/core/pci.c |   21 ++++++++++++++++-----
 drivers/cxl/port.c     |    3 +++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 046e55a9b419..9fabfe458499 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -546,18 +546,29 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
-	struct device *host = cxlmd->dev.parent;
+	struct device *uport = port->uport;
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *cdat_doe;
+	struct cxl_memdev *cxlmd;
+	struct pci_dev *pdev;
+	struct device *host;
 	size_t cdat_length;
 	void *cdat_table;
 	int rc;
 
-	if (!dev_is_pci(host))
+	if (is_cxl_memdev(uport)) {
+		cxlmd = to_cxl_memdev(uport);
+		host = cxlmd->dev.parent;
+		if (!dev_is_pci(host))
+			return;
+		pdev = to_pci_dev(host);
+	} else if (dev_is_pci(uport)) {
+		pdev = to_pci_dev(uport);
+	} else {
 		return;
-	cdat_doe = pci_find_doe_mailbox(to_pci_dev(host),
-					PCI_DVSEC_VENDOR_ID_CXL,
+	}
+
+	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 					CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!cdat_doe) {
 		dev_dbg(dev, "No CDAT mailbox\n");
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 22a7ab2bae7c..a49f5eb149f1 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -62,6 +62,9 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	struct cxl_hdm *cxlhdm;
 	int rc;
 
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
+
 	rc = devm_cxl_port_enumerate_dports(port);
 	if (rc < 0)
 		return rc;


