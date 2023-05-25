Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE5C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu, 25 May 2023 16:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjEYQKH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjEYQJo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 12:09:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6149E1BD
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 09:09:21 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRtHV1HrGz67RCM;
        Fri, 26 May 2023 00:07:34 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 17:08:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>
CC:     Niyas Sait <niyas.sait@linaro.org>,
        Klaus Jensen <its@irrelevant.dk>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 0/6] hw/{cxl,i386,arm}: PoC: Emulated MCTP over I2C for CXL Fabric / Device management
Date:   Thu, 25 May 2023 17:08:53 +0100
Message-ID: <20230525160859.32517-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Not intended for merge in anything like current form!

CC list is a bit random and I'll admit I added a few people just to make them groan.

Depends on patches 1 and 2 from.
[PATCH v2 0/3] hw/{i2c, nvme}: mctp endpoint, nvme management interface model.

Based-on: Message-ID: 20230425063540.46143-1-its@irrelevant.dk
Arm parts also need the out of tree ARM64 cxl patches.
Generally working  with the kernel CXL stack requires event emulation.

A git tree with this near the top and all prereqs is available at:
http://gitlab.com/jic23/qemu  cxl-2023-05-25

Just over a year ago (yikes) I posted [RFC PATCH 0/2] CXL FMAPI interface over MCTP/I2C
https://lore.kernel.org/linux-cxl/20220520170128.4436-1-Jonathan.Cameron@huawei.com/

Since that time I've had a number of questions about how to build on that
PoC to enable control of actual CXL devices.

The fundamental problem at that stage was the PoC only worked with device tree
bindings and the rest of CXL software assumes ACPI (adding DT support for
CXL in general is a long term project).  So this series attempts to 'solve'
that.

Currently I'm only aware of one emulated I2C controller with the right
characteristics to be able to support MCTP over I2C - aspeed-i2c.
So lets add that to the main architectures we care about for CXL:
- ARM64 (on top of my out of tree support github.com/jic23/qemu)
- X86 - yup I just added an aspeed-i2c controller to pc :)

The actual emulated device has been rebased on Klaus Jensen's work
for the nvme-mi which massively reduces the amount of boilerplate
/ state machine handling that needs to be done in this emulation.
(great work btw Klaius!)

So how to use this:

For ACPI you need the kernel patches from:
https://lore.kernel.org/linux-cxl/20230525152203.32190-1-Jonathan.Cameron@huawei.com/T/#u
To make the aspeed i2c controller play nicely with PRP0001 based ACPI description.

Example qemu command line - stripped back to include only relevant bits

qemu-system-x86_64 -M q35,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
...
 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-mem5,share=on,mem-path=/tmp/cxltest5.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem6,share=on,mem-path=/tmp/cxltest6.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem7,share=on,mem-path=/tmp/cxltest7.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa5,share=on,mem-path=/tmp/lsa5.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa6,share=on,mem-path=/tmp/lsa6.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa7,share=on,mem-path=/tmp/lsa7.raw,size=1M,align=1M \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
 -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=2 \
 -device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=0,slot=3 \
 -device cxl-upstream,port=33,bus=root_port0,id=us0,multifunction=on,addr=0.0,sn=12345678 \
 -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
 -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
 -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
 -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-lsa1,sn=3 \
 -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa2,sn=4 \
 -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa3,sn=5 \
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=4,target=us0 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=5,target=cxl-pmem0 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=6,target=cxl-pmem1 \
 -device i2c_mctp_cxl,bus=aspeed.i2c.bus.0,address=7,target=cxl-pmem2 \
  

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
busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x4
busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x5
busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x6
busctl call xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp au.com.CodeConstruct.MCTP AssignEndpoint say mctpi2c0 1 0x7

# Check it worked by dumping some state.
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/8 xyz.openbmc_project.MCTP.Endpoint
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/9 xyz.openbmc_project.MCTP.Endpoint
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/10 xyz.openbmc_project.MCTP.Endpoint
busctl introspect xyz.openbmc_project.MCTP /xyz/openbmc_project/mctp/11/11 xyz.openbmc_project.MCTP.Endpoint

Use the following test program to poke them

./test 8 etc (address will be printed out during configuration above, but usually starts at 8)


