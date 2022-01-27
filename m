Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C5C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 22:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiA0WqZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 17:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiA0WqZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 17:46:25 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4293DC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 14:46:25 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e9so3644794pgb.3
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 14:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/11zwmji6aqM+TcjzSqvFbPLSRncjG/b2Hrb4dKpUQI=;
        b=15IS/YZrVUUtEdVs3hk6GBcxlhbNtFSUbCWiXBLRAG9j/myRWYjG6yigkfRVywh7iu
         PIQUVgcRx5cgkYisLMWwiPqd8Vgb5b1DEaM3PrdqjIGm1EDWrxHpyGvIPuHMpQQJinV/
         DH1G5nnlJdBjr8+pzNxeRe8KUeolgf/blmIzn7LscLj3clxMoZgBtcWkzbOxElSiBrNd
         /JlRCUrBp73K9Oy2Xcki4ltKN7Y/apRN7tiGimHJht6b9d/BBb2IIu8BwPCHfVXHOvTt
         NoQUI689U/3K7Lf6PolammEtrD3FNX9H17dPA427gUkJxi+ivw0Wwo4JJNfFhaLBtaYa
         uyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/11zwmji6aqM+TcjzSqvFbPLSRncjG/b2Hrb4dKpUQI=;
        b=CzNwOBrcMvxETXa1jO20cUYgBKgMh9xKINd/GJY8ZpXo3oKOAD5h7UiDM2TuM0TJTb
         Uv6ZYLGPiT8DBQunAb4RbObPrGH7bWHnOOh3He/ZoDvuH79KA6gIv/fBVEwk4C2zFQfD
         0Pq8OPWpl81p/msl9M+klwbZktgV6jqafUfy6BXv6odRmeC/FpolXmCrIn35sXvv6Xdv
         F2tSbZxBe2Vv6LTO5LNXvsOLjTnJL6DiFev9S3o3+sowwvBXp3438oPgyT8NJlAGXBW5
         gICoumBeLsOiZS0Beo95LhFcGTz3SimGewwGYZ8XeTvqs8+N8/fRyd8k5L2fhRdas+Jt
         n2Dw==
X-Gm-Message-State: AOAM533JKwwjFl+GXxy43JR2IgyniT6srkDmLejwvEV3TjzyAlW7FfXo
        nDrePgeTjB0Pd9uCZdMUOzsSP3Gprt7ru/QVutCQzA==
X-Google-Smtp-Source: ABdhPJzaGVV9a6xmMmBvhXo3f8rFaIdDjDQ85ZmsKBIALsl3fi+U5V+UBW+LxWY3JCS14UjcCTeyY9ImHKM2F4MKCds=
X-Received: by 2002:a63:4717:: with SMTP id u23mr4483852pga.74.1643323584813;
 Thu, 27 Jan 2022 14:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20220127212911.127741-1-ben.widawsky@intel.com> <20220127212911.127741-2-ben.widawsky@intel.com>
In-Reply-To: <20220127212911.127741-2-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jan 2022 14:46:14 -0800
Message-ID: <CAPcyv4hEB2BBcNUeRs4m-p5BwkLNd3cHWjFFYVWaZaLOtE_DOQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] cxl/acpi: Store interleave granularity absolutely
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 1:29 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> This matches the usages everywhere else in the driver and matches the
> existing kernel documentation defined for CXL decoders.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index f64d98bfcb3b..f99cad8350fd 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -11,7 +11,7 @@
>
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>  #define CFMWS_INTERLEAVE_WAYS(x)       (1 << (x)->interleave_ways)
> -#define CFMWS_INTERLEAVE_GRANULARITY(x)        ((x)->granularity + 8)
> +#define CFMWS_INTERLEAVE_GRANULARITY(x)        (1 << ((x)->granularity + 8))

Looks good.
