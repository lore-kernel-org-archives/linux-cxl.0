Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E07192D69
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960735; cv=none; b=MQoVXpvSGGyn2clngOR8GIMfHRiyd/lMBcO8tHt9txumabrnUck2v+Ia9NseOFAExYz8QyFjtIByfe9TC7Kev4iuwpvUCP96RnrcZVMe3pJ1hfhjxtjLLgXtXZ6OnLJH3js48nvKytSnXU0Mmsu9rV5zXU+MOFxPIFNBznhF7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960735; c=relaxed/simple;
	bh=74ujiHqa5JZjFipwZbxCv3A1jGWUhbO9BIXRabl1Iwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oo3Z+OV6iASwV67WMRB9cIHOQnpUX+34oHdFfM2jniBAoQ/8yk5XePaJmwYkwQyOTP7f7V8KcO23BLQCV/WVCTo9ECdtsi9TAJElelrFfRuxGSzDRihJhQAG6Lx71o4X5K4hlQ9FrESdXv/nbkinnXQ4Kc5xEFVpKdmJNxuhg/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kcjL/6kG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kcjL/6kG"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6f0afda3fso701676685a.2
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 09:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736960732; x=1737565532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6RrQ3pBaAVcoFnAc6/GFF9heBGG2e1/nEy3oiiP8jM=;
        b=kcjL/6kGCiO6ZhdSZB2MItWLXadLtn9ZT94J7/X7SFc9C/Ju6SqIK+hq5AnIHww5AW
         STMuGsusSogox4uaofigAIlZi3kHUqc4VKMQDtFyL+EKSlvKiTXQvFx6yTJi5f7z7cWP
         On5xrai4fJ2atlbnJDECnTKoVw9UaCu2grqkcWRmT9iQQXkGxgh+F6ixvfTnT40st/2i
         +WhjVvHbyiwNahXsGNBXOdSfrqQ8f3s1oTmPi8H465NHAdejR1qCtHdzZpy0k70zGAoc
         95RBIz/BIUv/ypxDfmNKLdnaAbOojxFuzOLA977EsrwbiXy5S1Bg0vZzXB9dBQ4bfwJh
         T2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960732; x=1737565532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6RrQ3pBaAVcoFnAc6/GFF9heBGG2e1/nEy3oiiP8jM=;
        b=pfQzAVoQMq/2Ga06ckEEcoLTobq7PoeVnemojfZD7BG4fALhCpNy2rgilxEoVQci8f
         HlEYQstjQJlmTa/9pzNbnknr1kyP4pRwZzY13VrJ0JdaeHA9cYi7fZrzT//xooSj+eLQ
         PQANdkv4i4+yYkQ8b3+RQnVLTtpLYsM/OpsvFa1LQ2WYPqJwIuI9EG9PnGx9/cCUxqHf
         YyA2Q65EpHOU5OKMeVGZzWm/lro6dmDUOsFBuetabc92IvIIw7t4tWCeH2+ilynxzHTh
         6N/zmWrNf7gIlUj0Zj6XrtzyhkHvbdkeGl6E3ZXbYqhHw4gbG9RJE4HtUq3tgmvk8ICS
         xvnA==
X-Forwarded-Encrypted: i=1; AJvYcCUh7J63XSOuZaK9tsZvW6DZ0zyyo+Fiumzbq2F9dOrDvCmg+qv0vuZ45vdNstQGQfsXPL3LbU5pCyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxd6OOXq4wqlQo8KCThCsmKoYy7Vs7Eov/6TGEw64jdOOhVPQ
	rrabLHhv/rnwz0qOS0UkOS+KRXjusLdyEh4+Pw4V2Q2O2gmIT7U2NmJxa5j1Dn4=
X-Gm-Gg: ASbGncvyOj2neXaib66UjY+tHtuub+pOAJ7xZDiaQ69nHqg8yV5azVOstZCWxfiJF2v
	LLyv/7J8P1a8Ntp4C3AwknjwOuWg8oqHotI7PYdEV/9r2I10fMBm1f0F1IgSBdT4aFEfTCQvmQJ
	y7Qsz3O2vpRpvk5fBKsfusa36y7G9tnif5DEkcedo7kfIVltq7kmHZDTbTl+deTAOulXKUAnEUH
	FURgomm67HlvOKBS1dtwA/S5QqwU+DzQeB15XfTY5plcPXXcilxcTnW5M9quaO9VjZUwBDcvG5O
	ZURkyEF6FxuMcltfceV6xFP2Og1X0saUvzru6vc=
