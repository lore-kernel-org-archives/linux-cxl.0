Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CADC636D3
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Feb 2023 17:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBFRby (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Feb 2023 12:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBFRbx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Feb 2023 12:31:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4626196
        for <linux-cxl@vger.kernel.org>; Mon,  6 Feb 2023 09:31:47 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9YDz0Tykz6J9yR;
        Tue,  7 Feb 2023 01:30:27 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 6 Feb 2023 17:31:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 07/10] tests: acpi: Update q35/DSDT.cxl for removed duplicate UID
Date:   Mon, 6 Feb 2023 17:28:13 +0000
Message-ID: <20230206172816.8201-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dropping the ID effects this table in trivial fashion.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Tested-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/data/acpi/q35/DSDT.cxl                | Bin 9578 -> 9564 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index 3d18b9672d124a0cf11a79e92c396a1b883d0589..4586b9a18b24acd946cd32c7e3e3a70891a246d2 100644
GIT binary patch
delta 65
zcmaFmb;pa#CD<h-MwNkqQEMaDUKwr|m6-Tor}*e5Z{^9CWUMyF%dcjfyiYC^MM6#<
IB*D!F0I~xVRsaA1

delta 79
zcmccP^~#IOCD<h-OO=6vv2P>SUKwt0m6-Tor}*e5CzZ*UWUScYLp@!%?rjc`U&A<g
SyId%Wytq76o(Cw;!v+8Y7Z@l2

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 9ce0f596cc..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.cxl",
-- 
2.37.2

