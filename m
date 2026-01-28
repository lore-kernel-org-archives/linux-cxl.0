Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F5B376BCE
	for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634858; cv=none; b=mzXPJ78RPJMTVPk7ya7PE4X2g2YGjddIAs4PEJuZWIsp7DqKa2ynOyj5yS2q51dOQE1KIl8FsymXHVpJh4j8WMyOT4GzzVknofgEO4A77zBb6Hub8HZOiOOs/e6n6dNVdvuk+8U20zSlmPLHND1z6fbc0OK1oTuC/E23bH+UA0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634858; c=relaxed/simple;
	bh=da9JD1YJn6XSolHgifWTXwdU+nHOiT0jUp3Nb+QT4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnQ4eqertG4ZOnVAKpprtSNh1UkPVDqudlekWKJ0Q44ndoq8bk21/hXSLX3FmdCwx4HelL8cWRmsWPUJZdEpbg7WrSAsFxwNAq3amYMTFnXNkSCxSMK/tXnHQ5NXMVY/bkjj2mg2j3znHar93Izy6FejSWglnxKHan2IHR89OGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=He5hsoEj; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="He5hsoEj"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-481188b7760so834215e9.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 13:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769634855; x=1770239655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hv2y5+eHgpdbyVWkOZYtB9y4CpO1vE2yqof3Vkhxaww=;
        b=He5hsoEjHJ3rNlEimd4G9Nz/hOReLnZz/Anim93KMexVIFsPEEF3mx4EdyhGSuxnAy
         RZUslN07/7/EGmGAKDWB1Roxk70iyFf0kRwVuo3U/NoxNMxFd1qXWbDVfrLeejQ7hdOx
         yXPzmuAivA/dNIVq2nHy5UZcfPhZEuz7OiQmcz8CxYUvyR3+/OOkiJyWRJ1cgx7vLxwW
         lurD+lWu0ySEnicxereqCiCwu9b/H3u4NF5Cnc8ze+S6nJSdFp3CrFeSF37jJPd6+bhS
         w80jzm3qF1zNA8AswHHum8N56Pggka2mdNKf9SOS502wM2xboMrUUp8JHTNDDxP0fXLe
         VWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769634855; x=1770239655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hv2y5+eHgpdbyVWkOZYtB9y4CpO1vE2yqof3Vkhxaww=;
        b=CaNwJ3LiI0YvztQBzVoUPbqxnge3ixilyPAzQRvcLqfYUwcYwL7xQCaE4Q16+XSz+9
         sg/Wdsc9XK/Pcx+3nWcNImFZuwLIECGFaWPixMcC6ITr5FQfR4p5hJI1mfCLQiCALkMU
         i5noMAcSKK6KsvbFutSi1S4oSxAIsTc0iipNsPZZRXWpBfyGOt7t6zDLOpBWdV0hdKts
         CKuGZXdnJG/o/rFRPQr7FSgrz85ytC0nW3SXUYuBcvQCQKbdfOqV6gJvXWXhV+8vf5WV
         EcXhuFGHIErAN06+njeBASMcsfbLZY+jsN82VSE79HvTTjzDLrEj62E+azrcfbem74RE
         2gaA==
X-Forwarded-Encrypted: i=1; AJvYcCVKOWMHRYpCTywey65yUMcvPpQy/kChDG2l6fpSOmqDRQ27ybzJVHOeqAux7ejweilOlPytdCGUjpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmpiUD+hoXdcTp4svHc+xVkKfFm8zA9FCdE6EHXvT4Itn3O0Q
	iodM5qwFgy4Rz/AHeeRgWeVpODRLin7uVi5J5G+JwdDBZRKxcwg+scpxe6jna4aHOLA=
X-Gm-Gg: AZuq6aI++5/hFCesTxlTK+ICzAapVaP/bf+V5wwR69IPyFzj8Dw6jmtUkZ9pXrq7HiB
	Bgq6SNoigCa0l6Lk7ObSldLGY50jJ2RmXXYlQZrk0DnlPyLcFU0gTpJ0IoDGxtxUwcycXDCgTKu
	gA3hDtjJFhP1Obz1UlN1clREB8F0FuQM++DIhDXrEXU5wwVS+hug1ul/On4ztZo0Mi9jL8ESKCj
	Ztk2HTZDPfP43CZjobqo2em07QKzMrihmfSIMexJol+Y1mO9V3zJ9RFWrfSLC9nbMXIcIHjoUN2
	FVsXlNsK8ZavA56NcH4zLTBc3o0tEwpXj8iJiNncybJRAXeuu6JIB7gpVK+nwq38esWPqZA1/in
	pMvDIVE5YOaq4eVNv+GxzPo/SVcCaGpYeb7qUxzHHERbUDdkt54K8DDX3vacyEznPj6cQIoqS4H
	AEcveXsr5MKlQEnWRodHCl2noX
X-Received: by 2002:a05:600c:3b96:b0:47e:e4ff:e2ac with SMTP id 5b1f17b1804b1-48069c60317mr95974885e9.33.1769634855205;
        Wed, 28 Jan 2026 13:14:15 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354205sm10054004f8f.41.2026.01.28.13.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:14:14 -0800 (PST)
Date: Wed, 28 Jan 2026 22:14:13 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gourry@gourry.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, bingjiao@google.com
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXp8Jeaivfa79L4D@tiehlicka>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com>
 <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
 <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>
 <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
 <aXndXPMFK2fhLA4p@tiehlicka>
 <aXobeWtnJVrTmxlV@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXobeWtnJVrTmxlV@gourry-fedora-PF4VCD3F>

On Wed 28-01-26 09:21:45, Gregory Price wrote:
> On Wed, Jan 28, 2026 at 10:56:44AM +0100, Michal Hocko wrote:
> > >                 .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> > >                         __GFP_NOMEMALLOC | GFP_NOWAIT,
> > >         };
> > 
> > This will trigger kswapd so there will be background reclaim demoting
> > from those lower tiers.
> > 
> 
> given the node is full kswapd will be running, but the above line masks
> ~__GFP_RECLAIM so it's not supposed to trigger either reclaim path.

Yeah, my bad, I haven't looked carefully enough.
 
> > > Any chance you are using hugetlb on this system?  This looks like a
> > > clear bug, but it may not be what you're experiencing.
> > 
> > Hugetlb pages are not sitting on LRU lists so they are not participating
> > in the demotion.
> > 
> 
> I noted in the v4 thread (responded there too) this was the case.
> https://lore.kernel.org/linux-mm/aXksUiwYGwad5JvC@gourry-fedora-PF4VCD3F/
> 
> But since then we found another path through this code that adds
> reclaim back on as well - and i wouldn't be surprised to find more.
> 
> the bigger issue is that this fix can cause inversions in transient
> pressure situations - and in fact the current code will cause inversions
> instead of waiting for reclaim to clear out lower nodes.
> 
> The reality is this code probably needs a proper look and detangling.

Agreed!

> This has been on my back-burner for a while - i've wanted to sink the 
> actual demotion code into memory-tiers.c and provide something like:
> 
> ... mt_demote_folios(src_nid, folio_list)
> {
> 	/* apply some demotion policy here */
> }
> 
> ~Gregory

-- 
Michal Hocko
SUSE Labs
