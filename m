Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE2C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Mar 2022 03:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiC3DZ2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Mar 2022 23:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242265AbiC3DZY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Mar 2022 23:25:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3E6548
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 20:23:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z16so17614573pfh.3
        for <linux-cxl@vger.kernel.org>; Tue, 29 Mar 2022 20:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbIy+09lWriAjoJQkIaZDgvso2Ze50aQufgeiXJX5T4=;
        b=MeKhrEB0/zKn5AsKhz5NyBLmgLPv7TxLyPUCA/4ZBiFm9U1yclUL9V/4ZaSvv2LMol
         yTdu8s86mCwn4jS+5woxjdIBGL7A9bkI8c4OtbJvXjNY3LrQTlkFn6VqWOCJgAakiW7B
         BgFC63oA+8LrLbSMK7TT1BLXzAsy1VFYtHNrYYbHIvpjH+WU8A1u6lvT6OG334tyTLHg
         59rIb1g3NQBwIVO2l86LuM72WaC7oI8ufa8jEpfxDu3RzuE0tK1PtRqAgeWMWvathkRn
         Cv2hm+T9J3Ztj5UnVFiOlj6LtC5qIqvyFSKkPN+Wi4Q0qW914N67T5m4WRnyAdvpl4OV
         zRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbIy+09lWriAjoJQkIaZDgvso2Ze50aQufgeiXJX5T4=;
        b=JoSGopHuAZ/FOx3xWjsfgTSMRAhFPeio4YmlBeC5U1hJklmh6Bq7tQ94fAIrTYlnPM
         11uy/WtR+914P5IbgJwSb/wAsOT1zIEgqzHHcievfcwNt3AtrNVZl5R2LRnMAtk5o5fd
         mVv3KIXlr2FG/ETD3hL0w1x0Fq7WNKG0G4dT0d4C7X2KbYtTWlcLbi0syPRVhH4xA+Xe
         HVu2K4oNFzgkbLxE0Rc1PrwshOn3EOG36cdrzhNjmj3HI7nV5n9CAeIy0X9ue2sIQSzU
         dMy/+iSUySakFHb2LdpZGPlDoJxXA/cX7GiaWndAeoa1Umtxs+UpnEh9broJcjmCj5gK
         CG5Q==
X-Gm-Message-State: AOAM530y7wgMpZJCyx1r1Lgm/2Qfq2M6N8dzdSMDb4oWRe+Oq/ePNSFl
        TQQeKjaJl2mitKDrV0+opKMCOh2X5GqMi3MiVpthGK1Utwg=
X-Google-Smtp-Source: ABdhPJwPmuYP7IliVswVdCRL16D7R24uw67BX0rXSOYkJyTOSeEJvqTaJ+02VI6LE2JY0Vq6UHqYB3+bD4svy49dK2E=
X-Received: by 2002:aa7:86c6:0:b0:4fa:46d:6005 with SMTP id
 h6-20020aa786c6000000b004fa046d6005mr31352447pfo.86.1648610616947; Tue, 29
 Mar 2022 20:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648601710.git.alison.schofield@intel.com> <3d563038e093f435396f58b3757c74374257727b.1648601710.git.alison.schofield@intel.com>
In-Reply-To: <3d563038e093f435396f58b3757c74374257727b.1648601710.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Mar 2022 20:23:26 -0700
Message-ID: <CAPcyv4hsHx_6Q_gRdm5dH-t5Esv7KB_S3GB_EA9w4_0wa4dAbQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] cxl/mbox: Move cxl_mem_command construction to
 helper funcs
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
> Sanitizing and constructing a cxl_mem_command from a userspace
> command is part of the validation process prior to submitting
> the command to a CXL device. Move this work to helper functions:
> cxl_to_mem_cmd(), cxl_to_mem_cmd_raw().
>
> This declutters cxl_validate_cmd_from_user() in preparation for
> adding new validation steps.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/mbox.c | 155 +++++++++++++++++++++-------------------
>  1 file changed, 80 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index be61a0d8016b..0b5bec7b8b5a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -207,6 +207,81 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>         return true;
>  }
>
> +static int cxl_to_mem_cmd_raw(struct cxl_dev_state *cxlds,
> +                             const struct cxl_send_command *send_cmd,
> +                             struct cxl_mem_command *mem_cmd)

For multi-parameter "to()" style helpers like this with a destination,
I tend to prefer memcpy() style argument ordering where the
destination to be clobbered is the first parameter and the other
arguments tag on afterwards.

Other than that this looks good to me and you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
