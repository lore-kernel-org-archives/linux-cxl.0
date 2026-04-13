Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0080F125A9
	for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095450; cv=none; b=aP7zw4J2EG70dT+6I8QOoYh3huhLZnnEWK9xCxZRLjIlj9Ua3YQYwctJIJT8PPwKO9NbKoViOsI6jDExi7hVjgXCublUAUXEc7kNcfX5X0CZxNHdBbDAQpldFijeq8CTTajGkkOycSDN2jciqsqjIMLRfbB8nG4QChquj9mHfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095450; c=relaxed/simple;
	bh=xK4r1imp4wqDB8X4g2vLJ/eYGxYoxVGV8y487uiArvg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1ip6TM1v6MOvrQFhSehVTHTQlhJru3kkM+AIIeeMyLvo/Y9x0fv9j4GBzYClldI5QhkBkCisrg64vaQwpV36SSHOMiDk6p9DjcK690u49lAeUtzJhY1gGQ/22sKEBnJhMvwt9aWMKClHUtlMTpfrxVkYpfg/ga4dGh/EX1DmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fvX1N50KLzHnGcW;
	Mon, 13 Apr 2026 23:50:32 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 11C0340575;
	Mon, 13 Apr 2026 23:50:45 +0800 (CST)
Received: from localhost (10.203.86.132) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Apr
 2026 16:50:44 +0100
Date: Mon, 13 Apr 2026 16:50:42 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@groves.net>
CC: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>, John Groves
	<jgroves@micron.com>
Subject: Re: [RFC PATCH 0/1] cxl: Media Operations
Message-ID: <20260413165042.00004ec8@huawei.com>
In-Reply-To: <acaes_gqFt-LLFrC@groves.net>
References: <20260323204013.4010634-1-dave@stgolabs.net>
	<20260324153238.0000750e@huawei.com>
	<20260324180754.et4gwn6dobdplurt@offworld>
	<20260325120613.00007003@huawei.com>
	<acaes_gqFt-LLFrC@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 27 Mar 2026 10:17:01 -0500
John Groves <John@groves.net> wrote:

> On 26/03/25 12:06PM, Jonathan Cameron wrote:
> > On Tue, 24 Mar 2026 11:07:54 -0700
> > Davidlohr Bueso <dave@stgolabs.net> wrote:
> >   
> > > On Tue, 24 Mar 2026, Jonathan Cameron wrote:
> > >   
> > > >On Mon, 23 Mar 2026 13:40:12 -0700
> > > >Davidlohr Bueso <dave@stgolabs.net> wrote:
> > > >    
> > > >> Hello,
> > > >>
> > > >> This implements support for Media Operation cmd. It is marked RFC because of these
> > > >> noteworthy points:
> > > >>
> > > >>  (i) Sysfs interfaces. These changes implement 'security/zero' and multiplex
> > > >>      'security/sanitize' to allow dpa, len pairs for the range (no impact for
> > > >>      current usage as whole-device). This breaks the 1 value per file "rule",
> > > >>      and would be a first for drivers/cxl/*, so am I open to suggestions.    
> > > >
> > > >Value is a vague sort of term.  It's one thing (an range) so seems fine to me.    
> > > 
> > > I agree.
> > >   
> > > >    
> > > >>
> > > >>  (ii) Background cmd handling semantics. Media operations are synchronous,
> > > >>       which for raged zeroing operations makes sense and for range sanitize    
> > > >
> > > >ranged
> > > >    
> > > >>       differs from the current async handling for whole-device, so user response
> > > >>       differs significantly, something I am not crazy about. Another downside
> > > >>       of this is that it exposes lock hold times to be user-controllable, but is
> > > >>       no different than what we do for fw. Fundamentally, users have the
> > > >>       responsibility to break up the work into sane ranges.    
> > > >
> > > >We could apply a limit on this and make that discoverable via another sysfs attribute.
> > > >So let userspace request in say 1Gig chunks.  Would have to check that the device
> > > >supports that granularity though.    
> > > 
> > > If we agree that this will be performed synchronously, then yes, adding a size cap
> > > would be necessary. I don't love having it in ie: security/range_limit(?), but that
> > > could be created at discovery time when we know the granularity. Another way would
> > > be to avoid the extra file and just print the limit in the error message - but I
> > > guess dev_dbg() would be needed to not spam the dmesg. In any case with a cap,
> > > while no guarantees, this also reduces the chances of the user triggering driver timeouts.
> > >   
> > > >I don't think there is anything in the spec today to let us query how long
> > > >something takes (which would be a better way to bound this).    
> > > 
> > > Correct, that is just something Scan Media allows for - and yes, that's exactly
> > > the sane way to do the work breakup.
> > >   
> > Yo John,
> > 
> > I'm sure you are keeping a list of potential improvements for the appropriate group
> > that I believe you have some leadership role in ;)
> > 
> > I'd like devices to provide info to allow us to establish an upper bound on how
> > long a zero / sanitize media operation would take.  This one doesn't need to be
> > code first so we can consider this a potential feature request.
> > 
> > Jonathan
> >   
> > > Thanks,
> > > Davidlohr  
> >   
> 
> Acknowledged. Are you thinking of a one-off for sanitize, or is there
> a class of commands that might ought to provide such an upper-bound?

Not sure - probably one to through at the spec group and see if anyone can
think of more usecases beyond the various media operations.

> 
> I'd be happy to try to push something through, but the solution ought
> to come from somebody who experiences the inconvenience directtly :D

Over to you Davidlohr ;)
> 
> Regards,
> John

> 
> 

