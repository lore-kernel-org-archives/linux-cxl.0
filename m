Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE4C001DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGQRQw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjGQRQv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:16:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879021A5
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:16:46 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TDH74Zkz67YXJ;
        Tue, 18 Jul 2023 01:12:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:16:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 00/17] hw/cxl: hw/cxl: Generic CCI emulation support
Date:   Mon, 17 Jul 2023 18:16:29 +0100
Message-ID: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Includes addition of I2C-MCTP CCIs and tunnelling via switch-cci.

Base for this series messy, so I'd suggest the tree at
https://gitlab.com/jic23/qemu cxl-2023-07-17
which includes this series in the middle.

RFC for various reasons:
1 - I have some specification issues to figure out / query.
2 - The I2C MCTP stuff isn't upstream yet, and it may well change.
3 - The MCTP I2C controllers might be a tad controversial as currently
    hacked in :)

We have had separate PoCs for the switch CCI and MCTP-I2C, but they
shared very little of the infrastructure with the main CXL mailbox.
When looking at adding tunneling support it became clear this was
unsustainable.

Tunneling provides access the to MCTP CCIs below a given device -
initially providing emulation of a message being sent over the
Switch CCI mailbox (in band PCI mailbox in a BAR) which then routes
it as MCTP over PCIe VDM to the downstream device. In QEMU at least
the downstream device is a Type3 device below a switch downstream port.
Tunnelling is also used to access the various CCIs inside more complex
devices such as Multi Head Devices (not implemented yet!)

The particular test setup I have been using is:

qemu-system-aarch64 -M virt,nvdimm=on,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
 -kernel Image \
 -drive if=none,file=full.qcow2,format=qcow2,id=hd \
 -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd \
 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 \
 -qmp tcp:localhost:4445,server=on,wait=off \
 -device virtio-net-pci,netdev=mynet,id=bob \
 -nographic -no-reboot -append 'earlycon root=/dev/vda2 fsck.mode=skip maxcpus=4 tp_printk' \
 -monitor telnet:127.0.0.1:1234,server,nowait -bios QEMU_EFI.fd \
 -object memory-backend-ram,size=4G,id=mem0 \
 -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/t3_cxl1.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/t3_lsa1.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/t3_cxl2.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/t3_lsa2.raw,size=1M,align=1M \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
 -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
 -device cxl-upstream,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
 -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
 -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
 -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
 -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem1,lsa=cxl-lsa1,sn=3 \
 -device cxl-type3,bus=swport1,memdev=cxl-mem2,id=cxl-pmem2,lsa=cxl-lsa2,sn=4 \
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem1 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem2

Kernel side needs switch-cci driver support
https://lore.kernel.org/linux-cxl/20230717162557.8625-1-Jonathan.Cameron@huawei.com/T/#t 

A test program to poke the switch-cci is in the cover letter for that series.

For the MCTP devices:

For ACPI you need the kernel patches from:
https://lore.kernel.org/linux-cxl/20230525152203.32190-1-Jonathan.Cameron@huawei.com/T/#u
To make the aspeed i2c controller play nicely with PRP0001 based ACPI description.

Install the MCTP daemon from:
  https://github.com/CodeConstruct/mctp

Bring up and enumerate the MCTP EPs:

# Bring up the link
mctp link set mctpi2c0 up
# Assign an address to the aspeed-i2c controller
mctp addr add 50 dev mctpi2c0
# Assign a neetwork ID to the link (11)
mctp link set mctpi2c0 net 11
# Start the daemon that uses dbus for configuration.
systemctl start mctpd.service
# Assign EIDs to the EPs
busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x5
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/8 xyz.openbmc_project.MCTP.Endpoint

busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x6
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/9 xyz.openbmc_project.MCTP.Endpoint

busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x4
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/10 xyz.openbmc_project.MCTP.Endpoint

Suitable test program:

/*
 * Trivial example program to exercise QEMU FMAPI Emulation over MCTP over I2C
 */
#include <sys/socket.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "mctp.h"
#include "cxl_fmapi.h"

