Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333671E48A
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 04:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750133248; cv=none; b=BYQYtjsmbymV5BzawYeeclo4oqEmpfKvqPdkh/45qnCEGlgWQZJKTRJi+/XDDz7S8baSAEXonj3mdFx8GXoocVRF/4J9e5atpoK0EecMFOt02HV5BicW4syM+RV9vKbSzPaVh8AeH3EzzIOyFM0adGaLDSSorTPTkLLRgxhGXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750133248; c=relaxed/simple;
	bh=4uIopS+J/OPldqWgyEZXu1DsLVz/bz9hgnaLpMzU/Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyztpHkpIMDEJXatlUVqF1wd7GCTXFJktVCnlMwmVxt5hXIm9IH7FPplJRXntD2bduroqLjKQItGEEqGZiBV1Yxl6XVL3qa+YkNjKlzNxHHls6PmUlttv9k9muXPDmJNM/F1aaXieNPrXBGgIai+7mAlWUHWcANo8HeL7N4XthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3f3_26VBoykY4Aw--.374S2;
	Tue, 17 Jun 2025 12:07:18 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwAHmiPr6VBo5wZWAA--.5570S4;
	Tue, 17 Jun 2025 12:07:15 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	wangyuquan <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH v3 1/2] hw/pxb-cxl: Rename the pxb cxl host bridge
Date: Tue, 17 Jun 2025 12:06:48 +0800
Message-Id: <20250617040649.81303-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
References: <20250617040649.81303-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAHmiPr6VBo5wZWAA--.5570S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWhPIu4E8QAZsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF1UWr4ktw45Xw45WrW7Jwb_yoW8uryUpF
	yFg3W5tr1DJFWjkw4fCa4kXFyUC3Z7GrWrZFs7Gwn2kF1xWFyYqrsFka4IvF1UJFW0kFyj
	va1jvFW8uw4fAaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

This renames some descriptions and definitions of pxb cxl host
bridge, since the original names can be confusing.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/pci-bridge/pci_expander_bridge.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3a29dfefc2..bd637786d0 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -201,7 +201,7 @@ static void pxb_cxl_realize(DeviceState *dev, Error **errp)
 }
 
 /*
- * Host bridge realization has no means of knowning state associated
+ * PXB Host bridge realization has no means of knowning state associated
  * with a particular machine. As such, it is nececssary to delay
  * final setup of the host bridge register space until later in the
  * machine bring up.
@@ -240,7 +240,7 @@ static void pxb_cxl_host_class_init(ObjectClass *class, const void *data)
  * This is a device to handle the MMIO for a CXL host bridge. It does nothing
  * else.
  */
-static const TypeInfo cxl_host_info = {
+static const TypeInfo pxb_cxl_host_info = {
     .name          = TYPE_PXB_CXL_HOST,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(CXLHost),
@@ -522,7 +522,7 @@ static void pxb_cxl_dev_class_init(ObjectClass *klass, const void *data)
      * vendor, device, class, etc. ids are intentionally left out.
      */
 
-    dc->desc = "CXL Host Bridge";
+    dc->desc = "PXB CXL Host Bridge";
     device_class_set_props(dc, pxb_cxl_dev_properties);
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 
@@ -549,7 +549,7 @@ static void pxb_register_types(void)
     type_register_static(&pxb_pcie_bus_info);
     type_register_static(&pxb_cxl_bus_info);
     type_register_static(&pxb_host_info);
-    type_register_static(&cxl_host_info);
+    type_register_static(&pxb_cxl_host_info);
     type_register_static(&pxb_dev_info);
     type_register_static(&pxb_pcie_dev_info);
     type_register_static(&pxb_cxl_dev_info);
-- 
2.34.1

