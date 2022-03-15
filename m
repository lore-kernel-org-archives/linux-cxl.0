Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B84C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Mar 2022 01:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiCOBX3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiCOBX2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 21:23:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9263473AD
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 18:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307337; x=1678843337;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4p3DGgEk6SwAVbuaSgTMZIKFYlGj8ZTXCx0tI/DeEdE=;
  b=Y/NheOPLL0EnjrVXQaFg5W4xZttM4Z/OksxxpSAl8BYKxSK5WZkufqSw
   WW94B/N5BtH30vK0mFJajKIZFrDSsZ2c1foIcPtxuptWQnbUsY+csCwZ7
   4BcEdyn3m7ELA1Ty9VidP84s5ZJ8VqoU6oyndDXpo4nmN5w7hg3lWeUKc
   SSLoFtxI6ddaoOloGORwjhbpcRK87UBCs4vBui65JDkrpOguvqzXfPfIw
   J8t1d3rY1YZTo46bIABjCMXgx5Y82yQ3JrDrgLXbm+yEA1iTMbyJd5uGI
   LiS5G0K/r8NaOe2L6dfVlZBbhJ4JQZ2AyVYKJfB9in/YlMJxQPasJvASa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342613061"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="342613061"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="646037132"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:17 -0700
Subject: [PATCH v2 0/6] cxl: Handle DVSEC range init failures
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Krzysztof Zach <krzysztof.zach@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Mon, 14 Mar 2022 18:22:17 -0700
Message-ID: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1 [1]:
- Split the debug message additions to their own patch (Ben)
- Split the cxl_dvsec_range() handling in the cxl_mem driver to its own
  patch.
- Add a patch to rename cxl_dvsec_decode_init()
- Add a patch to clarify global HDM decoder control vs DVSEC range
  configuration.
- Pick up David's Reviewed-by, thanks David!

[1]: https://lore.kernel.org/r/164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com

---

Krzysztof reports a case where a timeout waiting for the "memory info
valid" indication in the DVSEC range register also results in the PCI
driver failing to load. Fix that scenario by making DVSEC range register
probe failures non-fatal to the cxl_pci driver.

Instead, convey the state of the DVSEC range registers to the cxl_mem
driver which can decide if it wants to proceed. Recall that the reason
cxl_mem relies on cxl_pci to do the register access is to keep PCI
configuration space knowledge in the cxl_pci driver and leave MMIO based
CXL.mem operations to the cxl_mem driver.

While pulling on the above threads a few more fixup and clarification
opportunities fell out.

---

Dan Williams (6):
      cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
      cxl/pci: Add debug for DVSEC range init failures
      cxl/mem: Make cxl_dvsec_range() init failure fatal
      cxl/pci: Make cxl_dvsec_ranges() failure not fatal to cxl_pci
      cxl/mem: Rename cxl_dvsec_decode_init() to cxl_hdm_decode_init()
      cxl/mem: Replace redundant debug message with a comment


 drivers/cxl/mem.c            |   52 +++++++++++++++---------------------------
 drivers/cxl/pci.c            |   40 +++++++++++++++++++++++---------
 tools/testing/cxl/mock_mem.c |    2 +-
 3 files changed, 48 insertions(+), 46 deletions(-)

base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4
