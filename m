Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D3358B5
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II/JPzAa"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C2CC
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697136836; x=1728672836;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4QwlekaDCmh4nU+rJqHNHFk/yzfADdGnns0sqNANpc=;
  b=II/JPzAaSMNRKHVafKCnuamLq36J5C/MZ5geD6V0s4UxO6YzVjinALrJ
   k9tTj1pbgbVNKr06a0NfP8Rig00x9MrG/3Cp0n7W2rHauFPK2wrs6uqbP
   Su7q4JcsXAPoh7tveYVzNc8j2awlDsDyc3p0uwQ6RE8ebrCTznmp17dIN
   L61BnFJxrBDb7JfJsf0HxAJ/mBVJt+Zakhc6Hvhm9UycnC/IlkJ+Iziot
   NRDYkmFzAkJny9YrMoSei083UzTTnwcdtJgM7CYQM0/XB+Ork9e1+mFI0
   9jhAjRmpCfwqTSgI5xaOZ/SD30VSPvZVokQuAI/20OuvqHfeCTDKVoO2n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="387864931"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="387864931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="898245676"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="898245676"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.15.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:52:00 -0700
Subject: [PATCH v11 03/22] cxl: Add support for reading CXL switch CDAT table
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 12 Oct 2023 11:53:48 -0700
Message-ID: <169713682855.2205276.6418370379144967443.stgit@djiang5-mobl3>
In-Reply-To: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add read_cdat_data() call in cxl_switch_port_probe() to allow
reading of CDAT data for CXL switches. read_cdat_data() needs
to be adjusted for the retrieving of the PCIe device depending
on if the passed in port is endpoint or switch.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |   22 +++++++++++++++++-----
 drivers/cxl/port.c     |    3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9321a3865c30..c86bcc181a5d 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -613,18 +613,30 @@ static unsigned char cdat_checksum(void *buf, size_t size)
  */
 void read_cdat_data(struct cxl_port *port)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
-	struct device *host = cxlmd->dev.parent;
+	struct device *uport = port->uport_dev;
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
index 6240e05b9542..47bc8e0b8590 100644
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


