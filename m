Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E0AC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbiAXRZR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:25:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4461 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiAXRZQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:25:16 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjGwY50Dkz67bhp;
        Tue, 25 Jan 2022 01:21:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:25:14 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:25:14 +0000
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
Subject: [PATCH v4 16/42] tests/acpi: Add update DSDT.viot
Date:   Mon, 24 Jan 2022 17:16:39 +0000
Message-ID: <20220124171705.10432-17-Jonathan.Cameron@huawei.com>
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

The consolidation of DSDT AML generation for PCI host bridges
lead to some minor ordering changes and the addition of _ADR
with a default of 0 for those case that didn't already have it.
Only DSDT.viot test is affected.

Changes all similar to:

Scope (\_SB)
     {
       Device (PC30)
       {
-        Name (_UID, 0x30)  // _UID: Unique ID
         Name (_BBN, 0x30)  // _BBN: BIOS Bus Number
         Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
         Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
+        Name (_ADR, Zero)  // _ADR: Address
+        Name (_UID, 0x30)  // _UID: Unique ID
         Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 tests/data/acpi/q35/DSDT.viot               | Bin 9398 -> 9416 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/q35/DSDT.viot
index 1c3b4da5cbe81ecab5e1ef50d383b561c5e0f55f..207ac5b9ae4c3a4bc0094c2242d1a1b08771b784 100644
GIT binary patch
delta 139
zcmdnydBT&+CD<k8gbD)#<CBeCu5zLdVlnZ-PVv!A?xF$C#s(bmPELMY6KfQhxC}No
z$Z0Y1qbM*kn0!E9nwKNq(Itq1BR<sAg-ZdbOrCM_F9mK?rG^HRr4><?3V@Yv4pmBI
F0sxp4B{u*7

delta 143
zcmX@%xy_TyCD<ion+gL1<MNGMu5zMYqA~HoPVv!Aj-mn1#s(bmp`I>WlVjy%CeC%7
z+^Kj^(SX5#0jQdxl0g7Ptr1kM!sPw((lEse3<_8k8$uNeOjb|?Dc;<vXwM7)8)+to

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 08a8095432..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.viot",
-- 
2.32.0

