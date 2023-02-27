Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DAFC64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjB0RDQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjB0RDP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 12:03:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D487416AED
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 09:03:12 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQRX86vL4z6J7mp;
        Tue, 28 Feb 2023 00:58:16 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 17:03:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v2 0/6] hw/cxl: Poison get, inject, clear
Date:   Mon, 27 Feb 2023 17:03:05 +0000
Message-ID: <20230227170311.20054-1-Jonathan.Cameron@huawei.com>
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

v2: Thanks to Ira for review and also to Philippe as some of the
    changes follow through from comments on precusor series.

- Fixed a bunch of endian issues. Note that QEMU CXL suppport only currently
  supports platforms that happen to be little endian so these are more
  theoretical than bugs that can be triggered.
- Improve handling over mailbox inject poison that overlaps with
  qmp injected (which can be bigger).
- Tighter checks on alignment.
- Add 'Since' entries to qapi docs.
- Drop the CXLRetCode move out of this series as it isn't needed for this.
  Will appear in next series I post instead (Ira's event series)
- Drag down the st24_le_p() patch from Ira's Event series so we can use
  it in this series.

Note Alison has stated the kernel series will be post 6.3 material
so this one isn't quite as urgent as the patches it is based on.
However I think this series in a good state (plus I have lots more queued
behind it) hence promoting it from RFC.

Changes since RFC v2: Thanks to Markus for review.
 - Improve documentation for QMP interface
 - Add better description of baseline series
 - Include precursor refactors around ret_code / CXLRetCode as this is now
   the first series in suggeste merge order to rely on those.
 - Include Ira's cxl_device_get_timestamp() function as it was better than
   the equivalent in the RFC.

Based on following series (in order)
1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
2. [PATCH v6 0/8] hw/cxl: RAS error emulation and injection
3. [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
4. [PATCH v4 0/2] hw/mem: CXL Type-3 Volatile Memory Support

Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227153128.8164-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227163157.6621-1-Jonathan.Cameron@huawei.com

The series supports:
1) Injection of variable length poison regions via QMP (to fake real
   memory corruption and ensure we deal with odd overflow corner cases
   such as clearing the middle of a large region making the list overflow
   as we go from one long entry to two smaller entries.
2) Read of poison list via the CXL mailbox.
3) Injection via the poison injection mailbox command (limited to 64 byte
   entries)
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

As the kernel code is currently fairly simple, it is likely that the above
does not yet matter but who knows what will turn up in future!

Kernel patches:
 [PATCH v7 0/6] CXL Poison List Retrieval & Tracing
 cover.1676685180.git.alison.schofield@intel.com
 [PATCH v2 0/6] cxl: CXL Inject & Clear Poison
 cover.1674101475.git.alison.schofield@intel.com


Ira Weiny (2):
  hw/cxl: Introduce cxl_device_get_timestamp() utility function
  bswap: Add the ability to store to an unaligned 24 bit field

Jonathan Cameron (4):
  hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
  hw/cxl: QMP based poison injection support
  hw/cxl: Add poison injection via the mailbox.
  hw/cxl: Add clear poison mailbox command support.

 hw/cxl/cxl-device-utils.c   |  15 ++
 hw/cxl/cxl-mailbox-utils.c  | 285 ++++++++++++++++++++++++++++++------
 hw/mem/cxl_type3.c          |  92 ++++++++++++
 hw/mem/cxl_type3_stubs.c    |   6 +
 include/hw/cxl/cxl_device.h |  23 +++
 include/qemu/bswap.h        |  23 +++
 qapi/cxl.json               |  18 +++
 7 files changed, 420 insertions(+), 42 deletions(-)

-- 
2.37.2

