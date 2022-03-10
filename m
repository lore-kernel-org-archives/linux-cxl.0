Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB1AC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 08:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiCJIkN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiCJIkN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Mar 2022 03:40:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489D136ED1
        for <linux-cxl@vger.kernel.org>; Thu, 10 Mar 2022 00:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646901552; x=1678437552;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EINunjKwbUzYNbXLbe3AwHD5LmoTnNeY9TL0oXt8pHo=;
  b=MEKsqWeLZWjPeZTZJNRPjyQ114SYqJfoGrbl9REKoUW5MPDqC42tem9a
   twev5IjD2sw0gJ2m+hKFw//qSrLMx/ausUHF0xejWVXR980eFNJyZFSIU
   FQ88vxfngZ+Xzszvfah+uGsxSsWo26saXDtHv/azz3buCYX20Bya6SVJR
   1XfgcTv+gZwnVhpG1JCuBE7tgqxhcV5bYdJLqiw9IDfwCdncDIQsVf6yY
   Nau/JFY7/VVXvlu3CxxXOEGoO4iQWzsLHkUgYqpMKNwocVAUyhIAiEPgB
   8CSdBiZXf9LrezqlLkXd6iI/cpP2sf58mG/YAly87BGhA8mWRjA7PXNH6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242639402"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="242639402"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:39:12 -0800
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="642474902"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:39:11 -0800
Subject: [PATCH 0/2] cxl: Fixup Legacy DVSEC Init failures
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Krzysztof Zach <krzysztof.zach@intel.com>,
        Jonathan.Cameron@huawei.com, ben.widawsky@intel.com
Date:   Thu, 10 Mar 2022 00:39:11 -0800
Message-ID: <164690155138.3326488.16049914482944930295.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Krzysztof reports a case where a timeout waiting for the "memory info
valid" indication in the DVSEC range register also resulted in the PCI
driver failing to load. Fix that by making DVSEC range register probe
failures non-fatal.

While investigating that came across the error message to validate EFI
memory map publication of DVSEC range registers and could not determine
that it affords any safety or actionable fixes to report back to a BIOS
vendor.

---

Dan Williams (2):
      cxl/mem: Drop DVSEC vs EFI Memory Map sanity check
      cxl/pci: Preserve mailbox access after DVSEC probe failure


 drivers/cxl/mem.c |   44 ++++++++++----------------------------------
 drivers/cxl/pci.c |   40 ++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 46 deletions(-)

base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4
