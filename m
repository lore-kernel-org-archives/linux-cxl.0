Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9724E002;
	Thu,  3 Apr 2025 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683402; cv=none; b=t+Jq3uzQLWs7zdrl+VL6puOVCTs80GjlwRClSQ5FL3zzqnf8Br5fek4PYIT4ke+TUeGVQPWFrMzcN0xHIXXWCFDgMKk6Em4mdqeU6JKNwImT0ELKNFBFW5S9WjLOcHmUualDWpl81nuWUs3kE9o8Cyvd5kTk0j08ktVZ9Ehv6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683402; c=relaxed/simple;
	bh=0RmaEk9oTb0vgvKAW0oPD/3qyuPhFRsSlfy/FfKh3q0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOeMkDcWnOPY841hO1mk7hXtcHW9V8+2Jy4GFr4I/O7DFi9nPaU5MoQt+lWEy0itdiG+1oODcWi7hzdGkpnm5LeSjhWXSA3iOUSVkfvNdIRY3j8rRIED9a7Os3+8CO4jcUSRvMkO0FQanfDUkvpazMEroGZ+LVy6+N6Y2GnpnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZT1Dm3dg6z6M4j7;
	Thu,  3 Apr 2025 20:26:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C576A14050C;
	Thu,  3 Apr 2025 20:29:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Apr
 2025 14:29:56 +0200
Date: Thu, 3 Apr 2025 13:29:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Oscar Salvador <osalvador@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	<mkoutny@suse.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 0/2] Implement numa node notifier
Message-ID: <20250403132954.0000779f@huawei.com>
In-Reply-To: <20250401092716.537512-1-osalvador@suse.de>
References: <20250401092716.537512-1-osalvador@suse.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  1 Apr 2025 11:27:14 +0200
Oscar Salvador <osalvador@suse.de> wrote:

> Memory notifier is a tool that allow consumers to get notified whenever
> memory gets onlined or offlined in the system.
> Currently, there are 10 consumers of that, but 5 out of those 10 consumers
> are only interested in getting notifications when a numa node has changed its
> state.
> That means going from memoryless to memory-aware of vice versa.
> 
> Which means that for every {online,offline}_pages operation they get
> notified even though the numa node might not have changed its state.
> 
> The first patch implements a numa node notifier that does just that, and have
> those consumers register in there, so they get notified only when they are
> interested.
> 
> The second patch replaces 'status_change_normal{_normal}' fields within
> memory_notify with a 'nid', as that is only what we need for memory
> notifer and update the only user of it (page_ext).
> 
> Consumers that are only interested in numa node states change are:
> 
>  - memory-tier
>  - slub
>  - cpuset
>  - hmat
>  - cxl
> 
Hi Oscar,

Idea seems good to me.

+CC linux-cxl for information of others not on the thread.

> 
> Oscar Salvador (2):
>   mm,memory_hotplug: Implement numa node notifier
>   mm,memory_hotplug: Replace status_change_nid parameter in
>     memory_notify
> 
>  drivers/acpi/numa/hmat.c  |  6 +--
>  drivers/base/node.c       | 19 +++++++++
>  drivers/cxl/core/region.c | 14 +++----
>  drivers/cxl/cxl.h         |  4 +-
>  include/linux/memory.h    | 37 ++++++++++++++++++
>  kernel/cgroup/cpuset.c    |  2 +-
>  mm/memory-tiers.c         |  8 ++--
>  mm/memory_hotplug.c       | 82 +++++++++++++++++++++++++++++----------
>  mm/page_ext.c             | 12 +-----
>  mm/slub.c                 | 22 +++++------
>  10 files changed, 146 insertions(+), 60 deletions(-)
> 

