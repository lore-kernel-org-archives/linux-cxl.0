Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6021382D9C
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814021; cv=none; b=pvdR0X64dIBl9NX9sL2+ynvky3OzjKwNFj3cPDtFV6fyyiieb40l4MOZ1Kkd+ufuBnlpZ8cO/PjCi9VC11SOSZSQMZ2HQmE4FxWDgbcb0WL2M+e6XfTqxuXavOWVPfPxuCqnbn2b3XO7AyXu589lCsRTOfAOv1fDwuInZTfn94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814021; c=relaxed/simple;
	bh=5HJkSTrJCL/upQ+22qSQqO6q12frFKDl9upFdK01dHM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzh+HuK7L/Swob8a4461jg/7fH2ZOk7/RJPbeRQI+dZ3QNpCUDaJAxkWQblHkSdSNKYLznkzKF9dmiv6Jl5/L9mf37vNtWEsNwRvhaiZIApuqgEYZNQ89+F274RqE+EbGLos8J0OcM1GC/YKL8HnIl67D+K6TYMUSX1t+rwHNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr7ZB3wPxz6K9GS;
	Thu,  7 Mar 2024 20:16:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B52FA140D26;
	Thu,  7 Mar 2024 20:20:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:20:16 +0000
Date: Thu, 7 Mar 2024 12:20:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 08/13] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240307122015.00000b6a@Huawei.com>
In-Reply-To: <ZejipnoILw6_Z-Cl@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-9-nifan.cxl@gmail.com>
	<20240306172827.000052dc@Huawei.com>
	<ZejipnoILw6_Z-Cl@debian>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 6 Mar 2024 13:39:50 -0800
fan <nifan.cxl@gmail.com> wrote:



> > > +                    }
> > > +                    if (len2) {
> > > +                        cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> > > +                                                         len2, NULL, 0);
> > > +                        ct3d->dc.total_extent_count += 1;
> > > +                    }
> > > +                    break;  
> > Maybe this makes sense after the support below is added, but at this
> > point in the series 
> > 			return CXL_MBOX_SUCCESS;
> > then found isn't relevant so can drop that. Looks like you drop it later in the
> > series anyway.  
> 
> We cannot return directly as we have more extents to release.

Ah good point. I'd missed the double loop.

> One thing I think I need to add is a dry run to test if any extent in
> the income list is not contained by an extent in the extent list and
> return error before starting to do the real release. The spec just says
> we need to return invalid PA but not specify whether we should update the list
> until we found a "bad" extent or reject the request directly. Current code
> leaves a situation where we may have updated the extent list until we found a
> "bad" extent to release.

Yes, I'm not sure on the correct answer to this either. My assumption is that in
error cases there are no side effects, but I don't see a clear statement of that.

So I think we are in the world of best practice, not spec compliance.
If we wanted to recover from such an error case we'd have to verify the current
extent list.  I'll fire off a question to relevant folk in appropriate forum.

Jonathan

