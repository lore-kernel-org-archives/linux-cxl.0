Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D735C61DA4
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjBNTlJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTlI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB12CFF7
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403663; x=1707939663;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cD+eOYNxR+CuKLT5frw8njlOHG1GlO7jXR/eAUTP1j8=;
  b=AqdqZAZBnSJ8NBjQv90sCdOcYUcQQKHL4yx3d94yOJ8/Ezh9/VoESqwH
   JUOHZy0ySTtlSY0acBD52TkHqrI/Oc2Al5+lpWccLt1zETich/XRRcLz3
   qMhctT/9hlJeRJO6Nbe7g5q15VXEWV6npDkZ55e6wY2IR0vPfk6EN2Iua
   7sv2CiBWh3gCK3KAJpZjh+/ZbJACCJHFZbYtl7t9IAhAFzluVYWh/oVJz
   JfbyB4Nb5dgLO4CWts5RgW9w7fSnSQPuL79azq069kXZ3d7jjqPQIpg/U
   D6eyTb3xG6X2slP63gvPyHZuIkYOvCrS0Ifb2BPfKlOUh/uXuE3EzGa1o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333384769"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="333384769"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793207764"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793207764"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:03 -0800
Subject: [PATCH v5 0/7] cxl: Introduce HDM decoder emulation from DVSEC
 range registers
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:03 -0800
Message-ID: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v4 [1]:
- Fold in changes to make this emulation compatible with cxl_test. For
  the most part this is providing a stub version of
  cxl_dvsec_rr_decode() so cxl_test can ignore 'struct
  cxl_endpoint_dvsec_info' related logic, and otherwise match the new
  function signatures.

[1]: http://lore.kernel.org/r/167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local

---

(cover letter from v4)

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
rr             RR             rr hdm     rr HDM      RR hdm        RR HDM
unsupported    emulate HDM    keep HDM   keep HDM    emulate HDM   keep HDM

---

Dave Jiang (7):
      cxl/pci: Break out range register decoding from cxl_hdm_decode_init()
      cxl/port: Export cxl_dvsec_rr_decode() to cxl_port
      cxl/pci: Refactor cxl_hdm_decode_init()
      cxl/hdm: Emulate HDM decoder from DVSEC range registers
      cxl/hdm: Create emulated cxl_hdm for devices that do not have HDM decoders
      cxl/hdm: Add emulation when HDM decoders are not committed
      cxl/pci: Remove locked check for dvsec_range_allowed()


 drivers/cxl/core/hdm.c        |  119 ++++++++++++++++++++++--
 drivers/cxl/core/pci.c        |  200 +++++++++++++++++++----------------------
 drivers/cxl/cxl.h             |   20 ++++
 drivers/cxl/cxlmem.h          |   12 --
 drivers/cxl/cxlpci.h          |    3 -
 drivers/cxl/port.c            |   24 +++--
 tools/testing/cxl/Kbuild      |    1 
 tools/testing/cxl/test/cxl.c  |    6 +
 tools/testing/cxl/test/mock.c |   36 ++++++-
 tools/testing/cxl/test/mock.h |    6 +
 10 files changed, 273 insertions(+), 154 deletions(-)

base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
