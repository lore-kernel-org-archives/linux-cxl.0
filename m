Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DD649A3AF;
	Thu, 17 Sep 2026 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679188; cv=none; b=ibE+6XFODbaBdyRwaCsoEvk67yGJgMbqXuOnfUgJva7fNAlw3+1JxjydYB9LlO0WoNxkVrOkDx5C1lIc/+1LtQdBQZMwBXE/UGdwzMe2DK68N9zujifhFs+9UXLpB6Vd8oWdvpuCZPfT+lZBaPfTZuqgVeDTppSvioZZkTu6eU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679188; c=relaxed/simple;
	bh=fvB176lIRo/bk5Bt4yXpF0lisEAMT+ENGE704peIYUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rta3bLCMKGBz0WJYuZR2H//Ok14KPnXr+QFVFePQll+ZwAwYZ1pw8cFUZyslOWTptJco6uMNtaqZ84yWOBzyPSAwl6S91tmiHyIE4nTN6jlxe19PHpkOqPUUkV35UQtjz0MIITcbQe4G9OO6Ywp8q/h9ca3aasg/DtXffne5aoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsVRn3mq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsVRn3mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E4A1F000FF;
	Thu, 17 Sep 2026 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679187;
	bh=bPO5GfzoUaFNNY93ukNknYL7uMiuEfhMiNhftV/7Gp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nsVRn3mqwdbxNt2RQoYP0mLp0BQvO6Oyl1iN47gIAyFGfg/j5CRv7xFU2at3M1EuX
	 EMHwx71FthDvIXlmes6ogrJ7BJPd+hQQ2uXG51Fm48eHrz3Og5tHULVgDC1b5Vc2Eu
	 8rC6aCZqZUcBUI+KmJG1gum7zaZHfxn4Ip0dDCuP38MLv6ce5Nb2Y3JUWFC2eo2Vjm
	 6nVc+QeTsIW0PEzyqqKfydIgK7jCV74ZRjuc/yoDsUM7S8anyHpVTVBlXb9S1O60Vm
	 zA3plTAyIIx0t4YXmCETEHFv6/zKH3X7jo4lloIQSpzV/hQAcpPQNOddKrR/GuxncY
	 cyoaVBnavqDAA==
Date: Thu, 17 Sep 2026 22:06:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Guixin Liu" <kanie@linux.alibaba.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Create node access attributes for
 CFMWS-only NUMA nodes
Message-ID: <20260917220624.459e8065@jic23-hlaptop>
In-Reply-To: <20260917030049.BD8711F000FF@smtp.kernel.org>
References: <20260917024632.1397380-1-kanie@linux.alibaba.com>
	<20260917030049.BD8711F000FF@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 03:00:49 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] cxl/region: missing access attributes for SRAT nodes without HMAT
> --
> 
> commit 2503e3249f202233ccb3653d33cc651692452053
> Author: Guixin Liu <kanie@linux.alibaba.com>
> 
> cxl/region: Create node access attributes for CFMWS-only NUMA nodes
> 
> A NUMA node that only backs a CXL fixed memory window and is not
> enumerated by SRAT has no memory_target in the HMAT code, so
> hmat_callback() exits early at find_mem_target() and never creates
> the node's accessN attributes. Create the attributes with
> node_set_perf_attrs() when the node is not backed by a real SRAT pxm.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f54acbf68e844..5ef0ca0694ff1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c  
> [ ... ]
> > @@ -2631,7 +2632,19 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
> >  
> >  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> >  		if (cxlr->coord[i].read_bandwidth) {
> > -			node_update_perf_attrs(nid, &cxlr->coord[i], i);
> > +			/*
> > +			 * A CFMWS-only node (not backed by a real SRAT pxm)
> > +			 * has no HMAT memory_target, so hmat_callback()
> > +			 * never created the access attributes for it:
> > +			 * create them here instead of only updating them.
> > +			 * This is called at most once per node (see
> > +			 * nodemask_region_seen), so the attributes are not
> > +			 * created twice.
> > +			 */
> > +			if (!acpi_node_backed_by_real_pxm(nid))
> > +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
> > +			else
> > +				node_update_perf_attrs(nid, &cxlr->coord[i], i);  
> 
> [Severity: Medium]
> Will this silently drop access attributes for SRAT nodes that lack HMAT
> entries?
> 
> If the system provides an ACPI SRAT table that enumerates a NUMA node,
> acpi_node_backed_by_real_pxm() will return true. However, if there is no
> corresponding HMAT table or entry, hmat_callback() exits early and never
> calls node_set_perf_attrs() to create the node's access attributes.
> 
> When CXL regions later come online, cxl_region_update_coordinates() checks
> acpi_node_backed_by_real_pxm(), which evaluates to true. It therefore calls
> node_update_perf_attrs() instead of node_set_perf_attrs(). 
> 
> Because the attributes were never created, node_update_perf_attrs() finds
> an empty node->access_list and silently returns, which drops CXL access
> coordinate sysfs attributes and NUMA mempolicy updates. Using an ACPI
> topology check to guess the initialization state of generic struct node
> sysfs attributes leaves the underlying bug unresolved for standard SRAT
> nodes lacking HMAT data.
> 

If there is no HMAT, there is no perf data to the generic ports and
none of this can be created or updated anyway.

Jonathan

> >  			cset++;
> >  		}
> >  	}  
> 

