Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE459C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Feb 2022 17:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384210AbiBHRYI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Feb 2022 12:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242427AbiBHRYH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Feb 2022 12:24:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF439C061578
        for <linux-cxl@vger.kernel.org>; Tue,  8 Feb 2022 09:24:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so2618611pjl.2
        for <linux-cxl@vger.kernel.org>; Tue, 08 Feb 2022 09:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Zobgm4ejvL5X2vx+Elp6qNaHl9oJb7aoU35nvjKyGQ=;
        b=y4qatfiS/FKo2LdP1XOBtuht8pzirkur85QRF+GXQyGL8zKYDMIkEoXPEsigzyYl1e
         qlxCJ0LnzQbRGnt+i7DNpvqwQLDfGyKq9FEwMIh1Tlpg+RBarmPwU2GiWcKOghdkFL/2
         xZbBgInBH3ctPc2yWHvXFE36j7cUi9N9dtUwMitNil8BnYTZEL/nzBRCOgqvdFkyaREC
         TRfT4GCwElSO9lfhCok1GPZ5i1+wbP3glV6NNN7E/mh0d866mGAuCpD6d0GltpGXQzM5
         qz3PPUTdmCpEiQdv2bRt0n5s9qzshAZsxcQJ5pg8NP7CEsmP5d7FVrykSnPYZq5bqTlq
         7ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Zobgm4ejvL5X2vx+Elp6qNaHl9oJb7aoU35nvjKyGQ=;
        b=uiZoly6kMD0HpuPuphVeKIJJNOG3AZl1YiVQz2Qq0lMG8udmkXL0HRjzClikSd5dtm
         OjUi14B3BCg9uS+m5qZSzD0lcLMWC7e1oYj4jnTsnfOgHfbK6yLAgvVcaBR5WlRHljL8
         T+29o49Sb3T1mknuoW08eC/DYn+XHRWmSb9dsIOLrrrJiGu9HJnGWO04znYG0tKVft1/
         ZmSY08KlBaEBKHF4IUPhqLgJzjnm0Ia/EkldgB2lhlcPRrWE2HMFEvoZuhcKECmi1Fdy
         rPkesKbSW9Cc0Y4d/AivRVN2HKBdXVV7gSUMB7hL5QBBDrgaMdf79BaWJSEr4qiRnJVg
         eJgQ==
X-Gm-Message-State: AOAM5333SttQuzpAyXRDv0ukAJiDsFqHoDIGYu18Hn6KmgPlxujrazhR
        6vltaxTHAGWiN+pEkZnK1mNp1ukbBsqpNKtGWZ+Hjg==
X-Google-Smtp-Source: ABdhPJwN74bjPb9AvY4ea3Oww3kvLaaAfLchzvMDsUNhjgjXw2UHWo7j0IbbW5Pj+Xtjy/LIXm+JxDyv0vUgDqyiQpQ=
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr5336931pls.147.1644341045290;
 Tue, 08 Feb 2022 09:24:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644271559.git.alison.schofield@intel.com>
In-Reply-To: <cover.1644271559.git.alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Feb 2022 09:23:54 -0800
Message-ID: <CAPcyv4ge-QF008ATyPhCzx51aWaqwBRue4gAgV81=BnxzJT_FQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 0/6] Add partitioning support for CXL memdevs
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
> Users may want to view and change partition layouts of CXL memory
> devices that support partitioning. Provide userspace access to
> the device partitioning capabilities as defined in the CXL 2.0
> specification.

This is minor feedback if these end up being re-spun, but "Users may
want..." is too passive for what this is, which is a critical building
block in the provisioning model for PMEM over CXL. So, consider
rewriting in active voice, and avoid underselling the importance of
this capability.

> The first 4 patches add accessors for all the information needed
> to formulate a new partition layout. This info is accessible via
> the libcxl API and a new option in the cxl list command:
>
>     "partition_info":{
>       "active_volatile_bytes":273535729664,
>       "active_persistent_bytes":0,
>       "next_volatile_bytes":268435456,
>       "next_persistent_bytes":273267294208,
>       "total_bytes":273535729664,
>       "volatile_only_bytes":0,
>       "persistent_only_bytes":0,
>       "partition_alignment_bytes":268435456
>     }