enum cxl_type {
	cxl_switch,
	cxl_type3,
};
static int query_cci_identify(int sd, struct sockaddr_mctp *addr, int *tag, enum cxl_type *type)
{
	struct cxl_cci_infostat_identify_resp_pl *pl;
	uint8_t buf[1024];
	struct cxl_fmapi_header *rsp_head = buf;

	int rc;
	ssize_t len;
	struct sockaddr_mctp addrrx;
	socklen_t addrlen = sizeof(addrrx);
	struct cxl_fmapi_header req = {
		.category = CXL_MCTP_CATEGORY_REQ,
		.tag = *tag++,
		.command = 1,
		.command_set = 0,
		.vendor_ext_status = 0xabcd,
	};

	printf("trying to identify\n");
	len = sendto(sd, &req, sizeof(req), 0, (struct sockaddr *)addr, sizeof(*addr));
	if (len != sizeof(req)) {
		printf("Failed to send whole request for phys switch info %d %d\n", len, sizeof(req));
		return -1;
	}

	len = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&addrrx, &addrlen);
	if (len < 0) {
		printf("Failed to receive response\n");
		return -1;
	}
	printf("length %d\n", len);
	pl = (void *)(rsp_head + 1);
	printf("Vendor id  : %04x\n", pl->vendor_id);
	printf("Device id  : %04x\n", pl->device_id);
	printf("Subsys vid : %04x\n", pl->subsys_vendor_id);
	printf("Subsys id  : %04x\n", pl->subsys_id);

	switch (pl->component_type) {
	case 0x00:
		printf("Switch!\n");
		*type = cxl_switch;
		break;
	case 0x03:
		printf("Type3!\n");
		*type = cxl_type3;
		break;
	}

	return 0;
}

static int parse_physical_switch_identify_switch_device(void *buf, size_t buf_len)
{
	struct cxl_fmapi_header *rsp_head = buf;
	struct cxl_fmapi_ident_switch_dev_resp_pl *pl = (void *)(rsp_head + 1);
	uint8_t *b;
	if (rsp_head->return_code != 0) {
		printf("Error code in response %d\n", rsp_head->return_code);
		printf("%x %x %x %x %x %x %x %x %x %x %x %x\n", ((uint8_t *)rsp_head)[0],((uint8_t *)rsp_head)[1],
			((uint8_t *)rsp_head)[2],((uint8_t *)rsp_head)[3],
			((uint8_t *)rsp_head)[4],((uint8_t *)rsp_head)[5],((uint8_t *)rsp_head)[6],
			((uint8_t *)rsp_head)[7], ((uint8_t *)rsp_head)[8], ((uint8_t *)rsp_head)[9],
			((uint8_t *)rsp_head)[10], ((uint8_t *)rsp_head)[11]);
		return -1;
	}
	printf("Num total vppb %d\n", pl->num_total_vppb);
	printf("Ports %d\n", pl->num_physical_ports);
	b = pl->active_port_bitmask;
	printf("ActivePortMask");
	for (int i = 0; i < 32; i++)
		printf("%02x", b[i]);
	printf("\n");
	return 0;
}

int query_physical_switch_info(int sd, struct sockaddr_mctp *addr, int *tag)
{
	uint8_t buf[1024];
	int rc;
	ssize_t len;
	struct sockaddr_mctp addrrx;
	socklen_t addrlen = sizeof(addrrx);
	struct cxl_fmapi_header req = {
		.category = CXL_MCTP_CATEGORY_REQ,
		.tag = *tag++,
		.command = CXL_IDENTIFY_SWITCH_DEVICE,
		.command_set = CXL_FM_API_CMD_SET_PHYSICAL_SWITCH,
		.vendor_ext_status = 0xabcd,
	};

	len = sendto(sd, &req, sizeof(req), 0, (struct sockaddr *)addr, sizeof(*addr));
	if (len != sizeof(req)) {
		printf("Failed to send whole request for phys switch info %d %d\n", len, sizeof(req));
		return -1;
	}

	len = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&addrrx, &addrlen);
	if (len < 0) {
		printf("Failed to receive response\n");
		return -1;
	}
	printf("length %d\n", len);
	rc = parse_physical_switch_identify_switch_device(buf, len);
	if (rc)
		return -1;

	return 0;
}

