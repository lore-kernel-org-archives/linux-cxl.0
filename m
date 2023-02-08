Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70366C05027
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 19:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjBHTUs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjBHTUr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 14:20:47 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34884FC3A
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 11:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675884046; x=1707420046;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xw45SvKUt1rYHjxp3+WdVNvhZK6g5Q8kRN112zvkDwA=;
  b=cQSuDMezJyjIgMc/de0VwGr+sM4xnqpzYMRMFY5Icr+m+c4GC8FnpaWu
   9CHgaNiSBhUzjB5lTgYJpai8nLNrCuyamhcAwFY12D4jjNihMEHrcOBcC
   j6SyGiKa79x6V145BEngtzEpdrIHT8jGDniZqTIUnMaVFyb5escKZLKcU
   3psxzq+Y7stfrBwOD9gJF9Lhb7rm6ofOcdyTu28rHGKBdCvdqWHfu0Lj5
   2085bW31XfOhI0+TbxFu4XzML8eCs5pTi5jY8PvU1kaC+pJMRPSgp+eyB
   7uwE7fEPXS3fQBB/IouxxciWFUFNtn6YWgebUSfL3QFhm5LxHZlKQhyy+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329925957"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329925957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:20:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776164876"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776164876"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.48.215])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:20:46 -0800
Subject: [PATCH v4 0/7] cxl: Introduce HDM decoder emulation from DVSEC range
 registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Date:   Wed, 08 Feb 2023 12:20:44 -0700
Message-ID: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

v4:
- Init invalid range start to 0. (Dan)
- Direct assign range to range. (Dan)
- Add comment for why emulated decoder is locked. (Dan)
- Check range_len() instead of content of .start. (Dan)
- Fix too long line formatting. (Dan)
- Remove ->emulate_decoders (Dan)
- Dropped v3 7/8 patch. (Dan)
- Change decoder lock removal commit log for more clarity. (Dan)

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

base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3

---

Dave Jiang (7):
      cxl: break out range register decoding from cxl_hdm_decode_init()
      cxl: export cxl_dvsec_rr_decode() to cxl_port
      cxl: refactor cxl_hdm_decode_init()
      cxl: emulate HDM decoder from DVSEC range registers
      cxl: create emulated cxl_hdm for devices that do not have HDM decoders
      cxl: Add emulation when HDM decoders are not committed
      cxl: remove locked check for dvsec_range_allowed()


 drivers/cxl/core/hdm.c | 119 +++++++++++++++++++++---
 drivers/cxl/core/pci.c | 199 +++++++++++++++++++----------------------
 drivers/cxl/cxl.h      |  20 ++++-
 drivers/cxl/cxlmem.h   |  12 ---
 drivers/cxl/cxlpci.h   |   3 +-
 drivers/cxl/port.c     |  25 ++++--
 6 files changed, 237 insertions(+), 141 deletions(-)

--

