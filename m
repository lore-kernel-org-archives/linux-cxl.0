Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842E12BEA5
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815630; cv=none; b=jq0TvG+tZ1voGvFyEOTYa6wqdSKJ9xA1QYvx5P91ZVf+XX717bDNjo0qKmv9wTpzbej9hC8UcsuSVrT4l568DnD8QkLytWgGr+G+VJ6Vi7kaWcp98aoTOEySbf2Q0+/22I2gM/Ofhto7/kRNVZQbw/xrjCO5cuLWehdKCq9fDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815630; c=relaxed/simple;
	bh=305klTfSlctq+gmJ/DEUasdhnvrUvdg7gOO7p11lGFM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APqHn1djoIZnGMYhZ8W3TKY0YLCqb4dsCBw4OexTaHWxDNxngxouPpGyYo6Qyl/BSVB+ObQWE1Tm82GKoMOA/TjmexWduX4H0f5EySbjC6oIWjy1rcxETVUoxTTf4SrpzNXs9/I0hsYjDrDyxYl4WDSc4JOKi78piUP2KaUve9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr8Fg01mBz6JB7t;
	Thu,  7 Mar 2024 20:47:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0174C140DAF;
	Thu,  7 Mar 2024 20:47:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:47:05 +0000
Date: Thu, 7 Mar 2024 12:47:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 09/13] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240307124704.000068fb@Huawei.com>
In-Reply-To: <Zej-Bg7ooVyswHXZ@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-10-nifan.cxl@gmail.com>
	<20240306174811.000029fd@Huawei.com>
	<Zej-Bg7ooVyswHXZ@debian>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >   
> > > +             * remove it from the pending extent list, so later when the add
> > > +             * response for the extent arrives, the device can reject the
> > > +             * extent as it is not in the pending list.
> > > +             */
> > > +            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> > > +                        &extents[i]);
> > > +            if (ent) {
> > > +                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> > > +                g_free(ent);
> > > +                skip_extent = true;
> > > +            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> > > +                /* If the exact extent is not in the accepted list, skip */
> > > +                skip_extent = true;
> > > +            }  
> > I think we need to reject case of some extents skipped and others not.
> > That's not supported yet so we need to complain if we get it at least. Maybe we need
> > to do two passes so we know this has happened early (or perhaps this is a later
> > patch in which case a todo here would help).  
> 
> If the second skip_extent case, I will reject earlier instead of
> skipping.
That was me misunderstanding the flow. I think this is fine as you have it already.

Jonathan
  

