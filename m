Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F35C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 23:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiAZXl0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiAZXl0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 18:41:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5ADC06161C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 15:41:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so1178196pjp.0
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 15:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdwA6PMtx8MsiNY+iybWKRjLmwLwfi42cNTs3ZjsKhY=;
        b=eQqPdTquUvBK5722LPR0fZvLXR+7vhZqSx0wDW5BXFIz0Su0ZJFfv38q11GPU1hXTX
         YvNJadfRHqUsruKEhKkNKGEOzNQHrAR+aoJHlvASeP0I27xVOUvcUjYZnMtOmksAmEiF
         N//ZZgCfKrHgyd4963NevN9/hDlmzlcRHLunqNVexO0Fc1BnCFcLIjQM2YGrfohl0p8o
         /QHmOlyz5Hz4waTj/eqDf+aMs+PJ0553cHFNO6+w0YcmmZdGizdAhA3z1otokVlotzn+
         6soo4yHsohpTJrFsxeFewygiHXD/TgxYHXMX3JXR7d7K/mOcQLQjrSvU2Xjd0uvf8mYg
         gW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdwA6PMtx8MsiNY+iybWKRjLmwLwfi42cNTs3ZjsKhY=;
        b=AHe8zgsPKAEEbPgo7cDCeLvCyLRvJdOT9r3oxSB5LXq2NT8D791zSGEC74x/Rwe551
         Oac/cp6NMEOXcCotq8ouXtHCB29JcEkn53zk6kE60PSiiA0p5P8yiTZS2YjmLGTYaR4Y
         t2skmexqEa2l+ygY0DhjzkiGa/zjzIre42WxPM53WdPspPWVzhCpoiuUJuWecp/Y4MaE
         nsOvmM4EZ4uE+LwMmvaCEZpjiiBpc+i3m0HSW+3JK1KSBgM+gBgrQZ41uDoCfolpEmso
         NXHkyR6XOY6wrmmEHmN7/GSbq40eV2UXV4Ap2eEtUcRv68bkvhf3CCmA/SVGrJ8E2LEv
         /s2A==
X-Gm-Message-State: AOAM531UpRnb6+DqpBaw0AqhRZDXJTSK3HqDfyscRDcp+lL0dRSLgw7n
        tk48h6Wq411FelzsYwMUtSg3BpfY4q/YEGMm9eaQGw4yVp0Brg==
X-Google-Smtp-Source: ABdhPJyivjT6UDLsoiLGMt2wY9OPc5zKXSg7dd+T74aDu2s29hlnRG7JPk+PKX8uFIlVDlfr4MaJcA997vf/ZiCGsPs=
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr755378plr.132.1643240485431;
 Wed, 26 Jan 2022 15:41:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642535478.git.alison.schofield@intel.com> <e98fa18538c42c40b120d5c22da655d199d0329d.1642535478.git.alison.schofield@intel.com>
