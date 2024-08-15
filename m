Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DBA63C
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683293; cv=none; b=roimw2byofHwkx2Y2YKyiDUeANC2bHm7zv3Rt1Iv/9zhR7MIHuHO8sd/8bHTUg3v/SB5q7SiKTeig3h3O06yF9oRDIWq9QIJFGyllAEf7/ORC5eB+Po97cVXJEJY44Sk8kGrccYfMdP2Hj2OXMHdROOfUJ+tieKqAENBHM4PJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683293; c=relaxed/simple;
	bh=HK2js8v7tUp1sOLeRRN1AQqbdnzR4T3wa4h0GQ/IhCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldn5DetJBx8bZEz6b1CSbrxakAYbAEPhBCvI9EtLJ8FbDbnRHWK5lypjdum6W6nQbEGv5KrE/trfGPwW6DH2xCPSK65fwHASHbPDiRlGWzYPG+mJliwQ3gtbeGQvuZPmdU4ROXJ4jjyyErYdFLtGFP9VNd+omt/9WfnwaypDZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Rq8q+LoR; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Rq8q+LoR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1723683290; x=1755219290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HK2js8v7tUp1sOLeRRN1AQqbdnzR4T3wa4h0GQ/IhCI=;
  b=Rq8q+LoR9YUo8/h1bHuoh1EpNA/kmzSJYnUpJxMjQrRTk27kPXE/Dj0L
   lIGp4bXq4fWCCIZft/PlQMIiBasfZ/UEpM9sSHi6/mQ99ovKGApPznUOE
   lwK3R/q0LwLKY548kSo76yhSYvces+7zSF3bCC1S7x2nGFM+le7CbwLcl
   WejJdsCXRzgnSSXG+7t5d/uz81GGZkv6brkFt+HomMhK9pEoixw70x7e2
   2iVme4uQ0PPIH1hCmAUi2/dyx9PrMfv+uFXodbDIWRu/o/CJuCQ6SygRn
   I9nV996ICKnc9q9bqcRf3gXXL4LZRtgrMbtehqiaeoYdUQXjJGHRa9bRl
   Q==;
X-CSE-ConnectionGUID: K9OzUVGBTDKwNkZ1XVouMg==
X-CSE-MsgGUID: b9ErJwVvTr+5LE+WOq8bbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="158930160"
X-IronPort-AV: E=Sophos;i="6.10,147,1719846000"; 
   d="scan'208";a="158930160"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 09:53:38 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6FCE3CA1E3
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 09:53:36 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B57B6D73CB
	for <linux-cxl@vger.kernel.org>; Thu, 15 Aug 2024 09:53:35 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 7DE81200536D;
	Thu, 15 Aug 2024 09:53:35 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v16 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Thu, 15 Aug 2024 09:55:11 +0900
Message-ID: <20240815005510.220835-4-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240815005510.220835-1-kobayashi.da-06@fujitsu.com>
References: <20240815005510.220835-1-kobayashi.da-06@fujitsu.com>
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
index 4eaf64d92541..4e51b6a0a97b 100644
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
+	struct cxl_port *root __free(put_cxl_root) =
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

