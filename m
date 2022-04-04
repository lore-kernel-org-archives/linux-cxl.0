Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176CEC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiDDPjm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiDDPjm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:39:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45FB3A5FB
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:37:45 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXFGl4tw3z67NNV;
        Mon,  4 Apr 2022 23:35:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:37:43 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:37:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 45/45] docs/cxl: Add switch documentation
Date:   Mon, 4 Apr 2022 16:14:45 +0100
Message-ID: <20220404151445.10955-46-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Switches were already introduced, but now we support them update
the documentation to provide an example in diagram and
qemu command line parameter forms.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 88 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 9293cbf01a..abf7c1f243 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -118,8 +118,6 @@ and associated component register access via PCI bars.
 
 CXL Switch
 ~~~~~~~~~~
-Not yet implemented in QEMU.
-
 Here we consider a simple CXL switch with only a single
 virtual hierarchy. Whilst more complex devices exist, their
 visibility to a particular host is generally the same as for
@@ -137,6 +135,10 @@ BARs.  The Upstream Port has the configuration interfaces for
 the HDM decoders which route incoming memory accesses to the
 appropriate downstream port.
 
+A CXL switch is created in a similar fashion to PCI switches
+by creating an upstream port (cxl-upstream) and a number of
+downstream ports on the internal switch bus (cxl-downstream).
+
 CXL Memory Devices - Type 3
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 CXL type 3 devices use a PCI class code and are intended to be supported
@@ -240,6 +242,62 @@ Notes:
     they will take the Host Physical Addresses of accesses and map
     them to their own local Device Physical Address Space (DPA).
 
+Example topology involving a switch::
+
+  |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
+  |    __________   __________________________________   __________    |
+  |   |          | |                                  | |          |   |
+  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 1   |   |
+  |   | HB0 only | |  Configured to interleave memory | | HB1 only |   |
+  |   |          | |  memory accesses across HB0/HB1  | |          |   |
+  |   |____x_____| |__________________________________| |__________|   |
+           |             |                     |             |
+           |             |                     |             |
+           |             |                     |
+  Interleave Decoder     |                     |             |
+   Matches this HB       |                     |             |
+           \_____________|                     |_____________/
+               __________|__________      _____|_______________
+              |                     |    |                     |
+              | CXL HB 0            |    | CXL HB 1            |
+              | HB IntLv Decoders   |    | HB IntLv Decoders   |
+              | PCI/CXL Root Bus 0c |    | PCI/CXL Root Bus 0d |
+              |                     |    |                     |
+              |___x_________________|    |_____________________|
+                  |              |          |               |
+                  |
+       A HB 0 HDM Decoder
+       matches this Port
+       ___________|___
+      |  Root Port 0  |
+      |  Appears in   |
+      |  PCI topology |
+      |  As 0c:00.0   |
+      |___________x___|
+                  |
+                  |
+                  \_____________________
+                                        |
+                                        |
+            ---------------------------------------------------
+           |    Switch 0  USP as PCI 0d:00.0                   |
+           |    USP has HDM decoder which direct traffic to    |
+           |    appropiate downstream port                     |
+           |    Switch BUS appears as 0e                       |
+           |x__________________________________________________|
+            |                  |               |              |
+            |                  |               |              |
+       _____|_________   ______|______   ______|_____   ______|_______
+   (4)|     x         | |             | |            | |              |
+      | CXL Type3 0   | | CXL Type3 1 | | CXL type3 2| | CLX Type 3 3 |
+      |               | |             | |            | |              |
+      | PMEM0(Vol LSA)| | PMEM1 (...) | | PMEM2 (...)| | PMEM3 (...)  |
+      | Decoder to go | |             | |            | |              |
+      | from host PA  | | PCI 10:00.0 | | PCI 11:00.0| | PCI 12:00.0  |
+      | to device PA  | |             | |            | |              |
+      | PCI as 0f:00.0| |             | |            | |              |
+      |_______________| |_____________| |____________| |______________|
+
 Example command lines
 ---------------------
 A very simple setup with just one directly attached CXL Type 3 device::
@@ -279,6 +337,32 @@ the CXL Type3 device directly attached (no switches).::
   -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
   -cxl-fixed-memory-window targets.0=cxl.1,targets.1=cxl.2,size=4G,interleave-granularity=8k
 
+An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
+
+  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
+  ...
+  -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
+  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
+  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
+  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
+  -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa0.raw,size=256M \
+  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa1.raw,size=256M \
+  -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M \
+  -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M \
+  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
+  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
+  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
+  -device cxl-upstream,bus=root_port0,id=us0 \
+  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
+  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
+  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
+  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
+  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
+  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
+  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
+  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
+  -cxl-fixed-memory-window targets.0=cxl.1,size=4G,interleave-granularity=4k
+
 Kernel Configuration Options
 ----------------------------
 
-- 
2.32.0

