Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D507DC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiDDPgG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiDDPgF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:36:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06621EAE0
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:34:08 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXFBx2c6Tz685bn;
        Mon,  4 Apr 2022 23:32:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:34:07 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:34:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 38/45] tests/acpi: Add tables for CXL emulation.
Date:   Mon, 4 Apr 2022 16:14:38 +0100
Message-ID: <20220404151445.10955-39-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Tables that differ from normal Q35 tables when running the CXL test.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/data/acpi/q35/CEDT.cxl                | Bin 0 -> 184 bytes
 tests/data/acpi/q35/DSDT.cxl                | Bin 0 -> 9615 bytes
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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..c1206defed0154e9024702bba88453b2790a306d 100644
GIT binary patch
literal 9615
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
E0+(|YhyVZp

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

