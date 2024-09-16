Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7E18B1A
	for <linux-cxl@vger.kernel.org>; Mon, 16 Sep 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508163; cv=none; b=Z/AS9057NdkfOA2KM7w9iTNkESjcAdSi5dYOm7krox5sL5fg11F/S/+wjJukfsugJm2UrC0wFLYzA2svfAsB8IMqjdJHHZHQ/tKoGk58ZUMwUZMLHHZg6B+J5nDy2Ww+0eknJDivzclETorO5LORm7HGB9c9Hp+6yc3DoyEKtHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508163; c=relaxed/simple;
	bh=IgCFi554874G/H00XXDx0h2QitS9Vv9eO5ErFyeI37U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jyzq7VHk2GmWY+AWW+NGv/4umDLtb/utanfBhQlMR5kvH9XeyaMgTOrxTw2tq6P7xa/V97WzbnpMlDplffRmbvN6G7EgYUWPhMxdf/dJHn0ZMUCTvSK5fBxvZCWPy454Nd2vxPcYBfpAmBdTxUkvmsAhnbb5ihoLUMzitu1OLi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6sWr2mfpz6K6gc;
	Tue, 17 Sep 2024 01:35:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BE831401F3;
	Tue, 17 Sep 2024 01:35:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 19:35:54 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
	<fan.ni@samsung.com>
Subject: [PATCH 1/6] hw/pci-bridge/cxl_root_port: Provide x-speed and x-width properties.
Date: Mon, 16 Sep 2024 18:35:13 +0100
Message-ID: <20240916173518.1843023-2-Jonathan.Cameron@huawei.com>
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

