Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591DC07E9D
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Sep 2022 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiI0QrP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiI0Qqq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Sep 2022 12:46:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623014BA53
        for <linux-cxl@vger.kernel.org>; Tue, 27 Sep 2022 09:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41A05B81C87
        for <linux-cxl@vger.kernel.org>; Tue, 27 Sep 2022 16:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDCEC433D7;
        Tue, 27 Sep 2022 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664297152;
        bh=mXLjU0NnaHtLCXzlZQdzs2AQEJ7WwomDsI5Ppifs1N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDkUbYfhgQpMOR4xOAGIpvC3KUpRrpv2Cb0i6vSlbE8N8lYMndgpVozg6zSru4iQT
         5fvJ0rypXB8osEQeEebIHIV+HypX4bJsAFFTAiXS5Bwqwj9tlkhFvusvCLtXdfSAnf
         JlIE66fDvqqZFYTcGtZv6zPpIzgOsU7iyRNircn79t4QmfdHEnBfAy5/DvIyfbJsWp
         1KqFlnSk8gRyghRxvOeR8nTetbwUEktzTAr9X+lApS7bkEdz2kvMKuT7eSY8JxHzv/
         Mh3/juQbl2JONbdhK2WDET+DvrmQum38ZYeZPKW7X5LRYBhp43Ii6U+iDa0GIjsgl5
         CpaStx0/nHVTg==
Date:   Tue, 27 Sep 2022 09:45:49 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
        "Michael S . Tsirkin" <mst@redhat.com>, linuxarm@huawei.com
Subject: Re: [PATCH] mem/cxl-type3: Add sn option to provide serial number
 for PCI ecap
Message-ID: <20220927164549.4rcc7ttrkc7tod7g@bwidawsk-mobl5>
References: <20220923161835.9805-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923161835.9805-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-09-23 17:18:35, Jonathan Cameron wrote:
> The Device Serial Number Extended Capability PCI r6.0 sec 7.9.3
> provides a standard way to provide a device serial number as
> an IEEE defined 64-bit extended unique identifier EUI-64.
> 
> CXL 2.0 section 8.1.12.2 Memory Device PCIe Capabilities and
> Extended Capabilities requires this to be used to uniquely
> identify CXL memory devices.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>

> ---
> 
> This is the missing element to be able to use the Linux kernel
> support for PMEM region creation.  Without this you can create
> a region, but not remount it after reboot (as the label
> is not valid).
> 
>  hw/mem/cxl_type3.c          | 14 +++++++++++++-
>  include/hw/cxl/cxl_device.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3bf2869573..e0c1535b73 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -14,6 +14,12 @@
>  #include "sysemu/hostmem.h"
>  #include "hw/cxl/cxl.h"
>  
> +/*
> + * Null value of all Fs suggested by IEEE RA guidelines for use of
> + * EU, OUI and CID
> + */
> +#define UI64_NULL ~(0ULL)
> +
>  static void build_dvsecs(CXLType3Dev *ct3d)
>  {
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> @@ -149,7 +155,12 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
> -    cxl_cstate->dvsec_offset = 0x100;
> +    if (ct3d->sn != UI64_NULL) {
> +        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> +        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> +    } else {
> +        cxl_cstate->dvsec_offset = 0x100;
> +    }

Perhaps just always make it 0x10c to keep it simple and debuggable?

>  
>      ct3d->cxl_cstate.pdev = pci_dev;
>      build_dvsecs(ct3d);
> @@ -275,6 +286,7 @@ static Property ct3_props[] = {
>                       HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
> +    DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 1e141b6621..e4d221cdb3 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -237,6 +237,7 @@ struct CXLType3Dev {
>      /* Properties */
>      HostMemoryBackend *hostmem;
>      HostMemoryBackend *lsa;
> +    uint64_t sn;
>  
>      /* State */
>      AddressSpace hostmem_as;
> -- 
> 2.32.0
> 