static int parse_phys_port_state_rsp(void * buf, size_t buf_len, struct cxl_fmapi_header *head)
{
	struct cxl_fmapi_header *rsp_head = buf;
	struct cxl_fmapi_get_phys_port_state_resp_pl *pl = (void *)(rsp_head + 1);
	uint32_t pl_length = rsp_head->pl_length[0] |
		(rsp_head->pl_length[1] << 8) |
		((rsp_head->pl_length[2] & 0xf) << 16);

	if (rsp_head->category != CXL_MCTP_CATEGORY_RESP) {
		printf("Message not a response\n");
		return -1;
	}
	if (rsp_head->tag != head->tag) {
		printf("Reply has wrong tag\n");
		return -1;
	}
	if ((rsp_head->command != head->command) ||
		(rsp_head->command_set != head->command_set)) {
		printf("Response to wrong command\n");
		return -1;
	}

	if (rsp_head->return_code != 0) {
		printf("Error code in response %d\n", rsp_head->return_code);
		printf("%x %x %x %x %x %x %x %x %x %x %x %x\n", ((uint8_t *)rsp_head)[0],((uint8_t *)rsp_head)[1],
			((uint8_t *)rsp_head)[2],((uint8_t *)rsp_head)[3],
			((uint8_t *)rsp_head)[4],((uint8_t *)rsp_head)[5],((uint8_t *)rsp_head)[6],
			((uint8_t *)rsp_head)[7], ((uint8_t *)rsp_head)[8], ((uint8_t *)rsp_head)[9],
			((uint8_t *)rsp_head)[10], ((uint8_t *)rsp_head)[11]);
		return -1;
	}

	if (pl_length < 4 ||  pl_length < (pl->num_ports * sizeof(pl->ports[0]))) {
	  printf("too short %d %d %d\n", pl->num_ports, pl_length, pl->num_ports * sizeof(pl->ports[0]));
		return -1;
	}

	for (int i = 0; i < pl->num_ports; i++) {
		struct cxl_fmapi_port_state_info_block *port = &pl->ports[i];
		const char *port_states[] = {
			[0x0] = "Disabled",
			[0x1] = "Bind in progress",
			[0x2] = "Unbind in progress",
			[0x3] = "DSP",
			[0x4] = "USP",
			[0x5] = "Reserved",
			//other values not present.
			[0xf] = "Invalid Port ID"
		  };
		const char *connected_device_modes[] = {
			[0] = "Not CXL / connected",
			[1] = "CXL 1.1",
			[2] = "CXL 2.0",
		};
		const char *connected_device_type[] = {
			[0] = "No device detected",
			[1] = "PCIe device",
			[2] = "CXL type 1 device",
			[3] = "CXL type 2 device",
			[4] = "CXL type 3 device",
			[5] = "CXL type 3 pooled device",
			[6] = "Reserved",
		};
		const char *ltssm_states[] = {
			[0] = "Detect",
			[1] = "Polling",
			[2] = "Configuration",
			[3] = "Recovery",
			[4] = "L0",
			[5] = "L0s",
			[6] = "L1",
			[7] = "L2",
			[8] = "Disabled",
			[9] = "Loop Back",
			[10] = "Hot Reset",
		};
		printf("Port%02d:\n ", port->port_id);
		printf("\tPort state: ");
		if (port_states[port->config_state & 0xf])
			printf("%s\n", port_states[port->config_state]);
		else
			printf("Unknown state\n");

		if (port->config_state == 3) { /* DSP so device could be there */
			printf("\tConnected Device CXL Version: ");
			if (port->connected_device_cxl_version > 2)
				printf("Unknown CXL Version\n");
			else
				printf("%s\n", connected_device_modes[port->connected_device_cxl_version]);

			printf("\tConnected Device Type: ");
			if (port->connected_device_type > 7)
				printf("Unknown\n");
			else
				printf("%s\n", connected_device_type[port->connected_device_type]);
		}

		printf("\tSupported CXL Modes:");
		if (port->port_cxl_version_bitmask & 0x1)
			printf(" 1.1");
		if (port->port_cxl_version_bitmask & 0x2)
			printf(" 2.0");
		printf("\n");

		printf("\tMaximum Link Width: %d Negotiated Width %d\n",
			   port->max_link_width,
			   port->negotiated_link_width);
		printf("\tSupported Speeds: ");
		if (port->supported_link_speeds_vector & 0x1)
			printf(" 2.5 GT/s");
		if (port->supported_link_speeds_vector & 0x2)
			printf(" 5.0 GT/s");
		if (port->supported_link_speeds_vector & 0x4)
			printf(" 8.0 GT/s");
		if (port->supported_link_speeds_vector & 0x8)
			printf(" 16.0 GT/s");
		if (port->supported_link_speeds_vector & 0x10)
			printf(" 32.0 GT/s");
		if (port->supported_link_speeds_vector & 0x20)
			printf(" 64.0 GT/s");
		printf("\n");

		printf("\tLTSSM: ");
		if (port->ltssm_state >= sizeof(ltssm_states))
			printf("Unkown\n");
		else
			printf("%s\n", ltssm_states[port->ltssm_state]);
	}
}

