Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5D22687B
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839835; cv=none; b=bcQ4KHpP8QL1TRl+X1y/YhHw0htS4SpSUmOgQe1ipjj+PJWV4hGYOPzjm70GzDzKiixtbT0pi8u+ZqEIWSUwnYfTkQhn1xnF9UU+6TzU6u8HoXL0vkAviPqEbzrnGbF+B1h8jEuGn6DevqSZHfHHvooWZZjcDbfHQrJc9nalcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839835; c=relaxed/simple;
	bh=2AEJqQfbzdnSyosbfEj7/ER7gJN9+y67xJxSFeV7wdk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv//YM1Ftu9M9CEXL+GLddOY1wTliiqmNKOhLaEP+6/Bn358jHHQ9FHGxmBkfsPU5E5sV4C6CMUQnuayIpsvtF2mRmpF2sbZd3BZohj3ScfF6aXgsnjPryWHnCx8jP4C4EDpkwsboo+ze7f4IvhpxdHGr/x69SOvaH98YGsB4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpZ0Q3KBpz6L5RZ;
	Thu,  6 Feb 2025 19:01:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BCDC31408F9;
	Thu,  6 Feb 2025 19:03:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Feb
 2025 12:03:51 +0100
Date: Thu, 6 Feb 2025 11:03:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 05/16] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <20250206110349.00006de1@huawei.com>
In-Reply-To: <67a3f0502e793_2d2c29496@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
	<20250204220430.4146187-6-dave.jiang@intel.com>
	<67a2b6d345b61_2d2c2943c@dwillia2-xfh.jf.intel.com.notmuch>
	<20250205175740.000079ab@huawei.com>
	<67a3f0502e793_2d2c29496@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 5 Feb 2025 15:12:16 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > So I see this is exported to a new cxl_fwtcl.ko module, but I think all
> > > of this can be core built-in functionality similar to memdev ioctl and
> > > firmware upload support. As long as distributions can opt-out of FWCTL
> > > and Features at build time then this is no worse than
> > > CONFIG_CXL_MEM_RAW_COMMANDS from a proprietary use case / security model
> > > stance. With that software only needs to worry about finding a
> > > cxl_memdev object and not manually loading a cxl_fwctl module.  
> > 
> > It'll get exported shortly anyway as it's used by the EDAC series
> > and that should be separate modules.    
> 
> What additional modules are needed for EDAC support? The registration is
> done by the cxl_mem and cxl_region drivers. Are you thinking of a pure
> helper library module to the CXL core?
> 
> Does it really matter if it's a separate module if cxl_core.ko is going
> to demand load it always?

I've lost track of all the reorganizing.  Might indeed not be needed
because it is wrapped up other calls that are in the cxl core.

I'll let Shiju figure that out when rebasing!  Note the two sets may
well race as I don't want to hold the discussion on remaining 
controversial bits of that set whilst Dave refactors this one.
The need to eventually rebase on this doesn't stop the EDAC core bits
going forwards.

Jonathan

