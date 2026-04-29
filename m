Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9101F63D9;
	Wed, 29 Apr 2026 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460210; cv=none; b=Q7OPabkEWINULX2D1jx0REflg7ou89H6yUYkxfwG4DqXbBbs5c8sNkLazrTZoEnIY99guBdNlZKwDPS3qhkLpTMB1kUB5//MGRjdnCuJbFoY/veQ7jABii0jTWEl8RucR64/PMA7uXVCuh1MVVu3KZj8pfa6AboNa3lJI3CcWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460210; c=relaxed/simple;
	bh=73d/gOG45X+YgKPVJ5mIpSzWZtPERo64zzVKJAlNpYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZzlFP1DAhNoqAI0bDH7XhySH2xczPFvCLauybLdMtL1Wpj1KUtMzhdN3QMP7J2OJUjIC6spweGRFI7TQoHOTXpWQs1/rLHoB261TMPe1rPMj3R30Suq4s5v5vTvNHzj9+7psIAl54Yxoh5w70i+z001S26R0VthfsK0/KAo/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRpwsP6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRpwsP6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D16C19425;
	Wed, 29 Apr 2026 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777460209;
	bh=73d/gOG45X+YgKPVJ5mIpSzWZtPERo64zzVKJAlNpYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rRpwsP6agOYqL9pyipHRIJ8Sby6fU9vawxL6bWvPkkSYC8IrtgvDdyYwfEXR0l3lU
	 m1cEhIerGcoOiA4gX10xYCCft1g/0VWjPGQBOmnE6Bug5OIatglB2MRvM6sXdz6299
	 YvP5scigNhNw5tR55ECvWGWIXuAJpFlUxDdhl7DrZdwkijmPSYf5FJ7WV/b30jyTDQ
	 G25Dj+h4tUlF9KdESSi8W7L0TKjpsqla2gHh5yiXRcBei91tOS3LIJNdxpWMk6GTd0
	 3QznrSkHYXWDPLEFwpA0NQceazAoZQKI1gKusIMb2lQsanIwpe7id3pgP0sVWhQJ2b
	 E+/QLoZ1pp6Yw==
Date: Wed, 29 Apr 2026 11:56:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ira Weiny <ira.weiny@intel.com>
Cc: John Groves <john@jagalactic.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 John Groves <John@groves.net>, Fan Ni <fan.ni@samsung.com>, Anisa Su
 <anisa.su@samsung.com>, Shiju Jose <shiju.jose@huawei.com>, Robert Richter
 <rrichter@amd.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dev.srinivasulu@gmail.com"
 <dev.srinivasulu@gmail.com>, "arramesh@micron.com" <arramesh@micron.com>,
 "ajayjoshi@micron.com" <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to
 an xarray
Message-ID: <20260429115638.685c421d@jic23-huawei>
In-Reply-To: <69ef7cc2a9b63_101875100a0@iweiny-mobl.notmuch>
References: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
	<20260423235158.3732476-1-john@jagalactic.com>
	<0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
	<69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>
	<20260427133833.61b9cbca@jic23-huawei>
	<69ef7cc2a9b63_101875100a0@iweiny-mobl.notmuch>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 10:12:02 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Jonathan Cameron wrote:
> >   
> > > Look at the diagrams in this presentation:
> > > 
> > > https://lpc.events/event/18/contributions/1826/attachments/1435/3335/LPC2024_CXL_DCD-v2.pdf
> > > 
> > > 'DAX dev 1' covers memory from Extent A and Extent B.  What yall will want
> > > to do is ensure that the region extents which get surfaced are ordered
> > > based on the sequence number _when_ _the_ _dax_ _device_ is created.  The
> > > order they come into the host does not really matter.  Although yea the
> > > spec has a bunch of rules...  so whatever, follow those.  But it is the
> > > dax device which groups the extents into a contiguous HPA range and maps  
> > 
> > On this bit, HPA?  Why would extents be contiguous in HPA?  Contiguous
> > in the DAX device mapping sure, but not HPA.  
> 
> I'm not saying the _extents_ are contiguous in HPA.  I said they get
> _mapped_ into a contiguous HPA _by_ the DAX device.

That's not HPA at that point, it's a VA of some type.
Now maybe it smells like HPA in some DAX interface but if it does
we should think about any renames etc necessary to avoid it doing
so!  Or introduce DAXPA (not DPA for obvious reasons ;)

> 
> IOW the DAX device has some policy(tm) which looks at the extents and
> decides which ones are part of the device (the grouping I mention above).
> Then it presents a contiguous HPA to the user by mapping those
> discontinuous extents.
> 
> Ira