In-Reply-To: <e98fa18538c42c40b120d5c22da655d199d0329d.1642535478.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jan 2022 15:41:14 -0800
Message-ID: <CAPcyv4j4Nq1AAxH2CybQCH3pcBpCWgCsnY5i=OfKQXd_C_3xWA@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 5/6] libcxl: add interfaces for
 SET_PARTITION_INFO mailbox command
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 18, 2022 at 12:20 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Users may want the ability to change the partition layout of a CXL
> memory device.
>
> Add interfaces to libcxl to allocate and send a SET_PARTITION_INFO
> mailbox as defined in the CXL 2.0 specification.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  cxl/lib/libcxl.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  5 +++++
>  cxl/lib/private.h  |  8 ++++++++
>  cxl/libcxl.h       |  5 +++++
>  4 files changed, 68 insertions(+)
>
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 5b1fc32..5a5b189 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1230,6 +1230,21 @@ cxl_cmd_partition_info_get_next_persistent_bytes(struct cxl_cmd *cmd)
>         cmd_partition_get_capacity_field(cmd, next_persistent_cap);
>  }
>
> +CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_partition_info(struct cxl_memdev *memdev,
> +               unsigned long long volatile_capacity, int flags)
> +{
> +       struct cxl_cmd_set_partition_info *set_partition;
> +       struct cxl_cmd *cmd;
> +
> +       cmd = cxl_cmd_new_generic(memdev,
> +                       CXL_MEM_COMMAND_ID_SET_PARTITION_INFO);
> +
> +       set_partition = (struct cxl_cmd_set_partition_info *)cmd->send_cmd->in.payload;

->in.payload is a 'void *', no casting required.


> +       set_partition->volatile_capacity = cpu_to_le64(volatile_capacity);
> +       set_partition->flags = flags;

This has the potential to bite if users get accustomed passing in raw
values directly... more below.

> +       return cmd;
> +}
> +
>  CXL_EXPORT int cxl_cmd_submit(struct cxl_cmd *cmd)
>  {
>         struct cxl_memdev *memdev = cmd->memdev;
> @@ -1428,3 +1443,38 @@ CXL_EXPORT int cxl_memdev_read_label(struct cxl_memdev *memdev, void *buf,
>  {
>         return lsa_op(memdev, LSA_OP_GET, buf, length, offset);
>  }
> +
> +CXL_EXPORT int cxl_memdev_set_partition_info(struct cxl_memdev *memdev,
> +              unsigned long long volatile_capacity, int flags)
> +{
> +       struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
> +       struct cxl_cmd *cmd;
> +       int rc;
> +
> +       dbg(ctx, "%s: enter cap: %llx, flags %d\n", __func__,
> +               volatile_capacity, flags);
> +
> +       cmd = cxl_cmd_new_set_partition_info(memdev,
> +                       volatile_capacity / CXL_CAPACITY_MULTIPLIER, flags);

Given that the get-partition-info helpers emit 'bytes' I think it
would make sense for the set-partition-info to take bytes, i.e. move
the conversion to the 256MB shifted value internal to
xl_cmd_new_set_partition_info().


> +       if (!cmd)
> +               return -ENXIO;
> +
> +       rc = cxl_cmd_submit(cmd);
> +       if (rc < 0) {
> +               err(ctx, "cmd submission failed: %s\n", strerror(-rc));
> +               goto err;
> +       }
> +       rc = cxl_cmd_get_mbox_status(cmd);
> +       if (rc != 0) {
> +               err(ctx, "%s: mbox status: %d\n", __func__, rc);
> +               rc = -ENXIO;
> +       }
> +err:
> +       cxl_cmd_unref(cmd);
> +       return rc;
> +}
> +
> +CXL_EXPORT int cxl_cmd_partition_info_flag_immediate(void)
> +{
> +       return CXL_CMD_SET_PARTITION_INFO_FLAG_IMMEDIATE;
> +}

I don't understand what this is for?

Let's back up. In order to future proof against spec changes, and
endianness, struct packing and all other weird things that make struct
ABIs hard to maintain compatibility the ndctl project adopts the
libabc template of just not letting library consumers see any raw data
structures or bit fields by default [1]. For a situation like this
since the command only has one flag that affects the mode of operation
I would just go ahead and define an enum for that explicitly.

enum cxl_setpartition_mode {
    CXL_SETPART_NONE,
    CXL_SETPART_NEXTBOOT,
    CXL_SETPART_IMMEDIATE,
};

Then the main function prototype becomes:

int cxl_cmd_new_setpartition(struct cxl_memdev *memdev, unsigned long
long volatile_capacity);

...with a new:

int cxl_cmd_setpartition_set_mode(struct cxl_cmd *cmd, enum
cxl_setpartition_mode mode);

...and it becomes impossible for users to pass unsupported flag
values. If the specification later on adds more flags then we can add
more:

int cxl_cmd_setpartition_set_<X>(struct cxl_cmd *cmd, enum
cxl_setpartition_X x);

...style helpers.

Note, I was thinking CXL_SETPART_NONE is there to catch API users that
forget to set a mode, but I also don't mind skipping that and just
defaulting cxl_cmd_new_setpartition() to CXL_SETPART_NEXTBOOT, up to
you.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/kay/libabc.git/tree/README#n99
