Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4613D8A3
	for <linux-cxl@vger.kernel.org>; Tue,  1 Apr 2025 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472792; cv=none; b=Y8Is6Wfj+aN+EYEmh8iCgJDImbiF2n4ajgMdrKO9V1gZz5tGJrKnmYBCnKi0T3ijUQ1ijYpnN+MgFEHr2GR8fICZiv4inIHw3rGaj7ZMi72ZTW0P/+D/C9xoP+AEcYLbPM51Uiqpi7lD7FvfXPl0i/3vF1YCzBi1q+ku/skgW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472792; c=relaxed/simple;
	bh=6IeqLEYXsygKzE9uSQtADsFIQuoYRh/d2F/YOt3jAdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PffEis3kEvnf4eXG7HZ8EkIg92yaqXKwYqwnDl1m889XFx9Pg9rndPgN97YOIYKE0uoTVOXxUhEsNLvYyCHEEKu3kmwqPNjqj9CK1fsT4C+jaLw2P8nDYjc0ok9RHFHE/coOHp5ndNjooT0dcqO++yRLTd6d17N0eeZXDoOomVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=WZh9MUXa; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="WZh9MUXa"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5e39d1e0eso487242285a.1
        for <linux-cxl@vger.kernel.org>; Mon, 31 Mar 2025 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743472789; x=1744077589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/APxeJj8qxlV5y7tBQGvY/cfkpveH0FBqtxz5Y6trE=;
        b=WZh9MUXajeCfp7xp8mLEWmzeKNiUw1Xk9HfLbQcpKCpeZZEpUIKeH6KXIDnMtlJ7WO
         H3cXSzQMLYqMfuPkV51zMCaqnAJUBtGcmkJEAk2BH0/DDPo9A/gWn/2VzrxTJj4c9Hzv
         GK3Prv4N4rhWlq9t11ROacEJnn0Gpj6fFnN8Z1qYepFISUaAWH0MbF0CoV5GsQWoARlA
         npQb9k4q80dC4ruoMaCiAXr84ScZFSb7cDLKnNOXLacTKousXJ9/VA4jY3NS5tYa04r7
         bpQ5Vm4aNuLQylfAcZqwXB56nd7Z9UuJ62SM0xyL3/khzHJQymMkdfCNuAAhj0O+TqPk
         cqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743472789; x=1744077589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/APxeJj8qxlV5y7tBQGvY/cfkpveH0FBqtxz5Y6trE=;
        b=QH4xouY0IwU/HoikxYkvVFPdKHzokPECH1olZCxoy4y1prZu+48QOjoI44k8sr+Ivj
         2anpYM3RFyLfZTdRbd/mPpOKn/F1P5gyqpkb/PIVbKz0D1JuhVszFKD1JgNtXGBI+LZd
         55dcsj1ZuvwT87rjo8lDIfxrP0+GEMgheLjTVthGwiEEsgoVQ9rndQl2iE3Ysw9F+zNo
         luszJ4+lc7/LarmZ8XTMgoYZW18EA2f8FH1KyyyKFzFOnwtHPDcyye2Owje3tOkCB9S2
         HoLIE15fIL5wYa+XLaTPURaC5xWvDi6mibir9emu89k55aggdj75XzcBkzsjiQES2kXQ
         +FIA==
X-Forwarded-Encrypted: i=1; AJvYcCWOWK7DZt5UbHYwC8/9tfCp+Hpx4eN+CLkKYU3LyhVNhzHOMoWZIPbgoQS4Z36WhIeh1sOFY8adB7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IW4ytsZgZS30F75xuXkM5f9lKOgWVR2tNOby6IcvBJt1U2za
	NSnufB8Ygufy/SsCDCxBfy7FOfT61hgAT5t1NvNsssobBuHC962TDogfDUi4uK0=
X-Gm-Gg: ASbGncvRKAYLbo5iVu3D1VNV+Ui7P+ELPho7iSZcmj2PB6b5+jEpd3bNtFOddfnhNvb
	m0G4TUKnwHEiEIrudLQsHnUycklEnxAkSCQcvwu4I6d8ifV8Bk/yOLJuKdEcqwmOQzf3ScEv77Y
	h/0pSLXSWZBSZWazOEi4Vhd0bJmNZnm1llfL4nAysL+V0h9upPr0gutnNmQuB7lXTC1T8bztEdc
	hkA2CcWrM1sHDdzZNbZLlDawoIjFn6PS3PMnviXXBuawyVTs9gle9JHFyXmEktWI19SCw3a3/GX
	3fNXv52a62+kY89oU9YU3hqRyCkHypUAEF1HcOGNt76TsZbsH43MPb29bJ0bmezaUg4p9hJZTLl
	Ix0LY3F6t2ssoepLxHJftZbvw7wY=
