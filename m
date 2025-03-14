Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5F1FAC59;
	Fri, 14 Mar 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950896; cv=none; b=Aw9zFg+ELXoHhj+yMJk1ztLZ9iEumpQRGLNnqKbmpPB157iY8N8+2FW10YFee7pMt3JC7qMzYk28SNdEPx3bLVo+/hRDB0MiB8zArpop/jQUOMIKZiNU5v2T9ISyoyk3J0/XC4zhpMXT9UBaRFXDl8aUEGyjKOnPs7yOQvEAMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950896; c=relaxed/simple;
	bh=Yr0hqmbWxrVQ/03SzK+XDshrxrtDOeuslaazuT5dTQs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYwQ0Yt0Vqo/+LG9/j9qKIeWyY8DqhdzqyqucZCdAqAUOagfBkfvGn5on9jf5PmE/zF4glC6vUCoSaD6BUF5+Eygq6l5klhZxt7M0UGmxb/x0LhbxxMIiAWgpINaUjwo959IQZfRo0G7mzKhJc1x5ljtUcFNIeF6DkFP1EkEFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDhWw4xQpz6J7rS;
	Fri, 14 Mar 2025 19:11:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C6460140A70;
	Fri, 14 Mar 2025 19:14:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 12:14:51 +0100
Date: Fri, 14 Mar 2025 11:14:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: <lsf-pc@lists.linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <20250314111450.000011f2@huawei.com>
In-Reply-To: <Z9MWUhHmZ5ND0b_e@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
	<20250313165539.000001f4@huawei.com>
	<Z9MWUhHmZ5ND0b_e@gourry-fedora-PF4VCD3F>
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

On Thu, 13 Mar 2025 13:30:58 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Mar 13, 2025 at 04:55:39PM +0000, Jonathan Cameron wrote:
> > 
> > Maybe ignore Generic Initiators for this doc.  They are relevant for
> > CXL but in the fabric they only matter for type 1 / 2 devices not
> > memory and only if the BIOS wants to do HMAT for end to end.  Gets
> > more fun when they are in the host side of the root bridge.
> >  
> 
> Fair, I wanted to reference the proposals but I personally don't have a
> strong understanding of this yet. Dave Jiang mentioned wanting to write
> some info on CDAT with some reference to the Generic Port work as well.
> 
> Some help understanding this a little better would be very much
> appreciated, but I like your summary below. Noted for updated version.
> 
> > # Generic Port
> > 
> > In the scenario where CXL memory devices are not present at boot, or
> > not configured by the BIOS or he BIOS has not provided full HMAT
> > descriptions for the configured memory, we may still want to
> > generate proximity domain configurations for those devices.
> > The Generic Port structures are intended to fill this gap, so
> > that performance information can still be utilized when the
> > devices are available at runtime by combining host information
> > with that discovered from devices.
> > 
> > Or just 
> > # Generic Ports
> > 
> > These are fun ;)
> >  
> 
> > > 
> > > ====
> > > HMAT
> > > ====
> > > The Heterogeneous Memory Attributes Table contains information such as
> > > cache attributes and bandwidth and latency details for memory proximity
> > > domains.  For the purpose of this document, we will only discuss the
> > > SSLIB entry.  
> > 
> > No fun. You miss Intel's extensions to memory-side caches ;)
> > (which is wise!)
> >   
> 
> Yes yes, but I'm trying to be nice. I'm debating on writing the Section
> 4 interleave addendum on Zen5 too :P

What do they get up to?  I've not seen that one yet!

May be a case of 'Hold my beer' for these crazies.


> 
> > > ==================
> > > NUMA node creation
> > > ===================
> > > NUMA nodes are *NOT* hot-pluggable.  All *POSSIBLE* NUMA nodes are
> > > identified at `__init` time, more specifically during `mm_init`.
> > > 
> > > What this means is that the CEDT and SRAT must contain sufficient
> > > `proximity domain` information for linux to identify how many NUMA
> > > nodes are required (and what memory regions to associate with them).  
> > 
> > Is it worth talking about what is effectively a constraint of the spec
> > and what is a Linux current constraint?
> > 
> > SRAT is only ACPI defined way of getting Proximity nodes. Linux chooses
> > to at most map those 1:1 with NUMA nodes. 
> > CEDT adds on description of SPA ranges where there might be memory that Linux
> > might want to map to 1 or more NUMA nodes
> >  
> 
> Rather than asking if it's worth talking about, I'll spin that around
> and ask what value the distinction adds.  The source of the constraint
> seems less relevant than "All nodes must be defined during mm_init by
> something - be it ACPI or CXL source data".
> 
> Maybe if this turns into a book, it's worth breaking it out for
> referential purposes (pointing to each point in each spec).

Fair point.  It doesn't add much.

> 
> > > 
> > > Basically, the heuristic is as follows:
> > > 1) Add one NUMA node per Proximity Domain described in SRAT  
> > 
> >     if it contains, memory, CPU or generic initiator. 
> >   
> 
> noted
> 
> > > 2) If the SRAT describes all memory described by all CFMWS
> > >    - do not create nodes for CFMWS
> > > 3) If SRAT does not describe all memory described by CFMWS
> > >    - create a node for that CFMWS
> > > 
> > > Generally speaking, you will see one NUMA node per Host bridge, unless
> > > inter-host-bridge interleave is in use (see Section 4 - Interleave).  
> > 
> > I just love corners: QoS concerns might mean multiple CFMWS and hence
> > multiple nodes per host bridge (feel free to ignore this one - has
> > anyone seen this in the wild yet?)  Similar mess for properties such
> > as persistence, sharing etc.  
> 
> This actually come up as a result of me writing this - this does exist
> in the wild and is causing all kinds of fun on the weighted_interleave
> functionality.
> 
> I plan to come back and add this as an addendum, but probably not until
> after LSF.
> 
> We'll probably want to expand this into a library of case studies that
> cover these different choices - in hopes of getting some set of
> *suggested* configurations for platform vendors to help play nice with
> linux (especially for things that actually consume these blasted nodes).

Agreed.  We'll be looking back on this in a year or so and thinking, wasn't
life nice an simple back then!

Jonathan


> 
> ~Gregory
> 

