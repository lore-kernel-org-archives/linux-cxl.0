Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9557C05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 10:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBAKDv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBAKDu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 05:03:50 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15174A211
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 02:03:48 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P6HXg365qz6J9pN;
        Wed,  1 Feb 2023 18:02:43 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 10:03:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [RFC PATCH v2 0/3] hw/cxl: Poison get, inject, clear
Date:   Wed, 1 Feb 2023 10:03:47 +0000
Message-ID: <20230201100350.23263-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

RFC mostly because we already have 4 CXL QEMU series waiting for review
ahead of this and I don't want to distract too much from those.

I posted an RFC of part of this series a long time back [1]. It's been more
or less entirely rewriten since then and gained support for mailbox based
injection and clearing (including writing the cacheline). Note that I still
don't check for poison on direct reads of memory. That may be added in future
but isn't really that useful for testing the kernel code - it will end up
being the same as injecting a Machine Check or equivalent for the Host
Physical Address in question.

The series supports:
1) Injection of variable length poison regions via QMP (to fake real
   memory corruption and ensure we deal with odd overflow corner cases
   such as clearing the middle of a large region making the list overflow
   as we go from one long entry to two smaller entries.
2) Read of poison list via the CXL mailbox.
3) Injection via the poison injection mailbox command (limited to 64 byte
   entries)
4) Clearing of poison injected via either method.

The implementation is meant to be a valid combination of imdef choices
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

Tested against Alison's latest kernel patches.
https://lore.kernel.org/linux-cxl/cover.1674070170.git.alison.schofield@intel.com/
https://lore.kernel.org/linux-cxl/cover.1674101475.git.alison.schofield@intel.com/
and set timestamp patch
https://lore.kernel.org/linux-cxl/20230130151327.32415-1-Jonathan.Cameron@huawei.com/

[1] https://lore.kernel.org/linux-cxl/20220620162056.16790-1-Jonathan.Cameron@huawei.com/

Jonathan Cameron (3):
  hw/cxl: QMP based poison injection support
  hw/cxl: Add poison injection via the mailbox.
  hw/cxl: Add clear poison mailbox command support.

 hw/cxl/cxl-mailbox-utils.c  | 199 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  92 +++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |   3 +
 hw/mem/meson.build          |   2 +
 include/hw/cxl/cxl_device.h |  21 ++++
 qapi/cxl.json               |  11 ++
 6 files changed, 328 insertions(+)

-- 
2.37.2

