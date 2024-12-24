Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95454C80
	for <linux-cxl@vger.kernel.org>; Tue, 24 Dec 2024 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735053202; cv=none; b=lmOFOK0qh8I7Wgp7Ciz7iMfYeNg3SVusNJ0yToDWba+I/uPqyZKXM/bQ+QS7N/LAWh2rZifIccFVsLj7NlJqMW/6U8lpMKUV8pEir+m9lnaqjgyZRipDs/NANIbGaPsRrmQQEF5OmVlYJtXQmRKdrxCzsNbG70bdYphfPwHDJY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735053202; c=relaxed/simple;
	bh=Nva82DnPbSDYVGLowBTRHcHfcxJETHiqVixsogrvZ54=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnUHsGIWJCDRn9iA/bbBCa2ALjURDQ8mz7RE8jrlUbGH6H4HN2zyRYiCN5y/V/fNkwPlOOpQkvk2K6OqpIPea7VYTbpWQwMXmVbblQUjgMN6zTRGrXatGiC23lwj6A7F8IUubiHSBVASfqoPajrzQ63xK4KjjrcjMqmfUtRoBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHdfD0kkvz6LCrH;
	Tue, 24 Dec 2024 23:12:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A8A5140B73;
	Tue, 24 Dec 2024 23:13:17 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:13:17 +0100
Date: Tue, 24 Dec 2024 15:13:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Hongjian Fan <hongjian.fan@seagate.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/mem: support zero memory size CXL device
Message-ID: <20241224151315.0000068e@huawei.com>
In-Reply-To: <Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
References: <20241202230310.1531219-1-hongjian.fan@seagate.com>
	<20241203172328.00001a00@huawei.com>
	<CH0PR20MB42505D4F82D534A85EEA4C2A90362@CH0PR20MB4250.namprd20.prod.outlook.com>
	<Z1iS2SeYSOQqdLVU@PC2K9PVX.TheFacebook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 10 Dec 2024 14:13:29 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Tue, Dec 03, 2024 at 09:15:51PM +0000, Hongjian Fan wrote:
> > Hi Jonathan,
> > 
> > I'm trying to emulate our memory appliance which is similar to a MH-SLD. The memory device is connected to the host server while the size of the memory could be changed by the out-of-band fabric manager. If there is no memory assigned to the host, the CXL device will be booted as zero memory size.  
> 
> This should not be how this is done.
Agreed, but...

It sounds like a pre DCD boot time only pooling solution?

What is the path to adding memory?

> 
> The ACPI tables should report the maximum possible size, and the DCD
> infrastructure should enable physical regions that have been added to the host.
> 
> Changing ACPI tables to report 0 memory size will basically result
> in the host memory map not reserving physical memory regions for that
> device.
This isn't the ACPI bit, it's just the device reporting.  Can have a huge
CFMWS and tiny devices.

> 
> See this emulation example of an MHSLD - which can be used for DCD.
> 
> https://lore.kernel.org/linux-cxl/20241018161252.8896-1-gourry@gourry.net/
> 
> > Recently we got some interest on trying our fabric manager software without having the real hardware. Supporting zero memory size in QEMU will be needed in this scenario.
> > Some detail about our memory appliance could be found from our OCP presentation: https://drive.google.com/file/d/1i8kBsBfRGjNqnTQqJ9upC-Xm9o56Y2Y5/view?usp=drive_link

That doesn't really give me any indication of how the addition of memory happens.

Jonathan

> > 
> > Thanks,
> > Hongjian Fan
> > 
> > 
> > Seagate Internal  

