Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7302CC4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F1160E09
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 15:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhHKPiz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhHKPiz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 11:38:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F34C061765
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 08:38:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id nt11so4105008pjb.2
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzliepAchv7I3T6ua5NUe+IpIK1Rs2yTgekxcTT2dE0=;
        b=GDMaWBTKcMU8u9EYddW8KTRTYXBT18WRNBiiICSKF3uDJOhRlvM/GaVgiiDUOdfW9I
         UH5q3hT4GoipzJgBuLiEoT0N5UJ2/JgQobuebTxtJ7NWfJmelDDQ6JdrpU6rjyFhuc53
         q4cHg3+l07RbwO80305LEksuhirxNj5JwbPEQNN/lVpDoKfonE4IrQ6hU3GBsbazw+V7
         ZZPltLq1Adq/QseK+aONqHRwlKwIgJr9FVdoXHNQPZrm0JqHbwdBBIQeE8OQW0mIKt2P
         R2I7pViwwtdSuMgwGOU4mCAS9oM51dDjXO7zAPEoGDS8cl952CWLxWSgaYdO9JZi+0s7
         vr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzliepAchv7I3T6ua5NUe+IpIK1Rs2yTgekxcTT2dE0=;
        b=R7DiLvqWunZ5vHvSVnV6NR98XDS2IjDCG8vsQeDxUFBWHRS+2aapgZNpZ5CUT60GGb
         dDbZ7uF5Ywbre0g4URWG4+j42VOkEiEmSuD/tMpGBdfNczLYESJbN3FO/s+bNOr8OzmI
         T/SD6ABCK4dDYtmReKt/Eobwv5PchtRTpPN4pvNICz5u5I7Yet+dIHXH+Uh7ajTH2wQ7
         rgb/Zs7ZU2IdJKvv9FwYr06yxK8OknAYRIpj6acK1rrW7vfuV2u2ScIlozGjhOZnwpjh
         Ponu5wucnw57q4MPecxPDzp/JuWKQwkIriEAvGpsKaE+25tHUci18fgkERT1QvA4J0za
         kcNw==
X-Gm-Message-State: AOAM532yXUlB54ZmilnS4jXKMrS/4zSEiQl+VqZnu09SNTOSz3CfA1FF
        wIwxSTxCM4E/ngT5Y4TrvszvLceo+BtllVQUEIYHng==
X-Google-Smtp-Source: ABdhPJx05byHn7IEAOAOs3ScFqJjA9rCIRA9qyUqHmnPJH04+9K3i4lk9GPH/vgNkHS+FN6iA813RYcgnd7PUf86Xzw=
X-Received: by 2002:a17:902:ab91:b029:12b:8dae:b1ff with SMTP id
 f17-20020a170902ab91b029012b8daeb1ffmr4703290plr.52.1628696311061; Wed, 11
 Aug 2021 08:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210811194747.44688-1-johnny.li@montage-tech.com>
In-Reply-To: <20210811194747.44688-1-johnny.li@montage-tech.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Aug 2021 08:38:19 -0700
Message-ID: <CAPcyv4gecCFVDeV2VwoaNwqycqkHNdKZT4-4KkcqLEbQ9RBsmg@mail.gmail.com>
Subject: Re: [PATCH v1] cxl/pci: Fix debug message in cxl_probe_regs()
To:     "Li Qiang (Johnny Li)" <johnny.li@montage-tech.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 11, 2021 at 12:54 AM Li Qiang (Johnny Li)
<johnny.li@montage-tech.com> wrote:
>
> Indicator string for mbox and memdev register set to status
> incorrectly in error message.
>
> Signed-off-by: Li Qiang (Johnny Li) <johnny.li@montage-tech.com>

Looks good to me, applied.

> ---
>  drivers/cxl/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 47315bb2db10..70e80237865c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1032,8 +1032,8 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
>                     !dev_map->memdev.valid) {
>                         dev_err(dev, "registers not found: %s%s%s\n",
>                                 !dev_map->status.valid ? "status " : "",
> -                               !dev_map->mbox.valid ? "status " : "",
> -                               !dev_map->memdev.valid ? "status " : "");
> +                               !dev_map->mbox.valid ? "mbox " : "",
> +                               !dev_map->memdev.valid ? "memdev " : "");
>                         return -ENXIO;
>                 }
>
> --
> 2.17.1
>
>
