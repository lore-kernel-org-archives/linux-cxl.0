Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D622C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 00:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiERAu4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 May 2022 20:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiERAuy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 May 2022 20:50:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3DE55B2
        for <linux-cxl@vger.kernel.org>; Tue, 17 May 2022 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652835052; x=1684371052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4vDnotMFO5WqUGNTV+aksJSZWD+WhnJ0eOjh1qtFuos=;
  b=nrUkqX1Ao6JKE/EZT0Mi0IB10PsZVZAzkUbPP3w8o6dCL0a9QTtfpMM4
   r+UfGqriZSRDgUR3l0rvrVl62NW+11UjgGpG4f01zjit4YcNP4wBRXB5N
   D2f0RLlOl9uBc7qEySpE7R8b+zZde42Q7R8kmMoc7FGXqrSGRA55Si/wx
   lIiJvp8xijk476xRe93VVtLJw6hQ79RSjw3fHKE/0eONaWNqRUfGf9rQA
   cHO88uAcrxI/cffFO0gLeIGmcNwANV4llg6LIT0+RBkmuomNVqXEE7p+t
   G48Y2JPRUA4YfNPOwp7W+Prce0JM3MWJUptBNCbRHYoWG/nD7UsT0m0rY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="357818161"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="357818161"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 17:50:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="673132262"
Received: from hrong1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.21.169])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 17:50:50 -0700
Date:   Tue, 17 May 2022 17:50:50 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
        ben.widawsky@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com
Subject: Re: [PATCH 00/14] cxl: Fix "mem_enable" handling
Message-ID: <YoRC6myTbtq6KoUd@iweiny-desk3>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 12, 2022 at 11:14:16AM -0700, Dan Williams wrote:
> Jonathan reports [1] that after he changed QEMU to stop setting
> Mem_Enable (8.1.3.2 DVSEC CXL Control (Bit 2)) by default the following
> problems arose:
> 
>     1. Nothing in the Linux code actually sets Mem_Enable to 1.
>     2. Probing fails in mem.c as wait_for_media() checks for
>        info->mem_enabled (cached value of this bit).
> 
> The investigation turned up more issues:
> 
> - DVSEC ranges are always non-zero size, so it is ambiguous, just
>   looking at the registers, as to whether platform firmware is trying to
>   route the first 256M of memory to CXL, or just failed to change the
>   registers from the default.
> 
> - No driver consideration for clearing "mem_enabled" and / or HDM
>   Decoder Enable.
> 
> - The cxl_test mock override for cxl_hdm_decode_init() was hiding bugs
>   in this path.
> 
> The end goal of these reworks are to improve detection for cases where
> platform firmware is actually operating in legacy CXL DVSEC Range mode,
> take ownership for setting and clearing "mem_enable" and HDM Decoder
> Enable, and cleanup the indirections / mocking for cxl_test.
> 
> The new flow is described in patch 14:
> 
>     Previously, the cxl_mem driver was relying on platform-firmware to set
>     "mem_enable". That is an invalid assumption as there is no requirement
>     that platform-firmware sets the bit before the driver sees a device,
>     especially in hot-plug scenarios. Additionally, ACPI-platforms that
>     support CXL 2.0 devices also support the ACPI CEDT (CXL Early Discovery
>     Table). That table outlines the platform permissible address ranges for
>     CXL operation. So, there is a need for the driver to set "mem_enable",
>     and there is information available to determine the validity of the CXL
>     DVSEC Ranges. Note that the DVSEC Ranges can not be shut off completely.
>     They always decode at least 256MB if "mem_enable" is set and the HDM
>     Decoder capability is disabled.
> 
>     Arrange for the driver to optionally enable the HDM Decoder Capability
>     if "mem_enable" was not set by platform firmware, or the CXL DVSEC Range
>     configuration was invalid. Be careful to only disable memory decode if
>     the kernel was the one to enable it. In other words, if CXL is backing
>     all of kernel memory at boot the device needs to maintain "mem_enable"
>     and "HDM Decoder enable" all the way up to handoff back to platform
>     firmware (e.g. ACPI S5 state entry may require CXL memory to stay
>     active).
> 
> Link: https://lore.kernel.org/r/20220426180832.00005f0b@Huawei.com [1]

For the series:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> ---
> 
> Dan Williams (14):
>       cxl/mem: Drop mem_enabled check from wait_for_media()
>       cxl/pci: Consolidate wait_for_media() and wait_for_media_ready()
>       cxl/pci: Drop wait_for_valid() from cxl_await_media_ready()
>       cxl/mem: Fix cxl_mem_probe() error exit
>       cxl/mem: Validate port connectivity before dvsec ranges
>       cxl/pci: Move cxl_await_media_ready() to the core
>       cxl/mem: Consolidate CXL DVSEC Range enumeration in the core
>       cxl/mem: Skip range enumeration if mem_enable clear
>       cxl/mem: Fix CXL DVSEC Range Sizing
>       cxl/mem: Merge cxl_dvsec_ranges() and cxl_hdm_decode_init()
>       cxl/pci: Drop @info argument to cxl_hdm_decode_init()
>       cxl/port: Move endpoint HDM Decoder Capability init to port driver
>       cxl/port: Reuse 'struct cxl_hdm' context for hdm init
>       cxl/port: Enable HDM Capability after validating DVSEC Ranges
> 
> 
>  drivers/cxl/core/pci.c        |  362 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h          |    4 
>  drivers/cxl/cxlpci.h          |    2 
>  drivers/cxl/mem.c             |  115 -------------
>  drivers/cxl/pci.c             |  184 ---------------------
>  drivers/cxl/port.c            |   28 ++-
>  tools/testing/cxl/Kbuild      |    3 
>  tools/testing/cxl/mock_mem.c  |   10 -
>  tools/testing/cxl/test/mem.c  |   17 --
>  tools/testing/cxl/test/mock.c |   29 +++
>  10 files changed, 422 insertions(+), 332 deletions(-)
>  delete mode 100644 tools/testing/cxl/mock_mem.c
> 
> base-commit: e6829d1bd3c4b58296ee9e412f7ed4d6cb390192
