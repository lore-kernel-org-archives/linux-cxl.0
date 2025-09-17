Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C2A2857F9
	for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142302; cv=none; b=e3LxIXh3+Zpr5QOIlDQtdpw9NE7hzddXkH71fzPzyQsh5ifwFcFg68kOvFZWnE9dzCCs8pAZS+cpy1HwMoH+qsne8jNAxfqljQ2Lrl0K/QUZEQnfauqBir1kThrxh3EMx5m9MWUcd47Gip/13Be8uOxp2QsNbHrfxniI8h0/HvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142302; c=relaxed/simple;
	bh=wQvLRiBXDj6VtyhIkweb+J/LGGpX+Bj5UgJ7DmBBbPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISbtEcjY4mnIUj4HBfksRKoOtzqi9JVuSBk0We0jQ+zu7kotsSflHuuX+6lE/jrLNL2uO1439u81I4Bh/4El9m7btdBqTMeaAbwldHyPy4KB4TmS2en8sE133Ly9ZLHieO5N5BlPSbzjzLgk+a7pM8GHvgZ2s3+dhppwj1ZREc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j6qnyWFP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j6qnyWFP"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5e35453acso2368981cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 17 Sep 2025 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758142300; x=1758747100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w67NJrFvcjqAdTQ9mCPnhFNgXmY6BD3kGRa56ePYCWI=;
        b=j6qnyWFPiqtKdAnQJx2LXC9hXuH7hfhmHJVINlv6k1S6q25G4defMWQyZBo8XmlzJX
         iDUxN1xJmdVxNvlh9mufTvxhQBF88lHO+ifCkQ++mt4YUaF4pPYnuLq5akG45xVQdaOe
         hIznLTpsZPdpL7A26fTolB3vogbJC4sd5tAaEn65xqf4HfRytjRWWKBuXFJ0ORptCLDi
         ddV3Jiupbnm1pwNGtvS21ADKKLn95RnhsK+DqmIHHXAsQ24dO8LjzFeaLRy2ibHb7gHS
         N4Rw1LPqwd9holM7a5B3ODhKPq5JI1lkIVwIrqzo776QLHoTe+sHLywrVJpq6Uh1/Ycn
         az6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758142300; x=1758747100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w67NJrFvcjqAdTQ9mCPnhFNgXmY6BD3kGRa56ePYCWI=;
        b=VS49JEV3Ge3NtVZAA0JnXzk09elAUk0EzH6MsTTpZrmpWj7umP6lRzeRvWRJOn1QeH
         vFqVRzMS+YWr8GFnE0TtUymEtL8pCQlIZsQJJnjoXrtAUiB+oHND4bJFUSHjH4QHCTic
         q9XeA3nWl0oi+cPrI4Z30rUQeQPTsuOf0zzywBJjD1PdeYswwlRKfnwltBjvuKUQZSOZ
         ngV11kzuf+32uMOEskDuTI99LnnbcEwNNOg+zKVLof3/bAdOfXUNSxIdxNaCiFDQLRFF
         q5prk+sUmQ/we0wRs21mlzXJMJ+gFwZAwZlfaAGm1czYthEjWlXt9o4/DFBdz8Fzhffm
         6xNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4PjcTk0oFwSDGzOEHwyrYfU0WZB4RhlEYXC1DS6N5GBl1ERkNGXHzd0MVp6uI7yQja2q36NTBRfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqtcj1SxiJs89xeXxNluGuWYewOlMIsFLByTHQHcxwWuJ1tWQB
	L0zcLRvBWmurLu9sujFtXRzCPu2rDe2Bn4J5+KY9bwNp8vSKWGphbQVMtLXIPWwfUPMGb7bpJbK
	HZaXn
