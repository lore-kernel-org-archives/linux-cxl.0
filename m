Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB13AEB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjFOB3w (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjFOB3v (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:29:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2F32126
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792590; x=1718328590;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X94raEYxOvrf4Q2vpehhW2SHMQfj0Tx4OLKKwxFdOjQ=;
  b=ZayzuaSWkkcqhFTiNNUwWApkBhmxs4DwmOx6IVQ/tiyRoLK/fH2HmsDz
   ueZDdXcCe+BwBVDBoKXiYQCmqtL0kQzcTyR8ahCbiB4A9/j07D5Mhvbpj
   j8tChBtrtYeVTVjIJC8BW4iKh/McO52TIiYSyRqcoGSuovFcIobMH2ZFJ
   tWPTouyVd46zcZ2iakG+2HPXamXqby6TCj5ZqbXshq1pINON+fbpybVg5
   mgDhXedLvlj0pa92mUb5TdQ+YlzwqxTb1u0sbciVBraZIFhWIFPaKns8o
   ICo2aXRa55Z09yjV8QsWXaktQGzgKxanxK0V76QazG0J3FisFzFP2pH/o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="445150604"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="445150604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="689599942"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="689599942"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:29:35 -0700
Subject: [PATCH v2 00/12] Device memory prep
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Fan Ni <fan.ni@samsung.com>
Date:   Wed, 14 Jun 2023 18:29:35 -0700
Message-ID: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1 [1]:
- Drop the region API changes to focus on the cleanups as a standalone
  set
- Added "cxl: Remove leftover attribute documentation..." (Jonathan)
- Added "cxl: Fix kernel-doc warnings" due as an additional cleanup
  prompted by the above
- Undo cxl_get_gsl() clang formatting (Jonathan)
- Clarified that the need for empty strings in the sysfs capacity
  attributes can be deprecated over time.
- s/expectation/requirement/ in CXL_DEVTYPE_DEVMEM kernel-doc (Jonathan)
- s/HOSTMEM/HOSTONLYMEM/ throughout (Jonathan)
- Fix initialization of the default decoder mode, and clarify that the
  default may need to change if, for example, non-class code HDM-H
  devices show up. (Jonathan)
- Fixup cxl_probe_link() to do actual 68B/256B Flit mode detection
  (Jonathan)
- Remove the previous 256B Flit mode detection

[1]: http://lore.kernel.org/r/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com

---

v1 of this patchset included reworks of the region creation APIs to
demonstrate how and accelerator could reuse CXL core APIs to establish a
host-managed device-memory region. These miscellaneous cleanups that
preceded those reworks are now broken out into their own set.

---

Dan Williams (12):
      cxl/regs: Clarify when a 'struct cxl_register_map' is input vs output
      tools/testing/cxl: Remove unused @cxlds argument
      cxl: Fix kernel-doc warnings
      cxl: Remove leftover attribute documentation in 'struct cxl_dev_state'
      cxl/mbox: Move mailbox related driver state to its own data structure
      cxl/memdev: Make mailbox functionality optional
      cxl/port: Rename CXL_DECODER_{EXPANDER, ACCELERATOR} => {HOSTONLYMEM, DEVMEM}
      cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to CXL_DECODER_DEVMEM
      cxl/region: Manage decoder target_type at decoder-attach time
      cxl/pci: Unconditionally unmask 256B Flit errors
      cxl/port: Enumerate cxl link capabilities
      cxl/memdev: Formalize endpoint port linkage


 drivers/cxl/acpi.c           |    2 
 drivers/cxl/core/hdm.c       |   44 +++++--
 drivers/cxl/core/mbox.c      |  276 ++++++++++++++++++++++--------------------
 drivers/cxl/core/memdev.c    |   52 +++++---
 drivers/cxl/core/pci.c       |  113 +++++++++++++++++
 drivers/cxl/core/pmem.c      |    2 
 drivers/cxl/core/port.c      |   17 ++-
 drivers/cxl/core/region.c    |   14 ++
 drivers/cxl/core/regs.c      |    8 +
 drivers/cxl/cxl.h            |   17 ++-
 drivers/cxl/cxlmem.h         |  114 +++++++++++------
 drivers/cxl/cxlpci.h         |   24 +++-
 drivers/cxl/mem.c            |   10 +-
 drivers/cxl/pci.c            |  132 ++++++++++----------
 drivers/cxl/pmem.c           |   35 +++--
 drivers/cxl/port.c           |    5 +
 drivers/cxl/security.c       |   24 ++--
 tools/testing/cxl/test/cxl.c |    6 -
 tools/testing/cxl/test/mem.c |  129 ++++++++++----------
 19 files changed, 629 insertions(+), 395 deletions(-)

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
