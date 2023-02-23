Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75873C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 06:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjBWG7O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 01:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjBWG7N (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 01:59:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ABE30B26
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 22:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677135505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ecfB09k8caShkH69E2kbw6K5lvSIdFRmEdtcuFcS5M=;
        b=Ys2U3C4U7MnRPsBMnU81oTFp+PfZFzlzp5TYCcnPvh8pFMmSrxnGrOUB1hy12atO3s4oLX
        8tDgdtqwHkJQ2EAFFNuhrEMPTu2xEuTOaY9xZrNFy2Dp9uSNPAl8Ov/WOFla4ReRuRA3UO
        hGNZbBH4EIc14TOW4HRiiWdhsZBz39Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-diafTHo_MyustnFGK19uFw-1; Thu, 23 Feb 2023 01:58:24 -0500
X-MC-Unique: diafTHo_MyustnFGK19uFw-1
Received: by mail-wm1-f70.google.com with SMTP id l23-20020a7bc457000000b003e206cbce8dso4604730wmi.7
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 22:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ecfB09k8caShkH69E2kbw6K5lvSIdFRmEdtcuFcS5M=;
        b=MHNbnrVxOz9xCYDhT7EowDNmX/7+4KUU1oefpuqcMK47VjwPDlUCvBxAlYcSPxNGJI
         ycddskWAM9zmYrCRGwPNjC22R1RzoLjJiJDn+1o+5/67owBUykCFF+q9hoswXAeJYueA
         m1w8VZUbv1Y6MCBaNarbthIjcUUZ9Li9t3QI+LOP/c19JRUZPkZbz7NEV1Hx9mlLRw6b
         x9bVz4uRO1sJBlMQw/mQFTWDrGykx13wlKqizkiLgT1g6HPIye3XSyLpoQCVpsh12IE0
         P1i3cMn7/Sq+EUBnPfe2wL4L3WIF90PHw704fP20Qnn0d+OtKoW34YP1oX8RoCDZH/6u
         SVmg==
X-Gm-Message-State: AO0yUKWsxlh8QFF1eCoCwhcA0hO+mwL2OJItWcUyIABeOnH0qVEbS2ii
        LpoBMBcWkIhygBk88J6eG00oEET2fNPNtz+jbg3hDDGxHZgX3ku63e/Uaoj8bee846VnQD8hFz7
        zfCob53Kz5SjkEy0JcQKU
X-Received: by 2002:a05:600c:4386:b0:3de:e447:8025 with SMTP id e6-20020a05600c438600b003dee4478025mr1752202wmn.21.1677135503221;
        Wed, 22 Feb 2023 22:58:23 -0800 (PST)
X-Google-Smtp-Source: AK7set8hftLISKlZmhPZy8Dw2g1kg+ALTvI5hH3AerEYASYiMZGtM+AXfmL6jhRPPsK/zHSqmS5RzA==
X-Received: by 2002:a05:600c:4386:b0:3de:e447:8025 with SMTP id e6-20020a05600c438600b003dee4478025mr1752186wmn.21.1677135502922;
        Wed, 22 Feb 2023 22:58:22 -0800 (PST)
Received: from [192.168.8.104] (tmo-100-40.customers.d1-online.com. [80.187.100.40])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c22cf00b003e11f280b8bsm10910924wmg.44.2023.02.22.22.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 22:58:22 -0800 (PST)
Message-ID: <586d040f-d712-905e-fd68-bcde3713478b@redhat.com>
Date:   Thu, 23 Feb 2023 07:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Markus Armbruster <armbru@redhat.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
 <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
 <20230222145330.000021ef@huawei.com>
 <c2fb77b0-0734-3be5-1b54-7c797b3daa15@linaro.org>
 <20230222164947.0000554f@Huawei.com>
 <b9bd5698-1f73-b912-0344-4b70c30dd02a@linaro.org>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
In-Reply-To: <b9bd5698-1f73-b912-0344-4b70c30dd02a@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22/02/2023 19.16, Philippe Mathieu-Daudé wrote:
> +Thomas (meson) & Marc-André (conditional QAPI)

+ Markus

> On 22/2/23 17:49, Jonathan Cameron wrote:
>>>>>> +# Type of uncorrectable CXL error to inject. These errors are 
>>>>>> reported via
>>>>>> +# an AER uncorrectable internal error with additional information 
>>>>>> logged at
>>>>>> +# the CXL device.
>>>>>> +#
>>>>>> +# @cache-data-parity: Data error such as data parity or data ECC 
>>>>>> error CXL.cache
>>>>>> +# @cache-address-parity: Address parity or other errors associated 
>>>>>> with the
>>>>>> +#                        address field on CXL.cache
>>>>>> +# @cache-be-parity: Byte enable parity or other byte enable errors on 
>>>>>> CXL.cache
>>>>>> +# @cache-data-ecc: ECC error on CXL.cache
>>>>>> +# @mem-data-parity: Data error such as data parity or data ECC error 
>>>>>> on CXL.mem
>>>>>> +# @mem-address-parity: Address parity or other errors associated with 
>>>>>> the
>>>>>> +#                      address field on CXL.mem
>>>>>> +# @mem-be-parity: Byte enable parity or other byte enable errors on 
>>>>>> CXL.mem.
>>>>>> +# @mem-data-ecc: Data ECC error on CXL.mem.
>>>>>> +# @reinit-threshold: REINIT threshold hit.
>>>>>> +# @rsvd-encoding: Received unrecognized encoding.
>>>>>> +# @poison-received: Received poison from the peer.
>>>>>> +# @receiver-overflow: Buffer overflows (first 3 bits of header log 
>>>>>> indicate which)
>>>>>> +# @internal: Component specific error
>>>>>> +# @cxl-ide-tx: Integrity and data encryption tx error.
>>>>>> +# @cxl-ide-rx: Integrity and data encryption rx error.
>>>>>> +##
>>>>>> +
>>>>>> +{ 'enum': 'CxlUncorErrorType',
>>>>>
>>>>> Doesn't these need
>>>>>
>>>>>         'if': 'CONFIG_CXL_MEM_DEVICE',
>>>>>
>>>>> ?
>>>>
>>>> If I make this change I get a bunch of
>>>>
>>>> ./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned 
>>>> "CONFIG_CXL_MEM_DEVICE"
>>>>      18 | #if defined(CONFIG_CXL_MEM_DEVICE)
>>>
>>> Err, I meant the generic CONFIG_CXL, not CONFIG_CXL_MEM_DEVICE.
>>>
>>>> It's a target specific define (I think) as built alongside PCI_EXPRESS
>>>> Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)
>>>>
>>>> To be honest though I don't fully understand the QEMU build system so 
>>>> the reason
>>>> for the error might be wrong.
>>>
>>> You need to restrict to system emulation (the 'have_system' check):
>>
>> This doesn't help - still have
>> attempt to used poisoned "CONFIG_CXL"

Not sure how the QAPI generator works, but target specific config switches 
can only be used in target specific json files there, so that's 
machine-target.json and misc-target.json currently, as far as I know. Not 
sure how the QAPI generator distinguishes between common and target specific 
code, though ... just by the "-target" suffix? Maybe Markus or Marc-André 
can comment on that.

See also:

  https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg01885.html
  https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02001.html

  Thomas

