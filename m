Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80116132B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338315; cv=none; b=oI0olHcM2ag2ATeTYd4kS/ETx4txuwYACrmCPsbtahAD5evNDjId8GeZYzp7BCL344ia6xWGkr128mm6Th4BqvM4cpBBD0gF1vUzHCmi5T3YExZVo693cMLuZndnW1aKXS1I8ZMzPm6SgObZW5Wjmoj+y76mSACqZeanCBTf+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338315; c=relaxed/simple;
	bh=r/7fYbzof5lM2I8fPkEvXtci1BGVlazBwiAXVYqAK3g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XK/U7rzT2gCRwdIBiGnoXrfe/7KqGUbnhXtBoxJ4GUdO5FlX4rAOUbtGbwjE0MgwgBmb1rwNE2UU81Bagun0wEpqfKzZhlpS/yE+pCUmMQy4o3MY/rPwlBcoqD1ZmEnwDAvpEsFmbV1+MqNh+a39dZX74O0DIH0xfypkio12rQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB55T4fTTz6K6gH;
	Sat,  6 Apr 2024 01:27:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD90141548;
	Sat,  6 Apr 2024 01:31:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 18:31:50 +0100
Date: Fri, 5 Apr 2024 18:31:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
CC: Dan Williams <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Srinivasulu Thanneeru
	<sthanneeru@micron.com>
Subject: Re: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
Message-ID: <20240405183149.000023d2@Huawei.com>
In-Reply-To: <38d0842e1f774c82b2f8f58f4d7ab07f@micron.com>
References: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
	<66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch>
	<38d0842e1f774c82b2f8f58f4d7ab07f@micron.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 1 Apr 2024 06:03:07 +0000
Srinivasulu Opensrc <sthanneeru.opensrc@micron.com> wrote:

> >-----Original Message-----
> >From: Dan Williams <dan.j.williams@intel.com>
> >Sent: Wednesday, March 27, 2024 5:07 AM
> >To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
> >cxl@vger.kernel.org
> >Cc: Jonathan.Cameron@huawei.com; dan.j.williams@intel.com;
> >john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>; Ajay Joshi
> ><ajayjoshi@micron.com>; Ravis OpenSrc <Ravis.OpenSrc@micron.com>;
> >Srinivasulu Thanneeru <sthanneeru@micron.com>
> >Subject: [EXT] RE: [PATCH v3 0/2] Add log related mailbox commands
> >
> >CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you
> >recognize the sender and were expecting this message.
> >
> >
> >sthanneeru.opensrc@ wrote:  
> >> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> >>
> >> Add support to expose following mailbox commands to userspace
> >> for clearing and populating the Vendor debug log in certain
> >> scenarios, allowing for the aggregation of results over time.
> >>
> >> 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> >> 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> >> 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> >>
> >> ---
> >> Changes in v3:
> >> - 'Component State Dump log' has several caveats for ioctl()
> >>    not being a suitable ABI as pointed in v2.(Dan Williams)
> >> - Remove Component State Dump from Clear log filter.
> >> - Implement a seperate patch(yet to do) to address issues as pointed in v2.  
> >
> >Circling back to this question... I had overlooked the fact that in v3.1
> >the "Request Abort Background Operation" command was added (8.2.9.1.5).
> >With that the kernel can safely support background commands with
> >indefinite residency. So as long as the device supports that command and
> >advertises that Log populate requests can be cancelled then we can build
> >a facility to cancel any user-submitted background commands when a
> >kernel internal need for the background command slot arises.  
> 
> I don't have the access to test "Request Abort Background Operation."
> Previously, we posted RFC for default time for background operations.
> https://lore.kernel.org/linux-mm/20240207105349.301-1-sthanneeru.opensrc@micron.com/
> 
>  Could you please guide me on how to proceed with this current patch series?

Whilst QEMU emulation doesn't yet support background command aborting, it wouldn't
be that hard to add and would provide a route to test this functionality.
We've done similar in a few other cases where no one had any hardware yet.

Of course that might not help you if you have silicon that doesn't implement it
but I agree with Dan that it is a lot less problematic to allow for unbounded
background ops if we can stop them for other urgent activity.

Jonathan

