Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13483CC7
	for <linux-cxl@vger.kernel.org>; Fri, 13 Jun 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749820224; cv=none; b=r7DsDsm4w9JivL3TCA2fpTKhXDV9bTPHieyS+QrIDvinKASsHyh45tmfDD4mH9C3ovdej0JOkpR/aEbZxYJLxwI937F12FU1yMkXnKBxzC/22HZDV/D9APixbltVHU6VN654S/qNJycGcFQAKX9sDqwYtMekkJragyDrWp8gY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749820224; c=relaxed/simple;
	bh=KhRhNtWSgPehTYYIFk6vhsM8CVWSnYaHOFgtzj28lC0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDtiL3/sHSyYeuVHNam0bTbRurqKXliGAsD4QQlPJ8GwNWTZoAcp02ARrXLQG6j9A722OmFjuvlWh/NmAHFjrAQ6dTF90PFjVtXV2dPkbAPKfpVT13jbc1f/mx5fpk12vkMDA7CpAKS9zx/P73KXNpVGcRvvZZYm0cG8YcXMyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJfp55RkBz6K9kL;
	Fri, 13 Jun 2025 21:07:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1257414038F;
	Fri, 13 Jun 2025 21:09:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Jun
 2025 15:09:55 +0200
Date: Fri, 13 Jun 2025 14:09:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Fan Ni <fan.ni@samsung.com>, <mst@redhat.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, <linuxarm@huawei.com>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows
 devices.
Message-ID: <20250613140954.000013f5@huawei.com>
In-Reply-To: <CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
	<20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
	<CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Jun 2025 13:33:51 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 12 Jun 2025 at 14:44, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > Previously these somewhat device like structures were tracked using a list
> > in the CXLState in each machine. This is proving restrictive in a few
> > cases where we need to iterate through these without being aware of the
> > machine type. Just make them sysbus devices.  
> 
> 
> > +static void cxl_fmw_realize(DeviceState *dev, Error **errp)
> > +{
> > +    CXLFixedWindow *fw = CXL_FMW(dev);
> > +
> > +    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
> > +                          "cxl-fixed-memory-region", fw->size);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
> > +}
> > +
> > +static void cxl_fmw_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->desc = "CXL Fixed Memory Window";
> > +    dc->realize = cxl_fmw_realize;
> > +    /* Reason - created by machines as tightly coupled to machine memory map */
> > +    dc->user_creatable = false;
> > +}  
> 
> Do these things have any state that needs migrating or resetting?
> If they do, they need a reset function and a vmstate. If not,
> it's helpful to have a comment explaining that the device
> has no state to be reset or migrated, so future readers of
> the code know this wasn't just accidentally forgotten.

Hi Peter,

For these specific devices (the fixed memory windows) there isn't
any state as they are representing fixed configuration of the system.
The state is all in the host bridges and beyond. I'll add
a comment as you suggest.

Currently CXL emulation is completely broken wrt to migration and
there are some known issues for reset as well. Both are on the list
of things to fix. Migration is less important as the only current use
for this stuff is running software stack test cases and for that
migration isn't currently of interest - that will change for some
of the virtualization related work that is just getting started.
The reset thing needs more work for devices as we've tripped over
a few corner cases triggered by people rebooting the guest and device
state not being fully cleared.  On top of that we have a complex
nest of device reset types to cover at some point as some registers
are sticky over some types of reset.

Jonathan



> 
> thanks
> -- PMM

