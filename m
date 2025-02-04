Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345DA2080FD
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663456; cv=none; b=DfrnQzNKEu15psna89qnlsK3JAim69L8woyuZtq6d0LjjFV4iLFu/arE8lrV7+oHJTg8qClwhqFLAnhdIgr/eIFUvy/jtafVmdr2+Agp/rFVjGkCuLKTa7pilyAqXlwQGgVZPhzH/Esz3hKwoej+BuAG2ibST+1uQGRBAgVoLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663456; c=relaxed/simple;
	bh=g3emyf3vQ0MSkaICpzT0GIpY0E/pMzVG5hEviIiSEnQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5m+RYHB5QOsQ512th8iU25K4q5OJdk15yFQROfGH3qBymWzuzyAUWxRg57xiKfUn1daWpYxNwjo0TgIHd/T5CIBAKJ/1AhetmW95AqzDB5cta4tbcdV29P8hHeAcuXbvWxC2c6sek4SJJgFDc1u5qdIx8+fk9oTCryi21Hgg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnJn05RJDz6D9PS;
	Tue,  4 Feb 2025 18:01:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C7892140A71;
	Tue,  4 Feb 2025 18:04:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 11:04:10 +0100
Date: Tue, 4 Feb 2025 10:04:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to
 enable CXL feature commands
Message-ID: <20250204100408.000048fd@huawei.com>
In-Reply-To: <67a170ca464e3_2d2c294d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-15-dave.jiang@intel.com>
	<6794478dd8026_20f329455@dwillia2-xfh.jf.intel.com.notmuch>
	<20250127105132.000072dd@huawei.com>
	<67982790e13d1_2d1e294b0@dwillia2-xfh.jf.intel.com.notmuch>
	<20250128120138.0000599f@huawei.com>
	<67a170ca464e3_2d2c294d@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Feb 2025 17:43:38 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > > > I think it's fine to let userspace see that exclusive features are
> > > > > present, just need to return EBUSY if userspace actually tries to use
> > > > > them.    
> > > > 
> > > > To me, a poke it and see interface is really ugly.    
> > > 
> > > That smells more like a matter of documentation. "Doctor it hurts when I
> > > try to use the documented kernel-exclusive commands?"  
> > 
> > To me this is a nasty interface design.
> > If I'm writing a tool to enumerate what is exposed etc then it will
> > have to poke every get command just to list if an interface is available.
> > Hopefully none of them have side effects!  
> 
> The kernel exclusive list is documented. How did this tool get written
> in such a way to understand how to get data out of the interface but
> without reading the documentation on how to consume that data?

Today's kernel exclusive list is documented.  Kind of tricky to know what
is on that list in a few years time.

> 
> > > > 2. Query type interface.  So a way to actually ask if a given feature is
> > > >    usable.    
> > > 
> > > Not sure we really need a programmatic way to read the documentation.
> > > 
> > > The CXL_MEM_COMMAND_FLAG_EXCLUSIVE flag is for cases where the
> > > exclusivity is transient. For these features the exclusivity is
> > > permanent, and I hope we never need to cross that
> > > transient-exclusivity-bridge for Features.  
> > 
> > It's permanent today, but I can definitely see that not always being
> > the case - we may well have future kernel does things in X fashion but
> > for legacy support disable that CONFIG option. Not nice but definitely
> > plausible.  
> 
> Then we cross that bridge and build some new ABI to communicate
> transient exclusivity, and that new state of the world will be
> documented as to how to discover that new capability.
> 
> Something like a Linux specific feature that returns a list of transient
> and permanently exclusive Features.
> 
> In the meantime no need to hide useful information from userspace.

Ok.  Seems like a more complex long term solution, but meh I don't care
that much.

