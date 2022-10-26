Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C63BC38A2D
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiJZUGq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiJZUG1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA253AC286
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666814785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kJbtSYiPhNxQ2HMlsmhAY3yYtRvixnk1SRvZ0hFQjaI=;
        b=G32FHutI8CLBun32mOrSVolQAsW//gBk7PAAGCEgneM3ic8KWFuZG7hvdAl3Bm99nZHB6s
        5FAoDLQvfLrP+CLP5P0d1PUAOPa2W78rdg+zIbCq619ZoWvyLz9yLbxGOCikF5vKKm5y6e
        HbXlS9FMtqekQdTcFbiv8XGp0stWs5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-hBMkjDnHNG2viIk9yqMnAw-1; Wed, 26 Oct 2022 16:06:24 -0400
X-MC-Unique: hBMkjDnHNG2viIk9yqMnAw-1
Received: by mail-wr1-f71.google.com with SMTP id r22-20020adfa156000000b0023660e969ddso4991569wrr.19
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJbtSYiPhNxQ2HMlsmhAY3yYtRvixnk1SRvZ0hFQjaI=;
        b=28Tvm38OFTKyIDETTnr++9+F+tokelWnkA7dwsZzm4LUelZOwzDH3QtaiIPh3zi+Gv
         P9sGokx1xXxJ7vqnk6Tvz/rOPCm9ouNJ65gOsXMplcz2Z3pK4LuzAfRgxyc6ZAWMRh/F
         hNyNz+zsEWUWYGNFOSyUlpVlqD5v1bvYNjK3T4XkqyPPiUDmrSWksIKhJ7EcACVTk0hU
         aG/lDqJOqt8RSjb6BJWp1NAULM06Y0ZD9NgmOV1XwFnoyt0bKCC+hpKL91UjYn47Um0j
         BAeAgKv/hKZGWQmBuDzb0frxymij+Cw5E2Kgx6kan5Aqx7Fw+PGMWsTN+SHcYCd0VWp4
         acXg==
X-Gm-Message-State: ACrzQf0JjrDcTyHIYLOp3a/JjBX5z1xIpXFdGY08Gw8SK9AjC1hMQ2TT
        iN35/T56Rm9MErla+KQKZvFu/7UjBdHeolBxScT8tmyfHUP0V297TIzY2dVRQ1tg65O+Cip7Nmy
        ugoSq5NcavQu00h+6rdWC
X-Received: by 2002:a05:600c:19d1:b0:3c7:b52:3aa4 with SMTP id u17-20020a05600c19d100b003c70b523aa4mr3699402wmq.56.1666814783406;
        Wed, 26 Oct 2022 13:06:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7CDoZL0RCSiT7Kxb1lDkPQKvatbpa5r0k7WVPhTpSMtuycc4dq+Zgv5Oxk5oEe8hdvfCN8+Q==
X-Received: by 2002:a05:600c:19d1:b0:3c7:b52:3aa4 with SMTP id u17-20020a05600c19d100b003c70b523aa4mr3699385wmq.56.1666814783199;
        Wed, 26 Oct 2022 13:06:23 -0700 (PDT)
Received: from redhat.com ([2.52.15.7])
        by smtp.gmail.com with ESMTPSA id d5-20020a05600c34c500b003cf4d99fd2asm1855476wmq.6.2022.10.26.13.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:06:21 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:06:18 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, bwidawsk@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Message-ID: <20221026160545-mutt-send-email-mst@kernel.org>
References: <20221006233702.18532-1-gregory.price@memverge.com>
MIME-Version: 1.0
In-Reply-To: <20221006233702.18532-1-gregory.price@memverge.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 06, 2022 at 07:37:01PM -0400, Gregory Price wrote:
> Current code sets to STORAGE_EXPRESS and then overrides it.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

If you expect me to merge it you need to CC me.
Also, do we need this separately from the series?

> ---
>  hw/mem/cxl_type3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ada2108fac..1837c1c83a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -146,7 +146,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>      }
>  
>      pci_config_set_prog_interface(pci_conf, 0x10);
> -    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>      cxl_cstate->dvsec_offset = 0x100;
> @@ -335,7 +334,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>  
>      pc->realize = ct3_realize;
>      pc->exit = ct3_exit;
> -    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> +    pc->class_id = PCI_CLASS_MEMORY_CXL;
>      pc->vendor_id = PCI_VENDOR_ID_INTEL;
>      pc->device_id = 0xd93; /* LVF for now */
>      pc->revision = 1;
> -- 
> 2.37.3
> 
> 

