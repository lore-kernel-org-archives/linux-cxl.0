Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30DFC64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 11:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjB1Lj3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjB1Lj2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 06:39:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA3211C0
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 03:39:27 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQwJ625qzz6J7dJ;
        Tue, 28 Feb 2023 19:34:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Feb 2023 11:39:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU reviewer
Date:   Tue, 28 Feb 2023 11:39:26 +0000
Message-ID: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni has offered to help out with QEMU CXL emulation reviewing.
Add him as a designated reviewer.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
Thanks to Fan for stepping up after I requested help following Ben
stepping down as co-maintainer. Fan base been active in testing
and review recently so great to have Fan on board.

Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky

Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ea56c6ccc..838e1a91a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2633,6 +2633,7 @@ T: git https://gitlab.com/vsementsov/qemu.git block
 
 Compute Express Link
 M: Jonathan Cameron <jonathan.cameron@huawei.com>
+R: Fan Ni <fan.ni@samsung.com>
 S: Supported
 F: hw/cxl/
 F: hw/mem/cxl_type3.c
-- 
2.37.2

