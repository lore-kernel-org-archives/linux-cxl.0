Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32616F2E8
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007597; cv=none; b=ChA2CNnIUG165E9BjsnzIvgM+pOweXsM6t0I70vZ/P0QrJcYz1+zNOWBNHOatIvd5UjlThxk6Mc+KciYftFwBfONp1LmvYYeeR/SOgW/XswqhS3unubLN3h5WJVnm1acslMbiFkkV06ithHa/22vYuwdJj5ZqEPNm+jwSODXSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007597; c=relaxed/simple;
	bh=idmoC+0jHbpFCQ3EQ53OPZ5XMrr9RxGS5ZymOuq6Vkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP7c/48yoiY6kWGYPbm1529aWv40SXCBNv9eTDXMULspTLaQpByGsfSaTvyLSnFNaYXisj9ELp6zSNNoSk9zOtkw+apnfFGB7KdDvekEJvbx3/1uh+9sBn95PNZEbHZkc9qVAxaGr/Xcsjfaq8RJQvL81Z/OORGjWRn1FJZRkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gQiZ5eeA; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gQiZ5eeA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718007595; x=1749543595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idmoC+0jHbpFCQ3EQ53OPZ5XMrr9RxGS5ZymOuq6Vkc=;
  b=gQiZ5eeAOXBIsoBpMNGEli8fJJHXMvCDV/ExmSWSz2uGJmuaStCxo9jC
   iJlyd9B1ajQbnhlBjoQj+CGJxFG8dUkoNh7+NfLr52Y81IC4nyn+Gh5yJ
   rH01l5CRdyx7UsF87XbeevHyRQSxXYLPJPPfB9t6yerXST7ujNITfUZZd
   PHvgZmo1fCt/BEcAYSgsOrRoWQO0Snjy9/PZdOc46WX19VlMjFQL1F3Tp
   RCOtjkc/4WKbw4EhTJi1U7/YjAbBHyMOVN4AR4vTPZIBk42t70CVnAUoQ
   wEAetUom2Gs/9qwZbK6vf49J3CRgzQqb1VonU71bwTY/7LE1S9SD/c7Sk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="161763792"
X-IronPort-AV: E=Sophos;i="6.08,227,1712588400"; 
   d="scan'208";a="161763792"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 17:19:46 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id BABF6C9323
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 17:19:43 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0BE99141C2
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 17:19:43 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id D7DBB200532B;
	Mon, 10 Jun 2024 17:19:42 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v9 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Mon, 10 Jun 2024 17:22:22 +0900
Message-ID: <20240610082222.22772-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240610082222.22772-1-kobayashi.da-06@fujitsu.com>
References: <20240610082222.22772-1-kobayashi.da-06@fujitsu.com>
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
 drivers/cxl/pci.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..0a09d1250f1d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -786,6 +786,78 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	return 0;
 }
 
+static u32 get_rcd_pcie_caps(struct device *dev, u16 offset)
+{
+	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
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
+	return readl(dport->regs.rcd_pcie_cap + offset);
+}
+
+static ssize_t rcd_link_cap_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x\n",
+					  get_rcd_pcie_caps(dev, PCI_EXP_LNKCAP));
+}
+static DEVICE_ATTR_RO(rcd_link_cap);
+
+static ssize_t rcd_link_ctrl_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x\n",
+					  (u16)get_rcd_pcie_caps(dev, PCI_EXP_LNKCTL));
+}
+static DEVICE_ATTR_RO(rcd_link_ctrl);
+
+static ssize_t rcd_link_status_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%x\n",
+					  (u16)get_rcd_pcie_caps(dev, PCI_EXP_LNKSTA));
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
+	.attrs = cxl_rcd_attrs,
+	.is_visible = cxl_rcd_visible,
+};
+__ATTRIBUTE_GROUPS(cxl_rcd);
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
@@ -969,6 +1041,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.44.0

