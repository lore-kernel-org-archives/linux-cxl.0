Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF52EC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 04:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiC3EwP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 00:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiC3EwO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 00:52:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B685227CD1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 21:50:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j13so19472171plj.8
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 21:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dy1J/nx4xiDbAxQkGI7HHsF6NRuNW3+X/8tqOc0eOPY=;
        b=cAj0nS1eCeiWT/9dVpXlC1ygJZ7RvlTuTgUABJI8KcyGeIhJXHmnaIB1qnEEEkRewV
         9jmGhlH5uS6574p+NmuzOZYhCPi14bbjZi5JNgDmAG88aAgunjNIZt13epdBlcmWAvr9
         o++Azkel62T7qXqWXmWTRHx32qNGxrJMai6xZyXf/ypPE0TjYp6zxZJe74mH35QUuEAq
         xaSWQQ58NBR8dRbasMP6YG1SuZcbEgaRaOVeC/x6FYoKGSax38KMHShhT7gRnINqAUlQ
         FuwIODm9DTxRoq3U8lajK4fcNss4zMnMhj1CieELDgN8APy/sd+z9q8AfC5xPGv1ZinF
         aFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dy1J/nx4xiDbAxQkGI7HHsF6NRuNW3+X/8tqOc0eOPY=;
        b=5bgiyjgP7svyuuQNiB90a5d0PP87ZEKknHS/FbQ4Qs3NddUHVVcDfg3/Um6uSGqXwj
         0t64CileAL7aoX65aA9nYzficZT7ZENttCzhfrv7ySrd7Oq8jP6lWl2rzIqZCHwwAF0Q
         xothbWQBO1rV1UHrfBjOmmJ0buO44GAtREgDAsXCzAoM6UqRyoF6CZTiK+qIy1GddyYA
         uLzq8rbAjWY92idGxkXGpMxEQI2Y97fACgrHbRPxYv82u5b0sQus+pXUmiszjUbNvQm4
         YIo9SSHmJga3yCxPOp9nheHU2ESgB0JVBPVSdkdeV3KK7Tmyf3LvJKjOMDjy+3VNgCQq
         2Y7A==
X-Gm-Message-State: AOAM530DRP8wM2gBrO1qzNbCnZk3IDTo8hA67rUcDLfx2ZtwyWQXSeR7
        XAgErrI/HnhuTH0iI5sROsjAxEHN308blbIV45UIsw==
X-Google-Smtp-Source: ABdhPJwe7I01UYuBQLMUHXOYiDi20tcVEcHKzXYd53HBmzeoDOuVUqXMAjxJ4NZPPV99InvCnUJz4jnn+GRDTKOS3P8=
X-Received: by 2002:a17:90a:990c:b0:1bc:3c9f:2abe with SMTP id
 b12-20020a17090a990c00b001bc3c9f2abemr2936658pjp.220.1648615828240; Tue, 29
 Mar 2022 21:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648601710.git.alison.schofield@intel.com> <1a1ebb7181b8be9fb746da48b41c02e54bee513e.1648601710.git.alison.schofield@intel.com>
In-Reply-To: <1a1ebb7181b8be9fb746da48b41c02e54bee513e.1648601710.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 21:50:17 -0700
Message-ID: <CAPcyv4gaZsFQYnFQtWBni67NYLoBxN+Hc=Y96OtPTPu5sRXfnA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] cxl/mbox: Remove dependency on cxl_mem_command for
 a debug msg
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 29, 2022 at 6:28 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> In preparation for removing access to struct cxl_mem_command,
> change this debug message to use cxl_mbox_cmd fields instead.
> Retrieve the pretty command name from cxl_mbox_cmd using a new
> opcode to command name helper.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 95882ab9f87b..654e61a77eb3 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -127,6 +127,17 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
>         return NULL;
>  }
>
> +static const char *cxl_mem_opcode_to_name(u16 opcode)
> +{
> +       struct cxl_mem_command *c;
> +
> +       c = cxl_mem_find_command(opcode);
> +       if (!c)
> +               return NULL;
> +
> +       return cxl_command_names[c->info.id].name;
> +}
> +
>  /**
>   * cxl_mbox_send_cmd() - Send a mailbox command to a device.
>   * @cxlds: The device data for the operation
> @@ -445,9 +456,9 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>         dev_dbg(dev,
>                 "Submitting %s command for user\n"
>                 "\topcode: %x\n"
> -               "\tsize: %ub\n",
> -               cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> -               cmd->info.size_in);
> +               "\tsize: %zx\n",
> +               cxl_mem_opcode_to_name(mbox_cmd.opcode),
> +               mbox_cmd.opcode, mbox_cmd.size_in);

Looks ok, although it's just a debug statement so the raw opcode would
also be acceptable to me to meet the goal of dropping the
cxl_mem_command usage.

Either way you decide to go:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
