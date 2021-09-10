Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA91C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48288611EE
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhIJSQ2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhIJSQ1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 14:16:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6473DC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:15:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w6so1672874pll.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTq2qYkS6pmH2FHpmgxIPl1sMQJ/yAq84hId0RdToj8=;
        b=Zfm14dGNwv6F6yzfAB6IJy4X/syhwp1cJHfPi5oN/X9WedmZXEv0BbJO62Eudvxdyy
         1XJDm92YzGvmzzOuNb37InJPxuVfNUW7ixJAoOyfodWeG5QHIv8q7H//t8103t8JWwWS
         YlvvPxZbUQsHzuJGafZuQNR+q/tgsoV0NHEyQOo2X9uknnKp5Wb9g8bYf0TEgpx3yAHz
         8TuFVZd7ZqSqwGiQ1xrTX1Ze6pN/dBXcTP0KQISQieaas2yt4sMe1+/p0VTHQX658W7c
         bACQB7LXPLLd4LfWDshrUWmNFpqofdT4ZcZ04h0ogQMl9eNdmKtIEtpsZ6gYjIfR2L+W
         IFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTq2qYkS6pmH2FHpmgxIPl1sMQJ/yAq84hId0RdToj8=;
        b=BAgTjhHc9fZBPK6Ig0Atxz+yg0veCXJoZhdoNmly6WH1daktSvYzDOIQgvAJnFOJca
         Ve5hyGIdtQRUuZPsTc+LsTyg3fHrHm7TEg0s0e96DbwExzeAQC/B7emwnadMu7ilI6Xi
         oE7M0JQ9RlelP9oh37YbWacCFaaR3FnDg97reRvya8py4FjrCaGJLyK42bxpKaJkwsNK
         SDaeaYiOH5GnkH/kJN3VxgnYe//vwXmjE3xfHUlh5M7v2Jgu9fdP0pX2Uhksq3KL8D2y
         B0vLpp8nMPqqdpTuGVdLpM8YvNX3rrae8lC2a5n4p7bpoBMT6T6RjXbdSx1YQyas84SF
         RmfQ==
X-Gm-Message-State: AOAM530npyBrTuBY5K5za+z4W8tH0ocZscqbynk/0U8hxOHRG8YSJXVs
        vjHfRrh/57ITHR40Ay+29aK4Q7hFLCZlItJ615OwWQ==
X-Google-Smtp-Source: ABdhPJyw+zOmR1hnQXj9pgRS+WCAaaOhIMkJhRZ8rOJ3Xd7A5D1jiDxdEMzCCt9CP+sPMiNcbb+uMDA020jXSBRvZaE=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr10927616pjb.220.1631297715695;
 Fri, 10 Sep 2021 11:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 11:15:05 -0700
Message-ID: <CAPcyv4hzszdcVequ5-tz7m8uvOTDYWw8ywN_7oqtTZ4koN7t7g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Enumerate midlevel and endpoint decoders
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

On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Every CXL component may implement component registers as defined by the CXL 2.0
> specification. In preparation for creating and enumerating regions it's
> important to at least enumerate all HDM decoders which are a subset of the
> component registers. To do this, a new cxl_mem driver is introduced which is
> responsible for binding to a CXL.mem enabled device. In order to determine
> whether or not an endpoint is CXL enabled, the relevant subhierarchy must be
> enumerated.
>
> This serves as the stepping stone toward enabling regions because regions must
> be able to determine if the devices selected for the region are CXL.mem capable
> and enabled.
>
> There's two issues that need to be resolved but I'm going to propose we fix
> them next time we need to touch this code...
> 1. cxl_pci now relinquishes its component register mappings. This may be
>    undesirable as cxl_pci may need to use those mappings.
> 2a. some amount of component register enumeration is duplicated in cxl_pci and
>     cxl_mem
> 2b. awkwardness in cxl_mem where memdevs get their component registers from
>    cxl_pci, and ports that enumerate their own component registers

I don't immediately see this as a technical debt problem. The CXL
component registers belong to the corresponding CXL functionality
driver. One agent should be in charge of all of them and any other
agent that has a request must work through the owner. The sub-device
design pattern like registering cxl_memdev on the cxl-bus, or the
generic mechanism to register auxliary-devices on the auxiliary-bus is
specfically targeting this case of parent-driver registering resources
for a child-driver to operate.

>
> The obvious fix for both of these is to move component register mapping to
> cxl_core, and let cxl_core arbitrate the mappings for the "client" drivers.
> Since the code needed to enable cxl_mem was small and subset of the existing
> code (and fairly error resistent vs creating a cxl_core API) I'm hoping to kick
> the can down the road.

The core contains common enumeration and mapping code, but ownership
belongs to one and only one agent, no runtime arbitration. ...or so
I'd like to assert unless there is a exceedingly good reason to add
arbitration complexity.

>
> NOTE: I do not have a way at present to test switches. For this reason and for
> patch readability, the switch enumeration is left as a separate patch.
>
> NOTE2: Some of these patches were introduced in an RFC for region creation. Upon
> further inspection, it made a lot of sense to land these before region creation
> so long as it's understood upfront why the new driver is needed.
>
> I've pushed this to my gitlab here:
> https://gitlab.com/bwidawsk/linux/-/tree/decoders
>
> Ben Widawsky (13):
>   Documentation/cxl: Add bus internal docs
>   cxl/core/bus: Add kernel docs for decoder ops
>   cxl/core: Ignore interleave when adding decoders
>   cxl: Introduce endpoint decoders
>   cxl/pci: Disambiguate cxl_pci further from cxl_mem
>   cxl/mem: Introduce cxl_mem driver
>   cxl/memdev: Determine CXL.mem capability
>   cxl/mem: Add memdev as a port
>   cxl/pci: Retain map information in cxl_mem_probe
>   cxl/core: Map component registers for ports
>   cxl/core: Convert decoder range to resource
>   cxl/core/bus: Enumerate all HDM decoders
>   cxl/mem: Enumerate switch decoders
>
>  .../driver-api/cxl/memory-devices.rst         |   6 +
>  drivers/cxl/Makefile                          |   3 +-
>  drivers/cxl/acpi.c                            |  39 +--
>  drivers/cxl/core/bus.c                        | 326 +++++++++++++++++-
>  drivers/cxl/core/core.h                       |   1 +
>  drivers/cxl/core/memdev.c                     |  19 +-
>  drivers/cxl/core/regs.c                       |   6 +-
>  drivers/cxl/cxl.h                             |  65 +++-
>  drivers/cxl/cxlmem.h                          |   6 +-
>  drivers/cxl/mem.c                             | 237 +++++++++++++
>  drivers/cxl/pci.c                             | 124 +++----
>  drivers/cxl/pci.h                             |  15 +-
>  12 files changed, 727 insertions(+), 120 deletions(-)
>  create mode 100644 drivers/cxl/mem.c
>
> --
> 2.33.0
>
