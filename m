Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC7302151
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411722; cv=none; b=qV+La7JRBBq21hzcz0yeFGdBZQB221p0WAUg4OC2kSvBAypQIv3H8EkzBA64suLxvycRI1GtzcYHk+bHadMXePCzSJtHCMg2ULwp0cftsda4c2Vjx0jEA6hRpFtURxRWBuLWKsqTZAQ3qvF194mfWKfEhcrXf92oYqDVlZabTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411722; c=relaxed/simple;
	bh=pn2FMj69xGy0y/5Gx9Y/UeewmmSegh4/cOxhPfcbyl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVepZZgqgxGzteCVF9UfBF2JJUlpNr7TblhT/uJM8XsGlckO8omIcKl21jKr3o8KXlI/RjF9B5IDBY921+NrQ8c+h0NG04I+YwpxhXHxYnfxgPusDoL2VYVyyFNUs1gLcOKCsCAFiYLult0S2+OzE6KRaJMCTwo19Xp9z1hoxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gLOKO3gS; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gLOKO3gS"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so76992336d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768411715; x=1769016515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8gk61w9S/yjYbnW7IJJtdpbyzDzV71vvh8bvL1b1DI=;
        b=gLOKO3gSTyccUYywZb35A02WxIqUgxHVDlmvszP62iQQDqqQ8wn4Hc1rpgfHuvOktZ
         t8foui6/1MtMZufeXldYyvrbOJbZo7ssKJmxbv5Pppo5RmtMVAYTuQ0Mq1RpcXmbigaK
         /HrPLTaQSqY5nCeOp6BTj5VSxi7fM48Q7uVXb6C2D+7NL/I3IuKyGEej3KGPkqVaC3f3
         lPEoYphI3lgWgTSIBxwkS0ZJCe8/5pPPSMDUYJVrrAdj87KP4B9aI4bGI/JUD5P3p03B
         SO1si4hCUBeHOG2S1OJBiNqUhWFUgYRWEqmZ/dFhVFrata+0IwRkxsRW4sFVa07O4OF/
         D5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411715; x=1769016515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8gk61w9S/yjYbnW7IJJtdpbyzDzV71vvh8bvL1b1DI=;
        b=mOw7uXM4OIvBUFQL6gcicyi7QOpdy3EibIDUk4hCL772lJHmrlA6f0anlTbOyAV3kT
         V25y0Ly1eEaFIceXZ3bpXwkDrsHZC3dFj5vDO9YXMDteSOTwrmMblfQhRtnMF6ClD5Ia
         SXFlONrcauXjYMKyHawsAsNdTXYJJvYXuf/neeKyvi9iaVuqv6BlOFWaKN2kmwfJArID
         aDT+LkYxab6IRjKHr+7FUei+Tjl7eDPkeAveKmJSuhDmvyD/eZWsVb66RH/ZS78pVS9k
         64AlBu6cUeFVFSvrcVcukn1CkYBSU3/KXWt1JKeAMFMcOPNHwxRr9uKr1PqnjXyUYorv
         fxBw==
X-Forwarded-Encrypted: i=1; AJvYcCVTdgW7hhCQ9eb13qp3ri21zmgpdmNSfIuUU0ZFF3WgKo1ILp5oTBl8hUl8vwwqb+zMa5nJ4aBg+D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG487o8u2Wm+3RVIi6cyZY12ngumcWQ4Ol7QqsO4lSreABs2SP
	Mnnnk2dCkDHaiJ9dSoSHY9QZk365x/Xkxwo1VzrvtOwPDG/BnAYPP2HV1NRpZcA8Xhc=
X-Gm-Gg: AY/fxX7QNsdL/q7a8nkWmA/Z51hncOpyUnFfB76QpK+t5Q9cng6ul5ra8908HvRHDJV
	NZ7kHqXKA8RGs55IBztGNKjQ1cv+0CIcfLkxLwtw44waYe24GlYEk9s3YGRw3Cl8zck6n4/SrS/
	Hi7E6OrItTJhIx+Qx7FVS7TfRkxQkylXyXhUME35C8fbC/abTMsEobclBQsrtsJ9lzVA3lo6Ypx
	4MQQX7Lvsyutd9pXZEQdEkTRUMHR63ODpd1k6TNhlPwpd+tvi3zRLvy1D5Cmhl7OIaqiShLanla
	DLH8GO4pd8raXWkiztn3kHURPrrJz1WCgv+80nIgwX1X+nRVU0/bcrHGirAmVdjffq/JURPN+FC
	JImUubQPESeYMKkg1do9JeFtDQ7wr0hCfHe3HLfJOD3t8hhuO5T81QoYrTLhBkfO+Ksq7USAK4k
	brCB1ku3usdNZZzWtLQPlgs9/x4rIgwp0HWF78IF5GJ6Mt1V4Iqh7DEMmT5LNH4GKBq3x1OA==
X-Received: by 2002:a05:6214:f6c:b0:87d:e2b:cdf7 with SMTP id 6a1803df08f44-8927445388dmr42459046d6.66.1768411714702;
        Wed, 14 Jan 2026 09:28:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8927a07c731sm10671566d6.34.2026.01.14.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:28:34 -0800 (PST)
Date: Wed, 14 Jan 2026 12:28:01 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 4/8] mm/memory_hotplug: return online type from
 add_memory_driver_managed()
Message-ID: <aWfSIX5lRqb35yUf@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-5-gourry@gourry.net>
 <6a9db6ff-2fe8-4be6-baba-7db7913898f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9db6ff-2fe8-4be6-baba-7db7913898f2@kernel.org>

On Wed, Jan 14, 2026 at 11:49:19AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > Change add_memory_driver_managed() to return the online type (MMOP_*)
> > on success instead of 0. This allows callers to determine the actual
> > online state of the memory after addition, which is important when
> > MMOP_SYSTEM_DEFAULT is used and the actual online type depends on the
> > system default policy.
> 
> Another reason to just let the caller handle MMOP_SYSTEM_DEFAULT itself by
> calling mhp_get_default_online_type() :)
>

Yeah i don't even end up using it, this is just cruft from early
iterations.  I'll clean it up.

~Gregory
