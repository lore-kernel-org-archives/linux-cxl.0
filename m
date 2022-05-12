Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF402C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 12 May 2022 18:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357470AbiELSOT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 May 2022 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241392AbiELSOS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 May 2022 14:14:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843A925F7B2
        for <linux-cxl@vger.kernel.org>; Thu, 12 May 2022 11:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652379257; x=1683915257;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3u/nMAeBRWMicz6TLD9iKdPTU+TkmymxLTEc67s2Vsk=;
  b=dRzmeziu7+94G+XEN6mHLJQSnIyVAxJmZD2BNPvSQukdtioTFORWhBbA
   grkgJVIOr1VDK+Wg3Jjn1SXgvpfLoGCGGdzbZGv5IFmlf3XMw5sFQMowT
   LZBjsLrA4Brjo/Tm/vgGt9Z8wu9GNzhq3R/O11j7YF7FZDgKOm97A8njA
   QZ7wpj6FkPkxqh7zgATEANduj09Dy6xx+0xk1JD1DXs5vod0wu2TRQUtC
   1xo4H38NwPc94GsxnV/jrLuWDWoGS8LgfUcT67Gk+d3qDoI7Wz6nak0PU
   mVcTvNDzI2lWZBd4zrhdS8jNCDdc08zWuJZyWz9SHQF7d19e4Sa6yAZnn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="268934813"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="268934813"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="542899180"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:14:16 -0700
Subject: [PATCH 00/14] cxl: Fix "mem_enable" handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan.Cameron@huawei.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Date:   Thu, 12 May 2022 11:14:16 -0700
Message-ID: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan reports [1] that after he changed QEMU to stop setting
Mem_Enable (8.1.3.2 DVSEC CXL Control (Bit 2)) by default the following
problems arose:

    1. Nothing in the Linux code actually sets Mem_Enable to 1.
    2. Probing fails in mem.c as wait_for_media() checks for
       info->mem_enabled (cached value of this bit).

The investigation turned up more issues:

- DVSEC ranges are always non-zero size, so it is ambiguous, just
  looking at the registers, as to whether platform firmware is trying to
  route the first 256M of memory to CXL, or just failed to change the
  registers from the default.

- No driver consideration for clearing "mem_enabled" and / or HDM
  Decoder Enable.

- The cxl_test mock override for cxl_hdm_decode_init() was hiding bugs
  in this path.

The end goal of these reworks are to improve detection for cases where
platform firmware is actually operating in legacy CXL DVSEC Range mode,
take ownership for setting and clearing "mem_enable" and HDM Decoder
Enable, and cleanup the indirections / mocking for cxl_test.

The new flow is described in patch 14:

    Previously, the cxl_mem driver was relying on platform-firmware to set
    "mem_enable". That is an invalid assumption as there is no requirement
    that platform-firmware sets the bit before the driver sees a device,
    especially in hot-plug scenarios. Additionally, ACPI-platforms that
    support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
    Table). That table outlines the platform permissible address ranges for
    CXL operation. So, there is a need for the driver to set "mem_enable",
    and there is information available to determine the validity of the CXL
    DVSEC Ranges. Note that the DVSEC Ranges can not be shut off completely.
    They always decode at least 256MB if "mem_enable" is set and the HDM
    Decoder capability is disabled.

    Arrange for the driver to optionally enable the HDM Decoder Capability
    if "mem_enable" was not set by platform firmware, or the CXL DVSEC Range
    configuration was invalid. Be careful to only disable memory decode if
    the kernel was the one to enable it. In other words, if CXL is backing
    all of kernel memory at boot the device needs to maintain "mem_enable"
    and "HDM Decoder enable" all the way up to handoff back to platform
    firmware (e.g. ACPI S5 state entry may require CXL memory to stay
    active).

Link: https://lore.kernel.org/r/20220426180832.00005f0b@Huawei.com [1]

---

Dan Williams (14):
      cxl/mem: Drop mem_enabled check from wait_for_media()
      cxl/pci: Consolidate wait_for_media() and wait_for_media_ready()
      cxl/pci: Drop wait_for_valid() from cxl_await_media_ready()
      cxl/mem: Fix cxl_mem_probe() error exit
      cxl/mem: Validate port connectivity before dvsec ranges
      cxl/pci: Move cxl_await_media_ready() to the core
      cxl/mem: Consolidate CXL DVSEC Range enumeration in the core
      cxl/mem: Skip range enumeration if mem_enable clear
      cxl/mem: Fix CXL DVSEC Range Sizing
      cxl/mem: Merge cxl_dvsec_ranges() and cxl_hdm_decode_init()
      cxl/pci: Drop @info argument to cxl_hdm_decode_init()
      cxl/port: Move endpoint HDM Decoder Capability init to port driver
      cxl/port: Reuse 'struct cxl_hdm' context for hdm init
      cxl/port: Enable HDM Capability after validating DVSEC Ranges


 drivers/cxl/core/pci.c        |  362 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h          |    4 
 drivers/cxl/cxlpci.h          |    2 
 drivers/cxl/mem.c             |  115 -------------
 drivers/cxl/pci.c             |  184 ---------------------
 drivers/cxl/port.c            |   28 ++-
 tools/testing/cxl/Kbuild      |    3 
 tools/testing/cxl/mock_mem.c  |   10 -
 tools/testing/cxl/test/mem.c  |   17 --
 tools/testing/cxl/test/mock.c |   29 +++
 10 files changed, 422 insertions(+), 332 deletions(-)
 delete mode 100644 tools/testing/cxl/mock_mem.c

base-commit: e6829d1bd3c4b58296ee9e412f7ed4d6cb390192
