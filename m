Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EECC7EE23
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBXTDN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBXTDM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:03:12 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D88514209
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:03:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j2so149165wrh.9
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeHdrzTRHjOdKzZKNf8TD6lSjBNiLWyMo4WSmYmb6jw=;
        b=poiQJjVntxqquElUCzR33mg0uIDl+9iq8v8GIFwfLGBKofXD8pSuOucyaV28Li1tC4
         FvJmNciqNmlXUVlauwqDELXkThOi7HdaMvTxw2ebElDhzkKvTWDWkj/DAjHRCTwwJCG1
         tpxJxgSSwYENkXS6L4rhJ1YK8aOUWmEYgmNa9cjEPHoYE09R4QVU8LOsYWPi0PPfYJbl
         QBrxZjCAsPS/SKIVw6A+zKScVjMVhaeiZ1VxQz7RGV9B2zs1uBkdVxrwwWuAhXQ2OtGf
         OLwdvZbdTLjbe9ZeDTVoMJHnlOMGMrk3AIn0m3yi8TcE3+dMhohIxnhPX08DzIEv4Xbc
         ctJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeHdrzTRHjOdKzZKNf8TD6lSjBNiLWyMo4WSmYmb6jw=;
        b=4Zp6OCrr3OTliSazkVLwTVYEys3s/VqP0qpvwa4slxxv+dMPuEl/CK681PHFGjic2O
         W16C6DCMS4l4AlFhhLSf4bascpHDzInudLpOTU3hEU4qhkA1azJEWBRLbGVeKZLEs+0R
         U+By3RZd3NPpgcvjn+jeTmDfz6hYOyed7OzPtw3ReDcMzyYfH3CSNfQkCCu8gIRQ5Y3I
         qMap3m8a2vVQsvtJhKkuz+mX0cTljCiqIjaRIPzrIXpn+nNilt2H02NhvpMx1J4lRfbE
         zjISD78yKTNBCggwvGlvgqrkzqBj1KZKr2GgsbC1TjXYEpAW0IVgxMhzlaOKRAg7nW+v
         5JlA==
X-Gm-Message-State: AO0yUKXXsBTOGoSgu7YZz+4czVY1JZgRoF/uF2+YnN44hgkcXkUFz5mI
        jF/KYrPhN48TGHaQ2uYgNbsBfQ==
X-Google-Smtp-Source: AK7set+m/LdF7l8wX+ezWdJkwGI3QBj3R35oyvVPpJryKitBf889AHbnk1/5fvylw8MNB4wUPZBORQ==
X-Received: by 2002:adf:cf06:0:b0:2bf:94ea:67ca with SMTP id o6-20020adfcf06000000b002bf94ea67camr14105532wrj.25.1677265383130;
        Fri, 24 Feb 2023 11:03:03 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d654e000000b002c5801aa9b0sm14336208wrv.40.2023.02.24.11.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 11:03:02 -0800 (PST)
Message-ID: <45b86050-0f0b-d222-c32f-9d6f23246574@linaro.org>
Date:   Fri, 24 Feb 2023 20:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
 <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
 <20230222145330.000021ef@huawei.com>
 <c2fb77b0-0734-3be5-1b54-7c797b3daa15@linaro.org>
 <20230222164947.0000554f@Huawei.com>
 <b9bd5698-1f73-b912-0344-4b70c30dd02a@linaro.org>
 <586d040f-d712-905e-fd68-bcde3713478b@redhat.com>
 <875ybsg7cl.fsf@pond.sub.org> <20230223142748.0000662f@huawei.com>
Content-Language: en-US
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230223142748.0000662f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 23/2/23 15:27, Jonathan Cameron wrote:
> On Thu, 23 Feb 2023 08:37:46 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
> 
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 22/02/2023 19.16, Philippe Mathieu-Daudé wrote:
>>>> +Thomas (meson) & Marc-André (conditional QAPI)
>>>
>>> + Markus
>>>   
>>>> On 22/2/23 17:49, Jonathan Cameron wrote:
>>
>> [...]
>>
>>>>>>>> Doesn't these need
>>>>>>>>
>>>>>>>>          'if': 'CONFIG_CXL_MEM_DEVICE',
>>>>>>>>
>>>>>>>> ?
>>>>>>>
>>>>>>> If I make this change I get a bunch of
>>>>>>>
>>>>>>> ./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned "CONFIG_CXL_MEM_DEVICE"
>>>>>>>       18 | #if defined(CONFIG_CXL_MEM_DEVICE)
>>>>>>
>>>>>> Err, I meant the generic CONFIG_CXL, not CONFIG_CXL_MEM_DEVICE.
>>>>>>   
>>>>>>> It's a target specific define (I think) as built alongside PCI_EXPRESS
>>>>>>> Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)
>>>>>>>
>>>>>>> To be honest though I don't fully understand the QEMU build system so the reason
>>>>>>> for the error might be wrong.
>>>>>>
>>>>>> You need to restrict to system emulation (the 'have_system' check):
>>>>>
>>>>> This doesn't help - still have
>>>>> attempt to used poisoned "CONFIG_CXL"
>>>
>>> Not sure how the QAPI generator works, but target specific config switches can only be used in target specific json files there, so that's machine-target.json and misc-target.json currently, as far as I know. Not sure how the QAPI generator distinguishes between common and target specific code, though ... just by the "-target" suffix? Maybe Markus or Marc-André can comment on that.
>>
>> Whenever you use a poisoned macro in a conditional, all the code
>> generated for this .json file (we call it a "QAPI schema module")
>> becomes target-dependent.  The QAPI code generator itself is blissfully
>> unaware of this.
>>
>> Since target-dependent code needs to be compiled differently, the build
>> process needs to be know which modules are target-dependent.  We do this
>> in one of the stupidest ways that could possibly work: a module is
>> target-dependent if its name ends with "-target".  There are just two
>> right now: qapi/machine-target.json and qapi/misc-target.json.
>>
>> The logic resides in qapi/meson.build.  Look for
>>
>>      if module.endswith('-target')
> 
> Thanks for all the pointers.
>>
>> Questions?
> 
> Is it sensible to make the cxl stuff all target dependent and do the following?
> I like that we can get rid of the stubs if we do this but I'm sure there are
> disadvantages. Only alternative I can currently see is continue to have
> stubs and not make the qmp commands conditional on them doing anything useful.

I still don't understand what is the target-dependent part of CXL.

IIUC CXL depends on PCIe which isn't target dependent.
