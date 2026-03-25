Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34413C198A
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440381; cv=none; b=SiIMBrzpUaZ94bYN/KNL0wcXtTjcFWr8rRRp4YdQX1T13fc2wxE662pFy3MQ12hwFsXoSRztnjjPyJlO3Qt36ksrQ4GBhYRjUgxWtTY+rRrRPPBOpJhnjgaVwFqgYLklLmNJXLP7PXpibHmmP35UYD0xIyrGHBPVxN4eewyL0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440381; c=relaxed/simple;
	bh=2C+I6zXug0xtCvDlpS6+AKeb+mAb95KujcIiKzOdeSY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQE/3sSWKp9RrCap3uqp3Ghot8OPM0FRXnbIN+JHzYWl7XEiT0cYsFkhz6fpUHeHNnxqtTtp0OUD7B+1VAp7aZ7imP0/7Cg5csWXT/YK4fiAiSK1bGIcYt2VXBfkjeeEzWEgOTmKu6NPZcFKITeM8cvRzbbW4K2W34Grkg1BmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fglwh1Cz6zHnGgq;
	Wed, 25 Mar 2026 20:05:40 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 72F824056A;
	Wed, 25 Mar 2026 20:06:15 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 12:06:14 +0000
Date: Wed, 25 Mar 2026 12:06:13 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<dongjoo.seo1@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>, John Groves <John@Groves.net>, John Groves
	<jgroves@micron.com>
Subject: Re: [RFC PATCH 0/1] cxl: Media Operations
Message-ID: <20260325120613.00007003@huawei.com>
In-Reply-To: <20260324180754.et4gwn6dobdplurt@offworld>
References: <20260323204013.4010634-1-dave@stgolabs.net>
	<20260324153238.0000750e@huawei.com>
	<20260324180754.et4gwn6dobdplurt@offworld>
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

On Tue, 24 Mar 2026 11:07:54 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 24 Mar 2026, Jonathan Cameron wrote:
> 
> >On Mon, 23 Mar 2026 13:40:12 -0700
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> Hello,
> >>
> >> This implements support for Media Operation cmd. It is marked RFC because of these
> >> noteworthy points:
> >>
> >>  (i) Sysfs interfaces. These changes implement 'security/zero' and multiplex
> >>      'security/sanitize' to allow dpa, len pairs for the range (no impact for
> >>      current usage as whole-device). This breaks the 1 value per file "rule",
> >>      and would be a first for drivers/cxl/*, so am I open to suggestions.  
> >
> >Value is a vague sort of term.  It's one thing (an range) so seems fine to me.  
> 
> I agree.
> 
> >  
> >>
> >>  (ii) Background cmd handling semantics. Media operations are synchronous,
> >>       which for raged zeroing operations makes sense and for range sanitize  
> >
> >ranged
> >  
> >>       differs from the current async handling for whole-device, so user response
> >>       differs significantly, something I am not crazy about. Another downside
> >>       of this is that it exposes lock hold times to be user-controllable, but is
> >>       no different than what we do for fw. Fundamentally, users have the
> >>       responsibility to break up the work into sane ranges.  
> >
> >We could apply a limit on this and make that discoverable via another sysfs attribute.
> >So let userspace request in say 1Gig chunks.  Would have to check that the device
> >supports that granularity though.  
> 
> If we agree that this will be performed synchronously, then yes, adding a size cap
> would be necessary. I don't love having it in ie: security/range_limit(?), but that
> could be created at discovery time when we know the granularity. Another way would
> be to avoid the extra file and just print the limit in the error message - but I
> guess dev_dbg() would be needed to not spam the dmesg. In any case with a cap,
> while no guarantees, this also reduces the chances of the user triggering driver timeouts.
> 
> >I don't think there is anything in the spec today to let us query how long
> >something takes (which would be a better way to bound this).  
> 
> Correct, that is just something Scan Media allows for - and yes, that's exactly
> the sane way to do the work breakup.
> 
Yo John,

I'm sure you are keeping a list of potential improvements for the appropriate group
that I believe you have some leadership role in ;)

I'd like devices to provide info to allow us to establish an upper bound on how
long a zero / sanitize media operation would take.  This one doesn't need to be
code first so we can consider this a potential feature request.

Jonathan

> Thanks,
> Davidlohr

