Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95966EC873A
	for <linux-cxl@archiver.kernel.org>; Thu,  7 Sep 2023 15:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjIGPmh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbjIGPYa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 7 Sep 2023 11:24:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38ECDE
        for <linux-cxl@vger.kernel.org>; Thu,  7 Sep 2023 08:24:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso1499719a12.1
        for <linux-cxl@vger.kernel.org>; Thu, 07 Sep 2023 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100255; x=1694705055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PoBujJ/iXdoCMge3j3UDXvjqLVzFDD0TrTUoS71ns7E=;
        b=BGkGsYml6uevVIlGGQDIxshLHlkVPnWI3ucMSwirqkkQpM7G0qJnn+QP6O5FM7Ec8M
         Av1Z8cxFWpSQviPeni+y7M6Y5paZedgknUR/Kf/BMo5qwIheioE6amIlO1wOGCVK60B1
         GFj7VDZzkW8Pytb6biqdeV68EsWckMK8+b2BjNodeY2Q1aEWsVEVrXk/sXX93dypbEYX
         qDd6FysfCEnnfiH6GTDqnmT9pg74RRVy6e3BHv0BOz/MOrj2x8u3fMfKu7pm6rNhTbVB
         NZa95aGx108ctCT/RZg/4wNdZ2meSlS6xymz5yIpPqC7cQECK0KKgh4bnRUiwWprYRBb
         x8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100255; x=1694705055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoBujJ/iXdoCMge3j3UDXvjqLVzFDD0TrTUoS71ns7E=;
        b=RIpLPLH1uON4+MkHm5swZ1VtrNrmiH7CrxxeILg4Bm9bGsuSTDiBEF1n3LnUhGB5Yc
         0tXhUEHSIP/E/WLXIZrUSeV3MICFpwpQnURAo7GYzHLAiHQTC9qPdaXuRwakutSqInRk
         5BgcyIA1PrdVUA1Wvz0i8fY47BVPbm2XGpuH/HQzkslAL6iyIh+hRj80yx5Rf+3CKpw/
         2subWo5k6Uwsd7FEkZhGHGtGdkDYfmsbGsZ9aQLLQcFFpIiKfYrDs9HWvbGLM2oOxpjZ
         wcGBeHX2O+IxIEUo7dNlyzDI2/LBU9l4o+PLYFvouVvJJR/evyLtjL8UB7zf1lZyKegu
         /WWQ==
X-Gm-Message-State: AOJu0Yyco7tah8g0yPWwu3AzHD6Wkb71QJkYCk+FTm6rKfcQTaj6mviQ
        pMvwvox6VQJ0TWrzjt2mT/qMSIU2jVgKkqN/mSA=
X-Google-Smtp-Source: AGHT+IEJBc6bLzdKEt+8aczqpH1jETGPkzQbTVPi0fsfGDqj+OEEylRFztpb+wnefd0GKDO7f4ukhA==
X-Received: by 2002:a17:906:739e:b0:99c:6692:7f76 with SMTP id f30-20020a170906739e00b0099c66927f76mr4999604ejl.16.1694090143746;
        Thu, 07 Sep 2023 05:35:43 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr. [176.131.222.226])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906391b00b0099cd1c0cb21sm10222882eje.129.2023.09.07.05.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 05:35:43 -0700 (PDT)
Message-ID: <f1694c9b-75ed-a8a3-6a05-91f796dfcf2b@linaro.org>
Date:   Thu, 7 Sep 2023 14:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 2/3] hw/cxl: Add utility functions decoder interleave
 ways and target count.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     linuxarm@huawei.com
References: <20230907113543.19760-1-Jonathan.Cameron@huawei.com>
 <20230907113543.19760-3-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907113543.19760-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/9/23 13:35, Jonathan Cameron wrote:
> As an encoded version of these key configuration parameters is available
> in a register, provide functions to extract it again so as to avoid
> the need for duplicating the storage.
> 
> Whilst here update the _enc() function to include additional values
> as defined in the CXL 3.0 specification. Whilst they are not
> currently used in the emulation, they may be in future and it is
> easier to compare with the specification if all values are covered.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Thanks to Philippe Mathieu-Daudé
>   - Expand both enc() and dec() functions to include full set of values
>     defined in CXL r3.0
>   - Pushed implementation down into the .c file.
> ---
>   include/hw/cxl/cxl_component.h |  2 ++
>   hw/cxl/cxl-component-utils.c   | 59 ++++++++++++++++++++++++++++++----
>   2 files changed, 55 insertions(+), 6 deletions(-)

Hoping the values match the "CXL r3.0 Section 8.2.4.19.1 CXL
HDM Decoder Capability Register":

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