int query_ports(int sd, struct sockaddr_mctp *addr, int *tag)
{
	uint8_t buf[1024];
	ssize_t len;
	int num_ports = 4;
	int rc;
	uint8_t port_list[4] = { 0, 3, 7, 4 };
	struct sockaddr_mctp addrrx;
	socklen_t addrlen = sizeof(addrrx);
	struct cxl_fmapi_header *head;
	struct cxl_fmapi_get_phys_port_state_req_pl *reqpl;
	size_t req_sz = sizeof(*reqpl) + num_ports + sizeof(*head) ;

	head = malloc(req_sz);
	*head = (struct cxl_fmapi_header) {
		.category = CXL_MCTP_CATEGORY_REQ,
		.tag = *tag++,
		.command = CXL_GET_PHYSICAL_PORT_STATE,
		.command_set = CXL_FM_API_CMD_SET_PHYSICAL_SWITCH,
		.pl_length = {
			req_sz & 0xff,
			(req_sz >> 8) & 0xff,
			(req_sz >> 16) & 0xf },
		.vendor_ext_status = 0x1234,
	};
	reqpl = (void *)(head + 1);
	*reqpl = (struct cxl_fmapi_get_phys_port_state_req_pl) {
		.num_ports = num_ports,
	};
	for (int j = 0; j < num_ports; j++)
		reqpl->ports[j] = port_list[j];

	len = sendto(sd, head, req_sz, 0,
				 (struct sockaddr *)addr, sizeof(*addr));

	len = recvfrom(sd, buf, sizeof(buf), 0,
				   (struct sockaddr *)&addrrx, &addrlen);
	printf("got back %d\n", len);
	if (len < sizeof(struct cxl_fmapi_header)) {
		printf("Too short for header\n");
	}
	//TODO generic check of reply.
	if (addrrx.smctp_type != 0x7) {
		printf("Reply does not match expected message type %x\n", addrrx.smctp_type);
	}

	rc = parse_phys_port_state_rsp(buf, len, head);
	if (rc)
		return rc;

	return 0;
}

int main(int argv, char **argc)
{
	int rc, cci_sd, fmapi_sd;
	int tag = 0; /* will increment on each use */
	ssize_t len;
 	if (argv < 2) {
		printf("Give an address\n");
		return -1;
	}
	int dev_addr = atoi(argc[1]);
	struct sockaddr_mctp cci_addr = {
		.smctp_family = AF_MCTP,
		.smctp_network = 11,
		.smctp_addr.s_addr = dev_addr,
		.smctp_type = 0x8, /* CXL CCI */
		.smctp_tag = MCTP_TAG_OWNER,
	};
	struct sockaddr_mctp fmapi_addr = {
		.smctp_family = AF_MCTP,
		.smctp_network = 11,
		.smctp_addr.s_addr = dev_addr,
		.smctp_type = 0x7, /* CXL FMAPI */
		.smctp_tag = MCTP_TAG_OWNER,
	};
	struct sockaddr_mctp addrrx;
	socklen_t addrlen = sizeof(addrrx);
	enum cxl_type type;

	cci_sd = socket(AF_MCTP, SOCK_DGRAM, 0);
	rc = bind(cci_sd, (struct sockaddr *)&cci_addr, sizeof(cci_addr));
	if (rc) {
		printf("Bind failed\n");
		return -1;
	}

	printf("first query\n");
	rc = query_cci_identify(cci_sd, &cci_addr, &tag, &type);
	if (rc)
		return rc;

	if (type == cxl_switch) {
		fmapi_sd = socket(AF_MCTP, SOCK_DGRAM, 0);
		rc = bind(fmapi_sd, (struct sockaddr *)&fmapi_addr, sizeof(fmapi_addr));
		if (rc) {
			printf("Bind failed\n");
			return -1;
		}

		rc = query_physical_switch_info(fmapi_sd, &fmapi_addr, &tag);
		if (rc)
			return rc;

		/* Next query some of the ports */
		rc = query_ports(fmapi_sd, &fmapi_addr, &tag);
		if (rc)
			return rc;
	}

	return 0;
}

