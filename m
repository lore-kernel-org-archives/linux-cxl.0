Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF74C7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 16:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjDUQI1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjDUQI1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 12:08:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9D46BE
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 09:08:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2zrr0xwfz6J6yf;
        Sat, 22 Apr 2023 00:05:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:08:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
CC:     Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v5 0/3] hw/mem: CXL Type-3 Volatile Memory Support
Date:   Fri, 21 Apr 2023 17:08:24 +0100
Message-ID: <20230421160827.2227-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v5: Thanks to Michael Tsirkin for review
 - Use memory_region_size() instead of incorrect open coding.
   Add a precursor patch tidying up existing uses.

Depends on some of the fix series posted (mostly fuzz).
[PATCH 0/2]  hw/cxl: CDAT file handling fixes.
[PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handlin
[PATCH 0/3] docs/cxl: Gathering of fixes for 8.0 CXL docs.

Based on: Message-ID: 20230421132020.7408-1-Jonathan.Cameron@huawei.com
Based on: Message-ID: 20230421135906.3515-1-Jonathan.Cameron@huawei.com
Based on: Message_ID: 20230421134507.26842-1-Jonathan.Cameron@huawei.com/

Now kernel support is in place, lets catch up with the emulation
of volatile memory on CXL type 3.

Original cover letter with minor updates.

This patches provides 2 features to the CXL Type-3 Device:
    1) Volatile Memory Region Support
    2) Multi-Region support (1 Volatile, 1 Persistent)

Summary of Changes per-commit:
1) Whitespace updates to docs and tests
2) Refactor CDAT DSMAS Initialization for multi-region initialization
   Multi-Region and Volatile Memory support for CXL Type-3 Devices
   Test and Documentation updates

The final patch in this series makes 6 major changes to the type-3
device in order to implement multi-region and volatile region support
    1) The HostMemoryBackend [hostmem] has been replaced by two
       [hostvmem] and [hostpmem] to store volatile and persistent memory
       respectively
    2) The single AddressSpace has been replaced by two AddressSpaces
       [hostvmem_as] and [hostpmem_as] to map respective memdevs.
    3) Each memory region size and total region are stored separately
    4) The CDAT and DVSEC memory map entries have been updated:
       a) if vmem is present, vmem is mapped at DPA(0)
       b) if pmem is present
          i)  and vmem is present, pmem is mapped at DPA(vmem->size)
          ii) else, pmem is mapped at DPA(0)
       c) partitioning of pmem is not supported in this patch set but
          has been discussed and this design should suffice.
    5) Read/Write functions have been updated to access AddressSpaces
       according to the mapping described in #4.  Access to the
       persistent address space is calculated by (dpa-vmem_len)
    6) cxl-mailbox has been updated to report the respective size of
       volatile and persistent memory region.

Gregory Price (2):
  tests/qtest/cxl-test: whitespace, line ending cleanup
  hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)

Jonathan Cameron (1):
  hw/mem: Use memory_region_size() in cxl_type3

 docs/about/deprecated.rst      |   8 +
 docs/system/devices/cxl.rst    |  49 ++++--
 hw/cxl/cxl-mailbox-utils.c     |  32 ++--
 hw/mem/cxl_type3.c             | 300 ++++++++++++++++++++++++---------
 include/hw/cxl/cxl_device.h    |  11 +-
 tests/qtest/bios-tables-test.c |   8 +-
 tests/qtest/cxl-test.c         | 146 +++++++++++-----
 7 files changed, 407 insertions(+), 147 deletions(-)

-- 
2.37.2

