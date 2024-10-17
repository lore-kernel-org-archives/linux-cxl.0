Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75314D2B1;
	Thu, 17 Oct 2024 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167429; cv=none; b=aJNlOE7nRQD+w/AwYnntU6baFgMbfcRLDovyfmTmJDJ8GGQz+dwgp7I1BlslbJKsVvs8NJ4pUXl+SPkf36T4isZZLmO2uvnV2t91fnmxGfbYJe/28d5zzcEH6aAkzpnXx/wW77xmwDsCRQbG9YUr7JgPto8B/LH/4cMNbG8O8r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167429; c=relaxed/simple;
	bh=Yf61FvcfH5nCZ/c6o860G2My1JoTfHPOgJis45+GQbg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6Q7luSXg7v1ZjtTLwtMZIW+/3d+a+EC6DjP8yCISYMZ8GyNUE7pW4cwzIh778jyiQdHFkNDIscrQN7qHcOk0PH5CmhUgSU05/SuBlwvEylrAXfvwAWCeB3fxAqfUFbGtWfgY7WnLzoI78hcW/Q3btb4fL9Ecg7cR8Zx337aX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTmtQ3BFjz6LDDD;
	Thu, 17 Oct 2024 20:12:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F0C20140119;
	Thu, 17 Oct 2024 20:17:01 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 14:17:01 +0200
Date: Thu, 17 Oct 2024 13:16:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiju Jose <shiju.jose@huawei.com>
CC: Alison Schofield <alison.schofield@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: Re: [RFC PATCH 0/4] Updates for CXL Event Records
Message-ID: <20241017131659.00000224@Huawei.com>
In-Reply-To: <9e221493ff4a456cbdd1b773c670d1c7@huawei.com>
References: <20241016163349.1210-1-shiju.jose@huawei.com>
	<ZxAppnCBf4wFgcQ0@aschofie-mobl2.lan>
	<9e221493ff4a456cbdd1b773c670d1c7@huawei.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Oct 2024 10:39:58 +0100
Shiju Jose <shiju.jose@huawei.com> wrote:

> >-----Original Message-----
> >From: Alison Schofield <alison.schofield@intel.com>
> >Sent: 16 October 2024 22:01
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; vishal.l.verma@intel.com;
> >ira.weiny@intel.com; dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-
> >kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; tanxiaofei
> ><tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>
> >Subject: Re: [RFC PATCH 0/4] Updates for CXL Event Records
> >
> >On Wed, Oct 16, 2024 at 05:33:45PM +0100, shiju.jose@huawei.com wrote:  
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> CXL spec rev 3.1 CXL Event Records has updated w.r.t CXL spec rev 3.0.
> >> Add updates for the above spec changes in the CXL events records and
> >> CXL trace events implementation.
> >>
> >> Note: Please apply following fix patch first if not present.
> >> https://patchwork.kernel.org/project/cxl/patch/20241014143003.1170-1-s
> >> hiju.jose@huawei.com/
> >>
> >> Shiju Jose (4):
> >>   cxl/events: Updates for CXL Common Event Record Format
> >>   cxl/events: Updates for CXL General Media Event Record
> >>   cxl/events: Updates for CXL DRAM Event Record
> >>   cxl/events: Updates for CXL Memory Module Event Record  
> >
> >Thanks, this looks useful! I didn't review line by line but do have some feedback
> >before for a v1:  
> Hi Alison,
> Thanks for the feedbacks.
> 
> >
> >- Suggest being more explicit in the commit msg(s). Something like:
> >cxl/events: Update Common Event Record to CXL spec 3.1  
> Sure. Will add.
> 
> >
> >- I was a bit surprised that this doesn't simply append new fields to the
> >TP_printk() output. Is there some reason for that?  
> Will do. Thought print new fields before region_name and region_uuid. 
> 
Worth calling out that the other change is that 3.1 added the option
of a spec defined format for the component ID (various PLDM defined
fields)

I don't think we need to maintain ABI compatibility to TP_printk so to me it
makes sense to print that formatted version if that is what is provide instead
of (rather than as well as) the component IDs.

For RAS Daemon etc, that can be figured out in userspace if needed
so no point in changing the trace point, but the print being the
subfields is nice to have.

Jonathan

> >
> >- How about updating the mock of these events to include these new fields. I
> >don't think this introduces any new formats, but I would certainly eyeball all 3:
> >dmesg tp_printk, trace file, and monitor output because all 3 (sadly) present a
> >bit differently.
> >  
> I will update the CXL mock test for these new fields.
>  
> >-- Alison
> >  
> >>
> >>  drivers/cxl/core/trace.h | 201 +++++++++++++++++++++++++++++++++------
> >>  include/cxl/event.h      |  20 +++-
> >>  2 files changed, 190 insertions(+), 31 deletions(-)
> >>
> >> --
> >> 2.34.1
> >>  
> >  
> Thanks,
> Shiju