> 
> > > > 3. What we have here.  To me the simplest solution is hide what we can't
> > > >    be used.    
> > > 
> > > It is inconsistent that we do not do this for the other kernel exclusive
> > > commands in userspace retreived Command Effects Log. The ABI here is raw
> > > Get Supported Features payload.  
> > 
> > If they were exposed via similar paths I'd agree consistency matters
> > but I 'hope' no one is going to have a tool that mixes fwctl and the
> > legacy path.  In my head we add all the useful commands to fwctl
> > and that legacy path ends up effectively deprecated.
> > 
> > Anyhow, I don't feel that strongly about this, it's just a case
> > of doesn't smell of roses to me.
> >   
> > >   
> > > > > > +	/* These effects supported for all scope */
> > > > > > +	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
> > > > > > +	     (effects & CXL_CMD_EFFECTS_EXTEND &&
> > > > > > +	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
> > > > > > +	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
> > > > > > +	    scope >= FWCTL_RPC_DEBUG_WRITE)
> > > > > > +		return true;      
> > > > > 
> > > > > Looks good for the known bits, but this needs to return false for the
> > > > > currently reserved bits because the driver can not assume a security
> > > > > model for future effects. If a future spec adds
> > > > > FWCTL_RPC_DEBUG_WRITE-safe effects, a new kernel is needed to allow
> > > > > those Feature commands through.
> > > > > 
> > > > > Sidenote: I wonder why the spec wasted one of its bits on an extend bit,
> > > > > but here we are. The 'extend' concept is typically something like
> > > > > "bit15: go look at this other field in this payload as this 16-bit field
> > > > > was exhausted", not "bit9: the bits above this originally defined 16 bit
> > > > > field now has more bits", oh well.    
> > > > 
> > > > It's odd but corner case of going from 'unknown' state for the remaining
> > > > pair of bits to 0 means this and 1 means this.    
> > > 
> > > I don't understand. 0 means no effect to worry about whether it is
> > > defined or not.
> > >   
> > > > Naming though doesn't match the spec that calls it CEL[11:10] valid.
> > > > Would be good to name it closer to that as we may well have something
> > > > in bits 12 and 15 in future and it doesn't refer to them.    
> > > 
> > > Hopefully we can head off another "valid2" mistake, and I don't think
> > > Linux needs to define anything for this bit. That bit's definition is:
> > > 
> > >    "Bit[9]: 1 is recommended, 0 is permitted (CEL[11:10] Valid)"
> > > 
> > > ...which translates to "useless". If 11 or 10 are set, I don't care what
> > > value 9 has.
> > >
> > > If 12:15 are set, I don't care if there is a future valid2
> > > bit gating whether or not to use them. Valid bits are for cases that go
> > > outside of what Reserved 0 compatibility rules can convey, and I think
> > > Reserved 0 compatiblity fully covers us in this case.  
> > 
> > Seems the spec authors disagreed. (obviously I can't comment on that
> > discussion).
> > 
> > Using just what anyone can see (if they have the spec)
> > It was a clear spec hole and there wasn't an obvious default for 0 to
> > mean so it was a 'read your device docs and act appropriately' case
> > before this stuff was added.  
> 
> I see v2 is still trying to pretend this bit matters.
> 
> Are you saying that because the unused bits were marked 0 instead of
> "Reserved" that software needs to play this game of checking an extend
> bit?
> 
> What breaks if software treats those bits as Reserved0? What breaks if
> software ignores bit9?

More generally we can't assume it doesn't happen if those bits are 0.
In this particular case perhaps it doesn't matter.

Hmm. The aim is to decide if the permissions DEBUG_WRITE is enough.

We have already verified it doesn't happen immediately. So now
the question is does it result in a change conventional reset.

Without bit 9 we have no idea either way.  So question is do
we assume it does, or assume it doesn't?

+	/* These effects supported for all scope */
+	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
+	     (effects & CXL_CMD_EFFECTS_EXTEND &&
+	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
+	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
+	    scope >= FWCTL_RPC_DEBUG_WRITE)
+		return true;
+
+	return false;

Right now we return false if it was conventional reset but
we don't know that because the hardware doesn't say either way.

I'm stuck on what the right thing to do is.  My assumption
is that cold reset will always apply if conv or cxl reset
do. So maybe who cares and we shouldn't check these two
at all?

Fun corner: there must be something that causes an effect
to happen (or in what sense is this a 'set') and if we have
excluded everything else maybe we should assume that
it must be one of these two resets?


> 
> > There may be corner cases where the right answer if we know the
> > feature is not persisted over a reset but instead panic or take
> > some heavy weight action. Same can be true the other way around
> > in that we may have to do something heavy to manually reset something
> > we don't want to persist over reset. Hopefully not but we'll see.  
> 
> ...but how is that relevant to the FWCTL use case which just wants to
> know if the operation is going to have an immediate effect that changes
> a parameter behind the kernel's back?

In that case, should we just let everything through and not check for
cold reset either?

Jonathan

> 

