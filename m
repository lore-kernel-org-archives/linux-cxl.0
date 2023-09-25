Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2177ACE7A9B
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjIYQLf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjIYQLe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:11:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE88ACE
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:11:25 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSVT6nzcz6DBCC;
        Tue, 26 Sep 2023 00:09:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:11:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 00/19] QEMU: CXL mailbox rework and features
Date:   Mon, 25 Sep 2023 17:11:05 +0100
Message-ID: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Based on: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Based on: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended capability support
Based on: [PATCH v3 0/4] hw/cxl: Line length reduction and related
Based on: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management interface model

I'm assuming this last dependency will go via a different tree though there
is an outstanding request for tests. That equally applies to the CXL setup,
but there are lot of moving parts. I'll experiment with basic testing
of the MCTP I2C device whilst this is being reviewed.

Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913133615.29876-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230919093434.1194-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230925152258.5444-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com

I've been carrying most of this series on our CXL staging tree
https://gitlab.com/jic23/qemu for some time and a lot of more recent
work around Multi Head Devices and Dynamic Capacity that we need for
Linux kernel enabling are backed up behind it. Hence I reorganized my
queue to try and land this before other less 'central' features such
as CXL PMUs and arm/virt support.

This series is focused on enabling the Fabric Management (FM) aspects of
CXL to enable orchestration and tooling development and also to enable
testing of related kernel features. That requires some substantial
reworking of existing mailbox handling (improving a few things along
the way).

Features:
1. Rework the Component Command Interface (CCI) implementation to extract
   generic parts from the existing CXL Primary Mailbox (in PCI BAR
   space).
2. Add CXL Switch Mailbox CCI function support. This CXL r3.0 feature
   enables an in band PCI path to control switch configuration.
   It is basically a CXL primary mailbox in a separate PCI function.
   On many systems this would be wired to a BMC, but as it is a normal
   PCI function we can make it an option for an emulated host providing
   us with a useful interface for testing some Fabric Mnagement
   features of CXL. In particular this will be useful for tunneling
   Fabric Management commands to Type 3 memory devices (via
   MCTP over PCI VDM)
3. Via MCTP over I2C and the two CXL MCTP bindings (FM-API and
   Memory Device) provide an alternative control interface.
   For now this can only be used with an aspeed-i2c controller.
   (There are hacks to enable this controller on CXL host systems
    but they are not suitable for upstreaming - so in upstream
    it's either MCTP access, or inband access depending on
    machine used). This is primarily implemented to enable work
   on the very different Linux kernel interface for MCTP (network
   socket based) to the IOCTL interface for the Switch Mailbox CCI.
4. A set of example commands to explore how to get access to various
   information. Additional commands will be added in future series.
   This one is big enough already!  One or two bits are made up
   for now.  Fidelity may therefore improve in future patch sets.
5. Davidlohr's work on background operations (only for the CXL
   type 3 primary mailbox for now. This wasn't directly related
   to the above series but was based on the early rework and is a
   simple feature.  Background support for MCTP interfaces and the
   Switch Mailbox CCI is left for future series.

Note that we are currently only implement a simple fixed configuration
single VH switch. If anyone is interested in working on expanding that
to deal with the high degree of configurability of topology that
vPPBs bring then let me know.

A few areas that might be of interest to reviewers:
1) The target=XXX approach to linking the 'interfaces' up with the
   underlying CXL devices.
2) The walking of various PCIe structures and similar to fill in
   the data needed for some commands.  I'm still using some
   fake data for now, but ultimately all this stuff is probably
   discoverable.
3) Tunneling fun in the final patch.  That gives an idea of
   one of the more complex corners of the Fabric Management part
   of the CXL spec and perhaps best illustrates the reason we
   have so many CCI instances inside one device a they all require
   separate state and can present different available commands.

A typical QEMU command line snippet for testing the Switch Mailbox CCI.

 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
 -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
 -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
 -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
 -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
 -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
 -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
 -device cxl-type3,bus=swport1,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2

A snippet for testing the i2c_mctp_cxl (on a suitable aspeed machine,
or with the hacks on gitlab.com/jic23/qemu to add an aspeed controller to
i386/pc).

 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
 -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
 -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
 -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
 -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
 -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
 -device cxl-type3,bus=swport1,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2

Rather than ending up with a very long cover letter, I'll post
where to find test userspace code to talk to the switch-cci and the
i2c_mctp_cxl device + tunnel to the devices below them separately
along with pointers to the kernel series needed (for the switch
mailbox CCI).

I'll shortly push out a fresh tree including dependencies for this set
and everything we currently have on top of it at

gitlab.com/jic23/qemu cxl-2023-09-26

Davidlohr Bueso (3):
  hw/cxl/mbox: Add support for background operations
  hw/cxl/mbox: Wire up interrupts for background completion
  hw/cxl: Add support for device sanitation

Gregory Price (1):
  hw/cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write
    functions

Jonathan Cameron (15):
  hw/cxl/mbox: Pull the payload out of struct cxl_cmd and make instances
    constant
  hw/cxl/mbox: Split mailbox command payload into separate input and
    output
  hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState
  hw/cxl/mbox: Generalize the CCI command processing
  hw/pci-bridge/cxl_upstream: Move defintion of device to header.
  hw/cxl/i2c_mctp_cxl: Initial device emulation
  hw/cxl/mbox: Add Information and Status / Identify command
  docs: cxl: Add example commandline for MCTP CXL CCIs
  hw/cxl/mbox: Add Physical Switch Identify command.
  hw/cxl: Add a switch mailbox CCI function
  hw/pci-bridge/cxl_downstream: Set default link width and link speed
  hw/cxl: Implement Physical Ports status retrieval
  hw/cxl/mbox: Add Get Background Operation Status Command
  hw/cxl: Add dummy security state get
  hw/cxl: Add tunneled command support to mailbox for switch cci/mctp.

 docs/system/devices/cxl.rst               |   27 +
 include/hw/cxl/cxl.h                      |    6 +
 include/hw/cxl/cxl_component.h            |    3 +-
 include/hw/cxl/cxl_device.h               |  110 ++-
 include/hw/pci-bridge/cxl_upstream_port.h |   20 +
 hw/cxl/cxl-device-utils.c                 |  120 ++-
 hw/cxl/cxl-events.c                       |    2 +-
 hw/cxl/cxl-mailbox-utils.c                | 1038 ++++++++++++++++++---
 hw/cxl/i2c_mctp_cxl.c                     |  290 ++++++
 hw/cxl/switch-mailbox-cci.c               |  111 +++
 hw/mem/cxl_type3.c                        |   32 +-
 hw/pci-bridge/cxl_downstream.c            |   18 +-
 hw/pci-bridge/cxl_upstream.c              |   11 +-
 hw/cxl/Kconfig                            |    4 +
 hw/cxl/meson.build                        |    2 +
 15 files changed, 1609 insertions(+), 185 deletions(-)
 create mode 100644 include/hw/pci-bridge/cxl_upstream_port.h
 create mode 100644 hw/cxl/i2c_mctp_cxl.c
 create mode 100644 hw/cxl/switch-mailbox-cci.c

-- 
2.39.2

