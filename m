Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF26F2F2
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292213; cv=none; b=qL4qn0J/vE4jHayCqb3XGJqiDMk1QX/VU53iJF557BEyBuweOxyyhZgEwQp5HgHLg7OGyHFDeqF5B53fwHVS1L3fDC4bgnrlaNAxx/5AGVIklQKFZ/hSc1ftg+A2cWe9F9IWg0LTDOGMFDaliP2C5LRDJXediWXuXbYG9AFW6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292213; c=relaxed/simple;
	bh=T5mPAGowJZl2Vxp2CAdSlm9LzHuWu7EyeJ6xk71Xr+w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VG7utL/fWeL0R8gtydx+mAEFQotA1YVOvFjEsBlYkX/tBnQjvTGqSE21CMq/O7ozqzDr3GhAdoFnYCrOkJVty7WZcYzUNYWgRvO4LHsAKrZT8bi45FUzWdVS2H1Cy2XLXdNqpt5B6x3hGX3rDM/u0zyjBalWFFir3dxRmiWARIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6Frw1MtWzHnH57;
	Thu,  5 Feb 2026 19:50:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C50C40086;
	Thu,  5 Feb 2026 19:50:10 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Feb
 2026 11:50:09 +0000
Date: Thu, 5 Feb 2026 11:50:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH qemu v7 0/7] hw/cxl: Support Back-Invalidate (+ PCIe
 Flit mode)
Message-ID: <20260205115008.00001be0@huawei.com>
In-Reply-To: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
References: <20260204170936.43959-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 4 Feb 2026 17:09:28 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Based on - due to fuzz + context changes.
> 
> 1. [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
> https://lore.kernel.org/qemu-devel/20260119111542.788389-1-Jonathan.Cameron@huawei.com/
> 
Hi Michael,

This first dependency now has a v5:
https://lore.kernel.org/qemu-devel/20260205112350.60681-1-Jonathan.Cameron@huawei.com/

But all the other dependencies and this apply cleanly on top of that so no need
for rebasing them.

Thanks,

Jonathan

> 2. [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
> https://lore.kernel.org/qemu-devel/20250917143330.294698-1-Jonathan.Cameron@huawei.com/
> 
> 3. [PATCH qemu 0/2] hw/cxl: Two media operations related fixes.
> https://lore.kernel.org/qemu-devel/20260102154731.474859-1-Jonathan.Cameron@huawei.com/
> (most likely will apply fine with out this one)
