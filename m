Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557AC77B73
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 15:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjEVPKN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjEVPJw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 11:09:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4614ABF
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 08:09:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QQ16k57Bnz686gL;
        Mon, 22 May 2023 23:08:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 16:09:47 +0100
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
Subject: [PATCH v7 0/7] QEMU CXL Provide mock CXL events and irq support
Date:   Mon, 22 May 2023 16:09:40 +0100
Message-ID: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v7: Thanks to Phillipe and Markus for reviews.
 QAPI docs were as Markus pointed out far too terse.
 So most of the changes in this series are making those more
 specific.
 Incorporated moving from Physical Address (as per the CXL specification)
 to the more meaningful DPA + clarifying comment that other things are
 found in the low bits. Hopefully that is a good trade off.

Based on:
[PATCH v7 0/4] hw/cxl: Poison get, inject, clear

Based on: Message-ID: 20230522145029.6370-1-Jonathan.Cameron@huawei.com

Updated cover letter from earlier versions:

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

{ "execute": "cxl-inject-general-media-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "dpa": 1000,
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
        "dpa": 1000,
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

 qapi/cxl.json               | 196 ++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  80 +++++++++-
 include/hw/cxl/cxl_events.h | 168 +++++++++++++++++++++
 hw/cxl/cxl-device-utils.c   |  43 +++++-
 hw/cxl/cxl-events.c         | 248 ++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 166 ++++++++++++++------
 hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  35 +++++
 hw/cxl/meson.build          |   1 +
 9 files changed, 1173 insertions(+), 56 deletions(-)
 create mode 100644 include/hw/cxl/cxl_events.h
 create mode 100644 hw/cxl/cxl-events.c

-- 
2.39.2

