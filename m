Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BA9C636D6
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 21:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBQViw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBQViv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 16:38:51 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF9B60A48
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676669931; x=1708205931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3BQA4sS//3VABDV2ayavENiGLTEUUqEzhhRuMUKPJPk=;
  b=QSmb8td9dXRMrdODBcnx0F/ptco9WVpMOG6w2EWeEHVSC6ttih47gZKO
   HMNZwkaxNEzgI/ZlhwOi5isSbk3oQ9vmlbkIbDTp2FM6bD8gMzs6NO5Pw
   uEfvv1Y4TcG5+Fx5CNC3kf0eTk8+gK6INQZXedJSYqk4pdFaN3uBDBag2
   xc0eOYC5aeeqcDR4wZCEGXK2B2gFq0KqXimp0MUtUKGlIINhHXZSc5JcD
   kxgQqW2xVFy2ATztPHlzPzPPx6keGtQvStbqqM61ttb6P8ruePFgv9VCS
   nNzsQei4mGJdQshxA4ZbQ/LuPwSx88IO0cj40Z5v46/oIhZPcvW8zmsjV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="332103303"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="332103303"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:38:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="703078338"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="703078338"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:38:49 -0800
Message-ID: <d71a40d3-9d1e-2e85-c2f3-34e70474f3d4@intel.com>
Date:   Fri, 17 Feb 2023 14:38:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/8] hw/pci-bridge/cxl_root_port: Wire up MSI
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20230217172924.25239-1-Jonathan.Cameron@huawei.com>
 <20230217172924.25239-5-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217172924.25239-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 10:29 AM, Jonathan Cameron wrote:
> Done to avoid fixing ACPI route description of traditional PCI interrupts on q35
> and because we should probably move with the times anyway.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   hw/pci-bridge/cxl_root_port.c | 61 +++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 00195257f7..7dfd20aa67 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -22,6 +22,7 @@
>   #include "qemu/range.h"
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/pcie_port.h"
> +#include "hw/pci/msi.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/sysbus.h"
>   #include "qapi/error.h"
> @@ -29,6 +30,10 @@
>   
>   #define CXL_ROOT_PORT_DID 0x7075
>   
> +#define CXL_RP_MSI_OFFSET               0x60
> +#define CXL_RP_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_MASKBIT
> +#define CXL_RP_MSI_NR_VECTOR            2
> +
>   /* Copied from the gen root port which we derive */
>   #define GEN_PCIE_ROOT_PORT_AER_OFFSET 0x100
>   #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
> @@ -47,6 +52,49 @@ typedef struct CXLRootPort {
>   #define TYPE_CXL_ROOT_PORT "cxl-rp"
>   DECLARE_INSTANCE_CHECKER(CXLRootPort, CXL_ROOT_PORT, TYPE_CXL_ROOT_PORT)
>   
> +/*
> + * If two MSI vector are allocated, Advanced Error Interrupt Message Number
> + * is 1. otherwise 0.
> + * 17.12.5.10 RPERRSTS,  32:27 bit Advanced Error Interrupt Message Number.
> + */
> +static uint8_t cxl_rp_aer_vector(const PCIDevice *d)
> +{
> +    switch (msi_nr_vectors_allocated(d)) {
> +    case 1:
> +        return 0;
> +    case 2:
> +        return 1;
> +    case 4:
> +    case 8:
> +    case 16:
> +    case 32:
> +    default:
> +        break;
> +    }
> +    abort();
> +    return 0;
> +}
> +
> +static int cxl_rp_interrupts_init(PCIDevice *d, Error **errp)
> +{
> +    int rc;
> +
> +    rc = msi_init(d, CXL_RP_MSI_OFFSET, CXL_RP_MSI_NR_VECTOR,
> +                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
> +                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
> +                  errp);
> +    if (rc < 0) {
> +        assert(rc == -ENOTSUP);
> +    }
> +
> +    return rc;
> +}
> +
> +static void cxl_rp_interrupts_uninit(PCIDevice *d)
> +{
> +    msi_uninit(d);
> +}
> +
>   static void latch_registers(CXLRootPort *crp)
>   {
>       uint32_t *reg_state = crp->cxl_cstate.crb.cache_mem_registers;
> @@ -183,6 +231,15 @@ static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
>       }
>   }
>   
> +static void cxl_rp_aer_vector_update(PCIDevice *d)
> +{
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
> +
> +    if (rpc->aer_vector) {
> +        pcie_aer_root_set_vector(d, rpc->aer_vector(d));
> +    }
> +}
> +
>   static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
>                                   int len)
>   {
> @@ -192,6 +249,7 @@ static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
>   
>       pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
>       pci_bridge_write_config(d, address, val, len);
> +    cxl_rp_aer_vector_update(d);
>       pcie_cap_flr_write_config(d, address, val, len);
>       pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
>       pcie_aer_write_config(d, address, val, len);
> @@ -220,6 +278,9 @@ static void cxl_root_port_class_init(ObjectClass *oc, void *data)
>   
>       rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
>       rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
> +    rpc->aer_vector = cxl_rp_aer_vector;
> +    rpc->interrupts_init = cxl_rp_interrupts_init;
> +    rpc->interrupts_uninit = cxl_rp_interrupts_uninit;
>   
>       dc->hotpluggable = false;
>   }
