Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD459C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 21:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BA361019
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhJNV3Y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 17:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbhJNV3X (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 17:29:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FE3C061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 14:27:18 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so5041851pls.6
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNGCBwGGQSw99cENJKftH/ORXKCPl8SOyv4sQBu0lqA=;
        b=ANWhszpbkpC3qEqly9uwkomufNNiXvix8cHVLsmwPZGXE6VeTJUzVSCTExZH9u7XEw
         zt+gCgzHk2akz17Yg01zZ6LN7L28oTDmVNcABF+FwvZVoJxRNItDj/jGbbqrtg6KG7pY
         IOnMcY+lJ3XQh32FIciSJU5Rck1OmCjwLNl/Ne3WlV50REyf98N+nozcmKPeD8em/OGS
         LO9xqCP6zuiUQNnXifJOsnfd3OZ7+GiY9mk/eWwPjPnFsTJtOYwl4YREXH/qSvCzJ16F
         uOOAS+ks7Wy3HLblcQRgY4XRyvv7ur5PgJOPNobAFyawPZgAWCCui5MGWraBUk+bOnE1
         0Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNGCBwGGQSw99cENJKftH/ORXKCPl8SOyv4sQBu0lqA=;
        b=iPPdS5Vahi5p3+cQnwsgTL0XBVrHg1Et++W42b/Q+8SKMPvUBd4VN7YPc3YBZOEOKJ
         iY9n2sOf10E+PNlLAB2/niZ/r5Nl2hNKmXz78z8/o6hK2qleiT3fyDxS9/Fu/vWD5vau
         nQb9rvpvyic2B9VM8sikak9liichWPo/vOtadqpnw+CgH2m9DTKtBkkveRfNchVvobZr
         8lz1CBpmT4y4vQ9yAON8ouPmEr/u+z7cu5RFB745TPgWLhT2uKzKI30nIeUV6j4HG8Zx
         nzn2OdPydRgpUX18y2r4e8fOP9U75rmD7tiOgJdaQgewelNRELCt+AOttVfV2OiVK1wB
         3tfw==
X-Gm-Message-State: AOAM532xqH3T6MWnmK2sP+4sBwOBfCsd2EV8duOFasw79giEIV9GMYgJ
        WDEi7pMGjNIn3dTt3FDfnDrKePHHCYw6hUm0ni5S2w==
X-Google-Smtp-Source: ABdhPJzkZUuNvTnX4n8TX8b0la1zgjhjNektpLA2Hj9UlB5DGvGiaTKZUYj1dHznm5KDmV84pc6PlIikSsdgHymRLTA=
X-Received: by 2002:a17:90a:a085:: with SMTP id r5mr22972907pjp.8.1634246837935;
 Thu, 14 Oct 2021 14:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-13-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-13-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 14:27:07 -0700
Message-ID: <CAPcyv4h49Cei27qLAL8oUmcpa=Su_VArrAEzGwt3VSbpCoxYTw@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 12/17] libcxl: add interfaces for label operations
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add libcxl interfaces to allow performinfg label (LSA) manipulations.
> Add a 'cxl_cmd_new_set_lsa' interface to create a 'Set LSA' mailbox
> command payload, and interfaces to read, write, and zero the LSA area on
> a memdev.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  cxl/lib/private.h  |   6 ++
>  cxl/lib/libcxl.c   | 137 +++++++++++++++++++++++++++++++++++++++++++++
>  cxl/libcxl.h       |   7 +++
>  cxl/lib/libcxl.sym |   4 ++
>  4 files changed, 154 insertions(+)
>
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index 671f12f..89212df 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -79,6 +79,12 @@ struct cxl_cmd_get_lsa_in {
>         le32 length;
>  } __attribute__((packed));
>
> +struct cxl_cmd_set_lsa {
> +       le32 offset;
> +       le32 rsvd;
> +       unsigned char lsa_data[0];
> +} __attribute__ ((packed));
> +
>  struct cxl_cmd_get_health_info {
>         u8 health_status;
>         u8 media_status;
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 59d091c..8dd69cf 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1126,3 +1126,140 @@ CXL_EXPORT int cxl_cmd_get_out_size(struct cxl_cmd *cmd)
>  {
>         return cmd->send_cmd->out.size;
>  }
> +
> +CXL_EXPORT struct cxl_cmd *cxl_cmd_new_write_label(struct cxl_memdev *memdev,
> +               void *lsa_buf, unsigned int offset, unsigned int length)
> +{
> +       struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +       struct cxl_cmd_set_lsa *set_lsa;
> +       struct cxl_cmd *cmd;
> +       int rc;
> +
> +       cmd = cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_SET_LSA);
> +       if (!cmd)
> +               return NULL;
> +
> +       /* this will allocate 'in.payload' */
> +       rc = cxl_cmd_set_input_payload(cmd, NULL, sizeof(*set_lsa) + length);
> +       if (rc) {
> +               err(ctx, "%s: cmd setup failed: %s\n",
> +                       cxl_memdev_get_devname(memdev), strerror(-rc));
> +               goto out_fail;
> +       }
> +       set_lsa = (void *)cmd->send_cmd->in.payload;

...the cast is still nagging at me especially when this knows what the
payload is supposed to be. What about a helper per command type of the
form:

struct cxl_cmd_$name *to_cxl_cmd_$name(struct cxl_cmd *cmd)
{
    if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_$NAME)
        return NULL;
    return (struct cxl_cmd_$name *) cmd->send_cmd->in.payload;
}

