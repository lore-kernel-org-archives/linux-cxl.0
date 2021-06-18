Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74646C2B9F4
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554E66120A
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhFRAyP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:54:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:2051 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232889AbhFRAyO (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 20:54:14 -0400
IronPort-SDR: EievXxyxplLA/0yyE0wOSI1osTvGXImXyZgPEqlUkpJOAQYx8tHivLE/6Hq5gZKeifTyEjyGjU
 JxJLoUXuom3A==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292105414"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292105414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:06 -0700
IronPort-SDR: pwDYEPPiVv8iTlr8X4FpbhqkhrZCBSLegCTdH/hzGds8eB0RHpf2v2qAVjEQlg2HBgn+j84pP8
 /cVwtJSkfcjA==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="622223110"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:05 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 0/5] Introduce memdev driver
Date:   Thu, 17 Jun 2021 17:51:55 -0700
Message-Id: <20210618005200.997804-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The concept of the memdev has existed since the initial support for CXL.io
landed in 5.12. Here, supported is furthered by adding a driver that is capable
of reporting whether or not the device is also CXL.mem capable. With this, the
region driver is able to consume these devices for programming interleave (or
x1) sets. Unlike the region driver, no explicit sysfs interaction is needed to
utilize this driver.

The logic encapsulated here checks two things:
1. The device itself is CXL.mem enabled.
2. The device's upstream is CXL.mem enabled [1].

What's currently missing is for the cxlmem driver to add the device as an
upstream port (since it has HDM decoders). I'm still working out those details.
HDM decoder programming still remains undone as well, and isn't pertinent to
this series perse.

The patches are based on top of my region patches [2].

The code itself is pretty rough for now, and so I'm mostly looking for feedback
as to whether or not the memdev driver is serving its purpose and checking what
needs to be checked on bind. If however you come along something glaringly bad,
or feel like reviewing not fully tested code (I know it builds), by all means...

[1]: This series doesn't actually add real support for switches which would also
need to make the determination of CXL.mem enabling.
[2]: https://lore.kernel.org/linux-cxl/20210617173655.430424-1-ben.widawsky@intel.com/


Ben Widawsky (5):
  cxl/region: Only allow CXL capable targets
  cxl/mem: Introduce CXL mem driver
  cxl/memdev: Determine CXL.mem capability
  cxl/pci: Export CXL DVSEC functionality
  cxl/mem: Check that the device is CXL.mem capable

 drivers/cxl/Makefile |   3 +-
 drivers/cxl/acpi.c   |   9 +++-
 drivers/cxl/core.c   |   7 +++
 drivers/cxl/cxl.h    |   2 +
 drivers/cxl/mem.c    | 102 +++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.h    |   3 ++
 drivers/cxl/pci.c    |   7 ++-
 drivers/cxl/pci.h    |   7 ++-
 drivers/cxl/region.c |  12 ++++-
 9 files changed, 147 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cxl/mem.c

-- 
2.32.0

