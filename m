Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554F4C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Jan 2022 19:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiADTCb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiADTCa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 4 Jan 2022 14:02:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C75C061761
        for <linux-cxl@vger.kernel.org>; Tue,  4 Jan 2022 11:02:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lr15-20020a17090b4b8f00b001b19671cbebso4113759pjb.1
        for <linux-cxl@vger.kernel.org>; Tue, 04 Jan 2022 11:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqTqyS3o10BccwqfHeCaswJB157cqaqD7cA9CAAGo4s=;
        b=8QrlDQCNDd/e9v5AEepy3Cn+x9PoB5dft3dHGOBEE92E/TROXpWYwTLNyCdSwUibSR
         jEJdkkc0qLAxw7+DIU7wiXCkj5F/81d67IBLmZVOptzIlCYVJqiVr5wQ3MIfA0WaUnnD
         vYu/dzVdZy1gahCWxQAn4BYzM/vLo+PwkVrJcl3nTbimKvEo7DXTSiIeuawb9CN0cTjN
         eTlW/6AMcGS8YoxhTVh114wI7t7DBaW2JOCIFFM06EmJ4NyOJNBpX6PKElYbrisjFJms
         AnDl+2rQtGYfKDqGe0YfDyITaNK+rzbR3g63i7nH8nISGkiaz1AqSmfvRfdIWkvekPmJ
         kA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqTqyS3o10BccwqfHeCaswJB157cqaqD7cA9CAAGo4s=;
        b=u89pcmu8+R92MWSMv1oZdwRyEwqrhevJ2KpQwO8Y3xncTJGw+tm8izDlp0mV6wYJ+H
         jVLFjHNPCGRqdy2/Q1j2n76PSi/mUSrTITSWd76CFOP/22WrmfLmGAiQb0SZBEyxu8xR
         jZL0jYdLLCJev90gpmy+OF5+RAY64yq9jSbaMftdE81hi2R2q+PMjXFQskxLZQchCs5c
         3aXWmhZoOm2SCGxLVhqbKxmoIqtw0PAVTzkl59S3PNys7L9oBV3V/+F8uU/RjV3oRIAZ
         DyQAMU00u10XIIZHnC1IpvWXVaWJCx0JPhvtmfYZcOzhlkf6QC3/D6HxnnJbgWYEYahE
         3djA==
X-Gm-Message-State: AOAM532jZxQr5g220i7rUL6AuC4u9p/R6n1siAXq734eF+xCYiv7zsFG
        FRDiS24D18ByFy3Bj5iznO4DpTjWk36kGWd0pAGBxQ==
X-Google-Smtp-Source: ABdhPJyDFaJ4hR0ll6kKhn5RXiHNdYXKgw1bdd5iMkZEuCgbnCirIw04S6xHXEn8x6OBV1I1NGQUGauslM7G9qRtpvk=
X-Received: by 2002:a17:90a:e7cb:: with SMTP id kb11mr56970972pjb.8.1641322950066;
 Tue, 04 Jan 2022 11:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20220103202100.784194-1-alison.schofield@intel.com>
In-Reply-To: <20220103202100.784194-1-alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Jan 2022 11:02:19 -0800
Message-ID: <CAPcyv4j0wqvX82wPxgvLLu7DcSu4TRs5RE-jXg_YXz=y_7ucrQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/mbox: Do not allow immediate mode in SET_PARTITION_INFO
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 3, 2022 at 12:15 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> User space may send the SET_PARTITION_INFO mailbox command using
> the IOCTL interface. Inspect the input payload and fail if the
> immediate flag is set.
>
> This is the first instance of the driver inspecting an input payload
> from user space. Assume there will be more such cases and implement
> with an extensible helper.
>
> Note: At this time immediate partitioning is not allowed because the
> kernel will need to react immediately to this configuration change
> and that support is not yet implemented.

I would say:

In order for the kernel to react to an immediate partition change it
needs to assert that the change will not affect any active decode. At
a minimum this requires validating that the device is using HDM
decoders instead of the CXL DVSEC for decode, and that none of the
active HDM decoders are affected by the partition change. For now,
just fail until that support arrives.

>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 43 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    |  7 +++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index be61a0d8016b..2cf5ccdea7df 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -352,6 +352,41 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>         return 0;
>  }
>
> +/**
> + * cxl_payload_from_user_allowed() - Check contents of in_payload.
> + * @opcode: The mailbox command opcode.
> + * @payload_in: Pointer to the input payload passed in from user space.
> + *
> + * Return:
> + *  * true     - payload_in passes check for @opcode.
> + *  * false    - payload_in contains invalid or unsupported values.
> + *
> + * The driver may inspect payload contents before sending a mailbox
> + * command from user space to the device. The intent is to reject
> + * commands with input payloads that are known to be unsafe. This
> + * check is not intended to replace the users careful selection of
> + * mailbox command parameters and makes no guarantee that the user
> + * command will succeed, nor that it is appropriate.
> + *
> + * The specific checks are determined by the opcode.
> + */
> +static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
> +{
> +       switch (opcode) {
> +       case CXL_MBOX_OP_SET_PARTITION_INFO: {
> +               struct cxl_mbox_set_partition_info *pi;
> +
> +               pi = (struct cxl_mbox_set_partition_info *)payload_in;

No need for a cast since @payload_in is a 'void *'

> +               if (pi->flags && CXL_SET_PARTITION_IMMEDIATE_FLAG)
> +                       return false;
> +               break;
> +       }
> +       default:
> +               break;
> +       }
> +       return true;
> +}
> +
>  /**
>   * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
>   * @cxlds: The device data for the operation
> @@ -405,6 +440,14 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>                 }
>         }
>
> +       if (!cxl_payload_from_user_allowed(mbox_cmd.opcode,
> +                                          mbox_cmd.payload_in)) {
> +               dev_dbg(dev, "%s: input payload not allowed\n",
> +                       cxl_command_names[cmd->info.id].name);
> +               rc = -EINVAL;
> +               goto out;
> +       }
> +
>         dev_dbg(dev,
>                 "Submitting %s command for user\n"
>                 "\topcode: %x\n"
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8d96d009ad90..e10b86f06c75 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -231,6 +231,13 @@ struct cxl_mbox_set_lsa {
>         u8 data[];
>  } __packed;
>
> +struct cxl_mbox_set_partition_info {
> +       u64 volatile_capacity;

This should be __le64, and it looks like 'struct cxl_mbox_get_lsa' and
'struct cxl_mbox_set_lsa' need similar fixups.

> +       u8 flags;
> +} __packed;
> +
> +#define  CXL_SET_PARTITION_IMMEDIATE_FLAG      BIT(0)
> +
>  /**
>   * struct cxl_mem_command - Driver representation of a memory device command
>   * @info: Command information as it exists for the UAPI
>
> base-commit: 53989fad1286e652ea3655ae3367ba698da8d2ff
> --
> 2.31.1
>
