Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E343D2421C
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142814; cv=none; b=Cv/fQpwb7g8A4j2pTkcDQ9WRtef79RjjUZ68tcAniNxhR9WBj89+XUF+hXcWJbqcKh1h4ugrisW4vMR234nv/duL8/EcgjJmYeiAtscFmTmUZX0B3Azq8hLQBt6Fhs5dBpUVN5K2PJ7brtmOm8nY6rePcdG8Miwtf0M5iqfUaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142814; c=relaxed/simple;
	bh=mf6O+fJAb5la1piugbmmii0I9swXSIZF0acdR7hgeUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTrC07GwOs6Jcm249dMe5q3EKRpis/suen9kaLc2MBNmqij4Zb2DKMFCWWxRVP61tLRlKzm03Th/DsoVyGvuHcYkhFovnrGPLnDqDBAHFXWdJdMSbNaFvhVpE9ht5tpMSpfDprsdJLjfwuMkwBp/L5774sroIk9vgDD/xjrDlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7jf4XCKz6J67k;
	Mon,  5 Feb 2024 22:16:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EC2C140D1A;
	Mon,  5 Feb 2024 22:20:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:20:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 01/11] hw/pci: Add pcie_find_dvsec() utility.
Date: Mon, 5 Feb 2024 14:19:30 +0000
Message-ID: <20240205141940.31111-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Simple search code used to find first instance of a PCIe
Designated Vendor-Specific Extended Capability.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci/pcie.h |  1 +
 hw/pci/pcie.c         | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 11f5a91bbb..ff559a6653 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -127,6 +127,7 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev);
 
 /* PCI express extended capability helper functions */
 uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
+uint16_t pcie_find_dvsec(PCIDevice *dev, uint16_t vid, uint16_t id);
 void pcie_add_capability(PCIDevice *dev,
                          uint16_t cap_id, uint8_t cap_ver,
                          uint16_t offset, uint16_t size);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6db0cf69cd..9f1ca718b5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -944,6 +944,30 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id)
     return pcie_find_capability_list(dev, cap_id, NULL);
 }
 
+uint16_t pcie_find_dvsec(PCIDevice *dev, uint16_t vid, uint16_t id)
+{
+    uint16_t prev = 0;
+    uint16_t next;
+
+    while (1) {
+        uint32_t head1;
+
+        next = pcie_find_capability_list(dev, 0x23, &prev);
+        if (!next) {
+            break;
+        }
+        head1 = pci_get_long(dev->config + next + 4);
+        if ((head1 & 0xFFFF) == vid) {
+            uint16_t head2 = pci_get_word(dev->config + next + 8);
+            if (head2 == id) {
+                return next;
+            }
+        }
+        prev = next;
+    }
+    return 0;
+}
+
 static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
 {
     uint32_t header = pci_get_long(dev->config + pos);
-- 
2.39.2

