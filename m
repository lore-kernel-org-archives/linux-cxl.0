Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764422AE75
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748529073; cv=none; b=rsFPNfDsrzV27CtpDg8zMa8VhuqEdf7Ab8z3An+gjMEbY1tXgPsI1qF0MHTsQREMfEW18Biol4cW8DmfCSx7vgROW9n8U8ufQPasjJTKTeqVb3bQPC7heqMceh4C4IWIMvJJTmtZOv7q9p+fwKF5P9xQC8FaK+UGEPhzTUGzGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748529073; c=relaxed/simple;
	bh=eMFxBMfyFOxV3BeIGTcDx5sFm09M8My+rTkQmtIPqAk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbxjLXeYWs89ZdMtzu1s9UTM2Wi1epc0nFTLuQUQqOv5ASGw10m5Zwxg8HruzGA1nsw79g6ZlkSWrv6ex/8gM9k37DObtJ9w4Exzxc0VnhdNWJTdC0q0Ddp9ru48cEGwg9JMCfk2oYiENKDjMls/Q9EiuqB+11GqC+EjhN+XqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7TKX117hz6K5lR;
	Thu, 29 May 2025 22:29:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CB1131400CA;
	Thu, 29 May 2025 22:31:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 May
 2025 16:31:07 +0200
Date: Thu, 29 May 2025 15:31:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<anisa.su887@gmail.com>, <gourry@gourry.net>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl: fix DC extent capacity tracking
Message-ID: <20250529153105.00000bd0@huawei.com>
In-Reply-To: <20250520195741.789841-1-nifan.cxl@gmail.com>
References: <20250520195741.789841-1-nifan.cxl@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 12:56:43 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
> extents in different states including added, pending, etc.
> 
> Before the change, for the in-device extent number tracking purpose, we only
> have "total_extent_count" defined, which only tracks the number of
> extents accepted. However, we need to track number of extents in other
> states also, for now it is extents pending-to-add.
> 
> To fix that, we introduce a new counter for dynamic capacity
> "nr_extents_accepted" which explicitly tracks number of the extents
> accepted by the hosts, and fix "total_extent_count" to include
> both accepted and pending extents counting.

Hi Fan,

This is complex code but looks correct to me - I'd managed to forget
all the weird ways the extent counts can go up and down - most of
which Linux doesn't actually hit.

For fixes like this can save a bit of time by +CC mst@redhat.com then
it just needs a review tag from me (or you if it is me sending).

I only have that other regloc fix and just sent that out for review
with mst +CC so maybe just send a v2 of this (rebased on upstream)
and add 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

