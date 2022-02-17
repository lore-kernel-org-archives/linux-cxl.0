Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9083DC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Feb 2022 01:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiBQBUy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:20:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiBQBUy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 16 Feb 2022 20:20:54 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC72A0D49
        for <linux-cxl@vger.kernel.org>; Wed, 16 Feb 2022 17:20:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso7994480pjt.4
        for <linux-cxl@vger.kernel.org>; Wed, 16 Feb 2022 17:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7cadtmmQLWpqnDfNO/7BqDxIT7kznXIolyywHVAbf4=;
        b=sS4wdzZnPrT37CjCYgWCu8TLp11Ei7CFxuIjGDv44Mt2ivHoti/wY6MSdwNP0cKoXs
         Z21zfBugMb1CY2vsjABdEjflXhE4sdqTYSfDLkoAWfYWucbo1M7uHtiAqtTpogLYrl0T
         Bny4tAEmHxEn1N7T6sp5A5zMZsLgdkoxEdNhQMBVzalmJx54O6aDMEOdT2Io7FbEn8kA
         36+YLJcNQWtJzG2nJiiiuLwlw2U0p7FhhKvp6vg923Gz/g7rsu250azpMQiZTwABpqnr
         uPRpauBD6c9T+s5+i/bFlkwQZ/rM3RoYv8gkX6G0ez0kJPNKL/hqyrwrK3Wz+5D7lGGk
         Ol4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7cadtmmQLWpqnDfNO/7BqDxIT7kznXIolyywHVAbf4=;
        b=3BVR1BuXUMqgJPXjYPdhFIjZgNaoLFjY0ZnbL4+UfbCAH3T2i06R71HJR9X6gYp+gv
         phYq2hmTVs8E+KVPIMoeOHGzr3F7PyUmJLYyPUU/DGg+Iz1Vqdh644qSAPQlJSw4cHF/
         szVMhti+fem0HwKEUDb51/nggie21PAY66J45VQIABPtoBhyueCpuAbQSizp5msOOBgk
         yo7wgHO9P0TY/ie5y4SiErAqAaDR8Bdig7AqTOwI89wEqDPnDQNai0MhCOIGu65/hOv+
         17JkdB2teI7n25LkNYpV9/iKuZOc4b8uH7pKNjFs7QxjZR17tJIFxTyDSAOaru83002I
         /wwA==
X-Gm-Message-State: AOAM5314BF7Lg28uyoaE2m9bc61hOYAuCVroYg0pdlSpE8VKfkDbEZtI
        05dlD921mTEZXr8mU5x6Hj36xO7sJvdDH1G/QpkknA==
X-Google-Smtp-Source: ABdhPJwGogsHvhC8P7qOIe64MKrYPXZoUlX6w2MClweVcGHPqJw7K83Y/KeKSJi0yGjqpvs9L6OgDsIEYrhg9zspKmA=
X-Received: by 2002:a17:90a:f28d:b0:1b9:975f:1a9f with SMTP id
 fs13-20020a17090af28d00b001b9975f1a9fmr598286pjb.220.1645060839612; Wed, 16
 Feb 2022 17:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-4-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Feb 2022 17:20:27 -0800
Message-ID: <CAPcyv4idjxVE=U8wQJj+7cZ+ZxP79q6GqCdQG4GQZ8pRX3fb+A@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] cxl/mem: Cache port created by the mem dev
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Since region programming sees all components in the topology as a port,
> it's required that endpoints are treated equally. The easiest way to go
> from endpoint to port is to simply cache it at creation time.

As of 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver"),
cxl_endpoint_autoremove() already sets cxlmd drvdata to @endpoint, so
this patch isn't needed.
