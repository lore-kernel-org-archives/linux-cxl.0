Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF41CC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 00:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiC3A0Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 20:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiC3A0X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 20:26:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABE751E77
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:24:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i11so7795681plg.12
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylrqPtDRpqKdH0Jofj0HZ85xHchR1jkh2/owj0NCXDI=;
        b=c6v5MHQHyVJ26aZFG4bzjcl/PsBK5oWWp9raqNfrrd7FwbX+YAx1Y3oVaUmTz+0JQ1
         i9onk+tsZzHuNCFaamJ5iGUvFZnzrbasgqevZaRzoetzsbMe7uC9Vp75dxDB4Go4QgQS
         NMMqe7AeJuHRAS0kHCQKaKG4rSLwuLbuynUlCnZqsZo9TVxZ3ks35ThpRWGtS5Ss1Tx6
         4rloL6Ovu/S6+sZggBUl6jGVWUSF/4yX8F2bzKkyJl/epHVYxLxnqkDcIp5NCAK647xv
         vew1CTINKm9zP3SaN0+TLN5Bm273rmHRRVrT7Rm79M6UpR3GAR8EfblLdo5MvyG24YFr
         /vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylrqPtDRpqKdH0Jofj0HZ85xHchR1jkh2/owj0NCXDI=;
        b=rLaSijyOsa5D2k0wiCMg7ncglOpgJGJ9Z1iHjOeDhMv7xKX9A2yTz6Q1Jbu2BivmQw
         w5oVhajNZ1/BOTtM9/60swsb9wSwb3gVtO3QGFDhD0FchvXLoOSPU061gVLoQGe6rB9O
         eqBZqETfwgocBjyntYs9/k+L4ge7O8dW2A4LI3aDwBEce8QtiBmRyew7EH3x3JindZ0p
         OMJ4NQWzOKTkqA7awJByj2EescVzjggbL8D92ack3mnvSoEcnjE2W7kFBLfUy1igCHTX
         1ULUvWFeY06o3nHoIPHa7TwbQ0wZFQ9DBmxQs9eENW6baaPRJfP851xSlfDIrkvAwtXo
         HO9w==
X-Gm-Message-State: AOAM532MhdF1a+/vfagIbajRP43Br8u8H523jGbLlfyVuiWKa2eE4fU4
        B8DahmTDZqjgaiDIZ87UdQgY6jqHi36CJOZTVNhyCw==
X-Google-Smtp-Source: ABdhPJwEN6wCAsGpUO4j5nKq9o6JhoaSFLYdWkB5vQ36BAJ26V08RylmgVEqEgB8EgW6NqRtGUU2fCR+VoqvVAZDLXI=
X-Received: by 2002:a17:90a:990c:b0:1bc:3c9f:2abe with SMTP id
 b12-20020a17090a990c00b001bc3c9f2abemr1878969pjp.220.1648599878497; Tue, 29
 Mar 2022 17:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234049.69323-1-dave@stgolabs.net> <20220317234049.69323-5-dave@stgolabs.net>
In-Reply-To: <20220317234049.69323-5-dave@stgolabs.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 17:24:27 -0700
Message-ID: <CAPcyv4i=tV1dL3V=jCeZuxLbfqH8K0RCmQkutvnhxuqc3Z4rgw@mail.gmail.com>
Subject: Re: [PATCH 4/5] cxl/mbox: Use new return_code handling
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 4:41 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Use the global cxl_mbox_cmd_rc table to improve debug messaging
> in __cxl_pci_mbox_send_cmd() and allow cxl_mbox_send_cmd()
> to map to proper kernel style errno codes - this patch
> continues to use -ENXIO only so no change in semantics.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 7 ++++---
>  drivers/cxl/pci.c       | 3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d4d4a16820b7..fa9e7043f158 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -170,9 +170,10 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>         if (rc)
>                 return rc;
>
> -       /* TODO: Map return code to proper kernel style errno */
> -       if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
> -               return -ENXIO;
> +       if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> +               int err = cxl_mbox_cmd_rc2errno(&mbox_cmd);
> +               return -err;

I don't like the need for a local variable and adding the negation.
Just store the negative value directly and call the helper
cxl_mbox_cmd_rc2err() so that this can just do "return
cxl_mbox_cmd_rc2err(&mbox_cmd);".

> +       }
>
>         /*
>          * Variable sized commands can't be validated and so it's up to the
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0c36d111232b..67ec0220826f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -178,7 +178,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>                 FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>
>         if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
> -               dev_dbg(dev, "Mailbox operation had an error\n");
> +               dev_dbg(dev, "Mailbox operation had an error: %s\n",
> +                       cxl_mbox_cmd_rc2str(mbox_cmd));

Looks good.
