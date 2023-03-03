Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FACBC64EC4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 15:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCCP33 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Mar 2023 10:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCCP32 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Mar 2023 10:29:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950621A4A7
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 07:29:06 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSsJW3qsnz67PMg;
        Fri,  3 Mar 2023 23:26:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 15:29:03 +0000
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
Subject: [PATCH v4 0/7] QEMU CXL Provide mock CXL events and irq support
Date:   Fri, 3 Mar 2023 15:28:56 +0000
Message-ID: <20230303152903.28103-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Whilst I'm an optimist, I suspect this is now 8.1 material because we have
5 CXL patch sets outstanding before it. Current bottleneck being QAPI review
for the RAS error series.

v4 changes: Thanks to Ira and to some feedback I received off list.
- More endian fixes for a future big endian architecture using it.
- Comment typo

One challenge here is striking the right balance between lots of constraints
in the injection code to enforce particular reserved bits etc by breaking
out all the flags as individual parameters vs having a reasonably concise
API.  I think this set strikes the right balance but others may well
disagree :)   Note that Ira raised the question of whether we should be
automatically establishing the volatile flag based on the Device Physical
Address of the injected error. My proposal is to not do so for now, but
to possibly revisit tightening the checking of injected errors in future.
Whilst the volatile flag is straight forwards, some of the other flags that
could be automatically set (or perhaps checked for validiaty) are much more
complex. Adding verification at this stage would greatly increase the
complexity of the patch + we are missing other elements that would interact
with this.  I'm not concerned about potential breaking of backwards compatibility
if it only related to the injection of errors that make no sense for a real
device.

Based on following series (in order)
1. [PATCH v4 00/10] hw/cxl: CXL emulation cleanups and minor fixes for upstream
(in staging currently so fingers crossed that one is fine)
2. [PATCH v6 0/8] hw/cxl: RAS error emulation and injection
3. [PATCH v2 0/2] hw/cxl: Passthrough HDM decoder emulation
4. [PATCH v4 0/2] hw/mem: CXL Type-3 Volatile Memory Support
5. [PATCH v4 0/6] hw/cxl: Poison get, inject, clear

Based on: Message-Id: 20230206172816.8201-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227112751.6101-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227153128.8164-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230227163157.6621-1-Jonathan.Cameron@huawei.com
Based-on: Message-id: 20230303150908.27889-1-Jonathan.Cameron@huawei.com

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
 hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++------
 hw/cxl/meson.build          |   1 +
 hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  35 +++++
 include/hw/cxl/cxl_device.h |  80 +++++++++-
 include/hw/cxl/cxl_events.h | 168 +++++++++++++++++++++
 qapi/cxl.json               | 120 +++++++++++++++
 9 files changed, 1097 insertions(+), 56 deletions(-)
 create mode 100644 hw/cxl/cxl-events.c
 create mode 100644 include/hw/cxl/cxl_events.h

-- 
2.37.2

