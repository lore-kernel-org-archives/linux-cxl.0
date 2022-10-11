Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7329C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 15:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKPeJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiJKPdL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 11:33:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468B81704C
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 08:22:38 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d24so13512867pls.4
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H21Nio4D2xn0RvfXYxXa/PUcol8n63P73+yyaGf437U=;
        b=iuRbfPeOBfszd1n0ONgHWaX5FsEggz9de5H404yoFgQ6veehM1sihh4ekroiQ4dXeh
         ECmCdqyntasMITc7JH89yJ9BXbPJpwV8iMH15bwEwlMDj1fPkmPlzb/NIUFeDtDeIDXh
         kNdnguV1AgQJ9ChOfPXUqVRBstBwH1OeNTxFgQYfXdCVh6JZ+/Fj6Qr5u4CK9Mvhx/R8
         UEw5pFMGik5ldUeIulalRLCt4eTwAh4vBSAz7YfyhyZFuWsiKnCEVumxw9kFeVa25pxK
         wOg+LKmDxCNuRPPHl1hEq4jjiiGEJODYixCYdwXl2cAHlBjQbG9c5I5CKhy/29foVEqZ
         BMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H21Nio4D2xn0RvfXYxXa/PUcol8n63P73+yyaGf437U=;
        b=BEpdZnZASzE7UqbB0qcLFbkF8QChyx8pYOFsNeuBtgXndNNf4HLK3yaDiJNHGTa/1Q
         qfP/iPaBYvH+WJlSC8NfU6Xc07RDy9Kv8jQNRfH0COgGaHFRRVZRzLfB+Dkop3D9uL41
         rr9BoV0fdvcc0eXyqVV+KOp9H+H01cSIXpb5qdTIWAe1iDt9KokJUKiHEzLIq5OeeXb+
         kKn8VqBI7WVsMq8ahgtIfbEvlPCibsBpdlgo9oa/RepYDlhhJ1bAPHdo20esuc1vMouo
         y+44DQlxFg2RucqNoJ8fcqtJqWwKv98bLuaNY2KOueUS14wJKI1lVsHFrlU3ptyUOKYb
         WDzw==
X-Gm-Message-State: ACrzQf1PVYTTl8wu6mz9vOYSz2iqz9r4iB8fgWIKEwIJg0tlvCDXvpSW
        q0sYO9cIJv7EPuc9ZeaGDjS9eQ==
X-Google-Smtp-Source: AMsMyM7R67b2kprMTt7x7ehl96nSBL+sKbYVyNdo/8R2YjOZHWijiIPvfBmdnRXv7OmqjGKMUML4jA==
X-Received: by 2002:a17:902:b589:b0:179:f8c5:7212 with SMTP id a9-20020a170902b58900b00179f8c57212mr24833426pls.174.1665501756241;
        Tue, 11 Oct 2022 08:22:36 -0700 (PDT)
Received: from ?IPV6:2602:47:d49d:ec01:67e1:640e:ccb8:1a4a? ([2602:47:d49d:ec01:67e1:640e:ccb8:1a4a])
        by smtp.gmail.com with ESMTPSA id x20-20020aa79ad4000000b00562a5f29ac1sm9184207pfp.100.2022.10.11.08.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 08:22:35 -0700 (PDT)
Message-ID: <05ed1f6a-0771-798c-408b-272fb57b4582@linaro.org>
Date:   Tue, 11 Oct 2022 08:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 1/6] qemu/bswap: Add const_le64()
Content-Language: en-US
To:     Peter Maydell <peter.maydell@linaro.org>, ira.weiny@intel.com
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20221010222944.3923556-1-ira.weiny@intel.com>
 <20221010222944.3923556-2-ira.weiny@intel.com>
 <CAFEAcA9yVKWCZ-PhCbHqpaEW7Tgtqoo=wSQLy6=U5yfq2uVfPA@mail.gmail.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9yVKWCZ-PhCbHqpaEW7Tgtqoo=wSQLy6=U5yfq2uVfPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 10/11/22 02:48, Peter Maydell wrote:
>> +# define const_le64(_x) (_x)
>>   # define const_le32(_x) (_x)
>>   # define const_le16(_x) (_x)
>>   #endif
> 
> This is kind of a weird API, because:
>   * it only exists for little-endian, not big-endian
>   * we use it in exactly two files (linux-user/elfload.c and
>     hw/input/virtio-input-hid.c)
> 
> which leaves me wondering if there's a better way of doing
> it that I'm missing. But maybe it's just that we never filled
> out the missing bits of the API surface because we haven't
> needed them yet. Richard ?

It's piecemeal because, as you note, very few places require a version of byte swapping 
that must be applicable to static data.  I certainly don't want to completely fill this 
out and have most of it remain unused.


r~

