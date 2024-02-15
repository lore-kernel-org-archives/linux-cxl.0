Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53DF12D74A
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000457; cv=none; b=spRfalONO7Clcp6vLf7h1LhEq0Ahi9q8h6ilZmQSQwbglxu7kGhflbUxUGAykmPOvaSC7oK4oULhYtFZ9uUkd+IZYm+ApReEX3C1QHUw5TUB/G9gXZhDksHMX5urCn+k0N+U96W31tsbUb09HIWD5Sa3GDQwI91f/YfPIW7zydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000457; c=relaxed/simple;
	bh=X6uRUfNRPZ7rFScXpJAsQJPPjE4DmsHv+jE8OCptbKM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPzd8ZMpK6ryh/YmJ0XuwXFAlV28SIuh8j4jChbDKZe5TtDbJs+xDGHwMbeAidU807oAf6UwCZCV5NoZdaferJqM6Xs01ExrJUW4suy5q+8Jfglv5aBxgsKrEH9KknaEIypcE6qaLHkMGBSdQsKf2A0xoVOirqqfXBOoxRears8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbDss548Sz6J9pr;
	Thu, 15 Feb 2024 20:30:09 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EB091400D3;
	Thu, 15 Feb 2024 20:34:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 12:34:11 +0000
Date: Thu, 15 Feb 2024 12:34:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <sthanneeru.opensrc@micron.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@kvack.org>, <john@jagalactic.com>, <emirakhur@micron.com>,
	<ajayjoshi@micron.com>, <Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: Re: [RFC PATCH] cxl/pci: Set default timeout for background
 operations
Message-ID: <20240215123410.00003b8c@Huawei.com>
In-Reply-To: <65cd858b3e5bc_5c76294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240207105349.301-1-sthanneeru.opensrc@micron.com>
	<65cd858b3e5bc_5c76294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 19:31:23 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> sthanneeru.opensrc@ wrote:
> > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> >=20
> > The CXL 3.0 specification outlines background operations,
> > and support for handling these operations was added in following patch.
> >=20
> > Link: https://lore.kernel.org/all/20230523170927.20685-5-dave@stgolabs.=
net/
> >=20
> > Mailbox commands like =E2=80=98Log Populate=E2=80=99 use background ope=
rations
> > to complete the execution of the command.
> > This can lead to a timeout, since there is currently no option
> > in the ioctl cxl_send_command structure to specify
> > a timeout value. The default values being zero can lead
> > to the driver reporting false negatives to the application.
> >=20
> > This patch aims to establish default values, enabling mailbox commands
> > that operate in the background to continue functioning even
> > if a timeout is not set in the userspace application. =20
>=20
> The reason there are no defaults is because userspace is not allowed to
> issue background commands. The CXL background command definition is
> awkward in that it allows a single command to monopolize the mailbox for
> an indefinite amount of time.
>=20
> Instead, the approach taken with Firmware Update and Sanitize is that a
> kernel sysfs ABI mediates access to the mailbox and facilitates bounded=20
> timeslices between command submissions. It effectively allows the kernel
> to manage fairness and more importantly preempt userspace if it needs to
> issue its own commands.
>=20
> I assume you are only seeing this lack of a default due to building with
> CONFIG_CXL_MEM_RAW_COMMANDS=3Dy? If yes, "raw" means "raw" and the kernel
> is mostly taken out of the loop of saving userspace from itself.
>=20
> All that said, ugh, "Log Populate" has no facility to time bound the
> population of the log. I do not think it is tenable for Linux to
> surrender mailbox access for an indefinite uninterruptible amount of
> time... unless you want to handle "Log Populate" like Sanitize where the
> unbounded background operation is tolerated because the device is taken
> offline?

It may be pointless to do a component state dump only on an offline device.
My assumption is this one is hardware debug only.  Patches out of
tree or behind a really scary sounding config variable perhaps?
Other than vendor log I don't think populate log applies to the other
log types yet (they don't mention it anyway!)

Jonathan



