Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95A6146D66
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787497; cv=none; b=VOjvqTn+xEeBwMfieyuFDyJYnwGtV+yYLBbp89QWZVIWABW6iASO5FbKQpevmW8z8NNbwNTopQtu1Tj46YfrVpmu6p2WnKBF5N4qfb7aTs5mUTF8OYYDssM/yafdOlDw1TY+ahiPkOoCmMaZ455zTWWhoJcEAIzCBpLro5TZEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787497; c=relaxed/simple;
	bh=XxKK1fyV56jaChctqigIr1Fol0LXsevuLAlBhwH310w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoRgO7ltYn/2rpDV+J3jQ2YBA1c36ywd0GBcakv5wT3is1B5lNCGr+gt5F858oinPj+ba+J8uhipTnym2S88CL8eYfg0FW1jVe0Py58DYRpNjpoHNNxKe6CDaP2/Zj0qn9fZO26HCeC8S2Ta07Nw9JC9urtQ/fcL7YoQXvg/WCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNP555mpRz6K6hP;
	Mon, 22 Apr 2024 20:02:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D732140AB8;
	Mon, 22 Apr 2024 20:04:49 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 13:04:49 +0100
Date: Mon, 22 Apr 2024 13:04:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: fan <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, <fan.ni@samsung.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <20240422130448.000057ec@huawei.com>
In-Reply-To: <ZiQnIkYjY3ngRLAi@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<ZiK25Log7LmtBffa@memverge.com>
	<ZiK7QtVxutwDys4K@debian>
	<ZiQnIkYjY3ngRLAi@memverge.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 20 Apr 2024 16:35:46 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Apr 19, 2024 at 11:43:14AM -0700, fan wrote:
> > On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:  
> > > 
> > > added review to all patches, will hopefully be able to add a Tested-by
> > > tag early next week, along with a v1 RFC for MHD bit-tracking.
> > > 
> > > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> > > 
> > > The super-set release will complicate a few things but this doesn't
> > > look like a blocker on our end, just a change to how we track bits in a
> > > shared bit/bytemap.
> > >   
> > 
> > Hi Gregory,
> > Thanks for reviewing the patches so quickly. 
> > 
> > No pressure, but look forward to your MHD work. :)
> > 
> > Fan  
> 
> Starting to get into versioniong hell a bit, since the Niagara work was
> based off of jonathan's branch and the mhd-dcd work needs some of the
> extentions from that branch - while this branch is based on master.
> 
> Probably we'll need to wait for a new cxl dated branch to try and sus
> out the pain points before we push an RFC.  I would not want to have
> conflicting commits for something like this for example:
> 
> https://lore.kernel.org/qemu-devel/20230901012914.226527-2-gregory.price@memverge.com/
> 
> We get merge conflicts here because this is behind that patch. So
> pushing up an RFC in this state would be mostly useless to everyone

Subtle hint noted ;) 

I'll build a fresh tree - any remaining rebases until QEMU 9.0 should be
straight forward anyway.   My ideal is that the NUMA GP series lands early
in 9.1 cycle and this can go in parallel.  I'd really like to
get this in early if possible so we can start clearing some of the other
stuff that ended up built on top of it!

Jonathan

> 
> ~Gregory

