Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AB8C6FD1C
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 06:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjCNG2B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 02:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCNG2A (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 02:28:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1955B9D
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 23:27:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p23-20020a05600c1d9700b003ead4835046so177991wms.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Mar 2023 23:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678775277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYns6uzT2QxbBcCa0vS4G5/3NPd0+7JxpjBnyynmpEI=;
        b=JJB5HQtsj1ZsHRO5TJfcq+imgp+ogT/jaIbiVkM/AbGfNtHTHz+JMv8xZzpZ3gXU7M
         IJPQd6sAXBprY0FMcyK39V8zBLi7U/p9UyoggUB9xlr/SARSsvbE6UHc2ZLMexnb5mKr
         4X2MMbbjtSxzA9NYbupghcBAdn5ZdnelpfE+5G0ZWbaSLCth4pUEx21KEjkP90i3a7T+
         XD7xlGvdya/c8tlqEvS1Ft9id+mO4EUzlIOcdTijArLRJ0dRxZIaKrAmqaKhrD2Frx+x
         YfHjte+sLaXlPAXibi08WD27iVKR3wzr4twkD4uNnzcEBTwpAKaeN72hgRtYDBtvByPf
         jYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678775277;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYns6uzT2QxbBcCa0vS4G5/3NPd0+7JxpjBnyynmpEI=;
        b=MCOMywFhA1XMtoFMaHtGpAjB2zBwTE78IZOrAlzfba/6PJbOkD3tgg6duPuZzT5qTK
         2V2equ9SkWfbqkHjWpjMnlKlogMy0SsSuQPyvmI2JQ5EC39FmaKiiRbSdBUkKO/L6w8u
         6loXGYoRjHGSzQTvuIuc3cK8AjHFXBfGKtDRoTiqVYqufwdXZh3x0Ux0q7cvb7JzSPrr
         KpzvCSi2sfl3fcP904XVf6T6BxdAe+mQsbgNTvwFVo6BGGzqrU18FhdddSimSY1BrPqp
         ixHTK44WokBWThdy2g+BskHGdvLQeAlimfres33u05xW/E8n5gcyvj6mX3js9qm32PbR
         whCQ==
X-Gm-Message-State: AO0yUKU9wx1uvDuGDe3RNCbnAg05ULIhbiBgA4KoJ+9LLY4CVU1O0n9H
        QU14T8O/zXjSpzD9cF72lGhkHQ==
X-Google-Smtp-Source: AK7set/2WV9vLrL2lxn/B2smMYJWPlqkYBtHU+khuGwNoQ8U9m4vKGkBS5HSDjLCmRiTkJDYudjifg==
X-Received: by 2002:a05:600c:3ac9:b0:3eb:966f:5811 with SMTP id d9-20020a05600c3ac900b003eb966f5811mr13273971wms.3.1678775276901;
        Mon, 13 Mar 2023 23:27:56 -0700 (PDT)
Received: from [192.168.150.175] (180.red-88-28-30.dynamicip.rima-tde.net. [88.28.30.180])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c021400b003e20970175dsm1765992wmi.32.2023.03.13.23.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 23:27:56 -0700 (PDT)
Message-ID: <c5332793-f062-e4e7-9579-8eeb416e57ab@linaro.org>
Date:   Tue, 14 Mar 2023 07:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 5/6] hw/cxl: Add poison injection via the mailbox.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
Cc:     linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-6-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230303150908.27889-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 3/3/23 16:09, Jonathan Cameron wrote:
> Very simple implementation to allow testing of corresponding
> kernel code. Note that for now we track each 64 byte section
> independently.  Whilst a valid implementation choice, it may
> make sense to fuse entries so as to prove out more complex
> corners of the kernel code.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: No change
> ---
>   hw/cxl/cxl-mailbox-utils.c | 41 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)


> +static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
> +                                          CXLDeviceState *cxl_dstate,
> +                                          uint16_t *len)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);

This makes me wonder why CXLDeviceState isn't QDev based.

(Also, why include/hw/cxl/cxl_device.h is under GPL-2.0-only license?)
