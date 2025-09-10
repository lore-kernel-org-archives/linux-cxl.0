Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BB4A04
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507541; cv=none; b=Z4rpZgLjb+DLMeUunsvjif8qvAnW9Kte11ctnBhNtawUZFc+dvlw/d+QGQcXLcypAvF/VldsKGzlfVBd5SiuVq4ICfswNCEuyQV6KaDG08O9qtGrouC0xY8LIU+tIx22LrvRSHPkluVx25AG/Pf0CGnDvRc/TlQ3XU6Q0mNh0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507541; c=relaxed/simple;
	bh=YrkY4ancbl2pUd1rsDvlxFNH/vRqYq+e48ZI5QTc4sU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8LTD4ZAAIhZquc/Ne2G01N3ghbVQihkjcGUN1dY0A0JCnttqBGjvhCpUkehYSSufJrJVS+5jToEzbP9zLSUr6I1gLH2yjQzpAyvlGj04bnnn/fe4ij4IEm4iSNiZUxAuw8yU2Xr2YEw82k+ZjHOKtmrPzIbEzEGTfTNmhBJgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMKj06pDRz6K6ZX;
	Wed, 10 Sep 2025 20:28:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EBB61400C8;
	Wed, 10 Sep 2025 20:32:15 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 14:32:14 +0200
Date: Wed, 10 Sep 2025 13:32:13 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/region: Refactor address translation funcs
 for testing
Message-ID: <20250910133213.00004cb0@huawei.com>
In-Reply-To: <aMBnteQTnLZRwfvK@aschofie-mobl2.lan>
References: <cover.1756446925.git.alison.schofield@intel.com>
	<f0c6fa733cea8585f2bfda0851489bd7ca2e2b2c.1756446925.git.alison.schofield@intel.com>
	<20250909171005.000040f6@huawei.com>
	<aMBnteQTnLZRwfvK@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 9 Sep 2025 10:45:25 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Tue, Sep 09, 2025 at 05:10:05PM +0100, Jonathan Cameron wrote:
> > On Fri, 29 Aug 2025 00:21:25 -0700
> > Alison Schofield <alison.schofield@intel.com> wrote:
> >   
> > > In preparation for adding a test module that exercises the address
> > > translation calculations, extract the core calculations into stand-
> > > alone functions that operate on base parameters without dependencies
> > > on struct cxl_region.
> > > 
> > > Mark the new functions as static outside of test builds by adding
> > > and using a new __mock_export label.  
> > 
> > For the __mock_exports magic, I assume that can be applied in existing
> > cases as well.  Perhaps better to introduce it for them first?
> > That would give a nice clear example of what changes.  
> 
> I came upon this new-ish helper and intend to replace the __mock_exports
> magic with it in the next revision of this set.
> 
> 707f853d7fa3 ("module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper")
> 
> I think the existing cxl_num_decoders_committed can use the helper too,
> and if that works out I'll present it first as an example of using the
> new helper as you suggest.
> 
> Thanks for the review!
That does a rather different thing from what you had here, but I guess
if the aim is to make it unlikely anyone else makes use of these exports
and to act as documentation of why they are there it does the job.

Jonathan

> 
> >   
> 

