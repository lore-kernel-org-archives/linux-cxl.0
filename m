Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B34C636D6
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 18:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBVSQn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 13:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjBVSQm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 13:16:42 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24A52D173
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 10:16:40 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so622633wmb.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEbEQAsJpeS1K3BFED1M3rJ0rZv5yY1Z13SXmyHqi+E=;
        b=K9YAb7OU6ketr+1JblAQwmnUEU9u3uUp8GRxJXl45Rr/k1ZhlMyNjCpHmJbDeALR6d
         HpTrZeobAza2QDtDpXpOyAs9OasYLlLhXq35Yxq0+HysvriGMIHWEjpDvcpZvbv8FvUM
         QQrlxtlfCZeS0OQESlsIQQpold16ngt3cl/tW3Gt9KUUA1nF1Mv2YBupkA88oPyANxYh
         8WbnYgpgDPCg5g20vJkWapfyLtyhPG8PrFnhzZjx4JXNiGb3AhehZIE8n92KfqIBTMBK
         KLSTnRTeeAAnOuKrDRgdtLtMNRSL4DCpmRIiv5+8A7RJSlwDbtDlpfZ9xEj0DCWti4h7
         ZS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEbEQAsJpeS1K3BFED1M3rJ0rZv5yY1Z13SXmyHqi+E=;
        b=EIZ2KHHoz1ln7x6JRwXMgFADCc8y16hEqaplvf1pMm14l6WgfGLh6nd8QCt9Tfl+9g
         x/lKVE8v6vc69JZt2FS/XWhHLFkfUy7YObcpPBjMgr17EapvVptbzBiC7lcHRvYkEJQd
         AZsNYiZ/rzkfYMHfFaK6N952z0az4esaNW7ZN1xHzIBb52Soyi0duuWzB2Fuuu1Ripnn
         PERSGdEc0wb3FIVFM6FN8ZZ8BWWawg97XezT+rHM/fx9oNA9BfrDaVzogTRIP/gnUFr+
         Q7Mq28hSfAshnSWM5XFpHaOj2Ko87sE1YeHph/qQkvemWEl6gLDsc1gy0VMPl+k9oRoz
         MNdg==
X-Gm-Message-State: AO0yUKX6Fkc6ppUJG+flLMP9G+7FvxwKXO7DTpxeslmy+oTS/UdTF2jK
        aTn1sg3PWmcIJ9urhrZgHWteWw==
X-Google-Smtp-Source: AK7set+F7RTVDbHqBYVShgsyPL/EwtVry1+BZqCxLwsSFPkeWx+8v3sMTg865mh/N/tJMCdYIafadw==
X-Received: by 2002:a05:600c:181b:b0:3e2:2504:50e3 with SMTP id n27-20020a05600c181b00b003e2250450e3mr6245331wmp.25.1677089799452;
        Wed, 22 Feb 2023 10:16:39 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c224500b003dc1a525f22sm5932253wmm.25.2023.02.22.10.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:16:38 -0800 (PST)
Message-ID: <b9bd5698-1f73-b912-0344-4b70c30dd02a@linaro.org>
Date:   Wed, 22 Feb 2023 19:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
 <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
 <20230222145330.000021ef@huawei.com>
 <c2fb77b0-0734-3be5-1b54-7c797b3daa15@linaro.org>
 <20230222164947.0000554f@Huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230222164947.0000554f@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

+Thomas (meson) & Marc-André (conditional QAPI)

On 22/2/23 17:49, Jonathan Cameron wrote:
>>>>> +# Type of uncorrectable CXL error to inject. These errors are reported via
>>>>> +# an AER uncorrectable internal error with additional information logged at
>>>>> +# the CXL device.
>>>>> +#
>>>>> +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
>>>>> +# @cache-address-parity: Address parity or other errors associated with the
>>>>> +#                        address field on CXL.cache
>>>>> +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
>>>>> +# @cache-data-ecc: ECC error on CXL.cache
>>>>> +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
>>>>> +# @mem-address-parity: Address parity or other errors associated with the
>>>>> +#                      address field on CXL.mem
>>>>> +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
>>>>> +# @mem-data-ecc: Data ECC error on CXL.mem.
>>>>> +# @reinit-threshold: REINIT threshold hit.
>>>>> +# @rsvd-encoding: Received unrecognized encoding.
>>>>> +# @poison-received: Received poison from the peer.
>>>>> +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
>>>>> +# @internal: Component specific error
>>>>> +# @cxl-ide-tx: Integrity and data encryption tx error.
>>>>> +# @cxl-ide-rx: Integrity and data encryption rx error.
>>>>> +##
>>>>> +
>>>>> +{ 'enum': 'CxlUncorErrorType',
>>>>
>>>> Doesn't these need
>>>>
>>>>         'if': 'CONFIG_CXL_MEM_DEVICE',
>>>>
>>>> ?
>>>
>>> If I make this change I get a bunch of
>>>
>>> ./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned "CONFIG_CXL_MEM_DEVICE"
>>>      18 | #if defined(CONFIG_CXL_MEM_DEVICE)
>>
>> Err, I meant the generic CONFIG_CXL, not CONFIG_CXL_MEM_DEVICE.
>>
>>> It's a target specific define (I think) as built alongside PCI_EXPRESS
>>> Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)
>>>
>>> To be honest though I don't fully understand the QEMU build system so the reason
>>> for the error might be wrong.
>>
>> You need to restrict to system emulation (the 'have_system' check):
> 
> This doesn't help - still have
> attempt to used poisoned "CONFIG_CXL"
> 
> 
>>
>> -- >8 --
>> diff --git a/qapi/meson.build b/qapi/meson.build
>> index fbdb442fdf..643c76d61c 100644
>> --- a/qapi/meson.build
>> +++ b/qapi/meson.build
>> @@ -31,6 +31,7 @@ qapi_all_modules = [
>>      'compat',
>>      'control',
>>      'crypto',
>> -  'cxl',
>>      'dump',
>>      'error',
>>      'introspect',
>> @@ -58,6 +59,7 @@ if have_system
>>        'audio',
>>        'qdev',
>>        'pci',
>> +    'cxl',
>>        'rdma',
>>        'rocker',
>>        'tpm',
>> ---
>>
> 

