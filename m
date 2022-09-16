Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA4ECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIPXLB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIPXK5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:10:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CDBC826
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369855; x=1694905855;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p0c6VAlE6f/jXum5X2vqqDO41Pq3X5FOlRGpuxwm1nE=;
  b=h6vFt4XILjO6nky2LH5bsafd+HxixqOANHGN0Cv3r/DgOgtICKQ5PiMG
   G151pctGryXJZxuXCmorLa25C6J8bUQiVfh5Wx1LKeEevmZ26qwpcz0Oh
   xBD8gTlzvjorx96UCLBOs3AGv99z3ibdjjwW9OGWe+rJ9bkisWt87Gnqz
   vbtr1w+VFEqbQLo1thViZyi8sMheTvWQWLFjeoIxqIg3TOFncctejt6Dq
   mL2vevQ61UHMM02Dy8kDHXXMbHsrmKd3GjvzNLWJMwQO8lmrrS16lZtkX
   olr/h/tHybZNPHuAkUR2ixHTVk7y4KqCt3Fj9r/ne3ySjmRqSrbjYbkML
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="299087682"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="299087682"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:10:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305054"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:10:54 -0700
Subject: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:10:53 -0700
Message-ID: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Series set to RFC since there's no means to test. Would like to get opinion
on whether going with using trace events as reporting mechanism is ok.

Jonathan,
We currently don't have any ways to test AER events. Do you have any plans
to support AER events via QEMU emulation?

v2:
- Convert error reporting via printk to trace events
- Drop ".rmap =" initialization (Jonathan)
- return PCI_ERS_RESULT_NEED_RESET for UE in pci_channel_io_normal (Shiju)

Add a 'struct pci_error_handlers' instance for the cxl_pci driver.
Section 8.2.4.16 "CXL RAS Capability Structure" of the CXL rev3.0
specification defines the error sources considered in this
implementation. The RAS Capability Structure defines protocol, link and
internal errors which are distinct from memory poison errors that are
conveyed via direct consumption and/or media scanning.

The errors reported by the RAS registers are categorized into
correctable and uncorrectable errors, where the uncorrectable errors are
optionally steered to either fatal or non-fatal AER events. Table 12-2 
"Device Specific Error Reporting and Nomenclature Guidelines" in the CXL
rev3.0 specification outlines that the remediation for uncorrectable errors
is a reset to recover. This matches how the Linux PCIe AER core treats
uncorrectable errors as occasions to reset the device to recover
operation.

While the specification notes "CXL Reset" or "Secondary Bus Reset" as
theoretical recovery options, they are not feasible in practice since
in-flight CXL.mem operations may not terminate and cause knock-on system
fatal events. Reset is only reliable for recovering CXL.io, it is not
reliable for recovering CXL.mem. Assuming the system survives, a reset
causes CXL.mem operation to restart from scratch.

The "ECN: Error Isolation on CXL.mem and CXL.cache" [1] document
recognizes the CXL Reset vs CXL.mem operational conflict and helps to at
least provide a mechanism for the Root Port to terminate in flight
CXL.mem operations with completions. That still poses problems in
practice if the kernel is running out of "System RAM" backed by the CXL
device and poison is used to convey the data lost to the protocol error.

Regardless of whether the reset and restart of CXL.mem operations is
feasible / successful, the logging is still useful. So, the
implementation reads, reports, and clears the status in the RAS
Capability Structure registers, and it notifies the 'struct cxl_memdev'
associated with the given PCIe endpoint to reattach to its driver over
the reset so that the HDM decoder configuration can be reconstructed.

The first half of the series reworks component register mapping so that
the cxl_pci driver can own the RAS Capability while the cxl_port driver
continues to own the HDM Decoder Capability. The last half implements
the RAS Capability Structure mapping and reporting via 'struct
pci_error_handlers'.

The reporting of error information is done through event tracing. A new
cxl_ras event is introduced to report the Uncorrectable and Correctable
errors raised by CXL. The expectation is a monitoring user daemon such as
"cxl monitor" will harvest those events and record them in a log in a
format (JSON) that's consumable by management applications..

[1]: https://www.computeexpresslink.org/spec-landing

---

Dan Williams (8):
      cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
      cxl/pci: Cleanup cxl_map_device_regs()
      cxl/pci: Kill cxl_map_regs()
      cxl/core/regs: Make cxl_map_{component, device}_regs() device generic
      cxl/port: Limit the port driver to just the HDM Decoder Capability
      cxl/pci: Prepare for mapping RAS Capability Structure
      cxl/pci: Find and map the RAS Capability Structure
      cxl/pci: Add (hopeful) error handling support

Dave Jiang (1):
      cxl/pci: add tracepoint events for CXL RAS


 drivers/cxl/core/hdm.c         |  33 ++---
 drivers/cxl/core/memdev.c      |   1 +
 drivers/cxl/core/pci.c         |   3 +-
 drivers/cxl/core/port.c        |   2 +-
 drivers/cxl/core/regs.c        | 172 +++++++++++++++-----------
 drivers/cxl/cxl.h              |  39 ++++--
 drivers/cxl/cxlmem.h           |   2 +
 drivers/cxl/cxlpci.h           |   9 --
 drivers/cxl/pci.c              | 216 +++++++++++++++++++++++++++------
 include/trace/events/cxl_ras.h | 117 ++++++++++++++++++
 10 files changed, 445 insertions(+), 149 deletions(-)
 create mode 100644 include/trace/events/cxl_ras.h

--

