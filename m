Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44BC6379F
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 15:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjBUPX0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjBUPXJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 10:23:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E806190
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 07:23:09 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PLjbf3H5lz6865q;
        Tue, 21 Feb 2023 23:18:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Feb 2023 15:23:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v5 3/8] hw/pci-bridge/cxl_root_port: Wire up AER
Date:   Tue, 21 Feb 2023 15:21:40 +0000
Message-ID: <20230221152145.9736-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

We are missing necessary config write handling for AER emulation in
the CXL root port. Add it based on pcie_root_port.c

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
 hw/pci-bridge/cxl_root_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 6664783974..00195257f7 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -187,12 +187,15 @@ static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
                                 int len)
 {
     uint16_t slt_ctl, slt_sta;
+    uint32_t root_cmd =
+        pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
 
     pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
     pci_bridge_write_config(d, address, val, len);
     pcie_cap_flr_write_config(d, address, val, len);
     pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
     pcie_aer_write_config(d, address, val, len);
+    pcie_aer_root_write_config(d, address, val, len, root_cmd);
 
     cxl_rp_dvsec_write_config(d, address, val, len);
 }
-- 
2.37.2

