Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0932750ED
	for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530260; cv=none; b=IPPxe02tRIvvg3hFdIpmmNQgEoKX4+kQqTLIxSVUu8L4HvGoWJItP1BuEcrNL/ls40L+oOcHlTCuvAPtYAglKZxQNiubThJj2ez3hbO/sFDfVZ2XCxU9ucr7dkBdC7DCT5Pr2WYPSvR7skKY0DtqiwQq8gvTDMoKSkv8AvhTNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530260; c=relaxed/simple;
	bh=J/XjkfMjnAy2SFGiYC0w1DPdQZB3CJ1L8BPZM+RZfCo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qY2pasQl84mGE0SgfKYxRP5NMemE3K8699/69Alb4zVbL82yLx5LJPGHtAUEMns4gCvVNHgSB45EIIXQbUfJpRUX7GfOv6hch0G9Lc+pCcNZtqQ8swgtq9NTsPKCJxxXH9Vr/lVRbvnkBLCbxvYFFkU9iP61C9hkz02jnOfZKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fhP9465qdzHnGhq;
	Thu, 26 Mar 2026 21:03:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 33EC64056E;
	Thu, 26 Mar 2026 21:04:14 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Mar
 2026 13:04:13 +0000
Date: Thu, 26 Mar 2026 13:04:09 +0000
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisa.su@samsung.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: Re: [PATCH 1/9] hw/mem: Add tag support to generic host memory
 backends
Message-ID: <20260326130409.0000405b.alireza.sanaee@huawei.com>
In-Reply-To: <87bjgag2y5.fsf@pond.sub.org>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-2-alireza.sanaee@huawei.com>
	<87a4vuhnxy.fsf@pond.sub.org>
	<20260326112921.000028e6.alireza.sanaee@huawei.com>
	<87bjgag2y5.fsf@pond.sub.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 26 Mar 2026 14:01:06 +0100
Markus Armbruster <armbru@redhat.com> wrote:

Hi Markus,

Sure, absolutely.
> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
> 
> > On Thu, 26 Mar 2026 11:42:17 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Hi Markus,
> >  
> >> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
> >>   
> >> > Add a string tag property to HostMemoryBackend so that backends can be
> >> > identified by a user-assigned name at runtime. Expose the property through
> >> > QOM and add a host_memory_backend_find_by_tag() helper that walks the
> >> > object tree to locate a backend by its tag.    
> >> 
> >> Why can't you use the QOM ID?
> >> 
> >> $ qemu-system-x86_64 -S -display none -monitor stdio -object memory-backend-ram,id=fred,size=1M
> >> QEMU 10.2.90 monitor - type 'help' for more information
> >> (qemu) info qom-tree /objects/fred
> >> /fred (memory-backend-ram)
> >>   /fred[0] (memory-region)
> >> 
> >>    
> >
> > Fair question. The ID would have been a solution if it had accepted GUIDs. CXL spec 
> > requires GUIDs for extents as identification, hence new tag property.  
> 
> Your commit message should state that this needs to be a GUID and why.
> 
> > alireza@blue-ocean:~/Downloads$ qemu-system-x86_64 -s -display none -monitor std
> > io -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd76bb79,size=1M
> > qemu-system-x86_64: -object memory-backend-ram,id=02bb2436-e87d-4aa1-b2be-aaffdd
> > 76bb79,size=1M: Parameter 'id' expects an identifier
> > Identifiers consist of letters, digits, '-', '.', '_', starting with a letter.
> >
> > Thanks,
> > Ali  
> 
> 

