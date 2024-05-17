Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239932C8B
	for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940892; cv=none; b=lXRZ71eK3wDNKIWmUKAHPJDaJY12ehjlbCoJTI+lzeyAy/CfQwsGOV3oBPexpWSrtqFZw7UHz2sbFb6mD8zDgbg+VRuk9MVZEqa9uHdhnMkCZQH15d3Y5iNlCS5Mff2r4wl/pS7pDGQ+cfkPl3eddLC4142k39FBVq9okjrFBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940892; c=relaxed/simple;
	bh=G7ouvYE2KGAGYNy6Llvo5bEx0CAkELd/lYwmwbvmSlg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7ij6ke1ulQpxDkdrz69tCOkJfdEobxwQniT/rycW3NXk2j7H/th5cWycvea15es6kSnMj0CuDYC3WZaTctuNNOihIs30YCOY2flvSI0DooQZwbedQ24qsNxISqZJ3gKA9B9i2FIGvkySTV9hnv6SGvfk0b2f+ChgPOu46GrQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgjR40WFJz67NJq;
	Fri, 17 May 2024 18:11:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A2B85140594;
	Fri, 17 May 2024 18:14:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 11:14:46 +0100
Date: Fri, 17 May 2024 11:14:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: CXL numa error on arm64 qemu virt machine
Message-ID: <20240517111441.00002279@Huawei.com>
In-Reply-To: <ZkcsS0we4XHPgBIP@phytium.com.cn>
References: <20240508080051.3756934-1-wangyuquan1236@phytium.com.cn>
	<20240508130252.00006367@Huawei.com>
	<ZjyK1tI0TtbAKhmh@phytium.com.cn>
	<20240510181646.000019a1@Huawei.com>
	<ZkcsS0we4XHPgBIP@phytium.com.cn>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 17 May 2024 18:07:07 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> On Fri, May 10, 2024 at 06:16:46PM +0100, Jonathan Cameron wrote:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/cxl-staging.git/log/?h=arm-numa-fixes
> >   
> Thank you :)
> > I've run out of time to sort out cover letters and things + just before the merge
> > window is never a good time get anyone to pay attention to potentially controversial
> > patches.  So for now I've thrown up a branch on kernel.org with Robert's
> > series of fixes of related code (that's queued in the ACPI tree for the merge window)
> > and Dan Williams (from several years ago) + my additions that 'work' (lightly tested)
> > on qemu/arm64 with the generic port patches etc. 
> > 
> > I'll send out an RFC in a couple of weeks.  In meantime let me know if you
> > run into any problems or have suggestions to improve them.
> > 
> > Jonathan
> >  
> With the latest commit(d077bf9) in the 'arm-numa-fixes', the qemu virt
> could create a cxl region with a new numa node (node 2) just like x86.
> At this stage(the first time to create cxl region), everything works
> fine.
> 
> However, if I use below commands to delete the created cxl region:
> 
> `daxctl offline-memory dax0.0`
> `cxl disable-region region0`
> `cxl destroy-region region0`
> 
> and then recreate it by `cxl create-region -d decoder0.0 -t ram`, the
> kernel could not create the numa node2 again, and the kernel will print:
> 
> [  589.458971] Fallback order for Node 0: 0 1
> [  589.459136] Fallback order for Node 1: 1 0
> [  589.459175] Fallback order for Node 2: 0 1
> [  589.459213] Built 2 zonelists, mobility grouping on.  Total pages: 1009890
> [  589.459284] Policy zone: Normal

I'll see if I can figure out what is happening there.
> 
> Meanwhile, the qemu reports that: 
> 
> "qemu-system-aarch64: virtio: bogus descriptor or out of resources"

That sounds like another TCG issue, or possibly the DMA bounce buffer
problem resurfacing.  It's not directly related to his NUMA aspect unless
something very odd is going on.  I'm even more confused because I think
you are not using kmem with the above commands, so we shouldn't be using
the CXL memory for virtio.

Just to check, you aren't running with KVM I hope?  That opens a much
bigger problem set. :(

Jonathan



> 
> Many thanks
> Yuquan
> 