Is this stale? I.e. we discussed aligning the names to other
'size'-like values in 'ndctl list' and 'cxl list'.

>
> Patch 5 introduces the libcxl interfaces for the SET_PARTITION_INFO
> mailbox command and Patch 6 adds the new CXL command:
>
> Synopsis:
> cxl set-partition <mem0> [<mem1>..<memN>] [<options>]
>
> -t, --type=<type>       'pmem' or 'volatile' (Default: 'pmem')
> -s, --size=<size>       size in bytes (Default: all partitionable capacity)

Spell-check does not like "partitionable"

s/partitionable/available/

> -a, --align             allow alignment correction

How about:

"Auto-align --size per device's requirement."

> -v, --verbose           turn on debug
>
> The CXL command does not offer the IMMEDIATE mode option defined

s/CXL/'cxl set-parition'/

This is a general problem caused by the tool 'cxl' being the same name
as the specification CXL. When it is ambiguous, go ahead and spell out
'cxl <command>'.

> in the CXL 2.0 spec because the CXL kernel driver does not support
> immediate mode yet. Since userspace could use the libcxl API to
> send a SET_PARTITION_INFO mailbox command with immediate mode
> selected, a kernel patch that rejects such requests is in review
> for the CXL driver.
>
> Changes in v4: (from Dan's review)
> - cxl set-partition command: add type (pmem | volatile),
>   add defaults for type and size, and add an align option.
> - Replace macros with return statements with functions.
> - Add cxl_set_partition_set_mode() to the libcxl API.
> - Add API documentation to Documentation/cxl/lib/libcxl.txt.
> - Use log_err/info mechanism.
> - Display memdev JSON info upon completion of set-partition command.
> - Remove unneeded casts when accessing command payloads.
> - Name changes - like drop _info suffix, use _size instead of _bytes.
>
> Changes in v3:
> - Back out the API name change to the partition align accessor.
>   The API was already released in v72.
> - Man page: collapse into one .txt file.
> - Man page: add to Documentation/meson.build
>
> Changes in v2:
> - Rebase onto https://github.com/pmem/ndctl.git djbw/meson.
> - Clarify that capacities are reported in bytes. (Ira)
>   This led to renaming accessors like *_capacity to  *_bytes and
>   a spattering of changes in the man pages and commit messages.
> - Add missing cxl_cmd_unref() when creating json objects. (Ira)
> - Change the cxl list option to: -I --partition (Dan)
> - Use OPT_STRING for the --volatile_size parameter (Dan, Vishal)
> - Drop extra _get_ in accessor names. (Vishal)
> - Add an accessor for the SET_PARTITION_INFO mbox cmd flag.
> - Display usage_with_options if size parameter is missing.
> - Drop the OPT64 define patch. Use OPT_STRING instead.
>
> Alison Schofield (6):
>   libcxl: add GET_PARTITION_INFO mailbox command and accessors
>   libcxl: add accessors for capacity fields of the IDENTIFY command
>   libcxl: return the partition alignment field in bytes
>   cxl: add memdev partition information to cxl-list
>   libcxl: add interfaces for SET_PARTITION_INFO mailbox command
>   cxl: add command set-partition
>
>  Documentation/cxl/cxl-list.txt          |  23 +++
>  Documentation/cxl/cxl-set-partition.txt |  60 ++++++++
>  Documentation/cxl/lib/libcxl.txt        |   5 +
>  Documentation/cxl/meson.build           |   1 +
>  cxl/builtin.h                           |   1 +
>  cxl/cxl.c                               |   1 +
>  cxl/filter.c                            |   2 +
>  cxl/filter.h                            |   1 +
>  cxl/json.c                              | 113 ++++++++++++++
>  cxl/lib/libcxl.c                        | 123 ++++++++++++++-
>  cxl/lib/libcxl.sym                      |  10 ++
>  cxl/lib/private.h                       |  18 +++
>  cxl/libcxl.h                            |  18 +++
>  cxl/list.c                              |   2 +
>  cxl/memdev.c                            | 196 ++++++++++++++++++++++++
>  util/json.h                             |   1 +
>  util/size.h                             |   1 +
>  17 files changed, 575 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/cxl/cxl-set-partition.txt
>
> --
> 2.31.1
>
