Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336B181BA7
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496069; cv=none; b=EocrzPfckma4OkxHqm+x0kg1NMbQ9os8c76fCFZbsKDI0p9d3JOTtK+K0AsJRNeZud7QsHq62jZ2QobI4JN8WOTYIuBUIKrJFbVUyD9dZUo9fk3I9vGwGaX++ZYEgnZWpYxuHQkTn5ItGG+P9BWKDn5vxoVVX4urJ3u8XIAlOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496069; c=relaxed/simple;
	bh=Ku6ula7mH3d+zVzqSj+/4lVsY9mO5LYKwI9qfc7vRaQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZ8d1z6jSnJxdUVqgA+elSU4ejzdgaTWiQEDw0keTog66WHAJmoCfviAVBrbKQLP7Xn9HXeDoPi8WTRgPgx+4jHaoxoDPzqefOLT5Ld1hgcS0cCONtMjEHyK7UHGONHcV2bHGjY1PdoX8rulruX8o+mxJH6nrTNJ5RA+MDsAKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTR772KWRz67HtH;
	Wed,  1 May 2024 00:51:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DA177140518;
	Wed,  1 May 2024 00:54:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 30 Apr
 2024 17:54:24 +0100
Date: Tue, 30 Apr 2024 17:54:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: Fix cxl_endpoint_get_perf_coordinate() support for
 RCH
Message-ID: <20240430175423.00003589@Huawei.com>
In-Reply-To: <Zi-RNOZ7OlK6rbuA@rric.localdomain>
References: <20240426224913.1027420-1-dave.jiang@intel.com>
	<662c425f15f73_b6e0294dd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<Zi-RNOZ7OlK6rbuA@rric.localdomain>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Apr 2024 14:23:16 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 26.04.24 17:10:07, Dan Williams wrote:
> > Now, that said, if someone can think of why the driver needs to do
> > dynamic performance enumeration for RCH (i.e. a platform BIOS does not
> > populate HMAT), they should speak up now.  

It would have to selectively populate HMAT as we'd need the
Generic Port distances anyway.  That is an odd corner indeed.

Agreed on disabling it until someone shouts.

> 
> I wouldn't stick with that forever as you never know, but for now
> disabling it for RCDs looks good to me to fix this, esp. considering
> we are already at -rc6.
> 
> E.g I found in cxl-3.1, 9.11.6 RCD Discovery:
> 
> """
> In the future, a
> CXL-aware OS may extract this information directly from the device via
> Table Access DOE.
> """
> 
> Thanks,
> 
> -Robert