Jonathan Cameron (15):
  hw/pci-bridge/cxl_upstream: Move defintion of device to header.
  hw/cxl/mailbox: Enable mulitple mailbox command sets
  cxl/mbox: Pull the payload out of struct cxl_cmd and make instances
    constant
  hw/mbox: Split mailbox command payload into separate input and output
  cxl/mbox: Pull the CCI definition out of the CXLDeviceState
  cxl/mbox: Generalize the CCI command processing
  hw/acpi/aml-build: add function for i2c slave device serial bus
    description
  misc/i2c_mctp_cxl: Initial device emulation
  HACK: arm/virt: Add aspeed-i2c controller and MCTP EP to enable MCTP
    testing
  HACK: hw/arm/virt: Add ACPI support for aspeed-i2c / mctp
  HACK: hw/i386/pc: Add Aspeed i2c controller + MCTP with ACPI tables
  docs: cxl: Add example commandline for MCTP CXL CCIs
  hw/cxl: Add a switch mailbox CCI function.
  hw/cxl: Implement Physical Ports status retrieval
  hw/cxl: Add tunneled command support to mailbox for switch cci.

Klaus Jensen (1):
  hw/i2c: add mctp core

Matt Johnston (1):
  i2c/mctp: Allow receiving messages to dest eid 0

 MAINTAINERS                               |   7 +
 docs/system/devices/cxl.rst               |  27 +
 include/hw/acpi/aml-build.h               |   1 +
 include/hw/arm/virt.h                     |   2 +
 include/hw/cxl/cxl.h                      |   6 +
 include/hw/cxl/cxl_component.h            |   3 +-
 include/hw/cxl/cxl_device.h               |  81 ++-
 include/hw/i2c/mctp.h                     | 114 ++++
 include/hw/i2c/smbus_master.h             |   3 +
 include/hw/i386/pc.h                      |   1 +
 include/hw/pci-bridge/cxl_upstream_port.h |  20 +
 include/net/mctp.h                        |  43 ++
 hw/acpi/aml-build.c                       |  17 +
 hw/arm/virt-acpi-build.c                  |  60 ++
 hw/arm/virt.c                             |  86 +++
 hw/cxl/cxl-device-utils.c                 |  97 ++-
 hw/cxl/cxl-events.c                       |   2 +-
 hw/cxl/cxl-mailbox-utils.c                | 715 +++++++++++++++++-----
 hw/cxl/i2c_mctp_cxl.c                     | 237 +++++++
 hw/cxl/switch-mailbox-cci.c               |  98 +++
 hw/i2c/mctp.c                             | 353 +++++++++++
 hw/i2c/smbus_master.c                     |  28 +
 hw/i386/acpi-build.c                      |  65 ++
 hw/i386/pc.c                              |  20 +-
 hw/mem/cxl_type3.c                        |   9 +-
 hw/pci-bridge/cxl_downstream.c            |   5 +-
 hw/pci-bridge/cxl_upstream.c              |  11 +-
 hw/arm/Kconfig                            |   3 +
 hw/cxl/Kconfig                            |   3 +
 hw/cxl/meson.build                        |   2 +
 hw/i2c/Kconfig                            |   4 +
 hw/i2c/meson.build                        |   3 +-
 hw/i2c/trace-events                       |  12 +
 hw/i386/Kconfig                           |   2 +
 34 files changed, 1956 insertions(+), 184 deletions(-)
 create mode 100644 include/hw/i2c/mctp.h
 create mode 100644 include/hw/pci-bridge/cxl_upstream_port.h
 create mode 100644 include/net/mctp.h
 create mode 100644 hw/cxl/i2c_mctp_cxl.c
 create mode 100644 hw/cxl/switch-mailbox-cci.c
 create mode 100644 hw/i2c/mctp.c

-- 
2.39.2

