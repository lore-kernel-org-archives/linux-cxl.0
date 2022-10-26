Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E367DECDFA1
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 00:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJZAse (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 20:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJZAsc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 20:48:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F614DFB43
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 17:48:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s17so9482285qkj.12
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 17:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pRJ+Cja9hGKvP9Uv81zKjO1XrsOT/gV10dj8HPGULI=;
        b=OUHzed6BTa1Vii+0mF+dyAQPkqwQz9PUyKz+jFraAJaz4Hlxa7WCTfOya5IHrXdMqQ
         7y3RGAK/5x6lOppqxoGsJbDFmbBcPXvqv3Y+mjO/FuIDxKXUwq257dINXNW7nmI8iW3j
         TQEQ0inBOEQYRsr4heEoCXskUHM2aY+PKSz2VXwKjdnc3oOsQ7V004oy7hJhvNGVRj3X
         HNOMbNubbe4U+cgWu2MN6kJzIiIC+ZMKyMJGAi5ALcOXuYGhiz0uefjnEhUTfXSZy5t5
         GJrNwMa3PPqBeE1a1Vs80syUSdLxzohFUK1dMBlbbr+7sTiw4gpKTSDtEqRWcV+m7t5g
         fvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pRJ+Cja9hGKvP9Uv81zKjO1XrsOT/gV10dj8HPGULI=;
        b=DlPRBKUHQguB7Ilg58TtMkR/Ym4L1at36OuSYxq9tiPLXKaSUqUxPZ1e/mOtaAJwOT
         I+ZsyzntzrEGuK+8/TN5BodcgEQM3/6Hc82xAo+opkPlBEf5wL7t0B6ncPx/ZOw7HVco
         fmWnT7mYffE2Rp7682z2fx2GPARGddcgLDJM7/H57EVqGZJZ9ZcwxMgRlre3+bLOyM5y
         d369VtUhu6DeUo3xO8zjRcbF5nA8cIKLrpfXe2H7ikoQ+mVv4/KW9yGepLnK6qqtm8Ic
         vvgN8vD3NicAID/a0gmeoQ8lL95qfWVKCtpE3UxAzcphRE0G0DATFdP7W+THK9tuRT9u
         RN3A==
X-Gm-Message-State: ACrzQf0rXbXN5Q+3bjIAb9TJ36ldSfXNKK4a1bXA62jTo8oQVikYV7ws
        DXrODWS7nO+mp7z1hZnwDA==
X-Google-Smtp-Source: AMsMyM7/Q/kn4Ts0Em/8Uuw1vWpdkIYCyjwK4MQvuKnFzD3/UIcjSbYjIIFMYVBxnj909hHuPIZBeQ==
X-Received: by 2002:a05:620a:c4f:b0:6cf:33cd:2bc9 with SMTP id u15-20020a05620a0c4f00b006cf33cd2bc9mr29455547qki.99.1666745310325;
        Tue, 25 Oct 2022 17:48:30 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id j15-20020ac8550f000000b0039a610a04b1sm2408651qtq.37.2022.10.25.17.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 17:47:58 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
        ani@anisinha.ca, alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: [PATCH 0/4 v3] Multi-Region and Volatile Memory support for CXL Type-3 Devices
Date:   Tue, 25 Oct 2022 20:47:33 -0400
Message-Id: <20221026004737.3646-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Submitted as an extention to the multi-feature branch maintained
by Jonathan Cameron at:
https://gitlab.com/jic23/qemu/-/tree/cxl-2022-10-24 


Summary of Changes:
1) E820 CFMW Bug fix.  
2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
3) Multi-Region and Volatile Memory support for CXL Type-3 Devices
4) CXL Type-3 SRAT Generation when NUMA node is attached to memdev


Regarding the E820 fix
  * This bugfix is required for memory regions to work on x86
  * input from Dan Williams and others suggest that E820 entry for
    the CFMW should not exist, as it is expected to be dynamically
    assigned at runtime.  If this entry exists, it instead blocks
    region creation by nature of the memory region being marked as
    reserved.

Regarding Multi-Region and Volatile Memory
  * Developed with input from Jonathan Cameron and Davidlohr Bueso.

Regarding SRAT Generation for Type-3 Devices
  * Co-Developed by Davidlohr Bueso.  Built from his base patch and
    extended to work with both volatile and persistent regions.
  * This can be used to demonstrate static type-3 device mapping and
    testing numa-access to type-3 device memory regions.


This series brings 3 features to CXL Type-3 Devices:
    1) Volatile Memory Region support
    2) Multi-Region support (1 Volatile, 1 Persistent)
    3) (optional) SRAT Entry generation for type-3 device regions

In this series we implement multi-region and volatile region support
through 7 major changes to CXL devices
    1) The HostMemoryBackend [hostmem] has been replaced by two
       [hostvmem] and [hostpmem] to store volatile and persistent
       memory respectively
    2) The single AddressSpace has been replaced by two AddressSpaces
       [hostvmem_as] and [hostpmem_as] to map respective memdevs.
    3) Each memory region size and total region are stored separately
    4) The CDAT and DVSEC memory map entries have been updated:
       a) if vmem is present, vmem is mapped at DPA(0)
       b) if pmem is present
          i)  and vmem is present, pmem is mapped at DPA(vmem->size)
          ii) else, pmem is mapped at DPA(0)
       c) partitioning of pmem is not supported in this patch set but
          has been discussed and this design should suffice.
    5) Read/Write functions have been updated to access AddressSpaces
       according to the mapping described in #4
    6) cxl-mailbox has been updated to report the respective size of
       volatile and persistent memory regions
    7) SRAT entries may optionally be generated by manually assigning
       memdevs to a cpuless numa node

To support the Device Physical Address (DPA) Mapping decisions, see
CXL Spec (3.0) Section 8.2.9.8.2.0 - Get Partition Info:
  Active Volatile Memory
    The device shall provide this volatile capacity starting at DPA 0
  Active Persistent Memory
    The device shall provide this persistent capacity starting at the
    DPA immediately following the volatile capacity

Partitioning of Persistent Memory regions may be supported on
following patch sets.


Gregory Price (4):
  hw/i386/pc.c: CXL Fixed Memory Window should not reserve e820 in bios
  hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
  hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
  hw/acpi/cxl.c: Fill in SRAT for vmem/pmem if NUMA node is assigned

 docs/system/devices/cxl.rst |  74 ++++++++--
 hw/acpi/cxl.c               |  67 +++++++++
 hw/cxl/cxl-mailbox-utils.c  |  23 +--
 hw/i386/acpi-build.c        |   4 +
 hw/i386/pc.c                |   2 -
 hw/mem/cxl_type3.c          | 274 +++++++++++++++++++++++++++---------
 include/hw/acpi/cxl.h       |   1 +
 include/hw/cxl/cxl_device.h |  11 +-
 tests/qtest/cxl-test.c      | 111 +++++++++++----
 9 files changed, 443 insertions(+), 124 deletions(-)

-- 
2.37.3

