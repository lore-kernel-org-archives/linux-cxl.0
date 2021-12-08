Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B768C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Dec 2021 05:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhLHFPr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhLHFPr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Dec 2021 00:15:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC00DC061574
        for <linux-cxl@vger.kernel.org>; Tue,  7 Dec 2021 21:12:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so3350232pjb.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Dec 2021 21:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9Sm+CJj+k97c2G0Smxb6+UAPlWADPCiIL9dHkctAHo=;
        b=vaU8gj1feFuClW2Z6UMKFtOCODGZiaYDtUstYrXqS7au42szcbAIi2kyXk5vViHxFa
         RwKG9yEw1e0COtPjeMGZ58HuaRTqLj0GOXE7/q7i9J+NIla5djncLqdGUR/rFuZVuCDO
         JqBAhyV3YZdGDel246lmCZkMX2JpP3VvN+ABtz8+XINAYE8Hk2/jErC4VUEHA8dB5fhG
         ARr6RtX8EeZBEF2miwpZBhZt/3ifm/BBjz+8tdie04Scm8FjxWR1WPUOStFU5uM3V8qo
         /+j+IcQzNED+C6rRJ7K3eJNKJDW+HE/Yp5ZZszmPQYeXzOi1N2+fwjjHQfIh/U1eo05l
         Yw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9Sm+CJj+k97c2G0Smxb6+UAPlWADPCiIL9dHkctAHo=;
        b=kSc8V1g9t9vjsXyMyklddtcBtRVyZf2hD3b7PdA1EZv4EsEquiOW0fQoQjLYASMkcp
         oGw2NiKzR12iY6f7w9H9DQDHtDXfEUIM5dxDBL5xr5PXZdHeDsVyL8347qJyK5TOE4B2
         aQflN9ZfjwpkS5WQ63I+7X5w1zQQ980guu9Lv/80bExKlwy/f20JsumVbIktSUpBU/1X
         TTzGOcM8vwMA/TcCeAbSBKhzGFglFToIIPHrThXCSvGmxNjRLSmxmXx4jhmdRAzKcrKW
         TJ1cyg7uG25exspHjkJs+M6SzEURUXNmUEHW5Qnq0dCfAy8yOyEGyEae2Q85G+XOddCY
         k4MQ==
X-Gm-Message-State: AOAM533TlwDEJOVVYDkIZD1C0Qn4VCzo3/Yw+moCRW0HV5nsC28qbVrl
        cAVm5wd1DuE50oRH5Ju0dYj3TEMBVlrbeySkkVIQuVzXPMc=
X-Google-Smtp-Source: ABdhPJzny71lJbtdinrKM61/8j9NMWVL9fklbA7/j/YKiNIdhokDCNcxS3st0TVnv+CDtswukl5IdQLTi/dOCl1twZ4=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr4424098pjb.93.1638940335434;
 Tue, 07 Dec 2021 21:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20211111204436.1560365-1-vishal.l.verma@intel.com> <20211111204436.1560365-3-vishal.l.verma@intel.com>
In-Reply-To: <20211111204436.1560365-3-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Dec 2021 21:12:04 -0800
Message-ID: <CAPcyv4g=Zc=KizTvVVeyA4gFJi=K8Amuok-kjBM6UqkVZHwd2g@mail.gmail.com>
Subject: Re: [ndctl PATCH v5 02/16] cxl: add a cxl utility and libcxl library
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Nov 11, 2021 at 12:45 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> CXL - or Compute eXpress Link - is a new interconnect that extends PCIe
> to support a wide range of devices, including cache coherent memory
> expanders. As such, these devices can be new sources of 'persistent
> memory', and the 'ndctl' umbrella of tools and libraries needs to be able
> to interact with them.
>
> Add a new utility and library for managing these CXL memory devices. This
> is an initial bring-up for interacting with CXL devices, and only includes
> adding the utility and library infrastructure, parsing device information
> from sysfs for CXL devices, and providing a 'cxl-list' command to
> display this information in JSON formatted output.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
[..]
> +int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
> +{
> +       const struct option options[] = {
> +               OPT_STRING('d', "memdev", &param.memdev, "memory device name",
> +                          "filter by CXL memory device name"),
> +               OPT_BOOLEAN('D', "memdevs", &list.memdevs,
> +                           "include CXL memory device info"),
> +               OPT_BOOLEAN('i', "idle", &list.idle, "include idle devices"),
> +               OPT_BOOLEAN('u', "human", &list.human,
> +                               "use human friendly number formats "),
> +               OPT_END(),
> +       };
> +       const char * const u[] = {
> +               "cxl list [<options>]",
> +               NULL
> +       };
> +       struct json_object *jdevs = NULL;
> +       unsigned long list_flags;
> +       struct cxl_memdev *memdev;
> +       int i;
> +
> +       argc = parse_options(argc, argv, options, u, 0);
> +       for (i = 0; i < argc; i++)
> +               error("unknown parameter \"%s\"\n", argv[i]);
> +
> +       if (argc)
> +               usage_with_options(u, options);
> +
> +       if (num_list_flags() == 0)
> +               list.memdevs = true;

It strikes me that we may regret this default. In the interest of
giving us flexibility to pick a new default later (i.e. to not grow
any maintenance dependencies on this default), let's fail for now if
no list options are specified. I expect "cxl list" to enumerate the
active and most relevant end user devices by default. For ndctl its
namespaces, but for cxl-cli I expect it should be regions by default
to show all the CXL address ranges. Likely it should be "--regions
--namespaces" by default since regions are the primary user relevant
devices for volatile memory and namespaces are the end user relevant
devices for persistent memory, but the "--regions" vs "--regions
--namespaces" decision can be made later.
