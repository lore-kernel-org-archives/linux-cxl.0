Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49E1CC14E
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724776701; cv=none; b=pThpKbvkYIVgvk78TnZPdaMn3Xihh2jM8NImy9H40TsVBxmBwSg8ZZl7pd5PqKyeiAhraOX2aB0Heaah4ohkZBHoQ5QTBIKaWkNVu29IItUpPsxl3fbXvro7trSlnli6ejC+u3O2+pp7RriHLEDTxAC103jDb4jEJy1wm5oNrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724776701; c=relaxed/simple;
	bh=Ovn4NXl2Dc+dMc9F//2yKUXoCKx8vIIDfNLVuDTZIQw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruupUy76f67qersPA356AFb12RZecnD0w+oPm5v80TggbRANHSMJyEOV2F2riVtXYatrkTRpQC00RZEx8P90V3coC/olzgLiEMlhbCAHUYkcVq0NyziGKsuOdbtw5Rdh1eSVJRXMp/bK1MtzmX2yEjbBDPH/WiEzg7Nfwo5HdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtY6q5Srwz6L6sV;
	Wed, 28 Aug 2024 00:34:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B3CEC140A35;
	Wed, 28 Aug 2024 00:38:14 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:38:14 +0100
Date: Tue, 27 Aug 2024 17:38:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: ajay.opensrc <ajay.opensrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"john@jagalactic.com" <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, "Srinivasulu
 Thanneeru" <sthanneeru@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
	Aravind Ramesh <arramesh@micron.com>, "Davidlohr Bueso" <dave@stgolabs.net>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin"
	<mst@redhat.com>
Subject: Re: [EXT] Re: [PATCH] hw/cxl: Fix background completion percentage
 calculation
Message-ID: <20240827173813.00001cab@Huawei.com>
In-Reply-To: <ad56f019ee6e43f4b209a814f5494af0@micron.com>
References: <20240729102338.22337-1-ajay.opensrc@micron.com>
	<svy4snogtc2k5423b4vtmzaoaryetmxzatjfiqfeiywepkr7us@dcslpmazfuw5>
	<ad56f019ee6e43f4b209a814f5494af0@micron.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 27 Aug 2024 16:01:54 +0000
ajay.opensrc <ajay.opensrc@micron.com> wrote:

> > From: Davidlohr Bueso <dave@stgolabs.net>
> > 
> > On Mon, 29 Jul 2024, ajay.opensrc@micron.com wrote:\n  
> > >From: Ajay Joshi <ajayjoshi@micron.com>
> > >
> > >The current completion percentage calculation does not account for the
> > >relative time since the start of the background activity, this leads to
> > >showing incorrect start percentage vs what has actually been completed.
> > >
> > >This patch calculates the percentage based on the actual elapsed time
> > >since the start of the operation.
> > >
> > >Fixes: 221d2cfbdb ("hw/cxl/mbox: Add support for background
> > >operations")
> > >
> > >Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>  
> > 
> > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>  
> 
> Ping.
> Jonathan, this patch was reviewed by Dave already.
> Do you have any comments on this patch?

Sorry bit behind. Seems fine to me.   I'll queue it up, but not sure
when I'll get a fixes series out (hopefully soon!)

+CC Michael in meantime.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
in case Michael wants to pick it up directly.

Thanks,

Jonathan

> 
> Ajay
