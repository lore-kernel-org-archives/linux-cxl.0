Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375E37C928;
	Tue, 17 Mar 2026 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770354; cv=none; b=mvm/53Ej8BVUEXkA5CUu3GKpYCvgOkis2v+RBmLxe7JYl1FOPr0zDe9uVwbGV6Hobol2IzPnTSRB2IhSKiCpkN39wX+YTX0SgIv+coNBYcn8IPDKulBAi+z33TMEgynpnPzCqF1eWS3tQNjRdGtUxcGCctMQ/nMr9y5rSB71g6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770354; c=relaxed/simple;
	bh=fNdBPx5e+Y6DO1+P3mk65cZ+h5F23E8u87RAEBPi9hw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgrzuIa1GnbqKWts5X7pk/ONBnCCEjh82gBE1oAi6kAnTMMeZOKqPg9KKRp8wAcXZuJu+QReN631toBBKJ+fQL0sohcV31Gyu9tv8GnYywslg2LcS71aB/P61IvTSnIADaSOy0ufymH6LRI5lPk7XCdzGzH48HTSKprxJFTw8cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fb07B4clBzJ467f;
	Wed, 18 Mar 2026 01:58:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 18C514056B;
	Wed, 18 Mar 2026 01:59:11 +0800 (CST)
Received: from localhost (10.48.149.62) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 17:59:10 +0000
Date: Tue, 17 Mar 2026 17:59:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Teshan Kannangara <tpk.teshan@gmail.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Fix coding style issues in acpi.c
Message-ID: <20260317175909.00006cee@huawei.com>
In-Reply-To: <2aa6594d-3277-4637-af6a-9be11400d05d@intel.com>
References: <ablFdTrypTz67N0D@the-machine>
	<2aa6594d-3277-4637-af6a-9be11400d05d@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 17 Mar 2026 07:48:17 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 3/17/26 5:13 AM, Teshan Kannangara wrote:
> > Fix various coding style issues in drivers/cxl/acpi.c, including
> > indentation, line wrapping, macro alignment, cast formatting,
> > and conditional braces.  
> 
> Hi Teshan,
> Thank you for the code changes. While we appreciate it, I'm going to NAK the changes. For this sub-system, we are not going to make style changes or fixes unless it's part of functional code changes or refactor. The reason is to not introduce unnecessary churns to the code that can make fix backports difficult later on. Thanks.
> 
> DJ

I'm going to give it a quick review on the first item at least.

> 
> > 
> > No functional changes.
> > 
> > Signed-off-by: Teshan Kannangara <tpk.teshan@gmail.com>
> > ---
> >  drivers/cxl/acpi.c | 26 +++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 127537628817..b54b962cf973 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -395,9 +395,16 @@ static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
> >  	cxlrd->cache_size = cache_size;
> >  }
> >  
> > -DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> > -	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
> > -DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
> > +DEFINE_FREE
> > +(put_cxlrd, struct cxl_root_decoder *,
> > +if (!IS_ERR_OR_NULL(_T))
> > +	put_device(&_T->cxlsd.cxld.dev))
> > +
> > +DEFINE_FREE
> > +(del_cxl_resource, struct resource *,
> > +if (_T)
> > +	del_cxl_resource(_T))
> > +
Why? the original code was the standard way to format these and
there is no explanation of the change in the commit message.
Is it because it's over 80 chars long?  That is guidance only and
if readability is hurt (like here) feel free to go up to 100 chars
before worrying about it.




