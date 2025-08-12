Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBE2ED149
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010412; cv=none; b=h8KL5hl2x6xZPOSf648j0V/2XWd6IZP2Hcjzk1+ga86k2rnPqmRtwSvCp+q5k+spFxS5+Td9f6NLNrPvaueg1wCdyZ0xEjk/oX4ME4ARQX2LUB/5in0/5Q3+fW5+CtuQrHS/jwFCbBf5+BNRKgrrqJQFK3/N5JS+Rofrci6a5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010412; c=relaxed/simple;
	bh=i9GFLcyQTUBynLRsFNDvSrSDC5u5Sq/0cvFGVEnJLPk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb1JdK5EGE+ysbWU9xXip8GSDmJ7Saopj56Excwj9VITTENhGjuFInBDPjMnhhmUYUmFx+det72EVXT5vb5+hHmPnEwgb/c0oVVFILXuY656w72JVSv+FGDXXH9zi7AjzhXaL5g/EAggYdRmCDqespACipLyZ3lT4wcpc92Lans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1ZF40Lpcz6L5F1;
	Tue, 12 Aug 2025 22:50:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E42C01402FF;
	Tue, 12 Aug 2025 22:53:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 16:53:25 +0200
Date: Tue, 12 Aug 2025 15:53:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] cxl: Initial support for Back-Invalidate
Message-ID: <20250812155324.00001aa2@huawei.com>
In-Reply-To: <20250812010228.2589787-1-dave@stgolabs.net>
References: <20250812010228.2589787-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 11 Aug 2025 18:02:25 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Hello,
> 
> The following is some initial plumbing to enabling HDM-DB in Linux. This model allows devices,
> specifically Type 2 and Type 3 devices, to expose their local memory to the host CPU in a
> coherent manner, In alignment with what was discussed at last year's LPC type2 support session,
> this series takes the type3 memory expander approach, which is more direct.
> 
> While this is an early RFC and I'm sure many thoughts, the next phase of this would be to
> integrate Bi with Alejandro's Type2 work as well as with Jonathan's Cache Coherency subsystem
> series (aka memregion inv)... this might be a good topic for the upcoming LPC's devmem session:
> 	https://lore.kernel.org/linux-cxl/20250624141355.269056-1-alejandro.lucero-palau@amd.com
> 	https://lore.kernel.org/linux-cxl/20250624154805.66985-1-Jonathan.Cameron@huawei.com

Hi Davidlohr,

For type 3 devices, when are HDM-DB / BI flows this useful?
I think it's worth calling those cases out.

IIRC 
- Shared coherent memory
- Media operations (8.2.10.9.5.3 in 3.2 spec)
   So the range based sanitize and zero stuff.

But not I think on DCD extent add or remove.  Which is kind of fair enough as
the device would have to track prefetches that occurred to addresses it wasn't
backing at the time. 

So I'm not immediately sure how it will combine with explicit cache coherency management.
So far we haven't hooked anything up for non BI enabled shared memory.

For type 2, do we have a BI capable example?

> 
> o Patch 1 adds the BI cachemem register discovery along with two interfaces around cxlds to allow
> the setup and deallocations of BI-IDs. The idea is for type3 memdevs and future type2 devices
> to make use of cxlds->bi when committing HDM decoders, such that different device coherence models
> can be differentiated as:
> 
> 	type2 hdm-db: cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == true
> 	type2 hdm-d:  cxlds->type == CXL_DEVTYPE_DEVMEM && cxlds->bi == false
> 	type3 hdm-h:  cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == false
> 	type3 hdm-db: cxlds->type == CXL_DEVTYPE_CLASSMEM && cxlds->bi == true
> 	
> Because ->bi becoming true does not depend on auto-committing upon HDM decoder port/enumeration
> (port driver), for now this is set as unsupported and will error out when initializing the HDM
> decoder that has its BI bit set.
> 
> o Patch 2 renames/updates some of the CXL Window coherency restrictions. This should be picked
> up regardless as the spec has been updated already.
> 
> o Patch 3 deals with the HDM decoder programming changes around whether or not to set the
> BI bit. Based on the model above, decoder target types are straightforward: DEVMEM or HOSTONLY
> for type2 and regular type3, but for type3 HDM-DB, this is not as clear, for which this patch
> will 1) rely on the HDM capability for supporting coherence models, and 2) allow, when possible,
> to change it by the user when configuring the BI-capable HDM decoder. It gives the user sysfs
> tools to create BI-enabled memory regions (see testing below).



