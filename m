Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795056284;
	b=0R80HcoOtLYxxQdjhMcv0aYbVQuzftKQhvUg059WXu47rtesrgIoSOtmvGYWrG3fno+K
	 PDqslB/zu2ezXD7M05E5jDsxQMGTqhjwXzrkvh1kKkfPe9dtv9bw41+S0FeXCdYsBg6M+
	 O9OIvvpJWGB5ueVMs2CIAeailB8qwWGzYdcITSGk5No62MKdEIs2v3QwQc0LTuvhKYvUN
	 nqBACosJe2p3DhRlV5mk07V+m6TcGKf1EydIiiGjiZ7oP38Drg90ijV0jN09m9nO11u3x
	 yUeHckkTs8pgoMesMkD+/YuoG6feixsUkaCjKfa9S7F1OXl6q3uhLc9O3lOkOYbDjOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795056284;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=GS4NVhiAOnRs5e7t5yEw596+HJfBXXj+oSDJGrq3dyA=;
	b=qkFN2WHFOxxJ9LBcFBk4/KDe9ii3wbdt0T0NxnbNmDq3Ff5KGRLf9PqUk7v17fC8idW6
	 FY7HfMrgONqzQnrGHpPNBxluH6qSFKFoO5u+6vFbm4t3iYiZHhrwhofCfjkPEWPfk1QQ7
	 0vKLYLFlh7Io4LWj7/+AFOOITaPCF1DIN/6NrKimj+uyrbcdqltXVByKlRGr96qRzqfQ3
	 iY6yPXlyJooJLCSX/iWFdLX4GPjlxWX5fMbD03eTXx7Vz+DOBOhBmxS06kLnJOtKvEUyA
	 cSQ0P5l6e96NPaVUFr5Gsm9OiW1QC7okrKay0UhZHnTpssqilk1D+t+KBovUrn+3tqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="Kf/mhT/j";
	arc=none smtp.remote-ip=115.124.30.119
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CA606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 02:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kf/mhT/j
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795056278; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=GS4NVhiAOnRs5e7t5yEw596+HJfBXXj+oSDJGrq3dyA=;
	b=Kf/mhT/je7vKQbLKvk4WRWc6WY0+a20IvhC4d/WLiGbW7hvVUm4b6FcIfgWu1l2V0iO9a0zBPWPsQn9iecy/AA03viU8arQU7PD6EL2DnybI3+kdzy+fLtFwXKTCaMvvMlHwux6i3YMQEeyGxGn7wYGmq0LJfl7S+un9IrS5rfk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=yuxiong.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0XF27X32_1795056274;
Received: from U-Q2G32XWJ-0138.local(mailfrom:yuxiong.wang@linux.alibaba.com fp:SMTPD_---0XF27X32_1795056274 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Nov 2026 10:44:36 +0800
Date: Thu, 19 Nov 2026 10:44:34 +0800
From: Yuxiong Wang <yuxiong.wang@linux.alibaba.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Will Deacon <will@kernel.org>,
	Jia He <justin.he@arm.com>, Mike Rapoport <rppt@linux.ibm.com>,
	linuxarm@huawei.com, catalin.marinas@arm.com,
	Anshuman.Khandual@arm.com,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	James Morse <james.morse@arm.com>,
	Huang Ying <ying.huang@linux.alibaba.com>
Subject: Re: [RFC PATCH 4/8] arch_numa: Avoid onlining empty NUMA nodes
Message-ID: <av5ikhyVRSgTmIjx@U-Q2G32XWJ-0138.local>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-5-Jonathan.Cameron@huawei.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529171236.32002-5-Jonathan.Cameron@huawei.com>

在 Wed, May 29, 2024 at 06:12:32PM +0100，Jonathan Cameron 写道：
> ACPI can declare NUMA nodes for memory that will be along later.
> CXL Fixed Memory Windows may also be assigned NUMA nodes that
> are initially empty.  Currently the generic arch_numa handling will
> online these empty nodes. This is both inconsistent with x86 and
> with itself as if we add memory and remove it again the node goes
> away.

Hi Jonathan, Yuquan,
 
I also ran into this issue on arm64 and reproduced it on current
mainline: an empty CFMWS node is onlined at boot as memoryless, and
goes away after the memory is hot-removed.
 
I noticed this patch fixes exactly this problem, but it seems it was
never pushed further: the rest of the series landed in evolved form,
yet I found no respin of this one on lore.
 
So I have two questions:
1. Was this patch dropped for a reason I'm missing, or did it just
   fall through the cracks during the numa_memblks rework?
2. If it was simply overlooked, do you have any plan or interest in
   pushing it forward yourself? If not, I'd be happy to carry it
   forward with the original authorship preserved.
 
Thanks,
Yuxiong

