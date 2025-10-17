Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EA2F12C9
	for <linux-cxl@vger.kernel.org>; Fri, 17 Oct 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720411; cv=none; b=AT0bZFiDwyMvvqfuRoHdeCiUECxybB6KZp11Yei9WNd/z4TmAu9k4A3x8BicaDIrtwVW8cKSpP7bJy0/9GdI3C5qI+9eaGeL17yHH3SlL7BYcnNSZLFZARAnfU09+wyzz7nK7zVEV2B2rONmxQ87+7HcXvccWSV/ll7kmE0z1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720411; c=relaxed/simple;
	bh=7jqukuXCaqvmfJfAP/aE7po5/P9v8827vg40RbAyJeE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfRRF+OfFMZaAV94jV0/9puIBp74r1eT6BevBJ8Xr06RZh89G6cYhGg2p1qXbWMp3onOX32W/v83JceVnsv9NR1rFVvzLBMMBQQrOHnA5lNrRn4BgNN2IpmcU1qvqBwsfO4LDD0qd/ITKFpaCyqRGArpZUpfM0UV7utD4Yszo5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cp9wK65Tjz6L4t8;
	Sat, 18 Oct 2025 00:57:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 89EE6140137;
	Sat, 18 Oct 2025 01:00:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 17 Oct
 2025 18:00:03 +0100
Date: Fri, 17 Oct 2025 18:00:01 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: "Huang, Ying" <ying.huang@linux.alibaba.com>, Dan Williams
	<dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <hch@infradead.org>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: Deep flush support for CXL pmem?
Message-ID: <20251017180001.00006d6c@huawei.com>
In-Reply-To: <aPJR1ihx1j3UqUjx@gourry-fedora-PF4VCD3F>
References: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>
	<aPJR1ihx1j3UqUjx@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 10:25:26 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Oct 17, 2025 at 02:11:16PM +0800, Huang, Ying wrote:
> > Hi, All,
> > 
> > When reading the documentation of PMDK (https://github.com/pmem/pmdk), I
> > found that deep flush is used for data loss recovery in addition to GPF.
> > With that, we can identify that a file isn't affected by the GPF failure
> > because it wasn't opened during the GPF failure.
> > 
> > However, IIUC, the Linux kernel doesn't support deep flush (via
> > nvdimm_flush()) for CXL pmem at least for now.  For NVDIMM, we have WPQ,
> > but it appears that we don't have that for CXL.  Is deep flush for CXL
> > defined in some spec?
> >  
> 
> Should note that this is relevant not just for pmem, but also for shared
> memory use cases.  Last I looked there's nothing defined / implemented.
> 
> When I reviewed the cxl.mem protocol about a year or so ago, I came away
> thinking a deep flush was going to be problematic for shared devices
> (multiple separate coherency domains / non-coherent memory).

Two things to deal with.  Getting it to the device.  For that what happens
is CPU architecture / host system architecture dependent. Not all (possibly
none) of the architectures have this well defined today - on some it
just works (cross your fingers that this is always the case). In some systems
using the persistent flushes gets it out on the bus whether or not the
CXL device is persistent.

There are ways around that, such as 'device' like entities on particular
systems that do this.  We have one in our Hydra Home Agent that is handled
by the cache maintenance 'subsystem' series (I'll send v4 of that early
next week). You can use that to guarantee caches are written back to
the device. We don't currently use it outside of capacity additions / removal
(DCD or address decoder programming routes).

The other thing is getting the device to actually write it to persistent
memory rather than relying on local or remote power to keep things up long
enough for writes to complete.

So I understand that there are gaps in what is guaranteed to do the job for both
deep flushes to persist memory and for shared memory use cases.

Jonathan

> 
> ~Gregory

