Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24161C4332F
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiKHRZk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiKHRZ1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 12:25:27 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD84C24F
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 09:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667928322; x=1699464322;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oVsrek1weL8Zd0gArqBas298JV5gJHlcCWw3jN4c660=;
  b=buEH0TvQAsvU58YwZt/wUwpm5mMQrJY4CqEdum+sfRTgSzfIRq7yF8oz
   64lacuigRJLg8Bj4tZk8mioQOo8zW6IT9YBgGPwyL0BySEFeVgK8N/W6I
   bqZYNdhj5e7jDcNSTVZhw8/SwY9o93pjkAP4+w77dSKIz5UhCs1BPTIH/
   zv30iUPh1E97L/VhCEwhHTT/WKtAKK9Y7lFx99G2nZWJAvJigvGi0M8em
   XCGZdSBavOux1v9lnq+m8nYwwYkahfim/60JPd4e5lvP63blK0WRqS1cD
   Brzg2YJa2+JMw2tZs4mcVE1vrWf7i1NbkIry60N/WdKge45Zy+4hHkaWH
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291144155"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="291144155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:25:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="742038694"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="742038694"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 09:25:21 -0800
Subject: [PATCH v3 00/18] Introduce security commands for CXL pmem device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date:   Tue, 08 Nov 2022 10:25:21 -0700
Message-ID: <166792815961.3767969.2621677491424623673.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This series adds the support for "Persistent Memory Data-at-rest Security"
block of command set for the CXL Memory Devices. The enabling is done
through the nvdimm_security_ops as the operations are very similar to the
same operations that the persistent memory devices through NFIT provider
support. This enabling does not include the security pass-through commands
nor the Santize commands.

Under the nvdimm_security_ops, this patch series will enable get_flags(),
freeze(), change_key(), unlock(), disable(), and erase(). The disable() API
does not support disabling of the master passphrase. To maintain
established user ABI through the sysfs attribute "security", the "disable"
command is left untouched and a new "disable_master" command is introduced
with a new disable_master() API call for the nvdimm_security_ops().

This series does not include plumbing to directly handle the security
commands through cxl control util. The enabled security commands will still
go through ndctl tool with this enabling.

The series has dependency on the cache invalidate patch from Davidlohr [1].

[1]: https://lore.kernel.org/linux-cxl/166698148737.3132474.5901874516011784201.stgit@dwillia2-xfh.jf.intel.com/

v3:
- Change all spec reference to v3. (Jonathan)
- Remove errant commit log in patch 1. (Davidlohr)
- Change return to -EINVAL for cpu_cache_has_invalidate_memregion() error. (Davidlohr)
- Fix mock_freeze_security() to be spec compliant. (Jonathan)
- Change OP_PASSPHRASE_ERASE to OP_PASSPHRASE_SECURE_ERASE. (Jonathan)
- Fix mock_passphrase_erase to be spec compliant. (Jonathan)
- Change password retry limit handling to helper function.
- Add ABI documentation to new sysfs attribs. (Jonathan)
- Have security_lock_show() emit 0 or 1 instead of "locked or "unlocked". (Jonathan)
- Set pdev->dev.groups instead of using device_add_groups(). (Jonathan)
- Add context to NVDIMM_SECURITY_TEST on possible side effects. (Jonathan)

v2:
- Rebased against Davidlohr's memregion flush call
- Remove SECURITY Kconfig and merge with PMEM (Davidlohr & Jonathan)
- Remove inclusion of ndctl.h from security.c (Davidlohr)
- Return errno and leave out return_code for error cases not in spec for mock device (Jonathan)
- Add comment for using NVDIMM_PASSPHRASE_LEN (Jonathan)
- Put 'struct cxl_set_pass' on the stack instead of kmalloc (Jonathan)
- Directly return in mock_set_passphrase() when done. (Jonathan)
- Tie user interface change commenting for passphrase disable. (Jonathan)
- Pass passphrase directly in command and remove copy. (Jonathan)
- Remove state check to enable first time passphrase set in mock device.
- Fix missing ptr assignment in mock secure erase
- Tested against cxl_test with new cxl security test.

---

Dave Jiang (18):
      cxl/pmem: Introduce nvdimm_security_ops with ->get_flags() operation
      tools/testing/cxl: Add "Get Security State" opcode support
      cxl/pmem: Add "Set Passphrase" security command support
      tools/testing/cxl: Add "Set Passphrase" opcode support
      cxl/pmem: Add Disable Passphrase security command support
      tools/testing/cxl: Add "Disable" security opcode support
      cxl/pmem: Add "Freeze Security State" security command support
      tools/testing/cxl: Add "Freeze Security State" security opcode support
      cxl/pmem: Add "Unlock" security command support
      tools/testing/cxl: Add "Unlock" security opcode support
      cxl/pmem: Add "Passphrase Secure Erase" security command support
      tools/testing/cxl: Add "passphrase secure erase" opcode support
      nvdimm/cxl/pmem: Add support for master passphrase disable security command
      cxl/pmem: add id attribute to CXL based nvdimm
      tools/testing/cxl: add mechanism to lock mem device for testing
      cxl/pmem: add provider name to cxl pmem dimm attribute group
      libnvdimm: Introduce CONFIG_NVDIMM_SECURITY_TEST flag
      cxl: add dimm_id support for __nvdimm_create()


 Documentation/ABI/testing/sysfs-bus-nvdimm |  12 +
 drivers/cxl/Makefile                       |   2 +-
 drivers/cxl/core/mbox.c                    |   6 +
 drivers/cxl/cxlmem.h                       |  44 +++
 drivers/cxl/pci.c                          |   4 +
 drivers/cxl/pmem.c                         |  44 ++-
 drivers/cxl/security.c                     | 186 +++++++++++++
 drivers/nvdimm/Kconfig                     |  13 +
 drivers/nvdimm/dimm_devs.c                 |   9 +-
 drivers/nvdimm/security.c                  |  37 ++-
 include/linux/libnvdimm.h                  |   2 +
 include/uapi/linux/cxl_mem.h               |   6 +
 tools/testing/cxl/Kbuild                   |   1 +
 tools/testing/cxl/test/cxl.c               |  58 ++++
 tools/testing/cxl/test/mem.c               | 303 +++++++++++++++++++++
 tools/testing/cxl/test/mem_pdata.h         |  16 ++
 tools/testing/nvdimm/Kbuild                |   1 -
 tools/testing/nvdimm/dimm_devs.c           |  30 --
 18 files changed, 732 insertions(+), 42 deletions(-)
 create mode 100644 drivers/cxl/security.c
 create mode 100644 tools/testing/cxl/test/mem_pdata.h
 delete mode 100644 tools/testing/nvdimm/dimm_devs.c

--

