Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6F1CB523
	for <linux-cxl@vger.kernel.org>; Tue,  3 Sep 2024 02:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725332291; cv=none; b=IK64u6Hpafkl4JB+GDa1RH7k4NrpWWSaAJ7vPJuq14zXptpKhuBgoR89wo887N0VogHmFLCPCPTNiLqnDslWcL46AOpdQbg0R907fJaqAQSoknFWdO9I6gWHuhV75hjLCiiyvWX6Mj3+gZ9rGfz8Ox6uLvIRsVkHADmEVyrVqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725332291; c=relaxed/simple;
	bh=ZKG2j0WW7/+SkxXmxLc9MoeSBxm8JVQ7GyXpoxAFMv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQUgBaPTXfSQ7wfK6tO7KcEASXFgmch14HgJDoFe47pF0eWYiBeEJeOkTA4okvOOeLRLGjrilxn002PCULVAI4/XJ3YJTd1rkMqnDERfUb7nY/Vz/urk91RU32h1Yz9enEY/dXOOoJ2bp4CKic3g5DnrBlF+eazX3oZUGox1678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jqI2OPCN; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jqI2OPCN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1725332289; x=1756868289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZKG2j0WW7/+SkxXmxLc9MoeSBxm8JVQ7GyXpoxAFMv0=;
  b=jqI2OPCNmQDApiTstTVVsQVIrUs9H0lRIaopyNtcvrVVmEiUEwwXluaU
   zvftoRlxtQ2foSS/jvtO8LsilMoBmduE7j61WQLqb89v8x9xbxgOxPbFA
   DAGuCAc2924BrlFs9yYM+OUoGzurMk8e4TLv/kmliwgMEwZJuCmSWHDo3
   E+QeZjXmKmxh6pDdG/hTU6T8So565VQR6FIkz7/iMNr6mbxkboQP0kz+k
   QlO3jmbAqXWBZRy30LJwWSv0LaRWEE1dhuIx4q3TUH4+cF8sqfEgMnh3c
   GW1DwiceFkrmGGtabVX7jVjkfjrMAZXxe8OL0Jy9MJe5uoipKbPHnBnhh
   w==;
X-CSE-ConnectionGUID: FurvxH9FQESWTKSsSm52+Q==
X-CSE-MsgGUID: 7uTbVpprTrWZa/1I8+g/lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="160492087"
X-IronPort-AV: E=Sophos;i="6.10,197,1719846000"; 
   d="scan'208";a="160492087"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 11:56:58 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C6E6DAE08
	for <linux-cxl@vger.kernel.org>; Tue,  3 Sep 2024 11:56:56 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6BBD9D50E8
	for <linux-cxl@vger.kernel.org>; Tue,  3 Sep 2024 11:56:55 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 4CEA22005340;
	Tue,  3 Sep 2024 11:56:55 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Tue,  3 Sep 2024 11:59:15 +0900
Message-ID: <20240903025915.270521-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240903025915.270521-1-kobayashi.da-06@fujitsu.com>
References: <20240903025915.270521-1-kobayashi.da-06@fujitsu.com>
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
index 5aebb0ab3dd1..09a3c111413a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -792,6 +792,83 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
@@ -975,6 +1052,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.45.0

