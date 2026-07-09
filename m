Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243FB2744F
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783634228; cv=none; b=eGIbhSmMTokrPT0hOmUXyaQsXMpVsTGxHV+qupRuY39HVgwV5Fu4kBg/dZORGXOtYa9euNTBLN6QLWUmxi7rbX0+V34e/35Rxqt8TO4vTsOCe6VhXn6zX9TOK9kOAOGSaGCQMSSFmZUg8j0ifFebQUgcVIBIULFueaGRRNGhDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783634228; c=relaxed/simple;
	bh=8UAIjOhvfbKjsQ/HTeZBSW9rJpTCzyIJqdF78M986Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6KfKSTftbqXlKXewqwNkweo9AzK4WUB9+Awgf7uvYsdBz6Yi3aGxsZmZALSN0TvRc5uRe7E20g9KVRMvnEzI1I6BrEoFY1aE+7NpzzGtD4VyQQulHAmUU3HW/QAinU3kW/ER2jZpeFjuSeqdlRb0O2QLqSaPNI+BpR2tvITHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jJ+P7PfB; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jJ+P7PfB"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so3083526d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783634226; x=1784239026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1AtZcCJL7SSO55KaeQpBRgHzud/kdG6WTG09Vy9G3lc=;
        b=jJ+P7PfBLXbjT1Rj5WlEniYWLmlHlbxUD90Xxnzpg/yjCanjKgxL+RtFPEdfgR2oyx
         0wEW/vD/gH1tUE4FGDERfWdghinDh+o8e+Q1fxIT7dsw8DoHnWvZjaa2NtfFUd3OGAc2
         ChTjWCdhyWBPfC6dXPpitW79JuhgvARxItvaGs/xVwwYSRvqrHjUbpKz8mIDFlYJJwys
         idPhAhYvLRgVAOWClwhJwxDZM8YbbfZ/8/OEz0bh/JAFskblZqcheMZ7bCvPzbryUqpv
         dFGcITqw9H3ZlCJCK/8UrUiLbFwHLJwH+29S2FL8OwVV7fg1qnsn9+yQ2LDWzUpIfRkz
         PimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783634226; x=1784239026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1AtZcCJL7SSO55KaeQpBRgHzud/kdG6WTG09Vy9G3lc=;
        b=FYBCa5HEq8EsE5SW8+EtaOr1cez6TGgJ7WgFa+yr+lRTfHaS9aL0fF2WVTup/HGEVA
         x4m0Qzas68U90AXWkablVBNvUVzudxAprE6g2FvjnDnBLUgx60VvoWltiSXvg7bAzmp5
         DwUdkOYSD5slJuJ9opT/jRXDvjvtBRnFlfuJ7gqWnT/1WHmbFA1a9gn8pkQ/Ui2VHPPZ
         XxbZ3qI+qieKWJH7nMPzV0T3nX1lxvu2Xt1UyylkOmX1AJzYIDS4guJK1vo5TT1wu4z8
         RAebvzzyt/xNtoWp3tp2w72+fC7bqMYRpwUWvX+Fm584DbXR4htQXG+kufRiRngPzXcy
         m0EQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPmaf8ApGEf27IlrGyAj1LeHGU93ZHGacFBVkTKI6bh0HpbjWHTWhRm3BFg0ZDN4/0fUwYdBBUr34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRzY/Y7oIfjpiZTMpGs6tHsuHjrg5Ce6nyJ/z0tuVs5VGfv6fL
	1IkZeVFaegLZeT3dT5bNMb4Kn0J8GsPwEYBAov6CR7glRmMxSDae+CVbi7LJGcimX2M=
X-Gm-Gg: AfdE7cnkcWCtZ4k/s7f1MyEu0dlu0ntYBfmaMmjWCSzQt5jwYy4Z9yy0yJGSxmZme8D
	dXRkIwYfKSMpSoAt7XGk0EjAGLtqdRW7twuyNtgwsuGgKVl60O4rgH4uQgGsEYgPMan6UCudM0j
	ZTHTkp9bFpCe1wtXFxX13N+OTmc4Ru5ZeOi1prVt+hU3EnM2U12OQgGr1/oFzzXojnIcu1wQKcV
	4sNGzgl8grLrTOZv504zFKiT+TjOogxMHd5RH9Sy8EOVrcMmi98F4WH0v410dPVOTGZGweVwd3J
	MrwZD69EiQvhfMzP3qAzGtxwiWNuhEwVNSJg6pJcsDcjmA/gVaLNBGay7FRsbChWQx8fnseDJhN
	r9WuDMStmh1MiJYIXE2x1WPb+eC1805Qk4rIIBqmGdXpR9FBfJwGkNBOjWpOLuzDO1nOvi7g1ax
	l1zwkaWo47l+F57JxNym4YMMBGbuNc8lZedKuCnb0w5RQgaP+maBO5XG8xtd5NjOfOhB5N
X-Received: by 2002:a05:6214:2b83:b0:8e7:8d53:240f with SMTP id 6a1803df08f44-8fec2a4a020mr91687356d6.43.1783634226132;
        Thu, 09 Jul 2026 14:57:06 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd82csm26977986d6.35.2026.07.09.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:57:05 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:57:00 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 02/10] mm/memory_hotplug: add mhp_online_type_to_str()
 and export string helpers
Message-ID: <alAZLBqgUEZliwk_@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-3-gourry@gourry.net>
 <bdf0ca14-eec4-43b6-93aa-310e77660d95@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf0ca14-eec4-43b6-93aa-310e77660d95@intel.com>

On Thu, Jul 09, 2026 at 02:08:43PM -0700, Dave Jiang wrote:
> 
> >  extern int mhp_online_type_from_str(const char *str);
> > +const char *mhp_online_type_to_str(int online_type);
> 
> Does this need to also be 'extern'?
> 
> DJ
> 

General policy i've understood is: "No new extern"

We use the EXPORT_SYMBOL_* family instead now

~Gregory
