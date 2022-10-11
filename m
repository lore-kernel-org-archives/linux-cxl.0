Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D9AC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJKVUg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJKVUf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:20:35 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A694F3AB
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:33 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id i9so9792731qvu.1
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J70hlX25E9ElY7Y0OLPVeghzHqgWbU0QsD3KrqAJXcA=;
        b=XEwLdU7PToSL6K/C6Da+/gEmrPiWVBKDwNnv75ttnzW7AqBPftHO58T8hEmWan8R4N
         cogE6vLVYvZhiB55FgKqjWoVjFnMgrjEbK1s+U1+hN66y4x0f1DywC6P2AJOTytG/vm4
         5/l2ZKrVZBTGMSABORBPoubISv7JXKjxDrZgfbjb/NzdaIwGxgQSOoHLlqDLgvK0bzXF
         FY2vMYfKRbo62IHK6l7tmMRnKoW4NcxFvLqbfQIYLXBveQB7T8r0Xe9Gi7hY7q6tCAQV
         BqyOGaEMcSA9gMTqaelogYOABK+AiXTACYzii3Pvx/3Cv3R0z9Vzay7Xb7NXCV6WGbkm
         pmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J70hlX25E9ElY7Y0OLPVeghzHqgWbU0QsD3KrqAJXcA=;
        b=E2Dkilu/Eu33aUTUZn5P9ZD1AMXwHKP2i1Xjc7mJFn0qrQVlpYGn+GWrRWpTnU6x0h
         289HDiRWzVJmOW/46W9K1xldNMCwS0mpA2sXX09PraEOj8k6pMcWYPZJME3GrACcw+78
         x3gm/xTUsqC7JOUEGCKnTuHmGXSaw5bJt8SbM0zKt3MJoP6Fs3UDDlPw/yVeHSagYWEu
         ClQvnYzM7ZHoBqyQTHeLw1/m//o5r/rtzyh6rgtXj0ouxAGxmo1Dpmosy0iBsYmUia+j
         k6gBhC9IFk0DpJi8/MCuMRM5Mb4Ej7rpQg0xEZnasoxM4cfY2rS32h1S9ABvB24o5qw1
         lC9Q==
X-Gm-Message-State: ACrzQf16mLMO7MR6Uf22aa8YJcwyzGl7PyrizjjokcMcctTiUjKB03Y+
        96TI96zgyugmeap5gAxsKQ==
X-Google-Smtp-Source: AMsMyM6e0/uUBi/TSGucpsZ08beHNefxsEt9v/RiauPWEaQTl6XMxfn/f6gsXAboSxfTB2QBWmXSjQ==
X-Received: by 2002:a0c:f349:0:b0:4b1:a0f5:4a2f with SMTP id e9-20020a0cf349000000b004b1a0f54a2fmr20034188qvm.112.1665523232686;
        Tue, 11 Oct 2022 14:20:32 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id y21-20020a05620a44d500b006b8f4ade2c9sm14493164qkp.19.2022.10.11.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:20:32 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     jonathan.cameron@huawei.com
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        alison.schofield@intel.com, dave@stgolabs.net,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        gregory.price@memverge.com, mst@redhat.com,
        hchkuo@avery-design.com.tw, cbrowy@avery-design.com,
        ira.weiny@intel.com
Subject: [PATCH 5/5] cxl: update tests and documentation for new cxl properties
Date:   Tue, 11 Oct 2022 17:19:16 -0400
Message-Id: <20221011211916.117552-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011211916.117552-1-gregory.price@memverge.com>
References: <20221007152156.24883-1-Jonathan.Cameron@huawei.com>
 <20221011211916.117552-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Adds explicit examples for --persistent-memdev and --volatile-memdev

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 docs/system/devices/cxl.rst | 53 ++++++++++++++++++------
 tests/qtest/cxl-test.c      | 81 +++++++++++++++++++++++++++++++------
 2 files changed, 110 insertions(+), 24 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index f25783a4ec..9e165064c8 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -300,15 +300,36 @@ Example topology involving a switch::
 
 Example command lines
 ---------------------
-A very simple setup with just one directly attached CXL Type 3 device::
+A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
 
   qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
   ...
-  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
-  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
+  -object memory-backend-file,pmem=true,id=pmem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
+  -object memory-backend-file,pmem=true,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=pmem0,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
+A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
+
+The same volatile setup may optionally include an LSA region::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  ...
+  -object memory-backend-ram,id=vmem0,share=on,size=256M \
+  -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
+  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
 A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
@@ -328,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
-  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
+  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
   -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
-  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
+  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
   -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
-  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
+  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
   -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
-  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
+  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
 
 An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
@@ -354,15 +375,23 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
   -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
   -device cxl-upstream,bus=root_port0,id=us0 \
   -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
-  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
+  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
   -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
-  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
+  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
   -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
-  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
+  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
   -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
-  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
+  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
   -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
 
+Deprecations
+------------
+
+The Type 3 device [memdev] attribute has been deprecated in favor
+of the [persistent-memdev] and [volatile-memdev] attributes. [memdev]
+will default to a persistent memory device for backward compatibility
+and is incapable of being used in combination with [persistent-memdev].
+
 Kernel Configuration Options
 ----------------------------
 
diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index f0a8a4045d..1a7a25dc53 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -34,29 +34,44 @@
                  "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
                  "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
 
-#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
+#define QEMU_T3D_DEPRECATED \
+  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
+  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
+
+#define QEMU_T3D_PMEM \
+  "-object memory-backend-file,id=m0,mem-path=%s,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-m0,lsa=lsa0,id=pmem0 "
+
+#define QEMU_T3D_VMEM \
+  "-object memory-backend-ram,id=mem0,size=256M " \
+  "-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=mem0 "
+
+#define QEMU_T3D_VMEM_LSA \
+  "-object memory-backend-ram,id=mem0,size=256M " \
+  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+  "-device cxl-type3,bus=rp0,volatile-memdev=mem0,lsa=lsa0,id=mem0 "
 
 #define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
                   "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+                  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
                   "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
                   "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
+                  "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
 
 #define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
                   "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+                  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
                   "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
                   "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
+                  "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
                   "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
                   "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
+                  "-device cxl-type3,bus=rp2,persistent-memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
                   "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
                   "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
+                  "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
 
 static void cxl_basic_hb(void)
 {
@@ -95,14 +110,53 @@ static void cxl_2root_port(void)
 }
 
 #ifdef CONFIG_POSIX
-static void cxl_t3d(void)
+static void cxl_t3d_deprecated(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_DEPRECATED,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_persistent(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+    g_autofree const char *tmpfs = NULL;
+
+    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_PMEM,
+                    tmpfs, tmpfs);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_volatile(void)
+{
+    g_autoptr(GString) cmdline = g_string_new(NULL);
+
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM);
+
+    qtest_start(cmdline->str);
+    qtest_end();
+}
+
+static void cxl_t3d_volatile_lsa(void)
 {
     g_autoptr(GString) cmdline = g_string_new(NULL);
     g_autofree const char *tmpfs = NULL;
 
     tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
 
-    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs, tmpfs);
+    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM_LSA,
+                    tmpfs);
 
     qtest_start(cmdline->str);
     qtest_end();
@@ -167,7 +221,10 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/rp", cxl_root_port);
         qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
 #ifdef CONFIG_POSIX
-        qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
+        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
+        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
+        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
+        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
         qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
         qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
                        cxl_2pxb_4rp_4t3d);
-- 
2.37.3

