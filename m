Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C08C38A2D
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 21:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiJZVDC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiJZVDC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 17:03:02 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E853A5C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 14:03:01 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s17so11653539qkj.12
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7/73U88aWKwNDfroPuUtEdVueHFIV0vL1R64OOolus=;
        b=MLL6rHHFzlTIlFjnX45D5dWzOTzb7hjWEd9LjdjkkrHD1PRnmPagXf7TnDurZkzP+U
         R3WkGfgLWcI4nPWBgOLemAI3FG1PPLghS/ePBF9ai2JDHtHa+NAMYGoOlCdBSTyq/GVI
         VNFj6aHyV6YOEtXGOx0MFELJVxwe8BxVQ7xutdCd+QmRajvnkIs5W8UjLnwUVW9Luk4+
         i39pI6srbvm8ZEqUyi10qB0taIxmlR4gvM8Gu/npBJEjQo0lp20C4KTR3HQiBOldgJR0
         QPlDhMbteAXrd4wS85xKctWJyW5QE35aK93gLx0jeBo9p3i+r+Z25bU5IHH4F82lE1HL
         ql4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7/73U88aWKwNDfroPuUtEdVueHFIV0vL1R64OOolus=;
        b=lrPs1TXH7+io/RaiFIXFXgfcxGtP2K04RLctxU7qpVz0o0R/ApI6OjoendDwxgi+ik
         wvsXLg5gRtXVC+p9vDgq1yyb8zNBqccGpDTyV0knd3tA6PIXXB6+GuDhUhpIMJqIPTZU
         b3T0zWQ2coMP0wSUWtX4mn7OfWNqIl5dexg8ukv3olVQycLy0SoUqODs2HKNfeKcwNzd
         EHaLF/B6pMHlOprDL/JkVGI3qaHRAs/2rxWIghjtfk9N4E3PNoWcpHahpboVyMqijLIp
         vqVyGx7uEaE6cFuMwcIus/T/Y/I7IJG0T38f7hvUuVkj1u/KJFFOQ8/kUuHt5dofKXMq
         2WQA==
X-Gm-Message-State: ACrzQf24dxfHXRYqZ/sn99L0sQ35lojF7oB05dh3xBrWioQxHgFf33TJ
        8TSfjmE5Vbi8pqJq26/bygmdsG+frQ==
X-Google-Smtp-Source: AMsMyM7VyTdk/Wn3qoOTlb9Al2zqipCfyiurRTHWSirl4Cd1LBW6/x+6OhstOtIN2i9JM0/p439LrQ==
X-Received: by 2002:a05:620a:2587:b0:6cf:7ece:e1f9 with SMTP id x7-20020a05620a258700b006cf7ecee1f9mr31770925qko.182.1666818180277;
        Wed, 26 Oct 2022 14:03:00 -0700 (PDT)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id e12-20020ac8130c000000b003a4efd59754sm1325020qtj.12.2022.10.26.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:02:58 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     qemu-devel@nongnu.org
Cc:     mst@redhat.com, linux-cxl@vger.kernel.org,
        jonathan.cameron@huawei.com, dave@stgolabs.net,
        a.manzanares@samsung.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH] hw/i386/pc.c: CXL Fixed Memory Window should not reserve e820 in bios
Date:   Wed, 26 Oct 2022 16:59:13 -0400
Message-Id: <20221026205912.8579-1-gregory.price@memverge.com>
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
the CXL Fixed Memory Window:

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
index 768982ae9a..203c90fedb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1062,7 +1062,6 @@ void pc_memory_init(PCMachineState *pcms,
         hwaddr cxl_size = MiB;
 
         cxl_base = pc_get_cxl_range_start(pcms);
-        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
         cxl_resv_end = cxl_base + cxl_size;
@@ -1078,7 +1077,6 @@ void pc_memory_init(PCMachineState *pcms,
                 memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
                                       "cxl-fixed-memory-region", fw->size);
                 memory_region_add_subregion(system_memory, fw->base, &fw->mr);
-                e820_add_entry(fw->base, fw->size, E820_RESERVED);
                 cxl_fmw_base += fw->size;
                 cxl_resv_end = cxl_fmw_base;
             }
-- 
2.37.3

