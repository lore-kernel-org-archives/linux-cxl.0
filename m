Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A5A3C07A
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 05:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775883913; cv=none; b=VvwnqzUuDpSvSqnj4TO582V/jk2XjPj2klQMWv8/pVTOWtlB0UvjGvvWvwZIXNqX9LFMSfn+WOe9Uun4KGyhBCnRKdEnlVQV3jyPkc1xqh7rgGWiYn4Qj0TWQFuj2vOnEvzkkMY13KJ5fObaWSbKR7jFNl93na0HWRpnThSSuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775883913; c=relaxed/simple;
	bh=IJFAGOE6aHtwumSs4a4kJwpIWI5vFFsj3bRuD46+sM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5CFI/2tLtHkBnzMQk54ELDC7Y7zVYTjmLg0VtH0PNJbc7GwPk6oAg/7jmxLqIEbUkIPoGTbXRZEq41DvmICHu8miakxGn17hmNo9flZ67u5vEBqaX7+Kt/wWlooi1ZD1HPXqOYrGhHzPWmc6PrGXushZaO5KSf64Ud6aV1rGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SsQgc7ha; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SsQgc7ha"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb38e86cf2so245823885a.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 22:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775883911; x=1776488711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIJ0EgwIZ1/c3nad2z814N4RACW0LQibM0HK3/VBYDw=;
        b=SsQgc7ha0TlT+2jBoNoj5RI15YfZrBQEzejLSux3P1nsnAUWCMNonxY/5CKjURaPCy
         oDO9vOeLBPsS+zQySnYWzbXsopKQUOTlhsjcpyMXhD1h5XzlwMIJd634KC95ALlUW0qW
         WjRTKNU+rxF1LYkd75k09yeXPZBCXGTWZFKwIMrnb8ZMuxLoaGT1hRtf0fz7cFN0fQoa
         8cJyB2oh8zNFO1KsLUaQ3YXorXTY9GbGICc/ExaRiHgq0i8rLEDquS6yFrYNVcMT+EX/
         OYIY4j74SCCAPhBd4Pz0bfkaRZET3inVQq8LZektOGgXqgxn7kYrnCCPZNXR/n+ozEbh
         lgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775883911; x=1776488711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIJ0EgwIZ1/c3nad2z814N4RACW0LQibM0HK3/VBYDw=;
        b=mhEzbjp1frAXVB0SFiaEj58QbgNgH7+YBXiEWq6czErlfkiBFy3bBqtlWJfOa05u22
         podRBgfStiUzcPqxqL6DdFynJg5IzbOhwCfi32tYSaceHHhvwcsLQoLYD+5fcpZnAHty
         i+CywXhhbEbnXE5b7sl7Jdh5yCENwVpr3bZeHt6RzHLK5Nc9rku0pYq96gNpgKXBr78U
         mrpGGHAiQWH4+5MbYmkZ+C3RL2HwAp+p5VYxV6d0DwXolDlFS/3hLSwQGQ/mwnvhBvUl
         UVR2k94KnliCY+HXNLxULHUQhR1lOPTM9Eekmv+IErsUC+yGJA7p34+1vZvxC6nUgVK3
         GDoQ==
X-Gm-Message-State: AOJu0YwMkFF4IgO2+ULGfzcXbKkzrmuPe3fPfgasnnTP6je6zrM2wxt5
	G4pOCctTNiOVx/uqLUrO3EwSsJv6Tj27KrArXdra1biSLZrMa2wlStq8/ZykjKib1ldF/r+hUio
	MSM0D
X-Gm-Gg: AeBDieuhdaSXLS95G0XYx3TyT0vjgnbb1U8ODNTu7J9S/46obft3o8Vw1z2zgbCtq+6
	hV9DAcJNgHHLwXYQ4xLurHjb2B4grg8UmU9P25IJ+7sTVmtumXiFR15FRU2POvi1D5KtjD8TxiQ
	lCLp/3kIBNGFnmD7vSEa0Ev3POnpWpLh/qZZl68+YiWeivrttW7m8dVCP5e3z69QRFC7r9yhApa
	SQoRZjAoutls5AIXKymEIkBMdHyqMkm1jLWHKHYA4YYeMq61zEEPn5c2BsMs6COrotYB3Qby7+Q
	Qv5tdiaVqKf5D1Q5Fc9d0mbZYHWzKD+2EWOQHQLCSmFo+sx1rMohpQSlOr6HR5YKCMfIkmPzYpU
	7YzkM2UzMybXc6wiiCyCPqVWbPz8+knniBXSKwdwsDanf4pCT/1NjTHEIwhmwZkZl4/cZ9Nyeyw
	2YHiZlDivGv/+7zoc/HnKQORGzhcRUvLKhiHhRpTylOTJPYXlGUSBtmyyVaPs1nJ8hQV6n2go5B
	AXrTZbKLhL4zhDKeYVuhn8=
X-Received: by 2002:a05:620a:2586:b0:8cf:c218:739b with SMTP id af79cd13be357-8ddcd6fda32mr799336085a.18.1775883910810;
        Fri, 10 Apr 2026 22:05:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9351afasm365538485a.36.2026.04.10.22.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:05:09 -0700 (PDT)
Date: Sat, 11 Apr 2026 01:05:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, john@groves.net, dave.jiang@intel.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Anisa Su <anisa.su@samsung.com>
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add
 tags
Message-ID: <adnWg-60uKmduTsh@gourry-fedora-PF4VCD3F>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>

On Fri, Apr 10, 2026 at 06:22:55PM -0700, Anisa Su wrote:
> This RFC modifies Ira's DCD patchset to enforce tags and remove sparse DAX region
> support, which are the requirements that I've understood from the community
> meetings, with the end goal of FAMFS as the end user for DCD. Feedback would be
> greatly appreciated to let me know if this is on the right track? Or totally off
> the mark...
> 
> Everything is the same as before except:
> - extents must have tags (uuids)
> - 1 tag per region
> - regions must be contiguous (no more sparse regions)
> 
> To achieve this, the main thing is to change the relationship between
> cxl_dax_region : region_extent from 1 : many to 1 : 1. Each region_extent is
> comprised of 1+ contiguous device extents with the same tag. Contiguity
> is enforced by sorting device extents by DPA order.

Are you saying they need to be contiguous in DPA?  I don't think that's
what we want - in fact that's actually somewhat defeats the entire point
of DCD being allocator-like.

We don't much care what DPA space the extents take up so long as the
total size of the set of extents matches the size of the HPA region.

Sorting by DPA at least gets you extent-ordering for free as a
pre-agreed upon mechanism, so that's fine.

Basically: we don't want sparse regions where the HPA space has holes
(i.e. an extent hasn't been sent by the device to back the hole yet),
but we don't really care what DPA actually backs those HPA regions.

Unless my take on how DCD "should" work is wildly different from the
general understand.

~Gregory
