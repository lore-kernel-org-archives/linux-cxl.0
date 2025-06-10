Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FA1C68F
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566835; cv=none; b=vCsXgyg7X6QloqfUr6M/mfeqjBSRI4iDcwlA84y6ogQ2SV/JfcnLN24VJn8EJLTPyaEfkhz7h+2lRizUVWZAgGA+mWLEa0d415NbzqWNCAo9nbEFifoh3iXCBzUhQCDwE1Rp/YKCWJGS6BPRdTMXBY1vGW+PSVD7cXhfEqnOrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566835; c=relaxed/simple;
	bh=otpOxX+zwE7vE+Ad31yMqsz5wXE1nRSpei0oG005nqo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcZaTW9ilDPybXNi+p4aqGIbj8JfxbEZjwWCH7v/n5ugUvbORSVL41l2SrwzwgSSQUJYf6RW1EHXL8b0cBP0MPOG/zXVhCJpFGvP06TF/tY1QFknAlFSn6RDz1jur8tpunWSpMaKJWaWzdCfdKRaSasjmrzgY79Uc2fkT2NrUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGs7W4mR7z6D92b;
	Tue, 10 Jun 2025 22:46:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 96D3014025A;
	Tue, 10 Jun 2025 22:47:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 16:47:10 +0200
Date: Tue, 10 Jun 2025 15:47:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands
 0x5600-0x5605
Message-ID: <20250610154708.000074a6@huawei.com>
In-Reply-To: <aEI2OqYwgTLw4KsY@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
	<20250520143947.00000337@huawei.com>
	<20250530152655.00007132@huawei.com>
	<aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>
	<aEI2OqYwgTLw4KsY@deb-101020-bm01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 6 Jun 2025 00:28:42 +0000
Anisa Su <anisa.su887@gmail.com> wrote:

> On Mon, Jun 02, 2025 at 05:46:57PM +0000, Anisa Su wrote:
> > On Fri, May 30, 2025 at 03:26:55PM +0100, Jonathan Cameron wrote:  
> > > On Tue, 20 May 2025 14:39:47 +0100
> > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > >   
> > > > On Thu,  8 May 2025 00:00:56 +0000
> > > > anisa.su887@gmail.com wrote:
> > > >   
> > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > >   
> snip 
> > > Anisa,
> > > 
> > > Ideally I'd like to get the majority of this upstream once you post
> > > a v3.  To do that I'd like to break the dependence on mctp_i2c in patch 2.
> > > These commands are equally valid via a switch-cci (and that path to the
> > > fm owned ld_mctpcci is already upstream).
> > > 
> > > If you could send it as two series. One of which sits on upstream and
> > > doesn't include the i2c_mctp part and the other of which is applied once
> > > that support is available in my tree that would be great. I'll squash
> > > the i2c_mctp part into the patch that adds support for that in the
> > > first place.
> > > 
> > > I'll deal with rebasing needed for other command introductions etc.
> > >   
> Hi Jonathan,
> 
> I applied the v3 patches (which are based on ToT master) on your latest
> published branch cxl-2025-03-20 + Fan's patch fixing dc extent tracking
> and then edited the first patch to add the i2c_mctp stuff and rebased
> the remaining patches on top.
> 
> Would it be easier for you if I send you those?
I'm lost in the description I'm afraid.  Maybe just have a go at it and we'll
see?

Jonathan

> 
> Let me know, thanks!
> Anisa
> 
> > > There are just enough open questions in this series that I haven't done
> > > this rework directly (though I did start doing it - hence the missing
> > > include note in one of the patches).
> > > 
> > > Thanks,
> > >   
> > Sounds good, will do :)
> > 
> > Thanks,
> > Anisa  
> > > Jonathan  
> > > > 
> > > > Jonathan
> > > > 
> > > > 
> > > >   
> snip
> > > > > Anisa Su (10):
> > > > >   cxl-mailbox-utils: Move opcodes enum to new header file
> > > > >   cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
> > > > >   cxl/type3: Add dsmas_flags to CXLDCRegion struct
> > > > >   cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
> > > > >   cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
> > > > >     DC event types
> > > > >   hw/cxl_type3: Add DC Region bitmap lock
> > > > >   cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
> > > > >   cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
> > > > >   cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
> > > > >   cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> > > > > 
> > > > >  hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
> > > > >  hw/cxl/i2c_mctp_cxl.c        |   6 +-
> > > > >  hw/mem/cxl_type3.c           |  41 ++-
> > > > >  include/hw/cxl/cxl_device.h  |  24 ++
> > > > >  include/hw/cxl/cxl_events.h  |  15 +
> > > > >  include/hw/cxl/cxl_mailbox.h |   6 +
> > > > >  include/hw/cxl/cxl_opcodes.h |  72 ++++
> > > > >  7 files changed, 724 insertions(+), 89 deletions(-)
> > > > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > > > >     
> > > > 
> > > >   
> > >   

