Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86F4C6FD1C
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 10:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCVK1s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Mar 2023 06:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCVK1q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Mar 2023 06:27:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEBB6130C
        for <linux-cxl@vger.kernel.org>; Wed, 22 Mar 2023 03:27:30 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PhPm25kCMz6J7rP;
        Wed, 22 Mar 2023 18:26:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 10:27:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: [RESEND PATCH 0/2] hw/cxl: Fix decoder commit and uncommit handling
Date:   Wed, 22 Mar 2023 10:27:29 +0000
Message-ID: <20230322102731.4219-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Resending because all but patch 1 seem to have failed to make it out of
our network.

Issue reported in discussion of:
https://lore.kernel.org/all/20230228224014.1402545-1-fan.ni@samsung.com/

The committed bit for HDM decoders is expected reset when commit transitions
from 1->0.  Whilst looking at that it was noticed that hardware was resetting
the commit bit which is not an option allowed by the CXL spec.

In common with many other areas the code did not take into account
big endian architectures, so fix that whilst we are here.

Note testing this exposed a kernel bug around repeated attempts to clear
a decoder out of order. That's been reported but not yet fixed.

Jonathan Cameron (2):
  hw/cxl: Fix endian handling for decoder commit.
  hw/cxl: Fix incorrect reset of commit and associated clearing of
    committed.

 hw/cxl/cxl-component-utils.c | 14 ++++++++------
 hw/mem/cxl_type3.c           | 28 +++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.37.2

