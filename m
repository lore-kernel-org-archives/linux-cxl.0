Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEAE1A3029
	for <linux-cxl@vger.kernel.org>; Thu,  9 Oct 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020220; cv=none; b=A9TI3PrkMPLzsZ/ysxE02tkIsBUg3PVVz3h8ILpPI2qSE9fsKKRmXPg8Ww4Dq0VTRHK7sh82AyW/U4n71cEITUJKji4PwvF+R5jO7aVGEiNIOgEPrvZFd6BnpQ8PwEV9p6HrS5XpBMF9sDnHI50zn7iS9axrHACA/Rx5NOGH60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020220; c=relaxed/simple;
	bh=MbAn6IxXoYCyZexFvoEXvgKWUGG3Aew40oi74OvfjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWmLiXlneef4FNGX2matYQlVQJyzMiHL2UbwMIFf2zwsntEHxB9aloQobT4PSsjffjS8rocmUMi98XorabMOJbQx4p+G41Sh0q/vZvTN7XAmgb+uIeKgUfFRh/a2GkaDsXf2y0DlXkUtTADGcTtbc4ekSBKkvAbbLqOBbRg4sxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BOkzVqFH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BOkzVqFH"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e6d9573c2aso14227471cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 09 Oct 2025 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760020216; x=1760625016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e09H8JuVw4CGVu4LXKpckxUyqmwU5fhDRfovcXXQuDM=;
        b=BOkzVqFHxBDiA5B0s0XrbYRIfIs3hMDIUxv0Sybl8y4n2B8DcePA27hNQgrqXTj2zt
         0DSpSWD9cnmfrAdN5QX/5yGNHk7hBf+DDAJmo0B+4vuIMNUj/DRdsXC4PAQ5dGpEcHYf
         F6MGf3+s2lx41xJtXjHeCOtIABWiHUaSWpRJ+79n6Mkowu54MBferX6uOOLrM6kqdgxt
         idp46Xbl72Y/STWAy0GWt+QRAYUpOb73rodLXBR8A6cPk0A7obPUy+GliGxBujiCVZIx
         2TiHqHoC+sAYG9cfUUl7B6jSQcM4oB3v32ErSnYeCxh10kRbxJn+FEI7iTZWDTLo1TyG
         qZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020216; x=1760625016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e09H8JuVw4CGVu4LXKpckxUyqmwU5fhDRfovcXXQuDM=;
        b=KQP6paMKPIovc4zzffDwAa21qsuFT6lOCzxuUmhXFymNp2xYmOUtH8kiNDlNnC7MSe
         PoCL42DegdE0HNfYwNQbGH3iI11vqZAbZv7aO0lctlX61Y81JyuKsXOGXU8b1lHm3GxH
         vF/uW5eSRPA1k+qfHrIA3sK5RcT7MMkD/8JgyYz5mdbkjLcYGJB/4B9fRJ3M0UviHNHb
         +N7wmAQfTuM8lCDEKDDBQGr0OfXUjW9tMj8NuUR8EyalLiRCal+IlmaalBkagqVUCK/X
         t3+5gpuq6FoK4ZgKSKGLCzrEU1tpTpVK6d3ajCgVkIhPOrDil8ICUJTQPMdSuxLBY/6d
         H2zg==
X-Forwarded-Encrypted: i=1; AJvYcCXv4TDq09wffiKrXDuUaU3Ni9bzxyZ+v0YnV59cLqgJyGDAs8nY1s4g2Z11XU0PaCifDBZW4a4reZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoE0JmojhsKQfyjN1wy/kuPu0xT949ca797GML2b43edLeSqjR
	p675BTn9RJblvmCnKAXy/YuXRiEedQLpkM5c+zUS/lOHP6NJn1QMQYcFP0VenK2kfGY=
X-Gm-Gg: ASbGncsOoNwenNvfgGh/M2V1rGSyLGeYkki86ELriXGDrA8xyWiLhCYvamQFECGv5g3
	FN42TfofiDJ0ReOaEaial+VoGgVp3/TRuJLv+O8cJz0ccH0UFzrOtpeEo3Gm7YNckkc6ajnCP+Q
	vjWlAl4a3ojuM4rzOcgKpHjri2UQW/CjCkpyCYv1HDmd6okC6DBfi09vHA+ShLvDWmVB5/NlJwD
	Bga/H9HwPT7N5qp+t1wnUE1ZFZ9gucCVfkDaCn6cx+3RMWEeczOMbqPog/3H3pHXOfDE0sUjXJK
	5NoedzpeLyMy30KFUr3YOsdpDyQkC/0UZ3siNH3qtaQZnuac7aS0thEYKYq8+sl1PoiKQzs7ZwR
	58oAhytgH3sHkeQWbPDqaCyn5NNeaXOa78yQ/m4ckMtjFmb1N3tRHgCEQ4gccOINXmOAjQfmgtY
	QJLALjSfYZJ7qxIzGROnRYRuX3L3AQ8fjNvtnlgTM8
X-Google-Smtp-Source: AGHT+IEuLK9K8/tHFdY+GPJPmi23LKwWmvNrqeBvd0kYXhrW7D0oKUmleIkRDgwlwwcejqyQl94Zlg==
X-Received: by 2002:a05:622a:5889:b0:4e4:5f64:b61d with SMTP id d75a77b69052e-4e6eace67eemr119642921cf.19.1760020216302;
        Thu, 09 Oct 2025 07:30:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e6e7c88cb2sm46457091cf.26.2025.10.09.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:30:15 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:30:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/4 v5] cxl/core: Enable Region creation on x86 with LMH
Message-ID: <aOfG9XKnGRrzxad8@gourry-fedora-PF4VCD3F>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
 <aOQAb9H-wIxc6j31@gourry-fedora-PF4VCD3F>
 <ed390a72-2470-4e09-8fbe-56915d619dfa@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed390a72-2470-4e09-8fbe-56915d619dfa@intel.com>

On Tue, Oct 07, 2025 at 01:25:11PM -0700, Dave Jiang wrote:
> On 10/6/25 10:46 AM, Gregory Price wrote:
> >> @@ -1779,8 +1788,13 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
> >>  	r1 = &cxlsd->cxld.hpa_range;
> >>  	r2 = &cxled->cxld.hpa_range;
> >>  
> >> -	if (is_root_decoder(dev))
> >> -		return range_contains(r1, r2);
> >> +	if (is_root_decoder(dev)) {
> >> +		if (range_contains(r1, r2))
> >> +			return 1;
> >> +		cxlrd = to_cxl_root_decoder(dev);
> >> +		if (platform_cxlrd_matches_cxled(cxlrd, cxled))
> >> +			return 1;
> >> +	}
> > 
> > Is there any concern for longer term maintainability if addition
> > match_*() functions are added?  Or is this upkeep just the unfortunate
> > maintenance cost of supportering the quirk?
> 
> Suggestions welcome. Would be nice if we have cleaner ways of dealing with this.
>

Had a bit of a think about it, but nothing immediately pops out
that doesn't just end with more obfuscation.  It is what it is.

~Gregory
