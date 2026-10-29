Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252137;
	b=R05R2gjNawe/d8WP0dg5vyiJ7uuJHx6Y80UyIpp0tTS1ccELj/Z3WGdCvkTY1OamObQq
	 i0rN3pEHicQMjQyNu0zypQWRCotbaoM0lakX+GtSQ+osRKaJmg5qeqNexQx9b7cpvD/25
	 2kQ4bKThFr+XzNII1vTWTXnj93Dh0gKVstbsB2C1O9vWRgns4X48KgyQtYygIsoWmXFU5
	 zU/YWXRfJ2NUCs5hFswyCuki9Z5eVAqmnvew/WldI3QCY2T0TgjZzzs01BK4k9kcUsQW7
	 z42zGrr/2xU44nmFoAYp8tPXsZiLFt70HbiTaSI40yIqiKIgki1PDYnI7fNh+mYi0Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252137;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=63NDZq8Cyb35cDuhqqHvr+BDCkAeruK0XwrO5RdM9ZY=;
	b=rVw17rq3ZK3LDS7nhIezDb3x6JOieh0nsmm1oixWqQ2UINQuMJZnu5XVVOnPE19jzYfa
	 HJvj+4aQLs77IR6pMgf2ZawY5Us9pMvRT8iANta2RfLxXpfyaRfNKX8xSPOsn3QvrVis8
	 XeUIkjQ2XZ4XijA8YnxuJtNg1nu0NW93ObmvmiXAJ8BzvKKeuP06XowLM4OykYrX4+WKs
	 GFCAXzvfSPYVSzvBxskcJ4I/Bqco6Zk2K3GSdFDzcWPM9Kzyuf4Lz5NIHM07Sgw7cfqFf
	 vAyYsnVx+LBkQQmWtURWv08y+jMDCFS0KsU60qLV+oczqd4/V8GBdtOqocszzRlWT7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="E/AmkrY8";
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D68606A31D
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 05:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80D68606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=E/AmkrY8
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JWxFG3qn2YevCpVcd3JxV3GGyjj+u2htHokQ1v3x0Pw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793252134; v=1; x=1793856934;
 b=E/AmkrY8zj2MdvEWmWN4ZE7Err/HvTah50oUTB3R7Fe4qK9Lh4KjjGNh8wT48vWIcKTHTHJY
 HZfIiBrKYNH0CpfU7ddyXH9knzUPHFLeylxbC3ZOM8A0X3UliJ0pCVcB+e1sugSVLLc2OMOXOcH
 jyxQzR7fV+57Dl0py4Xzdrok=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 24f16e16ac99131d;
	Thu, 29 Oct 2026 05:35:31 +0000
X-Mizu-Trace-ID: 24f16e16ac99131d
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261029030511.12004-1-trilith.zheng@gmail.com>
Date: Thu, 29 Oct 2026 13:35:05 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <djbw@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta@amd.com>,
 linux-mm@kvack.org,
 nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Mike Rapoport <rppt@kernel.org>,
 Ira Weiny <iweiny@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>
Content-Transfer-Encoding: 7bit
Message-Id: <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com>
 <20260903122128.12264-4-songmuchun@bytedance.com>
 <20261027065723.66564-1-trilith.zheng@gmail.com>
 <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev>
 <20261029030511.12004-1-trilith.zheng@gmail.com>
To: Yilei Zheng <trilith.zheng@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 11:05, Yilei Zheng <trilith.zheng@gmail.com> wrote:
> 
> Hi Muchun,
> 
>> Thank you very much for the test, so in your scenario, this is also
>> the behavior of your real workload (mainly read/write-based, rather
>> than mmap), right?
> 
> Yes. We mount read-only rootfs images over virtio-pmem and FS-DAX. Most
> file access goes through normal read/write. mmap is only used for
> loading binaries and shared libraries at startup, which is a small part
> of the image.

What's the size of the roots image? And I just want to know how much memory
this series could save in your workload.

> 
>> To be fair, it does fix the issue, but it's not very clean. I might
>> do some code cleanup first to solve this more gracefully. I want to
>> move the initialization to where the template page is allocated,
>> similar to what section-based vmemmap optimization does.
> 
> Makes sense. Initializing it at allocation time is cleaner.
> 
>> Thanks for the analysis and suggestions. However, the reason I
>> haven't sent out v2 yet is that I've been trying to refactor the
>> vmemmap optimization logic to make FS_DAX support cleaner. I think
>> I'll probably do some code refactoring first.
> 
> Understood. It would also help if the refactor could support subsection
> (2 MiB) alignment, so any 2 MiB-aligned device can use the optimization
> without padding to a 128 MiB multiple.

I think I can.

> 
>> I'cc you next time if you'd like to help me test.
> 
> Sounds good. Please Cc me when you post v2 and I'll be glad to test.

Thanks.

> 
> Best regards,
> Yilei

