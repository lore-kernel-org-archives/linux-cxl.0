Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51294C77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  2 May 2023 08:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjEBIzX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 May 2023 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjEBIzT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 May 2023 04:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5A51980
        for <linux-cxl@vger.kernel.org>; Tue,  2 May 2023 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683017679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7MRvn+36vnRrucFztl/iXQPBBeFdrWe3EVNFU0OdjY=;
        b=Y3FCzBIRNtsL9MAvqDfkyW83FZOKtzMln+LY4rx7dNwA/DlIqoc6ZZz4YJVzs2aCdG31h5
        zZDvv8eFxwxfJW+LVD1XgVm7dw5g82vPm3xG1+s1QDEufhc5CZovryC/WjKxmlF8XmBNYZ
        5AEfo9nmOb4IADKguGm8n6wrD0jUZvE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-21WaGNrrP6aBRhfq2mn68A-1; Tue, 02 May 2023 04:54:38 -0400
X-MC-Unique: 21WaGNrrP6aBRhfq2mn68A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f33f8ffa37so5473695e9.2
        for <linux-cxl@vger.kernel.org>; Tue, 02 May 2023 01:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683017676; x=1685609676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7MRvn+36vnRrucFztl/iXQPBBeFdrWe3EVNFU0OdjY=;
        b=OMqD7ZPhyZgfVTA18551u1XUK0bjTuH3d47b/ComJs+tvNYfPPbMmJ6GRor9CwAItE
         3Ch3iMI0XptvA2T/jOrBfU5okDfNtKBYJyavTyEyGCKE6s2vNId3zHr68OQtArewD6GQ
         avtpTxKMr5ZsVAvVYSy7YnDLMAmbOUCR2oTbsOrGiPH1l4r88izsupYlVgGEiAT5ABYR
         NLIpqAuPRAm8/+Yve+PuRBjN9ucVUtofdDQyk7GWoe0HxaARk/vwuuYb7MVr5yIP0GNh
         89N3AgSOcKMb2LZJDtJ6gqcHIefixYoz58llC9gEjnssLyFYxnAn8D4hJ8wLUJnLFahL
         +8Bw==
X-Gm-Message-State: AC+VfDzbKlWFSB6pvNcM/Q56W9/s8MNjf9KhtJRJ/6gjQnhSP+2VyoaA
        /AYeP9BGbrrOyNNfAwNFmFBmadAxcIHr63hqE8lEMKTb0f9gqeGPl1Ax9riyY7+gHKzDOy1MbkO
        he+OZyoADKlfksOeR2HhL
X-Received: by 2002:adf:e9cf:0:b0:306:2aa7:2ed2 with SMTP id l15-20020adfe9cf000000b003062aa72ed2mr4531161wrn.61.1683017675940;
        Tue, 02 May 2023 01:54:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lJwsdp+y3J4lTX0yNOTHKpPJy9RVsUO/rkcORPFrEcUGKB6ShBjz/zh6Q80mKUuVFIPH+dQ==
X-Received: by 2002:adf:e9cf:0:b0:306:2aa7:2ed2 with SMTP id l15-20020adfe9cf000000b003062aa72ed2mr4531143wrn.61.1683017675588;
        Tue, 02 May 2023 01:54:35 -0700 (PDT)
Received: from redhat.com ([2.52.8.43])
        by smtp.gmail.com with ESMTPSA id n10-20020a1c720a000000b003edef091b17sm34389793wmc.37.2023.05.02.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 01:54:34 -0700 (PDT)
Date:   Tue, 2 May 2023 04:54:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 1/8] hw/pci/aer: Implement PCI_ERR_UNCOR_MASK
 register
Message-ID: <20230502045358-mutt-send-email-mst@kernel.org>
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
 <20230302133709.30373-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230302133709.30373-2-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 01:37:02PM +0000, Jonathan Cameron wrote:
> This register in AER should be both writeable and should
> have a default value with a couple of the errors masked
> including the Uncorrectable Internal Error used by CXL for
> it's error reporting.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

OK it does not look like a fix to migration breakage
is forth coming so I'll revert this patchset for now.



> ---
>  hw/pci/pcie_aer.c          | 4 ++++
>  include/hw/pci/pcie_regs.h | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 9a19be44ae..909e027d99 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -112,6 +112,10 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
>  
>      pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
>                   PCI_ERR_UNC_SUPPORTED);
> +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
> +                 PCI_ERR_UNC_MASK_DEFAULT);
> +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
> +                 PCI_ERR_UNC_SUPPORTED);
>  
>      pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
>                   PCI_ERR_UNC_SEVERITY_DEFAULT);
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 963dc2e170..6ec4785448 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -155,6 +155,9 @@ typedef enum PCIExpLinkWidth {
>                                           PCI_ERR_UNC_ATOP_EBLOCKED |    \
>                                           PCI_ERR_UNC_TLP_PRF_BLOCKED)
>  
> +#define PCI_ERR_UNC_MASK_DEFAULT        (PCI_ERR_UNC_INTN | \
> +                                         PCI_ERR_UNC_TLP_PRF_BLOCKED)
> +
>  #define PCI_ERR_UNC_SEVERITY_DEFAULT    (PCI_ERR_UNC_DLP |              \
>                                           PCI_ERR_UNC_SDN |              \
>                                           PCI_ERR_UNC_FCP |              \
> -- 
> 2.37.2

