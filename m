Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED373451B0
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780697004; cv=none; b=o3E9W4OXr3DlY8z6k8AhpED0YsbxJ8wnW6cZKfIPz3Fxnaml2PDymlgbuBcBTuPSsCryCtAeCDocU+XuqPXtLgQkjvc2XyY1/FyLnma3Dx+h41mvoJfvjSPoOImrhcaz5+DbWtlATESA281ZPMXCA9UvhtNpF1fwKqxwxdP8Lko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780697004; c=relaxed/simple;
	bh=SPbh3ojU72bFIXuY0qiZcOuk2PrvLuoH5dLI7Gt1djE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asDZ8lnijCgzVVF90nGAz9jzrQLWbIHsfBYnf14wyjk8mJtH+267dY9JdsGlHvfcqpdJuEAriTZJ763nh3j7MFjPmHtmAoo3kTL1CtlO3xeYQPoh5iDVdjD9bpiwxuMw3lJQLhq96gtjJrLT2RorIo5VrE+n/rrM/I0iJ8yMgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eshgTVjz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eshgTVjz"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517583cb07aso26109851cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780697002; x=1781301802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5SZooodiCJIzwrHSkzIWvRjJGmT7hEK7Fa4gKTfb1gU=;
        b=eshgTVjzqdvXIz96e8gCHuGCq/7VsO94LsJBPz2M4clxVsbMqvpQSHTcRhkVH7R/jp
         HOpRlH1El2x/h+03U/scvfARQkMVxwsWYQSdUl0if4i+oAUg6Q6AiyLI/pj6RzVcXt8D
         0JwhQBzFOYHmp2+cdyRxF/J8Ou5fpLfjp+cl32xwimAFCqrUHW/uD3XbyvbZ8L6SMjpg
         uUUAl++X/NTUoCk+lrQ0ucJzgxIHCEs4eAEswFIt9hz2x4nH/J6w6YWjJgktlhsootnR
         aFx2Md0swC8Q3rgO0I4SPNWq5I+TW7ksoT/sIzG/csXMPUVG9CGRYkaTKDCZ/8lh0jsH
         F98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697002; x=1781301802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SZooodiCJIzwrHSkzIWvRjJGmT7hEK7Fa4gKTfb1gU=;
        b=g7bdw/pBM9RQf7MwEc6B8lzGpwPw2HoQKjvV4tVbYQrgG2Jdxr3saDKRAd91GzX+gx
         Tkk0ruqIZl07YUCH+pszC38bT+huroqxvHzxxwUW+rq9D1zUW7F97erCfllw4REl2qgu
         NL0YuOD9dRZZ0lMU38Ms5GQUSwEaAM7Y6ygosUz7HsoTlTLVQeJ3D1oMGvLJ1bsrutOV
         VaTKutwylR5Y7zF9WkfEPF69MyY7Hrel3GWYYXTm5U9XMADQEhAHfA2Xd9anPSgX1uWF
         ELMqJmiO/uFAzfOWjxM69ne9j26tYp2F86Lq6WjmPtzUpTd0AM3ZGLC/S8+1mtyS9gqm
         iBHA==
X-Gm-Message-State: AOJu0YxNMbtPlh6s6zBKs0e7n332EbnUKKhDCnf+hKoaden1ukwC5msp
	sduMvbvS5injSmz62h9I+HwaCVbPCgD7WNC8Fey89C95H2IitfPcMkJ9r07FUh15NURwxEg1IuP
	ijaX7lVDFlQ==
X-Gm-Gg: Acq92OHwsihSm9s//iuIx3pacLqs/MeKzlZcxmxNWQaa9X6sviQPWzUR546BFvqMA+1
	G52vSMzGgAgV3jK51eAEL9IFHmNK/yWdndr0ZGH1x+ruOl/dWHHNVFZLpFmfpDeWlYVp4WrrTKD
	lSJgCezDo29Cn+mISYHT13OvFSL/5Xe1WW/l/aOSSUdMh59qXzrIouadBsgywl5gDdUjuoNTeUf
	wwaOqcEiQ1h8Rq6qIwzAC6sDPhrOYwkLnWENlN+eFHc8moo4msIWPvVEFiYnXy6WOjUJJFmHknG
	q0Viw4x6WUIc6IX3NN50GGTMRSakRRgqdy1r7oQFp4M7B3R3lYS9W31isM0gj9VaVaaCmrYJMQC
	zOp7/Un011NrcVyOHIU5SO1A8ww85SMck+tEINrqSQv7AT/Zp2kODAqIs+xXh9p7CaeTSQI8ubz
	V+KBBHJ2m8V2sFzTTvgsRw5rTAknIOY2oOZ3LnhSXDUyJKxcSj3V2CxfEa3DaxcmauM+f1D7tO1
	gwLU7MJcd3kyX7ZhLS/j5KhW6oJ
X-Received: by 2002:ac8:6102:0:b0:517:5add:e449 with SMTP id d75a77b69052e-51795b9ec5amr82684041cf.22.1780697002243;
        Fri, 05 Jun 2026 15:03:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775da6f41sm87047171cf.22.2026.06.05.15.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:03:21 -0700 (PDT)
Date: Fri, 5 Jun 2026 23:03:20 +0100
From: Gregory Price <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 7/9] dax/kmem: extract hotplug/hotremove helper
 functions
Message-ID: <aiNHqGsMih-XF0tu@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-8-gourry@gourry.net>
 <20260605213602.10D1E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605213602.10D1E1F00893@smtp.kernel.org>

On Fri, Jun 05, 2026 at 09:36:01PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] dax_kmem_do_hotplug() unconditionally attempts to add memory for all ranges, missing a check for successfully reserved I/O resources, leading to unsafe hotplug and a permanent memory leak on removal.
> --
> 
> > +
> > +	for (i = 0; i < dev_dax->nr_range; i++) {
> > +		struct range range;
> > +
> > +		rc = dax_kmem_range(dev_dax, i, &range);
> > +		if (rc)
> > +			continue;
> > +
> > +		mhp_flags = MHP_NID_IS_MGID;
> > +		if (dev_dax->memmap_on_memory)
> > +			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
> > +
> > +		/*
> > +		 * Ensure that future kexec'd kernels will not treat
> > +		 * this as RAM automatically.
> > +		 */
> > +		rc = __add_memory_driver_managed(data->mgid, range.start,
> > +				range_len(&range), kmem_name, mhp_flags,
> > +				online_type);
> 
> [Severity: High]
> Should this loop verify if the resource was actually reserved before
> adding the memory?
> 
> In dax_kmem_init_resources(), if request_mem_region() fails for a range
> but a previous range succeeded (mapped > 0), the failure is bypassed and
> data->res[i] is left as NULL.
> 
> If we don't check for !data->res[i] here, does this unconditionally call
> __add_memory_driver_managed() and hot-add memory for physical ranges that
> failed reservation?
> 

This feedback is actually subtly wrong, the old code would do

for region:
  get_resource()
  hotplug()

The new code does

for region:
  get_resource()

for resource:
  hotplug()

I see now I forgot to error out if nr_success != nr_requested.  With
that, this condition goes away entirely and we can cleanup without a
partial hotplug event from having occurred.

~Gregory
