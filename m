Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F2374E72;
	Thu, 12 Mar 2026 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308545; cv=none; b=G8Fi3psLE6I0lx86xyUK+IbWZm+TN3agft1E2RQlRr1KligeZowC313Jo8UHrGYf83AgL1O2iVgf7+8VkUmklvW48nmwOxALX8PvWZ+wtOobymDDBtMbkVvLo9h1iLYm3vLPPn4dtJRodQ+Ykc+ngEY5gERSApCDAcEzbeX8wZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308545; c=relaxed/simple;
	bh=ocIyzr7c1RNiy8C07Am4OL8gIKsCyYLoB2MPmXZ0htM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BZTOGs6l/Pwk5s761EdJ1SY06AbaUBZ4rpWYyCL8RcPTUOKXNJwdZKV6nA282T1rMDKr3oJRcdNyFBl+AmfRPsKcIslRssxDJCK9sPz2cT1l+Dnw+cylKlTfAhH16IZnfm15VBRSRu0QcWeK1hDNnsjxfrHN2kaS/S6SWFnAxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SOy/gILo; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SOy/gILo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773308535; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=yPWlaauP5LfYdgi3W21fsz1vO9uleriWqeR2AsRR+/U=;
	b=SOy/gILofrVSdvOsnJcUH8152kPoVWdiglqIq+MblDpUkvdXrVUDQhSczD7jStytoWubL5xTFPNrDlL+ceR2xbjQpwUjv1L+krvNVsuOVqpTwEVwBF+0oJeXLqmoy17xuI52ZyHtxtbwt9J4yNqHLdZxehzqvQswwMiMFakkbT4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X-oES69_1773308534;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0X-oES69_1773308534 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Mar 2026 17:42:15 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: YeeLi <seven.yi.lee@gmail.com>
Cc: akpm@linux-foundation.org,  david@kernel.org,  dan.j.williams@intel.com,
  linux-mm@kvack.org,  joshua.hahnjy@gmail.com,
  linux-kernel@vger.kernel.org,  Jonathan.Cameron@huawei.com,
  linux-cxl@vger.kernel.org,  dave.jiang@intel.com
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node
 bandwidth
In-Reply-To: <20260312091207.2016518-1-seven.yi.lee@gmail.com> (YeeLi's
	message of "Thu, 12 Mar 2026 17:12:07 +0800")
References: <20260312091207.2016518-1-seven.yi.lee@gmail.com>
Date: Thu, 12 Mar 2026 17:42:13 +0800
Message-ID: <878qbxpeoa.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

YeeLi <seven.yi.lee@gmail.com> writes:

> From: yeeli <seven.yi.lee@gmail.com>
>
> Automatic tuning for weighted interleaving [1] provides real benefits on
> systems with CXL support. However, platforms that lack HMAT or CDAT
> information cannot make use of this feature.
>
> If the bandwidth reported by firmware or the device deviates from the
> actual measured bandwidth, administrators also lack a clear way to adjust
> the per-node weight values.
>
> This patch introduces an optional Kconfig option,
> CONFIG_NUMA_BW_MANUAL_OVERRIDE (default n), which exposes node bandwidth
> R/W sysfs attributes under:
>
>   /sys/kernel/mm/mempolicy/weighted_interleave/bw_nodeN
>
> The sysfs files are created and removed dynamically on node hotplug
> events, in sync with the existing weighted_interleave/nodeN attributes.
>
> Userspace can write a single bandwidth value (in MB/s) to override both
> read_bandwidth and write_bandwidth for the corresponding NUMA node. The
> value is then propagated to the internal node_bw_table via
> mempolicy_set_node_perf().
>
> This interface is intended for debugging and experimentation only.

How to use this new interface?  Can you provide an example?

---
Best Regards,
Huang, Ying

> [1] Link:
> https://lkml.kernel.org/r/20250505182328.4148265-1-joshua.hahnjy@gmail.com
>

[snip]
