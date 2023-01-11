Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B3DC46467
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 16:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjAKQHu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 11:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjAKQHP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 11:07:15 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D6363A7
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 08:07:09 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso2675041wmb.1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 08:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvMdInq1GfHSa6VurOCw33Z4fJEcoM66wnAGb8PRKag=;
        b=KUhZaGwrthKKRlNllrrY8oLuk3f01E560iYjPGObrFnKWaACNNcQ+5QBKJZjQ9sNaX
         wwQ6DnIArMalS7QeyRTbA8/g/4Ypu61BBXgtCf4Csq52SohZ9vO2IOsu/CCMTKaP7PBS
         WzIMDt6XNxfnfbGs2dHSvT6AStZ7cxC37y6wjqajMh2cbHggMhlqfYQh+I5EsZIwMUdD
         +uYdhCrgwUqJ/u4UmkG2BvTQNtk8d/4tGINF7Por5kzws7/SI1C04xK+923/jFOfFW18
         uMPgVWR2dV5JwnCMD0+/AJtKy1HFZA0QeBOqQ+vDZwq9z/D1GbyfGT4y2qXS8rOho4Gy
         apiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvMdInq1GfHSa6VurOCw33Z4fJEcoM66wnAGb8PRKag=;
        b=pWDMZq0s4bUa3kbmb70vA36SqcHoHUJelv4a9WH1Hr68qgoutm8/Q9mEK4Ljt9TD4w
         arGA23lwk6jyLlNpVrAQHuWXNNZWKYb3HtEBv35bXO7Vh/CJlQ4iu+TDisJhxcs77pcf
         AocUufJOizm1Fm1sTYOs+37qxN65tqDPOaI/YGm0DDN6fB90r8nTUW8if3TuXIvg1iZc
         lQKqwqAFE8TXgvQxNLtgkwJzj3K4S7UsFakjV1LESsDMZmqVx+xkWapk5lF5/JpvOyKg
         8sT6MKOtPHDTWWZrhSsYqhbuHSPF9IFbXEC1Dma1BPGmB4ihFHkeyQ9XUsLyu59MiClv
         Lv9Q==
X-Gm-Message-State: AFqh2krgS2KmdJk0LTDPjqRv2MC+LUoDzLgygyqNVT+jv7O9+o7iid3G
        clTXiwCpWs4MxLkJNnuryAqxo2ZMnFSHeAhw
X-Google-Smtp-Source: AMrXdXuDYz/ZJhg0YadhHp0Bl9SBUd7tGBjhGtfPC6ArK0OMyLe7dYcXcG/2CvyUndNgn78bFGFypQ==
X-Received: by 2002:a05:600c:1d03:b0:3d3:4aa6:4fe6 with SMTP id l3-20020a05600c1d0300b003d34aa64fe6mr51918208wms.3.1673453228391;
        Wed, 11 Jan 2023 08:07:08 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003cfbbd54178sm6620416wms.2.2023.01.11.08.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 08:07:07 -0800 (PST)
Message-ID: <aa007274-a787-5c93-c9b3-843a6b50f1f2@linaro.org>
Date:   Wed, 11 Jan 2023 17:07:06 +0100
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
In-Reply-To: <68f9b74a-b0e7-c5a6-7b99-ce4f96d79f36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 11/1/23 16:49, Philippe Mathieu-Daudé wrote:
> On 11/1/23 15:24, Jonathan Cameron via wrote:
>> From: Ira Weiny <ira.weiny@intel.com>
>>
>> Gcc requires constant versions of cpu_to_le* calls.
>>
>> Add a 64 bit version.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   include/qemu/bswap.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Actually I thought this was already merged but apparently
this never got in:
https://lore.kernel.org/qemu-devel/20200928131934.739451-1-philmd@redhat.com/
