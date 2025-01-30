Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A91E47B4;
	Thu, 30 Jan 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245149; cv=none; b=bbR36Nmb/7EjYQ740SW6J/Wyt23py1zCcZgN73tQU2KdN9p7Bj/vt0fob3sfB0x+NK1UJN9ZEopTOL2iJ7S39PVaFF2Ed8IfDDokhQTOczIsj8ey3h96kugWAG9xxhgYIWu8h3cgXkJtQ3ID8cqlUXCAGakcPDGBrBj321qBH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245149; c=relaxed/simple;
	bh=Hjvqi2y2L2JDEIZ53bqSE/CbrFVhGJvyvNXDAnto0z8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYYRnMEmQxOIQI5/pVnFlOzg2DgjWfhFg4boQd/Ji1ICDGXvFWbpp5/Hy4jyvDrIFKI+9oFFUPNKjVo+8Q29yXKjuXZJGTKfBuGJsT/KSMkioB5IckkSmSCv8+szKA+4DZvTrILErj2oiue6ePeam2yjY2ZqK/PLwDF5lBKSDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkL4n00bvz6M4Yk;
	Thu, 30 Jan 2025 21:50:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EB22B140517;
	Thu, 30 Jan 2025 21:52:23 +0800 (CST)
Received: from localhost (10.47.30.69) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 14:52:23 +0100
Date: Thu, 30 Jan 2025 13:52:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Message-ID: <20250130135220.00003637@huawei.com>
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
	<20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 28 Jan 2025 12:51:08 -0600
Ira Weiny <ira.weiny@intel.com> wrote:

> As was mentioned by Dan[1] cxl_memdev_state stores values which are only
> used during device probe.  This clutters the data structure and is a
> hindrance on code maintenance.  Those values are best handled with
> temporary variables.
> 
> Adjust the query of memory devices to read byte sizes in one call which
> takes partition information into account.  Use the values to create
> partitions for device state initialization.  Take care to separate the
> mailbox queries from the initialization of device state to steer the
> mbox code toward taking mailbox objects rather than memdev states.
> Update spec references while changing these calls.
Why not jump to 3.2? 
> 
> Link: https://lore.kernel.org/all/67871f05cd767_20f32947f@dwillia2-xfh.jf.intel.com.notmuch/ [1]
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not sure why you had this as an RFC!
Was it just that we are waiting for v3 from Dan?

If so maybe Dan, just stick these on the back of your series if you are
happen with these and make Dave's job a tiny bit easier (and so
rebases happen without needing to sync the two sets).

Jonathan
