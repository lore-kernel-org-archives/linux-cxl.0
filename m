Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE5C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbjEKSAN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjEKSAI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:00:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE579039
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683827980; x=1715363980;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j5x6f3r1ok48eBoxa/HxDk1jjDqrLmKG+KkhKxfWp7Y=;
  b=W2Ncw5ruYp9u81AxSSvjTTTt18SndyzCmVABdPwOHhYfhjzYg7NMzdFF
   FPK+1TfsF6b6Oo27xvshzbnTdekMFjp8vBKnNCHg1ksO3VAyhZRPVly9K
   dz7qabUFW2vUaSajFgYRwMzK0c3uJU/nVzjfSVgak4lkd8zj5GYsDK3gn
   4B0s55rPT5CBzK3vhXug9sT7DfjSbCKtKIFF9PHH1kK5adli93eWSI+hF
   m0o+aKK6MXwMclw7xG1UElvId2nRrtschxH910fVTi19zHssoM9kvBDu7
   +FLQ1TSevuYOj71MH/a1x3tdO6tfMJk8lfxUJGV24HXgdtqFjnPD8EG4I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335092065"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335092065"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:59:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="693904350"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="693904350"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.95.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:59:07 -0700
Subject: [PATCH v2 4/4] cxl: Add support for reading CXL switch CDAT table
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Thu, 11 May 2023 10:59:07 -0700
Message-ID: <168382794705.3510737.14861252708548327842.stgit@djiang5-mobl3>
In-Reply-To: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
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

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Set pdev to NULL first (Davidlohr)

Before split:
v5:
- Rebase after fix [1]. (Dan)

[1]: http://lore.kernel.org/r/168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com
v4:
- Remove cxl_test wrapper. (Ira)
---
 drivers/cxl/core/pci.c |   22 +++++++++++++++++-----
 drivers/cxl/port.c     |    3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 64ae45ae7ad6..58051154ab1a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -546,18 +546,30 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
-	struct device *host = cxlmd->dev.parent;
+	struct device *uport = port->uport;
 	struct device *dev = &port->dev;
 	struct pci_doe_mb *cdat_doe;
+	struct pci_dev *pdev = NULL;
+	struct cxl_memdev *cxlmd;
 	size_t cdat_length;
 	void *cdat_table;
 	int rc;
 
-	if (!dev_is_pci(host))
+	if (is_cxl_memdev(uport)) {
+		struct device *host;
+
+		cxlmd = to_cxl_memdev(uport);
+		host = cxlmd->dev.parent;
+		if (dev_is_pci(host))
+			pdev = to_pci_dev(host);
+	} else if (dev_is_pci(uport)) {
+		pdev = to_pci_dev(uport);
+	}
+
+	if (!pdev)
 		return;
-	cdat_doe = pci_find_doe_mailbox(to_pci_dev(host),
-					PCI_DVSEC_VENDOR_ID_CXL,
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


