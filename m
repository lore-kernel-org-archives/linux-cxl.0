Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D09C2BA4C
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jan 2022 17:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiAZRXg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jan 2022 12:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiAZRXf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jan 2022 12:23:35 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ECFC06161C
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 09:23:35 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k17so255722plk.0
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jan 2022 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4PBcFHpg3X/cUeTjK/pA3owHS0LZpp7nuPsOtsy/uM=;
        b=MRK8LrTkL61/2/BaPTX5UhD5roOEEheTbidBIpfv4xMENDJNSEs0hesn/UJ3IHzbY4
         US8nGBB1iFNZ8REhJxhSATNI7rF8YetikV95cRqRYG+MHUlfnQydcFpf3I9tYWwvlVGz
         kl2IWJSDG4MOFtq8ZzrvI8gRhRAhPMvd/I9Wyb+hFbccm4nfe6Grxy4vIHoDMPuJXAnR
         rK1XqEqP53f4ADfzii+M/cj09FUqrSj5w78JnFFbViY7b8EpiY08ssfOLSqrelY1tY31
         szIWRGcZuJNCzzR4dqmQZdw4t3wWhDyOVx28h+1D0ZhKL4O9FOdLYRd7vatO/O7bFL/o
         EJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4PBcFHpg3X/cUeTjK/pA3owHS0LZpp7nuPsOtsy/uM=;
        b=aStMqw4yPm7KwK/5aI15yV6EVK2Yb/WIyLSn9Z7fKACMptjx0NiJoQIULIAWb9Pnky
         VLWI03L0vNoCYKdIjWkTnDIenD191ZAABXEdalJgeQ4rRsaDW5ClK4LPqHfIQ6mRjgvq
         Zi+Xlrlha6Z04UCjD/ib3qlS6Cxezm7fNYlxTTk52f1CGMYuVbRLZMBxCgN7lFC2+ZAz
         JXkh5n6GmSP13TwClJ0r4GYQYRLZYE0vhgyq4sXpX2KJWJgZ3LsixEKKxXtKYjR8o+5u
         sGaKH8kpdj24Bnjv8I4PsSWvPmUUFRmiC3Zg1mkt2Xy4ztBaH+XHEd62OMzHbb6cb5qq
         0eMQ==
X-Gm-Message-State: AOAM530fBIQcKzvG1JHlf/3I/DWSq7uR5iA1SJ9oy4njmNHMsy54Q9sx
        HE4tu4Y23eREne9ROWMjVg2SigVA0aBKp6xvG1yQQi/Mkfw=
X-Google-Smtp-Source: ABdhPJzi84NoQVPOQ39gCTYeTDT3xvXg4UkMWphQ4maUGvEoxCjmQctUJ0RzLjIpw8cEEpBYUvjZj74lZmHXRgxoKp8=
X-Received: by 2002:a17:902:ce8d:b0:14b:4bc6:e81 with SMTP id
 f13-20020a170902ce8d00b0014b4bc60e81mr14896398plg.132.1643217815141; Wed, 26
 Jan 2022 09:23:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642535478.git.alison.schofield@intel.com> <5c20a16be96fb402b792b0b23cc1373651cef111.1642535478.git.alison.schofield@intel.com>
In-Reply-To: <5c20a16be96fb402b792b0b23cc1373651cef111.1642535478.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jan 2022 09:23:23 -0800
Message-ID: <CAPcyv4g3s=4AV+B3EHgANHXedrvOeY8vasE7uR5vznUX5BX24w@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 4/6] cxl: add memdev partition information to cxl-list
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
> Users may want to check the partition information of a memory device
> using the CXL command line tool. This is useful for understanding the
> active, as well as creating the next, partition layout.
>
> Add an option the 'cxl list' command to display partition information.
> Include all of the fields from GET_PARTITION_INFO and the partitioning
> related fields from the IDENTIFY mailbox command.
>
> Example:
>     "partition_info":{
>       "active_volatile_bytes":273535729664,
>       "active_persistent_bytes":0,
>       "next_volatile_bytes":0,
>       "next_persistent_bytes":0,
>       "total_bytes":273535729664,
>       "volatile_only_bytes":0,
>       "persistent_only_bytes":0,
>       "partition_alignment_bytes":268435456
>     }
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/cxl/cxl-list.txt |  23 +++++++
>  cxl/json.c                     | 114 +++++++++++++++++++++++++++++++++
>  cxl/list.c                     |   5 ++
>  util/json.h                    |   1 +
>  4 files changed, 143 insertions(+)
>
> diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> index c8d10fb..912ac11 100644
> --- a/Documentation/cxl/cxl-list.txt
> +++ b/Documentation/cxl/cxl-list.txt
> @@ -85,6 +85,29 @@ OPTIONS
>    }
>  ]
>  ----
> +-I::
> +--partition::
> +       Include partition information in the memdev listing. Example listing:
> +----
> +# cxl list -m mem0 -I
> +[
> +  {
> +    "memdev":"mem0",
> +    "pmem_size":0,
> +    "ram_size":273535729664,
> +    "partition_info":{
> +      "active_volatile_bytes":273535729664,
> +      "active_persistent_bytes":0,
> +      "next_volatile_bytes":0,
> +      "next_persistent_bytes":0,
> +      "total_bytes":273535729664,
> +      "volatile_only_bytes":0,
> +      "persistent_only_bytes":0,
> +      "partition_alignment_bytes":268435456

I think it's confusing to include "_bytes" in the json listing as it's
not used in any of the other byte oriented output fields across 'cxl
list' and 'ndctl list'. "_size" would match similar fields in other
json objects.

Other than that,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
