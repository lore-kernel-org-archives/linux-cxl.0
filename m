Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC64F4ED
	for <linux-cxl@vger.kernel.org>; Tue,  1 Apr 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743543655; cv=none; b=FzNm44j0XaYGfTto08s1YKa9W3JtjPbAl+Ijhxd1d8MOLSIdq+oAJvt0inADTv7bhlvIaHaoq0RgFsgj+n4ZV5uij/48M7qMwHnDtdMwctzsZJz9X4MYbAllHHbTAGmhhLEgh7fZ6Cl9FDopmbMNvyNiPalK25cA0DFrFNCU+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743543655; c=relaxed/simple;
	bh=xYzMwhcYtnhtvN8SaaCyiSa6IxxohqMDLB2iDnJ6fMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRkZgsGzwRDfOMZhjy86gojJS0ZM0ZyXLCsLFvZp2R5fPQ3HJIB93U3ToET++iHdYqCWw4nLQ5EeMAZiUbiPD87xFKy/OJCumsSH5bM2vsIUfLfFB8zbNvs5yj8ipNZXLFBm1/WnbmikWj5VNr1r7onO7U9QtAXXGVTvjwd69Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SFyvnZsC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SFyvnZsC"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476f4e9cf92so45628591cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743543652; x=1744148452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PuxPlzCWg1XtqjtZcXuLr8jO4Fm1vsCDnGFdTpMNAlQ=;
        b=SFyvnZsCcc02bMdH7z3FGET23PKj8H1Wykb+AjmcMf99sjBp2fmyDfhkd1MlL+xHnW
         QB5KcJlDS5X+ty9R3vLiNop7uyemod4xxl5suy6pDv3PcWp6qnt+QZXa2/5k4QlD+BHF
         vHh5S4G99/SipsIBB8W57tBbbMWa0wQ3SgxGaKYsEurBUJTJtxy3fGIs4R75xI+ofWmN
         IaeCPwimC0yFOGsz5xypvqDihVLFcoNInU7owIHwZfjf0KU7xRlE/Dky8nwyAJQpuqKK
         nmRXO6QkxqV8AyM/1kDmhmyc1659xJoy4+lHVwXEOiCsm2Co5hkSof1/ZQ3+UfvSqk4G
         73rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743543652; x=1744148452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuxPlzCWg1XtqjtZcXuLr8jO4Fm1vsCDnGFdTpMNAlQ=;
        b=qEnFlXDkINvSLTctkDYWeFgG6f6xWK5t1mTi+RkecaFWmdWfrSehabeyb/aaFCK0ea
         RSbw1bsOd+17ZjsheHIy28jjJ+JWSAIzd5IxdgeTrC1IV+mz6PR66bx0Gylb2ieGh3bM
         KPAA7Rw4tnoWS6xikUapv7W74oAUAib6QqVrrvMr9JJ2HKW/gI8rvM+o1S4rp/8GZ3qF
         92hMhcIZ5x2MH70yN9du70l9L7E1C2W0kX521226lzUMsxkmwn2ECXzJZ0CwDZqAIS7P
         YEymZzoUXusCDxloIfHvucrAkUMQLgz88Kf2soxTMF8Yyze0OPFb+mKJlBINR8oR3ddD
         2wOg==
X-Forwarded-Encrypted: i=1; AJvYcCWDckqTRpkm4Zps8QdE07I0KnlXMq27oQfJkejDqmPLYNbdVmlJl7KntAiG6j1i9MPtRtQzRtS4ybs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/6S7mRDB6B5Cywioums+fOXqw7mfrMyCMCd7lswfbf7EZfIHB
	t2/njfHGB47wvx2LdiU+68o/ePXVdt6p6bVMjoEo1rBi6ZYsrJ/PWf5p8lYYxh8=
X-Gm-Gg: ASbGncsbuIB1plrt7/hkJLVWF/EGYs4M2mrYJQnT2x45U+6NvcHbIy6oHXKKGtNP2yE
	rHEeA3hreknmPV1i+hIv3EgslZBX18Hupg/1Mc/9ZJu95Hwz8doJsETiWmtgvwTLfXbxcvXchsU
	GWQp6WW0AbdW9JbDsLnqI3RU3OtJS2BDxpf9XF1QKAW0FaTY0VPcFT1xce1uBkEKglqUJ0WBFOk
	wesCdkIpxNn6GPbPaMzwdPQC2itYhvD4KgsCGqGpFXxwUSUD1enPRZpxJpvCSa4a45yQmFgVGTU
	yvGc6/s3iJK2dqmGlfN32hwlHgaLAph6evOjwFua2l+dCj7zUDhD+7K27h6RyCkl1uk3RQHTmxG
	iXBT9gZRppOPSINn87bTdbN3KlPg=
X-Google-Smtp-Source: AGHT+IFpzLyTO0moMy+JQ9RKfNFuL6DHIrGkQnqp1sZ6FtwI4zZggYUxfCbJ8I0wE71OxVWymUzeLA==
X-Received: by 2002:a05:6214:2022:b0:6e8:9e9c:d212 with SMTP id 6a1803df08f44-6eed5e02670mr224490066d6.0.1743543652417;
        Tue, 01 Apr 2025 14:40:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec97bde6asm66492896d6.125.2025.04.01.14.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 14:40:52 -0700 (PDT)
Date: Tue, 1 Apr 2025 17:40:50 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <Z-xdYvxD6yz3fMiE@gourry-fedora-PF4VCD3F>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
 <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
 <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
 <67ec4d61c3fd6_288d2947b@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ec4d61c3fd6_288d2947b@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Apr 01, 2025 at 01:32:33PM -0700, Dan Williams wrote:
> Gregory Price wrote:
> > Is there a reason not to handle more than just LMH's in this set?
> 
> This discussion was referenced recently on an IM and I wanted to share
> my response to it:
> 
> The rules for when to apply this memory hole quirk are explicit and
> suitable to add to the CXL specification. I want the same standard for
> any other quirk and ideally some proof-of-work to get that quirk
> recognized by the specification. Otherwise, I worry that generalizing
> for all the possible ways that platform BIOS tries to be clever means we
> end up with something that has no rules.
>
> The spec is there to allow software to delineate valid configurations vs
> mistakes, and this slow drip of "Linux does not understand this platform
> configuration" is a spec gap.

Note: I've since come around to understand the whole ecosystem a bit
      better since i wrote this response. I don't know that it's needed.


Some of the explanation of this patch series is a bit confusing. It
justifies itself by saying CFMWS don't intersect memory holes and that
endpoint decoders have to be 256MB aligned.

/*
 * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
 *
 * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
 * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
 * the given endpoint decoder HPA range size is always expected aligned and
 * also larger than that of the matching root decoder. If there are LMH's,
 * the root decoder range end is always less than SZ_4G.
 */

But per the spec, CFMWS is also aligned to be aligned to 256MB.

Shouldn't the platform work around memory holes to generate multiple
CFMWS for the entire capacity, and then use multiple endpoint decoders
(1 per CFMWS) to map the capacity accordingly?

(Also, I still don't understand the oracle value of <4GB address range.
 It seems like if this is some quirk of SPA vs HPA alignment, then it
 can hold for *all* ocurrances, not just stuff below 4GB)

~Gregory
