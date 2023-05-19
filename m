Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF7CC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 14:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjESOSJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESOSI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 10:18:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130CBF7
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 07:18:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QN86b5Rn6z67d2y;
        Fri, 19 May 2023 22:16:55 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 15:18:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v6 0/4] hw/cxl: Poison get, inject, clear
Date:   Fri, 19 May 2023 15:17:59 +0100
Message-ID: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
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

Note that Michael Tsirkin replied to v5 to say he has first
3 queued - the bswap one is buggy so should be dropped and
replaced with this v6.  Note changes in that patch were large
enough that I've dropped Fan Ni's tag.

Tested the problematic cross compiles using docker.

v6:
 - Fix 24 bit bswap on big endian platforms.
   I think this was broken in a bad rebase some time ago.
   Fix is to not use the general macros for this case as they
   rely on a builtin 24 bit byte swap which doesn't exist.
 - Wrong use of int128_to_64() on a variable that was uint64_t in
   the first place.

Many of the precursors listed for v4 have now been applied, but
a few minor fixes have come up in the meantime so there are still
a few precursors including the volatile support left from v4
precursors.

Michael has the above series + initial patches of v5 of this series
queued up.

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


Ira Weiny (1):
  bswap: Add the ability to store to an unaligned 24 bit field

Jonathan Cameron (3):
  hw/cxl: QMP based poison injection support
  hw/cxl: Add poison injection via the mailbox.
  hw/cxl: Add clear poison mailbox command support.

 docs/devel/loads-stores.rst |   1 +
 hw/cxl/cxl-mailbox-utils.c  | 214 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  93 ++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |   6 +
 include/hw/cxl/cxl.h        |   1 +
 include/hw/cxl/cxl_device.h |  21 ++++
 include/qemu/bswap.h        |  27 +++++
 qapi/cxl.json               |  18 +++
 8 files changed, 381 insertions(+)

-- 
2.39.2

