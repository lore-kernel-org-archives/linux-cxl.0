Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8A1C6B2
	for <linux-cxl@vger.kernel.org>; Thu,  7 Mar 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814660; cv=none; b=mUgjaa5imEp91R6T96yeI4wWMYAcfbr4ISuS4rj/tOmGheXuXaKimv1n/t7l3XKFdKCIgU3xavRwfIHgDq6wiC92Vuw+w3mq5LJtAXIGo0e7KToqeagreNdyGXd8D1Jq+r2FEI6BEmTCF1rT9QERoDyVEHE8pu3s7QvYZ8XBkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814660; c=relaxed/simple;
	bh=Uhw8sOHIKPM3Y+QSobxe2h3RcJTrlRt9fHjjv+NX+wM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOfq+gKSqMFrvKI4NPCEMoV3y6S7qFTjiTad/7tmMkcIJJKif46LMiwCf9W3eVydAybgAbdBqk+Id6rbQudLNyNB4PhiKHYum27hPyjD3DQfJtvsvn9Unrz0xvBpl58gNchYClR29r476HAKzZuO8j6NLnEpitzGQP5lvo1Rg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr7nT09YBz6K61Q;
	Thu,  7 Mar 2024 20:26:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B175A140736;
	Thu,  7 Mar 2024 20:30:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:30:45 +0000
Date: Thu, 7 Mar 2024 12:30:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 08/13] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <20240307123044.00000ec1@Huawei.com>
In-Reply-To: <ZejvipUwjO-ZRT6y@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-9-nifan.cxl@gmail.com>
	<20240306172827.000052dc@Huawei.com>
	<ZejvipUwjO-ZRT6y@debian>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > > +{
> > > +    CXLDCExtent *ent;
> > > +
> > > +    while (!QTAILQ_EMPTY(&ct3d->dc.extents)) {
> > > +        ent = QTAILQ_FIRST(&ct3d->dc.extents);
> > > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);  
> > 
> > Isn't this same a something like.
> >     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node)) {
> > 	cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> >         //This wrapper is small enough I'd be tempted to just have the
> >         //code inline at the places it's called.
> >   
> We will have more to release after we introduce pending list as well as
> bitmap. Keep it?
ok. 
> 
> Fan
> 
> >     }  
> > > +    }
> > > +}  
> >   

