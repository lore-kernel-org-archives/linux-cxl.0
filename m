Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD39C25B08
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Aug 2022 14:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiHQO6E (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQO6E (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 17 Aug 2022 10:58:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237C9C2D7
        for <linux-cxl@vger.kernel.org>; Wed, 17 Aug 2022 07:58:03 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M7B2g26MZz67xgM;
        Wed, 17 Aug 2022 22:57:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 16:58:01 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 15:58:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/3] QEMU/CXL: A few more fixes for 7.1 related to LSA
Date:   Wed, 17 Aug 2022 15:57:56 +0100
Message-ID: <20220817145759.32603-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The recent addition of CXL Region setup to the 6.0-rc1 Linux kernel
has allowed us to test a few paths that weren't exercised fully until
now.  That threw up a mixture of bugs in QEMU emulation and the kernel
(kernel fixes already posted).

The first patch is down to a wrong assumption about RO MemoryRegions
and was hit due to a kernel bug overruning the mailbox and into
another register region.  Kernel bug fix:

https://lore.kernel.org/linux-cxl/20220815154044.24733-1-Jonathan.Cameron@huawei.com

The later 2 have shown up because the Get / Set LSA commands
have started getting proper user in the kernel.

With these fixes in place I've tested an 8 way interleave on a host
bridge to directly connected CXL devices and zeroed LSA regions.
On that we can bring up a CXL region on which we can create an
fsdax namespace and make a filesystem. For now, the cookie used
to identify device for re establishing that region/namespace will
be 0. A new feature patch will follow that will add the ability
to provide the necessary serial numbers for correct namespace
cookie creation allowing the namespace/filesystem to be remounted
after a full restart.

Jonathan Cameron (3):
  hw/cxl: Add stub write function for RO MemoryRegionOps entries.
  hw/cxl: Fix Get LSA input payload size which should be 8 bytes.
  hw/cxl: Correctly handle variable sized mailbox input payloads.

 hw/cxl/cxl-device-utils.c  | 12 +++++++++---
 hw/cxl/cxl-mailbox-utils.c |  4 ++--
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.32.0

