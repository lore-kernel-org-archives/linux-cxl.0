Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD32339A8
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455561; cv=none; b=VcGASBpt4dCwD4mavrBNadg4v+1Xnth9IiqchyG2Nh8XLEFZQsgZNY/cWE07QDOOeA+Fco4CFxiy1rhgaszm65BiRuaA3OsGUn1DPXXwa+RRyeOvF1MO41pdlsCwWL0On4/8CTiZb94pukW+Tl6TRz120FCrcjEbMcc9kcP4dIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455561; c=relaxed/simple;
	bh=PfV9P3qgJCwCwVsArXYl0p9tt2tYH5wfRSA2UDa7ndk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSiH1vVmWrs1H7wsRGgxic8W4oOsMrmrnIGMweHjN7S6UHbaovLxQYPM0DEoxOMeyVqhXZY5uLT/TDxQdEpTGIh3G8Fz8v5nceQXGYz7m7ubVG6eu+2uyuMNPD5cdOPlswR6JVluA/TWib++yKXxVKps8AD8diBKiXAZKuFOvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpWFB6VNqz6L59k;
	Fri, 25 Jul 2025 22:57:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B0B9E1400DC;
	Fri, 25 Jul 2025 22:59:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 16:59:14 +0200
Date: Fri, 25 Jul 2025 15:59:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v2 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250725155912.0000551d@huawei.com>
In-Reply-To: <20250710144338.2839512-3-arpit1.kumar@samsung.com>
References: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
	<CGME20250710144358epcas5p1bf06af9ee56880a24421a2f7a7d6c113@epcas5p1.samsung.com>
	<20250710144338.2839512-3-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Jul 2025 20:13:38 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> -added assert-deassert PERST implementation
>  for physical ports (both USP and DSP's).
> -assert PERST involves bg operation for holding 100ms.
> -reset PPB implementation for physical ports.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Hi Arpit,

Minor comments inline.

We have plenty of time given where the qemu cycle is, so no huge rush
for a v3.

Jonathan

> +static struct PCIDevice *cxl_find_port_dev(uint8_t pn, CXLCCI *cci)
> +{
> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
> +
> +    if (pp->pports.pport_info[pn].current_port_config_state ==
> +        CXL_PORT_CONFIG_STATE_USP) {
> +        PCIDevice *usp_dev = pci_bridge_get_device(bus);
> +        return usp_dev;

As below.

> +    }
> +
> +    if (pp->pports.pport_info[pn].current_port_config_state ==
> +        CXL_PORT_CONFIG_STATE_DSP) {
> +        PCIDevice *dsp_dev = pcie_find_port_by_pn(bus, pn);
> +        return dsp_dev;

What benefit do we get from a local variable?

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
> +    uint8_t pn = in->ppb_id;

Avoid inline declarations of local variables. 

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

> @@ -3810,4 +3932,17 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
>      cxl_set_phy_port_info(cci);
> +    /* physical port control */
> +    CXLUpstreamPort *pp = CXL_USP(cci->d);

Still sticking to the old style c option of declarations at the top of the scope.

> +    for (int i = 0; i < CXL_MAX_PHY_PORTS; i++) {
> +        qemu_mutex_init(&pp->pports.perst[i].lock);
> +        pp->pports.perst[i].issued_assert_perst = false;
> +        /*
> +         * Assert PERST involves physical port to be in
> +         * hold reset phase for minimum 100ms. No other
> +         * physcial port control requests are entertained
> +         * until Deassert PERST command.
> +         */
> +         pp->pports.perst[i].asrt_time = ASSERT_WAIT_TIME_MS;
> +    }
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 1fa6cf7536..bb47e671eb 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -128,6 +128,7 @@
>                    (1 << 16))
>  
>  #define CXL_MAX_PHY_PORTS 256
> +#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
>  
>  #define LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
>  #define LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
> @@ -203,10 +204,19 @@ struct cxl_phy_port_info {
>      uint8_t supported_ld_count;
>  } QEMU_PACKED;
>  
> +/* Assert - Deassert PERST */
> +struct pperst {

Prefix this name. pperst is a PCIE thing so it may otherwise end up confusing.

> +    bool issued_assert_perst;
> +    QemuMutex lock;

Good practice to add a comment to say exactly what data this lock is protecting.

> +    uint64_t asrt_time;
> +    QemuThread asrt_thread; /* thread for 100ms delay */
> +};
> +
>  struct phy_port {
>      uint8_t num_ports;
>      uint8_t active_port_bitmask[0x20];
>      struct cxl_phy_port_info pport_info[CXL_MAX_PHY_PORTS];
> +    struct pperst perst[CXL_MAX_PHY_PORTS];
>  };
>  
>  /* CXL r3.1 Table 8-34: Command Return Codes */

