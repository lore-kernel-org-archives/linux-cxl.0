Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75558C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 06:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbhLBGkK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Dec 2021 01:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344659AbhLBGkJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Dec 2021 01:40:09 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC0C061574
        for <linux-cxl@vger.kernel.org>; Wed,  1 Dec 2021 22:36:47 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id b13so19537782plg.2
        for <linux-cxl@vger.kernel.org>; Wed, 01 Dec 2021 22:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFoQAdLxmz67AyI3TimVSkiQsA05Gfv+53YJ4mz9anI=;
        b=yoUz2R5ZUyS08CAsLxZ6ka9odpd04zNNHkvBJhkQCid4NyOr1Ngi2596LJI+voQfnp
         Dih52VraDELWxKvfGGYmF28slNl61JIIUWD/ud9Dru22hQZ3T+LUL+BXcB1iGIK0s/DM
         JscYk4Z2l4eVRSSU9EN4Zl4rlYDtzT0y774LcpoasnO5EZ94ZuBe8A4+uO5W6uyQUatB
         dVANE3QWGgINWbXDCM/fZf7bAW0RN+a+raA4ZY0x+MM6IAxRBTa7nm3EcUihF/gYxKDV
         wzasx1BF5oeAgXQ+00tdxA+YczhF0CrwEfizqey4Hezzjp2feCi8yqX8j7aJYF64zQsC
         NS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFoQAdLxmz67AyI3TimVSkiQsA05Gfv+53YJ4mz9anI=;
        b=gIoFKi1ALOhyefgX7k1x/N2Bf42B5K6Ttv1hoTSZKmDxnKNLutwFykHcaeziWZsiXN
         bmPj3xD3dHMWuvWYFPFwECr+bmn0nHFImro6fV3F2bltr6emFrnnSCALgGEgcKjJm+ZL
         S3YT0xgSHVMlledVD9vxNweZFQWDyN2acHJuT4gJb1TetXQ2PSkK1+YXrohWF2y/zymG
         bZkqViZxV64BOyXL9Y8SvSMgt4CXKIogDmL/OmoD1h9xpJ+0eiJV6n/mWF3kagrhhrmz
         T/ov/axkTWwmjXn0C20MnrS0DDuIx9rtOWC4AP65Pba7vlx1slLsisPk/fgsAyalfnxh
         9fYQ==
X-Gm-Message-State: AOAM531Y+mx1yMKRx9lRcnZzNpXWf+gq5lNcJxStc6rcKaAHWAOwxrgO
        TzUzFXsQxvkeX/Sj2ycunirtOhmw+jq6MEtLqXVMlg==
X-Google-Smtp-Source: ABdhPJxLHO72QQUXSQooe5CKL3UTqAylyX606kcuxsZv4HJqAkpoJu2GvLw3EeAXInCOnkyHuIXXrLh8Srm/0GnJbcA=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr3779546pjb.93.1638427007388;
 Wed, 01 Dec 2021 22:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20211202043750.3501494-1-ben.widawsky@intel.com> <20211202043750.3501494-12-ben.widawsky@intel.com>
In-Reply-To: <20211202043750.3501494-12-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Dec 2021 22:36:37 -0800
Message-ID: <CAPcyv4jrYohXiD3FbuZXVRPP1Wbqys4qffn+5Ck=+49wmTP3Gg@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] cxl/port: Introduce a port driver
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Dec 1, 2021 at 8:40 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The CXL port driver is responsible for managing the decoder resources
> contained within the port. It will also provide APIs that other drivers
> will consume for managing these resources.
>
> There are 4 types of ports in a system:
> 1. Platform port. This is a non-programmable entity. Such a port is
>    named rootX. It is enumerated with an ACPI0017 object, by cxl_acpi in
>    an ACPI based system.
> 2. Host Bridge port. This port's register emumeration is defined in a
>    platform specific way (CHBS for ACPI platforms). It has n downstream
>    ports, each of which are known as CXL 2.0 root ports. Once the
>    platform specific mechanism to get the offset to the registers is
>    obtained it operates just like other CXL components. The enumeration
>    of this component is started by cxl_acpi and completed by cxl_port.
> 3. Switch port. A switch port is similar to a Host Bridge port except
>    register enumeration is defined in the CXL specification in a
>    platform agnostic way. The enumeration of these are entirely
>    contained within cxl_port.
> 4. Endpoint port. Endpoint ports are similar to switch ports with the
>    exception that they have no downstream ports, only the underlying
>    media on the device. The enumeration of these are started by cxl_pci,
>    and completed by cxl_port.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since v1:
> - Include header for ioread64_hi_lo (LKP)
> - Fix variable out of scope usage (Jonathan)
> - Cleanup error cases when adding decoder (Jonathan)
> - Handle decoder initialization in separate function (Jonathan)
> - Commit message rewording (Bjorn)
> - Grammar, whitespace, and typo fixes (Bjorn)
> - Skip DVSEC mess; mem driver won't add (Dan)
> - Skip checking global enable; move to mem driver
> - Use better names for get_caps and map_regs
> - Rework helper functions to be more idiomatic
> ---
>  .../driver-api/cxl/memory-devices.rst         |   5 +
>  drivers/cxl/Kconfig                           |  21 ++
>  drivers/cxl/Makefile                          |   2 +
>  drivers/cxl/core/bus.c                        |  67 ++++
>  drivers/cxl/core/regs.c                       |   6 +-
>  drivers/cxl/cxl.h                             |  32 +-
>  drivers/cxl/port.c                            | 318 ++++++++++++++++++
>  7 files changed, 442 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/cxl/port.c
>
[..]
> +static struct cxl_decoder *cxl_find_root_decoder(resource_size_t base,
> +                                                resource_size_t size)
> +{
> +       struct cxl_decoder *cxld = NULL;
> +       struct device *cxldd;
> +       struct device *host;
> +       struct resource res = (struct resource){
> +               .start = base,
> +               .end = base + size - 1,
> +       };
> +
> +       host = get_cxl_topology_host();
> +       if (!host)
> +               return NULL;
> +
> +       cxldd = device_find_child(host, &res, decoder_match);
> +       if (cxldd)
> +               cxld = to_cxl_decoder(cxldd);
> +
> +       put_cxl_topology_host(host);
> +       return cxld;
> +}

This can be rewritten to avoid the topology_host dependency:

static struct cxl_decoder *cxl_find_root_decoder(struct cxl_decoder *cxld,
                                                 resource_size_t base,
                                                 resource_size_t size)
{
        struct device *cxldd;
        struct cxl_port *port;
        struct resource res = (struct resource){
                .start = base,
                .end = base + size - 1,
        };

        port = to_cxl_port(cxld->dev.parent);
        while (!is_cxl_root(port))
                port = to_cxl_port(port->dev.parent);

        cxldd = device_find_child(&port->dev, &res, decoder_match);
        if (cxldd)
                cxld = to_cxl_decoder(cxldd);

        return cxld;
}
