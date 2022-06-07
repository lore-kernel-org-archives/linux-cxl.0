Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F73FC43334
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Jun 2022 16:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiFGQTh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344866AbiFGQTe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Jun 2022 12:19:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4F0101922
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 09:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EA6AB82185
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 16:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58103C385A5;
        Tue,  7 Jun 2022 16:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654618771;
        bh=9+2dfeP1OSMKbF4syE80xXLqc41JvlGenoGHaBBY/e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ptq1ClyHB6v4lKyr3Y4GXWmlGY9oCY/MoJUaN7Qk73w3OPulkeV6NfXjlFZQgnv1h
         OWCMJpltWFxNMeT7FGd7dR1FdMmjdTZnG2VsTu8GNclR3j0rTjPfTQ+KopvnqzdSh8
         j5WNAohJSnqdr+iWXcPwdzdrVGDvI73I4MC+7040Y4t1WXpaesWA4x4gpF6+dDOX9L
         pdAFTggqEikNgqPk1qVW+HXxeXGqe6XZXe1lmIDNSCNEeKIdwgQBT/ACsiEXKNhqW4
         fP7qwcUZQaNG+fiyOrEG5UayhLNrbymhZbe/C4NfL/WJRPshRM3b8QT1eOikMbvVb1
         0NgCXDH+HjPZg==
Date:   Tue, 7 Jun 2022 09:19:28 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, alex.bennee@linaro.org,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3] hw/cxl: Fix missing write mask for HDM decoder target
 list registers
Message-ID: <20220607161928.364mrju2mvzcvs56@bwidawsk-mobl5>
References: <20220607160747.21084-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607160747.21084-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-06-07 17:07:47, Jonathan Cameron wrote:
> Without being able to write these registers, no interleaving is possible.
> More refined checks of HDM register state on commit to follow.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Actually pass the parameter to the call...
> v2: (Ben Widawsky)
> - Correctly set a tighter write mask for the endpoint devices where this
>   register has a different use.
>   
>  hw/cxl/cxl-component-utils.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 7985c9bfca..2208284ee6 100644
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

Should it be (type == CXL2_DEVICE || type == CXL2_TYPE3_DEVICE) ?

Otherwise,
Reviewed-by: Ben Widawsky <ben@bwidawsk.net>

>      }
>  }
>  
> @@ -239,7 +246,7 @@ void cxl_component_register_init_common(uint32_t *reg_state, uint32_t *write_msk
>      }
>  
>      init_cap_reg(HDM, 5, 1);
> -    hdm_init_common(reg_state, write_msk);
> +    hdm_init_common(reg_state, write_msk, type);
>  
>      if (caps < 5) {
>          return;
> -- 
> 2.32.0
> 
