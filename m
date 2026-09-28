Received: from mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12345D1B1
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582593; cv=none; b=ortxLbc8sCSd2xF41iOP7SpUe5+yAT7J4M9hoEXu9D6hlMX5+fA/KzxeXQPnFP1XibAbfCn/JDo5idlEKkczCy9eOTXAGiQ31feV2SV+LbAkLZeROqEmed0WlLLhXBdYdSqKjYLqglcrQtPfKpNMPbZNw4owCIFVeYhZhLL1sgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582593; c=relaxed/simple;
	bh=u6pM4Q2lirOQrXvVOmhw6eCdvf86YRNbjnR3yNkFQzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJyY7gre1G0W9LCpXcU7W8aNIl8mvRfyU4iNLuYydr6xRWN5WSpKsYQiGXN/sif25ibKiP7i4nKuvaKURd0VPvLs31PFUWOSK7RY4Z7RyJyXbt6MVr2AkC9r1FDLdLV+HVJkasdo9VeedszjT0Xe3dhumzJID1qS5VwdjpxyRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+V5Fg7y; arc=none smtp.client-ip=91.218.175.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+V5Fg7y"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u6pM4Q2lirOQrXvVOmhw6eCdvf86YRNbjnR3yNkFQzk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790582588; v=1; x=1791187388;
 b=C+V5Fg7yUDtnG95PdYyQlpKrqN/I0S/X42BAIMYGwTLCGzp4vAUZid0wtjsNCaEZFEsjqFB+
 y46+C0Knmw9IqwGouFl4z0q9eUZEllrBPQRgyYhcIQKi9YaOwn5MwUkGYSVRKEaW8FzJnOV8jZZ
 PolBC5842VTOJPZssiW6x/6g=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6cea94b206c11561;
	Mon, 28 Sep 2026 08:03:07 +0000
X-Mizu-Trace-ID: 6cea94b206c11561
X-Migadu-Flow: FLOW_OUT
Date: Mon, 28 Sep 2026 16:01:16 +0800
From: Dave Young <ruirui.yang@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, akpm@linux-foundation.org,
	axelrasmussen@google.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, baoquan.he@linux.dev,
	brendan.jackman@linux.dev, dakr@kernel.org,
	driver-core@lists.linux.dev, gregkh@linuxfoundation.org,
	hannes@cmpxchg.org, jan.kiszka@siemens.com, kasong@tencent.com,
	kbingham@kernel.org, liam@infradead.org, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, ljs@kernel.org, mhocko@suse.com,
	osalvador@suse.de, qi.zheng@linux.dev, rafael@kernel.org,
	rppt@kernel.org, shakeel.butt@linux.dev, surenb@google.com,
	vbabka@kernel.org, weixugc@google.com, yuanchu@google.com,
	ziy@nvidia.com, devel@lists.crash-utility.osci.io,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 10/13] mm/sparse: remove SECTION_MARKED_PRESENT
Message-ID: <aroezLexo1WoeYI7@darkstar>
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

Cced kexec list.

On Mon, Sep 28, 2026 at 09:28:08AM +0200, David Hildenbrand (Arm) wrote:
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
> 
> > 
> > Keep bit 0 reserved, or export the bits via vmcoreinfo?
> We could export it, or crash can simply detect the change based on the kernel
> version. I remember the latter was done in makedumpfile in the past (although we
> export it).
> 
> I can send a separate patch to export it.

Thanks David.   Checking kernel internals via kernel version is not a good idea
due to the downstream kernels.

> 
> -- 
> Cheers,
> 
> David
