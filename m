Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB2C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A9361056
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJ2UxL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhJ2UxK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 16:53:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1AC061570
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:50:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a9so439021pgg.7
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAGfjPgEc5CIKWdeNvwVKbmAJSrZoGUuGO3smllA9PU=;
        b=4Ys3gyluWdGcblSKPWQ1IGq/hAzKhOAN5CnwNx0ec2q8PDNZAZH1V4cmJYjFNIRoMA
         Rli/v/j/wsPbrA9csRrKqGXZrTiayEB7UUWIIjfnR8VYtmV2TfUqV/tZuVAXr8K3RnJi
         xK3nRDaxKqAB1OkVv6jXsYb5cp7tpiBkYKr0oN8vo3z/sc2Xn5FkhJCdfn3WuxBQ2fjb
         FQb10bifIJyasGM+pUZTernBmkzMc8W+E4+WvvRE/pLMs4SPmUHanVJnlxSu4BHi7qFX
         XgbI17EHEetDCLKkKG7PYsdxDlJIGNA7SRPWo8MLHStCPQkPSnVArkUMR54Cezcpm+xx
         2m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAGfjPgEc5CIKWdeNvwVKbmAJSrZoGUuGO3smllA9PU=;
        b=LnkxCuZL0L6kxImneqHxK0g2LjHqLqFqymaXjGO0FJ8eE2d38M1GQ61doND3TA7860
         WhBrou/nvLU4aGwF0qMcqPgasmpn7tB1HfabxCdvIZA5hSYGOuY6KWtdVP97x1hGRc79
         yTUkoS6x47FExUopNC5/FHQkdxjQRDEyMMGnI0+KEx4UvTy+BKrZE6BpT8VZ76NBkZie
         86029/0iZ40dS4ATXjgG8LYnDtBoq9i5v7FgtNPYKulUV0iRmnln++wW3dM5dsLBP4eA
         6pt+EChnY6E/tSBz4wIId1z2WWLEZyBcbbmwJVWIh/LwKElR2w6khha3MGrg/NuHLwr5
         HBQQ==
X-Gm-Message-State: AOAM532+HKKzsyskZyWkh9AFbsxobHtPq+QxIwZWiBHOYrvI57+xZyLW
        //jE7xo1nPZ2DZCn884xgZd7JRPkwW4gRVKDVbRV5g==
X-Google-Smtp-Source: ABdhPJzybzfYSnWgUj3ks/wyWPmfDfnMYvRRnOXrb8e0ezmjX8wSu5/YsGLpQCb1dTltfPNt6BBgmhyaP0s+wPvoylk=
X-Received: by 2002:a63:770e:: with SMTP id s14mr9695619pgc.377.1635540641221;
 Fri, 29 Oct 2021 13:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-6-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-6-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 13:50:29 -0700
Message-ID: <CAPcyv4iiR_HT_9ExRvgLixWnQg8y-id1zpmRYurFSfw3OiVaYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/28] cxl/core: Convert decoder range to resource
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Regions will use the resource API in order to help manage allocated
> space. As regions are children of the decoder, it makes sense that the
> parent host the main resource to be suballocated by the region.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/acpi.c     | 12 ++++--------
>  drivers/cxl/core/bus.c |  4 ++--
>  drivers/cxl/cxl.h      |  4 ++--
>  3 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7d13e7f0aefc..b972abc9f6ef 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -126,10 +126,9 @@ static void cxl_add_cfmws_decoders(struct device *dev,
>
>                 cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>                 cxld->target_type = CXL_DECODER_EXPANDER;
> -               cxld->range = (struct range) {
> -                       .start = cfmws->base_hpa,
> -                       .end = cfmws->base_hpa + cfmws->window_size - 1,
> -               };
> +               cxld->res = (struct resource)DEFINE_RES_MEM_NAMED(cfmws->base_hpa,
> +                                                                 cfmws->window_size,
> +                                                                 "cfmws");

I think this should just be DEFINE_RES_MEM(), and then set the name of
it inside cxl_decoder_add() to the dev_name() of the decoder device.
That way a dump of the resource tree hierarchy makes sense compared to
the device hierarchy with actual device names not a series of
repeating "cfmws" entries.

>                 cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
>                 cxld->interleave_granularity =
>                         CFMWS_INTERLEAVE_GRANULARITY(cfmws);
> @@ -339,10 +338,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>         cxld->interleave_ways = 1;
>         cxld->interleave_granularity = PAGE_SIZE;
>         cxld->target_type = CXL_DECODER_EXPANDER;
> -       cxld->range = (struct range) {
> -               .start = 0,
> -               .end = -1,
> -       };
> +       cxld->res = (struct resource)DEFINE_RES_MEM(0, 0);
>
>         device_lock(&port->dev);
>         dport = list_first_entry(&port->dports, typeof(*dport), list);
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index ebd061d03950..454d4d846eb2 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -47,7 +47,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>  {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
>
> -       return sysfs_emit(buf, "%#llx\n", cxld->range.start);
> +       return sysfs_emit(buf, "%#llx\n", cxld->res.start);
>  }
>  static DEVICE_ATTR_RO(start);
>
> @@ -56,7 +56,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
>
> -       return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
> +       return sysfs_emit(buf, "%#llx\n", resource_size(&cxld->res));

It's not clear to me that anything other than root decoders will host
a resource tree, every decoder downstream of the root would reference
a subset of the root decoder range. Something like:

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5e2e93451928..00bf742396e0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -200,7 +200,8 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @res: platform address range hosted by a root decoder
+ * @range: address range programmed in the (non-root) decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -211,7 +212,10 @@ enum cxl_decoder_type {
 struct cxl_decoder {
        struct device dev;
        int id;
-       struct range range;
+       union {
+               struct resource res;
+               struct range range;
+       };
        int interleave_ways;
        int interleave_granularity;
        enum cxl_decoder_type target_type;

...because regions will __request_region(&cxld->res, ...) from the
root decoder, and all the intervening decoders in that stack will be
updated to make that mapping happen.

Note, this is just how I had it roughly mapped out in my head, I defer
making it a hard recommendation until I get deeper into this set to
see if we diverge.

>  }
>  static DEVICE_ATTR_RO(size);
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4483e1a39fc3..7f2e2bdc7883 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -195,7 +195,7 @@ enum cxl_decoder_type {
>   * struct cxl_decoder - CXL address range decode configuration
>   * @dev: this decoder's device
>   * @id: kernel device name id
> - * @range: address range considered by this decoder
> + * @res: address space resources considered by this decoder
>   * @interleave_ways: number of cxl_dports in this decode
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
> @@ -206,7 +206,7 @@ enum cxl_decoder_type {
>  struct cxl_decoder {
>         struct device dev;
>         int id;
> -       struct range range;
> +       struct resource res;
>         int interleave_ways;
>         int interleave_granularity;
>         enum cxl_decoder_type target_type;
> --
> 2.33.1
>
