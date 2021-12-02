Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7354C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 17:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbhLBRNS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhLBRNR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Dec 2021 12:13:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F78C06174A
        for <linux-cxl@vger.kernel.org>; Thu,  2 Dec 2021 09:09:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so178761plf.3
        for <linux-cxl@vger.kernel.org>; Thu, 02 Dec 2021 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5Au6s2fZ0UHVOVXUd+kxNSxuNXEbhFIO++4h56vFRk=;
        b=Q2QeB1qUo3MjE8h9M0QQErVxgAGGhtAR0+BPz0Xe3T7JSW9Zu2QMc4FYY5DE9qEAZ8
         7X2etgx13V/alRNbC6hHKnGTjLrTMrzsiWxYPR/fRmBX0nEirVU2Cho0Bapp9kn6o5f/
         NcqjE2DG68iCcQv9mlYVL23S9RxbRvXxZAyRyiRDW0YJHIWGX/J8ytSPgpSGFHWh7Dd7
         y22Al4W2ZMwI2kXZ+30vNxfkMe19S0bPx/Fqg7ngIFwriFTn0G4llX9O1WGRBvT9XDEq
         v+QU3oOiY2sts1IlkFcgTOvC5DOGNp3SLWg5kRlbFiDttnc5qE0lR4S/wsc+dHKEapg7
         TE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5Au6s2fZ0UHVOVXUd+kxNSxuNXEbhFIO++4h56vFRk=;
        b=8LAy5zb4g4yvcxvBTSqoZSh9TRCHx8zgUpMzrvRlU7PYTAd6Lr6pa5cfCRMNJT9WH3
         YwfMbYTqKsiHZ/Cg5BkMy5WoxxXlwxjTuEOFtk9wXHaX6G7dvwGArvFTEGsLJ3RetIBB
         YKOTJudzRvtG74QWnYYqlE5xp9xYqRK7azGf9TFMeQmuf/OkNB9KqL7kcukTA6UxxXqj
         A7rz6aPlsYA/gzVht7YsbSWifwNyi9oxk8J+NPajSaW9cNk6amvELuxrR5hKRDGw4A1I
         mMa5Qc6Cg01drRbWTe58HhABdKJutgvVxG7No6mSy22bwRXrWQTsrR+CgbCfCLzWyPjO
         AkCQ==
X-Gm-Message-State: AOAM531HLQrMI/xKkb/Raczbk835G0byv6OxwuhL8VAVd42zJIjskzd4
        bmbKb+5zff+63IFddx98t9pzm9pOk4dzD9LGVDImqg==
X-Google-Smtp-Source: ABdhPJw5Gl1ZvePNtgPUSidOE/By3ElI3IUEQbAowywGUKPaXmXGardcjWjBadh8iDu3vOQqSk1WOd2iPrkN13tlMlI=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr16414414plb.4.1638464994038; Thu, 02
 Dec 2021 09:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20211129214721.1668325-1-ben.widawsky@intel.com> <20211129214721.1668325-4-ben.widawsky@intel.com>
In-Reply-To: <20211129214721.1668325-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Dec 2021 09:09:44 -0800
Message-ID: <CAPcyv4iWNPA98x6GsOpeqF+11YeWgZternCJ0wgQtWOOknViSw@mail.gmail.com>
Subject: Re: [PATCH 3/9] cxl/pci: Extract device status check
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 29, 2021 at 1:47 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The Memory Device Status register is inspected in the same way for at
> least two flows in the CXL Type 3 Memory Device Software Guide
> (Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
> and 2.13.10 Media ready sequence. Extract this common functionality for
> use by both.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a6ea9811a05b..6c8d09fb3a17 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>         return 0;
>  }
>
> +/*
> + * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
> + * Device Software Guide
> + */

This version did not address the feedback about referencing the CXL
specification instead of the software guide.

> +static int check_device_status(struct cxl_dev_state *cxlds)
> +{
> +       const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> +
> +       if (md_status & CXLMDEV_DEV_FATAL) {
> +               dev_err(cxlds->dev, "Fatal: replace device\n");
> +               return -EIO;
> +       }
> +
> +       if (md_status & CXLMDEV_FW_HALT) {
> +               dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
>   * @cxlds: The device state to gain access to.
> @@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
>          * Hardware shouldn't allow a ready status but also have failure bits
>          * set. Spit out an error, this should be a bug report
>          */
> -       rc = -EFAULT;
> -       if (md_status & CXLMDEV_DEV_FATAL) {
> -               dev_err(dev, "mbox: reported ready, but fatal\n");
> +       rc = check_device_status(cxlds);
> +       if (rc)
>                 goto out;
> -       }
> -       if (md_status & CXLMDEV_FW_HALT) {
> -               dev_err(dev, "mbox: reported ready, but halted\n");
> -               goto out;
> -       }
> +
>         if (CXLMDEV_RESET_NEEDED(md_status)) {
>                 dev_err(dev, "mbox: reported ready, but reset needed\n");
> +               rc = -EFAULT;
>                 goto out;

It also did not address the feedback that the reset needed check can
be dropped because per the spec* it is redundant with the other checks
above. The driver need not give up on mailbox commands just because
the media is not ready. So this wants a lead-in patch to clean that up
first.

"This field returns non-zero value if FW Halt is set or Media Status
is not in the ready state."

Going further I do not think the driver should preemptively abort
commands due to device-fatal, or even firmware halt for that matter.
The true sign of failure and dead firmware is timed-out responses to
incoming commands. Just in case there are some commands still
functional in a device-fatal condition, or the firmware-halt indicator
was a false positive, let the command through, and then if it fails
report these forensic statuses.

"Mailbox Interfaces Ready" is the only status that needs to be checked
preemptively, and only once at the beginning of time until the next
command timeout where the driver collects it to find out what
happened.

I'll take a shot at a lead-in patch to that effect.
