Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48117C2EA
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769776290; cv=none; b=UiQfz6AeHC6oEZAqYH21bha5PYSlqhjO+hSTs7Mx+OqSTD+FWuAzbATu+ZMptSGL9aEeMuqGUf1C+Sx5cJwLHGsNgQO1Fio8LcyZ3iEM7d+fTg7tJBNoz5WI78/XW51TRUUqafCo7dS+T+hM6dganK93ohiciosg7dvbwFmmk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769776290; c=relaxed/simple;
	bh=XZsfEErUM3XLP6nUmG4eL7d10vpFzhM4OW55bsiTVNM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vyj46GnwYU3SMsJtTp6vezUy/R0E9eNAZInnny32D7DZjPLfEc40erCa69GzI8GS3++J/wY/guRxMuzmAeOLT4nqL0sc3HjQrS9En6XRL+hVBR8plOvUjA53g2vvYbHKMrvXSURUmn1ByZTVDUiA5Yu5bYA5KFFkYRPxXHPl2wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f2b2J5BZBzHnH4l;
	Fri, 30 Jan 2026 20:30:32 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E12740565;
	Fri, 30 Jan 2026 20:31:24 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Jan
 2026 12:31:23 +0000
Date: Fri, 30 Jan 2026 12:31:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
	<krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <arpit.sysdev@gmail.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v4 0/2] FM-API Physical Switch Command Set Support
Message-ID: <20260130123122.0000105e@huawei.com>
In-Reply-To: <20260130120350.n7ngrvla5mfkwllo@test-PowerEdge-R740xd>
References: <CGME20250916080757epcas5p2db403c9648f7818b22413d90acb4fdd4@epcas5p2.samsung.com>
	<20250916080736.1266083-1-arpit1.kumar@samsung.com>
	<20260127152350.00006447@huawei.com>
	<20260130120350.n7ngrvla5mfkwllo@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 30 Jan 2026 17:33:50 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> On 27/01/26 03:23PM, Jonathan Cameron wrote:
> >On Tue, 16 Sep 2025 13:37:34 +0530
> >Arpit Kumar <arpit1.kumar@samsung.com> wrote:
> >  
> >> This patch series refactor existing support for Identify Switch Device
> >> and Get Physical Port State by utilizing physical ports (USP & DSP)
> >> information stored during enumeration.  
> >
> >Hi Arpit.
> >
> >So I came back to this series to try and tweak it into being in a state
> >for upstreaming.  I made some fairly heavy changes (to push the
> >data down to the individual ports where to me it more logically sits)
> >but it became apparent to me during this that there is a fundamental
> >problem.  This stuff isn't static because it needs to reflect port
> >retraining and hotplug events etc.  If we want to store cached
> >data we are going to have to deal with updating it from a significant
> >number of different places. The perst one you have covered in patch 2
> >is an example but there are others.
> >
> >Now we definitely can do the generation in a neater way, but I've
> >come to the conclusion that caching it really doesn't make sense.
> >
> >Maybe we can do that for the USP, but definitely not DSPs.
> >
> >Given I did a bunch of refactoring I might as well share it even though
> >I'm currently thinking it might not be worth doing:
> >
> >From 40a8a36f22a6eb053c965231a698c8054d417049 Mon Sep 17 00:00:00 2001
> >From: Arpit Kumar <arpit1.kumar@samsung.com>
> >Date: Tue, 16 Sep 2025 13:37:35 +0530
> >Subject: [PATCH] hw/cxl: Refactored Identify Switch Device & Get Physical Port
> > State
> >
> >Store the physical port info for the USP on reset but refresh
> >it on demand for the DSPs as they are hotplug capable.
> >
> >Enables common data to be used for both of:
> >* Identify Switch Device (Opcode 5100h)
> >* Get Physical Port State (Opcode 5101h) physical switch FM-API command set.
> >
> >Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> >Co-developed: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> >---
> >Added a Co-dev as I have modified this a lot from Arpit's v4.
> >v5:
> >- Create a new header to avoid importing all of cxl_device.h into
> >the upstream port emulation.
> >- Move the call that caches state to the cxl_upstream_port reset
> >  to ensure downstream ports are in place before it is called.
> >  Also will make it available from whatever CCI.  If we ever support
> >  multiple VCS switches this will need to move an appropriate structure
> >  representing whole switch information. With only one USP that is
> >  a reasonable place to put full switch info.
> >- Downstream ports have more dynamic state (as devices can be
> >  hotplugged below them).  As such, only fill in the data at time
> >  of request.  
> 
> Hi Jonathan,
> Thanks for the update! The changes look good to me. I do concede that
> it requires more dynamic approach. This would help in future command 
> support like multiple VCS, MLD etc. I intially refrained from making changes
> to individual ports but it does logically fits there and would
> optimize the command support.

My current thinking is this major refactor is justified. There isn't
a strong reason not to do what the original code does and built it directly
in the command handler.

I'm preparing some cleanup of that though, such as using the defines
you added so it is more obvious what values are set.

The Physical Port Controls stuff can then drop in on top of that.

Once all that is in place we can reconsider if a refactor like the
one in the code below is worth doing.

We might also need a few more updates to keep track of things like flit
mode control patches.

Anyhow, I'll throw something together in the next day or two to share.

Jonathan



