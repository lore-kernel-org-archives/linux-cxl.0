Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3E2566DD;
	Mon, 12 May 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072360; cv=none; b=rPW7lSnazwlsIrS6WRJGmM1kB9O/IaVL8ZBgWQm/Yk135Hkx7pIDuaZVweiCp1eVk+m1FeL+JFQn1HFvkHQcsAFd9VBBFCNBVhCktdk+k+s+i9vgZM9eI1vyvGyFm4k0RjWnjIiVYOStNwA5eNuL0knE8ykVPFTh4kyIt0UGqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072360; c=relaxed/simple;
	bh=Ux3QgRt2jF2R8Z9eyxbrWaJo9VJUnFD9cGtGgwY/b4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gamh+/T3PPgPlOgizkeZeL714iHyYdEws1XfMtEHBNq7+N/nbgizUUpyMHDygfVV+tcG3ywJDf7ltD+bDd3ASYqttDvDnK6wZmNFomHAO5Af1HJdJRcBSDCsldny7SSyiJ4JemZqY0u388d6/9QPZww7HndvzHS8qTh1MSLwjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SsjXZ0CO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SsjXZ0CO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P6m/gOuJsgKXMELNFkjuzd8wF5VtSouHA+k5dme7F2s=; b=SsjXZ0COxXLba30mLcB5h6BhV9
	rCcdqsNgk88F5FwY3wTnzUvUIp4MeroDZ+XXoZIME13xXCnQIAPewBFpe1CPbN/p6mXsY9nnL0r9x
	/vHX0UZeOiuyPi6/FyCRUYKPnMWD5gA/q8/BjB2LUppmgkcqxwUBzyFx8QhNq2TmtO1Wtc4pZysAJ
	bqLa7Q981MPxK5hA2Ndis6V7pf0yhRSCC5B5bV9aiBNF9vv28c6GBg4oGeeBN78J7qn3ya/52tRDO
	TG/JWWVVpAX2pNBsDCckdi6BZpe2gFyp+WvElkQMMP/qZtKgT5kMMQqjh1JaBWLm2R7BWG23OWL5l
	WYx9GS2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEXKJ-0000000A6aP-3bSn;
	Mon, 12 May 2025 17:52:31 +0000
Date: Mon, 12 May 2025 18:52:31 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [PATCH v3 14/17] cxl: docs/allocation/page-allocator
Message-ID: <aCI1X3NZwuagNOqS@casper.infradead.org>
References: <20250512162134.3596150-1-gourry@gourry.net>
 <20250512162134.3596150-15-gourry@gourry.net>
 <aCIjMNooAzKaONod@casper.infradead.org>
 <aCIkF6RZJtU0m3Ia@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCIkF6RZJtU0m3Ia@gourry-fedora-PF4VCD3F>

On Mon, May 12, 2025 at 12:38:47PM -0400, Gregory Price wrote:
> On Mon, May 12, 2025 at 05:34:56PM +0100, Matthew Wilcox wrote:
> > On Mon, May 12, 2025 at 12:21:31PM -0400, Gregory Price wrote:
> > > Document some interesting interactions that occur when exposing CXL
> > > memory capacity to page allocator.
> > 
> > We should not do this.  Asking the page allocator for memory (eg for
> > slab) should never return memory on CXL.  There need to be special
> > interfaces for clients that know they can tolerate the added latency.
> > 
> > NAK this concept, and NAK this specific document.  I have no comment on
> > the previous documents.
> 
> This describes what presently exists, so i'm not sure of what value a
> NAK here is.
> 
> Feel free to submit patches that deletes the existing code if you want
> it removed from the documentation.

Who sneaked that in when?