X-Google-Smtp-Source: AGHT+IFxpCVikQ5yyrly+Wo3d8QpcAl9oj+coxqlTxTKqkD0EyECfgmCz8ov1GSVswfXNW92g5zMVQ==
X-Received: by 2002:a05:620a:2494:b0:7c5:99a6:a1ae with SMTP id af79cd13be357-7c67d22c22bmr1437821485a.0.1743472788949;
        Mon, 31 Mar 2025 18:59:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76a9d75sm578686985a.53.2025.03.31.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 18:59:48 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:59:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 10/15] cxl/region: Use root decoders interleaving
 parameters to create a region
Message-ID: <Z-tIkR_bEkDPUyp4@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-11-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-11-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:51PM +0100, Robert Richter wrote:
> @@ -1955,12 +1971,23 @@ static int cxl_port_calc_interleave(struct cxl_port *port,
>  	if (is_cxl_root(port))
>  		return 0;
>  
> -	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways);
> +	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways,
> +			&parent_granularity);
>  	if (rc)
>  		return rc;
>  
>  	ctx->pos = ctx->pos * parent_ways + parent_pos;
>  
> +	if (ctx->interleave_ways)
> +		ctx->interleave_ways *= parent_ways;
> +	else
> +		ctx->interleave_ways = parent_ways;
> +
> +	if (ctx->interleave_granularity)
> +		ctx->interleave_granularity *= ctx->interleave_ways;
> +	else
> +		ctx->interleave_granularity = parent_granularity;
> +
>  	return ctx->pos;
>  }
>  

I have discovered on my Zen5 that either this code is incorrect, or my
decoders are programmed incorrectly.

decoderN.M  |  ig  iw
----------------------
decoder0.0  |  2   256
decoder1.0  |  1   256
decoder3.0  |  1   256
decoder5.0  |  1   256
decoder6.0  |  1   256
region0     |  2   512 <--- Wrong

*Arch quirk aside*, everything except region is as expected.


I finally dropped a bunch of hacks from my branch, and my Zen5 stopped
bringing devices up correctly, with the error:

[]cxl region0: pci0000:d2:port1 cxl_port_setup_targets expected
               iw: 1 ig: 1024   [... snip ...]
[]cxl region0: pci0000:d2:port1 cxl_port_setup_targets got
               iw: 1 ig: 256    [... snip ...]

Sitting here scratching my head how I could possibly end up with an ig
of 1024 with the above set of decoders when I realized the region
inherited interleave_ways/granularity from the ENDPOINT decoder, which
is not exposed to sysfs.

Had to come back around to realize this patch set adds new
ways/granularity fields to the endpoint decoder.

struct cxl_endpoint_decoder {
        struct cxl_decoder cxld;
	...
        int interleave_ways;
        int interleave_granularity;
}

struct cxl_decoder {
	...
        int interleave_ways;
        int interleave_granularity;
}


1) the cxl_endpoint_decoder descriptor needs to be updated to explain
   why these ways/granularity differ from the cxl_decoder inside of the
   cxl_endpoint_decoder.  This is very, very confusing.

   The reason appears to be that the endpoint decoder ways/granularity
   is the region ways/granularity.  So the endpoint decoder is passing
   this information along.

   Makes me think the region creation code should call this directly,
   rather than all this indirection.


2) This calculation appears to just be plain wrong.


static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
{
	ctx = (struct cxl_interleave_context) {
                .hpa_range = &hpa,
        };
	...
        while (iter && parent) {
	        endpoint        host bridge      root
		decoder6.0  ->  decoder3.0   ->  decoder0.0

                /* Convert interleave settings to next port upstream. */
                rc = cxl_port_calc_interleave(iter, &ctx);
		...
	}
	...
	cxled->interleave_ways = ctx.interleave_ways;
        cxled->interleave_granularity = ctx.interleave_granularity;
}

On my setup, I would expect to iterate decoder3.0 and decoder0.0
	decoderN.M  |  ig  iw
	----------------------
	decoder0.0  |  2   256
	decoder3.0  |  1   256

	on entry [iw,ig] = [0,0]
	[parent_ways, parent_gran] -> [1,256]
	[iw * piw, ig * piw]       -> [2,512]


Looking at a normal system, we'd expect this configuration:

decoderN.M  |  ig  iw
----------------------
decoder0.0  |  2   256
decoder1.0  |  1   512
decoder3.0  |  1   512
decoder5.0  |  2   256
decoder6.0  |  2   256

The above code produces the following:
	[1,512]
	[2,1024] <--- still wrong


in cxl_port_setup_targets we have this comment:

        if (is_cxl_root(parent_port)) {
                /*
                 * Root decoder IG is always set to value in CFMWS which
                 * may be different than this region's IG.  We can use the
                 * region's IG here since interleave_granularity_store()
                 * does not allow interleaved host-bridges with
                 * root IG != region IG.
                 */
                parent_ig = p->interleave_granularity;
                parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
	}


Can we not just always report the parent ways/granularity, and skip all
the math?  We'll always iterate to the root, and that's what we want the
region to match, right?

Better yet, can we not just do this in the region creation code, rather
than having the endpoint carry it through to the region for some reason?
Avoid adding the duplicate ways/granularity field all together.

~Gregory
