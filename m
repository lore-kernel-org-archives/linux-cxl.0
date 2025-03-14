Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9B1A5B82;
	Fri, 14 Mar 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950589; cv=none; b=eGW5f4UoT1/GWm71bFqY2aoxTeVvFLwqbnnykyHzvxKvyFbNI5v5rJoLq1FOnzIGESrO3/12rMwVrv6rZRtC/XrH5w2SooTPiJL0dtvEP6qKdFRG8KriSRdAaqe+Uy7Am3KI5TlUlnCEVxVvLVg1mcpUgA8eXei3eR2rjlSRvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950589; c=relaxed/simple;
	bh=LcUk1W4gYUAuud4YDzRGE15WvmLIL4ATkXosQxiLJL4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLcKrmabPugeGfMkfcmRJHUCtZWfEBz3D6Nt34suZsw/GX5iHiwAr8Iv45T60tJLl+DwX/6nYqroSTU6+WNr1ahtrikm1xhMinB0Ik0EoREEP7WEDeZcNU9u1izYFLCkbCtDL76WwC5ZhCBN5n0PfcJUASD74mQgS1pxyRH0PVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDhQ10LXDz6J7rd;
	Fri, 14 Mar 2025 19:06:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 29C72140680;
	Fri, 14 Mar 2025 19:09:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 12:09:43 +0100
Date: Fri, 14 Mar 2025 11:09:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0a: CFMWS and NUMA
 Flexiblity
Message-ID: <20250314110942.0000476a@huawei.com>
In-Reply-To: <Z9MhVZmFVTPpuRe1@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
	<Z8u4GTrr-UytqXCB@gourry-fedora-PF4VCD3F>
	<20250313172004.00002236@huawei.com>
	<Z9MhVZmFVTPpuRe1@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 13 Mar 2025 14:17:57 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Mar 13, 2025 at 05:20:04PM +0000, Jonathan Cameron wrote:
> > Gregory Price <gourry@gourry.net> wrote:
> >   
> > > -------------------------------
> > > One 2GB Device, Multiple CFMWS.
> > > -------------------------------
> > > Lets imagine we have one 2GB device attached to a host bridge.
> > > 
> > > In this example, the device hosts 2GB of persistent memory - but we
> > > might want the flexibility to map capacity as volatile or persistent.  
> > 
> > Fairly sure we block persistent in a volatile CFMWS in the kernel.
> > Any bios actually does this?
> > 
> > You might have a variable partition device but I thought in kernel at
> > least we decided that no one was building that crazy?
> >   
> 
> This was an example I pulled from Dan's notes elsewhere (i think).
> 
> I was unaware that we blocked mapping persistent as volatile.  I was
> working off the assumption that could be flexible mapped similar to...
> er... older, non-cxl hardware... cough.

You can use it as volatile, but that doesn't mean we allow it in a CFMWS
that says the host PA range is not suitable for persistent.
A BIOS might though I think.

> 
> > Maybe a QoS split is a better example to motivate one range, two places?
> >   
> 
> That probably makes sense? 
> 
> > > -------------------------------------------------------------
> > > Two Devices On One Host Bridge - With and Without Interleave.
> > > -------------------------------------------------------------
> > > What if we wanted some capacity on each endpoint hosted on its own NUMA
> > > node, and wanted to interleave a portion of each device capacity?  
> > 
> > If anyone hits the lock on commit (i.e. annoying BIOS) the ordering
> > checks on HPA kick in here and restrict flexibility a lot
> > (assuming I understand them correctly that is)
> > 
> > This is a good illustration of why we should at some point revisit
> > multiple NUMA nodes per CFMWS.  We have to burn SPA space just
> > to get nodes.  From a spec point of view all that is needed here
> > is a single CFMWS. 
> >  
> 
> Along with the above note, and as mentioned on discord, I think this
> whole section naturally evolves into a library of "Sane configurations"
> and "We promise nothing for `reasons`" configurations.

:)  Snag is that as Dan pointed out on discord we assume this applies
even without the lock.  So it is possible to have device and host 
hardware combinations where things are forced to be very non-intuitive.


> 
> Maybe that turns into a kernel doc section that requires updating if
> a platform disagrees / comes up with new sane configurations.  This is
> certainly the most difficult area to lock down because we have no idea
> who is going to `innovate` and how. 
Yup.  It gets much more 'fun' once DCD partitions/ regions enter the game
as there are many more types of memory.

Jonathan

> 
> ~Gregory

