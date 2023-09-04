Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9277C71153
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 18:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbjIDS1P (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjIDS1N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 14:27:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139991B6
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 11:27:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so2333390a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 04 Sep 2023 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693852022; x=1694456822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=541JyCy9XPIs515STXSwG4wUnIWy4aYwP9IFPsJMMiY=;
        b=wMrJN3rcrDUlUw8LElOobcH9f9o2odMZdQ+MP68lhwxkiz0YazEP04MtPwmubHpqUG
         sOg62QfVdcYenezEp54Epedrb8kgboy5w1h4ZZLTLEWZe4kQDxEceBnPEOYEq7mnFKfq
         jsBRvZ0Gc0LZfyGFawDAK8sL8KaBjXIHS2/CrXVabmo3zMT1KFBVrY8UFdqGcVUZ18aE
         tVN3TImmVtwaqC+JIPwY+iNhVS2P6LA9e5Jplq2sIXfZspyLSd8rm1NKXP0fvZZQFN5C
         rcVwIX0WrBCHU6oCPLbYm6PIugozK05wPmzpqS8zx33oRpCN5QQLhTNsAf/CRHc9pl8s
         4CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693852022; x=1694456822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=541JyCy9XPIs515STXSwG4wUnIWy4aYwP9IFPsJMMiY=;
        b=LG6b7cZt5T8/BkxtK1Xyu4mHdKcBY+98xy6qr1V1XbFbolHxtxIKrdV3BpfC2QeSDG
         MPEkNGxtYMm2MqPUiSorTnUL45ARYZBD66uHQb2YakLF4L6jtqYJwuQujqG4SghqEoeF
         /l8RDGWSOFUKYH76urCIOtpysfz2yZpDz7DPc6gsXWwGnm3gEBpnZgDUVHrxtxDc+fMX
         BE/Mj4gfx1fivUg3+oQJ2u4WIbbdG51jdXBbRZvDxRKbCKfTl5rW864HaR+E6WmxBudw
         l2JJzr36Qh2R7NtMmmVKmAt1PO6PqRDIPWhjueijYwzxJ64nG+dsTqpPIwHRs+69wKeg
         p9Sw==
X-Gm-Message-State: AOJu0Ywqlfyggf9PvBfTBN/1PhBrzdVCPvnGXvWYWzxgj30akfdIB7aA
        NYMvEJ67TKByO4b0u78yxlTIqxYxxBMpwSpgLGg=
X-Google-Smtp-Source: AGHT+IG7olyS+jXevCnvnP0ISdYpGDEZXpjpOLluwjmlzCxf9S1L1N/Icwq7w84VNpuh8r40vekAIQ==
X-Received: by 2002:a05:6402:382:b0:525:7e46:940 with SMTP id o2-20020a056402038200b005257e460940mr8972257edv.24.1693852022524;
        Mon, 04 Sep 2023 11:27:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
        by smtp.gmail.com with ESMTPSA id b22-20020aa7d496000000b0051dd19d6d6esm6172363edr.73.2023.09.04.11.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 11:27:01 -0700 (PDT)
Message-ID: <89d5477c-ece0-b738-c64f-056242619d92@linaro.org>
Date:   Mon, 4 Sep 2023 20:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave ways
 and target count.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, linuxarm@huawei.com
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
 <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 4/9/23 18:47, Jonathan Cameron wrote:
> As an encoded version of these key configuration parameters is
> a register, provide functions to extract it again so as to avoid
> the need for duplicating the storage.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   include/hw/cxl/cxl_component.h | 14 ++++++++++++++
>   hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 42c7e581a7..f0ad9cf7de 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int count)
>       return 0;
>   }
>   
> +static inline int cxl_decoder_count_dec(int enc_cnt)
> +{
> +    switch (enc_cnt) {
> +    case 0: return 1;
> +    case 1: return 2;
> +    case 2: return 4;
> +    case 3: return 6;
> +    case 4: return 8;
> +    case 5: return 10;
> +    }
> +    return 0;
> +}

Why inline?

Alternatively:

   unsigned cxl_decoder_count_dec(unsigned enc_cnt)
   {
       return enc_cnt <= 5 ? 2 * enc_cnt : 0;
   }

