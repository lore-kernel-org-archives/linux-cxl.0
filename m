Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8659C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 05:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbiC3FCf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiC3FCe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Mar 2022 01:02:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D3050E14
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 22:00:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so5052244pjk.4
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 22:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvmIFWffQ9qxIcPDV5hZJ7377a558VMxjdfGXzOKdlo=;
        b=ftycQwkOJ6TqvBZDBDO8wXVaYUNDHBm8Zi58suqGjsWhDStD9vsffcEsXBenyZ1jjy
         tB6WE7ox9DivrvsLVvmOyTjlGI8HMPtOSqljUWYxOJudktjNldk8omLmUOSDxpPPLzpL
         5QDN2pWdLrQIs3JASTTxeIEcppWbOC+e99BIzEStjmoSeziqjrwqSqUq5SjPMIHneN6Q
         5+PhJipNzPvmkKw2WneRwQuryicnsHmrYAq+3WCD3zmiY60EpLr0sykhBHHlwEGozNtK
         VwWhu+a5ILHwDC2sCgvKjIr5zwCD51PHUCScyvPq4hgPEWr6nLgQ1HbOuAyBHctxW/2J
         SRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvmIFWffQ9qxIcPDV5hZJ7377a558VMxjdfGXzOKdlo=;
        b=TmPE69HBFMJFLJ0UE7YSCS0YVNYxAifsjslPtwdYzggBmPLN/BEo09agCHOirNdEo4
         /JbuPjtmLDsGldA+Ra1BO0TtsKLgF6t09JdB21a41KcrqNaYG2/OkP7FjEayKRu72yGb
         Ef6RtWy8eP0jwESYNXaDJRoAtmuHkPaoyfGvAln09oenCBcZEN69lublZT9SMRjSC3kZ
         kPxYd1w1BD52gbq8PasyNFPYHsiI8p8mxAeo0L0EX6xhEaHrvQJcB8QHsAoGBRA2vjbS
         fiDDt7TbWPHs+Wy+E9mi94oYNE7w/RsSG7QC1h2biVhtgZYCqWfCJqVdmRafOG70KQiW
         txGw==
X-Gm-Message-State: AOAM533iNBD2kgAwA+F+inUSIkjMbHkAHmT/uEUcAh0fPD6eiG2aXOlZ
        ZZpc2GCrTEdqV2QnJV5yZl/HRvabToPcSfm+X3LhEw==
X-Google-Smtp-Source: ABdhPJz15u/zEvPGgv6MnPoXH7I0u7nDjtHUHda7FXqJCHKc6BNdfTiKAb/Vwe8ZRaRS3sgu2kKnoeK/PVanfHz+icA=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr2889085pjg.93.1648616449471; Tue, 29
 Mar 2022 22:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648601710.git.alison.schofield@intel.com> <265c48b1ae2d6ebfed21f41bc1bfd2c2b98a1257.1648601710.git.alison.schofield@intel.com>
In-Reply-To: <265c48b1ae2d6ebfed21f41bc1bfd2c2b98a1257.1648601710.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 22:00:39 -0700
Message-ID: <CAPcyv4h+mPTiBi4=N-Dc0LN-4zT+8C00D-3RVaY1XruZvDmp7w@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] cxl/mbox: Make handle_mailbox_cmd_from_user() use
 a mbox param
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
> Previously, handle_mailbox_cmd_from_user(), constructed the mailbox
> command and dispatched it to the hardware. The construction work
> has moved to the validation path.
>
> handle_mailbox_cmd_from_user() now expects a fully validated
> mbox param. Make it's caller, cxl_send_cmd(), deliver it. Update
> the comments and dereferencing of the new mbox parameter.

It's not clear to me that handle_mailbox_cmd_from_user() has reason to
exist as a helper vs being open coded in cxl_send_cmd() after this,
but that can be a follow-on cleanup.

