Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737167E574
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908565; cv=none; b=ISGxut5VTB9WuQpxIqc1aH+ubwTbOBKO2eadK6hiVsZjNuv2INDprIMMA5asr4aX5aR9xnQnkAhTHoRKrh3N/bZmOKLRmOsARy+Od8v7BTcKTOtOYqD7t9XZFQM4fjtuqCeYl3JA2hp2/xrRA9aY1bFQidtZor5RN5tvoOPWlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908565; c=relaxed/simple;
	bh=MC/kC3tjf8F3nFbjGncE5oLrDPw2bfioX4xOpiBSM5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1Sxyzt1H++9mN2/M2nnfMX2NOi7W81o8ihgWiSGXCmhw7zvwE1P+Xuljpth8uiLcsNxhXPxJb458taDVXNeatBY862SkJ1OvqZl3gOwPI4dgQRI0TMTDvJACDWvbzeUSYpvqEE2dmGhTwC3CXNkUljfsttxI0Pgl2naJdDBcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRxDx3XwGz6K9L5;
	Mon, 14 Oct 2024 20:22:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 304ED140445;
	Mon, 14 Oct 2024 20:22:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:22:40 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 7/7] hw/pci-bridge: Make pxb_dev_realize_common() return if it succeeded
Date: Mon, 14 Oct 2024 13:19:02 +0100
Message-ID: <20241014121902.2146424-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
References: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

For the CXL PXB there is additional code after pxb_dev_realize_common()
is called.  If that realize failed (e.g. due to an out of range numa_node)
we will get a segfault.  Return a bool so the caller can check if the
pxb_dev_realize_common() succeeded or not without having to poke around
in the errp.

Fixes: 4f8db8711cbd ("hw/pxb: Allow creation of a CXL PXB (host bridge)")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 4578e03024..07d411cff5 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -330,7 +330,7 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
            0;
 }
 
-static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+static bool pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
                                    Error **errp)
 {
     PXBDev *pxb = PXB_DEV(dev);
@@ -342,13 +342,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
 
     if (ms->numa_state == NULL) {
         error_setg(errp, "NUMA is not supported by this machine-type");
-        return;
+        return false;
     }
 
     if (pxb->numa_node != NUMA_NODE_UNASSIGNED &&
         pxb->numa_node >= ms->numa_state->num_nodes) {
         error_setg(errp, "Illegal numa node %d", pxb->numa_node);
-        return;
+        return false;
     }
 
     if (dev->qdev.id && *dev->qdev.id) {
@@ -394,12 +394,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
     pci_config_set_class(dev->config, PCI_CLASS_BRIDGE_HOST);
 
     pxb_dev_list = g_list_insert_sorted(pxb_dev_list, pxb, pxb_compare);
-    return;
+    return true;
 
 err_register_bus:
     object_unref(OBJECT(bds));
     object_unparent(OBJECT(bus));
     object_unref(OBJECT(ds));
+    return false;
 }
 
 static void pxb_dev_realize(PCIDevice *dev, Error **errp)
@@ -500,7 +501,9 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pxb_dev_realize_common(dev, CXL, errp);
+    if (!pxb_dev_realize_common(dev, CXL, errp)) {
+        return;
+    }
     pxb_cxl_dev_reset(DEVICE(dev));
 }
 
-- 
2.43.0

