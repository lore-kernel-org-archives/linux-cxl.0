Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CE3C6FA8E
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 10:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCBKuA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBKt7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 05:49:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523EAD03
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 02:49:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e13so4548729wro.10
        for <linux-cxl@vger.kernel.org>; Thu, 02 Mar 2023 02:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677754197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o31DpofQKMwiF0QXWl2+GYaR9yoFmSvIR1KMvMRXpIA=;
        b=cGoUa8jITh/klMb9sPzqutvZ+2ywhbZs9/utVOAAefK9BTj8J0eWhZ99yYFqrLXLmy
         shwkWpAz70zsOE7aCLqvOT12b/HXvNLF91KVMcXHNz1vlCr1WSDubPwXeDnrcpfs1TO1
         huC/aq9FIsT5ftpqyvBN/dpku2MthY6kQrksyuIS/GqzdMkghJWoD0pVwbgYDde6/xW3
         hk3qnOJBq2bYFPGZCaZQd8KUmRgOR19dkWP2LqjKWRUml0ChfjaifjSrE8RegO5ZGkeJ
         NQ8XW2OJqI8PBYOKwK1Fi0GIfzebcDKqN2JXGSdxxHoQ2Rb2U392ikstfdg8tMJx0j4l
         5gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677754197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o31DpofQKMwiF0QXWl2+GYaR9yoFmSvIR1KMvMRXpIA=;
        b=eCM5TRTL8Z9ps7hSaf3NhBBy47nI50wfc7YBJgN0JVuwvS101c4w048KwJziViwMqK
         EoUM0ull2EWn0hocb6Ux5va345shDoQGn7U/5+1Ycko7BdHL2QEtH6QJG0cHVgImtoXz
         SM/rpazwtbR7Z22wT+K1S7y+4FyoXTTDjes6GPjd0XNPw/KxGFxVMI8AW/yMbKZS+j8u
         QtVydqc5DKOtfNh6RtqARBQpoSIDE292g6miqC+rry6MasFWtWHrfzbhqE+6DDdGWcZ9
         MRx1S3LTBrjvOwLUXF7OoIl54NXLmRizvhhqnst7XlgpN4XaS9GApcHJx/x2sZ0CK9G/
         faTg==
X-Gm-Message-State: AO0yUKXujnKcKAgvr8IYf448bG6KDvHdf27vHoMkKkkYdmlhy55GqrlP
        DHRH8h9cw/wZuCF1Zd2jHlNdPg==
X-Google-Smtp-Source: AK7set9hmycUPj+D+niptJeSnYhnttfxjkmSrtnQ5y7asTcrN3riMxxCyfvsVGSeBMw3NUyvl9vaMQ==
X-Received: by 2002:a5d:6589:0:b0:2c7:c49:e881 with SMTP id q9-20020a5d6589000000b002c70c49e881mr6979035wru.20.1677754196901;
        Thu, 02 Mar 2023 02:49:56 -0800 (PST)
Received: from [192.168.74.175] (89.red-88-28-21.dynamicip.rima-tde.net. [88.28.21.89])
        by smtp.gmail.com with ESMTPSA id y1-20020adfdf01000000b002c6d0462163sm15056720wrl.100.2023.03.02.02.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:49:56 -0800 (PST)
Message-ID: <e9287de7-94a6-944b-1627-3fa8f7f1a9bc@linaro.org>
Date:   Thu, 2 Mar 2023 11:49:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Michael Roth <michael.roth@amd.com>
References: <20230227112751.6101-1-Jonathan.Cameron@huawei.com>
 <20230227112751.6101-9-Jonathan.Cameron@huawei.com>
 <20230302100608.00005bcd@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230302100608.00005bcd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 2/3/23 11:06, Jonathan Cameron wrote:
> +CC Michael Roth.
> 
> Michael Tsirkin noted I'd missed CCing QAPI maintaintainers on the
> poison injection series so I went back to check the others I had out for review.
> For this series I'd managed to pick up one of two as Markus gave comments on
> earlier versions.

Now LGTM for meson/QAPI (although I'm not a QAPI maintainer).

Hopefully MST can take your series just in time for soft freeze.

> On Mon, 27 Feb 2023 11:27:51 +0000
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
>> CXL uses PCI AER Internal errors to signal to the host that an error has
>> occurred. The host can then read more detailed status from the CXL RAS
>> capability.
>>
>> For uncorrectable errors: support multiple injection in one operation
>> as this is needed to reliably test multiple header logging support in an
>> OS. The equivalent feature doesn't exist for correctable errors, so only
>> one error need be injected at a time.
>>
>> Note:
>>   - Header content needs to be manually specified in a fashion that
>>     matches the specification for what can be in the header for each
>>     error type.
>>
>> Injection via QMP:
>> { "execute": "qmp_capabilities" }
>> ...
>> { "execute": "cxl-inject-uncorrectable-errors",
>>    "arguments": {
>>      "path": "/machine/peripheral/cxl-pmem0",
>>      "errors": [
>>          {
>>              "type": "cache-address-parity",
>>              "header": [ 3, 4]
>>          },
>>          {
>>              "type": "cache-data-parity",
>>              "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>>          },
>>          {
>>              "type": "internal",
>>              "header": [ 1, 2, 4]
>>          }
>>          ]
>>    }}
>> ...
>> { "execute": "cxl-inject-correctable-error",
>>      "arguments": {
>>          "path": "/machine/peripheral/cxl-pmem0",
>>          "type": "physical"
>>      } }
>>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>> v6: (Thanks to Philippe Mathieu-Daudé)
>> - Add Since entries in cxl.json
>> - Add error prints in the stub functions so that if they are called without
>>    CONFIG_CXL_MEM_DEVICE then we get a useful print rather than just silently
>>    eating them.
>> ---
>>   hw/cxl/cxl-component-utils.c   |   4 +-
>>   hw/mem/cxl_type3.c             | 281 +++++++++++++++++++++++++++++++++
>>   hw/mem/cxl_type3_stubs.c       |  17 ++
>>   hw/mem/meson.build             |   2 +
>>   include/hw/cxl/cxl_component.h |  26 +++
>>   include/hw/cxl/cxl_device.h    |  11 ++
>>   qapi/cxl.json                  | 128 +++++++++++++++
>>   qapi/meson.build               |   1 +
>>   qapi/qapi-schema.json          |   1 +
>>   9 files changed, 470 insertions(+), 1 deletion(-)