>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 54 +++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 654e61a77eb3..b0abda67d7da 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -417,8 +417,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  /**
>   * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
>   * @cxlds: The device data for the operation
> - * @cmd: The validated command.
> - * @in_payload: Pointer to userspace's input payload.
> + * @mbox_cmd: The validated mailbox command.
>   * @out_payload: Pointer to userspace's output payload.
>   * @size_out: (Input) Max payload size to copy out.
>   *            (Output) Payload size hardware generated.
> @@ -433,59 +432,48 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>   *  * %-EINTR  - Mailbox acquisition interrupted.
>   *  * %-EXXX   - Transaction level failures.
>   *
> - * Creates the appropriate mailbox command and dispatches it on behalf of a
> - * userspace request. The input and output payloads are copied between
> - * userspace.
> + * Dispatches a mailbox command on behalf of a userspace request.
> + * The output payload is copied to userspace.
>   *
>   * See cxl_send_cmd().
>   */
>  static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
> -                                       const struct cxl_mem_command *cmd,
> -                                       u64 in_payload, u64 out_payload,
> -                                       s32 *size_out, u32 *retval)
> +                                       struct cxl_mbox_cmd *mbox_cmd,
> +                                       u64 out_payload, s32 *size_out,
> +                                       u32 *retval)
>  {
>         struct device *dev = cxlds->dev;
> -       struct cxl_mbox_cmd mbox_cmd;
>         int rc;
>
> -       rc = cxl_to_mbox_cmd(cxlds, &mbox_cmd, cmd->opcode, cmd->info.size_in,
> -                            cmd->info.size_out, in_payload);
> -       if (rc)
> -               return rc;
> -
>         dev_dbg(dev,
>                 "Submitting %s command for user\n"
>                 "\topcode: %x\n"
>                 "\tsize: %zx\n",
> -               cxl_mem_opcode_to_name(mbox_cmd.opcode),
> -               mbox_cmd.opcode, mbox_cmd.size_in);
> +               cxl_mem_opcode_to_name(mbox_cmd->opcode),
> +               mbox_cmd->opcode, mbox_cmd->size_in);
>
> -       rc = cxlds->mbox_send(cxlds, &mbox_cmd);
> +       rc = cxlds->mbox_send(cxlds, mbox_cmd);
>         if (rc)
> -               goto out;
> +               return rc;
>
>         /*
>          * @size_out contains the max size that's allowed to be written back out
>          * to userspace. While the payload may have written more output than
>          * this it will have to be ignored.
>          */
> -       if (mbox_cmd.size_out) {
> -               dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
> +       if (mbox_cmd->size_out) {
> +               dev_WARN_ONCE(dev, mbox_cmd->size_out > *size_out,
>                               "Invalid return size\n");
>                 if (copy_to_user(u64_to_user_ptr(out_payload),
> -                                mbox_cmd.payload_out, mbox_cmd.size_out)) {
> -                       rc = -EFAULT;
> -                       goto out;
> +                                mbox_cmd->payload_out, mbox_cmd->size_out)) {
> +                       return -EFAULT;
>                 }
>         }
>
> -       *size_out = mbox_cmd.size_out;
> -       *retval = mbox_cmd.return_code;
> +       *size_out = mbox_cmd->size_out;
> +       *retval = mbox_cmd->return_code;
>
> -out:
> -       kvfree(mbox_cmd.payload_in);
> -       kvfree(mbox_cmd.payload_out);
> -       return rc;
> +       return 0;
>  }
>
>  int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
> @@ -506,9 +494,11 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>         if (rc)
>                 return rc;
>
> -       rc = handle_mailbox_cmd_from_user(cxlds, &c, send.in.payload,
> -                                         send.out.payload, &send.out.size,
> -                                         &send.retval);
> +       rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
> +                                         &send.out.size, &send.retval);
> +
> +       kvfree(mbox_cmd.payload_in);
> +       kvfree(mbox_cmd.payload_out);

It's not obvious that these are paired with the allocations in
cxl_to_mbox_cmd().

How about rename cxl_to_mbox_cmd() to cxl_mbox_cmd_ctor(), and wrap
these kvfree() calls in a helper called cxl_mbox_cmd_dtor()?


Otherwise, these are only minor comments, so you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
