Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF219539F
	for <linux-cxl@vger.kernel.org>; Mon,  6 Oct 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743103; cv=none; b=nY0REjitpqbbwV0cl4TK0hGa0yKzHiO5hMGs6BFOcSebRJn5phr7eUm/KDdSdMGnSj1I818H58+c165LzWlOF2R035+jc0X2hnxLPvHHfE809x6+lkOZUcCZwYT3H6bYVcX8ikkpbY70l03ipCy0UcV394RH4P60QosMbVtDbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743103; c=relaxed/simple;
	bh=Phe5QevE3pHK2g7MMzn3BeP65gD8ci8vmzho42Z5Ot8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8ltbDxjxF5g5G3+EOMXUHDjR/nBJyeaxQa7wVnfQe6jvIEZpAUWDLSGr+U8j8SGGAvvn/98sDF/raiW5R+K3iAZoDEIrdwnGjmI5P/0eFpUAwM2bnnwR4l5lBuI9Tt2If4zpzfCqMstVmpgldNSCCkZetbVbAGi6J1AUUSGr0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgD7Q1g93z6L52J;
	Mon,  6 Oct 2025 17:12:34 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BD3B51402EB;
	Mon,  6 Oct 2025 17:13:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 6 Oct
 2025 10:13:05 +0100
Date: Mon, 6 Oct 2025 10:13:04 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Michael Tsirkin
	<mst@redhat.com>, <shiju.jose@huawei.com>, Davidlohr Bueso
	<dave@stgolabs.net>, <armbru@redhat.com>, Fan Ni <fan.ni@samsung.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, Ravi Shankar
	<venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20251006101304.000055f8@huawei.com>
In-Reply-To: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 17 Sep 2025 15:33:27 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> These two features have been used in testing the related EDAC RAS
> features drivers in Linux which are now upstream. Only minor tweaks
> from the second part of:
> https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> 
> I've split that series up as the two parts were only slightly connected.
> However there is some churn if this is applied without the other part of Shiju's posted
> series. That was sent a few minutes ago as:
> https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> 
> Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> 
> Davidlohr Bueso (1):
>   hw/cxl: Add support for Maintenance command and Post Package Repair
>     (PPR)
> 
Hi Michael,

I see you have queued some stuff up on your gitlab tree.
Just wanted to make sure these are on the radar for possible inclusion.
No huge rush, but I'll queue some more series up on top of these
shortly.

Thanks

Jonathan

> Shiju Jose (2):
>   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
>     attributes in cmd_features_set_feature()
>   hw/cxl: Add emulation for memory sparing control feature
> 
>  include/hw/cxl/cxl_device.h | 145 +++++++++
>  include/hw/cxl/cxl_events.h |  47 +++
>  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 169 +++++++++++
>  4 files changed, 915 insertions(+), 12 deletions(-)
> 

