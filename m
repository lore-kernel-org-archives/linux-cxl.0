Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70600A28
	for <linux-cxl@vger.kernel.org>; Sat, 13 Jan 2024 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJILVbDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705106105; x=1736642105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y7H5ydcUTIMvmzTfdweAeKPGyHI9KUBsDsNfrddM78k=;
  b=oJILVbDAEq80fMws8C2MkJGfDgbXo2f8b+YdVV36xxkEXv004/vtFkip
   qfnfWy+tIefO4GB2pNpYAlQJlscdSY1csnTzokTHZWhufbvmaeZxVBq6w
   9wonIaCvP7njCb6h2vfKp5sRjdigODJ6NKTquUiUaTJqr1z78KbmV+RMB
   MiLs7zxIJFAWZ2Pg1e6MtIJSgaA6c3IgM+i7oodPc71bxKhz0mSqhetG9
   fZHJNd9XSNe7Q1RUbhhz5MXPRAcHHr7iZMZH6tEPF3kQPHJwjn2E700xv
   mlK5iNcgkxqhlN5MCSfPmYC6ov2a5uIy3Ekh2dJVrDTbD9W5F0aIWzr7N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="12690946"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="12690946"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 16:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="902145759"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="902145759"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.99])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 16:35:03 -0800
Date: Fri, 12 Jan 2024 16:35:02 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/numa: Fix the sort compare func used in
 numa_fill_memblks()
Message-ID: <ZaHatrJJc8MqtBHP@aschofie-mobl2>
References: <cover.1705085543.git.alison.schofield@intel.com>
 <99dcb3ae87e04995e9f293f6158dc8fa0749a487.1705085543.git.alison.schofield@intel.com>
 <65a1bb13f0262_3b8e29483@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a1bb13f0262_3b8e29483@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Jan 12, 2024 at 02:20:04PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The compare function used to sort memblks into starting address
> > order fails when the result of its u64 address subtraction gets
> > truncated to an int upon return.
> > 
> > The impact of the bad sort is that memblks will be filled out
> > incorrectly. Depending on the set of memblks, a user may see no
> > errors at all but still have a bad fill, or see messages reporting
> > a node overlap that leads to numa init failure:
> > 
> > [] node 0 [mem: ] overlaps with node 1 [mem: ]
> > [] No NUMA configuration found
> > 
> > Replace with a comparison that can only result in: 1, 0, -1.
> 
> Good eye!
> 
> > Fixes: 8f012db27c95 ("x86/numa: Introduce numa_fill_memblks()")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  arch/x86/mm/numa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 8ada9bbfad58..65e9a6e391c0 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -934,7 +934,7 @@ static int __init cmp_memblk(const void *a, const void *b)
> >  	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> >  	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
> >  
> > -	return ma->start - mb->start;
> > +	return (ma->start > mb->start) - (ma->start < mb->start);
> 
> Maybe just do the less clever but obviously correct thing like 
> other unsigned compares like ktime_compare():
> 
>     if (ma->start > mb->start)
>         return 1;
>     if (ma->start < mb->start)
>         return -1;
>     return 0;
> 
> ...but otherwise this looks good to me.

During the upstream march of the original set, I oversimplified and
broke. For this fix, I surveyed the sort compare funcs and lifted this
simple method from commit: 4ac19ead0dfb ("kvm: x86/pmu: Fix the compare
function used by the pmu event filter"). 

Let me see what else I get to trigger a v2.

Thanks for the review!

