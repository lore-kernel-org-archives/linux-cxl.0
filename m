Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB53C7EE23
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjFDXbk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFDXbk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:31:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD34AC
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921499; x=1717457499;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NdgSszNxPAoIDiPnhg4c0SahyCVo6SQMipK5vT871dc=;
  b=b5zJo7hhh+rxiQdO6MtPf+HcKY/c+C8Zm6pBSuS4Bo0Yi4/q4gZk9l6z
   m84aBysuLxFqW4AOROuqFMrUakBwyVfiIaNKqzBj5Qa0oW+lpRekPJS4q
   Xt+LUR3GVBrGv1KhScG8tU/kQNiqdvDD8rpaJqm25Bes3kx3SljPCo04e
   cTMmbFd/MGuWEXi7WF8XuUNja76BWJMqC47q8Ec+YcwtsCpdmDi8PZZbp
   BlSSbi7YKT2YIPYcgkz2wT2pIL8BrkKOrPnqnez17z7DnXeAoSVQYD131
   xSuASnFyVdQVVzFUdXtI+QrIgU/AAJRIXme7UH3wqxN/m9TWfMK3cAC9h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="335860233"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335860233"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="708466066"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="708466066"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:31:38 -0700
Subject: [PATCH 00/19] cxl: Device memory setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:31:37 -0700
Message-ID: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

There are 2 models for implementing CXL memory. To date the CXL enabling
has been focused on the common class-device case (Type-3). The
class-code mandates the implementation of standard mechanisms like the
mailbox and mandatory commands. The other model (Type-2) is
implementation specific memory typically associated with local device
memory for an accelerator. Start the support for Type-2 and take the
opportunity to better prepare the CXL core for "a la carte" enabling of
optional CXL features.

Now, to date there has not been any engagement on the list for an
accelerator driver that wants to reuse the CXL core, but I think it is
worth moving ahead with these patches for the following reasons:

1/ The refactoring of region creation is needed by Persistent Memory
   support where the kernel needs to create regions from labels, not sysfs
   input.

2/ The 'struct cxl_dev_state' object carries infrastructure that is
   optional outside of CXL memory-device class-code devices. That makes it
   difficult to even start the discussion with accelerator driver authors
   that want to evaluate what pieces of the CXL core are suitable to reuse.

3/ The example type-2 driver in cxl_test protects against
   type-3-exclusive assumptions from leaking back into the code base.

In other words it is difficult to start the "type-2" discussion when the
kernel is ~1500 lines of change from the baseline such a driver might
need, and the cleanups make the code more maintainable independent of an
immediate non-test user.

The first 9 patches are general cleanups, the last 10 are focused on
refactoring region creation in support of driver-instantiated CXL memory
regions.

---

Dan Williams (19):
      cxl/regs: Clarify when a 'struct cxl_register_map' is input vs output
      tools/testing/cxl: Remove unused @cxlds argument
      cxl/mbox: Move mailbox related driver state to its own data structure
      cxl/memdev: Make mailbox functionality optional
      cxl/port: Rename CXL_DECODER_{EXPANDER,ACCELERATOR} => {HOSTMEM,DEVMEM}
      cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to CXL_DECODER_DEVMEM
      cxl/region: Manage decoder target_type at decoder-attach time
      cxl/port: Enumerate flit mode capability
      cxl/memdev: Formalize endpoint port linkage
      cxl/memdev: Indicate probe deferral
      cxl/region: Factor out construct_region_{begin,end} and drop_region() for reuse
      cxl/region: Factor out interleave ways setup
      cxl/region: Factor out interleave granularity setup
      cxl/region: Clarify locking requirements of cxl_region_attach()
      cxl/region: Specify host-only vs device memory at region creation time
      cxl/hdm: Define a driver interface for DPA allocation
      cxl/region: Define a driver interface for HPA free space enumeration
      cxl/region: Define a driver interface for region creation
      tools/testing/cxl: Emulate a CXL accelerator with local memory


 drivers/cxl/acpi.c           |    2 
 drivers/cxl/core/hdm.c       |  164 +++++++++++++---
 drivers/cxl/core/mbox.c      |  277 ++++++++++++++-------------
 drivers/cxl/core/memdev.c    |  108 +++++++++-
 drivers/cxl/core/pci.c       |   84 ++++++++
 drivers/cxl/core/pmem.c      |    2 
 drivers/cxl/core/port.c      |   19 +-
 drivers/cxl/core/region.c    |  437 ++++++++++++++++++++++++++++++++++++------
 drivers/cxl/core/regs.c      |    8 -
 drivers/cxl/cxl.h            |   21 ++
 drivers/cxl/cxlmem.h         |  124 ++++++++----
 drivers/cxl/cxlpci.h         |   25 ++
 drivers/cxl/mem.c            |   17 +-
 drivers/cxl/pci.c            |  114 ++++++-----
 drivers/cxl/pmem.c           |   35 ++-
 drivers/cxl/port.c           |    5 
 drivers/cxl/security.c       |   24 +-
 tools/testing/cxl/test/cxl.c |   20 ++
 tools/testing/cxl/test/mem.c |  214 ++++++++++++++-------
 19 files changed, 1245 insertions(+), 455 deletions(-)

base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