X-Gm-Gg: ASbGncuMTykVk0DrhYFG68fS/JiWcUBdGhnkzkCtcoBRfAKyRreqjDEw/1IN46sPmqk
	xWfXFfjzJyHJSaaswdZ4e1Fn90oHfnu5bby0MAh8t5Iyb2A3Se92HHZE/kMM21VdPXC9tHzCt+9
	U+rxzNs9SwvvaDFKwpD7hzreTrx/2Sc4RgL/TREcBsc7QhSi7zWdNe55JGxAG/bFWgJhZzRGM9O
	n5nX8TLbwzmlMEnXEGOulN2cQKzkxmI+dTVfuGU2pBwcx/0J80CCckPO1jc5zz7F4sMGBuH88I2
	7cy+6bmdGQKVOb0VQ5BlWKWrL/yLCXgiTtU/MlRdGd1wEF4KWdshjJH+Ls2Nig+yCFHbPUDickc
	TdzIuKIj2c1TScJevJsemG6VMo0e0KM72Yr7cSUJFrf5hR1Q9+vzn9Bi6rT2xCV1eTkvciGUlmT
	viY7c=
X-Google-Smtp-Source: AGHT+IGg29GpEvK32YLKgF/pd7sAjd5cJDb0a27ozoPbfeRjzihNQCeXTcdSxSoxPfGqLWFUkOLPJA==
X-Received: by 2002:a05:622a:48d:b0:4b7:a44f:5263 with SMTP id d75a77b69052e-4ba6cd712ccmr44103361cf.71.1758142299817;
        Wed, 17 Sep 2025 13:51:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83626780107sm44548085a.5.2025.09.17.13.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 13:51:39 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:51:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 08/11] cxl/region: Implement endpoint decoder address
 translation
Message-ID: <aMsfWfwMhewTjHD3@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-9-rrichter@amd.com>
 <20250915114614.000053f1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915114614.000053f1@huawei.com>

On Mon, Sep 15, 2025 at 11:46:14AM +0100, Jonathan Cameron wrote:
> > +	/*
> > +	 * Since translated addresses include the interleaving
> > +	 * offsets, align the range to 256 MB.
> 
> So we pass in an HPA range without interleaving offsets and get back
> one with them?  Is that unavoidable, or can we potentially push
> this bit into the callback?  Probably with separate callbacks to
> get the interleave details.
> 
> Overall I'm not really following what is going on here.  Maybe
> some ascii art would help?
>

The endpoints in this case are encoded with "normalized" (base-0) with
a size of only the memory they provide. As a result, the decoder
interleave settings will always be passthrough (iw=1, ig=ignored).

This chunk translates the normalized address region to the relevant SPA
region, and translates the IW/IG to what it actually is (i.e. what it 
*would have* been on a "normal" system).

Took me a while when i originally reviewed and tested this set.

Example - this is how you'd expect a real system supported by this code
to be programmed:

region {
    .start = 0x20000000
    .end   = 0x3fffffff
    .iw    = 2
    .ig    = 256
}

endpoint1_decoder {
    .start = 0x0
    .end   = 0xfffffff
    .iw    = 1
    .ig    = 256
}

endpoint2_decoder {
    .start = 0x0
    .end   = 0xfffffff
    .iw    = 1
    .ig    = 256
}

when you do the translation from either decoder's hpa start/end,
you want the following output:

range {
    .start = 0x20000000
    .end   = 0x3fffffff
    .iw    = 2
    .ig    = 256
}

If you assume a "normal" system - this is the settings the decoders
would have been programmed with in the first place.

You have to do the alignment because the translation function (may)
only work on granularity alignment.

Example:
endpoint1->to_hpa(0)         => 0x0
endpoint1->to_hpa(0xfffffff) => 0xffffe00
endpoint2->to_hpa(0)         => 0x100
endpoint2->to_hpa(0xfffffff) => 0xfffff00

So this code applies the appropriate alignment and returns the
translated iw/ig for use elsewhere in the stack when validating the rest
of the decoders.

(haven't gotten to later commits, but iirc it was eventually used)

~Gregory

> > +	 */
> > +	range.start = ALIGN_DOWN(range.start, SZ_256M);
> > +	range.end = ALIGN(range.end, SZ_256M) - 1;
> > +
> > +	spa_len = range_len(&range);
> > +	if (!len || !spa_len || spa_len % len) {
> > +		dev_warn(&port->dev,
> > +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> > +			range.start, range.end, ctx->hpa_range.start,
> > +			ctx->hpa_range.end, dev_name(&cxld->dev));
> > +		return -ENXIO;
> > +	}
> > +
> > +	ways = spa_len / len;
> > +	gran = SZ_256;
> > +
