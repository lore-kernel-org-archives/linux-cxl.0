Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF3387B16
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980000; cv=none; b=HvspYRlDiEgPj0G007vEP0EV/fAjeDbg+MhZ8v43Ek/gSgRvqG4iIGycoPJ2dWXpqJL9jFNm2z+fIZjmvEHQL7eim6L8yjwC9mcxx66O4aQ1l+bVqHYMwDSgTI0qci/ZgF+dxPI26RDwb57L8ziE2cMwwepaxMribKoA5mf9B2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980000; c=relaxed/simple;
	bh=G4CPwqk0paLoGveveF0gQRyl5YrHW0QdDhPQAY4aS5k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ssf2snSz2qP8cLYQgNi/fZ175HWplNP50eLtV3lDtRxVWDv6S0Ga3Gm4rAhp68rzj7bcGVJRR3Xd2OH8xF8UBQWlT47Aj+NzgG+69aKmRvobgqsuFg+lOLfaFcmhNA6so1eIdY+YiekcUKKun+MpsvvhEYtaQf1s7sDFlC1KZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWb5F74hlzHnGjn;
	Wed, 17 Dec 2025 21:59:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A53F4056B;
	Wed, 17 Dec 2025 21:59:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 13:59:31 +0000
Date: Wed, 17 Dec 2025 13:59:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ira.weiny@intel.com>, <alucerop@amd.com>, <a.manzanares@samsung.com>,
	<dongjoo.seo1@samsung.com>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<armbru@redhat.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4 -qemu 0/5] hw/cxl: Support Back-Invalidate
Message-ID: <20251217135930.00004616@huawei.com>
In-Reply-To: <20251216011211.anwnw25ot6n3euhq@offworld>
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251216011211.anwnw25ot6n3euhq@offworld>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 15 Dec 2025 17:12:11 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> ping? If there are no further issues, could this be picked up into
> your jic23 tree?
> 
> Thanks,
> Davidlohr
> 
Hi Davidlohr,

I'm just waiting on the 10.2 release before bringing my tree up to
date and reposting the various series that I consider ready which
didn't get merged in 10.2.

Then I'll figure out where in the tree to push these in.  I might
do the leg work for that before the release, but given that should
happen shortly I'll not push a tree out on gitlab until after that.

Jonathan
