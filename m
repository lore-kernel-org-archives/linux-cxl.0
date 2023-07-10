Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1C5EB64D9
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Jul 2023 10:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGJKtT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Jul 2023 06:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGJKtS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Jul 2023 06:49:18 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB2B5
        for <linux-cxl@vger.kernel.org>; Mon, 10 Jul 2023 03:49:17 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso5122520f8f.3
        for <linux-cxl@vger.kernel.org>; Mon, 10 Jul 2023 03:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688986155; x=1691578155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz/CXP8WxXBR12DChwynoxBwgxi+1EqsskEpSwz7a+Q=;
        b=Nsqw/nv1tO2x4hevqtG0XjjTWMnA/M2Gi7HBm7GQAEU69DgBgcJoSQ+d3baCggCJ0T
         jNG8OxBw7RV2pA7ZxrLl+FPfVvIRx0QwINlp0aMh/29GPqSVm/fSO8JZiFbsF+sbWfc+
         W2dUhLOlPa1bQ6eAXYANKzh/tyCdlN+SROXGQRgjn2fBegQRRl7O/an4T/PFZCGRCC9Q
         fuvM/o8rvXf5UTaPouHY8PsFOJiZj4i2EzRWL9fhIV9ocCDUmhCVRiXFLSmXM/PqoxC7
         k/lx88noHrhIzgCg6jYRReW5K2sewioYWdad1j879i6U/roQsvZyt280R2xD+DB9gr3x
         9u1A==
X-Gm-Message-State: ABy/qLa+BAGJsyeBSsoSOX8pa2qxhMuiql/TYxfRoP/FSG83DTG2AemI
        SkbjNx6znDGxTd2gxjWfyl3+6V1Bexs=
X-Google-Smtp-Source: APBJJlEpkfzIGn1Ovok7RTat6uOE8Dc3gbt2Xy3/TUhcMtOX7vMadmT/KsLp0J+c+4uhJMHHFBIgzA==
X-Received: by 2002:adf:dc11:0:b0:311:1b8a:b70e with SMTP id t17-20020adfdc11000000b003111b8ab70emr15091615wri.66.1688986155488;
        Mon, 10 Jul 2023 03:49:15 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2-20020adffd82000000b0030ada01ca78sm11331433wrr.10.2023.07.10.03.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 03:49:15 -0700 (PDT)
Date:   Mon, 10 Jul 2023 03:49:13 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Release device after dev_err
Message-ID: <ZKviKY6Px9qqJYK3@gmail.com>
References: <20230707161616.3554167-1-leitao@debian.org>
 <fb897ce1-3abf-f5b6-6585-1c74054beb86@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb897ce1-3abf-f5b6-6585-1c74054beb86@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 07, 2023 at 09:50:09AM -0700, Dave Jiang wrote:
> 
> 
> On 7/7/23 09:16, Breno Leitao wrote:
> > Kfence is detecting a user-after-free in the CXL, when cxl_decoder_add()
> > fails. Kfence drops this message, after the following:
> > 
> >    BUG: KFENCE: use-after-free read in resource_string
> > 
> > This is happening in cxl_parse_cfmws(), and here is a simplified flow
> > that is coming from Kfence.
> > 
> > Use-after-free:
> > 	_dev_err
> > 	cxl_parse_cfmws
> > 	acpi_table_parse_entries_array
> > 	acpi_table_parse_cedt
> > 	cxl_acpi_probe
> > 
> > Free:
> > 	cxl_decoder_release
> > 	device_release
> > 	kobject_put
> > 	cxl_parse_cfmws
> > 	acpi_table_parse_entries_array
> > 	acpi_table_parse_cedt
> > 	cxl_acpi_probe
> > 
> > Alloc:
> > 	cxl_decoder_alloc
> > 	cxl_parse_cfmws
> > 	acpi_table_parse_entries_array
> > 	acpi_table_parse_cedt
> > 	cxl_acpi_probe
> > 	platform_probe
> > 
> >  From my reading of the issue, the device struct being used by
> > dev_err() was removed in the put_device() before.
> > 
> > Put the device just after the message is printed.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/cxl/acpi.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 658e6b84a769..5179bf4211d8 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -291,14 +291,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >   	}
> >   	rc = cxl_decoder_add(cxld, target_map);
> >   err_xormap:
> > -	if (rc)
> > -		put_device(&cxld->dev);
> > -	else
> > -		rc = cxl_decoder_autoremove(dev, cxld);
> >   	if (rc) {
> >   		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> >   			cxld->hpa_range.start, cxld->hpa_range.end);
> > +		put_device(&cxld->dev);
> >   		return 0;
> 
> I think you will want to change this to 'return rc;' in order to reflect the
> error.

This is a good point also, and I can change it in v2, if there is an
agreement in this patch.
