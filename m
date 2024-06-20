Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E921B29C1
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905549; cv=none; b=AxYGrZ+2rQwxb4ANl1WjROns8W3e+D66sUm2+9JDfoajUCz5nBdvoxrByfD0C2nNZmMyGnlpLH+n4LolZOQYrQ3AXnU0yO+0Oup0e0qkEi+/IEfRD1fIwqq3aP+HlestqvjznABpOL6VGZvVnmbXSUNma5M4h1qZ/bom6tOXFro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905549; c=relaxed/simple;
	bh=XOwNc6dLGOy86io2R+RNVlyBfA3E/E8Ktuof6MS0iLo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug6hME2HYzruKSheywgNkwf1C2JhLWj2L/vJheoI7lHdAmKELSKLgx4juGA2Z700OsH84YnCqIOZzV2YDlssH11uzAPw86LaWeBdNelH446WOsxeoQvhXhf8VDQe974PEgOdMLtvb89YPl5L7+zeWogoqwreYNGerkMVZTBxNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4nvp3K3yz6J9x8;
	Fri, 21 Jun 2024 01:45:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EACBB1402C6;
	Fri, 21 Jun 2024 01:45:44 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 18:45:44 +0100
Date: Thu, 20 Jun 2024 18:45:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, Adam Manzanares
	<a.manzanares@samsung.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <20240620184543.00004ff1@Huawei.com>
In-Reply-To: <6670bdb69f996_3101294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
	<20240606154001.00000507@Huawei.com>
	<6670bdb69f996_3101294b8@dwillia2-xfh.jf.intel.com.notmuch>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

ling, or kernel enabling not required
> > > +
> > > +Feature and Capabilities
> > > +========================
> > > +
> > > +Enumeration / Provisioning
> > > +--------------------------
> > > +All of the fundamental enumeration an object model of the subsystem is
> > > +in place, but there are several corner cases that are pending closure.
> > > +  
> > 
> > Feels like we should in passing mention that we support none of the
> > bits of CXL fabrics that are host visible (so mainly G-FAM I think).
> > 
> > [0] Fabrics / G-FAM (chapter 7)
> > [0] Global Access Enpoint  
> 
> Are those [0] or [X], not even sure what the kernel is expected to do with those?

I'm not 100% sure, but they are host programmable and there
are a bunch of more general structures to program that are
'kind of like' the hdm decoders with stuff like interleave
setup.  So I think [0] but I've really not figure out the expected
software model for that stuff yet.

Jonathan

