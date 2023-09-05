Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006BACA0FFA
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 18:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbjIESNy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjIESNi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 14:13:38 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12655B86
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 09:57:33 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99357737980so421166466b.2
        for <linux-cxl@vger.kernel.org>; Tue, 05 Sep 2023 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693932925; x=1694537725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AlzI1/zUkgHjINPB/60Bhf/bsRfn38JsFwy+xis2jA=;
        b=LKdAnjFakELd+M4ORbusarOyo94XgreoFCbZCb0CzZLS40TUf3KslNG1QIiPqEjGkj
         j9HOtn7oDntfIlizBGpFw6vUtks+jbQOYYgG3ZweyKy1CVZT2BwGXd8RQMz7xoNxozC6
         qZjRWm5f53YkuHa4gA4JJDwDYTTahAwKgNXHuiUp11+N35bxL4GFc7LfpKuku/EiFbu5
         bNDCZbOxNVZDP3yz+2LDxWgpptFTeyernzp/wduhKcsIk8DPll2qU4GPuWTGh29XQhM9
         oijYKIeSkDKdumX82JSG0KLIa2ebj7zfwfi4FviKWI1o+sjXvgmQG20/kTv/i0RkmgjJ
         nqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693932925; x=1694537725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3AlzI1/zUkgHjINPB/60Bhf/bsRfn38JsFwy+xis2jA=;
        b=iWQJb0Pu5xfyz5aGN+nY7f87T1g9vDsP/pncY2fV08IJGUaiNuhOR5jZPwnfsbHLCc
         jYmE0azO6fnJHHKW3IjljDErDUTTkLsKYUu0J1+R5XUP8GtbiVP4JfHPjTkQWNBjzecE
         yMbAvhO9FqjFkK55cnADr+ra3iDNwFPxukg/H/gLJNinzmsSEdkOvQ+chPlQatwTeI79
         Id+lsxAVSI259QX5knfu+sm8WcO3vzTZoQwFud4GShIQLSwaUzAyFtJmfUYOFobb7jpi
         PxNnxwjq6NdfRWyq9kRwWpsFpQDFDAzi/dlutFzvkAXNXNHZxmRGNgGdw5VwzKMMrhhi
         Gxyg==
X-Gm-Message-State: AOJu0YxFTfDPxfIC82nk/QnDvmhpgYo7S+ZmnAqCBB/WyPtDwy8339k/
        aalAKV+1P9HtIi5oakEeeVtCCA==
X-Google-Smtp-Source: AGHT+IGJjFvazhbzDO72qsjE+5oyOKiJjYH9aNw64nxL/uDLtKPe8WhesihAPOy2FRDrol1fvQtvSQ==
X-Received: by 2002:a17:907:7893:b0:99b:d580:546c with SMTP id ku19-20020a170907789300b0099bd580546cmr369290ejc.23.1693932925378;
        Tue, 05 Sep 2023 09:55:25 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr. [176.184.47.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906824300b009786c8249d6sm7898364ejx.175.2023.09.05.09.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 09:55:24 -0700 (PDT)
Message-ID: <d3e6506a-b553-d292-9428-25e784be0d4f@linaro.org>
Date:   Tue, 5 Sep 2023 18:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] hw/cxl: Add utility functions decoder interleave ways
 and target count.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>
Cc:     Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linuxarm@huawei.com
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
 <20230904164704.18739-2-Jonathan.Cameron@huawei.com>
 <89d5477c-ece0-b738-c64f-056242619d92@linaro.org>
 <20230905155639.00000b3a@huawei.com> <20230905160607.0000366f@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905160607.0000366f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 5/9/23 17:06, Jonathan Cameron wrote:
> On Tue, 5 Sep 2023 15:56:39 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
>> On Mon, 4 Sep 2023 20:26:59 +0200
>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>>> On 4/9/23 18:47, Jonathan Cameron wrote:
>>>> As an encoded version of these key configuration parameters is
>>>> a register, provide functions to extract it again so as to avoid
>>>> the need for duplicating the storage.
>>>>
>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>    include/hw/cxl/cxl_component.h | 14 ++++++++++++++
>>>>    hw/cxl/cxl-component-utils.c   | 17 +++++++++++++++++
>>>>    2 files changed, 31 insertions(+)
>>>>
>>>> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
>>>> index 42c7e581a7..f0ad9cf7de 100644
>>>> --- a/include/hw/cxl/cxl_component.h
>>>> +++ b/include/hw/cxl/cxl_component.h
>>>> @@ -238,7 +238,21 @@ static inline int cxl_decoder_count_enc(int count)
>>>>        return 0;
>>>>    }
>>>>    
>>>> +static inline int cxl_decoder_count_dec(int enc_cnt)
>>>> +{
>>>> +    switch (enc_cnt) {
>>>> +    case 0: return 1;
>>>> +    case 1: return 2;
>>>> +    case 2: return 4;
>>>> +    case 3: return 6;
>>>> +    case 4: return 8;
>>>> +    case 5: return 10;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>
>>> Why inline?
>>>    
>>
>> Bad habit.
> Nope. I'm being slow.  This is in a header so if I don't
> mark it inline I get a bunch of defined but not used warnings.
> 
> Obviously I could move the implementation of this and the matching
> encoding routines out of the header. I haven't done so for now.

Inlined function in hw/ are hardly justifiable. They make the headers
and debugging sessions harder to read in my experience. Compilers are
becoming clever and clever, and we have LTO, so I rather privilege
code maintainability. My 2 cents :)

>>> Alternatively:
>>>
>>>     unsigned cxl_decoder_count_dec(unsigned enc_cnt)
>>>     {
>>>         return enc_cnt <= 5 ? 2 * enc_cnt : 0;
>>
>> It gets a little more fiddly than the code I'm proposing implies.
>> For Switches and Host Bridges larger values are defined
>> (we just don't emulate them yet and may never do so) and those
>> don't have a sensible mapping.
>>
>> I guess there is no harm in adding the full decode however
>> which will make it more obvious why it was a switch statement.

Right, no problem.

Preferably having this tiny function not inlined:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

