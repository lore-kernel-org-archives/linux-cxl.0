Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA92030F
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291315; cv=none; b=XlyXOwLo0MN/xlGAXNicmShj5lBJeTWsP8p1n7/BUkvcUoQZFBPGYTvt4WFDBgy3ooD6BiEnt1yHVDvqoQeuh3hKR/AbHY7WlTnq56ogliWEeWkpG54Bcc639NfBCE0ihkX67pRkyMZb7SYO+Etict68WSzOVuWPctT+MWZPyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291315; c=relaxed/simple;
	bh=vdKkvBh/skYrxVuR261TMwo8SFS+0NESgvKSrQ1D+aA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=og2KDkAfU+OSUxliAeFgLi0wqVNPF2Zl1/WIbZzAqq7FWxhu2uMXbgMTQjZ1DtPD/M0nHQKs5mLk7o4+I2qhSh0P2Lx6o5fneN9moTKCmRRYpNTRqC7bVLY+DrYkE3GPipg8Wcn9oGOIPkT6MhbbmHbZHsfliofx6fD7zSTj+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM4pw2b9rz6K8wW;
	Sat, 27 Jan 2024 01:45:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 34185140A36;
	Sat, 27 Jan 2024 01:48:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:48:27 +0000
Date: Fri, 26 Jan 2024 17:48:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <mounika.k@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: Add Transfer FW support
Message-ID: <20240126174826.00006239@Huawei.com>
In-Reply-To: <vsm7fpp3fbywuzzepbhezzuhewrk5fc3avtvbcrb2nubs3lm2m@y257ghfqmqmr>
References: <20240109070436.21253-1-dave@stgolabs.net>
	<20240109070436.21253-2-dave@stgolabs.net>
	<20240126154220.00002797@Huawei.com>
	<vsm7fpp3fbywuzzepbhezzuhewrk5fc3avtvbcrb2nubs3lm2m@y257ghfqmqmr>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Jan 2024 09:17:13 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Fri, 26 Jan 2024, Jonathan Cameron wrote:
> 
> >On Mon,  8 Jan 2024 23:04:35 -0800
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> Per the latest 3.1 spec for supporting firmware update metadata
> >> (no actual buffers). Aborting a xfer is currently unsupported
> >> through a nop.
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> >Hi Davidlohr.
> >
> >Whilst we may never notice from the OS as we expect it to send valid
> >sets of transfers only, I'd like the emulation to incorporate more
> >of the validity checks the spec requires such as:
> >- Multiple part transfers must all be for same slot - any interleaved
> >  ones for other slots result in error.
> >- Retry of previous transfer or one that starts where previous transfer
> >  ended - otherwise Out of Order detected.
> >
> >So we have to hold state, and as such will have the information to
> >set the slot as occupied with just one extra flag stored to say it is
> >a FULL or END message.
> >
> >Otherwise lgtm.  
> 
> I will send a v2 with your feedback. Do you prefer just using your
> latest '2024-26-01-draft' branch?

Yes, that makes my life easiest (though I'm also find dealing with
rebases if you use something reasonable that isn't that)
Nestle it in as far down as possible but after the DCD changes.
Either before or after your scan media set (up to you - they'll
probably get grouped together anyway for sending to Michael).

Thanks!

Jonathan


> 
> Thanks,
> Davidlohr

