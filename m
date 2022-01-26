Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B65FC2BA4C
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 16:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbiAZQRG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 11:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiAZQRD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 11:17:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C648C06161C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 08:17:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h12so151574pjq.3
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9speIaQTCGP3s0a64E+GY3sDlR2buP1pgNXk10VrJ4=;
        b=ldjg/ZRvhzfOem95h4B4LUKM/Y9FqXK6i8rzVXO52S9Nc52TBIJSk/tTwbkAUN1Ah1
         K5b79yJRnq6PeNogYBc4yAsGzxOVy/sxPddjEIS/CPnwd1D/JldR9DqCC1t1n6IYKtGZ
         +gDZmAAVjz23reFUC4OF5UzWgsxpzOPvL/pjuANg9SsA7Xc7KjvrvDvjl0GTzOFQC3QF
         5st6aZONAiT75MqQ0I6kZxZPI/e1yL6xPkFSiBLmuBFWDlXsplmN3/Y2MWlvykgEQWZO
         ba+1urcgh50HRfzWT497T3vuleYt/+d339UuUuzH7H5oNpvHqr+Lwp15u2EsoO3WxPg/
         ixLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9speIaQTCGP3s0a64E+GY3sDlR2buP1pgNXk10VrJ4=;
        b=V1gzKau/+RslwX+47tMBMsgfMuQMvOa30jC8FbZIhTFnDD7m6gBIM0iinA7IQHcxRM
         6d99AlyQjR5qBq9t6/VUCEcPra+htHxLbZ3nW+tmRsUdDSbAt7iic7SsNEiJ7ht33VL7
         lW7uS7vU1rQJw7Dnm9bfE3D9ybEVHgOXMqw502vXKZfPjiE3kU1OmDMYUCVpSAt8yGlA
         Trgpp+usWBZK07ydceiZ8B57EFut2OONN6TiNy1Qvwn/Wy0ITiYmyvKn2g0YqRZsEk9E
         Qqppk7JO0WrDvmPsT3bkvOdmM5TtGZHOiJVDS55pMIIfxdjb4Dt0jo0/VoYjMN7mt4tP
         Tkig==
X-Gm-Message-State: AOAM532e1Fa5E02GHo7zdr9+t/abI31kzrPM+3/yLI9Is2QcwHIjlz1r
        ALS0crGSVwmYdszCfYQpcGTgsmwNcOyYJjj1g6tM9g==
X-Google-Smtp-Source: ABdhPJzJKw9/W8FxpqE1jYmr1fg568gtzdl1WozStzP5if+YmGy3p9it+BwuHdRGAyzjtEqJzJH/FgmZxpm4jer/82k=
X-Received: by 2002:a17:902:d492:b0:14a:f3ce:37a8 with SMTP id
 c18-20020a170902d49200b0014af3ce37a8mr23672825plg.34.1643213822552; Wed, 26
 Jan 2022 08:17:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642535478.git.alison.schofield@intel.com> <55800f227e4d72f90fcdd49affb352fe4386f628.1642535478.git.alison.schofield@intel.com>
In-Reply-To: <55800f227e4d72f90fcdd49affb352fe4386f628.1642535478.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jan 2022 08:16:51 -0800
Message-ID: <CAPcyv4jcu8hbdf6+NYW3za4Q_qW=cMRWPznSyhmwhLwrNpCNXA@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 2/6] libcxl: add accessors for capacity fields of
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

On Tue, Jan 18, 2022 at 12:20 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> Users need access to a few additional fields reported by the IDENTIFY
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
>  cxl/lib/libcxl.c   | 29 +++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  3 +++
>  cxl/libcxl.h       |  3 +++
>  3 files changed, 35 insertions(+)
>
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 58181c0..1fd584a 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1105,6 +1105,35 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
>         return le32_to_cpu(id->lsa_size);
>  }
>
> +#define cmd_identify_get_capacity_field(cmd, field)                    \
> +do {                                                                           \
> +       struct cxl_cmd_identify *c =                                    \
> +               (struct cxl_cmd_identify *)cmd->send_cmd->out.payload;\
> +       int rc = cxl_cmd_validate_status(cmd,                                   \
> +                       CXL_MEM_COMMAND_ID_IDENTIFY);                   \
> +       if (rc)                                                                 \
> +               return ULLONG_MAX;                                                      \
> +       return le64_to_cpu(c->field) * CXL_CAPACITY_MULTIPLIER;                 \
> +} while (0)

This could probably just be 2 functions

cmd_to_identify()
capacity_to_bytes()

...and then the caller does:

return capactity_to_bytes(cmd_to_identify()->field);

...and skip the macro. Otherwise, a macro with a "return" statement
can be unwieldy unless that macro is defining an entire function.
