Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB0DC677F1
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 16:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjAKQdx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjAKQdF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 11:33:05 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38172270D
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 08:33:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so13122524wms.4
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 08:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8jCKVsR4MxJB8umO/EIZGA3CTPqpk8S9QK8JC1lx7A=;
        b=I5AKM32zy9xYd0qoWCb14QTtwZ+0zgvF5XXK80pYUKSrLlqV8momvvaObfFm0mWcTl
         xiuAhUQUY1oMKOhwJgUsrQEcBGD1o4cteqaUnurAa2y/SO/USKpYMWoLCs6Q4ZEODqq/
         R0SUySkf7S0QEt1tXRiMwu6rCyrkQ2eh8fYqymVV0u4r8idsNvXcdSo1INbqY/Ku4wIl
         TGwMGuWG6hWyZOT3gn+ldJIeNt87hWt28835TF5/myQftJdn9udp2ivxd9S7Tl7Rulik
         19MNNYdLmNmWF/m6r9ETEfudP2xG3eN6YCIg/fszv8sX32DnnrsH2oYwn2STO9zAZ6e6
         MKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8jCKVsR4MxJB8umO/EIZGA3CTPqpk8S9QK8JC1lx7A=;
        b=Fv3Iv2UgjCqzHHuudBR1LgE938uAO2bnGI4a/MQLEudV/NcUmz875OmIqwC/WjTT5o
         2xEO3+BhyxPx0eC2c0mwhR8gAy/V+6DmCSC8mNm9BstHk2IvmBAqSqOtYxWOkFLseUO8
         hhqvVK28Pivag8RiK0pqK1X6hebJYz4fnJ58supUUOQYd0KkIcu/k7b1nLNvIXfAHLnP
         yEBP3UIx4s04RK7EGL2iLVLRZgbvGb3p/BhSmBshr7avwi7SBLKIZlSu7uw2EymJ9I5G
         pS2Ofvye9MQ9diMYW2nUVqBnfEbN2Y3+bNOQSnN+24V6qtEiHT2JZRlTc4MNOW3vO2zD
         1Vyg==
X-Gm-Message-State: AFqh2kpQJXol4/QRlL8d4EUAKheKEzd2xjfOK7NPaO3MWWzEYQsN6QsK
        BldGQwdNCqcQxwNrpS3Vv9DRhQ==
X-Google-Smtp-Source: AMrXdXvNkLzrjJpnLXfhG9KwkDgzRoCFcKae1e/jpy8C6729y0u8HvDY6xd/o3ENgwN6cH7nyPmaYQ==
X-Received: by 2002:a05:600c:3552:b0:3d9:f801:bb6 with SMTP id i18-20020a05600c355200b003d9f8010bb6mr5849515wmq.10.1673454782836;
        Wed, 11 Jan 2023 08:33:02 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm25124963wmo.24.2023.01.11.08.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:33:02 -0800 (PST)
Message-ID: <cb1fafb5-a83d-210c-d0a1-8129eedb5c73@linaro.org>
Date:   Wed, 11 Jan 2023 17:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 6/8] qemu/bswap: Add const_le64()
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>
References: <20230111142440.24771-1-Jonathan.Cameron@huawei.com>
 <20230111142440.24771-7-Jonathan.Cameron@huawei.com>
 <68f9b74a-b0e7-c5a6-7b99-ce4f96d79f36@linaro.org>
 <aa007274-a787-5c93-c9b3-843a6b50f1f2@linaro.org>
In-Reply-To: <aa007274-a787-5c93-c9b3-843a6b50f1f2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/1/23 17:07, Philippe Mathieu-Daudé wrote:
> On 11/1/23 16:49, Philippe Mathieu-Daudé wrote:
>> On 11/1/23 15:24, Jonathan Cameron via wrote:
>>> From: Ira Weiny <ira.weiny@intel.com>
>>>
>>> Gcc requires constant versions of cpu_to_le* calls.
>>>
>>> Add a 64 bit version.
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>   include/qemu/bswap.h | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Actually I thought this was already merged but apparently
> this never got in:
> https://lore.kernel.org/qemu-devel/20200928131934.739451-1-philmd@redhat.com/

Oops unrelated, I meant:
https://lore.kernel.org/qemu-devel/20200917163106.49351-1-philmd@redhat.com/

But thank for the reminder, good opportunity to respin the
other one ;)
