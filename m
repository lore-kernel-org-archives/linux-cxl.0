Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B52D320E
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751356; cv=none; b=qCPoExvHwdXkGr5Iv/tBu7tIhqR6HYpQX3efWvt6f6FodxH60nIXtf1awkUSmls7yjrUadwgTkPffqzyaYP+AiOvaM5J8TcmVKK/SLhA45jUDoFrjOSkg2FVlJNRUf/4CFjhYKV9MmVirAph59RwjTEx2FNsQAPt93ej+lRgpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751356; c=relaxed/simple;
	bh=S7r59/PIWkoTLIG07/E/jEWrNmZtWKxEaHN/jiSuqUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESXpoEvqf9R9q2Jgpwoy2E1CmRZm0rfJr8l/inKlWOlgcCYZpLefIvve08ea1WefzBOwlEGqZtKck8ps75R4hgmVXDR20dFpdyVmbgyxvE5pgqqFkJNFmRPiSaih8/xlzC9khSc1AIfrslLJYpA0ByK6T5tftcSYgTb8K223GhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WaeDzmsz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WaeDzmsz"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a6f6d52af7so14477481cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749751354; x=1750356154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Men1Nv7TOAnztTuH0H3iBJJYmyP24ktCmwcSSGXFev0=;
        b=WaeDzmszRAUHVlAnIJEbJ8onMxOApOo0ScZYPiD9U0sp4i3kGK4rR/wYq+9q600hWi
         wwzNvXI6cE4z5jBOlKo2j0HbxaFj/R71YuKgrBw+NfVyeOR+TR16XxiQxVXE8dvaVp/p
         s/IY5ogw+cSZIRwmoC+SblvVqFzsXTA2f+iQM/xxQIFd8VtLm9iNWA+U4Q9Bwr6tuEZe
         yr1cPg4emPNKyRbubdbNi506auJDQuA7+eoACeDY19e0kvrBU1sf9FfQu8S4yaMv67Z2
         upL/OSFmI95stNikn9VNvWK+5oZmJuyEUpkBqK7r12a7+7Ntinde/HcjV+8vOuMidkEZ
         LgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749751354; x=1750356154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Men1Nv7TOAnztTuH0H3iBJJYmyP24ktCmwcSSGXFev0=;
        b=anFxOtqFUuWAR+GWPVWluibPHwf0fB7Cr/v9Hw2OAO3/kBXsVkzzhP3yDacsWJbDXM
         6mom6q+nQKXCjKZqgzydnxg+1p361woUUviC7WWn8Kk0aPz3EQOQUgcuMtdJH9FMXI1l
         qzfcLS3CHNDy/bQbZvuq4rZa2VGbUoEU5+Je5mh2bFaVtqiyeZZ3JmDydN8TJirxDrNr
         5ekTip9V1K98SKC6YTGZIU/oKVrvIcVYcp4KJ+Sdi6YkIvLlbBEJD0FQ95wwzQq4QkYm
         8mrEbFGbwteWGqJY+MrjpTKDq8jzyTaAzrZlX0CC4oPy2EFKroiq46shjcAx2mwTloFK
         Bazw==
X-Forwarded-Encrypted: i=1; AJvYcCUSutk1GPxpa8ngA0Vw92ei6IQ4huEyTTcCjpwCbhvc0wjgH4pzfbzr8EvYgJGycbDckI6D9s40rdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZYBXmkdEROi158YvFrbgL0suWX40PI/4V+77KYdJgVqsXjEN
	qUgxIrO/cF7XPAd6VC7LSPORrB/ZdSvFDxLr7cr5exB3HKUaoTMyPERM0XSYhYmYh6I=
X-Gm-Gg: ASbGnct8V6idec0oTcJLGC01vkrlvjYBal7ejOuIhAlRhuSfp7reFdP+2vpxENlrrLw
	ESw4fmYO6MHYfD64v0XbknLmUXL7EOeWc3gzbq6e2xQCp60Pk0IR9mCI3jFp8/O7N7iTrABwl2G
	w7pUkzy7OIBoJCHRnAzjeKYa/numMGr1Q502mfh6E8NPfscOFprmAT5s8SnzhGo9h7Xq+rE1Z6/
	DjQ9TxSqaQv811TzH2PkY7wvsQDLwDrY7qqOsdy45/fT0peocrCGWUiYqHqhLDf8yRaswX6ERYC
	+Ka4BbzVezj9fyMaaPJnnlSVWmLOQt6n3bBcuoXjMm2r2b4vZuU0ljVT80FuM58ahy2I/P+qTF7
	UFIHfsAxVX3yZi9vX1hESQaxXtr4ONwQY4lJmuA==
X-Google-Smtp-Source: AGHT+IF2gHZ0WFh5VXAMyx6YiN8EJ/UWCFphfLEXmh1c3StoJxVby1YEDKi6l0heE4IvQIvOlyk6VA==
X-Received: by 2002:a05:622a:1f91:b0:4a4:3079:55e7 with SMTP id d75a77b69052e-4a72fe7a666mr2315081cf.17.1749751353871;
        Thu, 12 Jun 2025 11:02:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a4b0cb9sm6750981cf.50.2025.06.12.11.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 11:02:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uPmG0-00000004kgF-3F9r;
	Thu, 12 Jun 2025 15:02:32 -0300
Date: Thu, 12 Jun 2025 15:02:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/3] mm/huge_memory: don't mark refcounted folios
 special in vmf_insert_folio_pmd()
Message-ID: <20250612180232.GB1130869@ziepe.ca>
References: <20250611120654.545963-1-david@redhat.com>
 <20250611120654.545963-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611120654.545963-3-david@redhat.com>

On Wed, Jun 11, 2025 at 02:06:53PM +0200, David Hildenbrand wrote:
> Marking PMDs that map a "normal" refcounted folios as special is
> against our rules documented for vm_normal_page().
> 
> Fortunately, there are not that many pmd_special() check that can be
> mislead, and most vm_normal_page_pmd()/vm_normal_folio_pmd() users that
> would get this wrong right now are rather harmless: e.g., none so far
> bases decisions whether to grab a folio reference on that decision.
> 
> Well, and GUP-fast will fallback to GUP-slow. All in all, so far no big
> implications as it seems.
> 
> Getting this right will get more important as we use
> folio_normal_page_pmd() in more places.
> 
> Fix it by teaching insert_pfn_pmd() to properly handle folios and
> pfns -- moving refcount/mapcount/etc handling in there, renaming it to
> insert_pmd(), and distinguishing between both cases using a new simple
> "struct folio_or_pfn" structure.
> 
> Use folio_mk_pmd() to create a pmd for a folio cleanly.
> 
> Fixes: 6c88f72691f8 ("mm/huge_memory: add vmf_insert_folio_pmd()")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 58 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 39 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
