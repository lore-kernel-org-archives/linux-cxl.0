Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8036EC64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 17:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjB0Red (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjB0Rec (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 12:34:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B0AD1C
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 09:34:18 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PQSD20nT9z67JRZ;
        Tue, 28 Feb 2023 01:29:22 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Feb 2023 17:34:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 0/7] QEMU CXL Provide mock CXL events and irq support
Date:   Mon, 27 Feb 2023 17:34:09 +0000
Message-ID: <20230227173416.7740-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Whilst I'm an optimist, I suspect this is now 8.1 material because we have
5 CXL patch sets outstanding before it. One of the earlier series has non trivial
PCI changes, so I'm hoping to route all these through Michael Tsirkin as for
previous releases.

v3: A lot of changes due to rebasing on other patch sets, new event types
and changes in response to v2 review.
A few big ones:
 - Use the ability to optional fields in qapi json to make the handling of
   flags more intuitive.
 - Add dram and memory module events.
 - Various patches from original series moved to other series and the
   CXLRetCode move ended up here.  This shuffling was to allow use of
   some features Ira introduced in patch sets that were ready to upstream
   earlier than this one.

One challenge here is striking the right balance between lots of constraints
in the injection code to enforce particular reserved bits etc by breaking
out all the flags as individual parameters vs having a reasonably concise
API.  I think this set strikes the right balance but others may well
disagree :)

Based on following series (in order)
1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
2. [PATCH v6 0/8] hw/cxl: RAS error emulation and injection
3. [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
4. [PATCH v4 0/2] hw/mem: CXL Type-3 Volatile Memory Support
5. [PATCH v2 0/6] hw/cxl: Poison get, inject, clear

Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227153128.8164-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227163157.6621-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227170311.20054-1-Jonathan.Cameron@huawei.com

v2 cover letter.

CXL Event records inform the OS of various CXL device events.  Thus far CXL
memory devices are emulated and therefore don't naturally generate events.

Add an event infrastructure and mock event injection.  Previous versions
included a bulk insertion of lots of events.  However, this series focuses on
providing the ability to inject individual events through QMP.  Only the
General Media Event is included in this series as an example.  Other events can
be added pretty easily once the infrastructure is acceptable.

In addition, this version updates the code to be in line with the
specification based on discussions around the kernel patches.

Injection examples;

{ "execute": "cxl-inject-gen-media-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "physaddr": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "device": 5,
        "component-id": "iras mem"
    }}


{ "execute": "cxl-inject-dram-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "physaddr": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "rank": 17,
        "nibble-mask": 37421234,
        "bank-group": 7,
        "bank": 11,
        "row": 2,
        "column": 77,
        "correction-mask": [33, 44, 55, 66]
    }}

{ "execute": "cxl-inject-memory-module-event",
  "arguments": {
    "path": "/machine/peripheral/cxl-mem0",
    "log": "informational",
    "flags": 1,
    "type": 3,
    "health-status": 3,
    "media-status": 7,
    "additional-status": 33,
    "life-used": 30,
    "temperature": -15,
    "dirty-shutdown-count": 4,
    "corrected-volatile-error-count": 3233,
    "corrected-persistent-error-count": 1300
  }}


Ira Weiny (4):
  hw/cxl/events: Add event status register
  hw/cxl/events: Wire up get/clear event mailbox commands
  hw/cxl/events: Add event interrupt support
  hw/cxl/events: Add injection of General Media Events

Jonathan Cameron (3):
  hw/cxl: Move CXLRetCode definition to cxl_device.h
  hw/cxl/events: Add injection of DRAM events
  hw/cxl/events: Add injection of Memory Module Events

 hw/cxl/cxl-device-utils.c   |  43 +++++-
 hw/cxl/cxl-events.c         | 248 +++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 166 +++++++++++++++------
 hw/cxl/meson.build          |   1 +
 hw/mem/cxl_type3.c          | 289 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  35 +++++
 include/hw/cxl/cxl_device.h |  80 +++++++++-
 include/hw/cxl/cxl_events.h | 168 +++++++++++++++++++++
 qapi/cxl.json               | 120 +++++++++++++++
 9 files changed, 1094 insertions(+), 56 deletions(-)
 create mode 100644 hw/cxl/cxl-events.c
 create mode 100644 include/hw/cxl/cxl_events.h

-- 
2.37.2

