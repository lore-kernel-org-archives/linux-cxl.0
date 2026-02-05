Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEE03A6411
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291624; cv=none; b=Gn7kNIpAEIc5XO/1XDCK0ykQZIVJhbHdzL8cNf93V1F4ZU0lD0QBWYo+Se2NSC8zsIjX+Bl0WNopYZkc6SwfhdMVVHc4ogw9MGADroV9nFWZfJV+6CbTOgzICGyesZigEiMRhhcXFJgpROVBz3wxk9B6Q5+JrNlEPnfmPhAXCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291624; c=relaxed/simple;
	bh=r4iu3kbhUxRqZgdf4YVe5XlKjVqfNB77WnuJAb/W6Vk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnVmOemTYWMpR0AbScunJ6hu1QwgyVFn4LdjIcRd2HWBgJBk2Ycs6QT+a0keA98qGVkda1VrSalxMnISCMLnz0AV1EhMyvryMDr+iZRccj280jcuWRf/DnXvNxqVKmwzqpZUiilG1kw/bUQ3ASYMjPkVNXwrk3wh6sKyUXNvVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6Fcd5BrWzJ46lp;
	Thu,  5 Feb 2026 19:39:29 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 5144540570;
	Thu,  5 Feb 2026 19:40:20 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Feb
 2026 11:40:19 +0000
Date: Thu, 5 Feb 2026 11:40:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <linuxarm@huawei.com>,
	<shiju.jose@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20260205114018.000027aa@huawei.com>
In-Reply-To: <20260205031548-mutt-send-email-mst@kernel.org>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
	<20251006101304.000055f8@huawei.com>
	<20251006062628-mutt-send-email-mst@kernel.org>
	<20260102152834.00003869@huawei.com>
	<20260204113526.00001040@huawei.com>
	<20260205031548-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 5 Feb 2026 03:16:15 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 04, 2026 at 11:35:44AM +0000, Jonathan Cameron wrote:
> > On Fri, 2 Jan 2026 15:28:34 +0000
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >   
> > > On Mon, 6 Oct 2025 06:26:53 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Mon, Oct 06, 2025 at 10:13:04AM +0100, Jonathan Cameron wrote:    
> > > > > On Wed, 17 Sep 2025 15:33:27 +0100
> > > > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > > > >       
> > > > > > These two features have been used in testing the related EDAC RAS
> > > > > > features drivers in Linux which are now upstream. Only minor tweaks
> > > > > > from the second part of:
> > > > > > https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> > > > > > [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> > > > > > 
> > > > > > I've split that series up as the two parts were only slightly connected.
> > > > > > However there is some churn if this is applied without the other part of Shiju's posted
> > > > > > series. That was sent a few minutes ago as:
> > > > > > https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> > > > > > 
> > > > > > Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> > > > > > Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> > > > > > 
> > > > > > Davidlohr Bueso (1):
> > > > > >   hw/cxl: Add support for Maintenance command and Post Package Repair
> > > > > >     (PPR)
> > > > > >       
> > > > > Hi Michael,
> > > > > 
> > > > > I see you have queued some stuff up on your gitlab tree.
> > > > > Just wanted to make sure these are on the radar for possible inclusion.
> > > > > No huge rush, but I'll queue some more series up on top of these
> > > > > shortly.
> > > > > 
> > > > > Thanks
> > > > > 
> > > > > Jonathan      
> > > > 
> > > > thanks for the reminder, will queue.    
> > > Hi Michael,
> > > 
> > > Looks like you didn't do another pull request for 10.2. If these can
> > > go upstream fairly early in 11.0 that would be very helpful as we have
> > > quite a few CXL series that I think are (nearly) ready.
> > > 
> > > I resent the events series but that was mainly because I'd forgotten you'd
> > > replied to this one and so might already have both queued. Sorry about that
> > > if you have them both already.  
> > 
> > This is the second series that is (I think) ready for merge.
> > Applies cleanly on mainline + 
> > [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> > 20260119111542.788389-1-Jonathan.Cameron@huawei.com  
> 
> question is if there will be v5 of that one, now there
> are review comments?
> 
Posted.  This applies cleanly on top of that (it only involved moving 2 lines within
functions that aren't touched by anything else we have pending.

So now, based on:
[PATCH qemu v5 0/5] cxl: r3.2 specification event updates.
https://lore.kernel.org/qemu-devel/20260205112350.60681-1-Jonathan.Cameron@huawei.com/

> > > 
> > > Jonathan
> > >   
> > > >     
> > > > > > Shiju Jose (2):
> > > > > >   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
> > > > > >     attributes in cmd_features_set_feature()
> > > > > >   hw/cxl: Add emulation for memory sparing control feature
> > > > > > 
> > > > > >  include/hw/cxl/cxl_device.h | 145 +++++++++
> > > > > >  include/hw/cxl/cxl_events.h |  47 +++
> > > > > >  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
> > > > > >  hw/mem/cxl_type3.c          | 169 +++++++++++
> > > > > >  4 files changed, 915 insertions(+), 12 deletions(-)
> > > > > >       
> > > > 
> > > >     
> > > 
> > >   
> 
> 

