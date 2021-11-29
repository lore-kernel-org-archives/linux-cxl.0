Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B162C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhK2Vz6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:55:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:46994 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232793AbhK2Vx6 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:53:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968499"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:24 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596079"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:24 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/9] CXL port prep work
Date:   Mon, 29 Nov 2021 13:47:12 -0800
Message-Id: <20211129214721.1668325-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

These are the first several patches from the CXL port patch series. They
primarily rework handling some of the handling in cxl_pci reworks and puts some
infrastructure in place for endpoints and ports.

The patches do not have overlap with other domains, such as PCI.

Ben Widawsky (9):
  cxl: Rename CXL_MEM to CXL_PCI
  cxl: Flesh out register names
  cxl/pci: Extract device status check
  cxl/pci: Implement Interface Ready Timeout
  cxl/pci: Don't poll doorbell for mailbox access
  cxl/pci: Add new DVSEC definitions
  cxl/acpi: Map component registers for Root Ports
  cxl: Introduce module_cxl_driver
  cxl/core: Convert decoder range to resource

 drivers/cxl/Kconfig     |  23 +++---
 drivers/cxl/Makefile    |   2 +-
 drivers/cxl/acpi.c      |  35 ++++-----
 drivers/cxl/core/bus.c  |  23 +++++-
 drivers/cxl/core/regs.c |  54 ++++++++++++++
 drivers/cxl/cxl.h       |  15 +++-
 drivers/cxl/pci.c       | 152 +++++++++++++++-------------------------
 drivers/cxl/pci.h       |  41 ++++++++---
 8 files changed, 211 insertions(+), 134 deletions(-)

-- 
2.34.1

