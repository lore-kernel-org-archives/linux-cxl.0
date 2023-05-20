Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5303FC77B7D
	for <linux-cxl@archiver.kernel.org>; Sat, 20 May 2023 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjETPPl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 May 2023 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjETPPk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 20 May 2023 11:15:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CF8EE
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 08:15:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so3978074a12.2
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684595739; x=1687187739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azp2lPDxMovbyKL7Tz6FjMFF9Og73b9fxvPwWXagsnE=;
        b=CsauIKuyd4vOeG+m71SlcYkcJuqjcdhFjxXUq+BwTAVevHT7iJViz2yPZ428+fEOwm
         ihioy1RhcjKgO7UEtvbWqziHH7zMWV2+03b4dpLA0eKEKlEnGPRsd0fGfwAfs94Q3D93
         zS2qqdR7WCG0av/M9JHPfO6M81nIXM3bAm3Bi0C6Okj2R5zffDARWzpk/k6WYXUBf8d0
         3vPoVkaEIsfbBPGgbgea0WKLND/e0pzMX4t79si/cLO/xVSO/HOVNEUFYWv2X+e9H+A6
         +jIWqGQL2d+h4HQKkn2T1zrwDlPBnYusWhUlrJ5LB01308CkIpO3szt0MTjmNRzZ05Ho
         ZhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684595739; x=1687187739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azp2lPDxMovbyKL7Tz6FjMFF9Og73b9fxvPwWXagsnE=;
        b=F8JRCuONiTPLDGO0Mp3U7RELvDw4gp+aM6kKni2BQ8ADJjyFklOucbtL7imgmOrl3p
         Lggyj4lu6t6PwcA0zjsgUravus6+xAywz4VA7aZESUvxilBxvCEShux1eyczmJghsyRL
         hCv37/WPQNhWwIOt/ebg98Bc6f6RN+7T0/UGdLMpKUMATp6WTMClG25H+0PIEVm+E+bt
         w/0cvlkSkX/8xHQqSQ0jknGd4xgtlZz3+IRLvrpbiZYTZYGUESizGxrN+MtOhFLPAxKe
         6S/aEGmJ58YqemV837EuVXpTk/tMuGu5uWthMNFlR7VJVFN+aYiYwjmVrgICGtrg3in+
         RZ6Q==
X-Gm-Message-State: AC+VfDw8t60Pe91fqSyTyDypTBgT9UYgBk78hMirhw+p7dDvPTWA5fHI
        oP2wP7z5uiSH1P46XtWhRUb1ww==
X-Google-Smtp-Source: ACHHUZ6TOvS+TALg6me6eBQDlfdKZHFuBju9MfST9Uv0Isu1nhsRvIjjHowJngtaGaQWeSr+BW3OLQ==
X-Received: by 2002:a17:902:e887:b0:1ae:8e80:ba89 with SMTP id w7-20020a170902e88700b001ae8e80ba89mr4956926plg.0.1684595739119;
        Sat, 20 May 2023 08:15:39 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:d078:d94e:cb2b:a055? ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d88200b001ae4edac77bsm1606444plz.275.2023.05.20.08.15.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 08:15:38 -0700 (PDT)
Message-ID: <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
Date:   Sat, 20 May 2023 08:15:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
Content-Language: en-US
To:     BALATON Zoltan <balaton@eik.bme.hu>,
        Peter Maydell <peter.maydell@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
 <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 5/20/23 06:15, BALATON Zoltan wrote:
> On Sat, 20 May 2023, Peter Maydell wrote:
>> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
>> <qemu-devel@nongnu.org> wrote:
>>>
>>> From: Ira Weiny <ira.weiny@intel.com>
>>>
>>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
>>> specified as little endian.
>>>
>>> Define st24_le_p() and the supporting functions to store such a field
>>> from a 32 bit host native value.
>>>
>>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
>>> used for the size part of the function name.
> 
> Maybe it's clearer to use 24 but if we want to keep these somewhat consistent how about 
> using t for Triplet, Three-bytes or Twenty-four?

I think it's clearer to use '3'.
When I added 128-bit support I used cpu_ld16_mmu.

I think it would be clearer to not use letters anywhere, and to use units of bytes instead 
of units of bits (no one can store just a bit), but changing everything is a big job.


r~

