Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DD2E040D
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211518; cv=none; b=ij0sP4dTh2yqKqMfnGmLssqnSd2tNmRqn3YLoky+6GPUGvATlGE7qHt68CxB5yxRHC8eflT2ol6B5KQ+7YQWaYIN2O1SsattTwTiRDBYxSXa0IcX4fYpeyBrBKCpfNXdM+SL5LCUqfEkfp5sxmBbkEVGrvK5OoyjHb0V6+IBFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211518; c=relaxed/simple;
	bh=NaAnJBt/azjCgFybHoLP/OgKlqakTmdm0UAaoO+iGUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1rgTF9eyjZ9c5L3xWDdD74bejZr9o3o1mIEON03YMSKMwIJYg3PZgZxSpF8FZYjq3JO1fsBdI+a9/ubsVl7pAX7WJhJi9LeZ9Yqh2KD+us2QxZixYqZO7QxRvQ45pftNdBpL/ysUHTs6Z+q+Df0Pm1F8w0h9YONI67M7VQ4nBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7iPH7+Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7iPH7+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA701F000FF;
	Thu, 24 Sep 2026 00:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211516;
	bh=/7+ogZZx1OT6sECvNNrwHzdqsQC/kkI31LUKDJ+ibOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L7iPH7+ZpxiIxMBn51GaxlEVa7VvajbRVz3CQFNzFvojmKq2sIPFxLNjFLJ6Nz+8U
	 j0uWYjf5OmlaW0koHsAL2r6+Z3sUhjLTxDXrNdfHwK/Yj6P3y9GoXRCv9O4cIvkJBA
	 OEaXftAZl5xVfOBsl/KhLLSqWQysuJ05gaIgs9BCgCk3oX9oGFvUWxXKB1J0hOBvS7
	 ZUgYH/oUbOV/6fqWktVAvAFEeFY5l1OkgT/n9YOTY8UVj3vYFrnnkc73k5rh7adSx8
	 8kRsGTATZvibOqDzKk7lZzcbuh/PlsumPO1QL0bURqXpc8Z8P4iIeDUGcojlK7Gfep
	 lGc1CwvROf8Cw==
Date: Thu, 24 Sep 2026 01:58:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Anisa Su <anisa.su887@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org, Alison
 Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, Gregory Price
 <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>, Wonjae Lee
 <wj28.lee@samsung.com>, Junhee Park <jh9934.park@samsung.com>, Heesoo Kim
 <habil.kim@samsung.com>
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <20260924015830.1b8a8963@jic23-hlaptop>
In-Reply-To: <arLxp9mx-IPNCPQq@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
	<20260918203049.7273-7-anisa.su@samsung.com>
	<da6deab0-de16-43ea-bd13-5861f84a587b@intel.com>
	<20260922004228.5a0c027b@jic23-hlaptop>
	<a26d002f-1dcf-4bf4-bfd5-dd587c559029@intel.com>
	<arLxp9mx-IPNCPQq@4470NRD-ASU.ssi.samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 14:22:47 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

> On Mon, Sep 21, 2026 at 05:45:56PM -0700, Dave Jiang wrote:
> > 
> > 
> > On 9/21/26 4:42 PM, Jonathan Cameron wrote:  
> > >   
> > >>> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > >>> index 7b756000a1a6..6ef47265da10 100644
> > >>> --- a/tools/testing/cxl/test/mem.c
> > >>> +++ b/tools/testing/cxl/test/mem.c
> > >>> @@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> > >>>  	if (rc)
> > >>>  		dev_dbg(dev, "No CXL FWCTL setup\n");
> > >>>  
> > >>> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > >>> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
> > >>> +				       CXLDEV_EVENT_STATUS_WARN |
> > >>> +				       CXLDEV_EVENT_STATUS_FAIL |
> > >>> +				       CXLDEV_EVENT_STATUS_FATAL);    
> > >>
> > >> Second time I'm seeing this constructed mask being used in this commit. Maybe create a define for it?
> > >>
> > >> s/CXLDEV_EVENT_STATUS_ALL/CXLDEV_EVENT_STATUS_BASE/ perhaps?  
> > > 
> > > That was Anisa acting on my feedbakc on previous.
> > > I don't like _ALL because we already have an example of the spec
> > > expanding and the definition becoming messy. But mainly I was
> > > pushing back against _ALL + masking with one element we didn't
> > > want as fragile.  So I'm not against _ALL if it is made up of
> > > another define + DCD (for now) and that other define can be
> > > used in places like this.
> > > 
> > > Bikeshed time... BASE is usually a define for a reg address and it is
> > > is hard to come up with a name for that when it is a mixture of
> > > RAS stuff and INFO which can be a wide range of random nasty
> > > and nice things.
> > > 
> > > So with the right name seems fine to have what Dave suggests.
> > > I'm just not sure what that name is!  Hence I'd just stick
> > > to the long hand option.  
> > 
> > Yeah if we can't come up with anything good then leave it as is. 
> >   
> CXLDEV_EVENT_STATUS_STANDARD_LOGS...? And just add a comment kind of explaining
> what "standard" means:
> 
> /* Logs whose ownership follows native_cxl_error; the DCD log is always OS owned */
> #define CXLDEV_EVENT_STATUS_STANDARD_LOGS	(CXLDEV_EVENT_STATUS_INFO | \
> 						 CXLDEV_EVENT_STATUS_WARN | \
> 						 CXLDEV_EVENT_STATUS_FAIL | \
> 						 CXLDEV_EVENT_STATUS_FATAL)
> 
> That's all I can come up with.

I can cope with that

Jonathan

> 
> - Anisa
> > > 
> > > Jonathan
> > >   
> > >>  
> > >>>  	cxl_mock_test_feat_init(mdata);
> > >>>  
> > >>>  	return 0;    
> > >>
> > >>  
> > >   
> >   

