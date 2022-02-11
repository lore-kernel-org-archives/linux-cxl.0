Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B082C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Feb 2022 12:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350185AbiBKM2J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:28:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350218AbiBKM1w (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Feb 2022 07:27:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C11D1019
        for <linux-cxl@vger.kernel.org>; Fri, 11 Feb 2022 04:27:45 -0800 (PST)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JwCYf0Z72z682Z6;
        Fri, 11 Feb 2022 20:27:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 13:27:43 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 12:27:42 +0000
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
Subject: [PATCH v6 39/43] tests/acpi: Add tables for CXL emulation.
Date:   Fri, 11 Feb 2022 12:07:43 +0000
Message-ID: <20220211120747.3074-40-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
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

Tables that differ from normal Q35 tables when running the CXL test.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/data/acpi/q35/CEDT.cxl                | Bin 0 -> 184 bytes
 tests/data/acpi/q35/DSDT.cxl                | Bin 0 -> 9627 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/q35/CEDT.cxl b/tests/data/acpi/q35/CEDT.cxl
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b8fa06b00e65712e91e0a5ea0d9277e0146d1c00 100644
GIT binary patch
literal 184
zcmZ>EbqU$Qz`(%x(aGQ0BUr&HBEVSz2pEB4AU23*U{GMV2P7eE5T6mshKVRJ@Sw=U
r)I#JL88kqeKtKSd14gp~1^Iy(qF)E31_T6{AT-z>kXmGQAh!SjnYIc6

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..e1d1299a67abd02a055c58f9306bf4a796b7d4c0 100644
GIT binary patch
literal 9627
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
MB1c&Y2`UZtUm5%vhyVZp

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 7c7f9fbc44..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.cxl",
-"tests/data/acpi/q35/CEDT.cxl",
-- 
2.32.0

