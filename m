Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8876AC43334
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Jun 2022 17:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiFFRj5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiFFRj4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Jun 2022 13:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3699A244F42
        for <linux-cxl@vger.kernel.org>; Mon,  6 Jun 2022 10:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C452E61206
        for <linux-cxl@vger.kernel.org>; Mon,  6 Jun 2022 17:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8ADC385A9;
        Mon,  6 Jun 2022 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654537195;
        bh=E/KMnli56ivgtHivCHSxhFbFmO5hhJAc+qxXDBOiGA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqPPcERDgLy7UOVMWr0wE4JSao4f0SHl9kKM4pcwpLEqi/UwsSVIE3a//Cbjthm3H
         tfjYJ/rmXn2oNn90Nq/yPZ3T6LNc4QZfvM9g7S+vY62sg7PYC18GmGyhYFXqHfAS9Y
         BUksNhvAaP/KJXlLMB+wtFhj9Yo090zVliN5S86u/FATlCTzsJb9ySIX+j8Zj9Byk7
         9nUi4aPu05WbkBPPiKmlQHxqxLE3MUjyT12MtiuDBdLDvP1bN4UJcIl/Dx+6tYLSgi
         3AI7959N8DXjJW/1tZRdonZq2xweKDBQh+7TBqeCdIYow6lWnmMuFiy/Gr43WFtj6y
         xyrqKzqecM5vw==
Date:   Mon, 6 Jun 2022 10:39:52 -0700
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
Subject: Re: [PATCH] hw/cxl: Fix missing write mask for HDM decoder target
 list registers
Message-ID: <20220606173952.66q3gtwtydrs7xwb@bwidawsk-mobl5>
References: <20220531123953.17582-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531123953.17582-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-05-31 13:39:53, Jonathan Cameron wrote:
> Without being able to write these registers, no interleaving is possible.
> More refined checks of HDM register state on commit to follow.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-component-utils.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 7985c9bfca..993248b5c0 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -174,6 +174,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk)
>          write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
>          write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
>          write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
> +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
> +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;

I wonder if this should be 0. It will be weird for endpoints to have a skip
value of 0xff.

>      }
>  }
>  
> -- 
> 2.32.0
> 
