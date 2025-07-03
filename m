Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76352D9ED5
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535090; cv=none; b=ReNfSOI8yTDv1VLm4rN3clarhF42fkXSahaOq8lMZXeiS8eIvYEvRL+TQ7QsfN+wt4BJLc3b0xpor4XL1PBUvKXBZb5sJME2c6Zhh2/7tNXZDYvWF8DVa/SOw8aM9Kk5R3o2EVyuBX6hF2marw/cXirZH3ETWVVecJYNMS52Ft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535090; c=relaxed/simple;
	bh=X34FavGd/46DToNZc8uUeAvoHM4jpDKz4ojcIwPZ1f4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPIir8FAQUADGaodua+nyOlF96m0JylnhmKyaPou/Jh74+z8En1U2fmZU/iZ74Cu7g/mq+5HX5ALFyekwOER6yCP/OuADHAPezQPRzAx2VEkY9TkZW0LLfbHAa1hAB51mROJRPKyKcJ2QCUGEuacpByE7oBfcBLHrlJ9MuR3K9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 7a1ff63d-57f0-11f0-a9d0-005056bdfda7;
	Thu, 03 Jul 2025 12:31:21 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 3 Jul 2025 12:31:20 +0300
To: Alison Schofield <alison.schofield@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Li Ming <ming.li@zohomail.com>, akpm@linux-foundation.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, shiju.jose@huawei.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] resource: Introduce a new helper
 resource_contains_addr()
Message-ID: <aGZN6EFMLp-pL6JB@surfacebook.localdomain>
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <aGTq5MKCYBO3H9Gg@smile.fi.intel.com>
 <aGWFdwla54b-98-x@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGWFdwla54b-98-x@aschofie-mobl2.lan>

Wed, Jul 02, 2025 at 12:16:07PM -0700, Alison Schofield kirjoitti:
> On Wed, Jul 02, 2025 at 11:16:36AM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 03:20:06PM +0800, Li Ming wrote:
> > > In CXL subsystem, many functions need to check an address availability
> > > by checking if the resource range contains the address. Providing a new
> > > helper function resource_contains_addr() to check if the resource range
> > > contains the input address.
> > 
> > resources are about ranges and not addresses. At bare minimum naming #####
> > here. Also there is no symmetry with the intersection API. But I would argue
> > to use resource_contains() and just provide necessary parameter with both
> > start and end to be set at the same value.
> > 
> > 	struct resource r = DEFINE_RES...(addr);
> > 
> > 	if (resource_contains, res, &r)
> > 		...do stuff...

(1) ^^^

> Thanks for the review. Two alternative approaches were considered:
> 
> 1) A CXL-only helper with direct comparison:
> This duplicates range checking logic that's already common in the
> resource API. We'd end up with CXL specific when the resource API
> already provides the semantic framework for containment checks.

> 2) A CXL helper using temporary resource + resource_contains():
> While this maintains API consistency, it's unnecessarily heavyweight.

How is it? It's mostly matter of stack usage. Do I miss anything?

> Creating a temporary resource struct just to check if a single address
> falls within a range feels like overengineering.
> (This is your suggestion above.)

I don' think so. This won't create anything, it will declare the resource
data on a stack.

...

> This patch proposes, a new helper in ioport.h, provides a clean, reusable
> API that follows the existing resource_contains() pattern while being
> optimized for the single address case. I guess I can agree with the lack
> of symmetry with the existing API, but that's only if one thinks an API
> cannot be extended. The new helper actually complements resource_contains()
> nicely: one checks resource vs resource containment, the other checks
> address vs resource containment.

The point is _there is no address_ in the resources! There is a _range_.

> Revisited the name, I can see how extending an existing name, like 
> resource_contains() is a poor choice because then one might expect the
> pair to be resource_contains_resource() and resource_contains_addr()
> which it is not.
> 
> Do either of these fit better, or something else?
> - resource_includes_addr() 
> - resource_has_addr()

That's why (see above) naming sucks. Doing it local to CXL makes it clearer as
CXL knows the semantic of the range, struct resource doesn't and shouldn't.
(Yeah, I know that we have something there that relies on the range being an
address range, but those APIs provide more and TBH I would rather split them
to a separate header)

> The new helper would immediately be used 7 times in the CXL subsystem.
> What are you thinking the bar is for adding to ioport.h?

It's only a single subsystem, find 3+ more outside and we can reconsider.
Also for the symmetrical API,

-- 
With Best Regards,
Andy Shevchenko


