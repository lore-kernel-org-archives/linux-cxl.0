Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA357C7EE26
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 16:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjESQnf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjESQne (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 12:43:34 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F7FD2
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 09:43:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f450815d0bso33938825e9.0
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684514611; x=1687106611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EEeZ0ecCEA5JwlhNdY/XwndwIOC3P/R2CuBxuQnX/U4=;
        b=QjnkVAjNEFN0pI/pnVXKDubNOBEe38ov3AXRIjVoyQCuQ0qDbCPBtLy6fMLelksIl2
         4MZ5dLQfvudNBdhEdt2HJ0GPCQUM6h/mYqECJWhHaSpYWZ4vpQretrMlj7Pz0dX7zTpE
         6jfl26wFtxY/pPdil1Ys9v+c9t2vA/seLVDbybLfIvqnL2GndBr/sMaFjZWqIIUjLyv6
         l9RyBiW15f26WLMAy5mqZQ7N/i9gLQcqwrcj46umxZr9n5dwyoV8mXBiafEVeUlBYBIJ
         LMH3HRt4An6+aTKOI3Nc+CjKoLD7ve48yNbtKj1RBZb67QRCkAz+pnYW8R8+jewEu7g6
         c5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684514611; x=1687106611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEeZ0ecCEA5JwlhNdY/XwndwIOC3P/R2CuBxuQnX/U4=;
        b=hdJEQe96tGPvyM0LpW/Yk6cjCiJAhQYCevTfws1lzPdafyodRTltH16jXJYf4qi734
         f/si2ZWK4AUQVGTAc5XRAfNogpbSFaWQV8wslvpof5Dt5bkyA72K5zizsgWAjcNtOFBW
         hn6S/Ep2ULWuOrG2mZW9WYlGdcd73KfUecHPtq0vaUk1auXL9++bZs68FPk4o1ziLFnb
         d9lLMPQ5wkZX0MgqgGDSfdbuJyCJpV8jKyEHEyFBLEuRt9xpPSQ52+HQzS0pFOhAWa+e
         I/4NtmUgJOAeA6mFLqxukvtVQ1h5/OxmfAR0kVJqF6g+Qyf1gu+Af8Es3bqa8xkKDIVg
         IEgw==
X-Gm-Message-State: AC+VfDzrNw/B3HYqLUdUhoCzMfRHhZiBu5h01+lj+g0XP5k5RKXI+cxz
        IFFEKtC7bZIJ2/Y31gCya+7NCw==
X-Google-Smtp-Source: ACHHUZ4uzSD4Mxadpvu1fdzjgi9qwpL5Oua2kCNf9yWviQUi/f7Y49rOqmSbr41jQpqcMv7L7D/wLA==
X-Received: by 2002:a1c:f709:0:b0:3f4:16bc:bd19 with SMTP id v9-20020a1cf709000000b003f416bcbd19mr1792895wmh.23.1684514610938;
        Fri, 19 May 2023 09:43:30 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003f4272c2d0csm2875134wmi.36.2023.05.19.09.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:43:30 -0700 (PDT)
Message-ID: <1eb91ba2-a2e0-44e4-a07b-badccef1fe42@linaro.org>
Date:   Fri, 19 May 2023 18:43:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <27f9ad4f-bdde-f548-860b-34e52493faa2@linaro.org>
 <20230519172404.0000649e@Huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519172404.0000649e@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 19/5/23 18:24, Jonathan Cameron wrote:
> On Fri, 19 May 2023 18:08:30 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> On 19/5/23 16:18, Jonathan Cameron wrote:
>>> From: Ira Weiny <ira.weiny@intel.com>
>>>
>>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
>>> specified as little endian.
>>>
>>> Define st24_le_p() and the supporting functions to store such a field
>>> from a 32 bit host native value.
>>>
>>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
>>> used for the size part of the function name.
>>>
>>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>    docs/devel/loads-stores.rst |  1 +
>>>    include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
>>>    2 files changed, 28 insertions(+)
>>>
>>> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
>>> index d2cefc77a2..82a79e91d9 100644
>>> --- a/docs/devel/loads-stores.rst
>>> +++ b/docs/devel/loads-stores.rst
>>> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>>>    ``size``
>>>     - ``b`` : 8 bits
>>>     - ``w`` : 16 bits
>>> + - ``24`` : 24 bits
>>>     - ``l`` : 32 bits
>>>     - ``q`` : 64 bits
>>>    
>>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>>> index 15a78c0db5..f546b1fc06 100644
>>> --- a/include/qemu/bswap.h
>>> +++ b/include/qemu/bswap.h
>>> @@ -8,11 +8,25 @@
>>>    #undef  bswap64
>>>    #define bswap64(_x) __builtin_bswap64(_x)
>>>    
>>> +static inline uint32_t bswap24(uint32_t x)
>>> +{
>>> +    assert((x & 0xff000000U) == 0);
>>
>> Asserting here is a bit violent. In particular because there is no
>> contract description that x should be less than N bits for bswapN()
>> in "qemu/bswap.h" API.
>>
>> But if you rather to assert ...
> 
> 
> I'm fine either way.  You asked for it when reviewing v4...
> https://lore.kernel.org/all/28a9d97a-b252-a33f-1ac0-cd36264b29ab@linaro.org/

Never too late to improve oneself ;)

One month later I'm afraid the assertion would fire too often,
resulting in unnecessary pain to developers (in particular the
non-QEMU ones).

>>
>>> +
>>> +    return (((x & 0x000000ffU) << 16) |
>>> +            ((x & 0x0000ff00U) <<  0) |
>>> +            ((x & 0x00ff0000U) >> 16));
>>> +}
>>> +
>>>    static inline void bswap16s(uint16_t *s)
>>>    {
>>>        *s = __builtin_bswap16(*s);
>>>    }
>>>    
>>> +static inline void bswap24s(uint32_t *s)
>>> +{
>>> +    *s = bswap24(*s & 0x00ffffffU);
>>
>> ... and sanitize the value here ...
>>
>>> +}
>>> +
>>>    static inline void bswap32s(uint32_t *s)
>>>    {
>>>        *s = __builtin_bswap32(*s);
>>> @@ -26,11 +40,13 @@ static inline void bswap64s(uint64_t *s)
>>>    #if HOST_BIG_ENDIAN
>>>    #define be_bswap(v, size) (v)
>>>    #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
>>> +#define le_bswap24(v) bswap24(v)
>>
>> ... then shouldn't you sanitize also here?
>>
> 
> Good point. I forgot that detail whilst fighting with s390
> cross builds earlier ;)
> 
>> Personally I'd just drop the assertion.
> 
> I'm fine with doing that.
> 
> Jonathan
> 
>>
>>>    #define be_bswaps(v, size)
>>>    #define le_bswaps(p, size) \
>>>                do { *p = glue(__builtin_bswap, size)(*p); } while (0)
>>>    #else
>>>    #define le_bswap(v, size) (v)
>>> +#define le_bswap24(v) (v)
>>>    #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
>>>    #define le_bswaps(v, size)
>>>    #define be_bswaps(p, size) \
>>> @@ -176,6 +192,7 @@ CPU_CONVERT(le, 64, uint64_t)
>>>     * size is:
>>>     *   b: 8 bits
>>>     *   w: 16 bits
>>> + *   24: 24 bits
>>>     *   l: 32 bits
>>>     *   q: 64 bits
>>>     *
>>> @@ -248,6 +265,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
>>>        __builtin_memcpy(ptr, &v, sizeof(v));
>>>    }
>>>    
>>> +static inline void st24_he_p(void *ptr, uint32_t v)
>>> +{
>>> +    __builtin_memcpy(ptr, &v, 3);
>>> +}
>>> +
>>>    static inline int ldl_he_p(const void *ptr)
>>>    {
>>>        int32_t r;
>>> @@ -297,6 +319,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
>>>        stw_he_p(ptr, le_bswap(v, 16));
>>>    }
>>>    
>>> +static inline void st24_le_p(void *ptr, uint32_t v)
>>> +{
>>> +    st24_he_p(ptr, le_bswap24(v));
>>> +}
>>> +
>>>    static inline void stl_le_p(void *ptr, uint32_t v)
>>>    {
>>>        stl_he_p(ptr, le_bswap(v, 32));
>>
>> Conditional to removing the assertion in bswap24():
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 

