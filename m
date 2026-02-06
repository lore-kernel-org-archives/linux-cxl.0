Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AE3AEF4C
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381826; cv=none; b=pXIEYuZQEkQugkyIeg8FXD2qtPGq68DikojRYAWRDi0Xp1OECC7Y/AUaOXuPza57yTrrfdbNCgIdAXR+jtQPGgSd1go3veexcpI3zbg1BNqVcV1VKR5CWeuV7TseoX6xE9D/rpOxDuCFbyiXi9MJDpj0itdplOIv4zaSa/skDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381826; c=relaxed/simple;
	bh=LuBiWUCv2XMbjW86ZDCky5FqmS+l0RT4R4JNYZRlFls=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZT9k5OeT/PFRksVadsq+V46OjcedY6prxpV0IuYMsl118kK14B8Fdb54tDs0jTaqJe6CLTNM50mqAIXZ9HKnNupoGBNMSSkq2a27FZrhYyXxlNt8i9XAFzKLBAblyY9CsFetrJwDL4xwwBSkdZYdm2m5m7FIJ7+kBNcBeCb4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6tzH5m7jzJ46DR;
	Fri,  6 Feb 2026 20:42:51 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D67940584;
	Fri,  6 Feb 2026 20:43:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:43:43 +0000
Date: Fri, 6 Feb 2026 12:43:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <eblake@redhat.com>,
	<armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 6/7] hw/cxl: Add remove alias functionality for
 extent direct mapping
Message-ID: <20260206124342.00001f75@huawei.com>
In-Reply-To: <20251127225526.700-7-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
	<20251127225526.700-7-alireza.sanaee@huawei.com>
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

On Thu, 27 Nov 2025 22:55:24 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Remove alias related to an extent when the extent is longer available,
> from removed from the VM.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
I'd combine with previous.  Otherwise we are broken in between.
I guess you could add a temporary error return to the remove path in previous
patch if they really don't more sense combined.

Jonathan

