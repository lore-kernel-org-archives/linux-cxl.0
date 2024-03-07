Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8B1D698
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709854476; cv=none; b=K1dPv17jcg5PI4AII8qjDh4Eoobo4GKYaBmBkwi2XjX0U5nriYlXAkwNRATwyZLImDdmcOuj83BUL+ehSqj+OXr5FxGe5bYE8L2EUQPtiPnANzxOpJO5YPtr7obXWfZQjxDImuMWCLMI6HIwGq8ylHP0JX8A0sjhrleouZlPFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709854476; c=relaxed/simple;
	bh=Wat+67RHqrj7NsdeUu5TWO7OomVfwqWsust5PlISLGY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toC4p7nvtTwGVDjOJ9bX5o61xchY0E37fPDcIAqn9AU/LC7/hwahXWjOszqZpcrzXvTE2o1LLQMnW86eYUuQgAZsssJNOUTgPibdyOOcsO+ynEuXzDelayMpRcmvWP9POprb8CV+f0T8+BWUgCus8lySPmSzxG6ToKB9sop04RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgE7jCwX; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgE7jCwX"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e50e97054fso243227a34.3
        for <linux-cxl@vger.kernel.org>; Thu, 07 Mar 2024 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709854474; x=1710459274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TvtzYXlBxDIQHvkk7OR+1bPqq72EzlsJeV1HC/bhQGk=;
        b=DgE7jCwXOF5GtjAFyQKeyGNWbuqYj7Mji0IzOqkryBlXltpOUT89v/soxEtLYDfr59
         M0/jQZSDCUlyy1YqSpMlreW23VWy9C+6la83RzkS7qX+ZMpJMi1rGfOzyK4L04OmtYm3
         pkyLdxZVocpmJOLcEWJ6DURNMgmTeasLte4aRLEvjA+uAeMrLaz7RxxVR1h22xPY+CFH
         gKb68xl6hl410c4XfM2FlxzMnJNe2BKIhaA0cdCiqaknvKaUiOFPXamCa0iLXYcWFk51
         9U4ok3pQAYWzEUDHURrFdnQaQ3yIfdXdIpTs/YM2nmmMOEWrC389fgBDNHC0NZ0bxViE
         2pkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709854474; x=1710459274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvtzYXlBxDIQHvkk7OR+1bPqq72EzlsJeV1HC/bhQGk=;
        b=U6l6xNcTP88UIcjW6+EmWLfErX+/WoyWl5wtxjQdNSB0TVZKFE6TK1CSC4o/NSc1uo
         R8qI7k5eG5BDEq4xRfkp+dtwR8R6QBpT3R8ELvVB2WIkfpQz6m8fVAiG2N1uZzRGcZK0
         XKudfTJjlRY7myugkQayrCQmho+l5b5eXuwP09ws1bCY0uKxgoGjTKRF4WC4zASY9S53
         mNiiJBKi86NrT99S7OIBXkoCKwzhSZWyn1y6JTEwzmGf7Jg3oS3q1WGsGzAbI7it8snv
         3RZavUNrFsx4Rex1P9/sJGIVTGXtQ1YdWu8Dea6XaeVz3rY6nYZgV2GiVM264FFcb9BG
         4Nug==
X-Forwarded-Encrypted: i=1; AJvYcCUG7MOo6kSG4NWJ077SDE2S89fmUrwRj3MDVspTbvkXWIKdemUAmFZqMFqVlbxvwFIQr1rSc8WFQ3C//FzoEfZmhcJczIsxJ0wn
X-Gm-Message-State: AOJu0Yy1GnwlOFdvSwzza38vBKfZxKsRt2+Mjxu2eWht8EDUya4gUiGi
	22g5FQWRGp7mUArTXYivrx4Mf6D4670iiCs5V+hWB1UgeK9SvgJ5
X-Google-Smtp-Source: AGHT+IH3n+2HDtXDeYfwWqHEIFObS9DfRE9bAsUrfAaSVz9lXI49vjH9TOCljpp7WUM5ovliUJEAHg==
X-Received: by 2002:a05:6830:1db5:b0:6e4:74e9:ece1 with SMTP id z21-20020a0568301db500b006e474e9ece1mr10323287oti.23.1709854474261;
        Thu, 07 Mar 2024 15:34:34 -0800 (PST)
Received: from debian ([2601:641:300:14de:a807:195f:7661:96fe])
        by smtp.gmail.com with ESMTPSA id p28-20020a631e5c000000b005d6a0b2efb3sm13021593pgm.21.2024.03.07.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:34:33 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 7 Mar 2024 15:34:18 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, gregory.price@memverge.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZepO-qfbXX7yOeIK@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-7-nifan.cxl@gmail.com>
 <20240306162816.00002e0e@Huawei.com>
 <ZejAh2O7fDBCcG-N@debian>
 <20240307121605.00002d7f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307121605.00002d7f@Huawei.com>

On Thu, Mar 07, 2024 at 12:16:05PM +0000, Jonathan Cameron wrote:
> > > > @@ -868,16 +974,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> > > >                                         AddressSpace **as,
> > > >                                         uint64_t *dpa_offset)
> > > >  {
> > > > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > > > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> > > > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> > > >  
> > > >      if (ct3d->hostvmem) {
> > > >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > > > +        vmr_size = memory_region_size(vmr);
> > > >      }
> > > >      if (ct3d->hostpmem) {
> > > >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > > > +        pmr_size = memory_region_size(pmr);
> > > > +    }
> > > > +    if (ct3d->dc.host_dc) {
> > > > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > > > +        /* Do we want dc_size to be dc_mr->size or not?? */  
> > > 
> > > Maybe - definitely don't want to leave this comment here
> > > unanswered and I think you enforce it above anyway.
> > > 
> > > So if we get here ct3d->dc.total_capacity == memory_region_size(ct3d->dc.host_dc);
> > > As such we could just not stash total_capacity at all?  
> > 
> > I cannot identify a case where these two will be different. But
> > total_capacity is referenced at quite some places, it may be nice to have
> > it so we do not need to call the function to get the value every time?
> 
> I kind of like having it via one path so that there is no confusion
> for the reader, but up to you on this one.  The function called is trivial
> (other than some magic to handle very large memory regions) so
> this is just a readability question, not a perf one.
> 
> Whatever, don't leave the question behind.  Find to have something
> that says they are always the same size if you don't get rid
> of the total_capacity representation.
> 
I will fix it.

For static capability, we have a variable static_mem_size, although we
can calculate it from volatile and non-volatile memory region size.
There are quite some places need to get the dynamic capacity, it is much
more convenient to have a variable ready to use, I will keep it for
now.

Fan
> 
> Jonathan
