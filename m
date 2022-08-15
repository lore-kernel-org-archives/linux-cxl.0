Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B00C00140
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 15:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiHOPku (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiHOPks (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 11:40:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2CE21B8
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 08:40:47 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M5z1j0Kn9z67ZkT;
        Mon, 15 Aug 2022 23:37:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 17:40:44 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 16:40:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: [PATCH 0/2] cxl: Fix oversized LSA write payload due to header
Date:   Mon, 15 Aug 2022 16:40:42 +0100
Message-ID: <20220815154044.24733-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix the bug by claiming the payload is smaller by 8 bytes for both
reads and writes. Also add a defensive check to aid catching similar
bugs in future.

Note that two issues also found in QEMU code whilst looking at this
bug. I'll send out fixes for those shortly.

Note that even with these
ndctl create-namespace fails.  More debugging underway.

Jonathan Cameron (2):
  cxl/mbox: Add a check on input payload size
  cxl/pmem: Fix failure to account for 8 byte header for writes to the
    device LSA.

 drivers/cxl/core/mbox.c | 2 +-
 drivers/cxl/pmem.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.32.0

