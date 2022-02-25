Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC53FC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Feb 2022 21:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiBYVb6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Feb 2022 16:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiBYVb5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Feb 2022 16:31:57 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6C204286
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 13:31:24 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 75so5750553pgb.4
        for <linux-cxl@vger.kernel.org>; Fri, 25 Feb 2022 13:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYgxxGovmdXdivCsiXz8vE/sGIbHFpO0nXuljfb7o6U=;
        b=Bf90n1Ln921aCUkWrHmn2ZpfLdcPGRIfh6F/W31DrBH1MbLWIqSlfm5hr5ORmOnOoM
         x+zkWoP7NJA4/SFk2G7V7/kOtQ/RBdMVck21NU13DknNvKQBaPOHQzkIO0+5HT7zSjwb
         kNgMf4GyDA2dl4mPQ5JlQEng97IVv9S9b8cmuTuWrElm0lsizG1jPMvMbaSku4WCNQKs
         59mGcZdMb1gXsAama6XS596yz8q+qnk1cD1oUPmV1+YMiyovYKht7/9bVGK5v4c3l58x
         pLqJFBfc0k0xSk44YLO7qK9tGE+QgpCQUMMNgokBRqAlf8Z/VaQT79TMpHKLMiEdxMmB
         eMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYgxxGovmdXdivCsiXz8vE/sGIbHFpO0nXuljfb7o6U=;
        b=3JPraIWYAQDSFJ5KDxIzXrq4aqLE0avX0KwaEqXeUb8nhs/e4lKzoatsS2K8VV+WBE
         wDuiIkoAtgDAdY8WkrggTmfwqly6Yl4MQLRvGcBj8mgr5WUM7Nb3fquDFe4olAc1pYBo
         jx1KhJ4vPIbuDjQezz3z7uYnddRT/2ub8gUQEUj+TvNhNKV7yHOHnBFg5O9c3MRDe5tk
         XlbGWLro8q5uLJ/A8DEVFd0bKDWzdueB8POoHZLliZuGDCq2Fvg4tnxktYAxexsB9oX8
         M0ALfviSvHndrEdcuXsfWa6aX9U7y62xbrO8Uh9nMemn9idrMiBfjc4B0EuRGR3oaTTS
         sXXg==
X-Gm-Message-State: AOAM533sZY+nirGLDr0FIv5jXRkuhYoG5FZRSCrASIrdTjC7phFdvV0V
        /InRRYma2chBhp7CqEa4jkaqS4NheAvqPIBPDl7TzEIv72ERvg==
X-Google-Smtp-Source: ABdhPJxP6/kHUQCZae8l8gSjA7VL3VQ3VKBmJTDujGheaGmRj2XtF57zx2N0Ewxd4i+6A3JCiOf1UpqNAOBWB42ciZk=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr7816194pgb.74.1645824683928; Fri, 25
 Feb 2022 13:31:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1645817416.git.alison.schofield@intel.com> <84c0ddda79331bbbc37a6237e980b53735c29c77.1645817416.git.alison.schofield@intel.com>
