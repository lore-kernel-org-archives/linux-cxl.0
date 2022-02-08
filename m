Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594CFC43219
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387601AbiBHWZo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386442AbiBHUef (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Feb 2022 15:34:35 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66F3C0612C1
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 12:34:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y5so492908pfe.4
        for <linux-cxl@vger.kernel.org>; Tue, 08 Feb 2022 12:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXOr74ZqxDbW2NHi8mT1BWeZ44BcpKSk2J1e3DuFzZ4=;
        b=AXaCk3sp+x06s/HtFgY8v5DpUjMNsvko9jEBwdAvKBBd0qN1IFbJU+MzgFdwdggwdk
         gYpVS5CiGAcQROCTr9WPYJ1IJTT0Z8VxC/yC0QXR61VFjwvREM/ibPlFtUE5ukCTFzON
         4aMK4HYDVMnLi4Ym8CDj/Ozet+noj61YbYkKQlBfC6r9ER1n9CLuC7EXqqlg2mcPFRN0
         ZgFAfwTKpoWBkDMy8R4KaswPAEGKZXsWBmU/wl6S4Odgi3iM9TKW59a2Wjes0YjoPAfp
         lVGY0t7KFMRcTRW6hRwwpcDTZGU+ZXZ1qenoV7rG53fV61itt2Z+/e/3hwFxBjSDh2cB
         YR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXOr74ZqxDbW2NHi8mT1BWeZ44BcpKSk2J1e3DuFzZ4=;
        b=QdVRSunTO6bPJqVSV04U/nWg84Jk/Dx5Gyec3aWhaHrpfiiTBVFKP8nfi6FPA7Wo22
         MkVaT+AuLIxsPGHyZ16W6sBs48zO0pEUs+fY8QyIV0wXCvhW4p6Cr+kF4buT1oEfOeyG
         /kY02ob+NOgt8gbRNOat6VvFIMcBtsrht/WQcUms9YxSsX/s/K/1amAf5k0mX/Vxc/Hk
         iVdVCN6JQ2hxUmuPbqw48oNwZUORn2gRSr53QHV3/xutDcL4y3gYEEMijxMah5/oNgHF
         R1cSO7HM9HBX13wc35C9aujSmbXUMuTjHxQstzsustHw6fK/B85FkrRRdXqIQIyoblFz
         sInQ==
X-Gm-Message-State: AOAM5324YGnSopGCbbaHJyEfUulisa8CPpH609JsghoNpsot60Sq4O+N
        P/fj7gE4dJOSW5usTnM/D4TB/exh9lcvVNphKoUrUQ==
X-Google-Smtp-Source: ABdhPJw5zlCGQ2nGF2qvA47+wUptq6SIuYOpA4S1R/pn67LuSNBMzaR5jgmoWVKQ2nMoG7BOYXz1SpO9PH5AG0fEdl4=
X-Received: by 2002:a63:4717:: with SMTP id u23mr4989089pga.74.1644352474249;
 Tue, 08 Feb 2022 12:34:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644271559.git.alison.schofield@intel.com> <034755a71999a66da79356ec7efbabeaa4eacd88.1644271559.git.alison.schofield@intel.com>
In-Reply-To: <034755a71999a66da79356ec7efbabeaa4eacd88.1644271559.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Feb 2022 12:34:23 -0800
Message-ID: <CAPcyv4juShujHXrh5ZB7d2sVtE4+sn6idi-KCbKZ=4pwz6jxpg@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 2/6] libcxl: add accessors for capacity fields of
 the IDENTIFY command
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

On Mon, Feb 7, 2022 at 3:06 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Users need access to a few additional fields reported by the IDENTIFY

Ah, I see the "Users need" pattern... To me, the "Users need"
statement is a step removed / secondary from the real driving
motivation which is the "CXL PMEM provisioning model specifies /
mandates".

It feels like a watered down abstraction to me.

> mailbox command: total, volatile_only, and persistent_only capacities.
> These values are useful when defining partition layouts.
>
> Add accessors to the libcxl API to retrieve these values from the
> IDENTIFY command.
>
> The fields are specified in multiples of 256MB per the CXL 2.0 spec.
> Use the capacity multiplier to convert the raw data into bytes for user
> consumption.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  cxl/lib/libcxl.c   | 36 ++++++++++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  3 +++
>  cxl/libcxl.h       |  3 +++
>  3 files changed, 42 insertions(+)
>
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 33cf06b..e9d7762 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -2322,6 +2322,42 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
>         return le32_to_cpu(id->lsa_size);
>  }
>
> +static struct cxl_cmd_identify *
> +cmd_to_identify(struct cxl_cmd *cmd)
> +{
> +       if (cxl_cmd_validate_status(cmd, CXL_MEM_COMMAND_ID_IDENTIFY))
> +               return NULL;
> +
> +       return cmd->output_payload;
> +}
> +
> +CXL_EXPORT unsigned long long
> +cxl_cmd_identify_get_total_size(struct cxl_cmd *cmd)
> +{
> +       struct cxl_cmd_identify *c;
> +
> +       c = cmd_to_identify(cmd);
> +       return c ? capacity_to_bytes(c->total_capacity) : ULLONG_MAX;
> +}
> +
> +CXL_EXPORT unsigned long long
> +cxl_cmd_identify_get_volatile_only_size(struct cxl_cmd *cmd)
> +{
> +       struct cxl_cmd_identify *c;
> +
> +       c = cmd_to_identify(cmd);
> +       return c ? capacity_to_bytes(c->volatile_capacity) : ULLONG_MAX;
> +}
> +
> +CXL_EXPORT unsigned long long
> +cxl_cmd_identify_get_persistent_only_size(struct cxl_cmd *cmd)
> +{
> +       struct cxl_cmd_identify *c;
> +
> +       c = cmd_to_identify(cmd);
> +       return c ? capacity_to_bytes(c->persistent_capacity) : ULLONG_MAX;

Same style comments as last patch, but otherwise:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
