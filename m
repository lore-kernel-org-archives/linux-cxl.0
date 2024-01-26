Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3314298
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269410; cv=none; b=MLMTxRHheaMaIR7G4+WyMEU0HN5Zk4Yf4Tcmv2tM8s1s8XUJiQU1lrvjmt+AZ8DH8V57uVoVrz+EyYZ3BNqLVWC+lCzqjWdYC6+IrRmiu/z2T+/9NOkCvCIUayIFFbVSAOHzxXijtVEC+wp1ups3NFfP6Lt54ObZBfnZhohyEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269410; c=relaxed/simple;
	bh=tHoHtuPOi2duesss3AYwY0IIBDNXz1fbqYCH0mut7J0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kpcs0X1DJUcPxO/IcDuCYqACjbo6y4jyXV4gqlfvp5vw5OsR1vPdwr5I2/ZvHps5bTmUQLMZOlLgiNjWnO95cdFtDsD1ZH2NfkUZbAKYQWzgV2eWjhlvuMcZGxSFRkKd+N1A98RjSwloKw1d/oPPKutYtMriheLtLeQSoJxkYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLwjx0xpXz689rg;
	Fri, 26 Jan 2024 19:40:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 73AA4140CF4;
	Fri, 26 Jan 2024 19:43:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 11:43:17 +0000
Date: Fri, 26 Jan 2024 11:43:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>, Davidlohr Bueso
	<dave@stgolabs.net>, <linuxarm@huawei.com>, Philippe =?ISO-8859-1?Q?Mathieu?=
 =?ISO-8859-1?Q?-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 5/5] hw/cxl: Standardize all references on CXL r3.1 and
 minor updates
Message-ID: <20240126114316.00006b9a@Huawei.com>
In-Reply-To: <ZbF56-RHbxY9yAUv@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
	<20240124134814.8717-6-Jonathan.Cameron@huawei.com>
	<ZbF56-RHbxY9yAUv@debian>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Jan 2024 12:58:19 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Wed, Jan 24, 2024 at 01:48:14PM +0000, Jonathan Cameron wrote:
> > Previously not all references mentioned any spec version at all.
> > Given r3.1 is the current specification available for evaluation at
> > www.computeexpresslink.org update references to refer to that.
> > Hopefully this won't become a never ending job.
> > 
> > A few structure definitions have been updated to add new fields.
> > Defaults of 0 and read only are valid choices for these new DVSEC
> > registers so go with that for now.
> > 
> > There are additional error codes and some of the 'questions' in
> > the comments are resolved now.
> > 
> > Update documentation reference to point to the CXL r3.1 specification
> > with naming closer to what is on the cover.
> > 
> > For cases where there are structure version numbers, add defines
> > so they can be found next to the register definitions.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---  
> 
> There are several references to the spec is incorrect, other than that
> LGTM.
> 
> Search "Identify Memory Device (Opcode 4000h)" for inline comments.
Thanks for ploughing through all this!


> >      /* Store off everything to local variables so we can wipe out the payload */
> > @@ -760,7 +757,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > -/* 8.2.9.5.1.1 */
> > +/* CXL r3.1 Section 8.2.9.8.1.1: Identify Memory Device (Opcode 4000h) */  
> 
> Should be 8.2.9.9.1.1

Oops. I think I had the 3.0 spec open by accident when doing some of these.
Good catch - I'll fix these all up and send a v2.

