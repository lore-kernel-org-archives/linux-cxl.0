Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054313666C
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679060; cv=none; b=P3H9UDNUApEA/92ENq7R/wta4CMRomO9o5EE4e0bMj/HL2AHCcVP/NTxfrwA+cFm7lgmaML+hAB/y2UQPHTLXa4dzl35VkHFvp/pwGJG8//bmaf/adXsr8Tuo75zmr3YiOvPJRkl8ANgh15b+zc9RSNzbYmnP07r5aHgX0doMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679060; c=relaxed/simple;
	bh=ugzz/fgtHnFL3TC/aFSve0V5kZ5/EpBZqXus5kT22q0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+8By3igDd5PYfkBjLtGlj2l6vrXALbzTLzW25EvOWVE02o0K9tPIAMiQiQJwQHQmy5XgC34Ifw2Y+Rw46IcI8vBVgay8LzCW2kFA9E3b3m+PK4yoYK/8b4jB0oH+jNxPCCtKzh5zfkKLKTZdg9K3QVQzEpVQH+KTQGoaynUbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VDW683WQXz67DpL;
	Wed, 10 Apr 2024 00:06:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 88DDD1400CA;
	Wed, 10 Apr 2024 00:10:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 17:10:54 +0100
Date: Tue, 9 Apr 2024 17:10:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240409171053.00003f2d@Huawei.com>
In-Reply-To: <ZhA+U9b/IVq1V6LT@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-10-nifan.cxl@gmail.com>
	<Zg2c+YauNGqhFfTW@memverge.com>
	<20240405132719.00005859@Huawei.com>
	<ZhAh0Qmv2/VTe1wT@memverge.com>
	<20240405184452.00007986@Huawei.com>
	<ZhA+U9b/IVq1V6LT@memverge.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Apr 2024 14:09:23 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Apr 05, 2024 at 06:44:52PM +0100, Jonathan Cameron wrote:
> > On Fri, 5 Apr 2024 12:07:45 -0400
> > Gregory Price <gregory.price@memverge.com> wrote:
> >   
> > > 3. (C) Upon Device receiving Release Dynamic Capacity Request
> > >    a. check for a pending release request. If exists, error.  
> > 
> > Not sure that's necessary - can queue as long as the head
> > can track if the bits are in a pending release state.
> >   
> 
> Yeah probably it's fine to just queue the event and everything
> downstream just handles it.
> 
> > >    b. check that the bits in the MHD bitmap are actually set  
> > Good.  
> > > 
> > >    function: qmp_cxl_process_dynamic_capacity
> > > 
> > > 4. (D) Upon Device receiving Release Dynamic Capacity Response
> > >    a. clear the bits in the mhd bitmap
> > >    b. remove the pending request from the pending list
> > > 
> > >    function: cmd_dcd_release_dyn_cap
> > > 
> > > Something to note: The MHD bitmap is essentially the same as the
> > > existing DCD extent bitmap - except that it is located in a shared
> > > region of memory (mmap file, shm, whatever - pick one).  
> > 
> > I think you will ideally also have a per head one to track head access
> > to the things offered by the mhd.
> >   
> 
> Generally I try not to duplicate state, reduces consistency problems.
> 
> You do still need a shared memory state and a per-head state to capture
> per-head data, but the allocation bitmap is really device-global state.

There is a separation between 'offered' to a head and 'accepted on that head'.
Sure you could track all outstanding offers (if you let more than one be
outstanding) at the shared memory, just seemed easier to do that in the
per head element.


> 
> Either way you have a race condition when checking the bitmap during a
> memory access in the process of adding/releasing capacity - but that's
> more an indication of bad host behavior than it is of a bug in the
> implementatio of the emulated device. Probably we don't need to
> read-lock the bitmap (for access validation), only write-lock.
> 
> My preference, for what it's worth, would be to have a single bitmap
> and have it be anonymous-memory for Single-head and file-backed for
> for Multi-head.  I'll have to work out the locking mechanism.
I'll go with maybe until I see the code :)

J
> 
> ~Gregory