From 14ac4ad4eb97bd0536c332f08c639f980c280b93 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 25 May 2023 11:36:36 +0100
Subject: [PATCH] Trivial MCTP CXL CCI test prog

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 cxl_fmapi.h |  72 +++++++++++
 mctp.h      |  68 ++++++++++
 test.c      | 361 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 501 insertions(+)
 create mode 100644 cxl_fmapi.h
 create mode 100644 mctp.h
 create mode 100644 test.c

diff --git a/cxl_fmapi.h b/cxl_fmapi.h
new file mode 100644
index 0000000..6e861ed
--- /dev/null
+++ b/cxl_fmapi.h
@@ -0,0 +1,72 @@
+
+#include <stdint.h>
+
+#define CXL_CCI_CMD_SET_INFO 0x0
+#define  CXL_IDENTIFY 0x0
+#define CXL_FM_API_CMD_SET_PHYSICAL_SWITCH 0x51
+#define  CXL_IDENTIFY_SWITCH_DEVICE 0x00
+#define  CXL_GET_PHYSICAL_PORT_STATE 0x01
+
+struct cxl_fmapi_header {
+  #define CXL_MCTP_CATEGORY_REQ 0
+  #define CXL_MCTP_CATEGORY_RESP 1
+  uint8_t category;
+  uint8_t tag;
+  uint8_t rsv1;
+  uint8_t command;
+  uint8_t command_set;
+  uint8_t pl_length[3]; /* 20 bit little endian, BO bit at bit 23 */
+  uint16_t return_code;
+  uint16_t vendor_ext_status;
+} __attribute__ ((packed));
+
+struct cxl_cci_infostat_identify_resp_pl {
+    uint16_t vendor_id;
+    uint16_t device_id;
+    uint16_t subsys_vendor_id;
+    uint16_t subsys_id;
+    uint8_t serial_num[8];
+    uint8_t max_msg;
+    uint8_t component_type;
+} __attribute__((packed));
+
+struct cxl_fmapi_ident_switch_dev_resp_pl {
+  uint8_t ingres_port_id;
+  uint8_t rsv1;
+  uint8_t num_physical_ports;
+  uint8_t num_vcs;
+  uint8_t active_port_bitmask[32];
+  uint8_t active_vcs_bitmask[32];
+  uint16_t num_total_vppb;
+  uint16_t num_active_vppb;
+} __attribute__((packed));
+
+struct cxl_fmapi_get_phys_port_state_req_pl {
+  uint8_t num_ports; /* CHECK. may get too large for MCTP message size */
+  uint8_t ports[];
+} __attribute__((packed));
+
+struct cxl_fmapi_port_state_info_block {
+  uint8_t port_id;
+  uint8_t config_state;
+  uint8_t connected_device_cxl_version;
+  uint8_t rsv1;
+  uint8_t connected_device_type;
+  uint8_t port_cxl_version_bitmask;
+  uint8_t max_link_width;
+  uint8_t negotiated_link_width;
+  uint8_t supported_link_speeds_vector;
+  uint8_t max_link_speed;
+  uint8_t current_link_speed;
+  uint8_t ltssm_state;
+  uint8_t first_lane_num;
+  uint16_t link_state;
+  uint8_t supported_ld_count;
+} __attribute__((packed));
+
+struct cxl_fmapi_get_phys_port_state_resp_pl {
+  uint8_t num_ports;
+  uint8_t rsv1[3];
+  struct cxl_fmapi_port_state_info_block ports[];
+} __attribute__((packed));
+
diff --git a/mctp.h b/mctp.h
new file mode 100644
index 0000000..154ab56
--- /dev/null
+++ b/mctp.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Management Component Transport Protocol (MCTP)
+ *
+ * Copyright (c) 2021 Code Construct
+ * Copyright (c) 2021 Google
+ */
+
+#ifndef __UAPI_MCTP_H
+#define __UAPI_MCTP_H
+
+#include <linux/types.h>
+#include <linux/socket.h>
+#include <linux/netdevice.h>
+
+typedef __u8			mctp_eid_t;
+
+struct mctp_addr {
+	mctp_eid_t		s_addr;
+};
+
+struct sockaddr_mctp {
+	__kernel_sa_family_t	smctp_family;
+	__u16			__smctp_pad0;
+	unsigned int		smctp_network;
+	struct mctp_addr	smctp_addr;
+	__u8			smctp_type;
+	__u8			smctp_tag;
+	__u8			__smctp_pad1;
+};
+
+struct sockaddr_mctp_ext {
+	struct sockaddr_mctp	smctp_base;
+	int			smctp_ifindex;
+	__u8			smctp_halen;
+	__u8			__smctp_pad0[3];
+	__u8			smctp_haddr[MAX_ADDR_LEN];
+};
+
+#define MCTP_NET_ANY		0x0
+
+#define MCTP_ADDR_NULL		0x00
+#define MCTP_ADDR_ANY		0xff
+
+#define MCTP_TAG_MASK		0x07
+#define MCTP_TAG_OWNER		0x08
+#define MCTP_TAG_PREALLOC	0x10
+
+#define MCTP_OPT_ADDR_EXT	1
+
+#define SIOCMCTPALLOCTAG	(SIOCPROTOPRIVATE + 0)
+#define SIOCMCTPDROPTAG		(SIOCPROTOPRIVATE + 1)
+
+struct mctp_ioc_tag_ctl {
+	mctp_eid_t	peer_addr;
+
+	/* For SIOCMCTPALLOCTAG: must be passed as zero, kernel will
+	 * populate with the allocated tag value. Returned tag value will
+	 * always have TO and PREALLOC set.
+	 *
+	 * For SIOCMCTPDROPTAG: userspace provides tag value to drop, from
+	 * a prior SIOCMCTPALLOCTAG call (and so must have TO and PREALLOC set).
+	 */
+	__u8		tag;
+	__u16		flags;
+};
+
+#endif /* __UAPI_MCTP_H */
diff --git a/test.c b/test.c
new file mode 100644
index 0000000..20f1dbb
--- /dev/null
+++ b/test.c
@@ -0,0 +1,361 @@
+/*
+ * Trivial example program to exercise QEMU FMAPI Emulation over MCTP over I2C
+ */
+#include <sys/socket.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include "mctp.h"
+#include "cxl_fmapi.h"
+
+enum cxl_type {
+	cxl_switch,
+	cxl_type3,
+};
+
+static int query_cci_identify(int sd, struct sockaddr_mctp *addr, int *tag, enum cxl_type *type)
+{
+	struct cxl_cci_infostat_identify_resp_pl *pl;
+	uint8_t buf[1024];
+	struct cxl_fmapi_header *rsp_head = buf;
+
+	int rc;
+	ssize_t len;
+	struct sockaddr_mctp addrrx;
+	socklen_t addrlen = sizeof(addrrx);
+	struct cxl_fmapi_header req = {
+		.category = CXL_MCTP_CATEGORY_REQ,
+		.tag = *tag++,
+		.command = 1,
+		.command_set = 0,
+		.vendor_ext_status = 0xabcd,
+	};
+
+	printf("trying to identify\n");
+	len = sendto(sd, &req, sizeof(req), 0, (struct sockaddr *)addr, sizeof(*addr));
+	if (len != sizeof(req)) {
+		printf("Failed to send whole request for phys switch info %d %d\n", len, sizeof(req));
+		return -1;
+	}
+
+	len = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&addrrx, &addrlen);
+	if (len < 0) {
+		printf("Failed to receive response\n");
+		return -1;
+	}
+	printf("length %d\n", len);
+	pl = (void *)(rsp_head + 1);
+	printf("Vendor id  : %04x\n", pl->vendor_id);
+	printf("Device id  : %04x\n", pl->device_id);
+	printf("Subsys vid : %04x\n", pl->subsys_vendor_id);
+	printf("Subsys id  : %04x\n", pl->subsys_id);
+
+	switch (pl->component_type) {
+	case 0x00:
+		printf("Switch!\n");
+		*type = cxl_switch;
+		break;
+	case 0x03:
+		printf("Type3!\n");
+		*type = cxl_type3;
+		break;
+	}
+
+	return 0;
+}
+
+static int parse_physical_switch_identify_switch_device(void *buf, size_t buf_len)
+{
+	struct cxl_fmapi_header *rsp_head = buf;
+	struct cxl_fmapi_ident_switch_dev_resp_pl *pl = (void *)(rsp_head + 1);
+	uint8_t *b;
+	if (rsp_head->return_code != 0) {
+		printf("Error code in response %d\n", rsp_head->return_code);
+		return -1;
+	}
+	printf("Num total vppb %d\n", pl->num_total_vppb);
+	printf("Ports %d\n", pl->num_physical_ports);
+	b = pl->active_port_bitmask;
+	printf("ActivePortMask");
+	for (int i = 0; i < 32; i++)
+		printf("%02x", b[i]);
+	printf("\n");
+	return 0;
+}
+
+int query_physical_switch_info(int sd, struct sockaddr_mctp *addr, int *tag)
+{
+	uint8_t buf[1024];
+	int rc;
+	ssize_t len;
+	struct sockaddr_mctp addrrx;
+	socklen_t addrlen = sizeof(addrrx);
+	struct cxl_fmapi_header req = {
+		.category = CXL_MCTP_CATEGORY_REQ,
+		.tag = *tag++,
+		.command = CXL_IDENTIFY_SWITCH_DEVICE,
+		.command_set = CXL_FM_API_CMD_SET_PHYSICAL_SWITCH,
+		.vendor_ext_status = 0xabcd,
+	};
+
+	len = sendto(sd, &req, sizeof(req), 0, (struct sockaddr *)addr, sizeof(*addr));
+	if (len != sizeof(req)) {
+		printf("Failed to send whole request for phys switch info %d %d\n", len, sizeof(req));
+		return -1;
+	}
+
+	len = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr *)&addrrx, &addrlen);
+	if (len < 0) {
+		printf("Failed to receive response\n");
+		return -1;
+	}
+	printf("length %d\n", len);
+	rc = parse_physical_switch_identify_switch_device(buf, len);
+	if (rc)
+		return -1;
+
+	return 0;
+}
+
+static int parse_phys_port_state_rsp(void * buf, size_t buf_len, struct cxl_fmapi_header *head)
+{
+	struct cxl_fmapi_header *rsp_head = buf;
+	struct cxl_fmapi_get_phys_port_state_resp_pl *pl = (void *)(rsp_head + 1);
+	uint32_t pl_length = rsp_head->pl_length[0] |
+		(rsp_head->pl_length[1] << 8) |
+		((rsp_head->pl_length[2] & 0xf) << 16);
+
+	if (rsp_head->category != CXL_MCTP_CATEGORY_RESP) {
+		printf("Message not a response\n");
+		return -1;
+	}
+	if (rsp_head->tag != head->tag) {
+		printf("Reply has wrong tag\n");
+		return -1;
+	}
+	if ((rsp_head->command != head->command) ||
+		(rsp_head->command_set != head->command_set)) {
+		printf("Response to wrong command\n");
+		return -1;
+	}
+
+	if (rsp_head->return_code != 0) {
+		printf("Error code in response %d\n", rsp_head->return_code);
+		printf("%x %x %x %x %x %x %x %x %x %x %x %x\n", ((uint8_t *)rsp_head)[0],((uint8_t *)rsp_head)[1],
+			((uint8_t *)rsp_head)[2],((uint8_t *)rsp_head)[3],
+			((uint8_t *)rsp_head)[4],((uint8_t *)rsp_head)[5],((uint8_t *)rsp_head)[6],
+			((uint8_t *)rsp_head)[7], ((uint8_t *)rsp_head)[8], ((uint8_t *)rsp_head)[9],
+			((uint8_t *)rsp_head)[10], ((uint8_t *)rsp_head)[11]);
+		return -1;
+	}
+
+	if (pl_length < 4 ||  pl_length < (pl->num_ports * sizeof(pl->ports[0]))) {
+		printf("too short %d %d\n", pl->num_ports);
+		return -1;
+	}
+
+	for (int i = 0; i < pl->num_ports; i++) {
+		struct cxl_fmapi_port_state_info_block *port = &pl->ports[i];
+		const char *port_states[] = {
+			[0x0] = "Disabled",
+			[0x1] = "Bind in progress",
+			[0x2] = "Unbind in progress",
+			[0x3] = "DSP",
+			[0x4] = "USP",
+			[0x5] = "Reserved",
+			//other values not present.
+			[0xf] = "Invalid Port ID"
+		  };
+		const char *connected_device_modes[] = {
+			[0] = "Not CXL / connected",
+			[1] = "CXL 1.1",
+			[2] = "CXL 2.0",
+		};
+		const char *connected_device_type[] = {
+			[0] = "No device detected",
+			[1] = "PCIe device",
+			[2] = "CXL type 1 device",
+			[3] = "CXL type 2 device",
+			[4] = "CXL type 3 device",
+			[5] = "CXL type 3 pooled device",
+			[6] = "Reserved",
+		};
+		const char *ltssm_states[] = {
+			[0] = "Detect",
+			[1] = "Polling",
+			[2] = "Configuration",
+			[3] = "Recovery",
+			[4] = "L0",
+			[5] = "L0s",
+			[6] = "L1",
+			[7] = "L2",
+			[8] = "Disabled",
+			[9] = "Loop Back",
+			[10] = "Hot Reset",
+		};
+		printf("Port%02d:\n ", port->port_id);
+		printf("\tPort state: ");
+		if (port_states[port->config_state & 0xf])
+			printf("%s\n", port_states[port->config_state]);
+		else
+			printf("Unknown state\n");
+
+		if (port->config_state == 3) { /* DSP so device could be there */
+			printf("\tConnected Device CXL Version: ");
+			if (port->connected_device_cxl_version > 2)
+				printf("Unknown CXL Version\n");
+			else
+				printf("%s\n", connected_device_modes[port->connected_device_cxl_version]);
+
+			printf("\tConnected Device Type: ");
+			if (port->connected_device_type > 7)
+				printf("Unknown\n");
+			else
+				printf("%s\n", connected_device_type[port->connected_device_type]);
+		}
+
+		printf("\tSupported CXL Modes:");
+		if (port->port_cxl_version_bitmask & 0x1)
+			printf(" 1.1");
+		if (port->port_cxl_version_bitmask & 0x2)
+			printf(" 2.0");
+		printf("\n");
+
+		printf("\tMaximum Link Width: %d Negotiated Width %d\n",
+			   port->max_link_width,
+			   port->negotiated_link_width);
+		printf("\tSupported Speeds: ");
+		if (port->supported_link_speeds_vector & 0x1)
+			printf(" 2.5 GT/s");
+		if (port->supported_link_speeds_vector & 0x2)
+			printf(" 5.0 GT/s");
+		if (port->supported_link_speeds_vector & 0x4)
+			printf(" 8.0 GT/s");
+		if (port->supported_link_speeds_vector & 0x8)
+			printf(" 16.0 GT/s");
+		if (port->supported_link_speeds_vector & 0x10)
+			printf(" 32.0 GT/s");
+		if (port->supported_link_speeds_vector & 0x20)
+			printf(" 64.0 GT/s");
+		printf("\n");
+
+		printf("\tLTSSM: ");
+		if (port->ltssm_state >= sizeof(ltssm_states))
+			printf("Unkown\n");
+		else
+			printf("%s\n", ltssm_states[port->ltssm_state]);
+	}
+}
+
+int query_ports(int sd, struct sockaddr_mctp *addr, int *tag)
+{
+	uint8_t buf[1024];
+	ssize_t len;
+	int num_ports = 4;
+	int rc;
+	uint8_t port_list[4] = { 0, 3, 7, 4 };
+	struct sockaddr_mctp addrrx;
+	socklen_t addrlen = sizeof(addrrx);
+	struct cxl_fmapi_header *head;
+	struct cxl_fmapi_get_phys_port_state_req_pl *reqpl;
+	size_t req_sz = sizeof(*reqpl) + num_ports + sizeof(*head) ;
+
+	head = malloc(req_sz);
+	*head = (struct cxl_fmapi_header) {
+		.category = CXL_MCTP_CATEGORY_REQ,
+		.tag = *tag++,
+		.command = CXL_GET_PHYSICAL_PORT_STATE,
+		.command_set = CXL_FM_API_CMD_SET_PHYSICAL_SWITCH,
+		.pl_length = {
+			req_sz & 0xff,
+			(req_sz >> 8) & 0xff,
+			(req_sz >> 16) & 0xf },
+		.vendor_ext_status = 0x1234,
+	};
+	reqpl = (void *)(head + 1);
+	*reqpl = (struct cxl_fmapi_get_phys_port_state_req_pl) {
+		.num_ports = num_ports,
+	};
+	for (int j = 0; j < num_ports; j++)
+		reqpl->ports[j] = port_list[j];
+
+	len = sendto(sd, head, req_sz, 0,
+				 (struct sockaddr *)addr, sizeof(*addr));
+
+	len = recvfrom(sd, buf, sizeof(buf), 0,
+				   (struct sockaddr *)&addrrx, &addrlen);
+	if (len < sizeof(struct cxl_fmapi_header)) {
+		printf("Too short for header\n");
+	}
+	//TODO generic check of reply.
+	if (addrrx.smctp_type != 0x7) {
+		printf("Reply does not match expected message type %x\n", addrrx.smctp_type);
+	}
+
+	rc = parse_phys_port_state_rsp(buf, len, head);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+int main(int argv, char **argc)
+{
+	int rc, cci_sd, fmapi_sd;
+	int tag = 0; /* will increment on each use */
+	ssize_t len;
+	if (argv < 2) {
+		printf("Give an address\n");
+		return -1;
+	}
+	int dev_addr = atoi(argc[1]);
+	struct sockaddr_mctp cci_addr = {
+		.smctp_family = AF_MCTP,
+		.smctp_network = 11,
+		.smctp_addr.s_addr = dev_addr,
+		.smctp_type = 0x8, /* CXL CCI */
+		.smctp_tag = MCTP_TAG_OWNER,
+	};
+	struct sockaddr_mctp fmapi_addr = {
+		.smctp_family = AF_MCTP,
+		.smctp_network = 11,
+		.smctp_addr.s_addr = dev_addr,
+		.smctp_type = 0x7, /* CXL FMAPI */
+		.smctp_tag = MCTP_TAG_OWNER,
+	};
+	struct sockaddr_mctp addrrx;
+	socklen_t addrlen = sizeof(addrrx);
+	enum cxl_type type;
+
+	cci_sd = socket(AF_MCTP, SOCK_DGRAM, 0);
+	rc = bind(cci_sd, (struct sockaddr *)&cci_addr, sizeof(cci_addr));
+	if (rc) {
+		printf("Bind failed\n");
+		return -1;
+	}
+
+	rc = query_cci_identify(cci_sd, &cci_addr, &tag, &type);
+	if (rc)
+		return rc;
+
+	if (type == cxl_switch) {
+		fmapi_sd = socket(AF_MCTP, SOCK_DGRAM, 0);
+		rc = bind(fmapi_sd, (struct sockaddr *)&fmapi_addr, sizeof(fmapi_addr));
+		if (rc) {
+			printf("Bind failed\n");
+			return -1;
+		}
+
+		rc = query_physical_switch_info(fmapi_sd, &fmapi_addr, &tag);
+		if (rc)
+			return rc;
+
+		/* Next query some of the ports */
+		rc = query_ports(fmapi_sd, &fmapi_addr, &tag);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
-- 
2.39.2

Jonathan Cameron (6):
  hw/acpi/aml-build: add function for i2c slave device serial bus
    description
  HACK: arm/virt: Add aspeed-i2c controller and MCTP EP to enable MCTP
    testing
  HACK: hw/arm/virt: Add ACPI support for aspeed-i2c / mctp
  HACK: hw/i386/pc: Add Aspeed i2c controller + MCTP with ACPI tables
  misc/i2c_mctp_cxl: Initial device emulation
  docs: cxl: Add example commandline for MCTP CXL CCIs

 docs/system/devices/cxl.rst |  27 +++
 include/hw/acpi/aml-build.h |   1 +
 include/hw/arm/virt.h       |   2 +
 include/hw/cxl/cxl_fmapi.h  | 102 ++++++++++
 include/hw/i386/pc.h        |   1 +
 hw/acpi/aml-build.c         |  17 ++
 hw/arm/virt-acpi-build.c    |  60 ++++++
 hw/arm/virt.c               |  92 ++++++++-
 hw/cxl/i2c_mctp_cxl.c       | 369 ++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        |  65 +++++++
 hw/i386/pc.c                |  20 +-
 hw/arm/Kconfig              |   2 +
 hw/cxl/Kconfig              |   3 +
 hw/cxl/meson.build          |   1 +
 hw/i2c/meson.build          |   2 +-
 hw/i386/Kconfig             |   2 +
 hw/misc/meson.build         |   1 +
 17 files changed, 762 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/cxl/cxl_fmapi.h
 create mode 100644 hw/cxl/i2c_mctp_cxl.c

-- 
2.39.2

