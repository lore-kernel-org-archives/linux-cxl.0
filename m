Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F54C07E95
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jul 2021 05:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE30611F1
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jul 2021 05:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhGMFPt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jul 2021 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhGMFPt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jul 2021 01:15:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63B1C0613DD
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jul 2021 22:12:59 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id a2so20578402pgi.6
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jul 2021 22:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj/ubujvDJn+tlwsupDed8IcALbOcjCactAn0/S6HQw=;
        b=rBY1rKgkJTN61vby7Hleb1gyZwgstf4gOxOpA1KBlIBR9/BpaI9/XD+P3aS9Dz7cO3
         cyhH5setx+QASoO5+FgYuYAXbq+kgwQGoTCdrgbSL447RhanB9sKMDoomFkw+UP05a+K
         /Mmap6TN60uUVna1UQwN2WJrDAGQCfkFsS9FVLJWRgxav1inb+I3Rrta3jMS6evT1fqs
         Dwpv5KrZVJqtl39QSaOnb1QS0kqkRuE997CmycXlhmQIAPD0FeZslweOxnz5H6/gi9mg
         1o76YYw0oWcyAy9kJXVv6FAfZ3GMQWK+HBPepyKGP1jOsj9ATjC6qlWfiiG1GOx76yps
         9J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj/ubujvDJn+tlwsupDed8IcALbOcjCactAn0/S6HQw=;
        b=arpxujnHH1HmeH+BVlSA4w01T2MC/vSAPh5HA/JPwbXrK0mOx+I2yPJDs2dpcsu1ZE
         q4utQw3+DgawcAF/tz0BekXSM0TAIXQweZ5InoSt1vQr2fvzMg3r+MBwpFlicdTDe21I
         llT2HRn7+zq4c9ctIC0tjvqMu0+ft/cPpUV/NeDxQoJmXmE6bfZan4yi8pLRWc7ghgQQ
         PgA65KeQH7bEXR925bEHUQvDoriUMv8yliYGeFckxOQWjyHvqvD89I59W4i/GcGXW+vK
         EPIgn9o53YeM3Rf/c0sfMNR1AeX9QQtQDvmjrmwfMZ9WFvS4a8JmUU5DXeGJnsaElGvS
         C8Ew==
X-Gm-Message-State: AOAM530V04jfmLtv3/cTfNZ6uGbBQNBFApYNF5zIKvkFIWM0dcww8krn
        pExZKUqnfQYOb1YDVhSz6BtKFfnKEZXS4DlGlTr3aw==
X-Google-Smtp-Source: ABdhPJxX8eF3A/XjpEyHN+TQuxLtQREUcUheHvloxBERshoIfVg+WjDlruFgnnquRDU0yc0o3wACzXPs5ewwimTGD/k=
X-Received: by 2002:a05:6a00:d53:b029:32a:2db6:1be3 with SMTP id
 n19-20020a056a000d53b029032a2db61be3mr2602575pfv.71.1626153179012; Mon, 12
 Jul 2021 22:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210701201005.3065299-1-vishal.l.verma@intel.com> <20210701201005.3065299-5-vishal.l.verma@intel.com>
In-Reply-To: <20210701201005.3065299-5-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 12 Jul 2021 22:12:48 -0700
Message-ID: <CAPcyv4iyhpSYkDKYDjWP61PaahtZrn3pGh7NnfC6jDaNbVEu+w@mail.gmail.com>
Subject: Re: [ndctl PATCH v3 04/21] libcxl: add support for command query and submission
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 1, 2021 at 1:10 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a set of APIs around 'cxl_cmd' for querying the kernel for supported
> commands, allocating and validating command structures against the
> supported set, and submitting the commands.
>
> 'Query Commands' and 'Send Command' are implemented as IOCTLs in the
> kernel. 'Query Commands' returns information about each supported
> command, such as flags governing its use, or input and output payload
> sizes. This information is used to validate command support, as well as
> set up input and output buffers for command submission.

It strikes me after reading the above that it would be useful to have
a cxl list option that enumerates the command support on a given
memdev. Basically a "query-to-json" helper.

>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  cxl/lib/private.h  |  33 ++++
>  cxl/lib/libcxl.c   | 388 +++++++++++++++++++++++++++++++++++++++++++++
>  cxl/libcxl.h       |  11 ++
>  cxl/lib/libcxl.sym |  13 ++
>  4 files changed, 445 insertions(+)
>
[..]
> +static int cxl_cmd_alloc_query(struct cxl_cmd *cmd, int num_cmds)
> +{
> +       size_t size;
> +
> +       if (!cmd)
> +               return -EINVAL;
> +
> +       if (cmd->query_cmd != NULL)
> +               free(cmd->query_cmd);
> +
> +       size = sizeof(struct cxl_mem_query_commands) +
> +                       (num_cmds * sizeof(struct cxl_command_info));

This is asking for the kernel's include/linux/overflow.h to be
imported into ndctl so that struct_size() could be used here. The file
is MIT licensed, just the small matter of factoring out only the MIT
licensed bits.

Other than that, looks good to me.
