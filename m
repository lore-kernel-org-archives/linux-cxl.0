Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D61BC76195
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Mar 2023 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCVQ3z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCVQ3y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Mar 2023 12:29:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760965D8A1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Mar 2023 09:29:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PgznV67d4z6YpMq;
        Wed, 22 Mar 2023 01:56:46 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 18:00:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH 0/2] hw/cxl: Fix decoder commit and uncommit handling
Date:   Tue, 21 Mar 2023 18:00:10 +0000
Message-ID: <20230321180012.2545-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

