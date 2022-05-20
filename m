Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310ADC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 20 May 2022 16:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiETQ7N (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 20 May 2022 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344870AbiETQ7M (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 20 May 2022 12:59:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93352185C91
        for <linux-cxl@vger.kernel.org>; Fri, 20 May 2022 09:59:10 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L4XtB2Sm4z67QNS;
        Sat, 21 May 2022 00:56:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 18:59:07 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 17:59:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Klaus Jensen <its@irrelevant.dk>
CC:     <linux-cxl@vger.kernel.org>, Corey Minyard <minyard@acm.org>,
        Damien Hedde <damien.hedde@greensocs.com>,
        Peter Delevoryas <pdel@fb.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH 0/2] CXL FMAPI interface over MCTP/I2C
Date:   Fri, 20 May 2022 17:59:09 +0100
Message-ID: <20220520165909.4369-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A quick PoC to show the feasibility of emulating the CXL 2.0
Fabric Manager API over MCTP over I2C as possible path to standards
based configuration of emulated CXL switches.  Lots of missing parts
(such as hooking this up to the upstream ports or making it actually
do anything useful), but it's enough to establish this as a plausible
approach. Purpose of sharing this is mostly to let people know I've
been messing around with this (and that Klaus' work was really
helpful :)

The end goal is to enable emulation of more sophisticated
CXL switches that rely on an external agent (fabric manager) configuring
them. One likely common way of doing this is to use the DMTF defined
CXL FMAPI over MCTP binding (message type 7).  Whilst we don't have
multiple hosts in QEMU, that doesn't matter for exercising both
the switch configuration elements, and the host handling of the
resulting events (we can have multiple virtual hierarchies via
multiple CXL root ports - similar to multiple hosts, but with a
few additional software complexities). Note there are a load
of other protocols that we will want to emulate in future (such as
SPDM) but this one was a simple place to start. Note QEMU emulation
of simple CXL switches is still under review (queued behind ARM
support for CXL due to some fuzz in test cases).
https://lore.kernel.org/qemu-devel/20220429144110.25167-44-Jonathan.Cameron@huawei.com/

FMAPI allows:
* Management software to query switch state and capabilities (part of
  this is implemented in this RFC)
* Configuration of binding of physical ports to particular virtual
  hierarchies (PCIe topologies visible to the host).
* Configuration of the binding of MLD (Multiple Logical Device) LDs
  to particular virtual ports within a Virtual Hierarchy (how CXL 2.0
  handles memory pooling).
* Lots of other stuff.

Details in the CXL 2.0 specification and ECNs.

FMAPI could be enabled via an external interface (and might be in
some later patch set) but the recent RFC for I2C slave mode support
https://lore.kernel.org/qemu-devel/20220331165737.1073520-1-its@irrelevant.dk/
provided the option to simply expose an MCTP interface to the guest.
(normally it would be exported to a BMC or similar, but meh, that doesn't
 matter for testing :) Ultimately emulation of all the common interfaces
 will be needed to provide a broad test platform.

Note this use of the above patch set is rather different to using it to
communicate between two emulated machines, one of which is running firmware for
an appropriate device.  We could do that for CXL switches, but the
tight coupling we will want to the other parts being emulated in QEMU
would make such an approach challenging. Also the FMAPI is simple
enough to lend itself to implementation as a state machine as part of the device
emulation.

Given I wanted a simple test platform without separate firmware requirements
I've added the aspeed-i2c controller to the arm virt image. There are some
quirks around this such as the need for reset controller but overall the
support is straight forward.  A snag here is that for rest of CXL emulation
I need to use ACPI and the aspeed-i2c driver in Linux is currently not
very ACPI friendly and it may be controversial to make it so.

To bring up the connection:

* Use a kernel with appropriate i2c controller and mctp driver support.
  (5.18-rc1 or later should work - though there are some bugs that can
   be if you follow particular wrong configuration flows).
* Get mctp and mctpd from https://github.com/CodeConstruct/mctp
  - modify the mctpd systemd init as provided and start the daemon.
  - for 64 bit support, get latest version as a sizeof() bug was identified
    whilst testing this.


# Bring up the link
mctp link set mctpi2c0 up
# Assign an address to the aspeed-i2c controller
mctp addr add 50 dev mctpi2c0
# Assign a neetwork ID to the link (11)
mctp link set mctpi2c0 net 11
# Start the daemon that uses dbus for configuration.
systemctl start mctpd.service
# Assign an EID to the EP (hard coded I2C address is 0x4d)
busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x4d
# Check it worked by dumping some state.
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/8 xyz.openbmc_project.MCTP.Endpoint

At this point the control protocol has been exercised.

The following test program will query some information about the
'fake' CXL switch.

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

#define AF_MCTP 45
static int parse_physical_switch_identify_switch_device(void *buf, size_t buf_len)
{
	struct cxl_fmapi_header *head = buf;
	struct cxl_fmapi_ident_switch_dev_resp_pl *pl = (void *)(head + 1);

	printf("Num total vppb %d\n", pl->num_total_vppb);
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
		printf("Failed to send whole request\n");
		return -1;
	}

	len = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&addrrx, &addrlen);
	if (len < 0) {
		printf("Failed to receive response\n");
		return -1;
	}
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
		printf("Error code in response %d\n", rsp_head);
		return -1;
	}

	if (pl_length < 4 ||  pl_length < (pl->num_ports * sizeof(pl->ports[0]))) {
		printf("too short\n");
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
	if (len < sizeof(struct cxl_fmapi_header)) {
		printf("Too short for header\n");
	}
	//TODO generic check of reply.
	if (addrrx.smctp_type != 0x7) {
		printf("Reply does not match expected message type\n");
	}

	rc = parse_phys_port_state_rsp(buf, len, head);
	if (rc)
		return rc;

	return 0;
}

