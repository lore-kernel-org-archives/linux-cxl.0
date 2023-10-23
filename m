Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475051CF80
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBBCCC
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 09:08:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDg4G1GDyz6JB9n;
	Tue, 24 Oct 2023 00:04:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:08:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
	<gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 00/17] QEMU: CXL mailbox rework and features (Part 1)
Date: Mon, 23 Oct 2023 17:07:49 +0100
Message-ID: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

v2:
 - To make this easier to merge, shuffle patches so that the MCTP over I2C
   transport can be in a later patch set once the prerequisites are in
   place.
 - Various fixes identified by tightening up and expanding the test code
   http://gitlab.com/jic23/cxl-fmapi-tests
   Instructions on how to use this can also be found in that repository.
 - Expanded command support so that each CCI can support a more
   representative command set (variable length payloads in both directions).
   Note we are not yet at the point of having implemented the required
   commands, let alone all the optional ones. Adding all those commands in
   an initial command set would have been far to large to review.
 - A few changes (mostly in comments and patch descriptions) reflecting
   answers to CXL specification queries.

Based-on: [PULL v3 00/62] virtio,pc,pci: features, cleanups
Based-on: [PATCH v5 0/5] hw/cxl: Line length reduction and related

Based-on: Message-ID: cover.1697966402.git.mst@redhat.com
Based-on: Message-ID: 20231023140210.3089-1-Jonathan.Cameron@huawei.com

I haven't picked up Gregory's tags as I've made a lot of changes and
as such he may want to retest the niagara support on this.
Similarly I've dropped some of Fan Ni's tags due to changes in particular
patches.

Updated v1 message:

I've been carrying most of this series on our CXL staging tree
https://gitlab.com/jic23/qemu for some time and a lot of more recent
work around Multi Head Devices and Dynamic Capacity that we need for
Linux kernel enabling are backed up behind it. Hence I reorganized my
queue to try and land this before other less 'central' features such
as CXL PMUs and arm/virt support.

This series is focused on enabling the Fabric Management aspects of
CXL to enable orchestration and tooling development and also
to enable testing of related kernel features.

Features:
1. Rework the Component Command Interface (CCI) implementation to extract
   generic parts from the existing CXL Primary Mailbox (in PCI BAR
   space).
2. Add CXL Switch Mailbox CCI function support. This CXL r3.0 feature
   enables an in band PCI path to control switch configuration.
   It is basically a CXL primary mailbox in a separate PCI function.
   On many systems this would be wired to a BMC, but as it is a normal
   PCI function we can make it an option for an emulated host providing
   us with a useful interface for testing some fabric management
   features of CXL. In particular this will be useful for tunneling
   Fabric Management commands to Type 3 memory devices (via
   MCTP over PCI VDM)
3. The afore mentioned tunneling support. Note this exercises most of
   the paths that will also be used by the CXL FMAPI/Device MCTP over
   I2C series when posted.
4. A set of example commands to explore how to get access to various
   information. Additional commands will be added in future series.
   This one is big enough already!  One or two bits are made up for now.
   Fidelity may therefore improve in future patch sets.
5. Davidlohr's work on background operations (only for the CXL type 3
   primary mailbox for now. This wasn't directly related to the above
   series but was based on the early rework and is a simple feature.
   Background support for the Switch Mailbox CCI is left for future
   series.

A typical Qemu command line snippet for testing these...

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
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k
 

Davidlohr Bueso (3):
  hw/cxl/mbox: Add support for background operations
  hw/cxl/mbox: Wire up interrupts for background completion
  hw/cxl: Add support for device sanitation

Gregory Price (1):
  hw/cxl/type3: Cleanup multiple CXL_TYPE3() calls in read/write
    functions

Jonathan Cameron (13):
  hw/cxl/mbox: Pull the payload out of struct cxl_cmd and make instances
    constant
  hw/cxl/mbox: Split mailbox command payload into separate input and
    output
  hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState
  hw/cxl/mbox: Generalize the CCI command processing
  hw/pci-bridge/cxl_upstream: Move defintion of device to header.
  hw/cxl: Add a switch mailbox CCI function
  hw/cxl/mbox: Add Information and Status / Identify command
  hw/cxl/mbox: Add Physical Switch Identify command.
  hw/pci-bridge/cxl_downstream: Set default link width and link speed
  hw/cxl: Implement Physical Ports status retrieval
  hw/cxl/mbox: Add Get Background Operation Status Command
  hw/cxl: Add dummy security state get
  hw/cxl: Add tunneled command support to mailbox for switch cci.

 include/hw/cxl/cxl.h                      |    6 +
 include/hw/cxl/cxl_component.h            |    3 +-
 include/hw/cxl/cxl_device.h               |  104 ++-
 include/hw/pci-bridge/cxl_upstream_port.h |   19 +
 hw/cxl/cxl-device-utils.c                 |  132 ++-
 hw/cxl/cxl-events.c                       |    2 +-
 hw/cxl/cxl-mailbox-utils.c                | 1035 ++++++++++++++++++---
 hw/cxl/switch-mailbox-cci.c               |  111 +++
 hw/mem/cxl_type3.c                        |   32 +-
 hw/pci-bridge/cxl_downstream.c            |   18 +-
 hw/pci-bridge/cxl_upstream.c              |   11 +-
 hw/cxl/meson.build                        |    1 +
 12 files changed, 1289 insertions(+), 185 deletions(-)
 create mode 100644 include/hw/pci-bridge/cxl_upstream_port.h
 create mode 100644 hw/cxl/switch-mailbox-cci.c

-- 
2.39.2

