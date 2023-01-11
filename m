Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E395C46467
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 15:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjAKPva (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbjAKPvK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 10:51:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129DDBE27
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 07:51:03 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso13013182wmq.1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 07:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3iA34dvhp3jSn6xOk1OrVv4JsY4jECUMYwtaI617JY=;
        b=BA6Ajnl4lubQmRgTHbwKEA55nCvZcZXi6GaMSSWkBJ6zy7q8N4Z0OS3u4O50C+YKKM
         GUxK7I6u+ZG67HpRXDsiTVTZtu4kopAGsZkl7LS/usMtGnoXVyHEvsXS0pDLm3lyaCYH
         vvs990JozLLG2BrRH7LNG9AGOIn1ClOVlOd6HpsCoFgS1V5nOQDG8rJ/sVK1UZsmKV1g
         dtZrZ5hF1ZXH12YbldPBbLp/trQnwcFXf407+FFuYoLLlONAlrZbm6D9K4gKOC5Zgx2p
         m6v7yga2UrjjESQ613+oECz4v/8WoNozsYt+bjFkm4Fue2A/+9/0MdZSH6biKkSr1jWq
         WdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3iA34dvhp3jSn6xOk1OrVv4JsY4jECUMYwtaI617JY=;
        b=loJLTXlJhuIyXfgLoC7qr5Ce7gM0FB4Dy2oTSXccwES19Q7DPtfzdPgSUxXPBcspoJ
         j1inRnHTZ2yO0MZpsvDIal3ibr7ESno7u0rRjZpPqJ3O9pfFrIr1ScmK3iatRW/ez7WU
         2ZC980Z4yJpcTIPR/+RFp0C2LIlFKGIBztmnGy1EIzu3qp8O7/rjMFVSlocr5hBAleF0
         uo2ElfSJM/g9LlS4Qs21ke7dw/9/5emnruYm1V8y99S4qYI6EaouAIJ/Mpp+r9mDQmTO
         knmiPandmm7oWXrGB2TqlvxirEcoSCaWwBZfVNmG5gP+uSynIcNPsnYvj6ljTXZwfy5O
         5EQA==
X-Gm-Message-State: AFqh2kqoJ86FGc8xLsrEfNoxjF7w3NcWebARMwAePAp/BfOjrD2FU1i5
        djDQFpN2alc1d71EkGIh6LO1Dg==
X-Google-Smtp-Source: AMrXdXuDxvzy9Al6M0dy6Q7S/XEf1yAhQPvVTaNir95bisIa7Iw7HzzjCvKU/9Owjpi5nW1cYT4jiQ==
X-Received: by 2002:a05:600c:34d0:b0:3d6:b691:b80d with SMTP id d16-20020a05600c34d000b003d6b691b80dmr52063697wmq.21.1673452261563;
        Wed, 11 Jan 2023 07:51:01 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b003d96b8e9bcasm25836972wmq.32.2023.01.11.07.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:51:01 -0800 (PST)
Message-ID: <47139b1a-e515-e6dd-86c4-c874afa07353@linaro.org>
Date:   Wed, 11 Jan 2023 16:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 8/8] hw/cxl/mailbox: Use new UUID network order define for
 cel_uuid
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-9-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230111142440.24771-9-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/1/23 15:24, Jonathan Cameron via wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The cel_uuid was programatically generated previously because there was
> no static initializer for network order UUIDs.
> 
> Use the new network order initializer for cel_uuid.  Adjust
> cxl_initialize_mailbox() because it can't fail now.
> 
> Update specification reference.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/cxl/cxl-device-utils.c   |  2 +-
>   hw/cxl/cxl-mailbox-utils.c  | 13 ++++++-------
>   include/hw/cxl/cxl_device.h |  2 +-
>   3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 83ce7a8270..4c5e88aaf5 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -267,5 +267,5 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
>       cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
>       memdev_reg_init_common(cxl_dstate);
>   
> -    assert(cxl_initialize_mailbox(cxl_dstate) == 0);
> +    cxl_initialize_mailbox(cxl_dstate);
>   }
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 942de73bbc..7ed344a754 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -192,7 +192,11 @@ static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
>       return CXL_MBOX_SUCCESS;
>   }
>   
> -static QemuUUID cel_uuid;
> +/* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
> +static QemuUUID cel_uuid = {

static const.

Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> +                     0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
> +};
>   
>   /* 8.2.9.4.1 */
>   static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
> @@ -457,11 +461,8 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>                        DOORBELL, 0);
>   }
