Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8C158862;
	Tue,  2 Jul 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961147; cv=none; b=eZH/qjOHEUSOPHCKzyRCZa4g+DrA4SbyJTd5L0nv9riAkzgwqgs6LvHZ7AT4+B9wg7069PEzqmWsV5tA6iii/Zss21aCsDi5CzYL9AG1uz9GBbRonyruW8jXq7siarwdagzG3GHmbUl7XiQSSl24+NtQL8kQDipKGnijgr08fiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961147; c=relaxed/simple;
	bh=1D59lPz/GEbhfqF+0FLdiOy+/mRTsjdN0bYfgfk5uAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZWZjvXJ06VtRC2Gc5k1pBaj7orqr0iCB4wjTKJG/vN6FoV4R9HpsAmg/vQD2UsooTS2Om88ps6MyjHdnIwxvp7q0AD21/cBBWqUTZIsvqU0RHsHN7Jz0t32vNgmotF9j8YXttjqJhRfct3UcCUDTu0gQsr6JNRFx4V9hAZ733w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLRVDT9L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLRVDT9L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719961146; x=1751497146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1D59lPz/GEbhfqF+0FLdiOy+/mRTsjdN0bYfgfk5uAw=;
  b=RLRVDT9LcNoaXkWE71TJgojEw7OAIsuXvXXvCSAGRI2neeLe7Yad0dXT
   xkNTbLLWe6C0vbkiHsUSdgnFFZ5b2PspZU35zvaNrhbw8lyIGqXd+8QM+
   npyC/2agSY52uwNQKduGH6iKQpuFfdJegMmUnG3uYYpkyBQxiNq5uTHhz
   3MJMRw7oUowI+oQrjT8/WE4kNPVVNmIu5DR2bvpNIW1rkcIJIMYsdWblH
   kvt7RfyxmfU6gFKKFxh3YeFsi5PzCTZnzuqiWK1DF1WrXQdTJJXxmG2p3
   IRosKBsqYUY9N0nMqkW76qMlzwQhikhMDvKn3CGErU5Cu+Sa5yk6/JBjW
   Q==;
X-CSE-ConnectionGUID: LTJFpcSsSumzx1PFwT3J1A==
X-CSE-MsgGUID: /2kyZY44SR+1TWfUQvkuag==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16822534"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="16822534"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:59:05 -0700
X-CSE-ConnectionGUID: e1kxnfziROW/W0920jCunQ==
X-CSE-MsgGUID: rdUEVHy4SrChGcbbeXYi2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="45833604"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.8.146])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 15:59:05 -0700
Date: Tue, 2 Jul 2024 15:59:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/acpi: Warn on mixed CXL VH and RCH/RCD Hierarchy
Message-ID: <ZoSGNuaAPuEQeq8B@aschofie-mobl2>
References: <20240628175535.272472-1-fabio.m.de.francesco@linux.intel.com>
 <ZoMq9TQoLTMaEPlJ@aschofie-mobl2>
 <2436432.YKUYFuaPT4@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2436432.YKUYFuaPT4@fdefranc-mobl3>

On Tue, Jul 02, 2024 at 09:14:51PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, July 2, 2024 12:17:25 AM GMT+2 Alison Schofield wrote:
> > On Fri, Jun 28, 2024 at 07:48:07PM +0200, Fabio M. De Francesco wrote:
> > > Each Host Bridge instance has a corresponding CXL Host Bridge Structure
> > > (CHBS) ACPI table that identifies its capabilities. CHBS tables can be
> > > two types (CXL 3.1 Table 9-21): The PCIe Root Complex Register Block
> > > (RCRB) and CXL Host Bridge Component Registers (CHBCR).
> > > 
> > > If a Host Bridge is attached to a device that is operating in Restricted
> > > CXL Device Mode (RCD), BIOS publishes an RCRB with the base address of
> > > registers that describe its capabilities (CXL 3.1 sec. 9.11).
> > > 
> > > Instead, the new (CXL 2.0+) Component registers can only be accessed
> > > by means of a base address published with a CHBCR (CXL 3.1 sec. 9.12).
> > > 
> > > If an eRCD (a device that forces the host-bridge into CXL 1.1 Restricted
> > > CXL Host mode) is attached to a CXL 2.0+ Host-Bridge, the current CXL
> > > specification does not define a mechanism for finding CXL-2.0-only
> > > root-port component registers like HDM decoders and Extended Security
> > > capability.
> > > 
> > > An algorithm to locate a CHBCR associated with an RCRB, would be too
> > > invasive to land without some concrete motivation.
> > > 
> > > Therefore, just print a message to inform of unsupported config.
> > > 
> > > Count how many different CHBS "Version" types are detected by
> > > cxl_get_chbs_iter(). Then make cxl_get_chbs() print a warning if that sum
> > > is greater than 1.
> > > 
> > > Tested-by: Alison Schofield <alison.schofield@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > > ---
> > > 
> > > --- Changes for v2 ---
> > > 
> > > 	- Rewrite the Subject line (Alison)
> > > 	- Address a bug found by Alison while testing (thanks!)
> > 
> > 'Address' a bug doesn't descibe what changed from v1 especially for
> > folks who reviewed v1.
> > 
> > I'm not asking you to rev this patch, just explain the saved_version
> > change.
> > 
> > Thanks
> > -- Alison
> >
> 
> Alison,
> 
> Thanks again for testing, and also for noticing that I didn't give any 
> explanation of the new saved_version variable and the solution I introduced to 
> fix the bug you found. Then...
> 
> During tests, Alison noticed that the CHBS iterator was testing chbs-
> >cxl_version always against UINT_MAX.  
> 
> ctx->cxl_version must be assigned, along with ctx->base, before returning from 
> the CHBS iterator, only if all 'if' statement evaluate false.
> 
> Therefore, don't test anymore against ctx->cxl_version. Instead save every new 
> different chbs->cxl_version in ctx->saved_version and test against this new 
> field at every iteration. 
> 
> Add an inline comment that briefly (and indirectly) refers to this logic. 
Thanks!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

>
snip

> 
