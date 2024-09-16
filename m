Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710B038DC7;
	Mon, 16 Sep 2024 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479410; cv=none; b=RWEYNC9jwtzxPPO0ZdOVFsdObmjW6HuFwJz7ldFIZpGaPX4ef1frnIjlrr+hhp+eo1oH/AutZtG9ErjeUpUI37J2c3xKYcqM3vLdS72cwmeity0HVecZagcaLmf99ThkcsCa6J7Oez3dfh1ZACeg1XluFgt3kTIvzl3xJPLnwvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479410; c=relaxed/simple;
	bh=/xxnoLY/T+x+hTyqnRjeE/EJ1Q1QT+KLxGzGkBAyl7U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TU5pjgw7OuWq74cgtsz1JPgaJJOhMbQkcx15MxHc+Q6vmnV2/xbNPkfEuINjAztCkkC+o5E+9cY6+8eh78vjmrkMVizPsIIPPrQIRDL7NJt02pygL6RL0KLLwM3gCJ5ku/SPJ2M67Nvaz+ZXpP43qbIWS7TjgzHNrkWEfEPPVu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6ftx10HSz6K5ww;
	Mon, 16 Sep 2024 17:36:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C3C451400F4;
	Mon, 16 Sep 2024 17:36:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 11:36:44 +0200
Date: Mon, 16 Sep 2024 10:36:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Ying Huang <ying.huang@intel.com>, Dave Jiang <dave.jiang@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, "Vishal Verma"
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/region: Remove lock from memory notifier
 callback
Message-ID: <20240916103642.00007c8a@Huawei.com>
In-Reply-To: <66e48742afe0f_e45da29448@iweiny-mobl.notmuch>
References: <20240904-fix-notifiers-v3-1-576b4e950266@intel.com>
	<20240913141322.000037e0@Huawei.com>
	<66e48742afe0f_e45da29448@iweiny-mobl.notmuch>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 13:41:06 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Wed, 04 Sep 2024 09:47:54 -0500
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> 
> [snip]
> 
> > > 
> > > Link: https://lore.kernel.org/all/66b4cf539a79b_a36e829416@iweiny-mobl.notmuch/ [0]
> > > Cc: Ying Huang <ying.huang@intel.com>
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Ying Huang <ying.huang@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > A few comments on looking at this again, but all things that apply equally to old
> > code so maybe things for another day.  
> 
> Yea this was solely a move of existing code to fix the locking issue.  I
> did not evaluate the original code.  However...
> 
> [snip]
> 
> > >  }
> > >  
> > > +static void shutdown_notifiers(void *_cxlr)
> > > +{
> > > +	struct cxl_region *cxlr = _cxlr;
> > > +
> > > +	unregister_memory_notifier(&cxlr->memory_notifier);
> > > +	unregister_mt_adistance_algorithm(&cxlr->adist_notifier);  
> > Flip order.
> > 
> > Makes zero real difference, but if we later end up with more to do
> > here for some reason there may be ordering requirements that will
> > care that this doesn't tear down in reverse of setup.  
> 
> Generally I agree with you however, the memory and adist notifiers are
> unrelated.  So failing to unwind in reverse order is a matter of taste and
> is not required even if some other logic was introduced between the
> registrations I don't see how this backwards order would be an issue.

Not an issue as such, but if it requires a tiny bit of thinking
that we've engaged in here then it was worth the obviously correct
ordering. Not worth churn of a patch though.

> 
> > 
> > Mind you, see below.
> >   
> > > +}
> > > +
> > >  static int cxl_region_probe(struct device *dev)
> > >  {
> > >  	struct cxl_region *cxlr = to_cxl_region(dev);
> > > @@ -3418,6 +3412,18 @@ static int cxl_region_probe(struct device *dev)
> > >  out:
> > >  	up_read(&cxl_region_rwsem);
> > >  
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> > > +	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> > > +	register_memory_notifier(&cxlr->memory_notifier);  
> > Can in theory fail.  Today that is EEXIST only but who knows in future.
> > I think we should handle that and do two devm_add_action_or_reset() perhaps?
> >   
> 
> First we should not fail the probe if this fails.
> 
> Second, nothing bad happens in unregister if the registration failed.
> Therefore, register failing is benign and I don't see a need for the extra
> action callback.

It's probably a case of print a warning only I guess.
Might be useful to know it's going wrong even though impact is not huge.
Personally I'd argue in favor of always failing to probe on a 'software issue'
like this where we don't expect to fail.  Things get less clear if we
fail on an optional hardware related part where carrying on may be
the reasonable thing to do.

Jonathan

> 
> Ira
> 
> [snip]
> 

