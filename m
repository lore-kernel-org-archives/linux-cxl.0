Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C501AD9D9
	for <linux-cxl@vger.kernel.org>; Tue, 20 Aug 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724184711; cv=none; b=hygckDcYRK+Iii4ulyg2JTHG0WjQJgZC+PwNcp+6lUNTdkRLMk+IXtMc6epzDw+RT1n3AaCuMbVxOCgOmZBwl1QbtKfkEnxQTvsxaKRtVHJEI7p9GLH1oyTQhQTMMypxgd6LU1Fmecke20z1DTpVobD6M9QiFN3AVLc4K6sGfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724184711; c=relaxed/simple;
	bh=aQ0tbtZnmB2YE0opLSDHPWuCyddKqqbbEAxuDZSnlaM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCPv+nTGxbfnC7VFAOe0QBofpBEK0zENaUF2qjyTn3abFJrRsTEigHJUxOPuhjZx92/Y8/1LXXhaEULhg8/wwKuN3/dQyXYgnoP+aY3e/TMRbqap1PfXPCWOtD5c8gyLEQv7qak/dWc/8f3YyvcyuiU4sg3Jsv4vw7Pq2UorZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WpLBc4g3jz67ZDL;
	Wed, 21 Aug 2024 04:08:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 877FD1400D3;
	Wed, 21 Aug 2024 04:11:45 +0800 (CST)
Received: from localhost (10.48.152.188) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 21:11:44 +0100
Date: Tue, 20 Aug 2024 21:11:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: ajay.opensrc <ajay.opensrc@micron.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, Aravind Ramesh <arramesh@micron.com>, "Tushar M
 Mulgund ." <tmmulgund@micron.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Add support for abort of background
 operation
Message-ID: <20240820211143.00007124@Huawei.com>
In-Reply-To: <20240815180403.000025f0@Huawei.com>
References: <20240729102010.20996-1-ajay.opensrc@micron.com>
	<jvbuxqaqjclc5cy5veltygpo4dg3naej456gvphndpdc3ttyoa@p64fmecqr67r>
	<027f6872f7ae42c4ba97ed1209e50253@micron.com>
	<20240804171638.0000291c@Huawei.com>
	<739db69829ed4afead329649fda1d47b@micron.com>
	<6erdnad5ql6xtzpwc6ay4mibud44u56kzd7r6nk5labxsmkkbi@e7lw2v7bffue>
	<20240815180403.000025f0@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Aug 2024 18:04:03 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 12 Aug 2024 13:04:36 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Wed, 07 Aug 2024, ajay.opensrc wrote:\n  
> > >>From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > >>So to my reading if you elect not to stop because it's very
> > >>nearly done, or indeed it raced and the command is done,
> > >>the specification doesn't tell us what to return.
> > >>That operation supports abort, we just didn't.
> > >>
> > >>What do you think should happen here?    
> > 
> > I had interpreted this case to return success for the req abort
> > command, but the caller had to check the Mailbox Status register
> > to see if result had actually canceled the on going bg op.
> > And I don't think there's a race between checking the status
> > register and the on-going bg command completing. Aborting
> > means percentage complete < 100 && bg field cleared.  
> I'm fine with it returning success, but I'm didn't read the spec
> as actually saying it would. Maybe I missed something as these
> cases where a call is a noop are classic corner cases where it
> might return
> a) you are crazy, why did you call that?
> b) sure I'll do nothing.

Clarification received was indeed that the device should return
success to a BG command abort if there isn't one to abort.

So that's easy :)

Jonathan
> 
> > 
> > Jonathan, would you want the patch to have an arbitrary "don't
> > abort the bg op over 85% done"? I see this useful as it allows
> > the cancel a bit more versatility, albeit potentially getting
> > in the way of testing. What do you think?  
> I'd not bother - I think we will cancel very rarely in reality.
> This is mostly a route around possible really long delays, not
> a tool for normal operation.
> >   
> > >
> > >IMHO, device should ignore the abort command and
> > >most likely return "Unsupported" code (since, the spec is not
> > >clear on what should be the return code in case the command
> > >is ignored). Does it make sense?    
> > 
> > I don't think so. This is not an error imo. This case is about
> > supporting the request abort command, but the actual command
> > not actually triggering the desired cancel.
> >   
> > >
> > >Agree that it's a spec hole and may need to be clarified.    
> > 
> > Yes, it would be nice to have this case be explicitly stated.
> > And it is not even a corner case, the way the spec describes
> > it, this case can perfectly happen.  
> Absolutely. I'll poke the relevant person.,
> 
> Jonathan
> 
> > 
> > Thanks,
> > Davidlohr  
> 
> 

