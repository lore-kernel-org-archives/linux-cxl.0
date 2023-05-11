Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2958C77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbjEKSAA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbjEKR7t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 13:59:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57509AD1C
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683827970; x=1715363970;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=32rpB+PvU8ajLARqWVN7Vh+y/sV5+Fmlwj/aQ69M0QE=;
  b=c9Sawkmi0S/QkuUL28C0gWvrj0stB4DID1Cabppt2gaklDuoJRbH1Pdp
   PQ4ulpGIHwRxUFf84gFGKnSXjp9Cc1CdtnG1zr2q4UdDcYkoyGq4C2jU+
   Dd1I3ImA06cugiWrpwBNlE5n4vCHjunWDi9OwnvhWtDCLi3lIUSW1YljT
   4npd5qM/rdDxV0Wq0v7/tEwP9QIt7mYabMUysJaziOHbJjBvjq1gMH5h4
   daGfESewUC38CMPsfS0e2LcNfptXpeQCOIOjZyW+HPn6eCA8bkwVR0hxo
   1qZOmh5kQ5SySHkPn6d3kaRH18uudkqEWKg+P1EFghGQdYGudI5VA+TOZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="350610861"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="350610861"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="650315637"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="650315637"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.95.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 10:58:43 -0700
Subject: [PATCH v2 0/4] cxl: Prep for QoS class support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Thu, 11 May 2023 10:58:42 -0700
Message-ID: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v2:
- Set cdat.table at the end to keep consistency. (Davidlohr)
- Split out error return for cdat_read(). (Davidlohr)

With the "cxl: Add support for QTG ID retrieval for CXL subsystem" series
getting larger and larger and span multiple maintainers, I'm going to try
to break them up into smaller parts. These 3 patches are just preparation
for QTG retrieval. Full git branch available at [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
---

Dave Jiang (4):
      cxl: Export QTG ids from CFMWS to sysfs as qos_class attribute
      cxl: Add missing return to cdat read error path
      cxl: Add checksum verification to CDAT from CXL
      cxl: Add support for reading CXL switch CDAT table


 Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++++
 drivers/cxl/acpi.c                      |  3 ++
 drivers/cxl/core/pci.c                  | 43 +++++++++++++++++++++----
 drivers/cxl/core/port.c                 | 11 +++++++
 drivers/cxl/cxl.h                       |  3 ++
 drivers/cxl/port.c                      |  3 ++
 6 files changed, 72 insertions(+), 6 deletions(-)

--

