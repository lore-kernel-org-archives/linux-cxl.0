Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175A63AE
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718684846; cv=none; b=gKzWsBPLxXzIC2Mz0MnrKJ4StKkIbe8G6L8+HtPTh9OPF9yZnmX/6Shei/dFXYevXv3GDWJlHBLNJwazeAiEHx3QeaqIVtuwu4oAIO7TUwkYklD/1Xw7YyFQAFvZ+ccm1eMY1ScEC9V5PDyHsW5YTt5P0gvIrphVcK/d7TReAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718684846; c=relaxed/simple;
	bh=AzOJck6PLn01Que+L6rHPxNIN4lWApn970GhQuk2ACw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSX5uZ5Q2w6ZM/kTL945VfSpKYcuRbH3G3ge8SRj65H5D+2FMqRp5gkOejCdBf0cR2VcmNkEk33p8tJOGDip6AOK/Upsn7EVre1L4UsNvJ4V5X/ZZIS9jW0Ix2+nTL4Odm4fbZF18Kvq27c7rIaRlxm0XwMA8Q3KDdeBr2uTrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Wbl5v0NH; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Wbl5v0NH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718684845; x=1750220845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AzOJck6PLn01Que+L6rHPxNIN4lWApn970GhQuk2ACw=;
  b=Wbl5v0NHznZp8o7tH6kz/6uYpfGK2p5dbMbuQVWdBXMRVNwbi9KevSAF
   nA6vvPX23kWbH19UFu9ZNVJfOYnJ/wP0ih3QGctxEdsFMIXD3jmKz7fMM
   EKEgksLn+7Z54yLDzwr6qEG/Kv+DpiQfYPNcPTcYQxMiCi4Fi3TqCQyTp
   Mmb56ufYJ4mqzTDjlgLV12tVkgXuAtKtS3fyEhUjB/MMqPlt7Iu6seZxJ
   GoytOVTbne6GBiqDUWXwxzlLtGQPVQbquPjQdr5WIT8mPR8W5xLk8Bd3c
   PVCuBEbIeS9oJijO5yEA04DcwOJ3zGittVrNEbmFUCcOE6TGqyJ6pa+nN
   A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="142729673"
X-IronPort-AV: E=Sophos;i="6.08,246,1712588400"; 
   d="scan'208";a="142729673"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 13:27:16 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B292CCC14F
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 13:27:13 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0AE93BF3D5
	for <linux-cxl@vger.kernel.org>; Tue, 18 Jun 2024 13:27:13 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id BF8F820053F9;
	Tue, 18 Jun 2024 13:27:12 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Tue, 18 Jun 2024 13:29:41 +0900
Message-ID: <20240618042941.96893-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
References: <20240618042941.96893-1-kobayashi.da-06@fujitsu.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
---
 drivers/cxl/pci.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bbc55732d6c1..6fa8a1a031bb 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -790,6 +790,86 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size_t width)
+{
+	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+
+	port = cxl_mem_find_port(cxlmd, &dport);
+	if (!port)
+		return -EINVAL;
+
+	endpoint_parent = port->uport_dev;
+	if (!endpoint_parent)
+		return -ENXIO;
+
+	guard(device)(endpoint_parent);
+	if (!endpoint_parent->driver)
+		return -ENXIO;
+
+	if (dport->regs.rcd_pcie_cap == NULL)
+		return -EINVAL;
+
+	switch (width) {
+	case sizeof(u16):
+		return sysfs_emit(buf, "%x\n",
+				  readw(dport->regs.rcd_pcie_cap + offset));
+	case sizeof(u32):
+		return sysfs_emit(buf, "%x\n",
+				  readl(dport->regs.rcd_pcie_cap + offset));
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t rcd_link_cap_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKCAP, buf, sizeof(u32));
+}
+static DEVICE_ATTR_RO(rcd_link_cap);
+
+static ssize_t rcd_link_ctrl_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKCTL, buf, sizeof(u16));
+}
+static DEVICE_ATTR_RO(rcd_link_ctrl);
+
+static ssize_t rcd_link_status_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return rcd_pcie_cap_emit(dev, PCI_EXP_LNKSTA, buf, sizeof(u16));
+}
+static DEVICE_ATTR_RO(rcd_link_status);
+
+static struct attribute *cxl_rcd_attrs[] = {
+	&dev_attr_rcd_link_cap.attr,
+	&dev_attr_rcd_link_ctrl.attr,
+	&dev_attr_rcd_link_status.attr,
+	NULL
+};
+
+static umode_t cxl_rcd_visible(struct kobject *kobj, struct attribute *a, int n)
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
+	.attrs = cxl_rcd_attrs,
+	.is_visible = cxl_rcd_visible,
+};
+__ATTRIBUTE_GROUPS(cxl_rcd);
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -973,6 +1053,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.44.0

