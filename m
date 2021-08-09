Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2DEC4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E7560EB5
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Aug 2021 22:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhHIW2J (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Aug 2021 18:28:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:52952 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233660AbhHIW2J (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 9 Aug 2021 18:28:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="195062384"
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="195062384"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:27:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,308,1620716400"; 
   d="scan'208";a="421627000"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 15:27:47 -0700
Subject: [PATCH 00/23] cxl_test: Enable CXL Topology and UAPI regression
 tests
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        nvdimm@lists.linux.dev, Jonathan.Cameron@huawei.com,
        ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com
Date:   Mon, 09 Aug 2021 15:27:47 -0700
Message-ID: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As mentioned in patch 20 in this series the response of upstream QEMU
community to CXL device emulation has been underwhelming to date. Even
if that picked up it still results in a situation where new driver
features and new test capabilities for those features are split across
multiple repositories.

The "nfit_test" approach of mocking up platform resources via an
external test module continues to yield positive results catching
regressions early and often. Repeat that success with a "cxl_test"
module to inject custom crafted topologies and command responses into
the CXL subsystem's sysfs and ioctl UAPIs.

The first target for cxl_test to verify is the integration of CXL with
LIBNVDIMM and the new support for the CXL namespace label + region-label
format. The first 11 patches introduce support for the new label format.

The next 9 patches rework the CXL PCI driver and to move more common
infrastructure into the core for the unit test environment to reuse. The
largest change here is disconnecting the mailbox command processing
infrastructure from the PCI specific transport. The unit test
environment replaces the PCI transport with a custom backend with mocked
responses to command requests.

Patch 20 introduces just enough mocked functionality for the cxl_acpi
driver to load against cxl_test resources. Patch 21 fixes the first bug
discovered by this framework, namely that HDM decoder target list maps
were not being filled out.

Finally patches 22 and 23 introduce a cxl_test representation of memory
expander devices. In this initial implementation these memory expander
targets implement just enough command support to pass the basic driver
init sequence and enable label command passthrough to LIBNVDIMM.

The topology of cxl_test includes:
- (4) platform fixed memory windows. One each of a x1-volatile,
  x4-volatile, x1-persistent, and x4-persistent.
- (4) Host bridges each with (2) root ports
- (8) CXL memory expanders, one for each root port
- Each memory expander device supports the GET_SUPPORTED_LOGS, GET_LOG,
  IDENTIFY, GET_LSA, and SET_LSA commands.

Going forward the expectation is that where possible new UAPI visible
subsystem functionality comes with cxl_test emulation of the same.

The build process for cxl_test is:

    make M=tools/testing/cxl
    make M=tools/testing/cxl modules_install

The implementation methodology of the test module is the same as
nfit_test where the bulk of the emulation comes from replacing symbols
that cxl_acpi and the cxl_core import with mocked implementation of
those symbols. See the "--wrap=" lines in tools/testing/cxl/Kbuild. Some
symbols need to be replaced, but are local to the modules like
match_add_root_ports(). In those cases the local symbol is marked __weak
with a strong implementation coming from tools/testing/cxl/. The goal
being to be minimally invasive to production code paths.

---

Dan Williams (23):
      libnvdimm/labels: Introduce getters for namespace label fields
      libnvdimm/labels: Add isetcookie validation helper
      libnvdimm/labels: Introduce label setter helpers
      libnvdimm/labels: Add a checksum calculation helper
      libnvdimm/labels: Add blk isetcookie set / validation helpers
      libnvdimm/labels: Add blk special cases for nlabel and position helpers
      libnvdimm/labels: Add type-guid helpers
      libnvdimm/labels: Add claim class helpers
      libnvdimm/labels: Add address-abstraction uuid definitions
      libnvdimm/labels: Add uuid helpers
      libnvdimm/labels: Introduce CXL labels
      cxl/pci: Make 'struct cxl_mem' device type generic
      cxl/mbox: Introduce the mbox_send operation
      cxl/mbox: Move mailbox and other non-PCI specific infrastructure to the core
      cxl/pci: Use module_pci_driver
      cxl/mbox: Convert 'enabled_cmds' to DECLARE_BITMAP
      cxl/mbox: Add exclusive kernel command support
      cxl/pmem: Translate NVDIMM label commands to CXL label commands
      cxl/pmem: Add support for multiple nvdimm-bridge objects
      tools/testing/cxl: Introduce a mocked-up CXL port hierarchy
      cxl/bus: Populate the target list at decoder create
      cxl/mbox: Move command definitions to common location
      tools/testing/cxl: Introduce a mock memory device + driver


 Documentation/driver-api/cxl/memory-devices.rst |    3 
 drivers/cxl/acpi.c                              |   65 +
 drivers/cxl/core/Makefile                       |    1 
 drivers/cxl/core/bus.c                          |   69 +-
 drivers/cxl/core/core.h                         |    8 
 drivers/cxl/core/mbox.c                         |  796 +++++++++++++++++
 drivers/cxl/core/memdev.c                       |   84 ++
 drivers/cxl/core/pmem.c                         |   32 +
 drivers/cxl/cxl.h                               |   35 -
 drivers/cxl/cxlmem.h                            |  186 ++++
 drivers/cxl/pci.c                               | 1053 +----------------------
 drivers/cxl/pmem.c                              |  162 +++-
 drivers/nvdimm/btt.c                            |   11 
 drivers/nvdimm/btt.h                            |    4 
 drivers/nvdimm/btt_devs.c                       |   12 
 drivers/nvdimm/core.c                           |   40 -
 drivers/nvdimm/label.c                          |  354 +++++---
 drivers/nvdimm/label.h                          |   96 +-
 drivers/nvdimm/namespace_devs.c                 |  194 ++--
 drivers/nvdimm/nd-core.h                        |    5 
 drivers/nvdimm/nd.h                             |  263 ++++++
 drivers/nvdimm/pfn_devs.c                       |    2 
 include/linux/nd.h                              |    4 
 tools/testing/cxl/Kbuild                        |   29 +
 tools/testing/cxl/mock_acpi.c                   |  105 ++
 tools/testing/cxl/mock_pmem.c                   |   24 +
 tools/testing/cxl/test/Kbuild                   |   10 
 tools/testing/cxl/test/cxl.c                    |  587 +++++++++++++
 tools/testing/cxl/test/mem.c                    |  255 ++++++
 tools/testing/cxl/test/mock.c                   |  155 +++
 tools/testing/cxl/test/mock.h                   |   27 +
 31 files changed, 3234 insertions(+), 1437 deletions(-)
 create mode 100644 drivers/cxl/core/mbox.c
 create mode 100644 tools/testing/cxl/Kbuild
 create mode 100644 tools/testing/cxl/mock_acpi.c
 create mode 100644 tools/testing/cxl/mock_pmem.c
 create mode 100644 tools/testing/cxl/test/Kbuild
 create mode 100644 tools/testing/cxl/test/cxl.c
 create mode 100644 tools/testing/cxl/test/mem.c
 create mode 100644 tools/testing/cxl/test/mock.c
 create mode 100644 tools/testing/cxl/test/mock.h

base-commit: 427832674f6e2413c21ca2271ec945a720608ff2

(cxl.git#pending as of August 9th, 2021)
