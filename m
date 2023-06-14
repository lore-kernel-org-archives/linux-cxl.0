Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1FFEB64D8
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 19:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjFNTTi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFNTTh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 15:19:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351572135
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686770376; x=1718306376;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to;
  bh=hfyzo/aij+WjRH3zSJkrl2bGy16dWXEU3/TU3zImZws=;
  b=VHoWY8EreJ9bxS6pEfCBh2fsKck5oXhjjI2PEcpad31dda69YiQz7aYu
   zC1G8qGWzzZ5XSiXJ2CGXICBu0eWs0BjrRIkB6HnRS9U1z9bZ6LNz//hq
   oJ/p4Rt9Wd0Noi9yCSf7EGf2G+bLZYK+Ozo3gQ5jj3+3EQb5Lvv6mtA90
   bN4nuNDLbLy2TnE35cJPDeT6ABOflySPMHM7n1M1zesx8cf+k6ktuchhT
   dQoEn6xBEsgZY9cNRKYzkaGb1eXTfaF0Ju3+lFG2SFEXVDYTLf81yBiE4
   M6jt6LWa8vuib/iTu9u2WSEHJ5YbttMWVqXU1OGm9FMX0APxzIlRQvxrO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338347256"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338347256"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886384224"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="886384224"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:29 -0700
From:   ira.weiny@intel.com
Subject: [PATCH 0/5] cxl/dcd: Add support for Dynamic Capacity Devices
 (DCD)
Date:   Wed, 14 Jun 2023 12:16:27 -0700
Message-Id: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsSimQC/1WNMQ7CMAwAv1J5xlISIANfQQxp7FAPhMguFajq3
 0nZGE+6061grMIGl2EF5UVMnrWDPwyQp1TvjEKdIbhwdNGdkDLh/Gkc8NVsVk4PdJn8ucTgYyH
 o4ZiMcdRU87Sn//YuNOUi79/1etu2LyAk6w2FAAAA
To:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686770367; l=3214;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=hfyzo/aij+WjRH3zSJkrl2bGy16dWXEU3/TU3zImZws=;
 b=xh6cLJmLC/0mGibj7k+TsXFba22EEO1ZxHMVkt9YKgN0rAJAIvjqx4XgO9mhA8gzmSZENHp29
 EJaXDqGiMdKAX3fLxC2CaoROEv8p4O3wfWvElH20aPXHQa3wn/5fWIU
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

I'm submitting these on behalf of Navneet.  There was a round of
internal discussion which left a few questions but we want to get the
public discussion going.  A first public preview was posted by Dan.[1]

The series has been rebased on the type-2 work posted from Dan.[2]  As
discussed in the community call, not all of that series is required for
these patches.  This will get rebased on the subset of those patches he
is targeting for 6.5.  The series was tested using Fan Ni's Qemu DCD
series.[3]

[cover letter]

A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
device that implements dynamic capacity.  Dynamic capacity feature
allows memory capacity to change dynamically, without the need for
resetting the device.

Provide initial patches to enable DCD on non interleaving regions.
Details:

- Get the dynamic capacity region information from cxl device and add
  the advertised DC memory to driver managed resources
- Get the device dynamic capacity extent list from the device and
  maintain it in the host and add the preallocated memory to the host
- Dynamic capacity region support
- DCD region provisioning via Dax
- Dynamic capacity event records
        a. Add capacity Events
	b. Release capacity events
	c. Add the memory to the host dc region
	d. Release the memory from the host dc region
- Trace Dynamic Capacity events
- Send add capacity response to device
- Send release dynamic capacity to device

Cc: Navneet Singh <navneet.singh@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org

[1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch/
[2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
[3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/

---
Navneet Singh (5):
      cxl/mem : Read Dynamic capacity configuration from the device
      cxl/region: Add dynamic capacity cxl region support.
      cxl/mem : Expose dynamic capacity configuration to userspace
      cxl/mem: Add support to handle DCD add and release capacity events.
      cxl/mem: Trace Dynamic capacity Event Record

 drivers/cxl/Kconfig       |  11 +
 drivers/cxl/core/core.h   |   7 +
 drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++--
 drivers/cxl/core/mbox.c   | 540 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/memdev.c |  72 +++++++
 drivers/cxl/core/port.c   |  18 ++
 drivers/cxl/core/region.c | 337 ++++++++++++++++++++++++++++-
 drivers/cxl/core/trace.h  |  68 +++++-
 drivers/cxl/cxl.h         |  32 ++-
 drivers/cxl/cxlmem.h      | 146 ++++++++++++-
 drivers/cxl/pci.c         |  14 +-
 drivers/dax/bus.c         |  11 +-
 drivers/dax/bus.h         |   5 +-
 drivers/dax/cxl.c         |   4 +
 14 files changed, 1453 insertions(+), 46 deletions(-)
---
base-commit: 034a16d0165be3e092d60685be7b1b05e6f3059b
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

