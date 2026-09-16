Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E95345EAC;
	Wed, 16 Sep 2026 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525968; cv=none; b=eTIWXetd/y6QNlYAlmfbj1Y/08stVcgTcUgDvZ9bV2zmU87hDNq+cjitH+eMgPl3SquzkEyf9KEE0kxR9soiarYz6/adJuvfiuI3hLHCRUIfoF3Fe5q7KQpbWCFgslqrFlBDOYwwovUUKZBe1d1aj/3VEtql+I5NYPzwJVrsZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525968; c=relaxed/simple;
	bh=+gvY37AcT3k5wbBYEtbtg6xNzgR7aqPbXSkxXJ4FWOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVd30B/5gPskXGJWoH5C8VT6GHJXaryQdW4vU5kTfNIyURGbU/IfzcWx6i22xL7vNR2VpAV952fT1Ox/Amv8hZA7HkkVREk82/FhO8FlSgnWtd06BC5fM04dY5x2sqof8PJBKDq350iDXnof4nDCmB/L/N8wPPBBJhAdlwmIols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJtaT7fB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJtaT7fB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2BD1F000FF;
	Wed, 16 Sep 2026 02:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789525964;
	bh=vwHTsbU5VsC9bg5GbUtPtfKqW9squjPWGLhZeAaw10k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nJtaT7fBH4ug66H5PilqmXMG9aw8jB1TzX1pyBfA/vk+Tw+9VhJ2j2b+zSwhUmk+3
	 Lv9lr7BewnJNrN9OgmXsKIpLCq6gYgFZRVeJ4Kxm6KnJVmFcOG5LQnuYfNdQV+ohQ6
	 UBAPNurFHwtKmvXsf6u/BNxPiQ5pVYAWCmpd/8GpzKd/z3qfKIEgQlW3FaliMHuQn7
	 IHzcUPl+bsPWVoa5duC1wHjwNAiK6jvOZ/WHZ0dXS9icHACxrUZnvOk95FrRgeUSto
	 7tpovPCUnXsjnWKOfIFSUOlhkf1LIxLr2hJ9s0vsop+U0LTzsfVut+wkwGGoHM9gec
	 oshffKJOMD/dA==
Date: Wed, 16 Sep 2026 03:32:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Richard Cheng <icheng@nvidia.com>, <dave@stgolabs.net>,
 <dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <iweiny@kernel.org>,
 <ming.li@zohomail.com>, <gourry@gourry.net>, <rrichter@amd.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kees@kernel.org>, <newtonl@nvidia.com>, <kristinc@nvidia.com>,
 <kaihengf@nvidia.com>, <kobak@nvidia.com>
Subject: Re: [PATCH v7 5/7] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Message-ID: <20260916033240.36c5b6ea@jic23-hlaptop>
In-Reply-To: <appXoR5rCn91KF34@aschofie-mobl2.lan>
References: <20260902053839.25595-1-icheng@nvidia.com>
	<20260902053839.25595-6-icheng@nvidia.com>
	<appXoR5rCn91KF34@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 22:31:13 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Wed, Sep 02, 2026 at 01:38:37PM +0800, Richard Cheng wrote:
> > cxl_get_poison_by_memdev() queries Get Poison List per partition but
> > never checks the result inside the loop, so a later partition's success
> > overwrites an earlier partition's failure and the whole scan reports
> > success while that partition's poison went unlisted. Before the loop
> > conversion the PMEM query returned early on error. Stop the loop on any
> > error not already tolerated as a RAM -EFAULT.  
> 
> Before be5cbd084027 pmem was queried first, then ram, so a ram failure
> was reported after the pmem records had been collected. Now w the order
> reversed, breaking on a ram error means pmem is never queried. I'm not
> sure that is what we want.
> 
> What matters more to poison list user - a truthful return code or every
> record the device is able to give us?

If we can have both, that would be nice.  That sort of multiple return code
fusing is nasty to read but here I think it makes sense.

Jonathan

> 
> -- Alison
> 
> 
> > 
> > Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/core/memdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index b3419df586b9..e39b3d13fd56 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
> >  		 */
> >  		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
> >  			rc = 0;
> > +		if (rc)
> > +			break;
> >  	}
> >  	return rc;
> >  }
> > -- 
> > 2.53.0
> >   
> 

