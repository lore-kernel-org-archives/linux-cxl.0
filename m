Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88FAC6FD18
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDWQUP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWQUP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 12:20:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534DE74
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 09:20:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4Cz753jZz67NsF;
        Mon, 24 Apr 2023 00:15:15 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 17:20:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 0/6] hw/cxl: Poison get, inject, clear
Date:   Sun, 23 Apr 2023 17:20:07 +0100
Message-ID: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v5: More details in each patch.
 - Simpler algorithm to find entry when clearing.
 - Improvements to debugability and docs for 24 bit endian functions.
 - Use of ROUND_DOWN() to simplify the various alignment questions.
 - Use CXL_CACHELINE_SIZE define to explain the mysterious 64 byte
   granularity
 - Use memory_region_size() instead of direct accesses.

Many of the precursors listed for v4 have now been applied, but
a few minor fixes have come up in the meantime so there are still
a few precursors including the volatile support left from v4
precursors.

Depends on 
[PATCH 0/2] hw/cxl: CDAT file handling fixes.
[PATCH v2 0/3] hw/cxl: Fix decoder commit and uncommit handling
[PATCH 0/3] docs/cxl: Gathering of fixes for 8.0 CXL docs.
[PATCH v5 0/3] hw/mem: CXL Type-3 Volatile Memory Support
 
Based on: Message-ID: 20230421132020.7408-1-Jonathan.Cameron@huawei.com
Based on: Message-ID: 20230421135906.3515-1-Jonathan.Cameron@huawei.com
Based on: Message-ID: 20230421134507.26842-1-Jonathan.Cameron@huawei.com
Based on: Message-ID: 20230421160827.2227-1-Jonathan.Cameron@huawei.com

The kernel support for Poison handling is currently in the cxl/pending
branch and hopefully should be in the CXL pull request next week.

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=pending

This code has been very useful for testing and helped identify various
corner cases.

Updated cover letter.

The series supports:
1) Injection of variable length poison regions via QMP (to fake real
   memory corruption and ensure we deal with odd overflow corner cases
   such as clearing the middle of a large region making the list overflow
   as we go from one long entry to two smaller entries.
2) Read of poison list via the CXL mailbox.
3) Injection via the poison injection mailbox command (limited to 64 byte
   entries - spec constraint)
4) Clearing of poison injected via either method.

The implementation is meant to be a valid combination of impdef choices
based on what the spec allowed. There are a number of places where it could
be made more sophisticated that we might consider in future:
* Fusing adjacent poison entries if the types match.
* Separate injection list and main poison list, to test out limits on
  injected poison list being smaller than the main list.
* Poison list overflow event (needs event log support in general)
* Connecting up to the poison list error record generation (rather complex
  and not needed for currently kernel handling testing).
* Triggering the synchronous and asynchronous errors that occur on reads
  and writes of the memory when the host receives poison.

As the kernel code is currently fairly simple, it is likely that the above
does not yet matter but who knows what will turn up in future!


Ira Weiny (2):
  hw/cxl: Introduce cxl_device_get_timestamp() utility function
  bswap: Add the ability to store to an unaligned 24 bit field

Jonathan Cameron (4):
  hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
  hw/cxl: QMP based poison injection support
  hw/cxl: Add poison injection via the mailbox.
  hw/cxl: Add clear poison mailbox command support.

 docs/devel/loads-stores.rst |   1 +
 hw/cxl/cxl-device-utils.c   |  15 ++
 hw/cxl/cxl-mailbox-utils.c  | 289 ++++++++++++++++++++++++++++++------
 hw/mem/cxl_type3.c          |  93 ++++++++++++
 hw/mem/cxl_type3_stubs.c    |   6 +
 include/hw/cxl/cxl.h        |   1 +
 include/hw/cxl/cxl_device.h |  23 +++
 include/qemu/bswap.h        |  25 ++++
 qapi/cxl.json               |  18 +++
 9 files changed, 429 insertions(+), 42 deletions(-)

-- 
2.37.2

