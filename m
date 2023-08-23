Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9C2C3DA66
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Aug 2023 23:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbjHWXV6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbjHWXVp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Aug 2023 19:21:45 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DE4E5F
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 16:21:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BD7E2C1775;
        Wed, 23 Aug 2023 23:21:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 165A1C16D3;
        Wed, 23 Aug 2023 23:21:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692832901; a=rsa-sha256;
        cv=none;
        b=KPShAwV0ZamjNdJH50qDo++qerggY0sk6oeNx/Bt9fbyrUQdrFWDk76y2F9j4Of+/VQ0G9
        0egAW78Sx8KpjTCtjVuXaKg2MYG8M49MjbBfWvpfEran0N6VNVe2/V/WygvXqNnlI+/uaM
        iJQlsE5M6fU+0EKzuzEYzk4dnghjA+rd+kneurbTZRXS0CGIPCfhMO5mC9ME/GGmdD+LSu
        rNwmNE/CQB6/bFUGu8Nt2Cn2zFiPVpoLclwpEpH9HAqIsiC45jqDzSYrhe2YJ0N9NhMviN
        q/V84l8hsvFbnifv9B6KLKyBoBO1ZJyhQz1ftumbDdoIA4oBmBF06cJZVCdJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692832901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QjVMIhe3I1dxpOuHC+caRg+jOFZGtsCaQpr9MIHeHew=;
        b=vJQAklHmGWZTd7hFGi1ND6zMyE823cmZqX4fLLJ8OOXNihKPfJKgw3LrEmxjuKosCiMt9X
        5BFYUfzT6TvXtgJXWMzQ7UKTHFzDkJ94EMcDDFaZ28dyBqs7muuluaGFB3Ug/gL0FswU/2
        CwpKPYm4ykeZHvtOPzb+pm4nxh9PSktxa6DtBk3e5u+Wg/bNXcKRkC7P/V0j6OObSlyy+m
        gTsMHlEzQTk/92bPMBC8YITIm/GVdFVOsbqFui13ziuX9SdUZAJ8B97+2AhMdlwhtvUGlK
        j4ndZai7HSs+G3FFc6vQKC5DQqM8csN4EkNfzz9lMXL8Bkjat53yKHZQ/UqAdQ==
ARC-Authentication-Results: i=1;
        rspamd-5c4f45d774-m48d7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Celery: 0abb2ced4143ee4c_1692832901556_1928060678
X-MC-Loop-Signature: 1692832901556:1193091089
X-MC-Ingress-Time: 1692832901556
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.240.35 (trex/6.9.1);
        Wed, 23 Aug 2023 23:21:41 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4RWMfr1bCSzPq;
        Wed, 23 Aug 2023 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1692832900;
        bh=QjVMIhe3I1dxpOuHC+caRg+jOFZGtsCaQpr9MIHeHew=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=cEiID2FHObZMuzci3/LpEycgbu4sJS8y+nco71vE6TIjlf+krB67s0kwNMzEhPPIC
         NkGWk29UXRZL9dGNI7BkGxD5oxwwOrWr5pPt/yFZxzg5zLskFUYKdpJV5XvGWcSDCZ
         1xT5pP4U5U8DRb8KsYVdLLNVsXnXDb1DUSmM3YousZXsScA850oHpsOxwzRAQe3MF9
         HvpunjsWIAcvlSJSQ/fEHsr0NY2pcM6QSrDOCVqI1SCFtgaFnVsB9RIzg2+l6oPo55
         rmK8W8sSBzzFHqP2a7hruVnbA8JJbLHIOiLlSR0rknB3pFnYo6knMyIhlQ1oMwWc+M
         1pr0P6ImSncvQ==
Date:   Wed, 23 Aug 2023 15:42:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linuxarm@huawei.com, Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, fan.ni@samsung.com,
        a.manzanares@samsung.com
Subject: Re: [RFC PATCH v5 0/4] CXL: Standalone switch CCI driver
Message-ID: <kppexf75p3dqdvg7faktkfaukuykgexyktinyk22w3ogulpadc@b3o6nn45tlkt>
References: <20230804115414.14391-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230804115414.14391-1-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 04 Aug 2023, Jonathan Cameron wrote:

