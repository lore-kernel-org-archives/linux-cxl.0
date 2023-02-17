Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE04C636D6
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 17:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBQR4y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 12:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBQR4x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 12:56:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9054D48
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 09:56:51 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJKC45XR7z6J6Gj;
        Sat, 18 Feb 2023 01:52:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Feb 2023 17:56:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2 0/2] hw/mem: CXL Type-3 Volatile Memory Support
Date:   Fri, 17 Feb 2023 17:56:55 +0000
Message-ID: <20230217175657.26632-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
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

v2:
- Fix an off by one in address space matching when both volatile and
  persistent memory is in present (meant 1st byte of persistent memory
  not readale)
- Picked up tags (thanks to all who tested!)

Based on following series (in order)
1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
2. [PATCH v4 0/8] hw/cxl: RAS error emulation and injection
3. [PATCH 0/2] hw/cxl: Passthrough HDM decoder emulation

Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230217172924.25239-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230125152703.9928-1-Jonathan.Cameron@huawei.com

Kernel code is queued up in kernel.org cxl/pending.

Now we have some kernel code to test this against (and it looks good)
I'd like to propose this series for upstream following 3 other series
already proposed for inclusion:

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
       volatile and persistent memory region

Gregory Price (2):
  tests/qtest/cxl-test: whitespace, line ending cleanup
  hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)

 docs/system/devices/cxl.rst    |  49 ++++--
 hw/cxl/cxl-mailbox-utils.c     |  26 +--
 hw/mem/cxl_type3.c             | 300 +++++++++++++++++++++++++--------
 include/hw/cxl/cxl_device.h    |  11 +-
 tests/qtest/bios-tables-test.c |   8 +-
 tests/qtest/cxl-test.c         | 146 +++++++++++-----
 6 files changed, 398 insertions(+), 142 deletions(-)

-- 
2.37.2

