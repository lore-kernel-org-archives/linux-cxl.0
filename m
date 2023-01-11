Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7007C678DB
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 14:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbjAKOZT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 09:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbjAKOYm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 09:24:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E619290
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 06:24:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NsVLW3T60z6J9Sb;
        Wed, 11 Jan 2023 22:24:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 11 Jan 2023 14:24:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
Subject: [PATCH 0/8] hw/cxl: CXL emulation cleanups and minor fixes for upstream
Date:   Wed, 11 Jan 2023 14:24:32 +0000
Message-ID: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A small collection of misc fixes and tidying up pulled out from various
series. I've pulled this to the top of my queue of CXL related work
as they stand fine on their own and it will reduce the noise in
the larger patch sets if these go upstream first.

Gregory's patches were posted as part of his work on adding volatile support.
https://lore.kernel.org/linux-cxl/20221006233702.18532-1-gregory.price@memverge.com/
https://lore.kernel.org/linux-cxl/20221128150157.97724-2-gregory.price@memverge.com/
I might propose this for upstream inclusion this cycle, but testing is
currently limited by lack of suitable kernel support.

Ira's patches were part of his event injection series.
https://lore.kernel.org/linux-cxl/20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com/
Intent is to propose for upstream the rest of that series shortly after
some minor changes from earlier review.

My three patches have not previously been posted.

For the curious, the current state of QEMU CXL emulation that we are working
through the backlog wrt to final cleanup before proposing for upstreaming can be found at.

https://gitlab.com/jic23/qemu/-/commits/cxl-2023-01-11

Gregory Price (2):
  hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
  hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition

Ira Weiny (3):
  qemu/bswap: Add const_le64()
  qemu/uuid: Add UUID static initializer
  hw/cxl/mailbox: Use new UUID network order define for cel_uuid

Jonathan Cameron (3):
  hw/mem/cxl_type3: Improve error handling in realize()
  hw/pci-bridge/cxl_downstream: Fix type naming mismatch
  hw/i386/acpi: Drop duplicate _UID entry for CXL root bridge

 hw/cxl/cxl-device-utils.c      |  2 +-
 hw/cxl/cxl-mailbox-utils.c     | 27 ++++++++++++++-------------
 hw/i386/acpi-build.c           |  1 -
 hw/mem/cxl_type3.c             | 15 +++++++++++----
 hw/pci-bridge/cxl_downstream.c |  2 +-
 include/hw/cxl/cxl_device.h    |  2 +-
 include/qemu/bswap.h           | 10 ++++++++++
 include/qemu/uuid.h            | 12 ++++++++++++
 8 files changed, 50 insertions(+), 21 deletions(-)

-- 
2.37.2

