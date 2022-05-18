Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA2C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 23:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiERXeM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiERXeL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 19:34:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250DF5B8
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652916850; x=1684452850;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xB8RYg7qv6RJYn9Go1XrrywQojoQ4dLJQeyPWkFpXlc=;
  b=GeNtmfc8MwZ7SY7+QQ4aqtgqYcGOL6orzoxlYXvdHZT4uoPD/xkUP0xQ
   4rEUCfQC+Ty5s4rlucR8uHgp0Ya+fJGuVzedpQlnBOOy1WgMB7wlLZiP4
   dnUwIVkeoXGVW5MpVp/Yk60SECwjpl/iDb9+yhSANlBSZzWZoZfdaeAH4
   DjCLCk529euiptk6ARq93bayokQ5zA8HtOtiVuwwDS+NsAZCUb+znvfoC
   VZrB0vwSOXxOBxF3fk3Okn2R8OobvV/wf84X0QbhOxPoYzSIh9WdeJVt5
   13q/GwmIHMfngwvdz6PBXsnjxItcPM+jlWKkXtFOqKb8w2pEj49euY402
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="271894281"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="271894281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="700849961"
Received: from vgarg-mobl2.amr.corp.intel.com (HELO [192.168.1.101]) ([10.209.5.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 16:34:09 -0700
Subject: [PATCH v3 00/13] cxl: Fix "mem_enable" handling
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ariel Sibley <ariel.sibley@microchip.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Wed, 18 May 2022 16:34:09 -0700
Message-ID: <165291684910.1426646.8615474651213855015.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v2 [1]:
- Drop the assumption that Memory_size=0 still decodes up to 256MB of
  memory space (Ariel, and Jonathan)
- Move the  s/out:/unlock:/ label rename a patch earlier (Jonathan)
- Drop ternary conditional trickery in a debug message (Jonathan)

[1]: https://lore.kernel.org/r/165283418817.1033989.11273676872054815459.stgit@dwillia2-xfh

---

Jonathan reports [2] that after he changed QEMU to stop setting
Mem_Enable (8.1.3.2 DVSEC CXL Control (Bit 2)) by default the following
problems arose:

    1. Nothing in the Linux code actually sets Mem_Enable to 1.
    2. Probing fails in mem.c as wait_for_media() checks for
       info->mem_enabled (cached value of this bit).

The investigation turned up more issues:

- DVSEC ranges, to be valid, must be covered by a CFMWS entry. Current
  code was blindly assuming that any non-zero value is valid.
 
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

Link: https://lore.kernel.org/r/20220426180832.00005f0b@Huawei.com [2]

---

Dan Williams (13):
      cxl/mem: Drop mem_enabled check from wait_for_media()
      cxl/pci: Consolidate wait_for_media() and wait_for_media_ready()
      cxl/pci: Drop wait_for_valid() from cxl_await_media_ready()
      cxl/mem: Fix cxl_mem_probe() error exit
      cxl/mem: Validate port connectivity before dvsec ranges
      cxl/pci: Move cxl_await_media_ready() to the core
      cxl/mem: Consolidate CXL DVSEC Range enumeration in the core
      cxl/mem: Skip range enumeration if mem_enable clear
      cxl/mem: Merge cxl_dvsec_ranges() and cxl_hdm_decode_init()
      cxl/pci: Drop @info argument to cxl_hdm_decode_init()
      cxl/port: Move endpoint HDM Decoder Capability init to port driver
      cxl/port: Reuse 'struct cxl_hdm' context for hdm init
      cxl/port: Enable HDM Capability after validating DVSEC Ranges


 drivers/cxl/core/pci.c        |  364 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h          |    4 
 drivers/cxl/cxlpci.h          |    2 
 drivers/cxl/mem.c             |  115 -------------
 drivers/cxl/pci.c             |  184 ---------------------
 drivers/cxl/port.c            |   28 ++-
 tools/testing/cxl/Kbuild      |    3 
 tools/testing/cxl/mock_mem.c  |   10 -
 tools/testing/cxl/test/mem.c  |   17 --
 tools/testing/cxl/test/mock.c |   29 +++
 10 files changed, 424 insertions(+), 332 deletions(-)
 delete mode 100644 tools/testing/cxl/mock_mem.c

base-commit: e6829d1bd3c4b58296ee9e412f7ed4d6cb390192
