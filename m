Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149621;
	b=pEINVTrmxHubfhqeptkt0KKHRJ9yG6Qb1O57Ae3cfchzhgfPwTlsBIVc5uqPdkz6bwFG
	 O4c3QSna2TwYN8FtxB5Xv6wS5OfIC04m465QKxUUDOmCWoQQtOxJEUCmbSQkeWvvKwhpU
	 M2c3orsVilGDbKUL4hl/l56zx5oM8d/T6ZZrb4Yxnmqfw3dFfySUNGhLB6ZYzGdaRjeDS
	 ODqdNPs5jz8pS+aNJf7VsNzw30mWp+ki6SyYDbirAkpzpnbnZIC5vOfu7/njnSAN2999l
	 eW+Rs+rYebVQfzUU0OZXOk+o4XEydQA3Qp6KK5mQKtuH5YDKAOHDm06BJ4VO1XrXntQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149621;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=MHC87lPbaUVMM0Wjs2NmSbYMQIC2BrofT6s8wEye+w0=;
	b=sTR18y+rZ0jhIVhdWif6Y/nKLbpVNmrBhuUIOlNIatoACrSpTcPOPFhRQl/1+QwU0f6I
	 L2IofQJhBY4IKisZV1Bc6MvtCUV+tui5EIOs8AGlueWW/sBmjInXyYxbcG3sHE2FUMYYg
	 2yiiIEdkyNZVwL7csh+YcAboYrvOZa3l95JKtKfeveAQEv1UXvNpMun/kVb7SwFpnK/zn
	 7Z3NcA97hEXDktIVoHynfojXPnjJLDuRNscpZMP8q1BO1qUuqIkYaITCeJvA3M+Pn6Zws
	 uUM5DatLcJ9qbMmyjjbtxcYinXrz3NFHn7Ovwqu0lLyUAa1aHL88TTCxX2cPOL8YCzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKMl7ko9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD1606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKMl7ko9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83811F01825;
	Wed, 28 Oct 2026 01:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149620;
	bh=MHC87lPbaUVMM0Wjs2NmSbYMQIC2BrofT6s8wEye+w0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EKMl7ko9PzzxIxqtqrh4yvE9q1duoFU3T76o3/2cwdap3TlD7qZvs6CHzQzimXrZZ
	 r63t1yNmZxskT3/5b8Ahr98cvEdXQIqPreJ1YlCEB0TOKku52Qoa8owl7us2A9SjAx
	 grSf7QdHSo4sA0mgy7OcTpdMe0fzHCmFwOKKzwJ3v6RBmWPsOcy2xPmsHh2CPdzRGy
	 RtWZybjEY99Nd76r+anRomT0TwTBPpkNT1RFfcPVAlunzFHI3uvmt4QhkcSlI9EoBU
	 jUUZ/crVO8BGKYVp+8aA3c5tLUmzRhUQrN98N9LWxtyJfZi0yOTUI2v48Pe9GgKWZ7
	 xZMr3SgeWvtyw==
Date: Wed, 28 Oct 2026 01:06:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
 <icheng@nvidia.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Make repeated targetN writes no-ops
Message-ID: <20261028010657.2d95c3a9@jic23-hlaptop>
In-Reply-To: <1f08a647-0d24-4103-9382-61eb9b7517a5@intel.com>
References: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
	<1f08a647-0d24-4103-9382-61eb9b7517a5@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 15:38:25 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/26/26 9:16 AM, Alison Schofield wrote:
> > Writing an endpoint decoder to a region targetN attribute that already
> > holds it returns -EBUSY, but leaves the partially populated region in an
> > inconsistent state. The targetN attribute still names the decoder, so the
> > failed write gives no indication that the region was damaged.
> > 
> > Filling the remaining target positions can then trigger a NULL pointer
> > dereference in cxl_region_setup_targets(). This can be reproduced through
> > sysfs:
> > 
> >     echo $decoder > /sys/bus/cxl/devices/region0/target0
> >     echo $decoder > /sys/bus/cxl/devices/region0/target0
> >     echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> > 
> > An existing check recognizes when the decoder already occupies the
> > requested position, but does not prevent the attachment from proceeding
> > and modifying region state.
> > 
> > Move the check ahead of the attachment work, so a repeat write succeeds
> > as a no-op without modifying region state.
> > 
> > Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Note: cxl_region_perf_data_calculate() currently updates region performance
> > data before attachment validation completes. This is a pre-existing issue
> > that will be addressed separately. This patch places the repeated-write
> > no-op check before that call, so the issue does not affect this fix.
> > 
> > Changes in v2:
> > - New Subject line. v1 as 'Reject a repeat write of an ...'
> >   v2 does not reject, it treats as no-op and protects region state
> > - Keep repeat write as a no-op instead of failing with -EBUSY (JonathanC)
> > - Check before the decoder's bandwidth is added to the region
> > - Correct the Fixes tag
> > 
> > v1: https://lore.kernel.org/linux-cxl/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/
> > ---
> >  drivers/cxl/core/region.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 27e63e6dab7c..c8dbd9b29899 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1762,9 +1762,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
> >  		return -ENXIO;
> >  	}
> >  
> > -	if (p->targets[pos] == cxled)
> > -		return 0;
> > -
> >  	if (p->targets[pos]) {
> >  		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
> >  		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
> > @@ -2128,6 +2125,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  		return -EINVAL;
> >  	}
> >  
> > +	/* Already at @pos: succeed before changing any region state */
> > +	if (pos >= 0 && pos < p->interleave_ways && p->targets[pos] == cxled)
> > +		return 0;  
> 
> I think we probably should do -EEXIST here. As far as the user
> visible aspect. Previously when this happened, the user just finds
> out that the region is broken later on. If you add an errno here, the
> user gets to find out earlier and it allows them to figure out what's
> wrong with their setup script. Given that there has never been a
> scenario where the user set an existing decoder and successfully
> configured a region, I don't think it's necessary to preserve that
> original behavior.

It's not a 'creation' type command, but rather an assignment.
To me more natural to just eat it and return success.

However, given it isn't something we expect anyone to rely
on (and currently broken) I don't mind that much.

Jonathan
> 
> DJ
> 
> > +
> >  	cxl_region_perf_data_calculate(cxlr, cxled);
> >  
> >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > 
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222  
> 

