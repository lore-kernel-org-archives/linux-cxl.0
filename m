Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB090C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 20 Jan 2023 14:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjATO3E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjATO3D (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 Jan 2023 09:29:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47A530D7
        for <linux-cxl@vger.kernel.org>; Fri, 20 Jan 2023 06:28:30 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nz1wf4KcTz6J69K;
        Fri, 20 Jan 2023 22:24:50 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 14:27:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <alison.schofield@intel.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH v2 6/7] hw/pci/aer: Make PCIE AER error injection facility available for other emulation to use.
Date:   Fri, 20 Jan 2023 14:24:49 +0000
Message-ID: <20230120142450.16089-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120142450.16089-1-Jonathan.Cameron@huawei.com>
References: <20230120142450.16089-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This infrastructure will be reused for CXL RAS error injection
in patches that follow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci/pci-internal.h     | 1 -
 include/hw/pci/pcie_aer.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci-internal.h b/hw/pci/pci-internal.h
index 2ea356bdf5..a7d6d8a732 100644
--- a/hw/pci/pci-internal.h
+++ b/hw/pci/pci-internal.h
@@ -20,6 +20,5 @@ void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent);
 
 int pcie_aer_parse_error_string(const char *error_name,
                                 uint32_t *status, bool *correctable);
-int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
 
 #endif
diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
index 65e71d98fe..1234fdc4e2 100644
--- a/include/hw/pci/pcie_aer.h
+++ b/include/hw/pci/pcie_aer.h
@@ -100,4 +100,5 @@ void pcie_aer_root_write_config(PCIDevice *dev,
                                 uint32_t addr, uint32_t val, int len,
                                 uint32_t root_cmd_prev);
 
+int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
 #endif /* QEMU_PCIE_AER_H */
-- 
2.37.2

