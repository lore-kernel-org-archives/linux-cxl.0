Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9627ECCA47F
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Jun 2022 11:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbiFGLLV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Jun 2022 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiFGLKE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Jun 2022 07:10:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233573BF8F
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 04:06:17 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LHS8r4HPcz684Xd;
        Tue,  7 Jun 2022 19:01:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 7 Jun 2022 13:06:14 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 12:06:13 +0100
Date:   Tue, 7 Jun 2022 12:06:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2] hw/cxl: Fix missing write mask for HDM decoder
 target list registers
Message-ID: <20220607120612.00000db7@Huawei.com>
In-Reply-To: <20220607105617.16459-1-Jonathan.Cameron@huawei.com>
References: <20220607105617.16459-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 7 Jun 2022 11:56:17 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Without being able to write these registers, no interleaving is possible.
> More refined checks of HDM register state on commit to follow.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

+Cc Ben on current address.

Which reminds me - Ben, when you have time please send an update
to MAINTAINERS to switch to your preferred email address going forwards.

Thanks,

Jonathan

> ---
> v2: (Ben Widawsky)
> - Correctly set a tighter write mask for the endpoint devices where this
>   register has a different use.
> 
>  hw/cxl/cxl-component-utils.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 7985c9bfca..40a0f752f2 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -154,7 +154,8 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>      reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0x00;
>  }
>  
> -static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
> +static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> +                            enum reg_type type)
>  {
>      int decoder_count = 1;
>      int i;
> @@ -174,6 +175,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
>          write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
>          write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
>          write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
> +        if (type == CXL2_DEVICE) {
> +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
> +        } else {
> +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
> +        }
> +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;
>      }
>  }
>  

