Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492DAC433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 14:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiBBObh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:31:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4658 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiBBObh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 09:31:37 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpkkG2Ww3z67n09;
        Wed,  2 Feb 2022 22:31:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:31:35 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:31:34 +0000
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
Subject: [PATCH v5 41/43] qtest/acpi: Add reference CEDT tables.
Date:   Wed, 2 Feb 2022 14:10:35 +0000
Message-ID: <20220202141037.17352-42-Jonathan.Cameron@huawei.com>
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

From: Jonathan Cameron <jonathan.cameron@huawei.com>

More sophisticated tests will come later, but for now deal
with the NULL case.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/data/acpi/pc/CEDT                     | Bin 0 -> 36 bytes
 tests/data/acpi/q35/CEDT                    | Bin 0 -> 36 bytes
 tests/data/acpi/virt/CEDT                   | Bin 0 -> 36 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   3 ---
 4 files changed, 3 deletions(-)

diff --git a/tests/data/acpi/pc/CEDT b/tests/data/acpi/pc/CEDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b44db4ce1db980d783ad568a03c17c2915d111b0 100644
GIT binary patch
literal 36
jcmZ>EbqP^nU|?VjaPoKd2v%^42yj*a0!E-1hz+6veU1hJ

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/CEDT b/tests/data/acpi/q35/CEDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b44db4ce1db980d783ad568a03c17c2915d111b0 100644
GIT binary patch
literal 36
jcmZ>EbqP^nU|?VjaPoKd2v%^42yj*a0!E-1hz+6veU1hJ

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/CEDT b/tests/data/acpi/virt/CEDT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b44db4ce1db980d783ad568a03c17c2915d111b0 100644
GIT binary patch
literal 36
jcmZ>EbqP^nU|?VjaPoKd2v%^42yj*a0!E-1hz+6veU1hJ

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index c7726cad80..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,4 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/CEDT",
-"tests/data/acpi/q35/CEDT",
-"tests/data/acpi/virt/CEDT",
-- 
2.32.0

