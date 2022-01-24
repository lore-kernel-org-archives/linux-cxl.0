Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6759C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiAXR2w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:28:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4468 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbiAXR2v (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:28:51 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH0h5K09z67MYM;
        Tue, 25 Jan 2022 01:24:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:28:50 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:28:49 +0000
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
Subject: [PATCH v4 23/42] tests/acpi: allow CEDT table addition
Date:   Mon, 24 Jan 2022 17:16:46 +0000
Message-ID: <20220124171705.10432-24-Jonathan.Cameron@huawei.com>
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

From: Ben Widawsky <ben.widawsky@intel.com>

Following patches will add a new ACPI table, the
CXL Early Discovery Table (CEDT).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/data/acpi/pc/CEDT                     | 0
 tests/data/acpi/q35/CEDT                    | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 3 files changed, 2 insertions(+)

diff --git a/tests/data/acpi/pc/CEDT b/tests/data/acpi/pc/CEDT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/CEDT b/tests/data/acpi/q35/CEDT
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9b07f1e1ff 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/CEDT",
+"tests/data/acpi/q35/CEDT",
-- 
2.32.0

