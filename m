Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110DFEB64DA
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Jul 2023 09:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjGRJZ4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Jul 2023 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjGRJZs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Jul 2023 05:25:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12C186
        for <linux-cxl@vger.kernel.org>; Tue, 18 Jul 2023 02:25:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4tly62nLz6J6jy;
        Tue, 18 Jul 2023 17:23:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 10:25:40 +0100
Date:   Tue, 18 Jul 2023 10:25:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Shesha Bhushan Sreenivasamurthy" <sheshas@marvell.com>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v3 0/4] CXL: Standalone switch CCI driver
Message-ID: <20230718102539.00005111@Huawei.com>
In-Reply-To: <20230717162557.8625-1-Jonathan.Cameron@huawei.com>
References: <20230717162557.8625-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 17 Jul 2023 17:25:53 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

Fixed Cc for our tracking mailbox (linuxarm@huawei.com)
+ changed Slava's address as other one bouncing.

> RFC v3 changes:
> - Rebase
> - Break out the CXL mailbox infrastructure to allow reuse.
> - Cleaner separation of the switch cci driver from the type 3 pci driver.
> - Introduction of rough tunneling support.
> 
> Note this is a rough and ready RFC rather than a formal proposal.
> I'm sharing it at this stage to provide a test path for the QEMU
> rework that enables emulation of the various different types of
> CCI (PCI Mailbox / MCTP over I2C / Tunneled versions of each).
> There are open questions from earlier versions around how we manage
> the security of these. To a certain extent we wouldn't expect
> to often see a switch-cci connected to a CXL host (except when
> emulating), but we should probably not assume that.
> 
> I would like feedback on the basic form of the refactoring.
> Doing the rebase this time was painful so I'd rather not have that
> pain too often in the future.
> 
> CXL rev 3.0 introduced the option for a PCI function, intended to sit on an
> upstream port of a CXL switch.  This function provides a mailbox
> interface similar to that seen on CXL type 3 devices. However, the
> command set is mostly different and intended for Fabric management.
> Note however that as we add support for multi headed devices (MHDs)
> a subset of commands will be available on selected MHD type 3 mailboxes.
> (tunnelling DCD commands for example)
> 
> See: CXL rev 3.0
> 7.2.9 Switch Mailbox CCI
> 8.1.13 Switch Malibox CCI Configuration Space Layout
> 8.2.8.6 Switch Mailbox CCI capability 
> 
> It is probably relatively unusual that a typical host of CXL devices
> will have access to the one of these devices, in many cases they will
> be on a port connected to a BMC or similar. There are a few use cases
> where the host might be in charge of the configuration.
> 
> These are very convenient for testing in conjunction with the QEMU
> emulation though so far CXL switch and type 3 emulation is in QEMU
> is not complex enough to make these particular interesting.
> 
> This initial support provides only a few commands but I'm sending it
> out as an RFC to get some input on how we should refactor the CXL core
> code to support these devices that use some of the provide functionality.
> 
> Example command line based on CXL QEMU emulation branch at
> https://gitlab.com/jic23/qemu cxl-2023-07-17
> 
> qemu-system-aarch64 -M virt,nvdimm=on,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
>  ...
>  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
>  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=256M,align=256M \
>  -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
>  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
>  -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
>  -device cxl-upstream,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
>  -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
>  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>  -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
>  -device cxl-type3,bus=swport1,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
>  -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k
> 
> Really hacky test program:
> 
> //Testswitch.c
> #include <linux/types.h>
> #include <stdint.h>
> #include <sys/ioctl.h>
> #include <stdio.h>
> #include <fcntl.h>
> #include <stdlib.h>
> #define __user
> #include "cxl_mem.h" /* include/uapi/linux/cxl_mem.h */
> 
> /* Move to appropriate header later */
> struct cxl_cmd_infostat_identify_rsp {
>   uint16_t pcie_vid;
>   uint16_t pcie_did;
>   uint16_t pcie_subsys_vid;
>   uint16_t pcie_subsys_id;
>   uint64_t sn;
>   uint8_t max_message_size;
>   uint8_t component_type;
> };
> 
> struct cxl_cmd_infostat_get_bg_cmd_sts_rsp { 
>   uint8_t status;
>   uint8_t rsvd;
>   uint16_t opcode;
>   uint16_t returncode;
>   uint16_t vendor_ext_status;
> };
> 
> struct cxl_cmd_identify_switch_device_rsp {
>   uint8_t ingress_port_id;
>   uint8_t rsvd;
>   uint8_t num_physical_ports;
>   uint8_t num_vcs;
>   uint8_t active_port_bm[0x20];
>   uint8_t vcs_bm[0x20];
>   uint16_t total_num_vPPBs;
>   uint16_t num_bound_vPPBs;
>   uint8_t num_hdm_decoders;
> } __attribute__((packed));
> 
> struct cci_message {
>   uint8_t message_cat;
>   uint8_t tag;
>   uint8_t resv;
>   uint8_t command;
>   uint8_t command_set;
>   uint8_t pl_length[3];
>   uint16_t ret_code;
>   uint16_t vendor_ext;
>   uint8_t payload[];
> };
> 
> struct cxl_cmd_tunnel_command_req {
>   uint8_t id;
>   uint8_t target_type;
>   #define TUNNEL_TARGET_TYPE_PORT_OR_LD  0
>   #define TUNNEL_TARGET_TYPE_LD_POOL_CCI 1
>   uint16_t command_size;
>   struct cci_message message;
> };
> 
> struct cxl_cmd_tunnel_command_resp {
>   uint16_t length;
>   uint16_t resv;
>   struct cci_message message;
> };
> 
> 
> int main()
> {
>   struct cxl_send_command cmd = {};
>   struct cxl_cmd_infostat_identify_rsp is_identify;
>   struct cxl_cmd_identify_switch_device_rsp switch_identify;
>   struct cxl_cmd_infostat_get_bg_cmd_sts_rsp bg_cmd_status;
>   struct cxl_cmd_tunnel_command_req *tunnel_req;
>   struct cxl_cmd_tunnel_command_resp *tunnel_resp;
>   int fd;
>   int rc, i;
>   int tun_cmd_size, tun_resp_size;
> 
>   printf("Starting\n");
>   fd = open("/dev/cxl/swcci0", O_RDWR);
>   if (fd < 0) {
>     printf("could not open file\n");
>     return 0;
>   }
>   cmd.id = CXL_MEM_COMMAND_ID_RAW;
>   cmd.id = CXL_MEM_COMMAND_ID_INFO_STAT_IDENTIFY;
>   cmd.out.size = sizeof(is_identify);
>   cmd.out.payload = (__u64)&is_identify;
> 
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>   if (rc) {
>     printf("rc %d\n", rc);
>     if (rc < 0)
>       return rc;
>   } 
> 
>   printf("Identify on switch:\n");
>   printf("VID:0x%04x DID:0x%04x\n", is_identify.pcie_vid, is_identify.pcie_did);
>   printf("Subsys: VID:0x%04x DID:0x%04x\n", is_identify.pcie_subsys_vid, is_identify.pcie_subsys_id);
> 
>   cmd.id = CXL_MEM_COMMAND_ID_GET_BG_CMD_STATUS;
>   cmd.out.size = sizeof(bg_cmd_status);
>   cmd.out.payload = (__u64)&bg_cmd_status;
> 
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>   if (rc) {
>     printf("rc %d\n", rc);
>     if (rc < 0)
>       return rc;
>   }
> 
>   cmd.id = CXL_MEM_COMMAND_ID_IDENTIFY_SWITCH_DEVICE;
>   cmd.out.size = sizeof(switch_identify);
>   cmd.out.payload = (__u64)&switch_identify;
> 
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>   if (rc) {
>     printf("rc %d\n", rc);
>     if (rc < 0)
>       return rc;
>   }
> 
>   printf("Switch indent ingress=%#x #ports=%d\n",
> 	 switch_identify.ingress_port_id,
> 	 switch_identify.num_physical_ports);
>   for (i = 0; i < sizeof(switch_identify.active_port_bm); i++) {
>     int j;
>     for (j = 0; j < 8; j++) {
>       if (switch_identify.active_port_bm[i] & 1 << j) {
> 	printf("Port %x active\n", i * 8 + j);
>       }
>     }
>   }
> 
>   tun_cmd_size = sizeof(*tunnel_req);
>   tunnel_req = malloc(tun_cmd_size);
>   tun_resp_size = sizeof(*tunnel_resp) + sizeof(struct cxl_cmd_infostat_identify_rsp);
>   tunnel_resp = malloc(tun_resp_size);
>   tunnel_req->target_type = TUNNEL_TARGET_TYPE_PORT_OR_LD;
>   tunnel_req->command_size = sizeof(tunnel_req->message);
>   tunnel_req->message.command = 0x01;
>   tunnel_req->message.command_set = 0x0; // tunnels within tunnels
>   
>   cmd.id = CXL_MEM_COMMAND_ID_TUNNEL_MANAGEMENT_COMMAND;
>   cmd.in.payload = tunnel_req;
>   cmd.in.size = tun_cmd_size;
>   cmd.out.size = tun_resp_size;
>   cmd.out.payload = tunnel_resp;
> 
>   rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>   if (rc) {
>     printf("rc from tunnel cmd is %d\n", rc);
>     if (rc < 0)
>       return rc;
>   }
>   printf("message response size %d\n", cmd.out.size);
>   {
>     struct cxl_cmd_infostat_identify_rsp *pl = (void *)tunnel_resp->message.payload;
>   	printf("Vendor id  : %04x\n", pl->pcie_vid);
> 	printf("Device id  : %04x\n", pl->pcie_did);
> 	printf("Subsys vid : %04x\n", pl->pcie_subsys_vid);
> 	printf("Subsys id  : %04x\n", pl->pcie_subsys_id);
> 
> 	switch (pl->component_type) {
> 	case 0x00:
> 		printf("Switch!\n");
> 		break;
> 	case 0x03:
> 		printf("Type3!\n");
> 		break;
> 	}
>   }  
>   return 0;	 
> }
> 
> Jonathan Cameron (4):
>   cxl: mbox: Preparatory move of functions to core/mbox.c
>   cxl: mbox: Factor out the mbox specific data for reuse in switch cci
>   PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to pci_ids.h
>   cxl/pci: Add support for stand alone CXL Switch mailbox CCI
> 
>  drivers/cxl/Kconfig          |  14 ++
>  drivers/cxl/Makefile         |   2 +
>  drivers/cxl/core/Makefile    |   1 +
>  drivers/cxl/core/core.h      |   4 +-
>  drivers/cxl/core/mbox.c      | 445 ++++++++++++++++++++++++++++-------
>  drivers/cxl/core/memdev.c    |  32 +--
>  drivers/cxl/core/port.c      |   4 +
>  drivers/cxl/core/regs.c      |  33 ++-
>  drivers/cxl/cxl.h            |   4 +-
>  drivers/cxl/cxlmbox.h        |  49 ++++
>  drivers/cxl/cxlmem.h         |  41 ++--
>  drivers/cxl/pci.c            | 430 ++++++++++-----------------------
>  drivers/cxl/pmem.c           |   6 +-
>  drivers/cxl/security.c       |  13 +-
>  drivers/cxl/switch-cci.c     | 182 ++++++++++++++
>  include/linux/pci_ids.h      |   1 +
>  include/uapi/linux/cxl_mem.h |   4 +
>  17 files changed, 821 insertions(+), 444 deletions(-)
>  create mode 100644 drivers/cxl/cxlmbox.h
>  create mode 100644 drivers/cxl/switch-cci.c
> 

