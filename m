Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1C15B548
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787181; cv=none; b=IJI2J1uTOtiiD22Uf8ryEJud2LX8Z37Dv+6BLp6rA6nXfTGI68s1mchUsEm3j0JqbjjiUTh7/LdHPenQPnExisGBn8K/ih2UJJpz5ZThuwsfEkOLVx7llprlV1Hm3LPyoTASFDwXOK3h23l4uhGKvtzErbPuFMvKl+YGzryg2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787181; c=relaxed/simple;
	bh=Zh/IIFaIdYqhAu8h/+u1b4488tZSuqKAmNoUg+1IKq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pe1RhS9uqSF02csuIjccqgNi+2kNLU3saqFHpF0chlU1ZdT5ij+es/PsL0pVdLAhu2qjV0pg4+bgQVLbPuhLVlQTqitGZcZzq9shgMEq5SAJ19R01bIDMaN8cknkG9WZGruNuhxE16mSAKaMcZvqIzsjs0PT2dBRquuWNc8ptwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL9ls0sR3z6JB8s;
	Fri, 12 Jul 2024 20:25:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CF7D140B2A;
	Fri, 12 Jul 2024 20:26:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 13:26:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [RFC qemu 4/6] hw/pcie: Provide a utility function for control of EP / SW USP link
Date: Fri, 12 Jul 2024 13:24:12 +0100
Message-ID: <20240712122414.1448284-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
References: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Whilst similar to existing PCIESlot link configuration a few registers
need to be set differently so that the downstream device presents
a 'configured' state that is then used to 'train' the upstream port
on the link.  Basically that means setting the status register to
reflect it succeeding in training up to target settings.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci/pcie.h |  2 ++
 hw/pci/pcie.c         | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 5eddb90976..b8d59732bc 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -141,6 +141,8 @@ void pcie_acs_reset(PCIDevice *dev);
 void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
+void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
+                               PCIExpLinkSpeed speed);
 
 void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp);
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b14d59573e..89734b50a2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -154,6 +154,24 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
     }    
 }
 
+void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExpLinkWidth width,
+                               PCIExpLinkSpeed speed)
+{
+    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
+
+    /*
+     * For an end point or USP need to set the current status as well
+     * as the capabilities.
+     */
+    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
+                                 PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
+    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
+                               QEMU_PCI_EXP_LNKSTA_NLW(width) |
+                               QEMU_PCI_EXP_LNKSTA_CLS(speed));
+    
+    pcie_cap_fill_lnk(exp_cap, width, speed);
+}
+
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
 {
     PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
-- 
2.43.0

