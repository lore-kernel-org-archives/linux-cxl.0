Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46318C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJKVT4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJKVTz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:19:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C21B9D1
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:19:53 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z18so9792722qvn.6
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sINKuKOEiCIa2vTfT03+2MwDHadp410OQVmZv4nahEQ=;
        b=JS6ro4eUzOk5m8PvhdpkI8lEQazk4kTsWazJK/19fHWcvoFvPqEQ9g/MsEbN3GSO1t
         7LleBBuov8J0It2JsFh/80VOc7dmAhTQ/x5CfZjBwOQcrJe9AazjwsRNO5eAr/7jNc4B
         y/RvNxKv5G1wtCQS9XwYLwWO+oPI6wkrv2/kNCzdLIo3MtCSgoqTQDCs6Kv6ZjYCmsnO
         rNXO/8qtY52Ip2pdfRgUYw72K6TB3Rroayp5nCXAHjPze9rMuimyGUhGYDB0KvzIS6P2
         aQcNZClR7d7Mp3bX9hWXj7wg5AifIrd4d7/yLtbKWp0yJcrqs8skoQ0f0N0SWmHD8F+b
         CivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sINKuKOEiCIa2vTfT03+2MwDHadp410OQVmZv4nahEQ=;
        b=fVBEmz87l6LjbvL4i07GbyorN5k4wRi9Dd71Ge4olDq95gMA4J0nVg1Ux1dEfNjBQe
         D1c7eNaBy7NqiV53tuyqFmI1g/KcrVaEIBUFbKy8ZI30L3smu2cgB0pqmA7Gzk0X4aBO
         T3E+Rlvu94aURMmsMo6DA6Melmo9IF9LwtAkyFvjytpn3EfOeLBbQF6vf5cAOti6U+px
         Ee6XBioELRUcAATKGTZd/eO7eAjbYYQ0tdX39IPhjWGHclZZ7s68UDLG7jOWXjBoAxIX
         w+c7AR8NE5fxhR6OF9rGuU8Gq0NVlD62o0B7Aa+AUj4hJixuqvvxCOcpO8b8ZAvMYjhl
         lWjQ==
X-Gm-Message-State: ACrzQf093RXR+KgH9moR9j3Bk0lCKJz3W1zFfeIiTj4IeRbxMPYaSOWF
        Io7lepAqyXxZApj7VjQytQ==
X-Google-Smtp-Source: AMsMyM6xWK8SW1sM8jvBB7Dboe/AwAeyLQA71qPNTgf5hzfxjiqGycnQBoUoYzVPLczCY0lLZdqK1g==
X-Received: by 2002:ad4:5e85:0:b0:4b1:ab8f:41d6 with SMTP id jl5-20020ad45e85000000b004b1ab8f41d6mr20799887qvb.73.1665523192821;
        Tue, 11 Oct 2022 14:19:52 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b8f4ade2c9sm14493164qkp.19.2022.10.11.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:19:52 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 0/5] Multi-Region and Volatile Memory support for CXL Type-3 Devices
Date:   Tue, 11 Oct 2022 17:19:11 -0400
Message-Id: <20221011211916.117552-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Summary of Changes:
1) Correction of PCI_CLASS from STORAGE_EXPRESS to MEMORY_CXL on init
2) Add CXL_CAPACITY_MULTIPLIER definition to replace magic numbers
3) Refactor CDAT DSMAS Initialization for multi-region initialization
4) Multi-Region and Volatile Memory support for CXL Type-3 Devices
5) Test and Documentation updates

Developed with input from Jonathan Cameron and Davidloh Bueso.

This series brings 2 features to CXL Type-3 Devices:
    1) Volatile Memory Region support
    2) Multi-Region support (1 Volatile, 1 Persistent)

In this series we implement multi-region and volatile region support
through 6 major changes to CXL devices
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
       according to the mapping described in #4
    6) cxl-mailbox has been updated to report the respective size of
       volatile and persistent memory regions

CXL Spec (3.0) Section 8.2.9.8.2.0 - Get Partition Info
  Active Volatile Memory
    The device shall provide this volatile capacity starting at DPA 0
  Active Persistent Memory
    The device shall provide this persistent capacity starting at the
    DPA immediately following the volatile capacity

Partitioning of Persistent Memory regions may be supported on following
patch sets.

Submitted as an extention to the CDAT emulation because the CDAT DSMAS
entry concerns memory mapping and is required to successfully map memory
regions correctly in bios/efi.

Gregory Price (5):
  hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
  hw/cxl: Add CXL_CAPACITY_MULTIPLIER definition
  hw/mem/cxl_type: Generalize CDATDsmas initialization for Memory
    Regions
  hw/cxl: Multi-Region CXL Type-3 Devices (Volatile and Persistent)
  cxl: update tests and documentation for new cxl properties

 docs/system/devices/cxl.rst |  53 ++++-
 hw/cxl/cxl-mailbox-utils.c  |  23 +-
 hw/mem/cxl_type3.c          | 449 +++++++++++++++++++++++-------------
 include/hw/cxl/cxl_device.h |  11 +-
 tests/qtest/cxl-test.c      |  81 ++++++-
 5 files changed, 416 insertions(+), 201 deletions(-)

-- 
2.37.3

