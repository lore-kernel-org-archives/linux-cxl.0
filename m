Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7B820E001
	for <linux-cxl@vger.kernel.org>; Tue, 18 Mar 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308546; cv=none; b=se19/Ep57abFOvFeB8jLQpyZkzvPOSj+uZYF+asP88KLpaI8i4GbiBSzpe6Nromgi5Op8fj+fvQ3m5aT1j99vZN11ZWQEuFVOD2AFgdosMiLUnskKb+ZTUN7M3g+R8ks81fOzlOzG1BXu4sqwPt+hP+2yt9yEbAkr9zzbQKZXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308546; c=relaxed/simple;
	bh=5KjKyc/CyccD4S+rlmeRnDcrFUtvFcBf7SzOU02OMHU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXHAQtphnPnfUfhBZIFI1McMHVwq3qQJACYChT9g/frHaAtGTpiWEWM9Y0X8jpRRvvG8eXZiKljFyK3Lwe8FH2bN7PLM4CXuabHeutJQ939xMu2Sj/kp0FZdIKhZqBnuV/prv4FaJF+kcgK+SagkqP0pjvJ2+Q/3dD/dd/lmjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZHDnh2JS9z6DB6F;
	Tue, 18 Mar 2025 22:32:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 74FA414062A;
	Tue, 18 Mar 2025 22:35:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Mar
 2025 15:35:41 +0100
Date: Tue, 18 Mar 2025 14:35:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
Message-ID: <20250318143539.00002575@huawei.com>
In-Reply-To: <Z9jjqPopE2IF5VXn@aschofie-mobl2.lan>
References: <20250306232239.2609017-1-alison.schofield@intel.com>
	<20250314120036.000034a9@huawei.com>
	<Z9jjqPopE2IF5VXn@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Mar 2025 20:08:24 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Mar 14, 2025 at 12:00:36PM +0000, Jonathan Cameron wrote:
> > On Thu,  6 Mar 2025 15:22:37 -0800
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > The CXL driver requires the granularity of a region and its root
> > > decoder to be the same. This is particularly restrictive for 3-way
> > > host bridge interleaves where the only spec defined interleave
> > > configurations for creating 6-way and 12-way regions on a 3-way HB
> > > interleave require mixed granularities.
> > > 
> > > CXL 3.2 Specification 9.13.1.1:
> > > Legal Interleaving Configurations: 12-way, 6-way, and 3-way  
> > 
> > Ah this is finally a valid reason to do coarser interleave first
> > (going away from host). That was subject of long discussions way back
> > when original interleaving code was discussed (mostly because
> > my mental model did it that way around and I couldn't follow what
> > the kernel code was doing).
> > 
> > We 'could' revisit allowing this more generally - at least for
> > already configured set ups.  Only real reason for that is
> > either that someone ships a config that does it for a different
> > case, or that we want to avoid special casing 3*x cases.  
> 
> Hi Jonathan,
> 
> I'll bring these configs up as an OPEN at the upcoming community collab,
> and hope you can elaborate more there.
> 

Sure. I'll try and remember how all this worked!

I'm not really suggesting we do handle those other cases unless we know
they are in the wild or it simplifies the code by removing special cases
(I'm not sure it does!)

Jonathan

> --Alison
> 
> 
> > 
> > Jonathan  
> 

