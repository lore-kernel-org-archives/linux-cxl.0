Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0A5C47088
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiK3XU2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiK3XT5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:19:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3580616A
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669849977; x=1701385977;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oeIH3BdgivH04veomWqWWnaf6ftgQFoBcDa/2qiYdLk=;
  b=HTw1GWFJst09LaVk7D/e5tpx7PecuLF4e+sXRFB2UfUa8DKAUgVEE11q
   U0z98gVdY96xgaCpo4V3XYSTIumOVNe47+65ZmgmWWATs8qVZbztQPrfX
   4gVGs5ZsRkKlvCKil8LJwOn2InHcFgeU8AZ+jnUvlZDH3dY2hcSphy9os
   zp94+N1yGkhCM7cni9czAloiTrq7QVI1Mwi/uDOu8g1Q1MuKD+aHUoW4K
   /Ff2LIX2dzOOAuP5uDDDDwzuKvyu+ndnVBfgOxmDzhbOj7LdRSrV4My28
   RF4VkZikCazSow9HlRji9NXDnAcRsRu/nh3oqmcrD3VlWwV9NNudcg72K
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="314232837"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="314232837"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="675206067"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="675206067"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:15 -0800
Subject: [RFC PATCH 0/8] cxl: Introduce HDM decoder emulation from DVSEC range
 registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:12:15 -0700
Message-ID: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This series provides the emulation of HDM decoders from the programmed range
registers. From CXL 3.0 spec 8.1.3.8, there can be up to 2 ranges programmed.
Some device may not implement HDM decoder registers and some may not be
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

rr             RR             rr hdm	 rr HDM	     RR hdm        RR HDM
unsupported    emulate HDM    keep HDM	 keep HDM    emulate HDM   keep HDM

This series is based on the current RCD work [1] that's going through upstream review.
For convenience, the kernel branch can be retrieved here [2].

[1]: https://lore.kernel.org/linux-cxl/Y4ePZD776yXv2rG3@rric.localdomain/T/#t
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-rch

---

Dave Jiang (8):
      cxl: break out range register decoding from cxl_hdm_decode_init()
      cxl: export cxl_dvsec_rr_decode() to cxl_port
      cxl: refactor cxl_hdm_decode_init()
      cxl: emulate HDM decoder from DVSEC range registers
      cxl: create emulated cxl_hdm for devices that do not have HDM decoders
      cxl: create emulated decoders for devices without HDM decoders
      cxl: suppress component register discovery failure warning for RCD
      cxl: remove locked check for dvsec_range_allowed()


 drivers/cxl/core/hdm.c | 115 +++++++++++++++++++++++---
 drivers/cxl/core/pci.c | 179 +++++++++++++++++------------------------
 drivers/cxl/cxl.h      |  20 ++++-
 drivers/cxl/cxlmem.h   |  13 +--
 drivers/cxl/cxlpci.h   |   3 +-
 drivers/cxl/pci.c      |   2 +-
 drivers/cxl/port.c     |  19 +++--
 7 files changed, 215 insertions(+), 136 deletions(-)

--