>//Testswitch.c
>#include <linux/types.h>
>#include <stdint.h>
>#include <sys/ioctl.h>
>#include <stdio.h>
>#include <fcntl.h>
>#include <stdlib.h>
>#define __user
>#include "cxl_mem.h" /* include/uapi/linux/cxl_mem.h */
>
>/* Move to appropriate header later */
>struct cxl_cmd_infostat_identify_rsp {
>  uint16_t pcie_vid;
>  uint16_t pcie_did;
>  uint16_t pcie_subsys_vid;
>  uint16_t pcie_subsys_id;
>  uint64_t sn;
>  uint8_t max_message_size;
>  uint8_t component_type;
>};
>
>struct cxl_cmd_infostat_get_bg_cmd_sts_rsp {
>  uint8_t status;
>  uint8_t rsvd;
>  uint16_t opcode;
>  uint16_t returncode;
>  uint16_t vendor_ext_status;
>};
>
>struct cxl_cmd_identify_switch_device_rsp {
>  uint8_t ingress_port_id;
>  uint8_t rsvd;
>  uint8_t num_physical_ports;
>  uint8_t num_vcs;
>  uint8_t active_port_bm[0x20];
>  uint8_t vcs_bm[0x20];
>  uint16_t total_num_vPPBs;
>  uint16_t num_bound_vPPBs;
>  uint8_t num_hdm_decoders;
>} __attribute__((packed));
>
>struct cci_message {
>  uint8_t message_cat;
>  uint8_t tag;
>  uint8_t resv;
>  uint8_t command;
>  uint8_t command_set;
>  uint8_t pl_length[3];
>  uint16_t ret_code;
>  uint16_t vendor_ext;
>  uint8_t payload[];
>};
>
>struct cxl_cmd_tunnel_command_req {
>  uint8_t id;
>  uint8_t target_type;
>  #define TUNNEL_TARGET_TYPE_PORT_OR_LD  0
>  #define TUNNEL_TARGET_TYPE_LD_POOL_CCI 1
>  uint16_t command_size;
>  struct cci_message message;
>};
>
>struct cxl_cmd_tunnel_command_resp {
>  uint16_t length;
>  uint16_t resv;
>  struct cci_message message;
>};
>
>
>int main()
>{
>  struct cxl_send_command cmd = {};
>  struct cxl_cmd_infostat_identify_rsp is_identify;
>  struct cxl_cmd_identify_switch_device_rsp switch_identify;
>  struct cxl_cmd_infostat_get_bg_cmd_sts_rsp bg_cmd_status;
>  struct cxl_cmd_tunnel_command_req *tunnel_req;
>  struct cxl_cmd_tunnel_command_resp *tunnel_resp;
>  int fd;
>  int rc, i;
>  int tun_cmd_size, tun_resp_size;
>
>  printf("Starting\n");
>  fd = open("/dev/cxl/switch0", O_RDWR);
>  if (fd < 0) {
>    printf("could not open file\n");
>    return 0;
>  }
>  cmd.id = CXL_MEM_COMMAND_ID_RAW;
>  cmd.id = CXL_MEM_COMMAND_ID_INFO_STAT_IDENTIFY;
>  cmd.out.size = sizeof(is_identify);
>  cmd.out.payload = (__u64)&is_identify;
>
>  rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>  if (rc) {
>    printf("rc %d\n", rc);
>    if (rc < 0)
>      return rc;
>  }
>
>  printf("Identify on switch:\n");
>  printf("VID:0x%04x DID:0x%04x\n", is_identify.pcie_vid, is_identify.pcie_did);
>  printf("Subsys: VID:0x%04x DID:0x%04x\n", is_identify.pcie_subsys_vid, is_identify.pcie_subsys_id);
>
>  cmd.id = CXL_MEM_COMMAND_ID_GET_BG_CMD_STATUS;
>  cmd.out.size = sizeof(bg_cmd_status);
>  cmd.out.payload = (__u64)&bg_cmd_status;
>
>  rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>  if (rc) {
>    printf("rc %d\n", rc);
>    if (rc < 0)
>      return rc;
>  }

I was under the impression that the BG status command would not be
exported to userspace (I assume its wanted for for bind vppb). While
polling on the status of the bg command, how does a user determine
whether or not the command finished and a new (same) one kicks in?
In theory userspace could poll forever.

Thanks,
Davidlohr

>
>  cmd.id = CXL_MEM_COMMAND_ID_IDENTIFY_SWITCH_DEVICE;
>  cmd.out.size = sizeof(switch_identify);
>  cmd.out.payload = (__u64)&switch_identify;
>
>  rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>  if (rc) {
>    printf("rc %d\n", rc);
>    if (rc < 0)
>      return rc;
>  }
>
>  printf("Switch indent ingress=%#x #ports=%d\n",
>	 switch_identify.ingress_port_id,
>	 switch_identify.num_physical_ports);
>  for (i = 0; i < sizeof(switch_identify.active_port_bm); i++) {
>    int j;
>    for (j = 0; j < 8; j++) {
>      if (switch_identify.active_port_bm[i] & 1 << j) {
>	printf("Port %x active\n", i * 8 + j);
>      }
>    }
>  }
>
>  tun_cmd_size = sizeof(*tunnel_req);
>  tunnel_req = malloc(tun_cmd_size);
>  tun_resp_size = sizeof(*tunnel_resp) + sizeof(struct cxl_cmd_infostat_identify_rsp);
>  tunnel_resp = malloc(tun_resp_size);
>  tunnel_req->target_type = TUNNEL_TARGET_TYPE_PORT_OR_LD;
>  tunnel_req->command_size = sizeof(tunnel_req->message);
>  tunnel_req->message.command = 0x01;
>  tunnel_req->message.command_set = 0x0; // tunnels within tunnels
>
>  cmd.id = CXL_MEM_COMMAND_ID_TUNNEL_MANAGEMENT_COMMAND;
>  cmd.in.payload = tunnel_req;
>  cmd.in.size = tun_cmd_size;
>  cmd.out.size = tun_resp_size;
>  cmd.out.payload = tunnel_resp;
>
>  rc = ioctl(fd, CXL_MEM_SEND_COMMAND, &cmd);
>  if (rc) {
>    printf("rc from tunnel cmd is %d\n", rc);
>    if (rc < 0)
>      return rc;
>  }
>  printf("message response size %d\n", cmd.out.size);
>  {
>    struct cxl_cmd_infostat_identify_rsp *pl = (void *)tunnel_resp->message.payload;
>	printf("Vendor id  : %04x\n", pl->pcie_vid);
>	printf("Device id  : %04x\n", pl->pcie_did);
>	printf("Subsys vid : %04x\n", pl->pcie_subsys_vid);
>	printf("Subsys id  : %04x\n", pl->pcie_subsys_id);
>
>	switch (pl->component_type) {
>	case 0x00:
>		printf("Switch!\n");
>		break;
>	case 0x03:
>		printf("Type3!\n");
>		break;
>	}
>  }
>  return 0;
>}
>
>Jonathan Cameron (4):
>  cxl: mbox: Preparatory move of functions to core/mbox.c and cxlmbox.h
>  cxl: mbox: Factor out the mbox specific data for reuse in switch cci
>  PCI: Add PCI_CLASS_SERIAL_CXL_SWITCH_CCI class ID to pci_ids.h
>  cxl/pci: Add support for stand alone CXL Switch mailbox CCI
>
> drivers/cxl/Kconfig          |  14 ++
> drivers/cxl/Makefile         |   2 +
> drivers/cxl/core/Makefile    |   1 +
> drivers/cxl/core/core.h      |  12 +-
> drivers/cxl/core/mbox.c      | 455 +++++++++++++++++++++++++++--------
> drivers/cxl/core/memdev.c    |  44 ++--
> drivers/cxl/core/regs.c      |  35 ++-
> drivers/cxl/core/switchdev.c | 129 ++++++++++
> drivers/cxl/cxl.h            |   4 +-
> drivers/cxl/cxlmbox.h        | 203 ++++++++++++++++
> drivers/cxl/cxlmem.h         | 176 ++------------
> drivers/cxl/pci.c            | 436 ++++++++++-----------------------
> drivers/cxl/pmem.c           |   6 +-
> drivers/cxl/security.c       |  13 +-
> drivers/cxl/switch.h         |  19 ++
> drivers/cxl/switchdev.c      | 170 +++++++++++++
> include/linux/pci_ids.h      |   1 +
> include/uapi/linux/cxl_mem.h |   4 +
> 18 files changed, 1128 insertions(+), 596 deletions(-)
> create mode 100644 drivers/cxl/core/switchdev.c
> create mode 100644 drivers/cxl/cxlmbox.h
> create mode 100644 drivers/cxl/switch.h
> create mode 100644 drivers/cxl/switchdev.c
>
>--
>2.39.2
>
