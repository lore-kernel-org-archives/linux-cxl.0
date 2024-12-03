Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5316FF4E;
	Tue,  3 Dec 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207248; cv=none; b=NasbJCoicCj3oTu9rA2vIAjVs7CRUGCQDx3shRH732hSMQRNEURhm8/zcDJlCFR3jJlJdlKvbM5K0UHrr0rGeqh4lrOXKC2WVV/UFvE10S80/gQaMPZTcQxsn+w4H0BJo/v3jk/YHLosVl5TR9GWc47y7g0jk8uFpvNF0mQ49Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207248; c=relaxed/simple;
	bh=a9o65h18zwdd49iZoTOnB/KaodhdIVoxC+xiHjydq7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CIu3IsbSVZrNoCAgWtNPRTdShihwMCnjTo3USzGTFjdm8ithwii8Tu2bKeZ+BNz+c0RFAcqQLGELXiO9TveFWzYpiNOKHn6xxmy6CIE6+dx1pRPaMbo5GSqkXXCZ6yLdWYHRf/rJDV8ywbb9B2MvsGCYWx73PfqUBvERBFa7YI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bAcQGKU7; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bAcQGKU7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733207237; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=lISfcjir4MGvhIlCz/kcscLyI0NrAxVbpsFJtfFwggM=;
	b=bAcQGKU7qS2RDKu8ii4+BPIMZKAb/xIOlE6q6e56HROci82bSHK+dW7Dw5yrRIPPI9Uk2ZiXblM51+cB+2f1PrWePKk3ltC0W3oVp3ZXUoETP6FhCx5xM7n7K50/7xiNPlrj8Wjsomn88kvz1Y9qmJnB3ZcMTYFFGq5t9G5l7oU=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WKlgUAx_1733207212 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 14:27:15 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-cxl@vger.kernel.org>,
  <bharata@amd.com>,  Andrew Morton <akpm@linux-foundation.org>,  "Dan
 Williams" <dan.j.williams@intel.com>,  David Hildenbrand
 <david@redhat.com>,  Davidlohr Bueso <dave@stgolabs.net>,  Jonathan
 Cameron <jonathan.cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,
  "Alison Schofield" <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alistair
 Popple <apopple@nvidia.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>,  <ilpo.jarvinen@linux.intel.com>,  Mika
 Westerberg <mika.westerberg@linux.intel.com>,  Fontenot Nathan
 <Nathan.Fontenot@amd.com>,  Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH] resource: Fix CXL node not populated issue
In-Reply-To: <20241202111941.2636613-1-raghavendra.kt@amd.com> (Raghavendra
	K. T.'s message of "Mon, 2 Dec 2024 11:19:41 +0000")
References: <20241202111941.2636613-1-raghavendra.kt@amd.com>
Date: Tue, 03 Dec 2024 14:26:52 +0800
Message-ID: <87frn5wac3.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Raghavendra K T <raghavendra.kt@amd.com> writes:

> Before:
> ~]$ numastat -m
> ...
>                           Node 0          Node 1           Total
>                  --------------- --------------- ---------------
> MemTotal               128096.18       128838.48       256934.65
>
> After:
> $ numastat -m
> .....
>                           Node 0          Node 1          Node 2           Total
>                  --------------- --------------- --------------- ---------------
> MemTotal               128054.16       128880.51       129024.00       385958.67
>
> Current patch reverts the effect of first commit where the issue is seen.

This doesn't root cause the issue.  Please trace the code path
(e.g. return value of region_intersects(), in which code path) at least.
Without these information, we cannot come up with a proper fix to your issue.

> git bisect had led to below commit
> Fixes: b4afe4183ec7 ("resource: fix region_intersects() vs add_memory_driver_managed()")

This breaks you case, sorry about that.  But this also fixed a real bug
too.  So, it's not appropriate just to revert it blindly.

[snip]

---
Best Regards,
Huang, Ying
