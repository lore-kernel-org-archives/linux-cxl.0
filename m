Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4069C433F5
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 18:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiCFSFz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 13:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCFSFz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 13:05:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3708555754
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 10:05:02 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTws1y4yz67Jb4;
        Mon,  7 Mar 2022 02:03:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 19:05:00 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:04:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v7 46/46] cxl/cxl-host: Support interleave decoding with one level of switches.
Date:   Sun, 6 Mar 2022 17:41:37 +0000
Message-ID: <20220306174137.5707-47-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Extend the walk of the CXL bus during interleave decoding to take
into account one layer of switches.

Whilst theoretically CXL 2.0 allows multiple switch levels, in the
vast majority of usecases only one level is expected and currently
that is all the proposed Linux support provides.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a1eafa89bb..ac20d9e2f5 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -130,8 +130,9 @@ static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
 
 static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 {
-    CXLComponentState *hb_cstate;
+    CXLComponentState *hb_cstate, *usp_cstate;
     PCIHostState *hb;
+    CXLUpstreamPort *usp;
     int rb_index;
     uint32_t *cache_mem;
     uint8_t target;
@@ -166,7 +167,46 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
 
     d = pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
 
-    if (!d || !object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3_DEV)) {
+    if (!d) {
+        return NULL;
+    }
+
+    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3_DEV)) {
+        return d;
+    }
+
+    /*
+     * Could also be a switch.  Note only one level of switching currently
+     * supported.
+     */
+    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_USP)) {
+        return NULL;
+    }
+    usp = CXL_USP(d);
+
+    usp_cstate = cxl_usp_to_cstate(usp);
+    if (!usp_cstate) {
+        return NULL;
+    }
+
+    cache_mem = usp_cstate->crb.cache_mem_registers;
+
+    target_found = cxl_hdm_find_target(cache_mem, addr, &target);
+    if (!target_found) {
+        return NULL;
+    }
+
+    d = pcie_find_port_by_pn(&PCI_BRIDGE(d)->sec_bus, target);
+    if (!d) {
+        return NULL;
+    }
+
+    d = pci_bridge_get_sec_bus(PCI_BRIDGE(d))->devices[0];
+    if (!d) {
+        return NULL;
+    }
+
+    if (!object_dynamic_cast(OBJECT(d), TYPE_CXL_TYPE3_DEV)) {
         return NULL;
     }
 
-- 
2.32.0

