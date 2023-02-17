Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AB5C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 21:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBQVrS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBQVrR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 16:47:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893C3B20F
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676670437; x=1708206437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NTmRDkTq/3zwC48YMDtAaY4wKqcKEsPOrmar5Gt4CTs=;
  b=Mf4r8Df5ggkONM5awIOHUw+BgyFIy4B+hhR5XEc5Syg8v+6YxnmiuZlU
   9fJGNz81ACS/OdWMCp8O6EYMKRsW5rU1fZQhibARMSuJo7ru4yhDXHL6E
   SYc3WJ0S+IGLgeoJU6yM3fqHmHNySNC0y8nPhJOsmWAv05bGgJaNx5gDs
   WjIynipnUspopxw30CCADTDfkdnoPltu9jeKBWsxqRxJqJrIIbe0jvsN6
   49rL1A2PIa/dhXZIuPBszCUpMBogDGfl19qfzAr9m9NTaCJlq3Lw2vJUm
   lnlRCpPdP3eQbuE2KhtxLI5ymnUbMWvqU91d4m6QQ2JXZTWyxBmT5JrPu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="320203472"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="320203472"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:47:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="670687658"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="670687658"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:47:15 -0800
Message-ID: <06665188-dcf9-441b-8393-a5ff443f6828@intel.com>
Date:   Fri, 17 Feb 2023 14:47:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 5/8] hw/mem/cxl-type3: Add AER extended capability
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
 <20230217172924.25239-6-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217172924.25239-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 10:29 AM, Jonathan Cameron wrote:
> This enables AER error injection to function as expected.
> It is intended as a building block in enabling CXL RAS error injection
> in the following patches.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   hw/mem/cxl_type3.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 217a5e639b..6cdd988d1d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -250,6 +250,7 @@ static void ct3d_config_write(PCIDevice *pci_dev, uint32_t addr, uint32_t val,
>   
>       pcie_doe_write_config(&ct3d->doe_cdat, addr, val, size);
>       pci_default_write_config(pci_dev, addr, val, size);
> +    pcie_aer_write_config(pci_dev, addr, val, size);
>   }
>   
>   /*
> @@ -452,8 +453,19 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>       cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
>       cxl_cstate->cdat.private = ct3d;
>       cxl_doe_cdat_init(cxl_cstate, errp);
> +
> +    pcie_cap_deverr_init(pci_dev);
> +    /* Leave a bit of room for expansion */
> +    rc = pcie_aer_init(pci_dev, PCI_ERR_VER, 0x200, PCI_ERR_SIZEOF, NULL);
> +    if (rc) {
> +        goto err_release_cdat;
> +    }
> +
>       return;
>   
> +err_release_cdat:
> +    cxl_doe_cdat_release(cxl_cstate);
> +    g_free(regs->special_ops);
>   err_address_space_free:
>       address_space_destroy(&ct3d->hostmem_as);
>       return;
> @@ -465,6 +477,7 @@ static void ct3_exit(PCIDevice *pci_dev)
>       CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
>       ComponentRegisters *regs = &cxl_cstate->crb;
>   
> +    pcie_aer_exit(pci_dev);
>       cxl_doe_cdat_release(cxl_cstate);
>       g_free(regs->special_ops);
>       address_space_destroy(&ct3d->hostmem_as);
