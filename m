Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D8EB64DD
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 14:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjGLOZG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGLOZF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 10:25:05 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A981993
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 07:25:00 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso72263815e9.2
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 07:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689171899; x=1691763899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIuejJj8sZ9ghKm3BGL2Tt3pnRyQTtLeWAdAz28xm4I=;
        b=ZS25J56ULzxJsNnmfK6CGylet1ENoueQXRrTcqxLTEeau9We289/MCO8dCmin/zbI7
         M9fIKL+1JO0rLICL4f9viQrPNfrTvy94dXQjhL+28nyGzpZNCrTq09ObsgELd+qok+ID
         N8YC/NLf+kYN92DdINtRqbwr7/X/hNoLH64WiFKsB76L97CDHF4eO7UQsnnZySElY7Tc
         RxrIO/EBb7mnyqG+8o85rTrIHDz2ByZ5eMo5LKP70q7F8tTl8n1Kq9BnsIWZtMgnA7RN
         v/viocJYrAgkudJCu3uNmVKtb52WVo2Gz3earsvtQzrtLj+E5+VJRr/zyKKNyzAaUrtf
         /q1Q==
X-Gm-Message-State: ABy/qLZJPHgr9R48qP+bI2M8XEcup62a/fFmqFBEWBcuo+K4ge6ESVSB
        rztt1aeF+haTAgiGrGunWg5ZLlXk8pM=
X-Google-Smtp-Source: APBJJlHsLksyVBZifPJfzQo8teX4FktnlFX2x9+9vvWTFimHgq0AQ733zhUCsi+PpgcN0Om8qPWfEA==
X-Received: by 2002:adf:e2d2:0:b0:314:1560:cc68 with SMTP id d18-20020adfe2d2000000b003141560cc68mr17291062wrj.56.1689171898690;
        Wed, 12 Jul 2023 07:24:58 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id c17-20020a056000105100b0031433d8af0dsm5257100wrx.18.2023.07.12.07.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:24:58 -0700 (PDT)
Date:   Wed, 12 Jul 2023 07:24:56 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        ave.jiang@intel.com
Subject: Re: [PATCH v2] cxl/acpi: Release device after dev_err()
Message-ID: <ZK63uG6WkBJC/5+l@gmail.com>
References: <20230711161704.3033220-1-leitao@debian.org>
 <ZK2W50voY8augr8m@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK2W50voY8augr8m@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hello Alison,

On Tue, Jul 11, 2023 at 10:52:39AM -0700, Alison Schofield wrote:
> On Tue, Jul 11, 2023 at 09:17:04AM -0700, Breno Leitao wrote:
> > Kfence detected an user-after-free in the CXL driver. This happens in
> > the cxl_decoder_add() fail path. Kfence drops this message:
> > 
> >   BUG: KFENCE: use-after-free read in resource_string
> > 
> > This is happening in cxl_parse_cfmws(), where put_device() is called,
> > releasing cxld->dev, and then, later, dev_err(cxld->dev) is called
> > referencing the released device.
> > 
> > Just release the device after the message is printed/dev_err().  On top
> > of that, cxl_parse_cfmws() must fail (returns rc) in case of
> > cxl_decoder_add() or cxl_decoder_autoremove() failing (rc != 0), instead
> > of swallowing the error and returning 0.
> 
> Breno,
> 
> Is kfence satisfied if you do this?

Yes, this approach solves the complaints from kfence/kasan. I am
wondering if "cxld" is what is being freed up here at device_put().

> iff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..642983da01cb 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -297,7 +297,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>                 rc = cxl_decoder_autoremove(dev, cxld);
>         if (rc) {
>                 dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> -                       cxld->hpa_range.start, cxld->hpa_range.end);
> +                       res->start, res->end);
>                 return 0;
>         }
>         dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",

Do you prefer this patch above, mine patch or a mix of both?

Thanks
