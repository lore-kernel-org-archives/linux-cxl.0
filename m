Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BA26A1B9
	for <linux-cxl@vger.kernel.org>; Wed,  5 Nov 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335149; cv=none; b=VMDS7KiugzQ+I3HDnHpeZijzu6oxnckmh3cmCqtEskxtcZHDynI3ufQQDyO4LFw2Av0cJEQZalOPyEzF5Tmy68x3tUUxndDItgEIZrf2gtNQ/+zVtAwET9IWW+Utj5ZjadFjT8N11r9R0mu3hX9iTahvMF8ekcKw+tdvwgGUtLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335149; c=relaxed/simple;
	bh=M25umAkiGD3jBlZh9qDI/mtWj+GxK9x367+Yt2GOKcE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lyy9RVL07JYw6DlQIWdrgBvVE2GLchd5z8rQY4mgp72iS8DUrZPeW4sY8eV+9xQPdGgQOMTBTAORPmLGiXs498jN59Q1oOlKaP5IRLrtspy47qFoDd+s27Fd+mVSqteD6CH8/1pWDL/HoI79DbRbVmcPhBS2Xfgt9yifteTzZRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1g8M0ZlLzHnGcR;
	Wed,  5 Nov 2025 17:32:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 276FD140278;
	Wed,  5 Nov 2025 17:32:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 09:32:23 +0000
Date: Wed, 5 Nov 2025 09:32:21 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, <linux-cxl@vger.kernel.org>,
	<linuxarm@huawei.com>, <nifan.cxl@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU
 reviewer
Message-ID: <20251105093221.00007b80@huawei.com>
In-Reply-To: <CAFEAcA_Dm89kafy028KWjbtxTRdCKLgc4KGCPJwxLdXf6monjg@mail.gmail.com>
References: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
	<CAFEAcA_Dm89kafy028KWjbtxTRdCKLgc4KGCPJwxLdXf6monjg@mail.gmail.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 16:17:07 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 28 Feb 2023 at 11:39, Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
> >
> > Fan Ni has offered to help out with QEMU CXL emulation reviewing.
> > Add him as a designated reviewer.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > --
> > Thanks to Fan for stepping up after I requested help following Ben
> > stepping down as co-maintainer. Fan base been active in testing
> > and review recently so great to have Fan on board.
> >
> > Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky
> >
> > Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7ea56c6ccc..838e1a91a4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2633,6 +2633,7 @@ T: git https://gitlab.com/vsementsov/qemu.git block
> >
> >  Compute Express Link
> >  M: Jonathan Cameron <jonathan.cameron@huawei.com>
> > +R: Fan Ni <fan.ni@samsung.com>
> >  S: Supported
> >  F: hw/cxl/
> >  F: hw/mem/cxl_type3.c  
> 
> Hi; I noticed today that Fan's samsung email is now bouncing
> with "550 5.1.1 Recipient address rejected: User unknown".
> Do we have a altenate email for him, or should we remove
> his entry from the QEMU MAINTAINERS file; and if so is there
> anybody else we should add as a reviewer for CXL ?

My bad. I've had this on my todo list since Fan moved.

nifan.cxl@gmail.com
is the address Fan asked me to use.

I do plan to add a second reviewer (more welcome!) as Fan's time is
limited (not the day job any more), but wanted to let them ramp up
and review informally for a bit first.

Thanks,

Jonathan

> 
> thanks
> -- PMM

