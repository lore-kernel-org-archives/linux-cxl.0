Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCF2D97A4
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770380194; cv=none; b=lFpGuEzMRUgb9+3EhpBpDOJwceOhl0/vMN/NL9+hmD6nuexfhtcFiX+XSn8vaj+AQcArPjjRhJchv+4mdD3TB2K1Pgx6jVNHBdGt8qlqZevzxF0mBgYyxbbB029FyJvIz422xLHykbCPOoISN6nsMSUfGFeuJZKHTNN3UCwoMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770380194; c=relaxed/simple;
	bh=+LhH6+euhHFUj0WZFT07Lojx9EEazkiFZQYM2GyoxCI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVF/kizAiBXkby1JMDyhtm3DYLzTTzJs+HLZCH4T8UM0l3EZOfNDUVcNcUmdkKdvulELJqesVxT5bKkuHImhnLGBGMGdH0WzOM0T1HQD5mCinFJ23lzglG7ABwvCVNlhLiSScYRrddR2eV5FBYcPR6dt8edO3WiPNwj//wbpvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6tMv1sXZzJ46Cx;
	Fri,  6 Feb 2026 20:15:39 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 83C994056A;
	Fri,  6 Feb 2026 20:16:31 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:16:30 +0000
Date: Fri, 6 Feb 2026 12:16:29 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 1/7] hw/mem: Add tagged memory backend object
Message-ID: <20260206121629.00004919@huawei.com>
In-Reply-To: <20251127225526.700-2-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
	<20251127225526.700-2-alireza.sanaee@huawei.com>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 27 Nov 2025 22:55:19 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Add a new memory-backend-tagged supports a tag property where you can
> find it based on tag. This is useful for scenarios where you want to add
> a piece of memory for a particular purpose to be passed for another
> device.
> 
> At the moment, this only supports a ram-backed object where we add a tag
> to it, and it temporary. However, we are planning for a generalized
> approach. The plan is to have a shim object where we add a tag to it,
> and then it can be later linked to any BACKEND object types.
> 
> Example use QMP API:
> {
> 
>     "execute": "object-add",
>     "arguments": {
>         "qom-type": "memory-backend-tagged",
>         "id": "tm0",
>         "size": 1073741824,
>         "tag": "6be13bce-ae34-4a77-b6c3-16df975fcf1a"
>     }
> }
> 
> Tags are assumed to be UUID. But this is something for debate maybe.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Just to keep a note here on what we discussed offline

Given this doesn't end up with a shim, but rather would need a
variant for each potential backend type, I'd not do this and instead
(For now) anyway, just add tag as a property to the HostMemoryBackend

We can come up with a clever solution later if that isn't an acceptable
path forwards.

Jonathan
