Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F913D9557
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034151; cv=none; b=omyHtOPSyMRsYypXUe5XkU36bgjWcwvVe04hNTlKD4HoYzB0VHe9P4njvZJ78pgaFDIPngmGpnjoG15zbxRu0Ar8Y+C89vOSAqRu0RlHaWYP5JlEvZ2bPXzyFGQTBGNlrotD0gYzmCOq6liV6h9hPjxvbenTfeSa9UZt1aMsjXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034151; c=relaxed/simple;
	bh=ieahzw4YRFgMnKeviFDby5ip9QWZnXVpUhHdUYYrrOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMezY5E4it3oCyGKsKsrDwt1pJXPsv3SwxlbWAxEjj0sR4xOoT28M8uY7YarBHr32TE/wNAeXTmaIZvQAYC21qZJ2gj/7YAaCk5wiL7pjzrnHh4WeOZz06TWZQ5chUTmZfVQRUIWUExTdFsgS+4OlEbw5rZ9aRkHTfK07bfjqyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1gDY8U4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1gDY8U4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062A71F000FF;
	Mon, 21 Sep 2026 23:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034150;
	bh=LOtkJ/iDc/V8ijZ2puiLL8xA7NCJgffWaYzzLobZAlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D1gDY8U4KN3qHeWxmqH2IvuA0ErxWzNDKbdqsdMuf137EqUgI/z5hVCXKqZKRiE9w
	 abOGrS3DesOgpoz6aNJOopzqgQB1KL03twlfwRJsZkz7o6L8Hf3z2hPtJMrJjt8ZFO
	 X7FHdBxX/w/PQaVNgGNGsrLv6gp8HaNMLfjchLTCDtmQo1krzk2g5yC8uyAwEWbFmP
	 0F/rRdBzPmx7+T/PrzgV/OzESqKunI4heaxanH36dDO249rcvgeonETvOt/3lkloMu
	 l2m0lvS06vFBaEzDGX20FP8L8F0oJaATqTcWHv3/+SkS4HzDOrhwprlLdC7be34wha
	 B73moTEDk9hYw==
Date: Tue, 22 Sep 2026 00:42:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org, Alison
 Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>, Gregory Price
 <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <20260922004228.5a0c027b@jic23-hlaptop>
In-Reply-To: <da6deab0-de16-43ea-bd13-5861f84a587b@intel.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
	<20260918203049.7273-7-anisa.su@samsung.com>
	<da6deab0-de16-43ea-bd13-5861f84a587b@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 7b756000a1a6..6ef47265da10 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >  	if (rc)
> >  		dev_dbg(dev, "No CXL FWCTL setup\n");
> >  
> > -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> > +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
> > +				       CXLDEV_EVENT_STATUS_WARN |
> > +				       CXLDEV_EVENT_STATUS_FAIL |
> > +				       CXLDEV_EVENT_STATUS_FATAL);  
> 
> Second time I'm seeing this constructed mask being used in this commit. Maybe create a define for it?
> 
> s/CXLDEV_EVENT_STATUS_ALL/CXLDEV_EVENT_STATUS_BASE/ perhaps?

That was Anisa acting on my feedbakc on previous.
I don't like _ALL because we already have an example of the spec
expanding and the definition becoming messy. But mainly I was
pushing back against _ALL + masking with one element we didn't
want as fragile.  So I'm not against _ALL if it is made up of
another define + DCD (for now) and that other define can be
used in places like this.

Bikeshed time... BASE is usually a define for a reg address and it is
is hard to come up with a name for that when it is a mixture of
RAS stuff and INFO which can be a wide range of random nasty
and nice things.

So with the right name seems fine to have what Dave suggests.
I'm just not sure what that name is!  Hence I'd just stick
to the long hand option.

Jonathan

> 
> >  	cxl_mock_test_feat_init(mdata);
> >  
> >  	return 0;  
> 
> 

