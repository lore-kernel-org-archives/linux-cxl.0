Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A8E29DB64
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125141; cv=none; b=TJYelgLgDsnJaSxFGaIB2JmvP1bP/3aa/SNpCqZMa7jxV2kdtQ8eE//FCfKHW879DIA+F4DOLBfNwRSKESHyVk+k6FhxmGomipXkx4P7F0YPRmrP9AqAbaQtknsVsHl2ZntMzwGkt3rTYPbmyrmVytphbt9NIF45P32VrSaf8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125141; c=relaxed/simple;
	bh=IuVydWHO0Bc3BQlu+FBWimNDWFnuIWiLdObI1ZnwUSk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAp5vQCJoV3W4kbbxJAjZqMt7MpUoSq/a1RAoGpn6Sk1+lbEo2IPveRObM60yS35/YMwLbR0ZMhO0rNciKpO72WBCpg4I/e5omMHw54C0riTVS+WdEuEGWYp3SsIYt8aJlT1FQPXYtWB/fVv3yHgY/1IdOBPRhRoUlUdYKCq/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRk8y4YkRz6GDQs;
	Thu, 18 Sep 2025 00:04:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E042B14033F;
	Thu, 18 Sep 2025 00:05:35 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 18:05:35 +0200
Date: Wed, 17 Sep 2025 17:05:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
	<krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250917170533.00003f03@huawei.com>
In-Reply-To: <20250916080736.1266083-3-arpit1.kumar@samsung.com>
References: <20250916080736.1266083-1-arpit1.kumar@samsung.com>
	<CGME20250916080808epcas5p23113551a9a0719d68a8c3efff15209cc@epcas5p2.samsung.com>
	<20250916080736.1266083-3-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 16 Sep 2025 13:37:36 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> -added assert-deassert PERST implementation
>  for physical ports (both USP and DSP's).
> -assert PERST involves bg operation for holding 100ms.
> -reset PPB implementation for physical ports.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
See below for why but I've picked this up with this and a define move that
was needed to build it where I've queued it up.

Thanks!

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6f7291e6ad..1d16d033c7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -607,7 +607,7 @@ static void *bg_assertcb(void *opaque)
     return NULL;
 }

