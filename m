Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66A1CB9E2
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011329; cv=none; b=bmQlX9s23rP3pKjaE6YEUadU8lftwX+nTIwaVO8qBjWdhyVI+dFsfY+CDvJnLJngYbFqUn7hyUpY18G/WvryyZOiN/6FYBi/9TTOKPef1keNrTJhEz5dSY9IgNx+1WMRZzR3PuPk43CcRRBjcxNyMiXDITop+RepZOQyX2Z6PpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011329; c=relaxed/simple;
	bh=abmKxsVyYG8w0lnnEFg/vh7gIrTWRHT1f08CrrSr3Jo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWhk1sJMTBCROaFapahxke6vaPbEriAx1jiLjJRayoUczisfnUdmpBiz8A8E91U09TDeI5ua6nSD38IperZSYsJ5qywKPj3Xfiykrft99iudSB08SLEM82X0xDI8x1mBZockerwJG72tGPJ++cv1+8v0toCmkketwAdHHhyT0Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSgCv0qXbz6K66M;
	Wed, 16 Oct 2024 00:53:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D90E140A77;
	Wed, 16 Oct 2024 00:55:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 18:55:24 +0200
Date: Tue, 15 Oct 2024 17:55:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Will Deacon <will@kernel.org>
CC: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<mark.rutland@arm.com>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
	<linux-cxl@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <20241015175523.00004d85@Huawei.com>
In-Reply-To: <20241014141551.GA17702@willie-the-truck>
References: <20241010025208.180458-1-dave@stgolabs.net>
	<670937ce7b7fd_9533f294b2@iweiny-mobl.notmuch>
	<20241014141551.GA17702@willie-the-truck>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 15:15:52 +0100
Will Deacon <will@kernel.org> wrote:

> On Fri, Oct 11, 2024 at 09:35:58AM -0500, Ira Weiny wrote:
> > Davidlohr Bueso wrote:  
> > > Update the CXL PMU driver to support the new events introduced
> > > in the latest revision. These are:
> > > 
> > > - read/write accesses with TEE constraints.
> > > - S2M indicating Modified state.
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > Just to be sure: Jonathan you are taking this through CPMU correct?  
> 
> I was about to pick it up via the perf tree, so I'll hold fire until we
> hear back from Jonathan.
> 
> Will
> 

Hi Will,

Please pick it up via the perf tree. That driver isn't big enough to warrant
separate handling and this stuff won't impact the CXL tree.

Thanks,

Jonathan
