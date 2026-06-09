Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203A47DD6C
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019351; cv=none; b=k4ApVbwLWabKeR/IKeYDKzv++kPRLvJEly4YTMABVU1Ndw23oq2JVLnz3kxhZJeCKiB5TBdvM92P4PZGAD09SCAUhl5NOJxz0GGNyKtaLz8t53rl3+ROScaufWeoxG+g45EriS/25TJFClLOtqhTaMENgh+6ixRV3gi7r0r6YIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019351; c=relaxed/simple;
	bh=/TgtOuaONvsUnR+aXOPnuRF8ZAqdZP8tr7TwdKuIOt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrVEKByVy+j78rmMmjv3JynhfHJkTXzTpuGoXBY7j1MDcq/ZSo2UtfTs9LqQKqG3jDz+KDTSAFYOU7Iulcu6+yMEHMVwlYoeaC6gZc6naMDNJg+0oUXnesbL3+v+pzfEECWXH5JYRbpM2y8jdOktYfKCAvVVLbhvh+20U+mxpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j576Jndo; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j576Jndo"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9156b74006aso411970885a.0
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781019349; x=1781624149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fMNVrJ+zylUZaoWsNGMkq8FYpb2q8Its7Sc70f0OoMM=;
        b=j576JndoQRbFIwumnPu2agxfJTry9gN3fd65VC3AxO6na6iEv2DVDWijxUmR2wpLme
         EcozNL+7l1PsxsSJcKgwrJeIrVVlsd8htTKxY5UiJrai+IYyjjBiH0WOmYoa98bpLlhD
         Lk7xBVgMuTbNv84+leerCaS2ruXmo9RiR5wGfemDasCJ8tfGuyDHpP27D1m9STYO2l1g
         mjyQbInRQcq+I0hFXL2nzCp0TVBXMInEuLKbaktsz5JWGPXn5unH4q7zBhQAFRN/qe3+
         2tOLCvVtqY5+8S+lj9UF744BrkKLfWWkXBy+M147GFsNR2rzE0a41gCEJdlzQF+9rTcY
         pETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019349; x=1781624149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMNVrJ+zylUZaoWsNGMkq8FYpb2q8Its7Sc70f0OoMM=;
        b=P1AM+tm7uszVoXGQmQQJ9PNc1UqaN/iqfsvSsJJGGVV0NqLRJ4QZTx/0Qtr0ZN3FmC
         uFyGDN+0nndpxTLBrsQSddIQbc7ft4BW7AkniLUD8uwrFN/RwWYdi4xovDW34fuPqHNO
         ajnaIoDVl8Eo698q4jBcTUn6OamHYYL4MzzKwk1mpMFYxM7its95/xtYtUQeLSUA0BfP
         jHT8klsZY6ggbE23MK05cCFgzMwArzkrNuMHvK2fOJdWTjNpT9R8YP6S1T/z69kzWFMn
         5gWuXH+8tozlFyqbaHv+XRAv1JG9h1LqMZguO5TDZX3orJ6sAssbKeg+FfP/W/SKff0b
         Z+Hw==
X-Forwarded-Encrypted: i=1; AFNElJ/dUqSfT/sx9IRfjSDVpJDn/ZXizgbI/7UTW/xJegynoPC7EG59oxDOQwXa1bX242kCfQpNdONwHS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGFxxYdVyeWrUvCFzK7WeBjWTVwX0e3Nra5VKXFKUKjrk6+2P
	BpJ41obgb73NCmeJw7pL1OnmahrLd9Kt5ggro2qB6s2pPjtbrmFGRSBE2an40Ym5eEc=
X-Gm-Gg: Acq92OFR/CM887gmTJ0aC2lIpz06B9fbsfkUtKP0Nh8hvnAWf48liuQBSQPERGH4DdJ
	WumcGToDnIqsWVd44Q1xE8cf828nYe/yf87XPY0S8a3/HwnHg12fjuA2uvzVWoLvzUuFJ9mM0IG
	tOqxJrnynzG8XvW1U93tfpRxNVO4pv98uADotescZTlCrfeM3KSiYEUgAihGgx4IEZ5qvgMXnk6
	1iQbPJHaM+Kz0CM3l+/ZwRZYBHqSHwAfdu2AcT947/icbdgGK87OxuLAGO8wwypWDcqX9lFcYq/
	h0WYvZUa5XN7sruFAqjJZftycLldWrGOfHac4FrZSQspgJMn8HNh9cGOhEipUmrYCe5ggLSuSTO
	yxp9J4I7yDO1oBWwK0oiyyMoqMsw4QBKVT5YY+QeMefscdIC52hzx2LcEamBxxkhmwMW0HmnlLQ
	/JbW0VgYyAxhrADfkbiNfoq7BeHVF8xji4nDjZz57vq/jPVUqdL09glzIXzwHe9IecbZWdMgEjK
	0MTGLQQGdjtKEeFAQ==
X-Received: by 2002:a05:620a:454b:b0:915:7732:ea7c with SMTP id af79cd13be357-915a9da3801mr3475555585a.43.1781019349028;
        Tue, 09 Jun 2026 08:35:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3bf5f9sm2173658385a.35.2026.06.09.08.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:35:48 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:35:46 -0400
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	linux-cxl@vger.kernel.org, linux-kselftest@vger.kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
	akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, osalvador@suse.de, shuah@kernel.org,
	alison.schofield@intel.com, Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com, apopple@nvidia.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 8/9] dax/kmem: add sysfs interface for atomic hotplug
Message-ID: <aigy0ut410TItkgB@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-1-gourry@gourry.net>
 <20260605211911.2160954-9-gourry@gourry.net>
 <1cb0514b-c753-411e-8ff8-80fa29837441@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cb0514b-c753-411e-8ff8-80fa29837441@kernel.org>

On Tue, Jun 09, 2026 at 12:26:07PM +0200, David Hildenbrand (Arm) wrote:
> On 6/5/26 23:19, Gregory Price wrote:
> 
> >  
> > +static int dax_kmem_parse_state(const char *buf)
> > +{
> > +	if (sysfs_streq(buf, "unplugged"))
> > +		return DAX_KMEM_UNPLUGGED;
> > +	if (sysfs_streq(buf, "online"))
> > +		return MMOP_ONLINE;
> > +	if (sysfs_streq(buf, "online_kernel"))
> > +		return MMOP_ONLINE_KERNEL;
> > +	if (sysfs_streq(buf, "online_movable"))
> > +		return MMOP_ONLINE_MOVABLE;
> > +	return -EINVAL;
> 
> Should we try making use of mhp_online_type_from_str()/online_type_to_str()
> [possibly a nicer exported function for the latter] to avoid duplicating this ...
> 

In patch 6 response i point out adding MMOP_UNPLUGGED

If we add MMOP_UNPLUGGED as a state that is only use by callers of
memory hotplug to represent the current state - but not as a valid input
to memory_hotplug.c - then we can simply this as you request.

Although we'll need to add a couple lines to memoryN/state parsing code
to disallow MMOP_UNPLUGGED as a valid input (otherwise you could
permanently unplug memory without the ability to get it back... unless
you want that?  Seems useless to me.)

~Gregory
