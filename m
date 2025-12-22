Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD80279DB6
	for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766405545; cv=none; b=YPd5YTXg1arJ2p0zjiBvPTwsqOsDG3CuEdL/zFLGYgCJTjJ1NH4+cQaNy1q5zAcfYyby4UUIl2ulMSyMIwh9i0xbH4dFZW3/oGz9JLtImgXz/nOJ8uCQOM4HZUTa81Dli80TraYYO0l0bl2IiZm6Ck97Q0LmBmhQIvBitLi99T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766405545; c=relaxed/simple;
	bh=Z1s5ISCUJs536J8uupB50OXrAMPXjKGNAJUqJ1nHEnU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wc2Au6wESTBqhGaeAd0ftQfhFCPq58eU/t8faFvcBE+TZ+ylQATneU+yw3dgpS0KvHSpZAHiKoz/SeEA6kBcEkddhFsJQBIsJtugFTDG2M2vqpPA7vtTZQ98aSmlUrAL/fbDDpLf5JKh/uoOBZ/jQo7KsY0wcQ+tAX3thBA6UE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dZcSb3cZlzJ46bM;
	Mon, 22 Dec 2025 20:11:43 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id F0A3E40569;
	Mon, 22 Dec 2025 20:12:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Dec
 2025 12:12:20 +0000
Date: Mon, 22 Dec 2025 12:12:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, David Hildenbrand <david@kernel.org>, "Oscar
 Salvador" <osalvador@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	John Groves <John@Groves.net>
Subject: Re: [PATCH] MAINTAINERS: Notify the "Device Memory" community of
 memory hotplug changes
Message-ID: <20251222121218.00000b1b@huawei.com>
In-Reply-To: <20251220000327.3502994-1-dan.j.williams@intel.com>
References: <20251220000327.3502994-1-dan.j.williams@intel.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 16:03:27 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The recent episode of a warning regression in memremap_pages() [1]
> highlights that relevant updates are being missed by folks that care about
> core ZONE_DEVICE changes. Yes, CXL folks should pay more attention to
> linux-mm@, but it also would not hurt to copy linux-cxl@, where most Device
> Memory folks hang out, on memory hotplug changes by default.
> 
> Link: http://lore.kernel.org/20251219123717.39330-1-john@groves.net [1]
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Groves <John@Groves.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Makes sense to me.

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
 
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5b11839cba9d..076322fe91de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16426,6 +16426,7 @@ MEMORY HOT(UN)PLUG
>  M:	David Hildenbrand <david@kernel.org>
>  M:	Oscar Salvador <osalvador@suse.de>
>  L:	linux-mm@kvack.org
> +L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/admin-guide/mm/memory-hotplug.rst
>  F:	Documentation/core-api/memory-hotplug.rst
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8

