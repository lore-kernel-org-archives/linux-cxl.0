Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7829B76C
	for <linux-cxl@vger.kernel.org>; Tue, 15 Apr 2025 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731435; cv=none; b=Fz+4hY4L1ccnSVXStbQ9aCMo8BMeIAFyRxIQEjEziusENuFRsWX44nmb7s2aM+TJ4IHwEqs8zMpSQAAT/RjX/Yz+pxUXGCQUgeXQ/Joc6zLF04gkhIIY3koXC+bZAIl330PMcw9gpFfmfM2Ru6kNWXY/X/QrhjnjfRtzcIn+gHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731435; c=relaxed/simple;
	bh=LPnYTUBmrxWkMtcbuCXlJzb+qwf9QwBDkWTN2MN7OaU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdN6raksgST4QeLNbhsUjmmEKTNg2mm7ON/AB0RI36ZDywie0x2jtSgKMcdZvwrBDGgXIcil7al8rDbW+efHoqaIQMU0HIzhildXNYAJvQ08lwSmmzKhzJCrThretZSkctXw8YBjrjKoP6dhjWn/y8Z18wNYBIu6TwT/vpPMEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcSpd57h8z6K9By;
	Tue, 15 Apr 2025 23:32:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 561B1140144;
	Tue, 15 Apr 2025 23:37:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 17:37:08 +0200
Date: Tue, 15 Apr 2025 16:37:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: Gregory Price <gourry@gourry.net>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <anisa.su887@gmail.com>, Markus Armbruster
	<armbru@redhat.com>
Subject: Re: [RFC 0/3] Qemu FM emulation
Message-ID: <20250415163707.00005091@huawei.com>
In-Reply-To: <Z_0tRwHNXD8idZl-@debian>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
	<Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F>
	<Z_0tRwHNXD8idZl-@debian>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Apr 2025 08:44:07 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Tue, Apr 08, 2025 at 11:04:20AM -0400, Gregory Price wrote:
> > On Mon, Apr 07, 2025 at 09:20:27PM -0700, nifan.cxl@gmail.com wrote:  
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > The RFC provides a way for FM emulation in Qemu. The goal is to provide
> > > a context where we can have more FM emulation discussions and share solutions
> > > for a reasonable FM implementation in Qemu.
> > >  
> > ... snip ...
> > 
> > Took a browse of the series, and I like this method.  It seems simple
> > and straight-forward, avoids any complex networking between the vms and
> > gives us what we want.
> > 
> > I'll wait for Jonathan's commentary, but solid prototype (bn_n)b
> > 
> > ~Gregory  
> 
> Hi Jonathan,
> 
> Any feedback for this RFC?

Immediate question is whether anything similar is done in other use cases
in QEMU?   There are vaguely similar things that work via a socket but
I'm not sure the mix of a shared buffer and a qmp based doorbell is done
elsewhere.  There is use of shared memory for inter VM comms but that uses
a socket for it's doorbell / interrupt path, not qmp.
https://www.qemu.org/docs/master/specs/ivshmem-spec.html

So without looking in that much detail yet, I'm not yet convinced this is
preferable to a socket over which we can send the mctp packets.

In general we need to also solve how to upstream the mctp support in
qemu or this is adding yet more stuff to my cxl staging tree.

+CC Markus for QMP part.

https://lore.kernel.org/all/20250408043051.430340-1-nifan.cxl@gmail.com/
is start of thread.
https://lore.kernel.org/all/20250408043051.430340-3-nifan.cxl@gmail.com/
the qmp patch adding what is more or less a doorbell pinged by a device
on a different  QEMU instance.

Jonathan

> 
> Fan