> +       set_lsa->offset = cpu_to_le32(offset);
> +       memcpy(set_lsa->lsa_data, lsa_buf, length);
> +
> +       return cmd;
> +
> +out_fail:
> +       cxl_cmd_unref(cmd);
> +       return NULL;
> +}
> +
> +enum lsa_op {
> +       LSA_OP_GET,
> +       LSA_OP_SET,
> +       LSA_OP_ZERO,
> +};
> +
> +static int lsa_op(struct cxl_memdev *memdev, int op, void **buf,
> +               size_t length, size_t offset)
> +{
> +       const char *devname = cxl_memdev_get_devname(memdev);
> +       struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +       struct cxl_cmd *cmd;
> +       void *zero_buf = NULL;
> +       ssize_t ret_len;
> +       int rc = 0;
> +
> +       if (op != LSA_OP_ZERO && (buf == NULL || *buf == NULL)) {
> +               err(ctx, "%s: LSA buffer cannot be NULL\n", devname);
> +               return -EINVAL;
> +       }
> +
> +       /* TODO: handle the case for offset + len > mailbox payload size */
> +       switch (op) {
> +       case LSA_OP_GET:
> +               if (length == 0)
> +                       length = memdev->lsa_size;

What's the use case to support a default size for get? If someone
wants to do a zero length lsa_op shouldn't that just return immediate
success just like 0 length read(2)?

> +               cmd = cxl_cmd_new_read_label(memdev, offset, length);
> +               if (!cmd)
> +                       return -ENOMEM;
> +               rc = cxl_cmd_set_output_payload(cmd, *buf, length);
> +               if (rc) {
> +                       err(ctx, "%s: cmd setup failed: %s\n",
> +                           cxl_memdev_get_devname(memdev), strerror(-rc));
> +                       goto out;
> +               }
> +               break;
> +       case LSA_OP_ZERO:
> +               if (length == 0)

This one makes sense because the caller just wants the whole area zeroed.

> +                       length = memdev->lsa_size;
> +               zero_buf = calloc(1, length);
> +               if (!zero_buf)
> +                       return -ENOMEM;
> +               buf = &zero_buf;


> +               /* fall through */
> +       case LSA_OP_SET:

...and if length == 0 here there's no need to go any further, we're done.

> +               cmd = cxl_cmd_new_write_label(memdev, *buf, offset, length);
> +               if (!cmd) {
> +                       rc = -ENOMEM;
> +                       goto out_free;
> +               }
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       rc = cxl_cmd_submit(cmd);
> +       if (rc < 0) {
> +               err(ctx, "%s: cmd submission failed: %s\n",
> +                       devname, strerror(-rc));
> +               goto out;
> +       }
> +
> +       rc = cxl_cmd_get_mbox_status(cmd);
> +       if (rc != 0) {
> +               err(ctx, "%s: firmware status: %d\n",
> +                       devname, rc);
> +               rc = -ENXIO;
> +               goto out;
> +       }
> +
> +       if (op == LSA_OP_GET) {
> +               ret_len = cxl_cmd_read_label_get_payload(cmd, *buf, length);
> +               if (ret_len < 0) {
> +                       rc = ret_len;
> +                       goto out;
> +               }
> +       }
> +
> +       /*
> +        * TODO: If writing, the memdev may need to be disabled/re-enabled to
> +        * refresh any cached LSA data in the kernel.
> +        */

I think we're sufficiently protected by the nvdimm-bridge up/down
dependency. I.e. if the above commands actually worked then nothing
should have had the labels cached in the kernel.

After fixing the the length == 0 case you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
