Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0425C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 22:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJJWaW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJWaV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 18:30:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F85A810
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441019; x=1696977019;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N4oN/BU47B6lOfEmpE4C3qKrhsgMUOFba1gHfTLJYqw=;
  b=B+8umtmIJllTSXMHzLBBCJbBudLAEkUvkE+yePJf5lvDpUzWltIh1SpN
   P2RlNNGRfE/ZkMYRhk9nE30wGjuJ4jM3tNnVV7aJ3iuW2/mHvLCrxAOAY
   qOZusH8H6ueV983TZ1l0ez5NBfnirXLEXtzg3u5LuAFDAkViLVrKNJf3v
   L74tym5AvIUpw+WkjRCC0rKu+t+VEywqf6XJ+vSz/+SxybKnbXjczh4VQ
   J3K3vbAr1gZ7wRHjs1SVlFxinOoBqY3rs92BE3jzJd4Ng23JGfI9hcrSo
   C3N14JUe0XO/MPwu2pUIOXrPYo/YRK4bXcA3IksnmjqelFyrBjBEAVEER
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291661236"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291661236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628456956"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628456956"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.104.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:18 -0700
From:   ira.weiny@intel.com
To:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Subject: [RFC PATCH 0/6] QEMU CXL Provide mock CXL events and irq support
Date:   Mon, 10 Oct 2022 15:29:38 -0700
Message-Id: <20221010222944.3923556-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL Event records inform the OS of various CXL device events.  Thus far CXL
memory devices are emulated and therefore don't naturally have events which
will occur.

Add mock events and a HMP trigger mechanism to facilitate guest OS testing of
event support.

This support requires a follow on version of the event patch set.  The RFC was
submitted and discussed here:

	https://lore.kernel.org/linux-cxl/20220813053243.757363-1-ira.weiny@intel.com/

I'll post the lore link to the new version shortly.

Instructions for running this test.

Add qmp option to qemu:

	<host> $ qemu-system-x86_64 ... -qmp unix:/tmp/run_qemu_qmp_0,server,nowait ...

	OR

	<host> $ run_qemu.sh ... --qmp ...

Enable tracing of events within the guest:

	<guest> $ echo "" > /sys/kernel/tracing/trace
	<guest> $ echo 1 > /sys/kernel/tracing/events/cxl/enable
	<guest> $ echo 1 > /sys/kernel/tracing/tracing_on

Trigger event generation and interrupts in the host:

	<host> $ echo "cxl_event_inject cxl-devX" | qmp-shell -H /tmp/run_qemu_qmp_0

	Where X == one of the memory devices; cxl-dev0 should work.

View events on the guest:

	<guest> $ cat /sys/kernel/tracing/trace


Ira Weiny (6):
  qemu/bswap: Add const_le64()
  qemu/uuid: Add UUID static initializer
  hw/cxl/cxl-events: Add CXL mock events
  hw/cxl/mailbox: Wire up get/clear event mailbox commands
  hw/cxl/cxl-events: Add event interrupt support
  hw/cxl/mailbox: Wire up Get/Set Event Interrupt policy

 hmp-commands.hx             |  14 ++
 hw/cxl/cxl-device-utils.c   |   1 +
 hw/cxl/cxl-events.c         | 330 ++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-host-stubs.c     |   5 +
 hw/cxl/cxl-mailbox-utils.c  | 224 +++++++++++++++++++++---
 hw/cxl/meson.build          |   1 +
 hw/mem/cxl_type3.c          |   7 +-
 include/hw/cxl/cxl_device.h |  22 +++
 include/hw/cxl/cxl_events.h | 194 +++++++++++++++++++++
 include/qemu/bswap.h        |  10 ++
 include/qemu/uuid.h         |  12 ++
 include/sysemu/sysemu.h     |   3 +
 12 files changed, 802 insertions(+), 21 deletions(-)
 create mode 100644 hw/cxl/cxl-events.c
 create mode 100644 include/hw/cxl/cxl_events.h


base-commit: 6f7f81898e4437ea544ee4ca24bef7ec543b1f06
-- 
2.37.2

