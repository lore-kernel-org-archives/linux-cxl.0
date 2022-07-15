Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A292AC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Jul 2022 21:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGOVIf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOVIe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Jul 2022 17:08:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8806B762
        for <linux-cxl@vger.kernel.org>; Fri, 15 Jul 2022 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657919313; x=1689455313;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7BF81LETZaU+r3o9lF+SOM9GnjKhTQeTvLp6cuo8V9s=;
  b=K8IopinaXd10T0MYKv07mq676foElaSHw2zHH2M3HBZGnGJ2gO/UaNyw
   y2AFxpiGyhkQQdQpYlfwILGmOlGdzxbVZvCKBJe3FFxHjVnPGgPTiBAy2
   iWynqtxF5VM4lNTiNltPrUj6ddcBSVYoKhWF2kEKIXiK3H1Kb8+IhEkfb
   LPejZlyR/cCR17c6++r8UozwJCdtkOcooKSqLJTXT2lf8MFP/lwrxQjQN
   htnYXCODSKYCpESHq4Xl1iCE7vtuc7vJKx5t4q8iJTQHE727r9QM+KSYe
   xA5uT8zz4DlkIKx5bWj/BRE6uLlAdG15QwBlYj7LfuVbZKq/zkXZF3p8o
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="283458276"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="283458276"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:08:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="654501206"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:08:32 -0700
Subject: [PATCH RFC 00/15] Introduce security commands for CXL pmem device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dave@stgolabs.net
Date:   Fri, 15 Jul 2022 14:08:32 -0700
Message-ID: <165791918718.2491387.4203738301057301285.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This series is seeking comments on the implementation. It has not been fully
tested yet.

This series adds the support for "Persistent Memory Data-at-rest Security"
block of command set for the CXL Memory Devices. The enabling is done through
the nvdimm_security_ops as the operations are very similar to the same
operations that the persistent memory devices through NFIT provider support.
This enabling does not include the security pass-through commands nor the
Santize commands.

Under the nvdimm_security_ops, this patch series will enable get_flags(),
freeze(), change_key(), unlock(), disable(), and erase(). The disable() API
does not support disabling of the master passphrase. To maintain established
user ABI through the sysfs attribute "security", the "disable" command is
left untouched and a new "disable_master" command is introduced with a new
disable_master() API call for the nvdimm_security_ops().

This series does not include plumbing to directly handle the security commands
through cxl control util. The enabled security commands will still go through
ndctl tool with this enabling.

For calls such as unlock() and erase(), the CPU caches must be invalidated
post operation. Currently, the implementation resides in
drivers/acpi/nfit/intel.c with a comment that it should be implemented
cross arch when more than just NFIT based device needs this operation.
With the coming of CXL persistent memory devices this is now needed.
Introduce ARCH_HAS_NVDIMM_INVAL_CACHE and implement similar to
ARCH_HAS_PMEM_API where the arch can opt in with implementation.
Currently only add x86_64 implementation where wbinvd_on_all_cpus()
is called.

---

Dave Jiang (15):
      cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation
      tools/testing/cxl: Create context for cxl mock device
      tools/testing/cxl: Add "Get Security State" opcode support
      cxl/pmem: Add "Set Passphrase" security command support
      tools/testing/cxl: Add "Set Passphrase" opcode support
      cxl/pmem: Add Disable Passphrase security command support
      tools/testing/cxl: Add "Disable" security opcode support
      cxl/pmem: Add "Freeze Security State" security command support
      tools/testing/cxl: Add "Freeze Security State" security opcode support
      x86: add an arch helper function to invalidate all cache for nvdimm
      cxl/pmem: Add "Unlock" security command support
      tools/testing/cxl: Add "Unlock" security opcode support
      cxl/pmem: Add "Passphrase Secure Erase" security command support
      tools/testing/cxl: Add "passphrase secure erase" opcode support
      nvdimm/cxl/pmem: Add support for master passphrase disable security command


 arch/x86/Kconfig             |   1 +
 arch/x86/mm/pat/set_memory.c |   8 +
 drivers/acpi/nfit/intel.c    |  28 +--
 drivers/cxl/Kconfig          |  16 ++
 drivers/cxl/Makefile         |   1 +
 drivers/cxl/cxlmem.h         |  41 +++++
 drivers/cxl/pmem.c           |  10 +-
 drivers/cxl/security.c       | 182 ++++++++++++++++++
 drivers/nvdimm/security.c    |  33 +++-
 include/linux/libnvdimm.h    |  10 +
 lib/Kconfig                  |   3 +
 tools/testing/cxl/Kbuild     |   1 +
 tools/testing/cxl/test/mem.c | 348 ++++++++++++++++++++++++++++++++++-
 13 files changed, 644 insertions(+), 38 deletions(-)
 create mode 100644 drivers/cxl/security.c

--

