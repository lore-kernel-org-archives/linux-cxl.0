Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD415A4B3
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787091; cv=none; b=Lsalk/vwLiywQwYT6WKsklvsXE/gQ91ATnZN7bvxgiS1QT9xkVZ6eMBLE4/yevYHqHz3401Cc3d78E0Pc+ALUeLUSlkXHtYFN2bF6H2AKFGATxTiyMAuP12cFGMCX1NsM6edN+A4+sdpgpltPdm4nMcmD9hmWVJdmN8j6lOkeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787091; c=relaxed/simple;
	bh=IgCFi554874G/H00XXDx0h2QitS9Vv9eO5ErFyeI37U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9D+zF6aFkySb0/XNSdpYHhewAyO147psSM2b0xlJcEfTaUEvEJURQ7Obif/NMSiL17SCdbO/p/pVVdyYSBPQgqP1ZG3kHe4Q0Ftn0m8WwYJd7Uemn5vu+yYg+w6QYLjtswii1xfb/7HRgEfnHflRvdBPFpCVHbaRDwMTCdB+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL9jY5kpTz6K652;
	Fri, 12 Jul 2024 20:23:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BE2321400D9;
	Fri, 12 Jul 2024 20:24:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 13:24:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [RFC qemu 1/6] hw/pci-bridge/cxl_root_port: Provide x-speed and x-width properties.
Date: Fri, 12 Jul 2024 13:24:09 +0100
Message-ID: <20240712122414.1448284-2-Jonathan.Cameron@huawei.com>
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

Approach copied from gen_pcie_root_port.c
Previously the link defaulted to a maximum of 2.5GT/s and 1x.  Enable setting
it's maximum values.  The actual value after 'training' will depend on the
downstream device configuration.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci-bridge/cxl_root_port.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 2dd10239bd..5e2156d7ba 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci/msi.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "hw/cxl/cxl.h"
@@ -206,6 +207,10 @@ static Property gen_rp_props[] = {
                      -1),
     DEFINE_PROP_SIZE("pref64-reserve", CXLRootPort, res_reserve.mem_pref_64,
                      -1),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_64),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_32),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0

