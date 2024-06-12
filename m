Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8A16C69A
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179032; cv=none; b=rvdxZ4ewm6w2qzc0g+U3EEeYxk9aJct0lSZ7NFWOor8JLz96eWaMnYXe4kfXO7ytFi+bq4FZHh/oHOH/GoPD5/UoP0hb2SydqLSF6HLYqv0m8XgMTj3yv2y0R8GP4WqPN6Q8vQU0l4ZXvd4xDmxevB3u5WGr1l0CrbUbIDLoOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179032; c=relaxed/simple;
	bh=BMkdwqp0xmfOkJEMfGwDhqaj4K6uv1+D3qulVuo5RbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV+fnbIyYoEM2y8ia8B+qsxvTEMLFmnj3sEBRuDUU2ybdRPPGmwRifEG7mZad+Y5T2+mAv7wUXpeLZXsimHu9r5gTq0rABAPt2a6LavrOsHA1BOSVVre0tWVtlyLPTnw+S+hFoEyYqSRucnJex0Q0Of1xOiVDEj/Ts8tm3QqqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=m4k1WKrk; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="m4k1WKrk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718179029; x=1749715029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BMkdwqp0xmfOkJEMfGwDhqaj4K6uv1+D3qulVuo5RbI=;
  b=m4k1WKrkePLxmsmqImhwOvuDgWDK655Ml3SdKVhztj8eDO7mKWopUzSm
   qQX0qVpycgEcJnD9ruT/ov83aQEGhDS0Vav10Dgjh4klYlRhCTUTuzm03
   VhA/htM1T/PhT9jOwOEZNFDO7RmWk/9Iw7p9srKgmztLEd70iCudLTwRm
   Ui+s0l5Dgnto5pfjKjCPI4PebMiKLTVX5IUTQ+ZHzlfi7GjK0votix/Vt
   XObkZt6oi+jXvsqIFL/6Ja9sh1ZoTQyoHFF/Da9qSHnDE6W4WA3PklAvy
   cwa6X8p9XG1LPpuXqQReqf42hGH3skWMaHEZbsFeh5NNW8T0ZmY7w9+N+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="162899333"
X-IronPort-AV: E=Sophos;i="6.08,232,1712588400"; 
   d="scan'208";a="162899333"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 16:57:01 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 05C69D29EA
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 16:56:59 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 24DBDBDCA1
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 16:56:58 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id DC7FC200537A;
	Wed, 12 Jun 2024 16:56:57 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v11 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Wed, 12 Jun 2024 16:59:39 +0900
Message-ID: <20240612075940.92500-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240612075940.92500-1-kobayashi.da-06@fujitsu.com>
References: <20240612075940.92500-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/pci.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8e7674c1b8f0..99380a5b1b7d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -788,6 +788,86 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
@@ -971,6 +1051,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.44.0

