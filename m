Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99DA20C492
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090294; cv=none; b=C4sVxJ3cRySmMRMxbbiWIhNj/tyVnwKFI7oynI5F1/RaurVlUfcLUsJh+Nib6wggrCja5a/HsTSUEvpJsvINlwar8KBBeGYzaZhPOICIoKgkySPnEJInma6FscZ5dzzccB5leg/TxY9E9A23BGje2MfKVmkJe6s+mXoyfRll9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090294; c=relaxed/simple;
	bh=lKZyca2sTbceijvRh811QEKg3a4QEJDHiFjcE5/yFHw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZpsJgHsPjnVf+q6+pU1JFGdyKoLq/U0lAh8WEys/1rMinM47zWzdMkcrbhijTG6WpMCeAQ1EQPHNZ4aqiFJbH7EdWN35xPLgHgCYUJcstlr2U43pluSyZcQDL6S7HPTEzHevknHpeZtPpW6gWRjqyEOn9QA9yRkgMVYbO6uFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTDM84QVzz6D99x;
	Wed, 16 Oct 2024 22:47:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B4FBA140393;
	Wed, 16 Oct 2024 22:51:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 16:51:30 +0200
Date: Wed, 16 Oct 2024 15:51:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
Message-ID: <20241016155129.00001d22@Huawei.com>
In-Reply-To: <670ead2735632_3ee2294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
	<172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
	<20241015173642.00007d1f@Huawei.com>
	<670ead2735632_3ee2294df@dwillia2-xfh.jf.intel.com.notmuch>
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

> > >  
> > > -static void cxl_bus_rescan_queue(struct work_struct *w)
> > > +static int attach_device(struct device *dev, void *data)  
> > 
> > That naming is never going to be a problem :)
> > I'd prefix this with something more specific  
> 
> I don't immediately see a problem since that symbol is private to the
> cxl core. Any alternate name ideas?
Not an immediate problem until another attach_device() shows up
that isn't private.

Ah well whoever introduces that gets to rename this I guess.

Jonathan

> 

