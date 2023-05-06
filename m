Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1243C77B7C
	for <linux-cxl@archiver.kernel.org>; Sat,  6 May 2023 00:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjEFAFN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 20:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjEFAFN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 20:05:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203025FD1;
        Fri,  5 May 2023 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683331512; x=1714867512;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=79CJHPqCO0eY3p701dtPvPHupeq6TdhJ6d2+eTacpqw=;
  b=F3DA39mfQBJ6qeRzR/1mQngn/AojF8KQ3yWxX/lIJ1egPXzMpuC3Hbld
   jDPuG8AVtkfXXKET88wKU8WuhqXHbVpqDzUmsWJ0qxHdcTvPQ/Gx/3Akk
   DLLmh4iw4HPQGVHcTclC+XOj9+b1E/IeXMv/37YV3autNKYnjVSy41VzD
   Ue7eF96nFCzNfqre1HxhHn5ENwDa74ULGbXtstBQ+vz0JsCS0LEcq02+U
   04ASzB6nrr6k/6SKU1vY22dPUZL4ObPgqf4WQVJj9palZ2JN1qpGqTRQr
   VvaR+KL4siG6ttPdBQDfTxlOVhBz4Yz2r7lRfJgiBLddk21b3csnTD6oo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338525701"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="338525701"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841969304"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="841969304"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:11 -0700
Subject: [PATCH 0/4] acpi: numa: add target support for generic port to HMAT
 parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 17:05:10 -0700
Message-ID: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Rafael,
This is the second set of ACPI changes that's part of the "cxl: Add support for
QTG ID retrieval for CXL subsystem" [1]. It has dependency on the patch [2]
that was sent to you and GregKH. But it's independent of the first set of
ACPI changes [3]. The series adds support to store the device handle from the
SRAT Generic Port Affinity Structure in correlation with a proximity domain. And
later on the HMAT is parsed and the performance data is stored associated with
the proximity domain. A helper function is added to allow the CXL driver to
retrieve the performance data that matches with the device handle later on. The
full series of CXL code is at this git repo [4] for usage reference. Please
review and consider for v6.5 inclusion if acceptable. Thank you!


[1]: https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t 
[2]: https://lore.kernel.org/lkml/168332248685.2190392.1983307884583782116.stgit@djiang5-mobl3/
[3]: https://lore.kernel.org/linux-acpi/168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3/T/#t
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg

---

Dave Jiang (4):
      acpi: numa: Create enum for memory_target access coordinates indexing
      acpi: numa: Add genport target allocation to the HMAT parsing
      acpi: numa: Add setting of generic port system locality attributes
      acpi: numa: Add helper function to retrieve the performance attributes


 drivers/acpi/numa/hmat.c | 130 ++++++++++++++++++++++++++++++++++-----
 include/acpi/actbl3.h    |   4 +-
 include/linux/acpi.h     |   9 +++
 3 files changed, 128 insertions(+), 15 deletions(-)

--

