Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8743AB5
	for <linux-cxl@vger.kernel.org>; Wed, 27 Dec 2023 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3duQJcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703717073; x=1735253073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yDD5ot/ndT53lIjprT129BXjMQESTYTACf1od2eA2gQ=;
  b=m3duQJcEQmXCcHHjw0B27gSiE5JHrrlKUPRhzj4EneNCiH9QS9EFXFRG
   e2RKn3Cv4s027jLJ0IzIDuVJeLKWqeewYSKpGemaVMQplQb1kYcJGVT4A
   HYHChOQ/+l920pOVJplzpdVmq9GtRFLM9V2F7Rizcxth56Y32h1TulBa9
   jkfPwRctXJGPW9Iab8QgslY1Rf6qikhUNTihLAoRZJMTQCB4x8gb2dApw
   ClNErGHsQ6qUT/SKg96V/bcuDjrS6pfxktlSZpUVUT3nrBfuyvwQja9u4
   YP0PHI6mC2OV+eF/Y6KA6fp1uzgQ575S2PTJmiahqY8/WBtRkflS3dPfk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="18052357"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="18052357"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 14:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="771545360"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="771545360"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.229.210])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 14:44:30 -0800
Date: Wed, 27 Dec 2023 14:44:29 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] ACPI: NUMA: Fix overlap when extending memblks to fill
 CFMWS
Message-ID: <ZYyozZcK9g4JE11B@aschofie-mobl2>
References: <20231223000025.1401076-1-alison.schofield@intel.com>
 <87sf3rf4ci.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf3rf4ci.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Mon, Dec 25, 2023 at 09:39:09AM +0800, Huang, Ying wrote:
> <alison.schofield@intel.com> writes:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > When the BIOS only partially describes a CFMWS Window in the SRAT
> > the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> > to fill the entire CFMWS Window, thereby applying the proximity domain
> > to the entire CFMWS.
> >
> > The calculation of the memblks to fill has an off-by-one error, that
> > causes numa_init to fail when it sees the overlap:
> >
> > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> > [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> > [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x100000000-0x1ffffffffff]
> >
> > Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
> >
> > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/acpi/numa/srat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 12f330b0eac0..b99062f7c412 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  
> >  	cfmws = (struct acpi_cedt_cfmws *)header;
> >  	start = cfmws->base_hpa;
> > -	end = cfmws->base_hpa + cfmws->window_size;
> > +	end = cfmws->base_hpa + cfmws->window_size - 1;
> 
> IIUC, this makes end inclusive instead of exclusive.  That is, from
> "[start, end)" to "[start, end]".  Am I right?

You are right.

numa_fill_memblks() is confusing. It's kernel doc comments says
end is inclusive, then in-code comments that end is exclusive,
and then it fails to handle the exclusive case correctly.

I think this change in numa_fill_memblks() that you suggested
(off-list) is the right way to go:

>> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
>> index c01c5506fd4a..3850ba23fa90 100644
>> --- a/arch/x86/mm/numa.c
>> +++ b/arch/x86/mm/numa.c
>> @@ -1007,7 +1007,7 @@ int __init numa_fill_memblks(u64 start, u64 end)
>>         for (int i = 0; i < mi->nr_blks; i++) {
>>                 struct numa_memblk *bi = &mi->blk[i];
>> 
>> -               if (start < bi->end && end >= bi->start) {
>> +               if (start < bi->end && end > bi->start) {
>>                         blk[count] = &mi->blk[i];
>>                         count++;
>>                 }
>> 

I'll also clean up the in code & kernel doc comments.

Thanks for the catch!
Alison

> 
> If so, later in the function, "numa_add_memblk(node, start, end)" is
> called, where "end" is expected to be exclusive.  And I think that it's
> better to make the parameter "end" of numa_fill_memblks() consistent
> with other numa_memblk family functions, that is, exclusive.
> 
Agree.

> >  	/*
> >  	 * The SRAT may have already described NUMA details for all,
> >
> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> 
> --
> Best Regards,
> Huang, Ying
