Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA00C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 22:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6FE6124C
	for <linux-cxl@archiver.kernel.org>; Wed, 10 Nov 2021 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhKJW3B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Nov 2021 17:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhKJW3A (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Nov 2021 17:29:00 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14267C061766
        for <linux-cxl@vger.kernel.org>; Wed, 10 Nov 2021 14:26:13 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z6so3876398pfe.7
        for <linux-cxl@vger.kernel.org>; Wed, 10 Nov 2021 14:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhsPCMX6fZnym+JQb4zpitIqmezgahI1oA1CZhModwU=;
        b=iAaH0/uXNupuVdI1iTVUnzA8rd2oWO6Rnipr9I5LwUwojYb2bhjwVjM6H85etQkyXE
         JfKzEpYn7BGhSHzXwIqEKUtJqcvgBSVcAj2LkvMH7FrLSST/s8X7T/LDks+AZTF22g84
         V/OtiYqxEYuaBj/fLHVyTmbY3eZuXmJSTFKQXKHkTIMj9RmrqkoYakJ6OCDLV0FKyA68
         r4DUH5Ihkfmo7jnoQeu0qQhkL7/wgtHeO3x2jJ0mRSOeUP2UZWopAr/HAhDV9gpzQi7a
         QMtzX9QdtX3Eh50TZjkbClQeiEP2PuPEQkws1lZx2XpdNitk2Ws0/VM1KovAXeESIEdR
         zcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhsPCMX6fZnym+JQb4zpitIqmezgahI1oA1CZhModwU=;
        b=rg6wJAvhpwp7mcpJiQ4h/dpXUyd4SaQF4g2VcBlBM9qVc/4C+csl/0GHVNSCe5tm4u
         H/ypxLHKCpHA+7bSZnQAsB258DSNyXuBt/uhqQG5F3I/fnUrJO7iJ6p/YJwdTSFzDeTM
         O1JqxOkro36EhGVPAyDQyNTquenht/8udnIpGn0qUCNt1IFamAh4ep5OgJxmTdEKwLN1
         SvT1TsSrlbJTbwC97iT/fe1b/rVY3DSCxXdlHx6QLMlGqn02FWS2KqnR2pKEF3RZ7Rpr
         WmIPNhho3yfOnrW33dyNF+Lq1b8QxI5RjYRM2pRNXRnjU7DcIGrKHyZazcALg7M8nuO6
         wR5A==
X-Gm-Message-State: AOAM532BfaEW1X4yji5cB5VJrorKbWb9e+jB8g7hE4wgFhpoP8Siqlde
        XVa48Qtd1fZKD7XzVZh+fCON5z4Y7a22pG5Tc4TuBw==
X-Google-Smtp-Source: ABdhPJy8L+1hHYWTkSCjxWeziXGbgTX2IxZFPn5aWixYUvFu/j+HHCZdQnPVZBBHumgEsR6zE0TbCyhsMepcHlFkBb4=
X-Received: by 2002:a05:6a00:1a51:b0:4a0:3c1:4f45 with SMTP id
 h17-20020a056a001a5100b004a003c14f45mr2308531pfv.86.1636583172639; Wed, 10
 Nov 2021 14:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20211110191425.3761515-1-ira.weiny@intel.com>
In-Reply-To: <20211110191425.3761515-1-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Nov 2021 14:26:01 -0800
Message-ID: <CAPcyv4hQF=vTcLRRQP3hsMTGTOTMkgVw2Q2AYeJoye+jhBjA6g@mail.gmail.com>
Subject: Re: [PATCH] cxl/memdev: Clean up the function declaration of cxl_add_memdev()
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 10, 2021 at 11:14 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Function return type and declaration should be on the same line.
>
> [1] https://lore.kernel.org/linux-cxl/20211103223413.n6fmf3gtop56wssz@intel.com/T/#m75fee4f12193169da20278cd48e9c655e904c88e
>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5341b0ba99a7..61029cb7ac62 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -276,8 +276,7 @@ static const struct file_operations cxl_memdev_fops = {
>         .llseek = noop_llseek,
>  };
>
> -struct cxl_memdev *
> -devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> +struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)

I went ahead and just folded this in since this commit has not been
finalized on cxl/next yet.
