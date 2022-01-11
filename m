Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD8C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jan 2022 22:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiAKWtW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346647AbiAKWtV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jan 2022 17:49:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6110C061751
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jan 2022 14:49:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso8083431pjo.5
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jan 2022 14:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=W11G8KOKO0fe1jEMu72qehVZONI87KeyD8+Vm5Xf76U=;
        b=0JxaCMJ1GyV8z331bQf2eZSF9nbkko60u09Jj/RK4b4X8Z9NMX1pg09y0uwtIB8GLr
         auuDdG8RncHOGCb7+qIb8SxUtg9Inxfwq2/FcFrItisxZRMZgcxyOZ0G6T99HrnWsuBQ
         k6FJykIPYsaNoCkbUnPHoAWimQSscJSLjb6i+qOQ7QScRzqTWThC8ydPExfG5Fdk1R/T
         1r/tdrdNgXS33b4NthDIix8KJIsrXphJ1NBGatTT/dmngGwnBWzvFbgoCACNaCXfLS79
         uCnfYlTKAYojz7W5uBkQPxlHv478EpMmLZP1LNIKQ58ZVbxo+rEBudvJa4diSvRIvn2h
         YRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=W11G8KOKO0fe1jEMu72qehVZONI87KeyD8+Vm5Xf76U=;
        b=bH8YDlqUSDglp1gHzos0yZh9/Ox7JDOyMffsMWkRXRSqpCo4S88zACFyHcbVOYqdik
         ONOol+XYP7FrB2WMH59HgqmX8tDf304TTcV1z91XrAXOT7UH6JnjItgg82yaS1QCRi+8
         vGBxOWCUM3kkH775a69zcXaUbJKHT574Jk4+e5ML9KWfPyHeimfpOLOxRVZISBl7DQCv
         NxcS34R22saicAsnobAlyv4lxfvf23hEp9whVANIGIp9svkICP2kpgwwsydXOW9eWNVp
         reAqitBMsMqUtoxGYxZgACVd1EN7wBOjHEfCNUvNS7x5cHFNfUI44euKuYXRWhYkawmu
         H+sQ==
X-Gm-Message-State: AOAM5338eJxWbTE8xH3qgAIOf0TTJUZdgGALDq95tWPxB3gdmuuypfyn
        fdNcgxwwrJrFX9v9hJ9MF6WaTKmzU5eqWQwpBhXrFA==
X-Google-Smtp-Source: ABdhPJxGZpEtTNJNY8srJCMQx1uA1lWF7NpqUotUHbEwy5YC9/+Xwh7r4cHpRs7imbRArXjCsHhKGB4n1PjRv1viREw=
X-Received: by 2002:a17:902:8f8f:b0:14a:766:67f1 with SMTP id
 z15-20020a1709028f8f00b0014a076667f1mr6600855plo.34.1641941360403; Tue, 11
 Jan 2022 14:49:20 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Jan 2022 14:49:09 -0800
Message-ID: <CAPcyv4j0NfC4RKr=VU6yUKrqVRKdAer9YeSezRctpp-k31iAzA@mail.gmail.com>
Subject: [GIT PULL] Compute Express Link for 5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.17

...to receive the CXL update for v5.17. The highlight is initial
support for CXL memory hotplug. The static NUMA node (ACPI SRAT
Physical Address to Proximity Domain) information known to platform
firmware is extended to support the potential performance-class /
memory-target nodes dynamically created from available CXL memory
device capacity.

New unit test infrastructure is added for validating health
information payloads.

Fixes to module reload stress and stack usage from exposure in -next
are included. A symbol rename and some other miscellaneous fixups are
included as well.

This has been in -next for several weeks with no reported issues / conflicts.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.17

for you to fetch changes up to be185c2988b48db65348d94168c793bdbc8d23c3:

  cxl/core: Remove cxld_const_init in cxl_decoder_alloc() (2022-01-04
17:29:31 -0800)

----------------------------------------------------------------
cxl for 5.17

- Rework ACPI sub-table infrastructure to optionally be used outside of
  __init scenarios and use it for CEDT.CFMWS sub-table parsing.
- Add support for extending num_possible_nodes by the potential hotplug
  CXL memory ranges
- Extend tools/testing/cxl with mock memory device health information
- Fix a module-reload workqueue race
- Fix excessive stack-frame usage
- Rename the driver context data structure from "cxl_mem" since that
  name collides with a proposed driver name
- Use EXPORT_SYMBOL_NS_GPL instead of -DDEFAULT_SYMBOL_NAMESPACE at
  build time

----------------------------------------------------------------
Alison Schofield (1):
      ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT

Dan Williams (8):
      cxl/pmem: Fix reference counting for delayed work
      cxl/core: Convert to EXPORT_SYMBOL_NS_GPL
      ACPI: Keep sub-table parsing infrastructure available for modules
      ACPI: Teach ACPI table parsing about the CEDT header format
      ACPI: Add a context argument for table parsing handlers
      cxl/acpi: Convert CFMWS parsing to ACPI sub-table helpers
      cxl/test: Mock acpi_table_parse_cedt()
      cxl/pmem: Fix module reload vs workqueue state

Ira Weiny (3):
      cxl/mbox: Remove bad comment
      cxl/memdev: Change cxl_mem to a more descriptive name
      cxl/memdev: Remove unused cxlmd field

Nathan Chancellor (1):
      cxl/core: Remove cxld_const_init in cxl_decoder_alloc()

Vishal Verma (1):
      tools/testing/cxl: add mock output for the GET_HEALTH_INFO command

 drivers/acpi/Kconfig          |   3 +
 drivers/acpi/numa/srat.c      |  59 ++++++++++-
 drivers/acpi/tables.c         |  87 ++++++++++++----
 drivers/cxl/Kconfig           |   1 +
 drivers/cxl/acpi.c            | 237 ++++++++++++++++--------------------------
 drivers/cxl/core/Makefile     |   2 +-
 drivers/cxl/core/bus.c        |  26 +++--
 drivers/cxl/core/mbox.c       | 186 ++++++++++++++++-----------------
 drivers/cxl/core/memdev.c     |  55 +++++-----
 drivers/cxl/core/pmem.c       |  20 ++--
 drivers/cxl/core/regs.c       |   8 +-
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/cxlmem.h          |  37 ++++---
 drivers/cxl/pci.c             | 120 ++++++++++-----------
 drivers/cxl/pmem.c            |  85 ++++++++++-----
 include/linux/acpi.h          |  34 ++++--
 tools/testing/cxl/Kbuild      |   3 +-
 tools/testing/cxl/test/cxl.c  |  68 ++++++++----
 tools/testing/cxl/test/mem.c  |  99 +++++++++++++-----
 tools/testing/cxl/test/mock.c |  30 ++----
 tools/testing/cxl/test/mock.h |   6 +-
 21 files changed, 675 insertions(+), 501 deletions(-)
