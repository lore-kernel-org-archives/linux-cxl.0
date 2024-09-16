Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003115B115
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508297; cv=none; b=jUuPdr9RBZl6L2nSMm1bfjQOS0A40nXriKcefs1nVm+U1xqMaNFI441hhujSx4aWztjYJs8ZHaCIMi0qkYyVOfHwanTgGc8QOtjL9/gvsWuHJtiA9Zs/SpvKMSQ2PIkIhVORBxrZUXeIrJgT7glFqK14tKHKyJlbVRsAHyTPh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508297; c=relaxed/simple;
	bh=Vc0cuG0R+Bv0xjdfjMRrqLAlDPU+c0oVtu5oK0C6LVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Seyb3Mh9NQl5pjEWYYZLfKihJjhOwh5ME8WuyPgmixcMCyTR8/7/Zl2yMsaTdcHLYEI1e//YL4VzSDgAcUk89MjBeXIPfcnb8cTL9ixLm0w22TlRrldcv6HHGJvsrpRqg8kRSIM+tUPRC64R1z37GtNU+Tjafs3dk2pHe+A/LHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sZS2km3z6K6gh;
	Tue, 17 Sep 2024 01:38:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B294140B33;
	Tue, 17 Sep 2024 01:38:13 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:38:10 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [PATCH 5/6] hw/mem/cxl-type3: Add properties to control link speed and width
Date: Mon, 16 Sep 2024 18:35:17 +0100
Message-ID: <20240916173518.1843023-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

To establish performance characteristics of a CXL device when used via a
particular CXL topology (root ports, switches, end points) it is necessary
to set the appropriate link speed and width in the PCI Express capability
structure.  Provide x-speed and x-link properties for this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 4 ++++
 hw/mem/cxl_type3.c          | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fdd0f4e62b..e14e56ae4b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -549,6 +549,10 @@ struct CXLType3Dev {
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
+    /* PCIe link characteristics */
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+
     /* DOE */
     DOECap doe_cdat;
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 235ac40aeb..44d491d8f6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -17,6 +17,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -1200,6 +1201,7 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
     cxl_device_register_init_t3(ct3d);
 
@@ -1229,6 +1231,10 @@ static Property ct3_props[] = {
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLType3Dev,
+                                speed, PCIE_LINK_SPEED_32),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLType3Dev,
+                                width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0

