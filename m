Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A13AC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Apr 2022 21:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiDMVeQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiDMVeP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Apr 2022 17:34:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4B710FD
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 14:31:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso7460074pju.1
        for <linux-cxl@vger.kernel.org>; Wed, 13 Apr 2022 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HAP4pqEac4lfNJXlvViTtFzP0gATvktiVtnIJE/uYVU=;
        b=OgUsLuIUsRmFfr4A7P9lwSM4pawCMg07L9HQNRqW9PovWsQNVsSSizipMQzqnefQtR
         dT3AYO5SlxNk0rXJLXPlp/n3ufv7OeBnqnAver93U09NRMQVlXjaqS6SGF/LLoTnAtZb
         lxYTwF0Q2J+zQkytzs4WvXg+DAfVRYtVZNhcooK5MJqwXWKTzewMCMuhKyVsnwyWojWA
         Lg0X3NO4LmioIHph39lzBB0zSLqIrW51B9PvxXyxt/7F2CwwJ7DVKeC8ikgphhXHClc6
         +m0Zu+85RvBqAWQ5kMqdj10LFi1Qnzym+4+bnjKNYULR79BsWUVHcxHKVlhGiaW3rgTU
         Bpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HAP4pqEac4lfNJXlvViTtFzP0gATvktiVtnIJE/uYVU=;
        b=eWqxZJTtzsaFAAK26sFNcHs74SqJ/AbbexdQaftQRo4b3bSBfj5FDUJpeSQ9ZY0gYU
         LGCSkbRSUXiBMiEPZXJz7jg5jRqGq0ueW1Frg3ghhd61c3Kz6gB6vhNQwU3iwMzfL1pr
         fAqdvPYoE6ZlX8HYoPt3v3+JMOgEght1bvRNLiyBJvO/YtAAKFrO2fJpe1zEN/nNWlda
         QwXKDJfzVlNKhtbibHM/4Ih31nxN1bVrvzSTyyLdfdLKsXQESW4EiGw/aSjwFh2feZoc
         q0jgo8+YpILiEzi2gh3y3ita8Nzdq4WGVgXoNtYYp4yHUriS5XNrx6O9+rgZThMulJ+9
         PA1w==
X-Gm-Message-State: AOAM5311d0DHeIzqZKFKPcC6T0twNbZl+3h/otwh+WU7pRmn/jop81UG
        8VLtkPl4UTMSjIr/pb8SF69qUy0KNuw+WYOs2NUXsg==
X-Google-Smtp-Source: ABdhPJzHhDGvKo68ukuom7cTV+SESOYW7n3f9obDLSXfAilPQCpARZg985t9+XOVyOdt2pul9ubiwJdi+IRUHLr5ncc=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr43905072pll.132.1649885513102; Wed, 13
 Apr 2022 14:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220413183720.2444089-1-ben.widawsky@intel.com> <20220413183720.2444089-3-ben.widawsky@intel.com>
In-Reply-To: <20220413183720.2444089-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Apr 2022 14:31:42 -0700
Message-ID: <CAPcyv4hKGEy_0dMQWfJAVVsGu364NjfNeup7URb7ORUYLSZncw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/15] cxl/core/hdm: Bail on endpoint init fail
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 13, 2022 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Endpoint decoder enumeration is the only way in which we can determine
> Device Physical Address (DPA) -> Host Physical Address (HPA) mappings.
> Information is obtained only when the register state can be read
> sequentially. If when enumerating the decoders a failure occurs, all
> other decoders must also fail since the decoders can no longer be
> accurately managed (unless it's the last decoder in which case it can
> still work).

I think this should be expanded to fail if any decoder fails to
allocate anywhere in the topology otherwise it leaves a mess for
future address translation code to work through cases where decoder
information is missing.

The current approach is based around the current expectation that
nothing is enumerating pre-existing regions, and nothing is performing
address translation.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index bfc8ee876278..c3c021b54079 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -255,6 +255,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>                                       cxlhdm->regs.hdm_decoder, i);
>                 if (rc) {
>                         put_device(&cxld->dev);
> +                       if (is_endpoint_decoder(&cxld->dev))
> +                               return rc;
>                         failed++;
>                         continue;
>                 }
> --
> 2.35.1
>
