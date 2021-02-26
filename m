Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3161C433E0
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAF864F1B
	for <linux-cxl@archiver.kernel.org>; Fri, 26 Feb 2021 20:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhBZU4X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhBZU4S (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 Feb 2021 15:56:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4FFC061786
        for <linux-cxl@vger.kernel.org>; Fri, 26 Feb 2021 12:55:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gt32so5458305ejc.6
        for <linux-cxl@vger.kernel.org>; Fri, 26 Feb 2021 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luqx3cU12gW6l31P+oloN1EmDovQOrEz+j/E4ZvRIEo=;
        b=N7R0KM77yXb5Q4ragmQ+c1Y18LNttK0H8Cf8chtF14NxpHhnVDeUleN04i4hEhbR39
         UqiPg2hPKRLhazAGbUZ2TXVYGcOWmxqVDPigh59vyQmi0wpK9Mr91l059lpTPnmQqfQo
         bSFd/tb6HrzZfMhv5XrmNopU/03Z5fm+xgPxkiQdjc6tB60kpV+AU3jpq+HYgh9YDr5/
         JQJWihoPjw+V5WP33x63wwKHUWc42EixYD45J/Zx6H4Af/gNIfRHLORqGp6ghPnsaAzA
         oTYgdy5TFzXMi7lH4f+Fkai9dMUGP6TUwiLbdRQFofkI5qMJ7iEjWQGqTcs4J1X5FzwN
         jMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luqx3cU12gW6l31P+oloN1EmDovQOrEz+j/E4ZvRIEo=;
        b=KGJwlx2LEnuBQ2wu/TxZwWGyj1u0wFvyT+wwl7g4P0zypsBb6ldhhYtfHLXoTKY3oQ
         aio9I3b1D2AWFY0XfnftyrDWxf0sL7rwfypeVr2mH1G+WaBmQjAySLqqdNpY3ub9RokZ
         0sBWDgQ+JrwOqlFwbUri+janIg0t3f1rHzKejBYVWyWi1Vmrk5TBS3/V4WSeUZIxuWIr
         Tx1WwkUjq/+ft8VzruEZ6Af+oY5V9UQHDdU1Xm+cw9v/Mu5Eg6awuhMhrUfMX5P4J1ls
         rcstts8sIUBGdAcUswZXM96E4lubjOcFKIfHtsyC092S4gPjszsJt4m50feWUFIXCCt9
         TGGA==
X-Gm-Message-State: AOAM530D+2UY89XfFhgY3cjhphMzibd/7hxgS403oujeCcY9O013mlc4
        6PLgiHi1os3H1I4S8bRFebbzvzugEvhYWLr4/g4vCA==
X-Google-Smtp-Source: ABdhPJwqQp9Aelw/XXCeN0Yu1s0zfwetVb/ScUA0ulc18ycRDHuH7TtrBNR/oZNq1kKDTKCfrG1kl+t9Gk3A4ucH0w8=
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr5230087ejb.264.1614372936636;
 Fri, 26 Feb 2021 12:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20210226204552.45399-1-konrad.wilk@oracle.com> <20210226204552.45399-2-konrad.wilk@oracle.com>
In-Reply-To: <20210226204552.45399-2-konrad.wilk@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 26 Feb 2021 12:55:25 -0800
Message-ID: <CAPcyv4iXhsOK0ZdHuHkQ-FwZbvT6H2M+FHRoZVr=Pv8SUdpT+g@mail.gmail.com>
Subject: Re: [PATCH] cxl: Make loop variable be 'i' instead of 'j'
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 26, 2021 at 12:46 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>

Hey, Konrad, thanks for fixing this up. Some more cosmetic changes to
fold in below...

> .. otherwise people spend extra cycles looking for the
> inner loop and wondering 'why j'?
>
> This was an over-sight when initial work was rebased

s/over-sight/oversight/

> so lets fix it here.

s/lets/let's/

> Fixes: 583fa5e71cae ("cxl/mem: Add basic IOCTL interface")

Since it's just cosmetic, I don't think it needs a "Fixes:". The
AUTOSEL-bot need not worry about this.

> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  drivers/cxl/mem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 244cb7d89678..2b8265b03b0d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -698,7 +698,7 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
>         struct device *dev = &cxlmd->dev;
>         struct cxl_mem_command *cmd;
>         u32 n_commands;
> -       int j = 0;
> +       int i = 0;

Let's move this initialization down to right before the loop. If this
ever gets refactored and @i gets reused this will break.

>
>         dev_dbg(dev, "Query IOCTL\n");
>
> @@ -716,10 +716,10 @@ static int cxl_query_cmd(struct cxl_memdev *cxlmd,
>         cxl_for_each_cmd(cmd) {
>                 const struct cxl_command_info *info = &cmd->info;
>
> -               if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> +               if (copy_to_user(&q->commands[i++], info, sizeof(*info)))
>                         return -EFAULT;
>
> -               if (j == n_commands)
> +               if (i == n_commands)
>                         break;
>         }
>
> --
> 2.13.6
>
