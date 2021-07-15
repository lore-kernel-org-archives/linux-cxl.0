Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD0AC636C9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 23:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC05613DA
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 23:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhGOXt2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhGOXt1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jul 2021 19:49:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6CC06175F
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jul 2021 16:46:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y4so7158372pfi.9
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jul 2021 16:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hnh9iNBPG97lV3I3Bxjjzu4zB9fwQYDGOo06GiKMxIA=;
        b=qJXEwzieAs9NT3fNDA2Omg+SU7c7OuzvkNiiYeklOt1He+XGia0ol/nNga2gj7YCbU
         /dSC4daFDWqAuGQ7rQpkCzt/2mLB6HSjGkLR+tTTFT9i4qq2XGOmNRrqZgvgSd8o2XE7
         h7fhYzQscr5t9Gif5XU2667KAm2l1sCPFX1Or7EPoEaSQGP3nlFosUk93tGaHfmVokY9
         1iqL6DLXbMPza0DmYOjz5i/d4MyQ3zbT1MrmYWcWE+P2BPGbydNsyHP+Gtdv3I9R1NLN
         hRJH2s881gUPpboW/RWxRXqO4xBNbuCgbJNZdmw3/Jn5UpIH5YO2qAwFGuXOs9XD175A
         FwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hnh9iNBPG97lV3I3Bxjjzu4zB9fwQYDGOo06GiKMxIA=;
        b=JInETCx+GpdLqBMYyQWahm30gJ5nOpP7p+PnZ716Y7R4p9pnujsV8HOwBdQ0oP2kLT
         dOTwE9f8oBHqDBW7UqxoXuKo4Zx3Z1IZZJd9M/WeRHYcjz3+PPdIxPrPAkY+3ZKWPtrJ
         zuFpJOCS4Emb+dw1X5z/WFe6WjPELwT7e47pDWnFp7lwWX0zNfOPgZJo+WAfDaeQDkGa
         9umpsfq13ttr24drxS8yCfLbZ7eVbYU6dS+1HbJkglK1o2JK1eysDXeevo5HwHXg04rR
         QtdY9jQuDAEYQcptYguZDZTyJ8q1yp+eooULuSZymeCp7FLcpVOsNiS34xHBSKG8LVKN
         RQSA==
X-Gm-Message-State: AOAM533ltdcu140eue3j9V3dOZ5KCbRwscdhCjl74oa89zcMYmsE3yoc
        +OihVmH0GMRas0YJXT6RKjD8van+5E9zh2EuaA9l7g==
X-Google-Smtp-Source: ABdhPJzfahEER1ktMjnH/iCOvnfUNaI9d/uEMNrHpaJX6R1lynyGSdmx00wGD0nldNMXi6rHRordu4DBQhJrXqM8770=
X-Received: by 2002:a63:d54b:: with SMTP id v11mr6956990pgi.450.1626392792965;
 Thu, 15 Jul 2021 16:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210715194125.898305-1-ben.widawsky@intel.com> <20210715194125.898305-3-ben.widawsky@intel.com>
In-Reply-To: <20210715194125.898305-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Jul 2021 16:46:21 -0700
Message-ID: <CAPcyv4gSig7j5mEJ1yDFY0cxdNLOUBsrJ-EN1JH5vhXLOBOA+Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] cxl/core: Improve CXL core kernel docs
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

On Thu, Jul 15, 2021 at 12:41 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Now that CXL core's role is well understood, the documentation should
> reflect that information.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 00b759ff92d3..f50872e8e7af 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -12,8 +12,15 @@
>  /**
>   * DOC: cxl core
>   *
> - * The CXL core provides a sysfs hierarchy for control devices and a rendezvous
> - * point for cross-device interleave coordination through cxl ports.
> + * The CXL core provides a set of interfaces that can be consumed by CXL aware
> + * drivers. The interfaces allow for creation, modification, and destruction of
> + * regions, memory devices, ports, and decoders. CXL aware drivers must register
> + * with the CXL core via these interfaces in order to be able to participate in
> + * cross-device interleave coordination. The CXL core also establishes and
> + * maintains the bridge to the nvdimm subsystem.
> + *
> + * CXL core introduces sysfs hierarchy to control the devices that are
> + * instantiated by the core.
>   */
>
>  static DEFINE_IDA(cxl_port_ida);
> --
> 2.32.0
>
