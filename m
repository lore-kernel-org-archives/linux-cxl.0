Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2954748
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPl36V7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704735690; x=1736271690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkSv/QsE74FSVnrEc6oxgTm5i9BaeyS/200PtlVA7Sw=;
  b=ZPl36V7sUIIVdRp+TDCGO4je6Qq+bfjjKxBn/zLtATDTSFhE82wYeXyu
   9hpuXfXUBqwKmc5pk17nN57koWd66vsM2uiA8g/LXFIzPn2reWFBnfTgZ
   mUXJmBp2RpFeCRJoMXTYRfoCksk2b7WP+kVNvK4znFli7K4UX4bT3Pjrw
   JzSYex4fMiU7MjVoVXefRIghQVXpD2yKV6HXh8oJe4Tfy0A7+cOkLi7Bv
   lfC+hRd0vIho/wPwofberF5jWaD9nc0iasH4aqjK7BpSeutJBBou3xCG8
   bhX2VriY4Yw8nroLf/wHxYASHngY1HiqofWY7IWarr2ajQX5b6IwT+LeM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5305694"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="5305694"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 09:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="784926179"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="784926179"
Received: from kmjog-mobl.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.32.48])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 09:41:28 -0800
Date: Mon, 8 Jan 2024 09:41:26 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>, x86@kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] x86/numa: Make numa_fill_memblks() @end parameter
 exclusive
Message-ID: <ZZwzxqxJjZlsXGjG@aschofie-mobl2>
References: <20240102213206.1493733-1-alison.schofield@intel.com>
 <65949f79ef908_8dc68294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <ZZWsOxhYRAdPNNCv@aschofie-mobl2>
 <6595c10982cf_8dc6829433@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6595c10982cf_8dc6829433@dwillia2-xfh.jf.intel.com.notmuch>

On Wed, Jan 03, 2024 at 12:18:17PM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > On Tue, Jan 02, 2024 at 03:42:50PM -0800, Dan Williams wrote:
> > > 
> > > So I realize I asked for the minimal fix before a wider cleanup to
> > > 'struct numa_memblk' to use 'struct range', but I want to see some of
> > > that cleanup now. How about the below (only compile-tested) to at least
> > > convert numa_fill_memblks(), since it is new, and then circle back
> > > sometime later to move 'struct numa_memblk' to embed a 'struct range'
> > > directly? I.e. save touching legacy code for later, but fix the bug in
> > > the new code with some modernization. This also documents that
> > > numa_add_memblk() expects an inclusive argument.
> > > 
> > > Note that this would be 3 patches, the minimal logic fix as you have it
> > > without the comment changes since they become moot later, the
> > > introduction of range_overlaps() with namespace conflict fixup with the
> > > btrfs version, and using range_overlaps() to cleanup numa_fill_memblks()
> > 
> > Hi Dan,
> > 
> > Your idea to use struct range in struct numa_memblk comes as tremendous
> > relief after staring at open coded usage of start/end in numa_memblk.
> > 
> > With that acknowledged, the minimal fix to the overlap issue could be
> > either in x86 or acpi.
> 
> I don't see how it could be in acpi since there are currently
> conflicting {in,ex}clusive usages of @end numa_fill_memblk(), right?
> 

You're right

> I.e.:
> ...
> start < bi->end && end >= bi->start)
> ...
> blk[count - 1]->end = max(blk[count - 1]->end, end);
> 
> > We're at x86 because we wanted to be 'like'
> > numa_add_memblks(). A partial cleanup now makes numa_fill_memblks()
> > diverge further.
> 
> Yes, but numa_add_memblks() parity is not necessarily a virtue, however
> memblock (with an 'o') parity might be, see below:
> 
> >  And, to avoid the partial cleanup from being throw-away work, it
> >  seems we'd want to define the full cleanup ahead of time.
> 
> Are you referring to throwing away this cleanup work for the eventual
> memblock conversion, then yes, I agree, if this is just talking about
> the numa_memblk with 'struct range' conversion, then I disagree.
> 
> > Also recall that we have a bigger hope of replacing this whole
> > numa memblk usage with the "Memblock" (with an 'o') API.
> 
> 2 wrinkles here...
> 
> 1/ From a practical standpoint is anyone actively working on this? I
>    would definitely stand down from the numa_memblk conversion in favor of
>    memblock, but it has been years since this idea was floated, and I doubt
>    it shows up anytime soon. However, "be more like memblock" is a good
>    idea.
> 
> 2/ memblock appears to be doing inclusive range math, which shoots holes
>    in my position that numa_add_memblk() is an anti-pattern that merits
>    conversion. I.e. "be more like memblock" contra-indicates a 'struct
>    range' conversion.
> 
> > Maybe I need clarification on what you are suggesting wrt 3 patches?
> > Are you saying you would not merge the minimal fix unless the partial
> > clean up patches are included in the same set?
> 
> I think your memblock observation points to a third way. Lets uplevel
> and steal memblock_addrs_overlap() and use it for this broken
> comparison. That nods to an eventual full memblock conversion and keeps
> the inclusive math status quo in memblock and numa_memblk related code.
> 

Thanks for calling my attention to the available memblock helper.  
I went ahead and used memblock_addrs_overlap() for the comparison
and verified that it fixes the case where an existing memblk is
extended rather than creating a new node and memblock. It actually
is not clear how that relates to what the user reported: numa init
failure due to nodes overlapping, so I'm holding off rev'ing this
patch until that user reported failure is understood.

> > Also, is this something that has to be merged through x86 or might
> > you be able to take it though cxl tree? Yes, that's me worrying 
> > about the review and intake burden this puts on x86.
> 
> I can always merge things through cxl.git with an x86 Acked-by, or a
> "holler if you don't want this to go through cxl.git" approach. Lets
> keep maintainer busy-ness concerns separate from where the best long
> term place for the changes to land.

Got it.