X-Google-Smtp-Source: AGHT+IFEXMvJgM0dISntes7DBNI6YuCnV9MrVUYaqBMi1+QY9kA/7GzKiLqk/h7x7hOGp4rzKanxVA==
X-Received: by 2002:a05:620a:4011:b0:7b7:142d:53a4 with SMTP id af79cd13be357-7bcd976d7e5mr4700725885a.51.1736960732245;
        Wed, 15 Jan 2025 09:05:32 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade73245sm66320636d6.76.2025.01.15.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:05:31 -0800 (PST)
Date: Wed, 15 Jan 2025 12:05:29 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4fq2UOUZV9yRtre@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z4BMyVsz7bLZAFEy@gourry-fedora-PF4VCD3F>
 <Z4fOrBYzIaIGCq5l@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4fOrBYzIaIGCq5l@rric.localdomain>

On Wed, Jan 15, 2025 at 04:05:16PM +0100, Robert Richter wrote:
> > 
> > Should be dpa as argument? Confusing to convert an hpa to an hpa.
> 
> We need to handle the decoder address ranges, the argument is always
> the HPA range the decoder belongs to.

I see, and this is where my confusion stems from. Basically these
addresses are consider "HPA" because they are programmed to decoders,
and decoder addresses are "always HPA".

i.e. 2 interleaved devices (endpoint decoders) with normalized addresses:

dev0: base(0x0) len(0x200000000)
dev1: base(0x0) len(0x200000000)

These are HPAs because decoders are programmed with HPAs.

It's just that in this (specific) case HPA=DPA, while root decoders and
host bridge decoders will always have HPA=SPA.  We're just translating
up the stack from HPA range to HPA range.

I've been dealing with virtualization for a long time and this has been
painful for me to follow - but I think I'm getting there.

> > DPA(0)
> > dev0: base(0xc050000000) spa(0xc050000000)
> > dev1: base(0xc050000000) spa(0xc050000000)
> > 
> > DPA(0x1fffffffff)
> > dev0: base(0xc050000000) spa(0xe04fffffff)
> > dev1: base(0xc050000000) spa(0xe04fffffff)
> > 
> > The bases seems correct, the SPAs looks suspect.
> 
> SPA range length must be 0x4000000000 (2x 128G). That is, upper SPA
> must be 0x10050000000 (0xc050000000 + 0x4000000000 - 1). This one is
> too short.
> 
> The decoder range lengths below look correct (0x2000000000), the
> interleaving configuration should be checked for the decoders.
> 

If i understand correctly, this configuration may be suspect

[decoder0.0]# cat start size interleave_ways interleave_granularity
0xc050000000
0x4000000000
2             <----- root decoder reports interleave ways = 2
256

[decoder1.0]# cat start size interleave_ways interleave_granularity
0xc050000000
0x4000000000
1             <----- host bridge decoder reports interleave ways = 1
256

[decoder3.0]# cat start size interleave_ways interleave_granularity 
0xc050000000
0x4000000000
1             <----- host bridge decoder reports interleave ways = 1
256

> > I do not understand this chunk here, we seem to just be chopping the HPA
> > in half to acquire the DPA.  But the value passed in is already a DPA.
> > 
> > dpa = (0x1fffffffff & ~(256 * 2 - 1)) / 2 + (0x1fffffffff & (256 - 1))
> >     =  0xfffffffff
> 
> HPA is:
> 
>  HPA = 2 * 0x2000000000 - 1 = 0x3fffffffff
>
... snip ...
> There is probably a broken interleaving config causing half the size
> of total device mem.
>

In my case, I never see 0x3fffffffff passed in.  The value 0x1fffffffff
from the endpoint decoders is always passed in.  This suggests the host
bridge interleave ways should be 2.

I can force this and figure out why its reporting 1 and get back to you.


> > dev0 (dpa -> hpa -> spa): 0x0          -> 0x0          -> 0xc050000000
> > dev1 (dpa -> hpa -> spa): 0x0          -> 0x100        -> 0xc050000100
> > dev0 (dpa -> hpa -> spa): 0x1fffffffff -> 0x3ffffffeff -> 0x1004ffffeff
> > dev1 (dpa -> hpa -> spa): 0x1fffffffff -> 0x3fffffffff -> 0x1004fffffff
> 
> Yes, would be the result without the offset applied for spa2 above.
> The check above calculates the *total* length of hpa and spa with out
> considering the interleaving position. This is corrected using the
> offset. There is no call prm_cxl_dpa_spa(dev0, 0x1fffffffff) that
> returns 0x1004fffffff, but we want to check the upper boundery of the
> SPA range.
> 

This makes sense now, there's no dpa->spa direct translation because you
may have to go through multiple layers of translation to get there - so
the best you can do is calculate the highest possible endpoint and say
"Yeah this range is in there somewhere".

Thank you for taking the time to walk me through this, I'm sorry I've
been confused on DPA/HPA/SPA for so long - it's been a bit of a
struggle.

~Gregory
