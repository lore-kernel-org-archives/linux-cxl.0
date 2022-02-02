Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D95C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 14:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiBBOcj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:32:39 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4660 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBBOcj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 09:32:39 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpklR6nFKz67sRl;
        Wed,  2 Feb 2022 22:32:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:32:36 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:32:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v5 43/43] scripts/device-crash-test: Add exception for pxb-cxl
Date:   Wed, 2 Feb 2022 14:10:37 +0000
Message-ID: <20220202141037.17352-44-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL expander bridge has several requirements but the one that
is checked first is that it is attached to a PCI Express bus,
not a PCI one so document that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v5:
 New patch - should probably be pushed down to introduction of pxb-cxl.
 Will do that in v6
 
 scripts/device-crash-test | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 7fbd99158b..52bd3d8f71 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -93,6 +93,7 @@ ERROR_RULE_LIST = [
     {'device':'pci-bridge', 'expected':True},              # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'pci-bridge-seat', 'expected':True},         # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'pxb', 'expected':True},                     # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
+    {'device':'pxb-cxl', 'expected':True},                 # pxb-cxl devices cannot reside on a PCI bus.
     {'device':'scsi-block', 'expected':True},              # drive property not set
     {'device':'scsi-generic', 'expected':True},            # drive property not set
     {'device':'scsi-hd', 'expected':True},                 # drive property not set
-- 
2.32.0

