Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0093FC4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Oct 2022 23:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJQXoI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Oct 2022 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiJQXoH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Oct 2022 19:44:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D584E53
        for <linux-cxl@vger.kernel.org>; Mon, 17 Oct 2022 16:44:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id i9so8401482qvo.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 Oct 2022 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sy9tv1vwouL5wVhECQge7xWZ+qNM1LObFiN/5x/fMFM=;
        b=FIri2iF5j+kvwS6svlaLz2nUebvPOpilYZ79rghjpIxUpv9wvIhQR9M78yVUsLgDzN
         tW7j+BG3oPV/a0ejDAbiq/2VuyhvfsjzEGHcOD5MQ6i+MsJon0t/LlVrd0PS5GQ5k5Sp
         ysqotUx7w/D9n9KLea2dF8Q5PWbHuwSlgHN4oeYIbVD+T0fHzTS0/s1fZD0fs4BlKV9O
         +EGyjvaaC+iyud7nmPho+MN1mCoj+drfD50YjVkTuE55nD7JoqhNy/B9DUUkKYd726SB
         NqhVyTiBnlIAbQUG5majwejJhZ0nvmgmolDOEtOk2O6e58UHlt0h4YzAW2+Iq/PqujPU
         cROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sy9tv1vwouL5wVhECQge7xWZ+qNM1LObFiN/5x/fMFM=;
        b=BDB+aKFIG3JJ0IYqgSkzhstOLc2AJ42ugdplLzMtIEuSOW6og4geyN1rZopPwXaq5a
         74yIkZylK+VvZKCT5YS5wzHQgsL8eFkXn9FB7HAsv2ZdHSV3cjZypbN4OAbdSw2kHSk8
         xq625AhbO6nWd5Zy0HsJYjJEes41wmEtpzpuo5NUR+dSq7l6d2D8zd9GbeW2iC/i3Jmi
         FnPH79fgRVD4T0QpxHuD6F4ckeve/XXVBJmo3Q8su5zpTkcrBjXAr8CmuvEOBk5l2ja+
         6BaecF7hjuHEeCTSPpnrzgJUybefy+NAv89/AZHO6HauJXIXR4vIRD9gqq03oOBFZiGN
         uEsw==
X-Gm-Message-State: ACrzQf3oZI7bUDX0ajvZAzv6I8po2V/0Zn1oBw1DBIPu3qoTFaW73hKK
        b3Q+i0qNo03fp9Du/qEXOA==
X-Google-Smtp-Source: AMsMyM4quy6AxXzTx9DblcWGeAySQBU3NbJ+ozk26GaG36plRJmcjSL3nf0X1bU37A8LksBdp+IoHg==
X-Received: by 2002:ad4:5d68:0:b0:4af:af07:580b with SMTP id fn8-20020ad45d68000000b004afaf07580bmr37946qvb.14.1666050245643;
        Mon, 17 Oct 2022 16:44:05 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id m10-20020ac8444a000000b0039b03ac2f72sm790520qtn.46.2022.10.17.16.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:44:05 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
        ani@anisinha.ca, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com
Subject: [BUG] hw/i386/pc.c: CXL Fixed Memory Window should not reserve e820 in bios
Date:   Mon, 17 Oct 2022 19:40:02 -0400
Message-Id: <20221017234001.53297-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Early-boot e820 records will be inserted by the bios/efi/early boot
software and be reported to the kernel via insert_resource.  Later, when
CXL drivers iterate through the regions again, they will insert another
resource and make the RESERVED memory area a child.

This RESERVED memory area causes the memory region to become unusable,
and as a result attempting to create memory regions with

    `cxl create-region ...`

Will fail due to the RESERVED area intersecting with the CXL window.


During boot the following traceback is observed:

0xffffffff81101650 in insert_resource_expand_to_fit ()
0xffffffff83d964c5 in e820__reserve_resources_late ()
0xffffffff83e03210 in pcibios_resource_survey ()
0xffffffff83e04f4a in pcibios_init ()

Which produces a call to reserve the CFMWS area:

(gdb) p *new
$54 = {start = 0x290000000, end = 0x2cfffffff, name = "Reserved",
       flags = 0x200, desc = 0x7, parent = 0x0, sibling = 0x0,
       child = 0x0}

Later the Kernel parses ACPI tables and reserves the exact same area as
the CXL Fixed Memory Window.  The use of `insert_resource_conflict`
retains the RESERVED region and makes it a child of the new region.

0xffffffff811016a4 in insert_resource_conflict ()
                      insert_resource ()
0xffffffff81a81389 in cxl_parse_cfmws ()
0xffffffff818c4a81 in call_handler ()
                      acpi_parse_entries_array ()

(gdb) p/x *new
$59 = {start = 0x290000000, end = 0x2cfffffff, name = "CXL Window 0",
       flags = 0x200, desc = 0x0, parent = 0x0, sibling = 0x0,
       child = 0x0}

This produces the following output in /proc/iomem:

590000000-68fffffff : CXL Window 0
  590000000-68fffffff : Reserved

This reserved area causes `get_free_mem_region()` to fail due to a check
against `__region_intersects()`.  Due to this reserved area, the
intersect check will only ever return REGION_INTERSECTS, which causes
`cxl create-region` to always fail.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/i386/pc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 566accf7e6..5bf5465a21 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1061,7 +1061,6 @@ void pc_memory_init(PCMachineState *pcms,
         hwaddr cxl_size = MiB;
 
         cxl_base = pc_get_cxl_range_start(pcms);
-        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
         cxl_resv_end = cxl_base + cxl_size;
@@ -1077,7 +1076,6 @@ void pc_memory_init(PCMachineState *pcms,
                 memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
                                       "cxl-fixed-memory-region", fw->size);
                 memory_region_add_subregion(system_memory, fw->base, &fw->mr);
-                e820_add_entry(fw->base, fw->size, E820_RESERVED);
                 cxl_fmw_base += fw->size;
                 cxl_resv_end = cxl_fmw_base;
             }
-- 
2.37.3

