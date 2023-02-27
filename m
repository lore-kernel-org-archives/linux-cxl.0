Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94077C64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 11:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjB0Lb2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 06:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjB0Lb1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 06:31:27 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C5A1E5F3
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 03:31:26 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQJGx3RNlz6J798;
        Mon, 27 Feb 2023 19:31:21 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 11:31:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v6 7/8] hw/pci/aer: Make PCIE AER error injection facility available for other emulation to use.
Date:   Mon, 27 Feb 2023 11:27:50 +0000
Message-ID: <20230227112751.6101-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230227112751.6101-1-Jonathan.Cameron@huawei.com>
References: <20230227112751.6101-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This infrastructure will be reused for CXL RAS error injection
in patches that follow.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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

