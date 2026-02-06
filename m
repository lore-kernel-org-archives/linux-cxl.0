Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2B3559D0
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370964; cv=none; b=fnqr9LLRLw3zHMAmDkvXVw1TCCopvesEbvGCu3PIBtLuCHygntVlxbImYBZ4rrSthXr+m/7dPLiLRvcSy/iD5uqWTSRdGz0Hjyer/BW4wiCnfSyloayCO9wThJfPzPy4hsZXAtfBDhiPxvdp5shUsmFFvSvDX3lBidhObuJMpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370964; c=relaxed/simple;
	bh=n1OFGqXVrjB+SSm8eyv7Y8z2DT5P1obOJbX7zIX8BHw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gdmm61/UKKfg+BiflV26ZtiDf5VtMrjLoigHmHPFc4kt17dHh8jE3RSl0U7whILmxqJd3A0fgjUBrdBOkCKGSBETM7msxXR6rLDZ/XtIfgRs+bz5+S4NhBeypoV2YInYWZ1/1XK3Gli1V2lYdo407B1gN2/Tf0icqtCg82hf4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6pyP0YLSzJ46jG;
	Fri,  6 Feb 2026 17:41:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D58F40565;
	Fri,  6 Feb 2026 17:42:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 09:42:40 +0000
Date: Fri, 6 Feb 2026 09:42:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, "Vinayak
 Holikatti" <vinayak.kh@samsung.com>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, Ravi Shankar <venkataravis@micron.com>,
	qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
Message-ID: <20260206094239.000065c4@huawei.com>
In-Reply-To: <3e767269-b39c-42e2-8283-598e16aa7b71@tls.msk.ru>
References: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
	<3e767269-b39c-42e2-8283-598e16aa7b71@tls.msk.ru>
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

On Fri, 6 Feb 2026 01:11:55 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> On 1/2/26 18:47, Jonathan Cameron via wrote:
> > Peter reported both of these last cycle.  Both are related to sanity
> > checking parameters.
> > 
> > Jonathan Cameron (2):
> >    hw/cxl: Check for overflow on santize media as both base and offset
> >      64bit.
> >    hw/cxl: Take into account how many media operations are requested for
> >      param check
> > 
> >   hw/cxl/cxl-mailbox-utils.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)  
> 
> Is this one worth picking up for qemu-stable (10.1.x & 10.2.x)?
> 
They are fairly obscure features but if it applies cleanly it seems
sensible to backport.

Thanks

Jonathan

> Thanks,
> 
> /mjt

