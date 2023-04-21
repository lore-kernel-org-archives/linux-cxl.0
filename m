Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C189C77B76
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 14:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDUN7i (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 09:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjDUN7I (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 09:59:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE4E46
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 06:59:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2wzb3BMKz6J6Ch;
        Fri, 21 Apr 2023 21:56:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 14:59:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
CC:     Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handling
Date:   Fri, 21 Apr 2023 14:59:03 +0100
Message-ID: <20230421135906.3515-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v2:
- Split dropping the transaction guards out as precursor (Phillipe)
- Picked up tags

Issue reported in discussion of:
https://lore.kernel.org/all/20230228224014.1402545-1-fan.ni@samsung.com/

The committed bit for HDM decoders is expected reset when commit transitions
from 1->0.  Whilst looking at that it was noticed that hardware was resetting
the commit bit which is not an option allowed by the CXL spec.

In common with many other areas the code did not take into account
big endian architectures, so fix that whilst we are here.

Note testing this exposed a kernel bug around repeated attempts to clear
a decoder out of order. That's been reported but not yet fixed.

Jonathan Cameron (3):
  hw/cxl: drop pointless memory_region_transaction_guards
  hw/cxl: Fix endian handling for decoder commit.
  hw/cxl: Fix incorrect reset of commit and associated clearing of
    committed.

 hw/cxl/cxl-component-utils.c | 14 ++++++++------
 hw/mem/cxl_type3.c           | 28 +++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.37.2

