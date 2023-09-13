Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128BDEEB596
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 06:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjIMGyF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjIMGyE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 02:54:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40E8173E
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 23:53:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so110696111fa.2
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 23:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694588038; x=1695192838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=211zCmIv+vPEaED+Sp4DjaXx7DIucvF6focw/AbqiiQ=;
        b=GqROLa+CqK/z6C9tX0I4A6tU3rtxckW0394nQKfHojT5ZeVUZJ3mN81YZmevD8WCc4
         oZ+B0cn1lGf1IcVCeAK1krkNMH+UndFBihg++ROiIl9XcwY0+KRN5kOXkW+kexNv4EBR
         SP4lq0ktgPqLnv/66VJWR7BtWmB7cYp6XeQea7IO9SRzjCSBpLQbVcgy5Zur7wQL4BI+
         A5d15cy0SHzC/gm92OIGlx+k0Wn6YY812uZttPkmnE8vps7XyZJJShkytSpGfnJCw0Pd
         rD/20SrFx0AJ8zeNCv4Xk1ZYo/e61o5Necb4/ovX0ksOQ4ZKGoeweIUMzu397WN7Urad
         xBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588038; x=1695192838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=211zCmIv+vPEaED+Sp4DjaXx7DIucvF6focw/AbqiiQ=;
        b=Z9IltPholNVAssUwACLIkqx59WDmf8GCeuSvXUxId2Q9RbtzZ1tUh9X8UJULKqoIqM
         So5vyHm0Brjzcbg3P82IIAE7DRbun+W+wQ3NS8jMPE6hDehgVJdwGYyc4H3dSORmjrF7
         szEN9civYE4E765YeOUR+U66kbCfMGvJpmeIoDBjVnvz5uW5swr6CEJolpEKE8XYkuZ3
         zu7gUcZm+DDReS2wIEbDs+SFXd1I76wVw0eu+MfwqIT4+A/gsgzrG0N5D+WsAuSqlTXQ
         zkMCNl47xSTmYMtAQ56xssI7wG8JQZyKXRMMMejEcd8LSV2fXSzbvnGqPwHdmVJNJNT0
         VUJw==
X-Gm-Message-State: AOJu0YxTqtdJmHTTOXT7VumUosA/iY2FRKpB/NZ1WWt5ebFbb8z3giw2
        OcBD9S3f8F3YANidw2eZlOnY4A==
X-Google-Smtp-Source: AGHT+IGmXzrN8RrPxven59mFGJOecTiXK/ZGzWoT1Ckaqo3J3rB7nwndwTMyl6V015x3eVQaTTa/4w==
X-Received: by 2002:a2e:a28d:0:b0:2b7:33b9:8809 with SMTP id k13-20020a2ea28d000000b002b733b98809mr1235791lja.16.1694588038119;
        Tue, 12 Sep 2023 23:53:58 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr. [176.131.211.241])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906939500b00985ed2f1584sm7845653ejx.187.2023.09.12.23.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 23:53:57 -0700 (PDT)
Message-ID: <b4ad0199-2df5-05ee-dde4-eb85ffb0a2b0@linaro.org>
Date:   Wed, 13 Sep 2023 08:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 3/4] hw/cxl: Fix and use same calculation for HDM
 decoder block size everywhere
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <20230911114313.6144-1-Jonathan.Cameron@huawei.com>
 <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230911114313.6144-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/9/23 13:43, Jonathan Cameron wrote:
> In order to avoid having the size of the per HDM decoder register block
> repeated in lots of places, create the register definitions for HDM
> decoder 1 and use the offset between the first registers in HDM decoder 0 and
> HDM decoder 1 to establish the offset.
> 
> Calculate in each function as this is more obvious and leads to shorter
> line lengths than a single #define which would need a long name
> to be specific enough.
> 
> Note that the code currently only supports one decoder, so the bugs this
> fixes don't actually affect anything. Previously the offset didn't
> take into account that the write_msk etc are 4 byte fields.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> v3:
> New patch to separate this out from the addition of HDM decoders.
> ---
>   include/hw/cxl/cxl_component.h |  2 ++
>   hw/cxl/cxl-component-utils.c   | 19 +++++++++++--------
>   hw/cxl/cxl-host.c              |  4 +++-
>   hw/mem/cxl_type3.c             | 24 +++++++++++++++---------
>   4 files changed, 31 insertions(+), 18 deletions(-)


> @@ -761,26 +763,30 @@ static void ct3_exit(PCIDevice *pci_dev)
>   /* TODO: Support multiple HDM decoders and DPA skip */
>   static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>   {
> +    int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
>       uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
>       uint64_t decoder_base, decoder_size, hpa_offset;
>       uint32_t hdm0_ctrl;
>       int ig, iw;
> +    int i = 0;
>   
> -    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
> -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
> +    decoder_base =
> +        (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] << 32) |
> +                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc]);

Alternatively easier to review as (matter of taste ?):

decoder_base = deposit64(cache_mem[R_CXL_HDM_DECODER0_BASE_LO + i * 
hdm_inc], 32, 32,
                          cache_mem[R_CXL_HDM_DECODER0_BASE_HI + i * 
hdm_inc]);

Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

