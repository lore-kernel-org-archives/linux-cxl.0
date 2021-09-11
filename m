Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3926CC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 00:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0674261211
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Sep 2021 00:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhIKBAd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 21:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbhIKBAc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 21:00:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC3C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 17:59:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 18so3382975pfh.9
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 17:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gm0oPuyULJfjBBrFfdjjbjCL6V4Vqv3TAoRI7ifhKk=;
        b=14kz0K93ybdPPh00ZGdiUChPLlIooBqCLidvIWBhTjdYpNy84+6rvX1CbtvNsfEN1q
         +r8LOdOdcqzf6lgtwd85p6HeBmFcGiG2/zYl31ZrO7MCRHF3qvxqUKkoUF3FIMAh7w0L
         SSwoyoeUWUGQYZN0tP23WqtvXaLA/ZvzVvgUM2HvwJNnXraEuSKWz+SPiuFVQyh1N2dj
         h/R5rAnydZkFSvWTqjonhH+IhIqBj5RCKXMT4A8BLUK3qme0j2QhTsArF9IGbTFjFFNN
         U6UsABv9SCE09lTqgT0fFmXxM/zfAS4Fah17fKyCjVCPvKRRFaTIkemDXa6z/amN2wGX
         WT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gm0oPuyULJfjBBrFfdjjbjCL6V4Vqv3TAoRI7ifhKk=;
        b=QfcrL3oZm/iuaNxs0vqjLZx6QXpnfgx1urhYS/DkQkhfXP7sGuACb4m7GuMofeb6Vf
         Grs7UmbZ5YCfz2lhjHYGfats9N492uBczGQgIgHNu4JyBEPYwGWvitUIzL+rM1Z4ShPq
         De/f1tAGdH+EUTIWzVpngbY3nqb6sFZK80CV4FpNIw9KyOPDYeyhNQgsbBCFeTVlH8zW
         ELK2pkhu0yGfa5d43cekuInClxk16q5UPZ7xckOS2vtJu58xEsYtweUqw9zrXWwCp7X9
         UdKVjDyZTmVRJY6BqFaoy9YuU6/oPs9FysPM+UoCanW4ziYKmW/WzVn0rOtygUN7JJzM
         59zw==
X-Gm-Message-State: AOAM531IqZKuHcBq7Xb+XZvG36JOw9L6eM6vy7TZl3cB9omMkYZeSgrV
        CUR9o/5TCdteAGbeMm/+pMcphBsqt31GJnTZl+bFCw==
X-Google-Smtp-Source: ABdhPJxostJqzK8UFftvl5w14yxGlufYWNekurm+Lneaa6do99tcbcnPJcio5aEPXPc7wrKWXYorYFWmGr/rEoMPhsE=
X-Received: by 2002:a63:1262:: with SMTP id 34mr412224pgs.356.1631321960363;
 Fri, 10 Sep 2021 17:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com> <20210902195017.2516472-12-ben.widawsky@intel.com>
In-Reply-To: <20210902195017.2516472-12-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 17:59:09 -0700
Message-ID: <CAPcyv4jgmpa26V4FpywUkpCe10bp=EQAMBwnCDBXH710bo2wjQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] cxl/core: Convert decoder range to resource
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
> index fd14094bdb3f..26691313d716 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -125,10 +125,9 @@ static void cxl_add_cfmws_decoders(struct device *dev,
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

I like this direction, but it's unfortunate to carry the bloat of
'struct resource' in all decoders when only the top-level needs it (as
far as I can see). I think it will be handy to have a global resource
tree available for address translation service to the rest of the OS
where resource providers / holders can be looked up by name in a
cxl-specific memory resource tree. I.e. how about something like:

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index be787685b13e..e64939f1b07d 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -26,6 +26,8 @@

 static DEFINE_IDA(cxl_port_ida);

+static struct resource cxlmem_resource = DEFINE_RES_MEM_NAMED(0, -1,
"CXL mem");
+
 static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
                            char *buf)
 {
@@ -180,6 +182,9 @@ static void cxl_decoder_release(struct device *dev)
        struct cxl_decoder *cxld = to_cxl_decoder(dev);
        struct cxl_port *port = to_cxl_port(dev->parent);

+       if (cxld->res)
+               remove_resource(cxld->res);
+       kfree(cxld->res);
        ida_free(&port->decoder_ida, cxld->id);
        kfree(cxld);
 }
@@ -545,6 +550,24 @@ int cxl_decoder_add(struct device *host, struct
cxl_decoder *cxld,
        if (rc)
                return rc;

+       if (dev->type == &cxl_decoder_root_type) {
+               struct resource *res = kzalloc(sizeof(*res), GFP_KERNEL);
+
+               if (!res)
+                       return -ENOMEM;
+               *res = (struct resource) DEFINE_RES_MEM_NAMED(
+                       cxld->range.start,
+                       cxld->range.end,
+                       dev_name(dev)
+               );
+
+               rc = insert_resource(&cxlmem_resource, res);
+               if (rc) {
+                       kfree(res);
+                       return rc;
+               }
+       }
+
        return device_add(dev);
 }
 EXPORT_SYMBOL_GPL(cxl_decoder_add);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6c7a7e9af0d4..7d0d218d9883 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -190,7 +190,8 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @range: current address range considered by this decoder
+ * @res: top level CXL mem resource (root decoder only)
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -202,6 +203,7 @@ struct cxl_decoder {
        struct device dev;
        int id;
        struct range range;
+       struct resource *res;
        int interleave_ways;
        int interleave_granularity;
        enum cxl_decoder_type target_type;
