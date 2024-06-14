Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1C2C95
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718340808; cv=none; b=raa/VPK+fB7V27gjpNYdtRTvGyvfbqDZ3+c64eL/4bhPJpAj1CfDS58FDQiVCgL0P/Za70hx9GxSJHWveyWvVzULrRlkSsMQC1JiFefBcU1zWqXrpO9IG9EZwPhUu+DO06EzpqPlYvjsHfHvEnb4c9wSAVXuGYRfnU/SrtvP3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718340808; c=relaxed/simple;
	bh=uFtoflPZ482fg9jwwEv87SvMz81X6kBcxJ/LjR2K6N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsOVDBvn6gb6ZQrbC1HAzwkm2dT06S27lUTJULUx/oRV+5BMdRw8VGuQvzT1x59kZ9w2iwQFfBgzvXU+cEF/gXHjusP1987aUY3Cd5GrRdi0fucOcrqTa2UPj4zPzhrKOKVeEj3l40NvAyH7X91Q+D9KkcBnz+/NnYo0Xb3mAi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IDzOz9eT; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IDzOz9eT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718340805; x=1749876805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uFtoflPZ482fg9jwwEv87SvMz81X6kBcxJ/LjR2K6N8=;
  b=IDzOz9eTFvHXO9y2CXSFqLCW6BMxHGdJ277QWo3ydaE9qYnNJwJuMHRJ
   7y9eJnvwt2x8+ku1/nZo0syeHqyZjXqwnMlRKtSD85nKdiNpyaFpcQqHh
   1HKP6lRzCtrVL2dC9KoOVS/uy5ORQ12BKqCdNW8Wr0LVPxcFYeoC1YQ5S
   0llTFxC6UyvyUOF6WUlOAm4pknZoh+QGz8XinmkFUNxc7HMW3Oz0djP1y
   NoEqVGxSCit0hBGcpjuhqmY/pWtKyNbeZTzHGWnQI+E36GIsdf8qzucJg
   ZMZouWkii69uz7VC7kWiUMIBvbZZCeF62bUmIe+BEK1p9spd6/Re5h1jB
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="163117506"
X-IronPort-AV: E=Sophos;i="6.08,236,1712588400"; 
   d="scan'208";a="163117506"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 13:53:22 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 242ACC68ED
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 13:53:20 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 69197D17CF
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 13:53:19 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 3CFBA200535C;
	Fri, 14 Jun 2024 13:53:19 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device link status
Date: Fri, 14 Jun 2024 13:56:11 +0900
Message-ID: <20240614045611.58658-3-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614045611.58658-1-kobayashi.da-06@fujitsu.com>
References: <20240614045611.58658-1-kobayashi.da-06@fujitsu.com>
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
index 62343a5a39ff..3743e9d265c3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -789,6 +789,86 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
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
@@ -972,6 +1052,7 @@ static struct pci_driver cxl_pci_driver = {
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
 	.err_handler		= &cxl_error_handlers,
+	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
-- 
2.44.0

