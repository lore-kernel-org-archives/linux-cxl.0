Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61B2D032
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508331; cv=none; b=g3iujngy9fOXAHF2q+oQkMq1siBumDSaaDOuGwuriwl3IKjX+IaDgewv5Xz9vzYWj+cKRZXVr3QEpMk+DGl33/Qh8ajkajY6Jrm6u1a6k4P7OVfUh2XKkAllkcOsZ8DhogcaC2CKv2IIyEOV6DUJQKnVBGq7GmHjvwi6UC5loqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508331; c=relaxed/simple;
	bh=wtCu5Nw+JuwiMxxvpBpZ3ib3qR2UBzUnvURcWm1prcg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1KWiarF22Vn0TapM3Bgx88CsJ/gQpLV0QBS6Lzc2OW7CWkqwh2VSb5px8h5mkTAzenExnTAiTkIMfl83uirVctFW/Vu0+yDFm3PY1tQn6uXJXGsQG6mYklXsw8HAaBwlJwwMerWHZj5avvWNSw15o4T5VxAo+lkWv1gLXb2qYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sVM0t5Hz6K9FB;
	Tue, 17 Sep 2024 01:34:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D72C140F1C;
	Tue, 17 Sep 2024 01:38:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:38:44 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [PATCH 6/6] hw/pci-bridge/cxl-upstream: Add properties to control link speed and width
Date: Mon, 16 Sep 2024 18:35:18 +0100
Message-ID: <20240916173518.1843023-7-Jonathan.Cameron@huawei.com>
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
 include/hw/pci-bridge/cxl_upstream_port.h | 4 ++++
 hw/pci-bridge/cxl_upstream.c              | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index 12635139f6..f208397ffe 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -12,6 +12,10 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     CXLCCI swcci;
+
+    PCIExpLinkSpeed speed;
+    PCIExpLinkWidth width;
+
     DOECap doe_cdat;
     uint64_t sn;
 } CXLUpstreamPort;
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index a5a39cc524..55f8b0053f 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
@@ -100,6 +101,7 @@ static void cxl_usp_reset(DeviceState *qdev)
 
     pci_bridge_reset(qdev);
     pcie_cap_deverr_reset(d);
+    pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed);
     latch_registers(usp);
 }
 
@@ -363,6 +365,10 @@ static void cxl_usp_exitfn(PCIDevice *d)
 static Property cxl_upstream_props[] = {
     DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
     DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", CXLUpstreamPort,
+                                speed, PCIE_LINK_SPEED_32),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
+                                width, PCIE_LINK_WIDTH_16),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0

