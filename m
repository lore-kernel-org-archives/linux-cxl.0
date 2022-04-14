Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA4C43217
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Apr 2022 17:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244196AbiDNRK3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346108AbiDNRJ3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Apr 2022 13:09:29 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9B6205E3
        for <linux-cxl@vger.kernel.org>; Thu, 14 Apr 2022 09:58:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 12so5118434pll.12
        for <linux-cxl@vger.kernel.org>; Thu, 14 Apr 2022 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPZr0zGQxINLzBPUzdpRKSuozUwt+nuTN3zQvazzYbo=;
        b=eGTR6ngTL2wCPLZvJneqm0LHHnleZ6FDKuc/9Q5G+D6vCkXNYr1eL2/fUgKh6TA5s1
         /Q6/b46IDx7bCYKHxNK10+lo7+AslhirJyfGoBuJg7Dk9lUGB0jCLBogBuBJOJp4h50t
         iWIcZeuDmgYn7LJI09BxkxgecLHp1Ty7GqHtsy+MiwTOTllSaIbIwl7RC+nSNusyRVWR
         1sVMvDZbtksm6K2aQ0m42xchXnWZ3oChwqgrS19CE5yKZloyuliMxQ42KE5wUHjCuhCq
         XmhHk68W+rluBZFWeoDO314EOQhpj37Z6CboaQ908E+xlIIEfHaztbf+yv6pPqmQ+eJP
         VZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPZr0zGQxINLzBPUzdpRKSuozUwt+nuTN3zQvazzYbo=;
        b=nD+P9FAYg3HiXlQ3+d+Q5i/pfn2Mxk7aknNy5WrOkVzf+sTWJ0tfIXTfzGC3A8OGiV
         y5xV1bDeIeUWBH+YWuA9HnreGJqZPm3qoIRVy2Gl80jb55eApE3MAdl5c0KWqBDVC+6Y
         cea3ZIPr061SqopVbyycUWGQJhkQXzxgr1bGH4nYHiIyqBylnEECuYwaOydLYVtjlQfH
         cVm2dN1GMbEQ5T7rmdhW/jiSXXXghPTMYGA/ydnptPEJsamldL3SZQU7XPkIYFeAefPx
         2tNtTnKNP3wgUABibRdiSdrwU2DRITy+CtX2GxvVGzS9iPLMycIXzT51j6h3AokjpdZB
         Q3PQ==
X-Gm-Message-State: AOAM531eI0KRJCyZy1JWIbtMIGA6IgFQaAC33yE6QnpcxLdxl7faNt9S
        /MPVnzs4g0m97EOXXBmtNFbzmAGvKjitohnTHnEHmg==
X-Google-Smtp-Source: ABdhPJyduPzJVnNpUDzbIkNsTy/TW8LHrkZDDSUTa0ZNucnNJlLyYBxn3JVjU9r/DosN+WyfXqvThW4zoxnfJU5BmHU=
X-Received: by 2002:a17:90b:1804:b0:1cb:82e3:5cd0 with SMTP id
 lw4-20020a17090b180400b001cb82e35cd0mr5353309pjb.8.1649955538169; Thu, 14 Apr
 2022 09:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220414051246.1244575-1-alison.schofield@intel.com>
In-Reply-To: <20220414051246.1244575-1-alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Apr 2022 09:58:46 -0700
Message-ID: <CAPcyv4ifF-SwCDugZ32ACQk4rwoPErirJE6HUo0CSEjsrnrJGg@mail.gmail.com>
Subject: Re: [PATCH v3] cxl/mbox: Use type __u32 for mailbox payload sizes
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Apr 13, 2022 at 10:11 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Payload sizes for mailbox commands are expected to be positive values
> coming from userspace. The documentation correctly describes these as
> always unsigned values. The mailbox and send structures that support
> the mailbox commands however, use __s32 types for the payloads.
>
> Replace  __s32 with __u32 in the mailbox and send command structures
> and update usages.
>
> Kernel users of the interface already block all negative values and
> there is no known ability for userspace to have grown a dependency on
> submitting negative values to the kernel. The known user of the IOCTL,
> the CXL command line interface (cxl-cli) already enforces positive
> size values.
>
> A Smatch warning of a signedness uncovered this issue.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>
> Changes in v3:
> - Toss v2 changes addressing signedness
> - Replace __s32 with __u32 in mbox and send command structures (Ben)
> - Update commit message and log
>   Was 'Restore signedness to a mailbox payload variable'
>
> Changes in v2:
> - Pass the payload sizes as signed rather than move the check (Dan)
> - Signedness is now discarded on ssize_t to size_t assignment.
> - Update commit msg. Was 'Handle variable size output while still
>   signed'
> - Update commit log.
>
>  drivers/cxl/core/mbox.c      | 28 +++++++++++++++-------------
>  include/uapi/linux/cxl_mem.h | 14 +++++++-------
>  2 files changed, 22 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8a8388599a85..d54a6d175fff 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -35,6 +35,7 @@ static bool cxl_raw_allow_all;
>         .flags = _flags,                                                       \
>         }
>
> +#define CXL_VARIABLE_PAYLOAD   ~0U
>  /*
>   * This table defines the supported mailbox commands for the driver. This table
>   * is made up of a UAPI structure. Non-negative values as parameters in the
> @@ -44,26 +45,26 @@ static bool cxl_raw_allow_all;
>  static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>         CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
>  #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
> -       CXL_CMD(RAW, ~0, ~0, 0),
> +       CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
>  #endif
> -       CXL_CMD(GET_SUPPORTED_LOGS, 0, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
> +       CXL_CMD(GET_SUPPORTED_LOGS, 0, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
>         CXL_CMD(GET_FW_INFO, 0, 0x50, 0),
>         CXL_CMD(GET_PARTITION_INFO, 0, 0x20, 0),
> -       CXL_CMD(GET_LSA, 0x8, ~0, 0),
> +       CXL_CMD(GET_LSA, 0x8, CXL_VARIABLE_PAYLOAD, 0),
>         CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
> -       CXL_CMD(GET_LOG, 0x18, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
> +       CXL_CMD(GET_LOG, 0x18, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
>         CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
> -       CXL_CMD(SET_LSA, ~0, 0, 0),
> +       CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
>         CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
>         CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
>         CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>         CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> -       CXL_CMD(GET_POISON, 0x10, ~0, 0),
> +       CXL_CMD(GET_POISON, 0x10, CXL_VARIABLE_PAYLOAD, 0),
>         CXL_CMD(INJECT_POISON, 0x8, 0, 0),
>         CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
>         CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>         CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> -       CXL_CMD(GET_SCAN_MEDIA, 0, ~0, 0),
> +       CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
>  };
>
>  /*
> @@ -187,9 +188,10 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
>          * Variable sized commands can't be validated and so it's up to the
>          * caller to do that if they wish.
>          */
> -       if (cmd->info.size_out >= 0 && mbox_cmd.size_out != out_size)
> -               return -EIO;
> -
> +       if (cmd->info.size_out != CXL_VARIABLE_PAYLOAD) {
> +               if (mbox_cmd.size_out != out_size)

I'd prefer && here, but not enough to ask for the patch to be re-sent.

I'll pull this into the pending branch.
