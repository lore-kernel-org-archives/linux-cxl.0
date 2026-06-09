Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7A35E1B3
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017918; cv=none; b=XOm/icBn2Sp892Vvy2Vd6KsogjwRlsgNd/W+jFYNiru/ghs1gqqhauGvY1vW8eLZLuW0y3H3GR8VyArawCy+i+d9XgiinElVwwW5SivVOphMmesgGDT5ZypIlQPdURJzgqp2IAXqJINH+VS0aIJDxc7xLufBVlXDaFe7Z1r2iwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017918; c=relaxed/simple;
	bh=2N6jjPNXS8KHkA9ELWAn9DU9QeobkpuL9vsk9iqxtB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl8tyeWEd8yR7uLznNgpTBw7z2yXZppwF2ZsmvQeUAWOvXEsC8MzKulRHm4JYARHkmTAGfVNBP9vpz5iAIW+llFV5olZyqkbmZUKYxTso4t+etm84KTXSkJ73nmuqpk/tdIVfQKgWzhZrykTQyrO2lE1wU/cBVtGs/vsUWMr7sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oMeq8jxa; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oMeq8jxa"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9157d3f2098so676016285a.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jun 2026 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1781017914; x=1781622714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHWQ15ZRzqnNTI4yBH6/uoHMgLXFxEcxAiVyb8DKfs=;
        b=oMeq8jxaYTIDpX3677iVIffpL40PQNwhQC7oEKFTbUgV/TAGmjp+dKmA2i9Y1OEU+W
         +L5JoR7wHQANPUBf4lwWVMnVQ2ZQfmcoIkvi3LjOGsJmoXjzhjZDPgsqpou153P9dwr7
         s8sXGynBp+/1JTpDDk2vp+seRzQW3Jlu2NQcOKaUQTnKAwBHlNoRzUmIUDYjMKf3/SD2
         fGqigpEZNr2XHtbL3ta40r4OMWst3qoDJdJX0HEcGeHXEjgVWJQuaKS/UjKSBNR0xKn7
         DRyQLE36k1OG9Vo9eJ41OuCvtYV0yI4ESwHOGUL/aTY8AQo2CQIevQZQHitKSKxBA7+e
         Vwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781017914; x=1781622714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JHWQ15ZRzqnNTI4yBH6/uoHMgLXFxEcxAiVyb8DKfs=;
        b=dgFDgs0YM1mG/hXJGYkxHTcEWv14kaKIfH5oCsiysaf7rTVTEMBs2cKu0hxoPhNE3u
         CrBPfgpUY4QM7fN7PD8zCsQLPjGVnt1y3CdDFyRnloh06xtg4KqQ1/UZY8HBuP5vSj9E
         Clzm9IEZlwr5dlMCd0bnNpC6E4RFEd8vldQF4/CPIOcuI+dDbEb7LmfALJx4NdfbLZqK
         3oylTMOpBCp6HT6YqJn0unPKPHuhM2spQDmGGTJc/2Dyb8fRRnNbG+mXPcsLjquf7VQ5
         N9MydYXa3WYR4HOs1mTOWMelocSm1hu9/EhbKBXIm7ypQh+P1lttKZvYZSDcVxx8b5ni
         ZoQA==
X-Forwarded-Encrypted: i=1; AFNElJ8Pf9pgyUb24lYj3gYssXHE9i48FWoOLD164jlKuBos+vFI4m5cxA7dIds/NyK6dqF52RAjCYL++fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUln7ywqanXopmW41NnKHtll2NrDQ65kCemUe6GY4V2chtA1h
	2RZHmHYjzOXvsOVDsac+drN0j+7N560SkOhwMKgFNDe0Aww4m7WWBf+18VEyMtmrTOc=
X-Gm-Gg: Acq92OHzq4rGzMalA0Cq3fCYgOLCfJqWCy22jdVZO41mx5rsxr+P5I3WwEhpOe4bZOU
	CqSb7uigk5oh0x+y5BMUEO81kWwCCPlKx5RvwW+F3iZ7eEotrUA++zEkXCbifWyqz1tI6T53xeK
	c/FOHuvNL+22eLl7mt/5VA9u2d+JYv24scMF8EmlWJRpInsnXfBd3HQDm8Wmzwq5Vt3zoFjnOi2
	Pult6iikAy2H/EU+ln5ULNtmYSp13t64tCXHiz8UW6L7D6KWN/JeyELWIlh3nVpyhWep4ZN9QKA
	bEqvlTXyoRMvKlwvbLj6ScBcbweOWtngt16qC2yS1r0cHI1LuUa3pMxGK+WbT7rR0qjQPUPs1MX
	mWfkRJouxhekMivxLdr3q/zMTCsmKC5otbOBlokgQewM2eETmx2ZvUIxvzYbkxmUXsLIj3Cd+eP
	akTSnQoZoDlE945gVIwu4+/jaoWpfRmzfB6q9VzopdqvKbHBuzRLR8qMxW66lbZAcUSNLtGvJLS
	GU3jVtWYNr4tIWJTA==
X-Received: by 2002:a05:620a:4546:b0:915:cf88:1e3b with SMTP id af79cd13be357-915cf882096mr1578753385a.47.1781017914136;
        Tue, 09 Jun 2026 08:11:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm2207058485a.16.2026.06.09.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:11:53 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:11:51 -0400
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
	ira.weiny@intel.com, apopple@nvidia.com
Subject: Re: [PATCH v4 3/9] mm/memory_hotplug: export
 mhp_get_default_online_type
Message-ID: <aigtN28XUvHyCSkG@gourry-fedora-PF4VCD3F>
References: <20260605211911.2160954-1-gourry@gourry.net>
 <20260605211911.2160954-4-gourry@gourry.net>
 <eaea4aac-fcba-4f83-99dd-f8289e5556c0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaea4aac-fcba-4f83-99dd-f8289e5556c0@kernel.org>

On Tue, Jun 09, 2026 at 11:52:21AM +0200, David Hildenbrand (Arm) wrote:
> On 6/5/26 23:19, Gregory Price wrote:
> > Drivers which may pass hotplug policy down to DAX need MMOP_ symbols
> > and the mhp_get_default_online_type function for hotplug use cases.
> > 
> > Some drivers (cxl) co-mingle their hotplug and devdax use-cases into
> > the same driver code, and chose the dax_kmem path as the default driver
> > path - making it difficult to require hotplug as a predicate to building
> > the overall driver (it may break other non-hotplug use-cases).
> > 
> > Export mhp_get_default_online_type function to allow these drivers to
> > build when hotplug is disabled and still use the DAX use case.
> > 
> > In the built-out case we simply return MMOP_OFFLINE as it's
> 
> Ah, you mean without CONFIG_MEMORY_HOTPLUG
> 

Yeah i'll update the commit message, thanks!

> > non-destructive.  The internal function can never return -1 either,
> > so we choose this to allow for defining the function with 'enum mmop'.
> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David
