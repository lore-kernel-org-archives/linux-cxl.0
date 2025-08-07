Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843A27780D
	for <linux-cxl@vger.kernel.org>; Thu,  7 Aug 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564401; cv=none; b=JLvdv8qb04PFkPWFGHRw2lBPUYRpRElzHQkg0o6MSTi77XoYOxh0ZyZBt85drqJIDV/kkGilNUOV4gJnGXwmEUCgdM8eW1PyDahIduTzf8ftncl02rr6ojiLrxBV/If0Aw/IXl0+V80dv3h1uRF+PvX3mcv12/zNlYf95KEJ7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564401; c=relaxed/simple;
	bh=4uIopS+J/OPldqWgyEZXu1DsLVz/bz9hgnaLpMzU/Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFdiSFFPH6ZlZw02z5sdL0gSJUHC7vok3aZ06eAc9z1fPDGUGuVjG08/KLFnSzhHCk/CN/xhC7EywDlwjfvzbN/+RrbJHDMaXTq9BPjKwgA9OGDWeHO7gd71ck2lY+WnOmCsojUsMgunwnPjK4vF1SdyY5JtLPaunKurdAfnLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHXWEjh5Rol0CABA--.51115S2;
	Thu, 07 Aug 2025 18:59:47 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwDHTwcSh5RoT_kKAA--.12934S4;
	Thu, 07 Aug 2025 18:59:44 +0800 (CST)
From: wangyuquan <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	rad@semihalf.com,
	peter.maydell@linaro.org,
	leif.lindholm@oss.qualcomm.com,
	graf@amazon.com,
	claudio.fontana@huawei.com,
	philmd@linaro.org,
	richard.henderson@linaro.org
Cc: chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	wangyuquan <wangyuquan1236@phytium.com.cn>
Subject: [RFC QEMU PATCH v4 1/2] hw/pxb-cxl: Rename the pxb cxl host bridge
Date: Thu,  7 Aug 2025 18:59:09 +0800
Message-Id: <20250807105910.240070-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
References: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDHTwcSh5RoT_kKAA--.12934S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWiTrgAFiAAAsX
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF1UWr4ktw45Xw45WrW7Jwb_yoW8uryUpF
	yFg3W5tr1DJFWjkw4fCa4kXFyUC3Z7GrWrZFs7Gwn2kF1xWFyYqrsFka4IvF1UJFW0kFyj
	va1jvFW8uw4fAaUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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

