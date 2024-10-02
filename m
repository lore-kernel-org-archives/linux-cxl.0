Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5881FA5
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831686; cv=none; b=Ou6EBcNhkVTZikHYFUx4clcgILk+7rFKCuiSsTNSXPPz885c8AoVj7c+PylWyfS8B1+EvbuRvV/O5xOVP+n3Ra8YspLdrks+3rF++VpApWe81me7aWonvr7JyEzFlbIf5WdapHRQX6PBBy7jb9MIo3XWZWqywzF8Bol1sC5rJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831686; c=relaxed/simple;
	bh=6ja6kS1lGL7dW6Nu3HFFrWJ74PaxQE35jaGTFCjT1l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtCoFZDLvkuey2QInp2aax3iN1c1X5DfMyIywKJrUiXIVtcbfMQxWORaeGdNPba67p7arrzXn9sLHUycCYhgGBjwQPIw3w4RZf+icdScyHWVrCOcUgk3OSgSA3pIpJIpY2mDUmHWP6TsobdceN9iufhOr1zOOKkqv4H77o39Rkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tgbgIXcx; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tgbgIXcx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1727831684; x=1759367684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ja6kS1lGL7dW6Nu3HFFrWJ74PaxQE35jaGTFCjT1l0=;
  b=tgbgIXcxXbEx6Szcnw3r6WqXDNfE5c7EcPSE4L7lYmmv8cHc0zRpeR2V
   ZQKJYcfrXo6FbbCopE/cp3Litr3zYIpofk8PEhxIOvzRrZq059rKRfvUx
   6hJb/n0DLaH8nZ9V5AMreF5hogbEIdO/K+4lhJG/xucIEYuBxqVTsncRZ
   /mp1VctLEfir4DuwvBzvmPa9EVO50ahcyUYvLPZqMwJ2iNvzI1E1h+Lcu
   wpVp54wM+pJicMINmMZfbMAiLeD2rWOa4FDaZ9munAz27HMWEL1pzFniM
   B5DdRClKytm1WvcOrjBLk9nUI0p/AV1dQaovlIbHxINScGgJIH/Ai5XH+
   w==;
X-CSE-ConnectionGUID: /YDzW2FBRIKWCZe3rm2SLg==
X-CSE-MsgGUID: i7vCu7zxRAaUTenyK2PSYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="162807887"
X-IronPort-AV: E=Sophos;i="6.11,170,1725289200"; 
   d="scan'208";a="162807887"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:13:33 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A0711E8526
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 10:13:30 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E7D79D50B2
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 10:13:29 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id C64FF2005338;
	Wed,  2 Oct 2024 10:13:29 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v18 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Wed,  2 Oct 2024 10:15:49 +0900
Message-ID: <20241002011549.408412-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/pci.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 05d49ea2466d..bbbb241e1c26 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -820,6 +820,83 @@ static int cxl_pci_type3_init_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size_t width)
+{
+	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *root_dev;
+	struct cxl_dport *dport;
+	struct cxl_port *root __free(put_cxl_port) =
+		cxl_mem_find_port(cxlmd, &dport);
+
+	if (!root)
+		return -ENXIO;
+
+	root_dev = root->uport_dev;
+	if (!root_dev)
+		return -ENXIO;
+
+	guard(device)(root_dev);
+	if (!root_dev->driver)
+		return -ENXIO;
+
+	switch (width) {
+	case 2:
+		return sysfs_emit(buf, "%#x\n",
+				  readw(dport->regs.rcd_pcie_cap + offset));
+	case 4:
+		return sysfs_emit(buf, "%#x\n",
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
@@ -1029,6 +1106,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.45.0

