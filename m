Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2011FC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbiAXRgd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:36:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4484 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiAXRgd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:36:33 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjHBX5Rcgz67vYh;
        Tue, 25 Jan 2022 01:33:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:36:31 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:36:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v4 38/42] RFC: softmmu/memory: Add ops to memory_region_ram_init_from_file
Date:   Mon, 24 Jan 2022 17:17:01 +0000
Message-ID: <20220124171705.10432-39-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Jonathan Cameron <jonathan.cameron@huawei.com>

Inorder to implement memory interleaving we need a means to proxy
the calls. Adding mem_ops allows such proxying.

Note should have no impact on use cases not using _dispatch_read/write.
For now, only file backed hostmem is considered to seek feedback on
the approach before considering other hostmem backends.

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 softmmu/memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 678dc62f06..d537091c63 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1606,6 +1606,15 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
     Error *err = NULL;
     memory_region_init(mr, owner, name, size);
     mr->ram = true;
+
+    /*
+     * ops used only when directly accessing via
+     * - memory_region_dispatch_read()
+     * - memory_region_dispatch_write()
+     */
+    mr->ops = &ram_device_mem_ops;
+    mr->opaque = mr;
+
     mr->readonly = readonly;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-- 
2.32.0

