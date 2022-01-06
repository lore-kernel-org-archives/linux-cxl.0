Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1704BC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Jan 2022 21:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244214AbiAFVfP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244184AbiAFVfP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 6 Jan 2022 16:35:15 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17740C061245
        for <linux-cxl@vger.kernel.org>; Thu,  6 Jan 2022 13:35:15 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i30so3749184pgl.0
        for <linux-cxl@vger.kernel.org>; Thu, 06 Jan 2022 13:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35ojMSYwIvgEsuuGh69OMMKtHULIXG00CitHuqBTcw0=;
        b=CJEBeAj/nZWT2MyfajUj9d2s1ZNjDMgp0T+HRxUZv2U/LaZ3OGoHXnb7/m6wzcjPji
         OjqaFPBzP2MsuTEj0UiEXIqxX89q/p3uo98F86XilDAjxOydTvB+99EFbnE3q7DSswmL
         rkpBuwnduQc57lygATBnvSV36BWHhihdG1sErEA6YfY5GBoXnsKndIpH/IeLjh2Aq97I
         jEF/8wBSm2qVSOW54Ku5HH3PxzKjtwQJPUGIRRqGnPB/L35bcu6S92/bq2O8NCjByYe6
         GmuFjvAffH0OJtE5xEkSXWYQJsHkH958VIcf8fMnKUzs79E8CvO28AZJ5HlfR3O66yAV
         FlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35ojMSYwIvgEsuuGh69OMMKtHULIXG00CitHuqBTcw0=;
        b=XWDe/xi2jbkT7wZLd/7oztU9IlR+55XlUfngLc2uk3MWghSHNXxmJHBZbmajeNV97m
         43lHfbjvLjQoJr8RyHJppBKn09Cl7yddHXAVtum2/iDOXC2MQXg4hen5LTDn2VMBA8cH
         pnE8Q5HRNZQ50i4wm3zlwELr7T/tpyX3PiMyX8mnyJiYdN7/oaLG/13Zxt/TJLbw7hHX
         ZZSI19GKjZjbja3TvaWL70SacvJiMHIZ6X5BeCiSTqGdvoyVAMrt3j6mus2uSFlPrNeG
         i05Tlb0R5mk5qklx0cPeHIq6O0Pdpn3GsH6cT+ZqMXZJVPW6y1HKmt8GpIBxfLOyyMKR
         jY/A==
X-Gm-Message-State: AOAM532dHLIOEYRtqe8l2tb5H0hc+MoAe2BuaNe/LdMTnVQx/uOkA0iR
        BT13ZWupOdfF9sPc6rUO/WGoJFzhLTt5x+qhdXeLMA==
X-Google-Smtp-Source: ABdhPJwmEX2g8BALD4pA29y6kZXZUB42q8MmTye6C59853IQD0o9PptQhGPOlN7Pz67lmoA5szSS02j8S21CetF1YA8=
X-Received: by 2002:a63:ab01:: with SMTP id p1mr5889471pgf.437.1641504914623;
 Thu, 06 Jan 2022 13:35:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641233076.git.alison.schofield@intel.com> <fd590fbbc2f1abaeca1fd368d26c4e90c3a89d69.1641233076.git.alison.schofield@intel.com>
In-Reply-To: <fd590fbbc2f1abaeca1fd368d26c4e90c3a89d69.1641233076.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 6 Jan 2022 13:35:03 -0800
Message-ID: <CAPcyv4iPJb8AGOcgW5ncid2GTtft5UzxmXWD4U8bNn1JCCMaLA@mail.gmail.com>
Subject: Re: [ndctl PATCH 7/7] cxl: add command set-partition-info
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 3, 2022 at 12:11 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> The command 'cxl set-partition-info' operates on a CXL memdev,
> or a set of memdevs, allowing the user to change the partition
> layout of the device.
>
> Synopsis:
> Usage: cxl set-partition-info <mem0> [<mem1>..<memN>] [<options>]
>
>     -v, --verbose         turn on debug
>     -s, --volatile_size <n>
>                           next volatile partition size in bytes
>
> The MAN page explains how to find partitioning capabilities and
> restrictions.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
[..]
> diff --git a/cxl/memdev.c b/cxl/memdev.c
> index 5ee38e5..fa63317 100644
> --- a/cxl/memdev.c
> +++ b/cxl/memdev.c
> @@ -6,6 +6,7 @@
>  #include <unistd.h>
>  #include <limits.h>
>  #include <util/log.h>
> +#include <util/size.h>
>  #include <util/filter.h>
>  #include <cxl/libcxl.h>
>  #include <util/parse-options.h>
> @@ -23,6 +24,7 @@ static struct parameters {
>         unsigned len;
>         unsigned offset;
>         bool verbose;
> +       unsigned long long volatile_size;

This should be a string.

See parse_size64() that handles suffixes like K,M,G,T, so you can do
things like "cxl set-partition -s 256M" and behave like the other
"--size" options in ndctl.
