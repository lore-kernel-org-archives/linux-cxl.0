Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15ADF44
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660004; cv=none; b=bgBNm9Xo0NEzab6NG0LYK0ffjZl2P6t09I4iFxGMamjVO0cKPmhZGAJmqeVox328/d+TJX+BHkp1wPmPU5oOkVxSQtlArqCUHMxdb7NLB8RGm/LNE2J2dnIzGeFURDbShUiMEJBkhtWIw56qe+cS5urTp9jyKJiLnt2anvAMnso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660004; c=relaxed/simple;
	bh=Zxpo7XA6Nbazo/d9OqNy0THIdx7tp5mI5U4cvG3Wa9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGyCNIPjJfZzt/pUiIFmehdTXsuDkgnK2vlBPIlv2S8F0/BSNG9gsbma0nolPVvrktS0NU7WLjv2mFqd19lD02/lq+93SOe/KzmRLoCQioSuQxOwLUB6qQkPG40cFgNc2zyjwuty9f6EV012EmCmVchu0H3Vqt4iiTYzK5P4mnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=sO8NIKZo; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="sO8NIKZo"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717660002; x=1749196002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zxpo7XA6Nbazo/d9OqNy0THIdx7tp5mI5U4cvG3Wa9s=;
  b=sO8NIKZoujGnLG5DZ3OiC4ltYkPxxmMCSPN/oWL35tLxIt2F1mvb76il
   j4OU0iiCQp7iIPhcURi9ER0NQh/v5Gltq5n0ejrDCwrPuFZ3ETU0eqV7r
   yW8zMaeoiZArZIAjGMJvwCBxSD7cOcX1CbRVTd4xx2Z8Yh4Zlz9QQaxNd
   RM1L0+aSJpui6LKzru7EzzMW4f8rRw53vuZQpG94KUoBSm7jSkNPDDwd2
   uhEvIfGaPomTlzTk7t5tPvQAv8waU2ItP3Yt8rolZhw0ZlTR51It9xJLA
   8TfiJjLMnn5X7G6NDISLy8g+2zktV5kJbuECWkjUSWVg0NG2Wl9tJxT7r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="162234576"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="162234576"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:45:35 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id ED1B1D9241
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 16:45:32 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3535ED8B00
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 16:45:32 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id ED415204E1BC;
	Thu,  6 Jun 2024 16:45:31 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v8 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Thu,  6 Jun 2024 16:48:14 +0900
Message-ID: <20240606074814.5633-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240606074814.5633-1-kobayashi.da-06@fujitsu.com>
References: <20240606074814.5633-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.

In CXL1.1, the link status of the device is included in the RCRB mapped to
the memory mapped register area. Critically, that arrangement makes the
link status and control registers invisible to existing PCI user tooling.

Export those registers via sysfs with the expectation that PCI user
tooling will alternatively look for these sysfs files when attempting to
access to these CXL 1.1 endpoints registers.

Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/pci.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..e157959dffc2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -786,6 +786,96 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+static u32 get_rcd_pcie_caps(struct device *dev, u16 offset)
+{
+	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	resource_size_t rcrb;
+	void __iomem *addr;
+	u32 ret;
+
+	port = cxl_mem_find_port(cxlmd, &dport);
+	if (!port)
+		return 0;
+
+	endpoint_parent = port->uport_dev;
+	if (!endpoint_parent)
+		return 0;
+
+	guard(device)(endpoint_parent);
+	if (!endpoint_parent->driver)
+		return 0;
+
+	rcrb = dport->rcrb.base;
+	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
+		return 0;
+	addr = ioremap(rcrb, SZ_4K);
+	if (!addr) {
+		dev_err(dev, "Failed to map region %pr\n", addr);
+		release_mem_region(rcrb, SZ_4K);
+		return 0;
+	}
+
+	ret = readl(addr + dport->rcrb.rcd_pcie_cap + offset);
+	release_mem_region(rcrb, SZ_4K);
+	return ret;
+}
+
+static ssize_t rcd_link_cap_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	u32 linkcap = get_rcd_pcie_caps(dev, PCI_EXP_LNKCAP);
+
+	return sysfs_emit(buf, "%x\n", linkcap);
+}
+static DEVICE_ATTR_RO(rcd_link_cap);
+
+static ssize_t rcd_link_ctrl_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	u16 linkctl = get_rcd_pcie_caps(dev, PCI_EXP_LNKCTL);
+
+	return sysfs_emit(buf, "%x\n", linkctl);
+}
+static DEVICE_ATTR_RO(rcd_link_ctrl);
+
+static ssize_t rcd_link_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	u16 linksta = get_rcd_pcie_caps(dev, PCI_EXP_LNKSTA);
+
+	return sysfs_emit(buf, "%x\n", linksta);
+}
+static DEVICE_ATTR_RO(rcd_link_status);
+
+static struct attribute *cxl_rcd_attrs[] = {
+		&dev_attr_rcd_link_cap.attr,
+		&dev_attr_rcd_link_ctrl.attr,
+		&dev_attr_rcd_link_status.attr,
+		NULL
+};
+
+static umode_t cxl_rcd_visible(struct kobject *kobj,
+					  struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (is_cxl_restricted(pdev))
+		return a->mode;
+
+	return 0;
+}
+
+static struct attribute_group cxl_rcd_group = {
+		.attrs = cxl_rcd_attrs,
+		.is_visible = cxl_rcd_visible,
+};
+__ATTRIBUTE_GROUPS(cxl_rcd);
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -969,6 +1059,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.44.0

