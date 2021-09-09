Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C64C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 00:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DDF610F8
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 00:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348785AbhIIAwH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Sep 2021 20:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348847AbhIIAwG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Sep 2021 20:52:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135DC061575
        for <linux-cxl@vger.kernel.org>; Wed,  8 Sep 2021 17:50:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k17so2392773pls.0
        for <linux-cxl@vger.kernel.org>; Wed, 08 Sep 2021 17:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=st0iJaf29MZrtalRYvkDnoTyG1q3n/sls+xpkp/si68=;
        b=k6RK5RMAWNZC0C2lACPqYAzo8ATiv7OnlyHAUTPRB0KiZlE0OAanjtSbu9dpV5RhIv
         MdD/nxbwh6h/W1bd8o7eKZpjj+CtB2wyod4ycW97HGx2tf9r8KUjP5wjYx6rUa1aAs+M
         ZE5qHLgG5/rN0hxcwfbu0hrN+ArVIqrmFFcE29QFYM62nCknCp61MWdsNDXiKr7DDy45
         4orWzEQ0e99Cl5F2IzuNZEyRN5D4FmvER9nNNmRPbR5GeyzAgCS7aW1Yo2JGYi4ZYZKG
         nOKy2ujezlgoCbt9tkrqVV2Md6XvTW8joqp5spDMRDWrWcBZPxsVfGlDPzgHj8ANlEp2
         YAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=st0iJaf29MZrtalRYvkDnoTyG1q3n/sls+xpkp/si68=;
        b=YIiBq89GYVTZt0rm8n81FcPWed7t4ympOJgtMFPjoP/96mIjTPVPB4cyePGMs82j7q
         3Jo+qoti7gEMRUPs9QYOPYUVdzM+aKKs7NLSlkHGkP+RN8LaUWlc3aSzdIksaZmIjklQ
         6G72OFmJetwYGUGcX4ACA1AWDHaL+V6hpbHPGGtHshGaGNeI1jB6MHyE+o1ngo/VET93
         O25pj3jIZuAWSZ2KA8ieAnlrORqe+9BVDPjDV9K88EISsnVMYf9gRkDel30w7bUCVn0k
         eB88td+3yY6v4LSKheY7u0ufBed5ni7iZuhb1MT7lQuhaL2VzLPv3plc/GeGrK4Hnh7+
         nmrQ==
X-Gm-Message-State: AOAM530W8ti6mmSMyXJ6W8oiisLPBmo/VLpHTPUG486Rq49yhY30ngZq
        fLGn4Crx2WGNhj3je4+ZPemzMZ1cmCyAoatUyGgO9GVr58/F8g==
X-Google-Smtp-Source: ABdhPJwJEDuu4qNJfcVrivy1EuQ328eYx3SxA169sGZwJwEh+lA9yQumarVbRkcy71qlz0t38c3gFPNLFhpKC3fRQ+Q=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr175834pls.89.1631148656565; Wed, 08 Sep
 2021 17:50:56 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Sep 2021 17:50:45 -0700
Message-ID: <CAPcyv4hEtOuExY1+YdKPaffBPO6A70u+01NA4EPON2s6Ut3rHw@mail.gmail.com>
Subject: [GIT PULL] Compute Express Link update for v5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.15

...to receive the cxl update for v5.15. This branch experienced some
fallout from some "just in time" review and the -Werror change. Rather
than rebase patches at the last moment the branch was simply rewound
to a stable point and the rest will wait for v5.16. Save for the top 6
fixes this has been in -next for several releases with no reported
issues (beyond the ones that caused the branch to be rewound), and the
fixes have appeared in at least one -next release.

Please pull, thanks,
Dan

---

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.15

for you to fetch changes up to 2b922a9d064f8e86b53b04f5819917b7a04142ed:

  cxl/registers: Fix Documentation warning (2021-09-07 11:39:02 -0700)

