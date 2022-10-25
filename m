Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CE1C04A95
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 10:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiJYKmt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJYKms (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 06:42:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C51D0FD
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 03:42:46 -0700 (PDT)
Received: from frapeml100005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MxT2T6z9kz67TN2;
        Tue, 25 Oct 2022 18:39:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 12:42:44 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:42:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <jonathan.cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: [RFC PATCH v2 0/4] CXL: Standalone switch CCI driver
Date:   Tue, 25 Oct 2022 11:42:39 +0100
Message-ID: <20221025104243.20836-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1: (thanks Slava!)
- 3 precusor patches added
    PCI Class ID added to pci_ids.h
    Refactoring to change parameters of cxl_send_cmd() to make
    it suitable for use from the new switch CCI code.
- Various fixes around error paths and tidying up (see patch 4)

CXL rev 3.0 introduced the option for a PCI function, intended to sit on an
upstream port of a CXL switch.  This function provides a mailbox
interface similar to that seen on CXL type 3 devices. However, the
command set is mostly different and intended for Fabric management.
Note however that as we add support for multi headed devices (MHDs)
a subset of commands will be available on selected MHD type 3 mailboxes.
(tunnelling DCD commands for example)

See: CXL rev 3.0
7.2.9 Switch Mailbox CCI
8.1.13 Switch Malibox CCI Configuration Space Layout
8.2.8.6 Switch Mailbox CCI capability 

It is probably relatively unusual that a typical host of CXL devices
will have access to the one of these devices, in many cases they will
be on a port connected to a BMC or similar. There are a few use cases
where the host might be in charge of the configuration.

These are very convenient for testing in conjunction with the QEMU
emulation though so far CXL switch and type 3 emulation is in QEMU
is not complex enough to make these particular interesting.

This initial support provides only a few commands but I'm sending it
out as an RFC to get some input on how we should refactor the CXL core
code to support these devices that use some of the provide functionality.

Test wise, there is emulation support on
http://gitlab.com/jic23/qemu cxl-2022-10-24 branch

Assumption for now is that the switch CCI function sits alongside
a CXL USP. A config blob along the lines of:

 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
 -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=2 \
 -device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=0,slot=3 \
 -device cxl-upstream,port=33,bus=root_port0,id=us0,multifunction=on,addr=0.0,sn=12345678 \
 -device cxl-switch-mailbox-cci,bus=root_port0,addr=0.1 \
 -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
 -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
 -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
 -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7

should create a switch with a suitable function 1 alongside the switch CCI.

Test wise, an example using the user space ioctls is given below.
Longer term this will want to be done with a suitable open source fabric
manager library / program.

#include <linux/types.h>
#include <stdint.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include "cxl_mem.h"

/* Move to appropriate header later */
struct cxl_cmd_infostat_identify_rsp {
  uint16_t pcie_vid;
  uint16_t pcie_did;
  uint16_t pcie_subsys_vid;
  uint16_t pcie_subsys_id;
  uint64_t sn;
  uint8_t max_message_size;
  uint8_t component_type;
};

struct cxl_cmd_infostat_get_bg_cmd_sts_rsp { 
  uint8_t status;
  uint8_t rsvd;
  uint16_t opcode;
  uint16_t returncode;
  uint16_t vendor_ext_status;
};

struct cxl_cmd_identify_switch_device_rsp {
  uint8_t ingress_port_id;
  uint8_t rsvd;
  uint8_t num_physical_ports;
  uint8_t num_vcs;
  uint8_t active_port_bm[0x20];
  uint8_t vcs_bm[0x20];
  uint16_t total_num_vPPBs;
  uint16_t num_bound_vPPBs;
  uint8_t num_hdm_decoders;
} __attribute__((packed));

int main()
{
  struct cxl_send_command cmd = {};
  struct cxl_cmd_infostat_identify_rsp is_identify;
  struct cxl_cmd_identify_switch_device_rsp switch_identify;
  struct cxl_cmd_infostat_get_bg_cmd_sts_rsp bg_cmd_status;
  int fd;
  int rc, i;

  fd = open("/dev/cxl/swcci0", O_RDWR);
  if (fd < 0) {
    printf("could not open file\n");
    return 0;
  }
  cmd.id = CXL_MEM_COMMAND_ID_RAW;
  cmd.id = CXL_MEM_COMMAND_ID_INFO_STAT_IDENT;
  cmd.out.size = sizeof(is_identify);
  cmd.out.payload = (__u64)&is_identify;

  rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
  if (rc) {
    printf("rc %d\n", rc);
    if (rc < 0)
      return rc;
  }

  printf("Identify on switch:\n");
  printf("VID:0x%04x DID:0x%04x\n", is_identify.pcie_vid, is_identify.pcie_did);
  printf("Subsys: VID:0x%04x DID:0x%04x\n", is_identify.pcie_subsys_vid, is_identify.pcie_subsys_id);

  cmd.id = CXL_MEM_COMMAND_ID_GET_BG_CMD_STATUS;
  cmd.out.size = sizeof(bg_cmd_status);
  cmd.out.payload = (__u64)&bg_cmd_status;

  rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
  if (rc) {
    printf("rc %d\n", rc);
    if (rc < 0)
      return rc;
  }

  cmd.id = CXL_MEM_COMMAND_ID_IDENTIFY_SWITCH_DEVICE;
  cmd.out.size = sizeof(switch_identify);
  cmd.out.payload = (__u64)&switch_identify;

  rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
  if (rc) {
    printf("rc %d\n", rc);
    if (rc < 0)
      return rc;
  }

  printf("Switch indent ingress=%#x #ports=%d\n",
	 switch_identify.ingress_port_id,
	 switch_identify.num_physical_ports);
  for (i = 0; i < sizeof(switch_identify.active_port_bm); i++) {
    int j;
    for (j = 0; j < 8; j++) {
      if (switch_identify.active_port_bm[i] & 1 << j) {
	printf("Port %x active\n", i * 8 + j);
      }
    }
  }
  
  return 0;	 
}

Jonathan Cameron (4):
  cxl/mbox: Use local cxl_device_state variable
  cxl/mbox: Change paramaters to cxl_send_cmd() to not assume a cxl
    memory device.
  PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to pci_ids.h
  cxl/pci: Add support for stand alone CXL Switch mailbox CCI

 drivers/cxl/core/Makefile     |   1 +
 drivers/cxl/core/core.h       |   6 +-
 drivers/cxl/core/mbox.c       |  12 ++-
 drivers/cxl/core/memdev.c     |   4 +-
 drivers/cxl/core/port.c       |   4 +
 drivers/cxl/core/switch-cci.c | 149 ++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h          |   3 +
 drivers/cxl/cxlpci.h          |   3 +
 drivers/cxl/cxlswitch.h       |  18 ++++
 drivers/cxl/pci.c             |  95 +++++++++++++++++++++-
 include/linux/pci_ids.h       |   1 +
 include/uapi/linux/cxl_mem.h  |   3 +
 12 files changed, 292 insertions(+), 7 deletions(-)
 create mode 100644 drivers/cxl/core/switch-cci.c
 create mode 100644 drivers/cxl/cxlswitch.h

-- 
2.37.2

