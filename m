Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F62C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Mar 2022 04:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiCPEYu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Mar 2022 00:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbiCPEYt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Mar 2022 00:24:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3965E57B38
        for <linux-cxl@vger.kernel.org>; Tue, 15 Mar 2022 21:23:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m22so1232369pja.0
        for <linux-cxl@vger.kernel.org>; Tue, 15 Mar 2022 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QN5BxAjO70BpcDVhIOU50WJ7iElMmqxXJEcxNA1HN4=;
        b=b7YXFRuHZZRLLBmmY/+nh6IFtnx6uwJMkcK89RhxxPeK6zuceplk23SRpazNuQBIqL
         ctxp0R+z0FVeA3NbHfPbHL67kF6dzxkbd/II4SxBImJa6Gy7hPQ4dMT3vG00FcUfGuof
         IsfQGYUnZypru1UVLYEumWdAh3mq2z4PdVGwu0kkyd2HAzocbofCGqTyjxf3+U/IaSIG
         HzJDViODGkbVpI+LEbXnaJkn5+H/yU4JQim1Yh9VZutYUfBJKLK81bnEM04Y53gfLwol
         +8fIjjD02MY06mABtJTITm2RPYgEwpyjqWygNXzcE7ahzGxdnQGSjEJnPWiL6m7K6CxW
         wAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QN5BxAjO70BpcDVhIOU50WJ7iElMmqxXJEcxNA1HN4=;
        b=rOQbTx1gVQQ2KPow5ii7CURLRv7EjV5wX86K3J1qQlZEolazq11uDlSIMVabqviHVn
         6a/mKD7PeIOM4sybDwrA0BBSMMlQo17Xu0uEstpqZDxrUeRZBrvkqg9SeQQm/fAwttKC
         f83M2CfIPWfMGMGam06dYCqsgd7vFr3ol39rF1BApCLgfTKkyj64SL7HRsTi5v55vznP
         moWd8ZAZ5EW4SWs9jwbt2di5ZSZwwcmHNGrV8OxzVm+TS2RVaVQO5lrGSGorPXx1IXzS
         HLDnx85ne90fbQ2zn5K+PaBsBju4skDOrAA3HWMXrB//vp2pdISOKxDRjQfz1LjZjDRl
         /ehA==
X-Gm-Message-State: AOAM5318CMZSGy5UT//vYb6QmQHJt0fVIwk/8bFxRMVn0C3om5pa9HKH
        uuBEcS55dAu2znqCxaFRPTzcYDktQbO57q9BfgchaYTBbWmWSQ==
X-Google-Smtp-Source: ABdhPJznDcFlJVdNMbsxVAO5sRQ1YIh+dEL9aBRO6eQu+nMMMdY5sRE4yU8E9k0oVv+GMDDusLjSd2LacGNI6nK20XM=
X-Received: by 2002:a17:90a:cf03:b0:1bf:7005:7d73 with SMTP id
 h3-20020a17090acf0300b001bf70057d73mr8157618pju.8.1647404614488; Tue, 15 Mar
 2022 21:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Mar 2022 21:23:23 -0700
Message-ID: <CAPcyv4g8EGEwtUw5MEZ3pHa8d6sDjKV1eOP2OfYSoUxW2DDQjg@mail.gmail.com>
Subject: Re: [PATCH 0/8] cxl/pci: Add fundamental error handling
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 15, 2022 at 9:14 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Add a 'struct pci_error_handlers' instance for the cxl_pci driver.
> Section 8.2.5.9 "CXL RAS Capability Structure" of the CXL 2.0
> specification defines the error sources considered in this
> implementation. The RAS Capability Structure defines protocol, link and
> internal errors which are distinct from memory poison errors that are
> conveyed via direct consumption and/or media scanning.
>
> The errors reported by the RAS registers are categorized into
> correctable and uncorrectable errors, where the uncorrectable errors are
> optionally steered to either fatal or non-fatal AER events. Table 224
> "Device Specific Error Reporting and Nomenclature Guidelines" in the CXL
> 2.0 specification outlines that the remediation for uncorrectable errors
> is a reset to recover. This matches how the Linux PCIe AER core treats
> uncorrectable errors as occasions to reset the device to recover
> operation.
>
> While the specification notes "CXL Reset" or "Secondary Bus Reset" as
> theoretical recovery options, they are not feasible in practice since
> in-flight CXL.mem operations may not terminate and cause knock-on system
> fatal events. Reset is only reliable for recovering CXL.io, it is not
> reliable for recovering CXL.mem. Assuming the system survives, a reset
> causes CXL.mem operation to restart from scratch.
>
> The "ECN: Error Isolation on CXL.mem and CXL.cache" [1] document
> recognizes the CXL Reset vs CXL.mem operational conflict and helps to at
> least provide a mechanism for the Root Port to terminate in flight
> CXL.mem operations with completions. That still poses problems in
> practice if the kernel is running out of "System RAM" backed by the CXL
> device and poison is used to convey the data lost to the protocol error.
>
> Regardless of whether the reset and restart of CXL.mem operations is
> feasible / successful, the logging is still useful. So, the
> implementation reads, reports, and clears the status in the RAS
> Capability Structure registers, and it notifies the 'struct cxl_memdev'
> associated with the given PCIe endpoint to reattach to its driver over
> the reset so that the HDM decoder configuration can be reconstructed.
>
> The first half of the series reworks component register mapping so that
> the cxl_pci driver can own the RAS Capability while the cxl_port driver
> continues to own the HDM Decoder Capability. The last half implements
> the RAS Capability Structure mapping and reporting via 'struct
> pci_error_handlers'.
>
> [1]: https://www.computeexpresslink.org/spec-landing
>
> ---
>
>
> Dan Williams (8):
>       cxl/pci: Cleanup repeated code in cxl_probe_regs() helpers
>       cxl/pci: Cleanup cxl_map_device_regs()
>       cxl/pci: Kill cxl_map_regs()
>       cxl/core/regs: Make cxl_map_{component,device}_regs() device generic
>       cxl/port: Limit the port driver to just the HDM Decoder Capability
>       cxl/pci: Prepare for mapping RAS Capability Structure
>       cxl/pci: Find and map the RAS Capability Structure
>       cxl/pci: Add (hopeful) error handling support
>
>
>  drivers/cxl/core/hdm.c    |   33 +++++----
>  drivers/cxl/core/memdev.c |    1
>  drivers/cxl/core/pci.c    |    3 -
>  drivers/cxl/core/port.c   |    2 -
>  drivers/cxl/core/regs.c   |  172 ++++++++++++++++++++++++++-------------------
>  drivers/cxl/cxl.h         |   36 +++++++--
>  drivers/cxl/cxlmem.h      |    2 +
>  drivers/cxl/cxlpci.h      |    9 --
>  drivers/cxl/pci.c         |  163 ++++++++++++++++++++++++++++++++-----------
>  9 files changed, 273 insertions(+), 148 deletions(-)
>
> base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4

Apologies, wrong base-commit, this series is based on that commit + this series:

https://lore.kernel.org/linux-cxl/164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com/
