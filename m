Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702F23B0
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jul 2024 04:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103868; cv=none; b=AoSu3U/8VYgP7awZwEjZyda3FBiZ3ZGXsGpOK+tbG20UsiOW7SpPoEjQoFyX0lWPQY87XD5Qvx7ZwQ0asdRcDgKsfpUhmE3k9G30duRoEdpWqiW00hkI9qmHyJo4/bdqsnDF+tGYXNtIRviN1AKYAeIAs1JTwH0Bq0b/ldwO2bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103868; c=relaxed/simple;
	bh=bDLVuPWmGFFwlylTxEEtDWOHcAZsCzz1S0fkylN95/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFZwXfRAKl6fHXXycilga6lBL9it9i+N7OabpDPLqIIlcPIpe0J6ZE/Bzx1ndu/9zU7NQy0LfWKLLw/9faDoTD/wNGeskwntTHrOGTCDlsAQ7aVZ0eHXDf3mqGWiZ4S+Xh/Ir1QTUElHVfzB0Lu9g3nz75RdjUFCyDc8CRL22PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QZZIP8fD; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QZZIP8fD"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721103865; x=1752639865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bDLVuPWmGFFwlylTxEEtDWOHcAZsCzz1S0fkylN95/g=;
  b=QZZIP8fDBYKhkNZDQG92/6fQBZx86n9AnL0c8KbTr/LWC7KEh3bo5AKR
   KKoUnHmddrBHCYaoGDfE7hP0zXX6z2tQECyl5G21EEwfxq3gTKr4mk0hK
   cQk8uoIEQCkC01R7mEGNX17RC9z7xDM98RKEA7DbWRMAUmfuP088YLUh+
   7kAuPd9ML2hQW9grj60v7bfMXYR6OOqJxqlPLqkDaLvk2/Q2XN/ss+R8/
   zuaOnjqIDZnWoENi5WSviQlct43UlFK5r95iEiZIkKWD/eodGLzB9A+b6
   6athqi6Tyb/tTjVB0VGtXQSF5/6ODVPjpz/xAEmk6WADj5c2r/u8uYlOp
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="167274141"
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="167274141"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 13:23:08 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B4D62E8521
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jul 2024 13:23:05 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id ECED3D96A2
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jul 2024 13:23:04 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id B6ABB20521FD;
	Tue, 16 Jul 2024 13:23:04 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v15 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Tue, 16 Jul 2024 13:25:40 +0900
Message-ID: <20240716042540.89639-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
References: <20240716042540.89639-1-kobayashi.da-06@fujitsu.com>
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
index 5e7e66f28420..c149c04b029e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -795,6 +795,86 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
@@ -978,6 +1058,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.45.0

