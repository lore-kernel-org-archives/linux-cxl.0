Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF2EB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 16:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjGQQ13 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGQQ13 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 12:27:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0212E
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 09:27:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4S962lDYz6J72X;
        Tue, 18 Jul 2023 00:24:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 17:27:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux@huawei.com>
Subject: [RFC PATCH v3 3/4] PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to pci_ids.h
Date:   Mon, 17 Jul 2023 17:25:56 +0100
Message-ID: <20230717162557.8625-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717162557.8625-1-Jonathan.Cameron@huawei.com>
References: <20230717162557.8625-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This ID is used for CXL Switch Mailbox CCIs.
Incorporate the Programming Interface in the definition in common
with similar entries.

See CXL rev3.0 81.1.3.1 PCI Header Class Code Register

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..b6fe5d33654f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -128,6 +128,7 @@
 #define PCI_CLASS_SERIAL_IPMI_SMIC	0x0c0700
 #define PCI_CLASS_SERIAL_IPMI_KCS	0x0c0701
 #define PCI_CLASS_SERIAL_IPMI_BT	0x0c0702
+#define PCI_CLASS_SERIAL_CXL_SWITCH_CCI	0x0c0b00
 
 #define PCI_BASE_CLASS_WIRELESS			0x0d
 #define PCI_CLASS_WIRELESS_RF_CONTROLLER	0x0d10
-- 
2.39.2

