Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9748269CE7
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367723; cv=none; b=TmJmt7VoVdZvOMhJWvf4xtWWq20nMjKbkCCCjodUeczsHpi+rdHEsqIg7eee+dn2LSok2iK773uBSffWz2F9OMxz6Jl4FrS5JsChxN+t1YO5RCqkmzO9PNvCdfXkZ0xCpjqKWdozV/VvkB/A0lF4pXHm7lZYQimJrZgN086sd7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367723; c=relaxed/simple;
	bh=TjaOMhZ/uiYrXuaxoWfaVWOnnB5CwJ7Mlcom1X1mHt8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkc3eDGMRhRf1u6lWQOyB8fUuOK+8ykpe4rotQca+O5iAyIZcZoG4lRV0QgkvSXU6f/3fNxcypG7zw0zwlDcErD+s+Icwn/p4zgt+pU2nYAj9dpDDYdEun+MZdGls1XgIvDVZxDtXevDGeYopy8ZnMcLM+NddIPBMr4l4oKUu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djSHd2mbkzJ468s;
	Fri,  2 Jan 2026 23:27:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB3A40569;
	Fri,  2 Jan 2026 23:28:37 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 2 Jan
 2026 15:28:36 +0000
Date: Fri, 2 Jan 2026 15:28:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <shiju.jose@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <armbru@redhat.com>, Fan Ni
	<fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	"Ravi Shankar" <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20260102152834.00003869@huawei.com>
In-Reply-To: <20251006062628-mutt-send-email-mst@kernel.org>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
	<20251006101304.000055f8@huawei.com>
	<20251006062628-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 06:26:53 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 06, 2025 at 10:13:04AM +0100, Jonathan Cameron wrote:
> > On Wed, 17 Sep 2025 15:33:27 +0100
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >   
> > > These two features have been used in testing the related EDAC RAS
> > > features drivers in Linux which are now upstream. Only minor tweaks
> > > from the second part of:
> > > https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> > > [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> > > 
> > > I've split that series up as the two parts were only slightly connected.
> > > However there is some churn if this is applied without the other part of Shiju's posted
> > > series. That was sent a few minutes ago as:
> > > https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> > > 
> > > Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> > > Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> > > 
> > > Davidlohr Bueso (1):
> > >   hw/cxl: Add support for Maintenance command and Post Package Repair
> > >     (PPR)
> > >   
> > Hi Michael,
> > 
> > I see you have queued some stuff up on your gitlab tree.
> > Just wanted to make sure these are on the radar for possible inclusion.
> > No huge rush, but I'll queue some more series up on top of these
> > shortly.
> > 
> > Thanks
> > 
> > Jonathan  
> 
> thanks for the reminder, will queue.
Hi Michael,

Looks like you didn't do another pull request for 10.2. If these can
go upstream fairly early in 11.0 that would be very helpful as we have
quite a few CXL series that I think are (nearly) ready.

I resent the events series but that was mainly because I'd forgotten you'd
replied to this one and so might already have both queued. Sorry about that
if you have them both already.

Jonathan

> 
> > > Shiju Jose (2):
> > >   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
> > >     attributes in cmd_features_set_feature()
> > >   hw/cxl: Add emulation for memory sparing control feature
> > > 
> > >  include/hw/cxl/cxl_device.h | 145 +++++++++
> > >  include/hw/cxl/cxl_events.h |  47 +++
> > >  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
> > >  hw/mem/cxl_type3.c          | 169 +++++++++++
> > >  4 files changed, 915 insertions(+), 12 deletions(-)
> > >   
> 
> 

