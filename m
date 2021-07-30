Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705ECC4338F
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 21:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400B660EFD
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhG3VDz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 30 Jul 2021 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhG3VDz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 30 Jul 2021 17:03:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848CC06175F
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jul 2021 14:03:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d1so12585249pll.1
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jul 2021 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYVees8V3Kr0GENQIVHO4XSK0DBrbpzdKw5jtkRl2wk=;
        b=s8aUhyixMOMLvEvNUQBJLIwdue5syUYvbjVgYYnRG22DMlm2G+3E9SFScHtTA33BkX
         TXX4o+evJJ2DpYfQOo/7AnbLJbpxsXNNlKBRmGvMGa1EROFlntHrW00efhagkNHNNP78
         vwhsP4s8CIO7VoLlv5RVoQCTst+n27Auw0SvLXoy8PyBJU8ivwW/khyY1po9OjbaS5Fv
         55rOIGiqQ5yRMMLPTjyr4MFBaYWqp0XsLUknfMEGYQlFqpjYudmoswHbF5HdtOg8vds1
         56dKeEDDlx+ywuBYE6xU1QiCX46rKyNOqKm4G5b5Bwl3Qxjp2cXKmzG/ta+BPRBk71h+
         VkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYVees8V3Kr0GENQIVHO4XSK0DBrbpzdKw5jtkRl2wk=;
        b=l2hCnPocNs01bgPbkIzj5Ud04DlOPJXe4OlmrOH7knAOf7N6ndZtpVCPzkSDBPqp+y
         N2Be0PAOVsYprIdg1VSMVEBmVBUAS2vMk2TxxuJNsXECqtPIX0Fck13IKhI7KBtvHWjb
         iie+SU5n3vUCgOYE4wtygxjfoc8YexQsnCZ1ZeVYb4IyfBrRAq5eB87qiF5ILxQgkys0
         NX1mtKbhu6+uMbjSFlciFXFQVuE7XU0rOcv3DZoCEJtv8rtOuiObVi3yZyWjEqRictXf
         +uynjdLJcUpcU6qj49fhkTQ9GiHpAHvctNDOam9dWjJwT+WfOZLXC/CXWSJYFxsZRInl
         OHsA==
X-Gm-Message-State: AOAM530YWenKgP4lL3EuLuxeEMOrUR4mv2fZ2TZW0dknZ0VRF1W2AAAE
        4ODmKjMDO6x4UH514lNk0Rd5biA66lMxa3wloHlnuA==
X-Google-Smtp-Source: ABdhPJzFtlCdWHQqKQ3enOxn0GBZNj/qJScVQ9iT/jjOTvHUAvAmDjsW0HsGWcmUpEc/ti04dA0iwPydIvtneuLQnzk=
X-Received: by 2002:a63:d54b:: with SMTP id v11mr3902780pgi.450.1627679029656;
 Fri, 30 Jul 2021 14:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210723210623.114073-1-ben.widawsky@intel.com> <20210723210623.114073-11-ben.widawsky@intel.com>
In-Reply-To: <20210723210623.114073-11-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Jul 2021 14:03:38 -0700
Message-ID: <CAPcyv4hoUWj_4cDMRszoz5ZcsUBGXE=jX9E5khE=3x97GxJJ7w@mail.gmail.com>
Subject: Re: [PATCH 10/23] cxl/decoder: Support parentless decoders
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

On Fri, Jul 23, 2021 at 2:06 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Currently, an ACPI0017 device (opaque platform thing) is parent to an
> ACPI0016 device (platform host bridge) child.

ACPI0017 is not a parent of ACPI0016 in the device hierarchy described
in the DSDT.

Linux does not even see ACPI0016 devices because the PCIE host-bridge
identifier dominates.

> The platform level
> decoders don't need a parent child relationship in order to traverse CXL
> hierarchy since once you get to these devices, you have a useless ACPI
> device instead of a CXL one.

The relationship is important for sysfs otherwise the root decoders
are floating in the sysfs hierarchy. For example, with this patch:

# ls /sys/devices/
breakpoint  decoder0.1  LNXSYSTM:00  pci0000:00  platform  software
tracepoint  virtual
decoder0.0  kprobe      msr          pci0000:34  pnp0      system    uprobe

...yuck, CXL decoders floating at the root of /sys/devices

> To support an upcoming expansion for CXL endpoints to be able to
> enumerate their decoders, support this NULL parent as a way to help
> distinguish decoder types.

Need to find a better way to make that distinction...
