Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6A330B0E;
	Fri, 30 Jan 2026 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742683; cv=none; b=oYTPV6t/JpP5LjcEszn8H0dDI2aZf7CQrPxpDX1Xkj9wBcJt+qhOqWeJlVOB9YSna5h50fP0rofgkaWQjKaeUIcHe4hkKCAQNsOWUcHQm02pR1Vy26kRrRP6zJotGDJRCAaKmYqXpknao1dV2wZK0FFczm0MeyelxN8VBQe2xNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742683; c=relaxed/simple;
	bh=lqhUsq4B6MtvcoApApHDdRa4clRZskZTS4n+u954eBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZWekX421E/auzwfJ4vl9PIcynYAkime8yvAbGM5h+NyXLZV2VCN6c3YfBzquVISk5479MKz5ClELgWjUACc+EuswGiF+iLkRTfow3O6OgRKSFKhqe4cNDtp9QOxLkDhur7KZc3NkcJbC+YimsIVVgpjOpZHWsL8rpkq6ld1IHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yHC/7Hv+; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yHC/7Hv+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769742678; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=+Sj5EkA5RsLnpWZahkb02HpmazD47xiU7plAZzL/HoM=;
	b=yHC/7Hv+pMBVObQO7iQWjIOwCeRDeymZAkkENi1GgaLKqDFSe6sMPsrHxquQhzUl09kiRJLmsc4DIcF0IDB3qvTggvF73Z5iKABpnsqKaRmTNYFpX5GpI0YxmoaihFESMsk3SL65e+0xYzw7cgAYmkt+L/x8v0MKahyn5jjg0eg=
Received: from U-Q2G32XWJ-0138.local(mailfrom:yuxiong.wang@linux.alibaba.com fp:SMTPD_---0Wy9FrHV_1769742676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Jan 2026 11:11:17 +0800
Date: Fri, 30 Jan 2026 11:11:16 +0800
From: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, ying.huang@linux.alibaba.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix premature commit_end increment on decoder
 commit failure
Message-ID: <aXwhVGbKyebNgfKi@U-Q2G32XWJ-0138.local>
References: <20260129064552.31180-1-yuxiong.wang@linux.alibaba.com>
 <aXudN_vAy7frUcWM@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXudN_vAy7frUcWM@aschofie-mobl2.lan>

On Thu, Jan 29, 2026 at 09:47:35AM -0800, Alison Schofield wrote:
> On Thu, Jan 29, 2026 at 02:45:52PM +0800, Yuxiong Wang wrote:
> > In cxl_decoder_commit(), commit_end is incremented before verifying whether the
> > commit succeeded, and the CXL_DECODER_F_ENABLE bit in cxld->flags is only set
> > after a successful commit. As a result, if the commit fails, commit_end has been
> > incremented and cxld->reset() has no effect since the flag is not set, so commit_end
> > remains incorrectly incremented. The inconsistency between commit_end and
> > CXL_DECODER_F_ENABLE causes failure during subsequent either commit or reset
> > operations.
> > 
> > Fix this by incrementing commit_end only after confirming the commit succeeded.
> > Also, remove the ineffective cxld->reset() call. According to CXL 3.2 Spec 8.2.4.20.12
> 
> DaveJ - Maybe s/3.2/4.0 above on applying please.
> 
> It's the same section either way but lets encourage new references to use the
> latest version of CXL Spec.

Thanks for the advice! I'll refer to the latest version of CXL Spec in future work.

Best Regards,
Yuxiong

> 
> > Committing Decoder Programming, since cxld_await_commit() has cleared the decoder
> > commit bit on failure, no additional reset is required.
> > 
> > Fixes: 176baef ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
> > Acked-by: Huang Ying <ying.huang@linux.alibaba.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > Change log:
> >  * Added CXL 3.2 Spec 8.2.4.20.12 Committing Decoder Programming statement. Thanks
> >    Alison.
> >  * Collected reviewed-by. Thanks Dave and Alison.
> > RFC Link: https://lore.kernel.org/linux-cxl/aXqKC-bscufh1ggq@aschofie-mobl2.lan/
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