int main()
{
	int rc, sd;
	int tag = 0; /* will increment on each use */
	ssize_t len;
	struct sockaddr_mctp addr = {
		.smctp_family = AF_MCTP,
		.smctp_network = 11,
		.smctp_addr.s_addr = 8,
		.smctp_type = 0x7, /* CXL FMAPI */
		.smctp_tag = MCTP_TAG_OWNER,
	};
	struct sockaddr_mctp addrrx;
	socklen_t addrlen = sizeof(addrrx);

	sd = socket(AF_MCTP, SOCK_DGRAM, 0);
	rc = bind(sd, (struct sockaddr *)&addr, sizeof(addr));
	if (rc) {
		printf("Bind failed\n");
		return -1;
	}

	rc = query_physical_switch_info(sd, &addr, &tag);
	if (rc)
			return rc;

	/* Next query some of the ports */
	rc = query_ports(sd, &addr, &tag);
	if (rc)
		return rc;

	return 0;
}

All feedback welcome.

Enjoy,

Jonathan

Jonathan Cameron (2):
  misc/i2c_mctp_cxl_fmapi: Initial device emulation
  arm/virt: Add aspeed-i2c controller and MCTP EP to enable MCTP testing

 hw/arm/Kconfig                       |   1 +
 hw/arm/virt.c                        |  77 +++
 hw/misc/Kconfig                      |   3 +
 hw/misc/i2c_mctp_cxl_fmapi.c         | 759 +++++++++++++++++++++++++++
 hw/misc/meson.build                  |   2 +
 include/hw/arm/virt.h                |   2 +
 include/hw/cxl/cxl_fmapi.h           | 158 ++++++
 include/hw/misc/i2c_mctp_cxl_fmapi.h |  17 +
 8 files changed, 1019 insertions(+)
 create mode 100644 hw/misc/i2c_mctp_cxl_fmapi.c
 create mode 100644 include/hw/cxl/cxl_fmapi.h
 create mode 100644 include/hw/misc/i2c_mctp_cxl_fmapi.h

-- 
2.32.0

