Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3402B2DA;
	Sun,  8 Sep 2024 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725765900; cv=none; b=ENNiEdk4GrIogjc0Xa3r2p4Gk2LBeU4fDBGUoryA6RDrhU2DYJCUV30C9mf1iaPHhFgmrNxBWV7qdiUg6vXENRPIWpOwDDRAODrWn5BOQ7d6PBlb+3PwkmIt0pRUBBJQHLiKnmzp5IPephYXedfoNZYzoPLlR69dkvhAaxveO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725765900; c=relaxed/simple;
	bh=Pyp7dRfMcSf5MD+6qBE70iGPu2i/5ZdA4dgou2lJL98=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OPBA/pSCEl/uFvoeU27gA5t3AMu4YJiAos2lJ1xvae3Sao0cJoHAqlJwNsyw0oZrmDw7UKt3S6xtOH7yG2HaSfD5nx9KLK4kH4nvBJ0EGX5kMm0y9kEHFI4x/ZxMhX8dDusuURA+giRvPSz9djS/oskiB+18o4KB+BJa3BbI07Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RJpiXoFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RJpiXoFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47301C4CEC4;
	Sun,  8 Sep 2024 03:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725765899;
	bh=Pyp7dRfMcSf5MD+6qBE70iGPu2i/5ZdA4dgou2lJL98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RJpiXoFqyWKXsiRSbKurj/snbkWegxcRcdb5ipXFzmA+U2SVo7fEschQfzxsFsF5C
	 GMawSuO/7erkzr53L8e4p5jTyXVqxw+Re+zRAxuqTn1yM3BH4ybYr9jbQIHMriq4ku
	 4p5HhU/JdZhsi6vBVG69PzBRl4njn7vGqaPEfRxg=
Date: Sat, 7 Sep 2024 20:24:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huang Ying <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, David
 Hildenbrand <david@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
 <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v3 1/3] resource: Fix region_intersects() vs
 add_memory_driver_managed()
Message-Id: <20240907202458.dfe90bfee071021706af91eb@linux-foundation.org>
In-Reply-To: <20240906030713.204292-2-ying.huang@intel.com>
References: <20240906030713.204292-1-ying.huang@intel.com>
	<20240906030713.204292-2-ying.huang@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Sep 2024 11:07:11 +0800 Huang Ying <ying.huang@intel.com> wrote:

> On a system with CXL memory, the resource tree (/proc/iomem) related
> to CXL memory may look like something as follows.
> 
> 490000000-50fffffff : CXL Window 0
>   490000000-50fffffff : region0
>     490000000-50fffffff : dax0.0
>       490000000-50fffffff : System RAM (kmem)
> 
> Because drivers/dax/kmem.c calls add_memory_driver_managed() during
> onlining CXL memory, which makes "System RAM (kmem)" a descendant of
> "CXL Window X".  This confuses region_intersects(), which expects all
> "System RAM" resources to be at the top level of iomem_resource.  This
> can lead to bugs.
> 
> ...
> 
> Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")

Do you believe this should be fixed in earlier (-stable) kernels?
