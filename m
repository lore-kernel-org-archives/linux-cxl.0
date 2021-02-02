Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC57AC433E9
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA52064EDC
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhBBBBK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:21915 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBBK (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:10 -0500
IronPort-SDR: KIjkqKMvkAMBaK1eM/vKBzRw8wXYFhkQjKnEQ28Y5IoGfjYkZqWToJDCFpPSJ1P5/Qz68IzEau
 v3c11dzYgwHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294610"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294610"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:03 -0800
IronPort-SDR: 1tYPthxBJp+5IJLJM/J4PqEwVO8Fh0L1C3aEi0byhdJNvuYDCglGaPMNkSJGeCWqz2G802pfdk
 P8Q9YsIr0zqw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764121"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:02 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 10/31] hw/pxb: Use a type for realizing expanders
Date:   Mon,  1 Feb 2021 16:59:27 -0800
Message-Id: <20210202005948.241655-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This opens up the possibility for more types of expanders (other than
PCI and PCIe). We'll need this to create a CXL expander.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index aedded1064..232b7ce305 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -24,6 +24,8 @@
 #include "hw/boards.h"
 #include "qom/object.h"
 
+enum BusType { PCI, PCIE };
+
 #define TYPE_PXB_BUS "pxb-bus"
 typedef struct PXBBus PXBBus;
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
@@ -214,7 +216,8 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
            0;
 }
 
-static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
+static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
+                                   Error **errp)
 {
     PXBDev *pxb = convert_to_pxb(dev);
     DeviceState *ds, *bds = NULL;
@@ -239,7 +242,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
     }
 
     ds = qdev_new(TYPE_PXB_HOST);
-    if (pcie) {
+    if (type == PCIE) {
         bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
     } else {
         bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
@@ -287,7 +290,7 @@ static void pxb_dev_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pxb_dev_realize_common(dev, false, errp);
+    pxb_dev_realize_common(dev, PCI, errp);
 }
 
 static void pxb_dev_exitfn(PCIDevice *pci_dev)
@@ -339,7 +342,7 @@ static void pxb_pcie_dev_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pxb_dev_realize_common(dev, true, errp);
+    pxb_dev_realize_common(dev, PCIE, errp);
 }
 
 static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)
-- 
2.30.0

