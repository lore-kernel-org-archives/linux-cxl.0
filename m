Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E8C77B61
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 02:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDVCvv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 22:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVCvu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 22:51:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8DE2109
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682131908; x=1713667908;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r5GQfd8aixynN5mk2EvRQANGxVKNzrTofFex9WRP3DM=;
  b=jt0U4M/N65MoORLk1Wuv6s6ONpBxJ4uHF80O6bX/ypU7ElRHqClyJmr7
   bM48/lBXsmLsyC0XiDTVvxrhCQi4Cw6fYuv/kv1xtCrXiWtj5Y4KyEwsx
   d7ymlcinmLmvqc4oOYxi2/233tpq5oBBnl/PWcumHlSuFuzLeagR6aev2
   s2ozJ42zrRgJYe0oUqmBSuKpmldV+tspcFsSS9bubVGF+Uq9/1SGf9wCB
   GpruM5onN9sQ5WPa291KaMjzOvsH1jrDNyttD92EQyHUgl12amEa/BctZ
   5dkQgDU1rOEMypE+G8AaEAZEWT4XV98NkkCX1JWVgvHo9HWgZzOYsirMf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="409061823"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="409061823"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 19:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="803936600"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="803936600"
Received: from dklinejr-tigerlake.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.245.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 19:51:47 -0700
Subject: [PATCH] cxl/port: Fix port to pci device assumptions in
 read_cdat_data()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, lukas@wunner.de
Date:   Fri, 21 Apr 2023 19:51:47 -0700
Message-ID: <168213190748.708404.16215095414060364800.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
References: <becaf70e8faf9681d474200117d62d7eaac46cca.1678543498.git.lukas@wunner.de>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Not all CXL ports are associated with PCI devices. Host-bridge and
cxl_test ports are hosted by platform devices. Teach read_cdat_data() to
be careful about non-pci hosted cxl_memdev instances. Otherwise,
cxl_test crashes with this signature:

 RIP: 0010:xas_start+0x6d/0x290
 [..]
 Call Trace:
  <TASK>
  xas_load+0xa/0x50
  xas_find+0x25b/0x2f0
  xa_find+0x118/0x1d0
  pci_find_doe_mailbox+0x51/0xc0
  read_cdat_data+0x45/0x190 [cxl_core]
  cxl_port_probe+0x10a/0x1e0 [cxl_port]
  cxl_bus_probe+0x17/0x50 [cxl_core]

Some other cleanups are included like removing the single-use @uport
variable, and removing the indirection through 'struct cxl_dev_state' to
lookup the device that registered the memdev and may be a pci device.

Fixes: af0a6c3587dc ("cxl/pci: Use CDAT DOE mailbox created by PCI core")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 25b7e8125d5d..bdbd907884ce 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -536,17 +536,18 @@ static int cxl_cdat_read_table(struct device *dev,
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct pci_doe_mb *cdat_doe;
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
+	struct device *host = cxlmd->dev.parent;
 	struct device *dev = &port->dev;
-	struct device *uport = port->uport;
-	struct cxl_memdev *cxlmd = to_cxl_memdev(uport);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct pci_doe_mb *cdat_doe;
 	size_t cdat_length;
 	void *cdat_table;
 	int rc;
 
-	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+	if (!dev_is_pci(host))
+		return;
+	cdat_doe = pci_find_doe_mailbox(to_pci_dev(host),
+					PCI_DVSEC_VENDOR_ID_CXL,
 					CXL_DOE_PROTOCOL_TABLE_ACCESS);
 	if (!cdat_doe) {
 		dev_dbg(dev, "No CDAT mailbox\n");

