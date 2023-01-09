Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1E9C54EBE
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbjAIVoN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbjAIVnS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 16:43:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF3642B
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 13:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673300583; x=1704836583;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hDPQ0tKxkpogo24st+WHs+zKOIs68nIL+rksrfk+sro=;
  b=ib9knSAbUX50ld4IfGC1ck0D4gDCH35Q40gfe1Hxk6KorIAR39icTIEQ
   Qxpoj/nSY4xyw+3VhGTpdTYEbfspXTXrd7M+Xy0eLtyUiiY4MGQ3VbZjL
   Pya5YtlRCES12V9TUURtj3o+roWdK86HGzn7VWi7gXBmZqM7/nSO35Qcq
   mJHOsYhMOxMMSJKyh3L44hIQx2k2Ki8gVPEVIPyCN/H7OpwOZ8IKWMXPn
   vBExegCdHimctmx6UoGkI+3h4HCDDc0qbCoqSTVMsKBSMtfEzt9CMv6wG
   K5CCwSWocz/0dpTM3g3zEwBsOfqxSRsnCZl3sXJmt4PHBEUhNnBlWexX7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385296168"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="385296168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656807675"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="656807675"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.37.174])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:43:02 -0800
Subject: [PATCH v2 0/8] cxl: Introduce HDM decoder emulation from DVSEC range
 registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Mon, 09 Jan 2023 14:43:00 -0700
Message-ID: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v2:
- Refactor to return when size is 0. (Jonathan)
- Update kdoc comments (Jonathan)
- Use a bool for is_cxl_endpoint() to make it easier for static analysis
  (Jonathan)
- Update commit log to indicate cxl_hdm_decode_init() return additional
  error codes after change. (Jonathan)
- Set target_type to CXL_DECODER_EXPANDER (type 3). (Jonathan)
- Skip HDM enabling if DVSEC range is active. (Jonathan)
- Set target_count to same as number of ranges. (Jonathan)
- Set target_type to CXL_DECODER_EXPANDER (type 3). (Jonathan)
- Refactor to put error case out of line. (Jonathan)
- Drop 7/8 "cxl: suppress component register discovery failure warning for RCD"
- Add support for missing case where HDM decoders are present but no decoders
  are committed. (Case 5 below)

This series provides the emulation of HDM decoders from the programmed range
registers. From CXL 3.0 spec 8.1.3.8, there can be up to 2 ranges programmed.
Some devices may not implement HDM decoder registers and some may not be
programmed by the BIOS. Under such scenarios, if one of more range registers
are programmed, then we can create an emulated HDM decoder per active range
indicated by the range registers. The emulated HDM decoders will show up as
locked and cannot be reprogrammed.

Below is a table that indicates different scenarios the driver may encounter:

rr: Range registers not programmed
hdm: HDM decoders not programmed
RR: Range registers programmed by BIOS
HDM: HDM decoders programmed by BIOS

emulate HDM: Create HDM decoder software structs and use values from range registers.
keep HDM: Populate HDM decoder software structs with values in HDM decoder registers.

Case 1:        Case 2:        Case 3:    Case 4:     Case 5:       Case 6:
rr             RR             rr hdm	 rr HDM	     RR hdm        RR HDM
unsupported    emulate HDM    keep HDM	 keep HDM    emulate HDM   keep HDM

For convenience, the kernel branch can be retrieved here [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-emulate-hdm

---

Dave Jiang (8):
      cxl: break out range register decoding from cxl_hdm_decode_init()
      cxl: export cxl_dvsec_rr_decode() to cxl_port
      cxl: refactor cxl_hdm_decode_init()
      cxl: emulate HDM decoder from DVSEC range registers
      cxl: create emulated cxl_hdm for devices that do not have HDM decoders
      cxl: create emulated decoders for devices without HDM decoders
      cxl: Add emulation when HDM decoders are not committed
      cxl: remove locked check for dvsec_range_allowed()


 drivers/cxl/core/hdm.c | 121 ++++++++++++++++++++++---
 drivers/cxl/core/pci.c | 201 ++++++++++++++++++++---------------------
 drivers/cxl/cxl.h      |  21 ++++-
 drivers/cxl/cxlmem.h   |  12 ---
 drivers/cxl/cxlpci.h   |   3 +-
 drivers/cxl/port.c     |  25 +++--
 6 files changed, 243 insertions(+), 140 deletions(-)

base-commit: 88603b6dc419445847923fcb7fe5080067a30f98

