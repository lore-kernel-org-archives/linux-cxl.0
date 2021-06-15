Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C3C48BE5
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Jun 2021 23:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534E66128C
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Jun 2021 23:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFOXUM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Jun 2021 19:20:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:9172 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhFOXUM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 15 Jun 2021 19:20:12 -0400
IronPort-SDR: fS336A95WiDAHWa1jNp8a+MW33pmEeNWB5LuIpx3yZd9sEec+b523H3nhj5kqlK3JsnzEs4jwn
 +BCoWBlxS1mA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206120242"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="206120242"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 16:18:06 -0700
IronPort-SDR: 7CS7bSGFCR2P7DxJ8Xv6xbM7B/H/KkOXT1XRPdPL6IOALDFZnwsRK74XUOvF/vVzDm9eFTTgHl
 kyua522vK3wA==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="484649160"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 16:18:06 -0700
Subject: [PATCH v2 0/5] cxl/pmem: Add core infrastructure for PMEM support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Tue, 15 Jun 2021 16:18:06 -0700
Message-ID: <162379908663.2993820.16543025953842049041.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1 [1]:
- cleanup @flush determination in unregister_nvb() (Jonathan)
- cleanup online_nvdimm_bus() to return a status code (Jonathan)
- drop unnecessary header includes (Jonathan)
- drop unused cxl_nvdimm driver data (Jonathan)
- rename the bus to be unregistered as @victim_bus in
  cxl_nvb_update_state() (Jonathan)
- miscellaneous cleanups and pick up reviewed-by's (Jonathan)

---

CXL Memory Expander devices (CXL 2.0 Type-3) support persistent memory
in addition to volatile memory expansion. The most significant changes
this requires of the existing LIBNVDIMM infrastructure, compared to what
was needed to support ACPI NFIT defined PMEM, is the ability to
dynamically provision regions in addition to namespaces, and a formal
model for hotplug.

Before region provisioning can be added the CXL enabling needs to
enumerate "nvdimm" devices on a CXL nvdimm-bus. This is modeled as a
CXL-nvdimm-bridge device (bridging CXL to nvdimm) and an associated
driver to activate and deactivate that bus-bridge. Once the bridge is
registered it scans for CXL nvdimm devices registered by endpoints.  The
CXL core bus is used as a rendezvous for nvdimm bridges and endpoints
allowing them to be registered and enabled in any order.

At the end of this series the ndctl utility can see CXL nvdimm resources
just like any other nvdimm bus.

    # ndctl list -BDiu -b CXL
    {
      "provider":"CXL",
      "dev":"ndbus1",
      "dimms":[
        { 
          "dev":"nmem1",
          "state":"disabled"
        },
        { 
          "dev":"nmem0",
          "state":"disabled"
        }
      ]
    }

Follow-on patches extend the nvdimm core label support for CXL region
and namespace labels. For now just add the machinery to register the
bus and nvdimm base objects.

---

Dan Williams (5):
      cxl/core: Add cxl-bus driver infrastructure
      cxl/pmem: Add initial infrastructure for pmem support
      libnvdimm: Export nvdimm shutdown helper, nvdimm_delete()
      libnvdimm: Drop unused device power management support
      cxl/pmem: Register 'pmem' / cxl_nvdimm devices


 drivers/cxl/Kconfig        |   13 ++
 drivers/cxl/Makefile       |    2 
 drivers/cxl/acpi.c         |   37 ++++++
 drivers/cxl/core.c         |  280 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h          |   56 +++++++++
 drivers/cxl/mem.h          |    1 
 drivers/cxl/pci.c          |   23 +++-
 drivers/cxl/pmem.c         |  230 ++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/bus.c       |   64 ++++++----
 drivers/nvdimm/dimm_devs.c |   18 +++
 include/linux/libnvdimm.h  |    1 
 11 files changed, 694 insertions(+), 31 deletions(-)
 create mode 100644 drivers/cxl/pmem.c

base-commit: 87815ee9d0060a91bdf18266e42837a9adb5972e