----------------------------------------------------------------
cxl for v5.15

- Fix detection of CXL host bridges to filter out disabled ACPI0016
  devices in the ACPI DSDT.

- Fix kernel lockdown integration to disable raw commands when raw PCI
  access is disabled.

- Fix a broken debug message.

- Add support for "Get Partition Info". I.e. enumerate the split between
  volatile and persistent capacity on bi-modal CXL memory expanders.

- Re-factor the core by subject area. This is a work in progress.

- Prepare libnvdimm to understand CXL labels in addition to EFI labels.
  This is a work in progress.

----------------------------------------------------------------
Alison Schofield (1):
      cxl/acpi: Do not add DSDT disabled ACPI0016 host bridge ports

Ben Widawsky (6):
      cxl: Move cxl_core to new directory
      cxl/core: Improve CXL core kernel docs
      cxl/core: Move memdev management to core
      cxl/pci: Ignore unknown register block types
      cxl/pci: Simplify register setup
      cxl/uapi: Fix defined but not used warnings

Dan Williams (14):
      cxl/core: Move pmem functionality
      cxl/core: Move register mapping infrastructure
      cxl/pci: Introduce cdevm_file_operations
      libnvdimm/labels: Introduce getters for namespace label fields
      libnvdimm/labels: Add isetcookie validation helper
      libnvdimm/labels: Introduce label setter helpers
      libnvdimm/labels: Add a checksum calculation helper
      libnvdimm/labels: Add blk isetcookie set / validation helpers
      libnvdimm/labels: Add blk special cases for nlabel and position helpers
      libnvdimm/labels: Add type-guid helpers
      libnvdimm/labels: Add claim class helpers
      cxl/pci: Fix lockdown level
      cxl/pmem: Fix Documentation warning
      cxl/registers: Fix Documentation warning

Ira Weiny (3):
      cxl/pci: Store memory capacity values
      cxl/mem: Account for partitionable space in ram/pmem ranges
      cxl/mem: Adjust ram/pmem range to represent DPA ranges

Li Qiang (Johnny Li) (1):
      cxl/pci: Fix debug message in cxl_probe_regs()

 Documentation/driver-api/cxl/memory-devices.rst |   8 +-
 drivers/cxl/Makefile                            |   4 +-
 drivers/cxl/acpi.c                              |  12 +-
 drivers/cxl/core/Makefile                       |   8 +
 drivers/cxl/{core.c => core/bus.c}              | 464 ++----------------------
 drivers/cxl/core/core.h                         |  20 +
 drivers/cxl/core/memdev.c                       | 246 +++++++++++++
 drivers/cxl/core/pmem.c                         | 230 ++++++++++++
 drivers/cxl/core/regs.c                         | 249 +++++++++++++
 drivers/cxl/cxl.h                               |   1 -
 drivers/cxl/{mem.h => cxlmem.h}                 |  35 +-
 drivers/cxl/pci.c                               | 439 +++++++++-------------
 drivers/cxl/pci.h                               |   1 +
 drivers/cxl/pmem.c                              |   2 +-
 drivers/nvdimm/label.c                          | 256 ++++++++-----
 drivers/nvdimm/label.h                          |   1 -
 drivers/nvdimm/namespace_devs.c                 | 113 +++---
 drivers/nvdimm/nd.h                             | 150 ++++++++
 include/uapi/linux/cxl_mem.h                    |   2 +-
 19 files changed, 1352 insertions(+), 889 deletions(-)
 create mode 100644 drivers/cxl/core/Makefile
 rename drivers/cxl/{core.c => core/bus.c} (58%)
 create mode 100644 drivers/cxl/core/core.h
 create mode 100644 drivers/cxl/core/memdev.c
 create mode 100644 drivers/cxl/core/pmem.c
 create mode 100644 drivers/cxl/core/regs.c
 rename drivers/cxl/{mem.h => cxlmem.h} (71%)
