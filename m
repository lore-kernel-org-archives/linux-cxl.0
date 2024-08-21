Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C861B3B1D;
	Wed, 21 Aug 2024 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265977; cv=none; b=VsKBajWp5HRMoMGjD+4fIti3VaCsft4NUB79p6L/o2H7Hzz/9aVcmgUdtw8eWYPwTXuIWp0Df+aCs9KMirMJ8wr+tUkkquhzZY2CZVSGWZPfIfU5xWAPXh74R4Te5g/IpBAdi99sCHtgC4JcoLZhagMBbX3cfqC5bJx/3pils10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265977; c=relaxed/simple;
	bh=cqQ+efIJ7BbTVi8BZHPCeDnba7cGvozIJaWcOMkL4Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZrNvo1s8GECmDdQOsspNPxgJQcRfpJSVXSf5EJCvecGhJg+FdqN87qL0B8FiYfwV+QDO8xoFqPQbeEn/mEnA4zVuCr8Ejg+6aD8FBuHHIJxohGbmJ829jDv9Pgeyftuy/DtNwVPtM2xhnPIGWAmHTk6jPtG7+Xo2gCNv6csSsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRXiXOve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRXiXOve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00449C32781;
	Wed, 21 Aug 2024 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724265977;
	bh=cqQ+efIJ7BbTVi8BZHPCeDnba7cGvozIJaWcOMkL4Bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qRXiXOveQ14RLiahwyTqoh0cx2pVLkxXvMpA09lX0Dh3EUM8hpIfFmTIM6onqfJY5
	 rOHFMpWtoIgdPtwWB1lqI/xEnxaZ/3DlRaM9c1PblTV/8x+vwUUpo/z740OEXFUXz2
	 W5k1NgvBpMa2fD7jvpL2dqLvPFBu016cf+exjZ+kjEcnLER4o0j8k3LQg7AEShtY5/
	 wonnPLL6cmGJ5a3akVX9qBf0zuvbgCyalBw6Ms3d9rnVrFb1ZMGCgXx2PUusdF48Xa
	 JQXEL2JhAtKkpmJ3QFS0DmNEjYa1Jru6U3C4fHKPJr9SoaqY5Qf5A8BLx63alXCGnc
	 U1Vzcft7T6ePw==
Date: Wed, 21 Aug 2024 13:46:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <20240821184615.GA262749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819023413.1109779-1-ying.huang@intel.com>

On Mon, Aug 19, 2024 at 10:34:13AM +0800, Huang Ying wrote:
> On a system with CXL memory installed, the resource tree (/proc/iomem)
> related to CXL memory looks like something as follows.
> 
> 490000000-50fffffff : CXL Window 0
>   490000000-50fffffff : region0
>     490000000-50fffffff : dax0.0
>       490000000-50fffffff : System RAM (kmem)

I think the subject is too specific (the problem is something to do
with the tree topology, not the fact that it's "CXL memory") and at
the same time not specific enough ("fix" doesn't say anything about
what was wrong or how it is fixed).

IMO it could be improved by saying something about what is different
about CXL, e.g., maybe it could mention checking children in addition
to top-level resources.

> When the following command line is run to try writing some memory in
> CXL memory range,
> 
>  $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
>  dd: error writing '/dev/mem': Bad address
>  1+0 records in
>  0+0 records out
>  0 bytes copied, 0.0283507 s, 0.0 kB/s

Took me a minute, but I guess the connection is that
19136512 * 1k = 0x490000000, which is the beginning of the CXL Window.

> the command fails as expected.  However, the error code is wrong.  It
> should be "Operation not permitted" instead of "Bad address".  And,
> the following warning is reported in kernel log.

This intro makes it sound like the problem being solved is the error
code being wrong.  But it seems like a more serious problem than that.

>  ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff

Incidental: it seems a little weird that this warning only exists on
x86 and mips (and powerpc32 has a similar warning with different
wording), but I assume we don't want to ioremap RAM on *any*
architecture?

>  WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
>  Modules linked in: cxl_pmem libnvdimm cbc encrypted_keys cxl_pmu
>  CPU: 2 UID: 0 PID: 416 Comm: dd Not tainted 6.11.0-rc3-kvm #40
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:__ioremap_caller.constprop.0+0x131/0x35d
> ...

> In the above resource tree, "System RAM" is a descendant of "CXL
> Window 0" instead of a top level resource.  So, region_intersects()
> will report no System RAM resources in the CXL memory region
> incorrectly, because it only checks the top level resources.
> Consequently, devmem_is_allowed() will return 1 (allow access via
> /dev/mem) for CXL memory region incorrectly.  Fortunately, ioremap()
> doesn't allow to map System RAM and reject the access.
> 
> However, region_intersects() needs to be fixed to work correctly with
> the resources tree with CXL Window as above.  To fix it, if we found a
> unmatched resource in the top level, we will continue to search
> matched resources in its descendant resources.  So, we will not miss
> any matched resources in resource tree anymore.  In the new
> implementation,
> 
> |------------- "CXL Window 0" ------------|
> |-- "System RAM" --|
> 
> will look as if
> 
> |-- "System RAM" --||-- "CXL Window 0a" --|

Where did "0a" come from?  The /proc/iomem above mentioned
"CXL Window 0"; is the "a" spurious?  Same question applies to the
code comment below.

> in effect.
> +		 * |------------- "CXL Window 0" ------------|
> +		 * |-- "System RAM" --|
> +		 *
> +		 * looks as if
> +		 *
> +		 * |-- "System RAM" --||-- "CXL Window 0a" --|
> +		 *
> +		 * in effect.
