Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E23DDDB0;
	Wed, 18 Mar 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845802; cv=none; b=aU9hdXCuXwZYjcf56fv85tAU3VurR0uHwFyIqUf/jOWLYygfnIlbYDMcA+q4UFyeFjri/LRs5Hte9WSB14EV1soYeuDf4fD2Es6Z9p2RrkWI4UhwWXz3LwHja/iT/XwWuRbaNcCNbuL/cnlmz3qcwUfcqTACvGDQmhN33Zj88pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845802; c=relaxed/simple;
	bh=ondXDKAspsi+lyldExZ5vp52UgylkV7tkuzxxV8xEE0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdnvNuY9NWZalKl8lyh/5QDxegHXGktP8kACmZvLYfuRVxgLGWoV2tYyLAfMvOyXDO+4d+vtuT5rGPvDMLI0glioxnlBgiamoA2aIWQ4AD4oN31CmaJqD3vqNCLs398+Dva/TWcG81/8NYzSij5ZMKYuiqaQa4BfljR96wkQpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fbX2k1d5mzHnGcc;
	Wed, 18 Mar 2026 22:56:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id DB6EA40573;
	Wed, 18 Mar 2026 22:56:35 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 18 Mar
 2026 14:56:34 +0000
Date: Wed, 18 Mar 2026 14:56:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <mhonap@nvidia.com>, <aniketa@nvidia.com>, <ankita@nvidia.com>,
	<alwilliamson@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
	<mochs@nvidia.com>, <skolothumtho@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>, <cjia@nvidia.com>,
	<targupta@nvidia.com>, <zhiw@nvidia.com>, <kjaju@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 03/20] cxl: Move CXL spec defines to public header
Message-ID: <20260318145633.0000392c@huawei.com>
In-Reply-To: <fd232cc5-f2ab-463f-9238-44e2514d4ad1@intel.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-4-mhonap@nvidia.com>
	<20260313121805.0000611e@huawei.com>
	<fd232cc5-f2ab-463f-9238-44e2514d4ad1@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 13 Mar 2026 09:56:10 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 3/13/26 5:18 AM, Jonathan Cameron wrote:
> > On Thu, 12 Mar 2026 02:04:23 +0530
> > mhonap@nvidia.com wrote:
> >   
> >> From: Manish Honap <mhonap@nvidia.com>
> >>
> >> HDM decoder capability structure and component reg block size
> >> needs to be used by VFIO subsystem. Move the macros from private
> >> CXL header to public one.
> >>
> >> Signed-off-by: Manish Honap <mhonap@nvidia.com>  
> > 
> > Not really related to this patch, but...
> > 
> > Maybe this is the time to think about doing a PCI like
> > uapi/linux/cxl_regs.h header?  
> 
> Sounds reasonable. Maybe makes sense to be in uapi/cxl/? There's already a features.h header in there.

Sure. I'd forgotten about that directory.
Jonathan
