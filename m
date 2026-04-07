Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508BE3B892B
	for <linux-cxl@vger.kernel.org>; Tue,  7 Apr 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571332; cv=none; b=GBPmWO7bIbY19Eseb4aJo647+EBwTIKFGBeaqbx8CjOKslaZqwDOyo/rV70s4a/fbuL6u7YQJEPA9AQ5jtON/KQgVM4cB5ojIccZQZLp++TkooOrdQuWNDWpAprGYtcryWI7sMYaNc91ob2lywik1FuQc4KZ/06EPej3HfXf9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571332; c=relaxed/simple;
	bh=FnSsZuPnGyxPDhNZRLYQ6JCnZWuSSmTUwVpsXpmU4SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRxUk9IGwBhoQTRcZqe7/hhrRntgC+ipILt21+ZVx+NaKLDsb8cEg+6BjUEAfTuQmSXTkb1UVTd8ORDy3a7TUl0MT4edCqi/KtjnHvfEf5/5dbh4pnyAJud2wug8PP15+o0Tsn/FODW74RiWP1DKpaU70PNABk/mO7BuAxj/HMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MtaqTtWC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MtaqTtWC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a1e1817db6so50591036d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 07 Apr 2026 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775571330; x=1776176130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrXvcr862UuyP9u64puUV6+vM1HuF+WgVzFiTHYkxJA=;
        b=MtaqTtWCayCARWnIfAPjHP9sgccrUonJRIK8Swc2gcl2f8lHjGClpqtv2R1df2NZJA
         A/ifVD2S55jf7AngdY6uUPhI5nGMeX3IDKA5mLsic7GDGQfBqGDiEYdH0Id7wupSketU
         L+t1ngjlUlmMA2O7DBM6sOkr5RN9K/U73cJnwu0bmcraxzr+QusBAmyxAEDPSNw/nsZD
         UmHVpz2jeyyLXRvEnFOgEQgslBrrkNbqzhWuYgzgT3jcHOdfPeM/CjgXFMvbr6PXuTrF
         57hq7ZDVXjZTNxHPoTCBcNiEWHmYPBkvt9yGZNEe6tIy2Vgt1h/ZaSs1VYK/FUHdxpPq
         Qjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775571330; x=1776176130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrXvcr862UuyP9u64puUV6+vM1HuF+WgVzFiTHYkxJA=;
        b=P4CO3p9UHvYfsBiB0cNHLt/XABicSX6JgVZLS6EIT3qFvI9FF1Y/yLfOqrModonk0Z
         XZkR4Kki2U5HaKuP2YwJ9TfALm6Rb9ZIuB3NxjSRlvuIC8/cPGGmew76q/M9WJ5+4iYR
         BUO3J0cJB0jr6YqurfH4+BUrodyWHvzM6Hndr3dfAVaVf2+wF1oo9D6x3ph+na0+DTx3
         WTE2HJvlmvQAD+lNJReNFkB9xIW0RWIvb6mze0xuccJ7x2EHVWd1xTgFeecZry5IVf86
         Lg+OWRzfx2H6uaCOvKgAo+mm/WPS9qiYqsF2kG5FVbpeMjEVSSrglG3+15544nbA7gaK
         cb4w==
X-Forwarded-Encrypted: i=1; AJvYcCXbODzyGd7tM8zqw5vYhP9asCJgljzz4ZAro/I8lkjWtTvauiWhps4E3xFwxZztBoaPLcU0elFi5M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd0b9V4d1zz1rjhyNzNQ4ffHzdTH/x0qng6tGq169cNp3LigCl
	/oq80rZjHviYq/hBMazQUhAzBW/kw641vROoqCuv479We+F7xjipKWBGfRGjebwhfLU=
X-Gm-Gg: AeBDiev7RlZp76LnEVfnrx+eyRLGwjGJltwosuOSNPngvATh5HJziCm9lpdgnN/iE5f
	8pRW7UV4n+YLsobEf5IxD5KG0u95h0dB6K5H+I5Ays62xhixrkp7LI5Giv83MXpJvioszSpDyur
	wSZGqc5HD7izCUAk4VwfCXkbFRJIVCMJggGhxQzKIhC+bc1wbseaJP5VzqCuQlYdUZ6Y2sru3QL
	wT+9Wbrb74C+s5VUkjEVg6RsEBURhfVxK6lFvBrrMBIsSo3kiQlAXbgzndGwaEByI6t5fqECjZy
	uoB3lhYFIJJiktIgjAvfv06s/gc7FsMUzTN6CmZpLsqX4K8+uGL+8e8T5omGfL669bwYpEttnTu
	jCLYGnjcPcy1zNUMVlfGxfVszJeSxc9pfiegp9nS4v7/sIFfcBgcZKd5Ob4qOwY+2Q770u1otsh
	LRkSwSxg524NNe2eBAngcU5lqbYuy28MDWXKO8s6yia+tq85+pdfI16QCp/3Gi/MYCNSukUFkSF
	9qwAyjxNx8D
X-Received: by 2002:a05:6214:400a:b0:89a:f92:b09f with SMTP id 6a1803df08f44-8a7022bb7a7mr282281776d6.4.1775571329335;
        Tue, 07 Apr 2026 07:15:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596ff619asm183100226d6.37.2026.04.07.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:15:28 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:15:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dan Williams <djbw@kernel.org>, mhonap@nvidia.com,
	alwilliamson@nvidia.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, dmatlack@google.com,
	shuah@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, ankita@nvidia.com, vsethi@nvidia.com,
	cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com,
	kjaju@nvidia.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Message-ID: <adURfscEwBuT3utz@gourry-fedora-PF4VCD3F>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
 <20260404185330.GD2551565@ziepe.ca>
 <69d1685538f45_556821002f@djbw-dev.notmuch>
 <adQj_gxSzjA51Q6n@gourry-fedora-PF4VCD3F>
 <20260406220521.GG2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406220521.GG2551565@ziepe.ca>

On Mon, Apr 06, 2026 at 07:05:21PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 06, 2026 at 05:22:06PM -0400, Gregory Price wrote:
> > On Sat, Apr 04, 2026 at 12:36:53PM -0700, Dan Williams wrote:
> > > Jason Gunthorpe wrote:
> 
> I would expect this to happen via the request_resource mechanism, if
> MM is using the CXL range it should be locked in the resource tree and
> vfio should request it and then fail during the initial startup
> phases.
> 
> > I need to read up a little bit on this area, but i don't see the "needs
> > to be mmap'able in a cache coherent way" to be an argument for one
> > particular method or another (hotplug, private node, memremap, etc).
> 
> It is speaking to what VFIO has to do. It is the exclusive owner of
> the physical range, it does not have struct pages, it must be cachable
> for VFIO and KVM to work - not alot of choices here. Turn the
> phys_addr_t's into large cachable special PTEs inside a VMA.
> 

Right - the observation here is essentially "if you need struct page and
need to get fancy with them...".   But if you just need to plonk a
region into one set of page tables and move on - then this is fine and
arguable preferable.

~Gregory
