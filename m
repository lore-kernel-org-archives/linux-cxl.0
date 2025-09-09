Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6688343210
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426945; cv=none; b=sE3Y8VQCGsqickqUdLAz6ar/hyOhEjsq7TsDPV9yFZb1ycCRiUrbHQkc7KVJMpHyBl2yE5B3B4o2xIE51kF9oQYhZ2sgAQFTcuSe8PliRWWBt+oSn+V8+90MHv3ARzMrjM7xN+rL614PaLSaSMoHOEX20p4qkoNNbUShxbsfdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426945; c=relaxed/simple;
	bh=ScGtWaq88mD5k4FIVwQ1G2KpmbfGz21C+S0dcJqSH4s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrjQGnz2L+wUPYYIA75gPiGMPxnPMM0s0p3Z/MQeQAndGT5iPyjHv1GK+ZvFj+EhUZeknYvjPxcYF+n5CcKTBpZxRHT3AvL5ibRGbJRTqtiZ1Rgy0aZaQ7qpyz8tn2VeSlS0w7NpMPW+L0dEc/2PdTLfdRvSboUoNDGv80z/8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLlv86hj5z6L50M;
	Tue,  9 Sep 2025 22:04:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F7EC1401DC;
	Tue,  9 Sep 2025 22:09:00 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 16:09:00 +0200
Date: Tue, 9 Sep 2025 15:08:59 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Joshua Lant <joshualant@googlemail.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [QEMU- PATCH 1/1] cxl_type3: fix segfault in
 cxl_destroy_dc_regions
Message-ID: <20250909150859.000055f3@huawei.com>
In-Reply-To: <aL754ZJlIUCOCotE@thinkpc>
References: <20250904090346.884649-1-joshualant@gmail.com>
	<20250904090346.884649-2-joshualant@gmail.com>
	<20250905155456.00005f7f@huawei.com>
	<aL754ZJlIUCOCotE@thinkpc>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 8 Sep 2025 16:44:33 +0100
Joshua Lant <joshualant@googlemail.com> wrote:

> > On Thu,  4 Sep 2025 10:02:22 +0100
> > Joshua Lant <joshualant@googlemail.com> wrote:
> >   
> > > CXL_TYPE3_CLASS() should be CXL_TYPE3_GET_CLASS() given object (CXLType3Dev)
> > > input. Leads to segfault in object_class_dynamic_cast.
> > > 
> > > Fixes: ef730035567
> > > 
> > > signed-off-by: Joshua Lant <joshualant@gmail.com>  
> > 
> > Good find.
> > 
> > The Fixes tag needs fixing though.
> > Should be all part of the tags block and needs to include the patch name.
> > I'm not finding the SHA though.
> > 
> > I think that tag is probably Svetley's MHD callback patch which isn't upstream
> > so I'll squash this in my local tree and it will be fixed in the next tree
> > I put up on gitlab.com/jic23/
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Yeah sorry, it is that MHD patch. I managed to write a rogue '7' at the end of
> the hash somehow. Have reposted with updated tags block...
> 
I smashed it into the mhd patch locally and it will end up in there when I push
a new tree, so the fix won't be directly visible as a separate patch.

Thanks anyway for working out what was wrong with the tag.

Jonathan

> Cheers,
> 
> Josh

