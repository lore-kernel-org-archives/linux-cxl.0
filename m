Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578B8C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Dec 2022 04:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiLVEZT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 23:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVEY4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 23:24:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40295C15
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 20:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671683095; x=1703219095;
  h=date:from:subject:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=0cTOW4aQbeJrB4PyXJK/ul38tT7E9EdZZ3sSJioccjo=;
  b=NAi0UtLw156zgLT60kHtjT9gvBfi7emj0Vw/HcBUL7fiWnZW4XW6LcqA
   lUhQ3T5f5DoGHapUN4Z8Nmq/8tgW2rNBy5L8HjAZJtLfbzPMOort6odoh
   DNpjBc+hgDw78Q2+euiqgV9Agcqhd0UAoKqWU9F3rrUyajAPX+1Xxt+oi
   pH9P5aRltnTPHSCVeCLyYu1sDLnOTzIvhTgNWPr7Q20D3r0kfdWR6REBl
   Xd+0Dtf4Zcjmbl3VAhDRfEnQBIkK/Raeggxi9vVIA9WWjv/NH3Kkhq39n
   br28SnxnO3dW+ZOUUAI7juhu1A4QVwbNWDzqXvgsT7BPEWJeEYooMOK2o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321957575"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321957575"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="601733184"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="601733184"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.20.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:54 -0800
Date:   Wed, 21 Dec 2022 20:24:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/8] QEMU CXL Provide mock CXL events and irq support
Message-Id: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP/bo2MC/yWNUQqDMAxAryL9XsRW3ei+do/hR+3SGejqaJ1Tp
 HdfdBAC70HyNpEwEiZxLTYRcaZEY2BQp0LYwYQnAj2YhaqUkjxA0YBdPOCMYUqwe5AS5AUcurZ2
 utfGKsH3vUkIfTTBDvwhfLxn+Y7oaDmC9455oDSNcT36s9ztP1VJ3ko3TVlrVbftGY50+UUK643
 ChL6040t0OecfP/HoncUAAAA=
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671683093; l=3489;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=0cTOW4aQbeJrB4PyXJK/ul38tT7E9EdZZ3sSJioccjo=;
 b=1iRz1qeQGo9GloWC0yIpbjh4y2y4jyPd9Ox7Gf1UGq1483JNGfW47IV4SQ+4UDjm1zZC6vDhfsoV
 hbiqM4ikBZYW18Ot680pZjecuOH0CngXJlJfFOAXthrzxrOW9mll
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL Event records inform the OS of various CXL device events.  Thus far CXL
memory devices are emulated and therefore don't naturally generate events.

Add an event infrastructure and mock event injection.  Previous versions
included a bulk insertion of lots of events.  However, this series focuses on
providing the ability to inject individual events through QMP.  Only the
General Media Event is included in this series as an example.  Other events can
be added pretty easily once the infrastructure is acceptable.

In addition, this version updates the code to be in line with the
specification based on discussions around the kernel patches.

This series is based on Jonathan's CXL branch here:
https://gitlab.com/jic23/qemu/-/tree/cxl-2022-11-17

Kernel code found here:
https://lore.kernel.org/all/20221212070627.1372402-1-ira.weiny@intel.com/

Previous RFC (V1) version:
https://lore.kernel.org/linux-cxl/20221010222944.3923556-1-ira.weiny@intel.com/

Instructions:

Add qmp option to qemu:

	<host> $ qemu-system-x86_64 ... -qmp unix:/tmp/run_qemu_qmp_0,server,nowait ...

	OR

	<host> $ run_qemu.sh ... --qmp ...

Enable tracing of events within the guest:

	<guest> $ echo "" > /sys/kernel/tracing/trace
	<guest> $ echo 1 > /sys/kernel/tracing/events/cxl/enable
	<guest> $ echo 1 > /sys/kernel/tracing/tracing_on

	OPTIONAL: set up ndctl to monitor for events (events will show up as
		  they are injected)

	<guest> $ <path to ndctl>/cxl monitor

Trigger event generation and interrupts in the host:

	<host> $ qmpcmd="${qemusrcdir}/build/scripts/qmp/qmp-shell /tmp/run_qemu_qmp_0"

	<host> $ echo "cxl-inject-gen-media-event path=cxl-dev0 log=0 flags=1 \
			physaddr=1000 descriptor=127 type=3 transactiontype=192 \
			channel=3 rank=-1 device=5 componentid='Iras mem'" | $qmpcmd

	<Repeat for more events with different values>

View events on the guest:

	<guest> $ cat /sys/kernel/tracing/trace

To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: qemu-devel@nongnu.org
Cc: linux-cxl@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Ira Weiny (8):
      qemu/bswap: Add const_le64()
      qemu/uuid: Add UUID static initializer
      hw/cxl/mailbox: Use new UUID network order define for cel_uuid
      hw/cxl/events: Add event status register
      hw/cxl/events: Wire up get/clear event mailbox commands
      hw/cxl/events: Add event interrupt support
      bswap: Add the ability to store to an unaligned 24 bit field
      hw/cxl/events: Add in inject general media event

 hw/cxl/cxl-device-utils.c   |  54 ++++++++--
 hw/cxl/cxl-events.c         | 252 ++++++++++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 160 ++++++++++++++++++++++------
 hw/cxl/meson.build          |   1 +
 hw/mem/cxl_type3.c          |  96 ++++++++++++++++-
 hw/mem/cxl_type3_stubs.c    |   8 ++
 include/hw/cxl/cxl_device.h |  56 +++++++++-
 include/hw/cxl/cxl_events.h | 126 ++++++++++++++++++++++
 include/qemu/bswap.h        |  40 +++++++
 include/qemu/uuid.h         |  12 +++
 qapi/cxl.json               |  25 +++++
 11 files changed, 785 insertions(+), 45 deletions(-)
---
base-commit: 1b4133103d20fc3fea05c7ceca4a242468a5179d
change-id: 20221221-ira-cxl-events-2022-11-17-fef53f9b9ac2

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>