-static CXLRetCode deassert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
+static CXLRetCode cxl_deassert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
 {
     if (!pp->pports.perst[pn].issued_assert_perst) {
         return CXL_MBOX_INTERNAL_ERROR;
@@ -623,7 +623,7 @@ static CXLRetCode deassert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
     return CXL_MBOX_SUCCESS;
 }

-static CXLRetCode assert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
+static CXLRetCode cxl_assert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
 {
     if (pp->pports.perst[pn].issued_assert_perst ||
         pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
@@ -668,7 +668,6 @@ static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
    CXLUpstreamPort *pp = CXL_USP(cci->d);
    PCIDevice *dev;
    uint8_t pn;
-   uint8_t ret = CXL_MBOX_SUCCESS;

    struct cxl_fmapi_get_physical_port_control_req_pl {
         uint8_t ppb_id;
@@ -691,22 +690,19 @@ static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,

     switch (in->ports_op) {
     case 0:
-        ret = assert_perst(OBJECT(&dev->qdev), pn, pp);
-        break;
+        return cxl_assert_perst(OBJECT(&dev->qdev), pn, pp);
     case 1:
-        ret = deassert_perst(OBJECT(&dev->qdev), pn, pp);
-        break;
+        return cxl_deassert_perst(OBJECT(&dev->qdev), pn, pp);
     case 2:
         if (pp->pports.perst[pn].issued_assert_perst ||
             pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
             return CXL_MBOX_INTERNAL_ERROR;
         }
         device_cold_reset(&dev->qdev);
-        break;
+        return CXL_MBOX_SUCCESS;
     default:
         return CXL_MBOX_INVALID_INPUT;
     }
-    return ret;
 }

> ---
>  hw/cxl/cxl-mailbox-utils.c                | 139 ++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h               |   9 ++
>  include/hw/cxl/cxl_mailbox.h              |   1 +

Had to move the define for now that went in here because I'm carrying this
further up my tree than Anisa's patch that moved this as a precursor
to the MCTP support.


>  include/hw/pci-bridge/cxl_upstream_port.h |   1 +
>  4 files changed, 150 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2a104dd337..8cccb2c0ed 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -541,6 +541,120 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void *bg_assertcb(void *opaque)
> +{
> +    CXLPhyPortPerst *perst = opaque;
> +
> +    /* holding reset phase for 100ms */
> +    while (perst->asrt_time--) {
> +        usleep(1000);
> +    }
> +    perst->issued_assert_perst = true;
> +    return NULL;
> +}
> +
> +static CXLRetCode deassert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)

I think we want to namespace these to cxl given these are not
a PCI standard thing.  So when I pick these up I'll prefix with cxl_

> +{
> +    if (!pp->pports.perst[pn].issued_assert_perst) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    QEMU_LOCK_GUARD(&pp->pports.perst[pn].lock);
> +    resettable_release_reset(obj, RESET_TYPE_COLD);
> +    pp->pports.perst[pn].issued_assert_perst = false;
> +    pp->pports.pport_info[pn].link_state_flags &=
> +        ~CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED;
> +    pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static CXLRetCode assert_perst(Object *obj, uint8_t pn, CXLUpstreamPort *pp)
> +{
> +    if (pp->pports.perst[pn].issued_assert_perst ||
> +        pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    QEMU_LOCK_GUARD(&pp->pports.perst[pn].lock);
> +    pp->pports.pport_info[pn].link_state_flags |=
> +        CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED;
> +    resettable_assert_reset(obj, RESET_TYPE_COLD);
> +    qemu_thread_create(&pp->pports.perst[pn].asrt_thread, "assert_thread",
> +        bg_assertcb, &pp->pports.perst[pn], QEMU_THREAD_DETACHED);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static struct PCIDevice *cxl_find_port_dev(uint8_t pn, CXLCCI *cci)
> +{
> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
> +
> +    if (pp->pports.pport_info[pn].current_port_config_state ==
> +        CXL_PORT_CONFIG_STATE_USP) {
> +        return pci_bridge_get_device(bus);
> +    }
> +
> +    if (pp->pports.pport_info[pn].current_port_config_state ==
> +        CXL_PORT_CONFIG_STATE_DSP) {
> +        return pcie_find_port_by_pn(bus, pn);
> +    }
> +    return NULL;
> +}
> +
> +/* CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h) */
> +static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
> +                                            uint8_t *payload_in,
> +                                            size_t len_in,
> +                                            uint8_t *payload_out,
> +                                            size_t *len_out,
> +                                            CXLCCI *cci)
> +{
> +   CXLUpstreamPort *pp = CXL_USP(cci->d);
> +   PCIDevice *dev;
> +   uint8_t pn;
> +   uint8_t ret = CXL_MBOX_SUCCESS;
> +
> +   struct cxl_fmapi_get_physical_port_control_req_pl {
> +        uint8_t ppb_id;
> +        uint8_t ports_op;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    pn = in->ppb_id;
> +    if (pp->pports.pport_info[pn].port_id != pn) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    dev = cxl_find_port_dev(pn, cci);
> +    if (!dev) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    switch (in->ports_op) {
> +    case 0:
> +        ret = assert_perst(OBJECT(&dev->qdev), pn, pp);
To me, direct returns are clearer here.
     return cxl_assert_perst();

I tweaked this and the other case statements in here.  That lets
me drop the local variable ret and the return code hidden up top.

> +        break;
> +    case 1:
> +        ret = deassert_perst(OBJECT(&dev->qdev), pn, pp);
> +        break;
> +    case 2:
> +        if (pp->pports.perst[pn].issued_assert_perst ||
> +            pp->pports.perst[pn].asrt_time < ASSERT_WAIT_TIME_MS) {
> +            return CXL_MBOX_INTERNAL_ERROR;
> +        }
> +        device_cold_reset(&dev->qdev);
> +        break;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    return ret;
> +}
> +
>  /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
>  static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in,
> @@ -4347,6 +4461,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>          cmd_identify_switch_device, 0, 0 },
>      [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
>          cmd_get_physical_port_state, ~0, 0 },
> +    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
> +        cmd_physical_port_control, 2, 0 },
>      [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
>                                       cmd_tunnel_management_cmd, ~0, 0 },
>  };
> @@ -4702,11 +4818,34 @@ static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
>                                    DeviceState *d, size_t payload_max)
>  {
> +    CXLUpstreamPort *pp;
> +    uint8_t pn = 0;
> +
>      cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
>      cxl_set_phy_port_info(cci);
> +    /* physical port control */
> +    pp = CXL_USP(cci->d);
> +    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
> +         byte_index++) {
> +        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
> +
> +        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
> +            if (((byte) & (1 << bit_index)) != 0) {
> +                qemu_mutex_init(&pp->pports.perst[pn].lock);
> +                pp->pports.perst[pn].issued_assert_perst = false;
> +                /*
> +                 * Assert PERST involves physical port to be in
> +                 * hold reset phase for minimum 100ms. No other
> +                 * physical port control requests are entertained
> +                 * until Deassert PERST command.
> +                 */
> +                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
> +            }
> +        }
> +    }
>  }
>  
>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
