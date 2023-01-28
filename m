Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFCDC38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 02:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjA1CjQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 21:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CjP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 21:39:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFE77DC3
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 18:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674873506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3skPhwWYqq9+Q3dD207lI3pLKfO52pZ5NMeq4QYCiU=;
        b=FAUE26FTM+jnqryC4LuMv+DfpIXAIGgAzgWdUQ917S9EYUbWyc63yT3vJTULtKgUUUYPHv
        inNzD6wtJqwyYLM93rLoSHcKXiMRRQu4Pi4RI8ZDOtrb6SGN2VFxAtL7USUEEfm+fs8Ra2
        yqbX73mJJdlU33r6XIrj8a2K6DL2U3M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-vwW110CkPw-Ig790AOInqQ-1; Fri, 27 Jan 2023 21:38:25 -0500
X-MC-Unique: vwW110CkPw-Ig790AOInqQ-1
Received: by mail-wm1-f71.google.com with SMTP id m15-20020a05600c3b0f00b003dc37d0e995so2031360wms.4
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 18:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3skPhwWYqq9+Q3dD207lI3pLKfO52pZ5NMeq4QYCiU=;
        b=YG/29MjdIX8/XDnab3N/CQY1nnrJ+1/8s01PqaNyhSGTxQ/TfQ68q84Yeb7Z63SMmX
         uCtJCmouT7DWzqsHUKVBCGbgJ1Yo5i2Y7pSb531z0pqNP5QQ3IxxVfvCoYYxIFCNkG4V
         JIXt+kAuTg4QnGutEjun35yr4GOZct9Uq0yoS4JmS0mlgr7JQDTG8eJAchY9jGmMTB3Y
         2HPrytsLUEOib6CKmN+U6B566hHs5son4nXSu7GSShEhJtSZLQVbKp5rVsQCvB6QgSte
         I/lpGVqApAyK5XRuKJmX5ixsY922pKVOpvU2z2+yFHuVAl0OqBrwM8DGbfENQwbXrx26
         zHFg==
X-Gm-Message-State: AO0yUKUI1Nf5ZW8BOgYV5SIOksQDQGOhRyCUH8HX6A443mSNrK0MQ/7o
        KrSS/lTCl5I0szPhKXe5TfMSERX6wAN+0LtCKnCY91H9ejhtMweYNdWh0qVp0R7pZ9FcItvzlUp
        bG8ze9ih3abAz6Taya4N0
X-Received: by 2002:adf:b35e:0:b0:2bf:cab7:cc36 with SMTP id k30-20020adfb35e000000b002bfcab7cc36mr6102561wrd.23.1674873504359;
        Fri, 27 Jan 2023 18:38:24 -0800 (PST)
X-Google-Smtp-Source: AK7set/Guu/iMw5Lz8J/77+zWTOLOhGbk1kcf/z87YNYZuGR6ion1t0t0yEwMF863rJcsDgTRoHWBA==
X-Received: by 2002:adf:b35e:0:b0:2bf:cab7:cc36 with SMTP id k30-20020adfb35e000000b002bfcab7cc36mr6102555wrd.23.1674873504117;
        Fri, 27 Jan 2023 18:38:24 -0800 (PST)
Received: from redhat.com ([2.52.20.248])
        by smtp.gmail.com with ESMTPSA id d3-20020adfe2c3000000b002bc7fcf08ddsm5209714wrj.103.2023.01.27.18.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 18:38:23 -0800 (PST)
Date:   Fri, 27 Jan 2023 21:38:20 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Ben Widawsky <bwidawsk@kernel.org>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 5/8] hw/i386/acpi: Drop duplicate _UID entry for CXL
 root bridge
Message-ID: <20230127213645-mutt-send-email-mst@kernel.org>
References: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
 <20230112102644.27830-6-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230112102644.27830-6-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 12, 2023 at 10:26:41AM +0000, Jonathan Cameron wrote:
> Noticed as this prevents iASL disasembling the DSDT table.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This needed but it looks like you did not bother updating
expected files for the tests. Did you run make check?

> ---
>  hw/i386/acpi-build.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 127c4e2d50..a584b62ae2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1482,7 +1482,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(pkg, aml_eisaid("PNP0A03"));
>                  aml_append(dev, aml_name_decl("_CID", pkg));
>                  aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>                  build_cxl_osc_method(dev);
>              } else if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> -- 
> 2.37.2

