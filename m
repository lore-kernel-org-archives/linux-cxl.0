Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCBB2D0267
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749751374; cv=none; b=XoBF8YHYPHkqYtjSoPObLVe011GEnH0zvH84038yFs/r7AU13iD0nZyNIU322ENmEhBBCZmXhjGkzYkQ+GxTJxhbPyQ9L1/8isUFCyrhw7Ib53f5/8/upH/e9h6wbJDUqfqmEu+ipCmrt2VxOm8tFIcLV54yZgEUMPCucoZM6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749751374; c=relaxed/simple;
	bh=7xWw5aJLm8rN49o70JV7Et+XL03bPweLX55FIjhoBWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjLZ+MGJTLDKQWen1mRtyUZBuRtpLi/Rhrj+q9p/qpLp+vtr+JHWJq837yn8y76o6qIH4LwhNKGXWykHayABQXUVfA3mIsgsajt2txHClEXt7p8I43Dob/X/DFMPkHYU12yMK2X1h62ztgt+51PVJVeDrGS8TyIbqn9okKV5Lcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SHQUsczu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SHQUsczu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d0a2220fb0so144995685a.3
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 11:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1749751371; x=1750356171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDDRWPX1lH08t+vNjXng50l3/jIs9pZf702xFyzNrfY=;
        b=SHQUsczuWm3agl6woZtp5CzhI7/hEvYO/lqDw70+mtT+2jgiku0xpGdC2XGyFTdiNY
         h4m/rihWjDzqeFqTygtJsjrTbLIgVc2oWUdkcrr7ixISuPE6IWe7rynrg+xfzMo18k/A
         c4vIlJLWRVpVTtyJ5TpLHCoh1ETzUp7EW+n/8K3wcszxUQJ6KNlse89xi/AFh0tXl7G2
         lR6fuSupVMvMvwpHei0L6VE7O3Fm17HcKOWOAuCOii4/lzYuX4UmS/+/zNzQDqtowlbY
         CUPbEigeyT+6uW+JOJd9PB2F7dNmvze8S5qlSbaplW8dAJQ+PNarM3DTxXeo7gkd9tW7
         s3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749751371; x=1750356171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDDRWPX1lH08t+vNjXng50l3/jIs9pZf702xFyzNrfY=;
        b=VsJgVCxdpRvabIq6NFGUXTKOGRkk6ELPiAAz7VvxBldRQiU3TD6zj3lQHsHBP1LEQB
         P7FK1QOT3ZcFhxPEZinE8/JaSiiqEx3IZXFUJFvChPd3TJm4f/u0qM8w0WlpLzBsG1q9
         tkwc/9Zcx21PlBbs1QUQ0DdMA3X8VTGcwDIgtD7p2Bdo781WfSb9KbOKWpn6+kzBfsrt
         UR49wZ3ha7LYNDPNgmoRKii3dGOqme3wXCS44SCvdpXHs3il5gTDs2FeAH6jrzmxJx3k
         fdap4sSG7aoYvB7dTW4qRIKjDV9gKO51J+FxAc4ju3nOskSDGVrajk5QUGOSpV4AuInn
         cJuA==
X-Forwarded-Encrypted: i=1; AJvYcCVAVcZtaYdOWfjHAILe/FTk0VIkAocTKxl3XYWNqC0KEyMeEP6upmgpZkUIqgmh+oQIjS8mm6lDguk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gI9zswvR/u7WZLfdf/mpAYb51oAbkpam837hq5QsLigpUdm0
	OOfJLpnZX0FocvA9HlOtQDMPLRWtEfalA9AUq12Kwmqyy7ij1qnuZvcUKguPUE9uFs4HFWwh2Gi
	B7bSs
X-Gm-Gg: ASbGncv8/ag2IK1KC9SlEDH2b/EzJfivnYmGs8SmUUV/kJGpKlgpyS/MeJ7LJQIAR6s
	/sV+KLfbH9Bi78gf+cbSUSfgRcGQ7NeQZrkejJCVfo6GQ2k15s7NodZ2cEXxU6Rm1nLI7cTRFFz
	5XONW7C86yGNVcGzJotWr9wFbjFSzt4gth7k51bdnyIOfMwROKaf07lAdbl4GLvuJ9Yrkcaq/fM
	g95F7LIN5xYUlbTVkD0AYApEPrEZwh+76NQysOALFyBECSfJ5iY6g3RpdtmVUaY1muuHiT4dOyN
	7NENSWy6vhqQJVfRVJzU0tTkzVYfCsJS5pzom7HR8aCYezdzpyoSeWvW1PPeODwvbJuru6czY0p
	EORustv93IQbgHqpimQMphLZDXQfE6svTcOE9AA==
X-Google-Smtp-Source: AGHT+IErLirqZ/IjWI/XgEsozLii1/UP6Pds6ZK0pCCFWbV1P+4pjEqskuPc1d9m/qNp3cmq3DvELw==
X-Received: by 2002:a05:6214:e86:b0:6fa:d95d:d0b1 with SMTP id 6a1803df08f44-6fb3d2b2155mr7744516d6.24.1749751371067;
        Thu, 12 Jun 2025 11:02:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c8ee5fsm12595756d6.122.2025.06.12.11.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 11:02:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uPmGI-00000004kgd-0Li5;
	Thu, 12 Jun 2025 15:02:50 -0300
Date: Thu, 12 Jun 2025 15:02:50 -0300
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
Subject: Re: [PATCH v2 3/3] mm/huge_memory: don't mark refcounted folios
 special in vmf_insert_folio_pud()
Message-ID: <20250612180250.GC1130869@ziepe.ca>
References: <20250611120654.545963-1-david@redhat.com>
 <20250611120654.545963-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611120654.545963-4-david@redhat.com>

On Wed, Jun 11, 2025 at 02:06:54PM +0200, David Hildenbrand wrote:
> Marking PUDs that map a "normal" refcounted folios as special is
> against our rules documented for vm_normal_page().
> 
> Fortunately, there are not that many pud_special() check that can be
> mislead and are right now rather harmless: e.g., none so far
> bases decisions whether to grab a folio reference on that decision.
> 
> Well, and GUP-fast will fallback to GUP-slow. All in all, so far no big
> implications as it seems.
> 
> Getting this right will get more important as we introduce
> folio_normal_page_pud() and start using it in more place where we
> currently special-case based on other VMA flags.
> 
> Fix it just like we fixed vmf_insert_folio_pmd().
> 
> Add folio_mk_pud() to mimic what we do with folio_mk_pmd().
> 
> Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mm.h | 19 ++++++++++++++++-
>  mm/huge_memory.c   | 51 +++++++++++++++++++++++++---------------------
>  2 files changed, 46 insertions(+), 24 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
