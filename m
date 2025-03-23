Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F766201006;
	Sun, 23 Mar 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742722474; cv=pass; b=ScrPxWK3X6BeNuer70dYSYFC0/GgomvnL7u5J9fUWR78FSlUDzT206AOUBA7Ecy9uaYW08+ht3DsTKs4csGgQRXHlaIBATFvknv3P3rMVubWW2fn0FKyKGz/pAJzL+NhRr4VhYww7eb1fJpjxxgNHTvorm/opABJMbS/IrVfeFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742722474; c=relaxed/simple;
	bh=3MTYhQELhhmoAHr2itXBrGDEDVYaZP97mblWMNS7zPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKgrY/Fa4hLqwS6/MAmkifWg0oazN5/KZMYLEsp3IzbTX500hhOfq7GmvnMqWnRMDTzC9LpT+09iUchY4jOHuCkfzCINY+8cbPDZxvgTR0PAKH7LK480Wqf+NCi7exUfhqB6rTVpxVUyd4nmU6QgjbtduKyzNOOViv+qU2vfgV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=F8LcahXK; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="F8LcahXK"
ARC-Seal: i=1; a=rsa-sha256; t=1742722319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a8QfsJuyFZcgRtuAuuGMwEzoZMYkq9k7xjJvNignIvulGwR3T5w8WxeUjSgHdD/D0XLllMY0cd5AWVBXf8vzG2H5YA8ix/O9/4AojV6BR1NVLGtxtzHxwn/9+hZ7AmNm750/4JyVDucmqWSlwD9VNZlBqGiLk6yZ7ruMY1OXDkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742722319; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uYKpGB1btXham6jc3sUGgsKSa89IKrQ8n0M2pm4m9A4=; 
	b=n8jCbMqR9M/vylpBsr0JZgOwe/0h1UMgwNUPdHz87QL4aTmeWqye3LW48ZYPANdBJCKEt3NJkDG/tZbm7o5ZegvgQuoPjbMr1MaBm8bO6VrVezkZBons72/zpDVufnHpc71bdHruo9RIFdbgXQURtp8qAir/YjO3WSRB4Z5fdjE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742722319;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=uYKpGB1btXham6jc3sUGgsKSa89IKrQ8n0M2pm4m9A4=;
	b=F8LcahXKKlinpMnD40o2pEhUWMR1uAplXSvmq0tC4kLXOfxpnxFZosZwYDjOFCjB
	M33LYqGzyzrC4JC4RLGz+qBn8qLMooR9geMNa976QpinZLL1u2t9ejsHvGdb3Galmce
	ETi+3L+38tTTyXHl3olKSixfXzG/DvqVD4aDWqrc=
Received: by mx.zohomail.com with SMTPS id 1742722317848132.1813064848485;
	Sun, 23 Mar 2025 02:31:57 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 3/3] cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()
Date: Sun, 23 Mar 2025 17:31:10 +0800
Message-Id: <20250323093110.233040-4-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250323093110.233040-1-ming.li@zohomail.com>
References: <20250323093110.233040-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227d9758ba022786c95310414780000b5abe8c267f9b74a4c09fef03e4bd902e5986ac2f5c3ad5261:zu0801122731e06d6555dbd7671af0ea8a00009be04fed6129c7ea4828dbf6c32c9468ea7f10710a36a5e727:rf0801122de4eb419cef64a976b494f4b000005880f0732d085e7595e45ffb44e5993faf2edc1741558a31419133dfbcc936:ZohoMail
X-ZohoMailClient: External

The first parameter of cxl_gpf_get_dvsec() is a struct device, can be
used to distinguish if the device is a cxl dport or a cxl pci device by
checking the PCIe type of it, so the parameter is_port is unnecessary
to cxl_gpf_get_dvsec(), using parameter struct device is enough.

Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 12 +++++++++---
 drivers/cxl/cxl.h      |  2 +-
 drivers/cxl/pmem.c     |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index edbdaf1681e8..3b80e9a76ba8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1072,14 +1072,20 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 #define GPF_TIMEOUT_BASE_MAX 2
 #define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */
 
-u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port)
+u16 cxl_gpf_get_dvsec(struct device *dev)
 {
+	struct pci_dev *pdev;
+	bool is_port = true;
 	u16 dvsec;
 
 	if (!dev_is_pci(dev))
 		return 0;
 
-	dvsec = pci_find_dvsec_capability(to_pci_dev(dev), PCI_VENDOR_ID_CXL,
+	pdev = to_pci_dev(dev);
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
+		is_port = false;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
 			is_port ? CXL_DVSEC_PORT_GPF : CXL_DVSEC_DEVICE_GPF);
 	if (!dvsec)
 		dev_warn(dev, "%s GPF DVSEC not present\n",
@@ -1137,7 +1143,7 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
 		struct pci_dev *pdev;
 		int dvsec;
 
-		dvsec = cxl_gpf_get_dvsec(dport->dport_dev, true);
+		dvsec = cxl_gpf_get_dvsec(dport->dport_dev);
 		if (!dvsec)
 			return -EINVAL;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2d81ccd83916..a9ab46eb0610 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -910,6 +910,6 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 #define __mock static
 #endif
 
-u16 cxl_gpf_get_dvsec(struct device *dev, bool is_port);
+u16 cxl_gpf_get_dvsec(struct device *dev);
 
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index d061fe3d2b86..e197883690ef 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -108,7 +108,7 @@ static void cxl_nvdimm_arm_dirty_shutdown_tracking(struct cxl_nvdimm *cxl_nvd)
 		return;
 	}
 
-	if (!cxl_gpf_get_dvsec(cxlds->dev, false))
+	if (!cxl_gpf_get_dvsec(cxlds->dev))
 		return;
 
 	if (cxl_get_dirty_count(mds, &count)) {
-- 
2.34.1

