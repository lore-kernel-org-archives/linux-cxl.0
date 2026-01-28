Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02D14A91;
	Wed, 28 Jan 2026 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583628; cv=none; b=SyGhO274i3053t45FUANhuSyO+RoES0efsYl1zE4R2uatYUJx32YjhwTZvQR5QP7Ui+f9kB6NVXrzd4WOvwYoG7Bxup5h9Lg0Wd/EJGuBD7/9RBgVL5tN72yJOV0Q0n+lbXHmb5+pAV2qZBkEWipVAp4hmBvWEKi2FfzbiBb160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583628; c=relaxed/simple;
	bh=J2zpTyG2d17Ab9PHegoKrNdCT/E3OAouTFt9C8vmEHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3ZL2KiRZZiVVMFZazMebdcHzwayENpy9nNmT+NriJTJH7xBCbhByfPTlQ/X1n4EfAPoZlMqROApuJVjwHjvvMvFq+NDlaVsjwZJUzJWZ3y23/n6q4piwYXsJ+U361I1stskE2szIQA4mNqlqOzdXXPs6komqCZbjFJGz/KfwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=esKxYH47; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="esKxYH47"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769583616; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=YpPTYafJUdlbhO42HGxhD/1cZeM13BNYS46Q4Esramk=;
	b=esKxYH47XWJqddRdY2tIfJzp9G2SN6rnlH5lS437BTQLkQizrL+46760MRYpBP3AcizHBLlQDev52LMmweZ5X33CK6mAjrvygVLjdJtFJ+1co4wj1QNwWidmNJXJPWR7/EgkirIp0VpLXUuc2x8X894YCMLo0Y837aCcTFWnO3E=
Received: from U-Q2G32XWJ-0138.local(mailfrom:yuxiong.wang@linux.alibaba.com fp:SMTPD_---0Wy2X8hv_1769583614 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 15:00:16 +0800
Date: Wed, 28 Jan 2026 15:00:14 +0800
From: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, ming.li@zohomail.com, rrichter@amd.com,
	ying.huang@linux.alibaba.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cxl: Fix premature commit_end increment on decoder
 commit failure
Message-ID: <aXmz_pH92dL1TqJ-@U-Q2G32XWJ-0138.local>
References: <20260127084855.66916-1-yuxiong.wang@linux.alibaba.com>
 <aXkq2DvEOeYQSVuN@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXkq2DvEOeYQSVuN@aschofie-mobl2.lan>

Resending with corrected CC list - apologies to those who received the
message twice.

Thanks for comments!

On Tue, Jan 27, 2026 at 01:15:04PM -0800, Alison Schofield wrote:
> On Tue, Jan 27, 2026 at 04:48:55PM +0800, Yuxiong Wang wrote:
> > In cxl_decoder_commit(), commit_end is incremented before verifying whether the
> > commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
> > after a successful commit. As a result, if the commit fails, commit_end has been
> > incremented and cxld->reset() has no effect since the flag is not set, so commit_end
> > remains incorrectly incremented. The inconsistency between commit_end and
> > CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
> > operations.
> > 
> > Fix this by incrementing commit_end only after confirming the commit succeeded.
> > Since cxld_await_commit() clears the decoder commit bit on failure, no additional
> > reset is required. Remove the ineffective cxld->reset() call in this case.
> 
> 
> Why are the writel()'s that cxld->reset() intended to do not really
> needed? Is only the twiddle of the COMMIT bit needed for a reset or
> do we need to 0 the size and base offsets we previously wrote?

In this case, cxld->reset() does not work because CXL_DECODER_F_ENABLE bit
in cxld->flag is not set. 

The size and base registers shall have no effects if the commit bit is cleared.
And except the reset and commit functions, there are no other functions that
touch these registers after initialization. So I think the key step is to clear
the commit bit, which has been done in cxld_await_commit(), and the size and
base will be overwritten in the next commit.

Considering the potential hardware problems, perhaps it's more a secure
solution to clear all these offsets. I can add a function like
'clear_hw_decoder()' to do this.

> 
> How did you find this?  Maybe we can add test case to cxl unit tests.

I think this is a very rare situation, since the software has done very
strict checks before commits. We found this when testing the cxl module
of kernel and firmware. We committed the region in OS, and faked a host
bridge hdm decoder commit failure in firmware. During the second commit,
we triggered this problem with 'out of order commit'.

> 
> Thanks,
> Alison

Best Regards,
Yuxiong

> 
> 
> > 
> > Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
> > Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
> > ---
> >  drivers/cxl/core/hdm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index eb5a3a7640c6..912f648a6b7a 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -844,14 +844,13 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
> >  	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> >  		setup_hw_decoder(cxld, hdm);
> >  
> > -	port->commit_end++;
> >  	rc = cxld_await_commit(hdm, cxld->id);
> >  	if (rc) {
> >  		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
> >  			dev_name(&cxld->dev), rc);
> > -		cxld->reset(cxld);
> >  		return rc;
> >  	}
> > +	port->commit_end++;
> >  	cxld->flags |= CXL_DECODER_F_ENABLE;
> >  
> >  	return 0;
> > -- 
> > 2.50.1 (Apple Git-155)
> > 
