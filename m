Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14972C61DA4
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjBVPcS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjBVPcS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 10:32:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1B3773B
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 07:32:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so829160wms.2
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 07:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVzFrKCuFSK7eT70pkY+VcYnT3HdH9nLSo3lTsO9lgM=;
        b=hweR71vYtdH908z56CW4tkhIY5ddlEtn0eOT0q9AcpOaCD/K5g8thOD8p1nnCzK1pz
         9bgYuWa+tf6cTL+VjgMytRs1RM5XcEWBYj4d7EKsYd306p+79ShKL0lZ9DEysfYZ6HQk
         1NRtLrPwxm8zNAYMedJEBb1yP2H0wOr9KMwI14Cb2+3/ts5HkGwQOvzM2ACXGm/i7GUu
         YsZ9QwIoWA3nHgyeJU7k8uVWxoFw9h6ejbb5+CeBs2g4/4AmQ4gOVEPspNlCZjlArPc4
         An9FufjXOwErja0N3tDVtv5XAwiaTB3A0J90gMxBgKDG88FTZ2f2FgFt2ox/wOS4wmVx
         pMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVzFrKCuFSK7eT70pkY+VcYnT3HdH9nLSo3lTsO9lgM=;
        b=43SMnRjKdSji7ClcCU47iA3/d2IiVAXqtrS/nbYgOPDQhS6fAZevRWvWgYU7sFoYjZ
         Ir/nVT5VzlYPfymn3UGFmF1tXfJUppRo9LzN+sDGmLoxw9GbX6Erk10DOAKVmqFVqYZo
         WwwAODqarbkBjzsTZl2XWyGHAvh8lAouNassn/TdYlCWSxdukZZV0IYBqUNA2QKchnu/
         sW7jmyA5Y2Vb35IRq98G2RH6o9Z4BihfeAeuWQ0XFbWmsZqfjtfP8UdYOtGP/cKVOTYC
         mGV78fpQSXMxwYphPCAntKYvSwbe0TcvXWDMj8xJMdVmJkzGJPcGoVNq18T54AxttXPC
         pstQ==
X-Gm-Message-State: AO0yUKUuV/PLqkU1Gozkg/P6F6bmRPn0Ez+Q28aSF0HBAbRUSGPtwfCW
        m6gqfuLG4cBKFt6MYiX6ugJziw==
X-Google-Smtp-Source: AK7set954uotp1PNFtGH1MlAHvPfpbqbWNJG9eh9Yz8TH9O274OfW2b8bfsH5eTdBBXg9P+iFgHG+A==
X-Received: by 2002:a05:600c:a695:b0:3e2:2f9:b8e2 with SMTP id ip21-20020a05600ca69500b003e202f9b8e2mr7047560wmb.35.1677079934198;
        Wed, 22 Feb 2023 07:32:14 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id e16-20020adfe390000000b002c54c8e70b1sm7841061wrm.9.2023.02.22.07.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:32:13 -0800 (PST)
Message-ID: <c2fb77b0-0734-3be5-1b54-7c797b3daa15@linaro.org>
Date:   Wed, 22 Feb 2023 16:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
 <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
 <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
 <20230222145330.000021ef@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230222145330.000021ef@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22/2/23 15:53, Jonathan Cameron wrote:
> On Tue, 21 Feb 2023 23:15:49 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Hi Jonathan,
>>
>> On 21/2/23 16:21, Jonathan Cameron wrote:
>>> CXL uses PCI AER Internal errors to signal to the host that an error has
>>> occurred. The host can then read more detailed status from the CXL RAS
>>> capability.
>>>
>>> For uncorrectable errors: support multiple injection in one operation
>>> as this is needed to reliably test multiple header logging support in an
>>> OS. The equivalent feature doesn't exist for correctable errors, so only
>>> one error need be injected at a time.
>>>
>>> Note:
>>>    - Header content needs to be manually specified in a fashion that
>>>      matches the specification for what can be in the header for each
>>>      error type.
>>>
>>> Injection via QMP:
>>> { "execute": "qmp_capabilities" }
>>> ...
>>> { "execute": "cxl-inject-uncorrectable-errors",
>>>     "arguments": {
>>>       "path": "/machine/peripheral/cxl-pmem0",
>>>       "errors": [
>>>           {
>>>               "type": "cache-address-parity",
>>>               "header": [ 3, 4]
>>>           },
>>>           {
>>>               "type": "cache-data-parity",
>>>               "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>>>           },
>>>           {
>>>               "type": "internal",
>>>               "header": [ 1, 2, 4]
>>>           }
>>>           ]
>>>     }}
>>> ...
>>> { "execute": "cxl-inject-correctable-error",
>>>       "arguments": {
>>>           "path": "/machine/peripheral/cxl-pmem0",
>>>           "type": "physical"
>>>       } }
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Hi Philippe,
> 
> Thanks for your review.  One question inline.
> 
>>> +#
>>> +# Type of uncorrectable CXL error to inject. These errors are reported via
>>> +# an AER uncorrectable internal error with additional information logged at
>>> +# the CXL device.
>>> +#
>>> +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
>>> +# @cache-address-parity: Address parity or other errors associated with the
>>> +#                        address field on CXL.cache
>>> +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
>>> +# @cache-data-ecc: ECC error on CXL.cache
>>> +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
>>> +# @mem-address-parity: Address parity or other errors associated with the
>>> +#                      address field on CXL.mem
>>> +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
>>> +# @mem-data-ecc: Data ECC error on CXL.mem.
>>> +# @reinit-threshold: REINIT threshold hit.
>>> +# @rsvd-encoding: Received unrecognized encoding.
>>> +# @poison-received: Received poison from the peer.
>>> +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
>>> +# @internal: Component specific error
>>> +# @cxl-ide-tx: Integrity and data encryption tx error.
>>> +# @cxl-ide-rx: Integrity and data encryption rx error.
>>> +##
>>> +
>>> +{ 'enum': 'CxlUncorErrorType',
>>
>> Doesn't these need
>>
>>        'if': 'CONFIG_CXL_MEM_DEVICE',
>>
>> ?
> 
> If I make this change I get a bunch of
> 
> ./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned "CONFIG_CXL_MEM_DEVICE"
>     18 | #if defined(CONFIG_CXL_MEM_DEVICE)

Err, I meant the generic CONFIG_CXL, not CONFIG_CXL_MEM_DEVICE.

> It's a target specific define (I think) as built alongside PCI_EXPRESS
> Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)
> 
> To be honest though I don't fully understand the QEMU build system so the reason
> for the error might be wrong.

You need to restrict to system emulation (the 'have_system' check):

-- >8 --
diff --git a/qapi/meson.build b/qapi/meson.build
index fbdb442fdf..643c76d61c 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -31,6 +31,7 @@ qapi_all_modules = [
    'compat',
    'control',
    'crypto',
-  'cxl',
    'dump',
    'error',
    'introspect',
@@ -58,6 +59,7 @@ if have_system
      'audio',
      'qdev',
      'pci',
+    'cxl',
      'rdma',
      'rocker',
      'tpm',
---

