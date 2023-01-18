Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8889EC38147
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjARSJL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjARSIs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:08:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580011EAD
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065310; x=1705601310;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ei3lR/SoQMhGD8cuXk2o1bQ9pKpwA/p8cVcjo6O71Dg=;
  b=ghbV9kAuAuZDBPHpBq816GV5b4DHyoolXQGkGqPHL55yyCd3X/mbebvw
   Yc2e6tspEV9htCBFH5fbGKyDMqhWfjQJEvCTrWn0J4wrL1BD2o2dxgBQb
   GG7rply8LQcJHkZpxMFU/RrHthJhhDTExxhz9YS9GECl3x3n+4LlHxIKW
   rPRtkicLY10DRU3RQ9f59gbYi3qQdvZIUJ3MjUAetwZg2mkgJ2exuIMnu
   +hGf5+687o+cX3eF9cNoAyTRQEQW8AmVZ544Bgj3IBDFQ4k8XnVLh4FZq
   qaoMmgIjGadBQGtw8egDBaZ9h7Wxnl2EomTxHMzRhgulFEG0Qo1NKA3Ok
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="352307744"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="352307744"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="988674800"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="988674800"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:22 -0800
Subject: [PATCH v3 0/8] cxl: Introduce HDM decoder emulation from DVSEC range
 registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:08:20 -0700
Message-ID: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v3:
- Simplify to directly return devm_cxl_enable_mem() in
  cxl_hdm_decode_init(). (Jonathan)
- Move relevant changes from 6/8 to 5/8 and update kdoc. (Jonathan)
- Add kernel doc update. (Jonathan)

v2:
- Refactor to continue when size is 0. (Jonathan)
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


 drivers/cxl/core/hdm.c | 120 ++++++++++++++++++++++---
 drivers/cxl/core/pci.c | 199 +++++++++++++++++++----------------------
 drivers/cxl/cxl.h      |  21 ++++-
 drivers/cxl/cxlmem.h   |  12 ---
 drivers/cxl/cxlpci.h   |   3 +-
 drivers/cxl/port.c     |  25 ++++--
 6 files changed, 239 insertions(+), 141 deletions(-)

base-commit: 88603b6dc419445847923fcb7fe5080067a30f98

