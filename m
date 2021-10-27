Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66EDC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB83360231
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Oct 2021 22:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJ0WnV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Oct 2021 18:43:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:11673 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhJ0WnU (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 27 Oct 2021 18:43:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="229031853"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="229031853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:40:49 -0700
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; 
   d="scan'208";a="665173672"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 15:40:48 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 0/9] CDAT/DSMAS reading and cleanups
Date:   Wed, 27 Oct 2021 15:40:34 -0700
Message-Id: <20211027224043.3551125-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210617221620.1904031-4-ira.weiny@intel.com>
References: <20210617221620.1904031-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

This really should be 2 series and a single patch for the cxl_mem change.

But for internal review I'm just going to throw it out on email to see what
others think.

Here are the 3 cover letters.

<Documentation>
The auxiliary device documentation was not wrong but it was a bit difficult to
follow.  Add clarifications to ensure that details are not missed.
</Documentation>

<CDAT/DSMAS>
Read CDAT and DSMAS data from the device.

This work was built on Jonathan's V4 series here[1].  The big change is a
conversion to an Auxiliary bus infrastructure which allows the DOE code to be
in a separate driver object which is attached to any DOE devices which are
created by the CXL device.

Other devices can then create DOE devices and have the doe driver automatically
attach to this functionality.  Furthermore, user space control of DOE mailboxes
will be easier because of the separation from the parent device control.

[1] https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com
</CDAT/DSMAS>

<Single patch so no cover for the cxlmem change.>


Ira Weiny (5):
  Documentation/auxiliary_bus: Clarify auxiliary_device creation
  Documentation/auxiliary_bus: Clarify match_name
  Documentation/auxiliary_bus: Update Auxiliary device lifespan
  cxl/cdat: Parse out DSMASS data from CDAT table
  cxl/cxlmem: Change struct cxl_mem to a more descriptive name

Jonathan Cameron (4):
  PCI: Add vendor ID for the PCI SIG
  PCI/DOE: Add Data Object Exchange Aux Driver
  cxl/pci: Add DOE Auxiliary Devices
  cxl/mem: Add CDAT table reading from DOE

 Documentation/driver-api/auxiliary_bus.rst | 137 +++-
 drivers/cxl/Kconfig                        |   1 +
 drivers/cxl/cdat.h                         |  81 +++
 drivers/cxl/core/mbox.c                    | 160 ++---
 drivers/cxl/core/memdev.c                  | 205 +++++-
 drivers/cxl/cxl.h                          |  20 +
 drivers/cxl/cxlmem.h                       |  79 ++-
 drivers/cxl/pci.c                          | 355 ++++++++---
 drivers/cxl/pmem.c                         |  32 +-
 drivers/pci/Kconfig                        |  11 +
 drivers/pci/Makefile                       |   3 +
 drivers/pci/doe.c                          | 704 +++++++++++++++++++++
 include/linux/pci-doe.h                    |  63 ++
 include/linux/pci_ids.h                    |   1 +
 include/uapi/linux/pci_regs.h              |  29 +-
 tools/testing/cxl/test/mem.c               |  50 +-
 16 files changed, 1670 insertions(+), 261 deletions(-)
 create mode 100644 drivers/cxl/cdat.h
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h

-- 
2.28.0.rc0.12.gb6a658bd00c9

