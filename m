Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C864C4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Jul 2021 22:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381F96103A
	for <linux-cxl@archiver.kernel.org>; Wed, 28 Jul 2021 22:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhG1WOz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 28 Jul 2021 18:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhG1WOz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 28 Jul 2021 18:14:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76568C061757
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jul 2021 15:14:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso6237445pjo.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jul 2021 15:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6BOhtA7FLyyb1NSaSw3kCP9ikMguWQZgr72raIZky00=;
        b=J9/q2wfuBZppTft6yABy7fnpEiMCf1wpnADO+16CSo3Itkzam3AlFYUe7/nwpMRU8B
         w8+HcxR5h8qvzskOpccRZrPcPGna6R4EZA7t5RooQ8yzo2F2qoPbvdPWyshXG1Vxk3GM
         930op+n51SFXgxRogMe8hZAfwinYN2YvTOGIFs+AdAr/Aa5N8Skkp7Qk2B4apiKowvPq
         1BNSbsHgZ/PRmOpRtxu1uLTxhYGDM9A8NDhk0o2spIh/sL8n+nWERxztiIMS+w400/1s
         wg0FdcO4Q7PHNWo25LMzMMvm7JU6IiV5pzB16m4r+7R7JeSYUGoduP27SLka6Y5XmPYw
         j+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6BOhtA7FLyyb1NSaSw3kCP9ikMguWQZgr72raIZky00=;
        b=pXPM+HgqCjOruVr3VBSKT+P6O95ALq6/cEEd3ZAgdH313likwuq0ByXCG+fiUFbVCO
         tEHQwtd0boWbKaNpguLOm180khQSL8cm9I7IWHAa+E3K87TlKjwd4oXfLhOkKd+J+3e4
         svkj3Ah1n7LGO+UHjEnnuTH7LCygoE8F3dQGpj/Anaovkn4SbLlx1XbUR8Wxr06R32kp
         oWnW2HSD+q9AaNWS2+s8YtrBaQjCdxetMC8hLEiZ/PdvUJBcxiuaipbFRE1xHE7VThSJ
         i8YGNNbAiCqG8+hTuRZQ+jS+CqeG1OnT4HgNTZPX+hY+4RyoZUDHYvrpjFdSz4UgqE4j
         Vn+A==
X-Gm-Message-State: AOAM532M7An12PtHE6MoqlAMZ+jcDL8AsoitEKf0xfFejJgt5H6FuoAA
        s9wtf5LEtuqD+zjdFNpkSLyB/ydMN0sq06CekdC5WA==
X-Google-Smtp-Source: ABdhPJxxxc3vorQJk4c5K3UUr2DEVXIfcQHNPiLZU0ZrQpNo443qq1A5T2TL1x1EjxpNOqN1ZdvRZGuGosRFYA1UgzU=
X-Received: by 2002:a65:5544:: with SMTP id t4mr988089pgr.240.1627510493008;
 Wed, 28 Jul 2021 15:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210715194125.898305-1-ben.widawsky@intel.com> <20210715194125.898305-4-ben.widawsky@intel.com>
In-Reply-To: <20210715194125.898305-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 28 Jul 2021 15:14:42 -0700
Message-ID: <CAPcyv4jeVsEOf8tohuKm62Uh0_esN5KAc2yVrdkL263qBXeV7Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] cxl/core: Extract register and pmem functionality
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In general "and" in the patch title is a red flag that the patch can
be split. I'll go ahead and do that when folding in the collision
fixes.

On Thu, Jul 15, 2021 at 12:41 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Register mapping and pmem/nvdimm integration are distinct enough from
> basic CXL bus functionality that it warrants being moved out of bus.c
> Additionally, this aims to modularize for the sake of reducing the size
> of bus.c
>
> pmem and register programming have very clear separation and are done
> together for that reason. Other parts of core, like ports and decoders
> should be pulled out as well, but those are more integrated with core
> and therefore saved for later.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  .../driver-api/cxl/memory-devices.rst         |   6 +
>  drivers/cxl/Makefile                          |   2 +-
>  drivers/cxl/core/bus.c                        | 435 +-----------------
>  drivers/cxl/core/core.h                       |  20 +
>  drivers/cxl/core/pmem.c                       | 201 ++++++++
>  drivers/cxl/core/regs.c                       | 235 ++++++++++
>  6 files changed, 466 insertions(+), 433 deletions(-)
>  create mode 100644 drivers/cxl/core/core.h
>  create mode 100644 drivers/cxl/core/pmem.c
>  create mode 100644 drivers/cxl/core/regs.c
>
[..]
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> new file mode 100644
> index 000000000000..74011c40801d
> --- /dev/null
> +++ b/drivers/cxl/core/core.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. */
> +
> +#ifndef __CXL_CORE_H__
> +#define __CXL_CORE_H__
> +
> +#include "../cxl.h"
> +#include "../mem.h"

This results in unnecessary includes. Each compilation unit should
only include the headers it absolutely needs. In this case, making
each compilation unit responsible for its own includes means that
bus.c does not need mem.h, and regs.c does not need either cxl.h or
core.h
