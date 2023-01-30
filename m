Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83953C54EED
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 14:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjA3OhH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjA3OhH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 09:37:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC4E9
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 06:37:05 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P59f01JDDz6H6rC;
        Mon, 30 Jan 2023 22:33:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 14:37:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
Date:   Mon, 30 Jan 2023 14:36:55 +0000
Message-ID: <20230130143705.11758-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

V3: Thanks to Michael Tsirkin
 - Update tests/data/acpi/q35/DSDT.cxl to reflect dropping of the duplicate _UID.
   Usual dance with marking table to be ignored by test then making change and finally
   updating the table with the new version and dropping the entry preventing the tests
   from running.
 
V2:
- Various minor issues found by Philippe, see individual patches.
  Note that the const_le64() patch matches changes in a set of Philippe's that was
  never applied. Philippe may send an update of that series before this merges.
  If that occurs, drop "qemu/bswap: Add const_le64()"
- Picked up tags.

V1 Cover letter.

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

Jonathan Cameron (5):
  hw/mem/cxl_type3: Improve error handling in realize()
  hw/pci-bridge/cxl_downstream: Fix type naming mismatch
  tests/acpi: Allow update of q35/DSDT.cxl
  hw/i386/acpi: Drop duplicate _UID entry for CXL root bridge
  tests: acpi: Update q35/DSDT.cxl for removed duplicate UID

 hw/cxl/cxl-device-utils.c      |   2 +-
 hw/cxl/cxl-mailbox-utils.c     |  28 +++++++++++++++-------------
 hw/i386/acpi-build.c           |   1 -
 hw/mem/cxl_type3.c             |  15 +++++++++++----
 hw/pci-bridge/cxl_downstream.c |   2 +-
 include/hw/cxl/cxl_device.h    |   2 +-
 include/qemu/bswap.h           |  12 +++++++++++-
 include/qemu/uuid.h            |  12 ++++++++++++
 tests/data/acpi/q35/DSDT.cxl   | Bin 9636 -> 9622 bytes
 9 files changed, 52 insertions(+), 22 deletions(-)

-- 
2.37.2

