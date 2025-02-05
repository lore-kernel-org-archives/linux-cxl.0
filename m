Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4A1FC0EB
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777021; cv=none; b=IDYJMUhcc5zps7XVQwaETB41f2aSTccKrN5AkR4hQp5GPY52DKwSRMWoKo73wQ818C0FbYFqAmq4r09CcXHvsyyxLGpOwAVxrbrlIidPtaBxurLZ40/Z8jHr1pH7OQiPVKtY+sIXe2qlLjjijZC/+ilO57OIvNutBPG6x8v2LQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777021; c=relaxed/simple;
	bh=pkH5ZoZwMj+u46pnZZKqoTgqBSDNxONb2u8UItL/sRI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3jwYlSiSQYvQ5zOPpDoonkagcbA8kvLEOOjQhVclQNDsX4ugzLEzCi9iIAD4AerUHBxyF3pnPWjBtHIgTjSWd/O9kluoLN3+Ith4jg80mGgS3pg3io5nege3BMo8yv7cPDPFNY8uP22J0Lxn84DKuquw0XERKlBUJR2F/VIxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yp6pQ16Vjz6J9YF;
	Thu,  6 Feb 2025 01:35:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 283361402C4;
	Thu,  6 Feb 2025 01:36:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Feb
 2025 18:36:53 +0100
Date: Wed, 5 Feb 2025 17:36:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250205173652.0000363b@huawei.com>
In-Reply-To: <67a293fa8f068_2d2c2944d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-15-dave.jiang@intel.com>
	<6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
	<20250127105132.000072dd@huawei.com>
	<67982790e13d1_2d1e294b0@dwillia2-xfh.jf.intel.com.notmuch>
	<20250128120138.0000599f@huawei.com>
	<67a170ca464e3_2d2c294d@dwillia2-xfh.jf.intel.com.notmuch>
	<20250204100408.000048fd@huawei.com>
	<67a293fa8f068_2d2c2944d@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 14:26:02 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Mon, 3 Feb 2025 17:43:38 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Jonathan Cameron wrote:
> > > [..]  
> > > > > > > I think it's fine to let userspace see that exclusive features are
> > > > > > > present, just need to return EBUSY if userspace actually tries to use
> > > > > > > them.      
> > > > > > 
> > > > > > To me, a poke it and see interface is really ugly.      
> > > > > 
> > > > > That smells more like a matter of documentation. "Doctor it hurts when I
> > > > > try to use the documented kernel-exclusive commands?"    
> > > > 
> > > > To me this is a nasty interface design.
> > > > If I'm writing a tool to enumerate what is exposed etc then it will
> > > > have to poke every get command just to list if an interface is available.
> > > > Hopefully none of them have side effects!    
> > > 
> > > The kernel exclusive list is documented. How did this tool get written
> > > in such a way to understand how to get data out of the interface but
> > > without reading the documentation on how to consume that data?  
> > 
> > Today's kernel exclusive list is documented.  Kind of tricky to know what
> > is on that list in a few years time.  
> 
> I expect new software for new capabilities considers new documentation.

Time travel issue.  New capabilities are supported as features the day
they turn up. Tools are written. 

Sometime later we might decide kernel support is needed and make them
exclusive.

Ah well, we'll cope.
> 
> [..]
> > > What breaks if software treats those bits as Reserved0? What breaks if
> > > software ignores bit9?  
> > 
> > More generally we can't assume it doesn't happen if those bits are 0.
> > In this particular case perhaps it doesn't matter.
> > 
> > Hmm. The aim is to decide if the permissions DEBUG_WRITE is enough.
> > 
> > We have already verified it doesn't happen immediately. So now
> > the question is does it result in a change conventional reset.
> > 
> > Without bit 9 we have no idea either way.  So question is do
> > we assume it does, or assume it doesn't?  
> 
> If bit10 is set, assume it does, otherwise not, but as you say below,
> does any of this matter once immediate config change effects are
> accounted?

If it's set and 9 isn't - hardware bug! Not really our problem.


> 
> I think no.
> 
> > 
> > +	/* These effects supported for all scope */
> > +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> > +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
> > +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> > +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
> > +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> > +		return true;
> > +
> > +	return false;
> > 
> > Right now we return false if it was conventional reset but
> > we don't know that because the hardware doesn't say either way.
> >
> > I'm stuck on what the right thing to do is.  My assumption
> > is that cold reset will always apply if conv or cxl reset
> > do. So maybe who cares and we shouldn't check these two
> > at all?  
> 
> That's true, if the security policy is that reset based configuration
> changes are always ok, then bits [0, 9:11] do not matter.
> 
> > Fun corner: there must be something that causes an effect
> > to happen (or in what sense is this a 'set') and if we have
> > excluded everything else maybe we should assume that
> > it must be one of these two resets?  
> 
> Yes, fun. "What exactly did this effectless 'Set' do?". I think I would
> be ok with blocking "effectless" Set just to make the device commit to
> a security model for all of its 'Set'-able Features.
> 
> > > > There may be corner cases where the right answer if we know the
> > > > feature is not persisted over a reset but instead panic or take
> > > > some heavy weight action. Same can be true the other way around
> > > > in that we may have to do something heavy to manually reset something
> > > > we don't want to persist over reset. Hopefully not but we'll see.    
> > > 
> > > ...but how is that relevant to the FWCTL use case which just wants to
> > > know if the operation is going to have an immediate effect that changes
> > > a parameter behind the kernel's back?  
> > 
> > In that case, should we just let everything through and not check for
> > cold reset either?  
> 
> I think so, yes. Filter the known problematic effects for live changes,
> and require the device to claim at least one of [0:5, 10:11] in its
> effects, and filter Features that claim [12:15] effects for now.
Ok.  With a big comment to say any device setting 10:11 that
doesn't set 9 is buggy but we don't care.

Otherwise someone will 'fix' it.

Jonathan


