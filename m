Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B063C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 12:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjB1MmM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 07:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjB1MmL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 07:42:11 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578392F7B4
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 04:42:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so5765707wmi.3
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5hJ+eTqZrxz3dDPsvOutkkWilrj1NrB+BKXpY9G/MI=;
        b=SOuwLi4NWy2Is8TFRYPyhjZRqvwXTQuvQb4wWkN7/8oEAR8/fqx+J1wiWxCHod2/WG
         Jed3xVcc2tXblRFBWcFhm8Dcv2yanIyms+KW8+lx4cBfWHS/RN8BZ64sgSpliMwuZR6j
         xBVXvWPKVDtrooecuewutFdqU804yKNtD96ujBcMPlLUXhrA8zqGoQkAezqkZ/nZ9OpQ
         pRj0h2G7mngPbCetI3Ie5KTu9FPizajApv0owcl8WP4FZb1YCAtCIfaEKSlRtJi75R2A
         yN9SgFyig4cpAzL69XwvbxGXHK1d9GxZRSvgJxfn+r2RNlmXkwgNSRASgx8atCAjnFAM
         6c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5hJ+eTqZrxz3dDPsvOutkkWilrj1NrB+BKXpY9G/MI=;
        b=oCXRfyH31qHj4BJ2lIeHxsYNZU3JWKEdpxU1aJEj4Yh+95rkJVERiEPmnLHC5RQK3S
         buxate0IcCy7kM64KOnu4LAbrI+qMVN5pV+ZnJ45z+xBPexkyYT+Z0ITmaxeLI7NxZ6X
         dQ1K8QZLFJXOZ3yim1NIX82ctsD0SMp7e05ir10OKZr3nXG4mphinjmuFCHjYv9lLSAB
         YF2IT6BbvJ7kB83xDWlssg1RLl/Zlvo+mCgimk+q7SMKl1cIca/Ts0k885sh/bWHzPtZ
         dxQwl9OWJXkDBs24k001VKchNZ9WbLTyJHM4nDKcLI7Gwwn6SCZ2rhw8ko8vP1pFibgu
         rbTQ==
X-Gm-Message-State: AO0yUKUSz1eJZQP0DwpMlELsr6X40KKbWXV50/YxFtPxJ6RuxAw/A5yC
        zIcdQE+UqBhYVFTx7oxTnpMDChlIHCAIb0Hu
X-Google-Smtp-Source: AK7set+uOv8KB/WFsC7VRZ+FhuikWbE8cjk2p9KbeS5mcvAVtNo4t8naJHU0IYFuzdm6M7m50fHwlQ==
X-Received: by 2002:a05:600c:a695:b0:3e2:f80:3df1 with SMTP id ip21-20020a05600ca69500b003e20f803df1mr1888130wmb.19.1677588128842;
        Tue, 28 Feb 2023 04:42:08 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003eaf666cbe0sm13161048wmq.27.2023.02.28.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 04:42:08 -0800 (PST)
Message-ID: <e18377f5-5a8f-20a5-3c32-30f360b0475a@linaro.org>
Date:   Tue, 28 Feb 2023 13:42:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [RFC] CXL: TCG/KVM instruction alignment issue discussion default
Content-Language: en-US
To:     Gregory Price <gregory.price@memverge.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Richard Henderson <richard.henderson@linaro.org>
References: <Y/Cm5nuJl3G2CG2p@memverge.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <Y/Cm5nuJl3G2CG2p@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 18/2/23 11:22, Gregory Price wrote:
> 
> Breaking this off into a separate thread for archival sake.
> 
> There's a bug with handling execution of instructions held in CXL
> memory - specifically when an instruction crosses a page boundary.
> 
> The result of this is that type-3 devices cannot use KVM at all at the
> moment, and require the attached patch to run in TCG-only mode.
> 
> 
> CXL memory devices are presently emulated as MMIO, and MMIO has no
> coherency guarantees, so TCG doesn't cache the results of translating
> an instruction, meaning execution is incredibly slow (orders of
> magnitude slower than KVM).
> 
> 
> Request for comments:
> 
> 
> First there's the stability issue:
> 
> 0) TCG cannot handle instructions across a page boundary spanning ram and
>     MMIO. See attached patch for hotfix.  This basically solves the page
>     boundary issue by reverting the entire block to MMIO-mode if the
>     problem is detected.
> 
> 1) KVM needs to be investigated.  It's likely the same/similar issue,
>     but it's not confirmed.
> 
> 
> 
> Second there's the performance issue:
> 
> 0) Do we actually care about performance? How likely are users to
>     attempt to run software out of CXL memory?
> 
> 1) If we do care, is there a potential for converting CXL away from the
>     MMIO design?  The issue is coherency for shared memory. Emulating
>     coherency is a) hard, and b) a ton of work for little gain.
> 
>     Presently marking CXL memory as MMIO basically enforces coherency by
>     preventing caching, though it's unclear how this is enforced
>     by KVM (or if it is, i have to imagine it is).
> 
> 
> 
> It might be nice to solve this for non-shared memory regions, but
> testing functionality >>> performance at this point so it might not
> worth the investment.
> 
> 
> Just tossing this out for discussion
> ~Gregory
> 
> 
> 
> 
> diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> index 061519691f..cd383d7125 100644
> --- a/accel/tcg/translator.c
> +++ b/accel/tcg/translator.c
> @@ -171,8 +171,16 @@ static void *translator_access(CPUArchState *env, DisasContextBase *db,
>           if (host == NULL) {
>               tb_page_addr_t phys_page =
>                   get_page_addr_code_hostp(env, base, &db->host_addr[1]);
> -            /* We cannot handle MMIO as second page. */
> -            assert(phys_page != -1);
> +
> +            /*
> +            * If the second page is MMIO, treat as if the first page
> +            * was MMIO as well, so that we do not cache the TB.
> +            */
> +            if (unlikely(phys_page == -1)) {
> +                tb_set_page_addr0(tb, -1);
> +                return NULL;
> +            }
> +
>               tb_set_page_addr1(tb, phys_page);
>   #ifdef CONFIG_USER_ONLY
>               page_protect(end);
> 

This is:
https://lore.kernel.org/qemu-devel/20230222020023.904232-2-richard.henderson@linaro.org/