In-Reply-To: <84c0ddda79331bbbc37a6237e980b53735c29c77.1645817416.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Feb 2022 13:31:13 -0800
Message-ID: <CAPcyv4g3LjDkRnE21rkMr0YddUJCBOe8LN5O7BFZPEYs_xp9gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] cxl/mbox: Move cxl_mem_command construction to
 helper funcs
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 25, 2022 at 12:27 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Sanitizing and constructing a cxl_mem_command from a userspace
> command is part of the validation process prior to submitting
> the command to a CXL device. Move this work to helper functions:
> cxl_to_mem_cmd(), cxl_to_mem_cmd_raw().
>
> This declutters cxl_validate_cmd_from_user() in preparation for
> adding new validation steps.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 143 ++++++++++++++++++++++------------------
>  1 file changed, 79 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index be61a0d8016b..06fbe6d079ba 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -207,6 +207,75 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>         return true;
>  }
>
> +static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
> +                             const struct cxl_send_command *send_cmd,
> +                             struct cxl_mem_command *mem_cmd)
> +{
> +       if (send_cmd->raw.rsvd)
> +               return -EINVAL;
> +       /*
> +        * Unlike supported commands, the output size of RAW commands
> +        * gets passed along without further checking, so it must be
> +        * validated here.
> +        */
> +       if (send_cmd->out.size > cxlds->payload_size)
> +               return -EINVAL;
> +
> +       if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> +               return -EPERM;
> +
> +       dev_WARN_ONCE(cxlds->dev, true, "raw command path used\n");
> +
> +       mem_cmd->info.id = CXL_MEM_COMMAND_ID_RAW;
> +       mem_cmd->info.flags = 0;
> +       mem_cmd->info.size_in = send_cmd->in.size;
> +       mem_cmd->info.size_out = send_cmd->out.size;
> +       mem_cmd->opcode = send_cmd->raw.opcode;

One subtle change from the previous version to this one is that it no
longer gets automatic zero initialization by the compiler. This leaves
a subtle timebomb if 'struct cxl_mem_command' is ever updated. So I
would write this as:

                *mem_cmd = (struct cxl_mem_command) {
                        .info = {
                                .id = CXL_MEM_COMMAND_ID_RAW,
                                .size_in = send_cmd->in.size,
                                .size_out = send_cmd->out.size,
                        },
                        .opcode = send_cmd->raw.opcode
                };

...where you can skip setting flags to 0 since that is implied by the
syntax and there is no need to worry about if all the unwritten fields
are zeroed.

> +
> +       return 0;
> +}
> +
> +static int cxl_to_mem_cmd(struct cxl_dev_state *cxlds,
> +                         const struct cxl_send_command *send_cmd,
> +                         struct cxl_mem_command *mem_cmd)
> +{
> +       const struct cxl_command_info *info;
> +       struct cxl_mem_command *c;
> +
> +       if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> +               return -EINVAL;
> +
> +       if (send_cmd->rsvd)
> +               return -EINVAL;
> +
> +       if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> +               return -EINVAL;
> +
> +       /* Convert user's command into the internal representation */
> +       c = &cxl_mem_commands[send_cmd->id];
> +       info = &c->info;
> +
> +       /* Check that the command is enabled for hardware */
> +       if (!test_bit(info->id, cxlds->enabled_cmds))
> +               return -ENOTTY;
> +
> +       /* Check that the command is not claimed for exclusive kernel use */
> +       if (test_bit(info->id, cxlds->exclusive_cmds))
> +               return -EBUSY;
> +
> +       /* Check the input buffer is the expected size */
> +       if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
> +               return -ENOMEM;
> +
> +       /* Check the output buffer is at least large enough */
> +       if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
> +               return -ENOMEM;
> +
> +       memcpy(mem_cmd, c, sizeof(*c));
> +       mem_cmd->info.size_in = send_cmd->in.size;

Perhaps for symmetry this can become:

                *mem_cmd = (struct cxl_mem_command) {
                        .info = {
                                .id = info->id,
                                .flags = info->flags,
                                .size_in = send_cmd->in.size,
                                .size_out = info->size_out,
                        },
                        .opcode = c->opcode
                };

...if I got that right...

> +       return 0;
> +}
> +
>  /**
>   * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
>   * @cxlds: The device data for the operation
> @@ -230,8 +299,8 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>                                       const struct cxl_send_command *send_cmd,
>                                       struct cxl_mem_command *out_cmd)
>  {
> -       const struct cxl_command_info *info;
> -       struct cxl_mem_command *c;
> +       struct cxl_mem_command mem_cmd;
> +       int rc;
>
>         if (send_cmd->id == 0 || send_cmd->id >= CXL_MEM_COMMAND_ID_MAX)
>                 return -ENOTTY;
> @@ -244,70 +313,16 @@ static int cxl_validate_cmd_from_user(struct cxl_dev_state *cxlds,
>         if (send_cmd->in.size > cxlds->payload_size)
>                 return -EINVAL;
>
> -       /*
> -        * Checks are bypassed for raw commands but a WARN/taint will occur
> -        * later in the callchain
> -        */
> -       if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW) {
> -               const struct cxl_mem_command temp = {
> -                       .info = {
> -                               .id = CXL_MEM_COMMAND_ID_RAW,
> -                               .flags = 0,
> -                               .size_in = send_cmd->in.size,
> -                               .size_out = send_cmd->out.size,
> -                       },
> -                       .opcode = send_cmd->raw.opcode
> -               };
> +       /* Sanitize and construct a cxl_mem_command */
> +       if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
> +               rc = cxl_to_mem_cmd_raw(cxlds, send_cmd, &mem_cmd);
> +       else
> +               rc = cxl_to_mem_cmd(cxlds, send_cmd, &mem_cmd);
>
> -               if (send_cmd->raw.rsvd)
> -                       return -EINVAL;
> +       if (rc)
> +               return rc;
>
> -               /*
> -                * Unlike supported commands, the output size of RAW commands
> -                * gets passed along without further checking, so it must be
> -                * validated here.
> -                */
> -               if (send_cmd->out.size > cxlds->payload_size)
> -                       return -EINVAL;
> -
> -               if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> -                       return -EPERM;
> -
> -               memcpy(out_cmd, &temp, sizeof(temp));
> -
> -               return 0;
> -       }
> -
> -       if (send_cmd->flags & ~CXL_MEM_COMMAND_FLAG_MASK)
> -               return -EINVAL;
> -
> -       if (send_cmd->rsvd)
> -               return -EINVAL;
> -
> -       if (send_cmd->in.rsvd || send_cmd->out.rsvd)
> -               return -EINVAL;
> -
> -       /* Convert user's command into the internal representation */
> -       c = &cxl_mem_commands[send_cmd->id];
> -       info = &c->info;
> -
> -       /* Check that the command is enabled for hardware */
> -       if (!test_bit(info->id, cxlds->enabled_cmds))
> -               return -ENOTTY;
> -
> -       /* Check that the command is not claimed for exclusive kernel use */
> -       if (test_bit(info->id, cxlds->exclusive_cmds))
> -               return -EBUSY;
> -
> -       /* Check the input buffer is the expected size */
> -       if (info->size_in >= 0 && info->size_in != send_cmd->in.size)
> -               return -ENOMEM;
> -
> -       /* Check the output buffer is at least large enough */
> -       if (info->size_out >= 0 && send_cmd->out.size < info->size_out)
> -               return -ENOMEM;
> -
> -       memcpy(out_cmd, c, sizeof(*c));
> +       memcpy(out_cmd, &mem_cmd, sizeof(mem_cmd));

Given the above helpers are already copying into a pointer, why not
pass them out_cmd directly instead of the extra mem_cmd hop?

>         out_cmd->info.size_in = send_cmd->in.size;

This could also be deleted since both helpers above already set
size_in = send_cmd->in.size.
