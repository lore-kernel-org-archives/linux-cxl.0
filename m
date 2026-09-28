Received: from mta0.migadu.com (out-116.mta0.migadu.com [91.218.175.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CB44A403
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584326; cv=none; b=KamploxE6RM1v+HLEQgY5MPyQRHocNbN4KbQGCpyVTGOcovqReNu0Y705IpklGsruIWRX+1pxOg+eWsb5PuQhbXhjKq0BSXq6miinYZ1ebnBVY75/CqTzFpaMsxcgPPLlyhpT9D2RgTQyfdbWJwSFOyLsw1KFolnePIv+iT6Dwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584326; c=relaxed/simple;
	bh=0vsNUizkmzlbu8y8J+IZWSMNjN9v2l2Yufh8n4d8/RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMzko2J9Qfo6B3BQzOIjsm0OVKl7Y++b2I8JglD75WBkM4vEQUKPvqTmlnLudkBqLhEHvYDyBw9rV7w6m4c1MqqEm87DSkm3vl0zj9VBcBkcMQyEUepHKnAnup2IxtlMvqqHzkS5oeF2ozlsDkLmI8ihCka1Sm/26enwWXUF3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tyjF0o3c; arc=none smtp.client-ip=91.218.175.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tyjF0o3c"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0vsNUizkmzlbu8y8J+IZWSMNjN9v2l2Yufh8n4d8/RU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790584322; v=1; x=1791189122;
 b=tyjF0o3cR9ljeFX4XK3gL8z3b7xqobt2exvjAkbD+PvnbxNfg2F1GudPKGeS+nnZnBWsZe8e
 AEK7Cwjwz0O91OKfGmf/5KNZvAVKzBK9uEzR8gkDGuKYdlvX3ue6Aq1wiZnpSoUClPeZEUe3bhA
 4Klw25etPFVrQB63qCKJd9bo=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 42d1b3bbabd087ec;
	Mon, 28 Sep 2026 08:32:01 +0000
X-Mizu-Trace-ID: 42d1b3bbabd087ec
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 16:31:51 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>, k-hagio-ab@nec.com,
	ruirui.yang@linux.dev
Cc: David Carlier <devnexen@gmail.com>, akpm@linux-foundation.org,
	axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, brendan.jackman@linux.dev,
	dakr@kernel.org, driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org, hannes@cmpxchg.org,
	jan.kiszka@siemens.com, kasong@tencent.com, kbingham@kernel.org,
	liam@infradead.org, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, mhocko@suse.com,
	osalvador@suse.de, qi.zheng@linux.dev, rafael@kernel.org,
	rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
	vbabka@kernel.org, weixugc@google.com, yuanchu@google.com,
	ziy@nvidia.com, devel@lists.crash-utility.osci.io
Subject: Re: [PATCH v2 10/13] mm/sparse: remove SECTION_MARKED_PRESENT
Message-ID: <arol9w7G3vupIVZ7@MiWiFi-R3L-srv>
References: <20260921-b4-sparsemem_cleanups-v2-10-54d81d65e125@kernel.org>
 <20260927192013.144672-1-devnexen@gmail.com>
 <655c509e-318f-48bc-8183-2b1274dd05ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <655c509e-318f-48bc-8183-2b1274dd05ac@kernel.org>

On 09/28/26 at 09:28am, David Hildenbrand (Arm) wrote:
> On 9/27/26 21:20, David Carlier wrote:
> > On Mon, Sep 21, 2026 at 09:59:02PM +0200, David Hildenbrand (Arm) wrote:
> >>  enum {
> >> -	SECTION_MARKED_PRESENT_BIT,
> >>  	SECTION_HAS_MEM_MAP_BIT,
> >>  	SECTION_IS_ONLINE_BIT,
> >>  	SECTION_IS_EARLY_BIT,
> > 
> > Hi David,
> 
> Hi!
> 
> > 
> > It seems dropping SECTION_MARKED_PRESENT_BIT shifts the other section flags down
> > one bit. crash hardcodes SECTION_HAS_MEM_MAP as (1UL << 1) in
> > pfn_to_map(), so it now tests SECTION_IS_ONLINE: offline and
> > ZONE_DEVICE sections no longer resolve to a struct page. makedumpfile
> > only checks bit 0 and is fine.
> 
> Thanks. To be expected when relying on kernel internals.
> 
> Which makes me wonder why makedumpfile
> (https://github.com/makedumpfile/makedumpfile) not require any such information.

Makedumpfile requires it too, while it doesn't ask for HAS_MEM_MAP. So
checking MARKED_PRESENT becomes checking HAS_MEM_MAP's value, it luckily
works.

# git grep MARKED_PRESENT
makedumpfile.c:                 if (!(map_mask & SECTION_MARKED_PRESENT)) {
makedumpfile.h:#define SECTION_MARKED_PRESENT  (1UL<<0)


Add makedumpfile maintainer Kazu here.

And add Dave Young here since I heard he is taking over Crash maintenance
as a volunteer.

> 
> > 
> > Keep bit 0 reserved, or export the bits via vmcoreinfo?
> We could export it, or crash can simply detect the change based on the kernel
> version. I remember the latter was done in makedumpfile in the past (although we
> export it).
> 
> I can send a separate patch to export it.
> 
> -- 
> Cheers,
> 
> David
