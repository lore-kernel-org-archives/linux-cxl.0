Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B05C43217
	for <linux-cxl@archiver.kernel.org>; Mon, 28 Nov 2022 15:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiK1PCN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiK1PCM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Nov 2022 10:02:12 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E8A1FD
        for <linux-cxl@vger.kernel.org>; Mon, 28 Nov 2022 07:02:11 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3353971pje.5
        for <linux-cxl@vger.kernel.org>; Mon, 28 Nov 2022 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSiDagc7OCOKkLbBACL9tcNTTqBs4oCCRei4cYayvkw=;
        b=bxe7g1HMI2EE3o5gbKfBcq1Zu+ylD7TFNLWqrQXxBiqcurE5/2x/c+wQ0pXkbUZNP+
         I5KXCQlA49AqoOYkpIefi2LL6P/Tm9rNN7z7bq/s6RwvWC7vrgShlb3yHWcj4zHRkFAk
         o0a77cHS146+L849xFSZPq0cmm++VMM7flNwCtSs2iyxoQ8bPx1PMAaZHkuXKd0eHx+w
         w5rSavTvlp/AXlv+UU+K5+TgZcQ6DY3NTE8bA3kln9SPSC2tSuTfjyQoRXdwuNsbgg4r
         cn2b/e61m43WehADZvQ51M9RhBI7DJwYbBrMG/HdPE68IM8jeXt6nu6uukdIb0++pvVA
         5EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSiDagc7OCOKkLbBACL9tcNTTqBs4oCCRei4cYayvkw=;
        b=022MX8Z8ZkuVMR3+kShLD//Ti6cjdfxBiC8R2OCwh0l40wcNMjrX5sVP4sAnU62EUz
         5GOL+QKzb/NYZiYQHIZpnoViqczYLp2ig9oZNYzZSKnNJ3tuFqHCooMhxFk6tiEDOLOb
         hbRzgl3TaU9Z9WeVd3XHtlPxR1Kleka1CEurKcsrXBVGKf9vybCb+hqGZFPwsJCLqsxj
         JVZiHg05DCzTuw5PwMIVnTXSdhXomW6ASfGCSAV5OPrb1Uez70FneS1JnGSNag4EwRnY
         +9u3e9hmmkzqzTw7pE7wdPT+GJYnys1Z4BA9J/ao+5tEKLrkGi/o5s1z9I5s8teqfkBp
         BTjQ==
X-Gm-Message-State: ANoB5pkIge5xyDzwIr8jGmOaMukuzrHtLtg0oqjVZhWoN2zBUiikY0ct
        hO5ZfrEU34WT5rn5sFbHnxbel+YUK0kB
X-Google-Smtp-Source: AA0mqf7mR6X2y+/1a55RM670ezMwFDfK4EAwc6sQ2ei/BKWgHagSx8UwAWqAhA98KzQb+1/pOuXL0w==
X-Received: by 2002:a17:902:d58d:b0:188:d6e1:b82b with SMTP id k13-20020a170902d58d00b00188d6e1b82bmr32406922plh.146.1669647730422;
        Mon, 28 Nov 2022 07:02:10 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001886ff82680sm8997928plh.127.2022.11.28.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:02:09 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: [RFC v4 0/3] CXL Type-3 Volatile Memory Support
Date:   Mon, 28 Nov 2022 10:01:54 -0500
Message-Id: <20221128150157.97724-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes in this version
    * Minor bug fixes spotted by J. Cameron
    * Whitespace changes to docs and tests moved ahead of patch
    * Address Space access to pmem region is now as(dpa-vmem_len)

Note: Submitted as an extention to the CDAT emulation because the CDAT DSMAS
entry concerns memory mapping and is required to successfully map memory
regions correctly in bios/efi.

See https://gitlab.com/jic23/qemu/-/tree/cxl-2022-11-17 for the base of
this patch set.



This patches provides 2 features to the CXL Type-3 Device:
    1) Volatile Memory Region Support
    2) Multi-Region support (1 Volatile, 1 Persistent)

Summary of Changes per-commit:
1) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
2) Whitespace updates to docs and tests
3) Refactor CDAT DSMAS Initialization for multi-region initialization
   Multi-Region and Volatile Memory support for CXL Type-3 Devices
   Test and Documentation updates

The final patch in this series makes 6 major changes to the type-3
device in order to implement multi-region and volatile region support
    1) The HostMemoryBackend [hostmem] has been replaced by two
       [hostvmem] and [hostpmem] to store volatile and persistent memory
       respectively
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
       according to the mapping described in #4.  Access to the
       persistent address space is calculated by (dpa-vmem_len)
    6) cxl-mailbox has been updated to report the respective size of
       volatile and persistent memory regions

CXL Spec (3.0) Section 8.2.9.8.2.0 - Get Partition Info
  Active Volatile Memory
    The device shall provide this volatile capacity starting at DPA 0
  Active Persistent Memory
    The device shall provide this persistent capacity starting at the
    DPA immediately following the volatile capacity

Partitioning of Persistent Memory regions may be supported on following
patch sets, but is not supported in this version.


Gregory Price (3):
  hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
  tests/qtest/cxl-test: whitespace, line ending cleanup
  hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)

 docs/system/devices/cxl.rst |  49 ++++--
 hw/cxl/cxl-mailbox-utils.c  |  24 +--
 hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++---------
 include/hw/cxl/cxl_device.h |  11 +-
 tests/qtest/cxl-test.c      | 161 ++++++++++++++------
 5 files changed, 395 insertions(+), 142 deletions(-)

-- 
2.37.3

