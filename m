Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C3F610D
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920892; cv=none; b=gPMdFc/SZ6/oI1nvtVHH+GRYzZe1ux65kBP/kONo7ryi/PO/KH19eXm55efLOTcCL5gTS+2Zcbm/VaeO2WgD5TPLL768KEC0TTWgFh8zMpkQIEl4jPVr6+PESDeU2YXNKEoe0hCfiQtLhYa3+sJ/a/oCXyLaofknFbut/KzFPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920892; c=relaxed/simple;
	bh=HZnVlV5X3G9PT+9ysZIA8U8pQFrpkStQKStPlIgtIyE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lt/xQNuBwzebrhx2Audvq6/Y/jnir3/UmALcD7+RbossxdBnu+JEevkEhwxZXHfw6vC79QWbNMIgFvU8NmQruPhgeVvHiJpmMB2Fg5ulJtEiK1pH+gIoMo1UqW63dJHlFp5GoO6/lRF2hA2niNKJY5za7Xn9CXdmQSEHcWZY09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-c5-67a5d3b38476
Message-ID: <ada54160-461c-4942-a4dc-43f7eab0f1bf@sk.com>
Date: Fri, 7 Feb 2025 18:34:43 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, Matthew Wilcox <willy@infradead.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, lsf-pc@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
To: Gregory Price <gourry@gourry.net>, Byungchul Park <byungchul@sk.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsXC9ZZnoe7my0vTDY5v0rOY2GNg8fPucXaL
	87NOsVjcW/Of1WLf673MFr9/zGFzYPPYOesuu0d322V2j80rtDw2fZrE7jH5xnJGj8+b5ALY
	orhsUlJzMstSi/TtErgy3jStZS1YzFKx+XZ1A+MK5i5GTg4JAROJj++7WWDsTVvfAsU5OHgF
	LCUurZcACbMIqEis3POBCcTmFRCUODnzCVi5qIC8xP1bM9i7GLk4mAX2MEr8nXCTFaRXWCBN
	4u0PP5AaEQEPiY6JM5hAaoQEdjJKzNreygqSYBYQkZjd2QZ2A5uAmsSVl5PAFnAKmElcarzL
	BlFjJtG1tYsRwpaX2P52DjPIIAmBM2wSH3adYYQ4WlLi4IobLBMYBWchOXAWkh2zkMyahWTW
	AkaWVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiBkbCs9k/0DsZPF4IPMQpwMCrx8CYcWJIuxJpY
	VlyZe4hRgoNZSYR3yhqgEG9KYmVValF+fFFpTmrxIUZpDhYlcV6jb+UpQgLpiSWp2ampBalF
	MFkmDk6pBka+u3H+Gx4LG29e9/tt4q70/GtuJjZFUwyYjqg0Fr5o4VBu0u1a1nPj29GrD09p
	ed+W+lUgZTmt4NfbXWa3PMRiZ2vtYbG4MaHols8yyfupk++sNymau0U9ZWdxRoPYpx1MUQ9u
	P99vViZb+v5si43kyZBX8VMUqtZyTaq+oS3QPt33dJRq4F0lluKMREMt5qLiRABvN8MDgAIA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXCNUNLT3fz5aXpBqe2qltM7DGwODdlNpvF
	z7vH2S0Ozz3JanF+1ikWi3tr/rNa7Hu9l9ni9485bA4cHjtn3WX36G67zO6xeYWWx6ZPk9g9
	Jt9Yzujx7baHx+IXH5g8Pm+SC+CI4rJJSc3JLEst0rdL4Mp407SWtWAxS8Xm29UNjCuYuxg5
	OSQETCQ2bX0LZHNw8ApYSlxaLwESZhFQkVi55wMTiM0rIChxcuYTFhBbVEBe4v6tGexdjFwc
	zAJ7GCX+TrjJCtIrLJAm8faHH0iNiICHRMfEGUwgNUICOxklZm1vZQVJMAuISMzubAPbyyag
	JnHl5SSwBZwCZhKXGu+yQdSYSXRt7WKEsOUltr+dwzyBkW8WkjtmIRk1C0nLLCQtCxhZVjGK
	ZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG+rLaPxN3MH657H6IUYCDUYmHN+HAknQh1sSy4src
	Q4wSHMxKIrxT1gCFeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4
	OKUaGK/PL0xsvxf53fa54nWl9IvnCjs+6tXF6lXFfphziYc7qCciivXKJKl5tYmXHm26tlhg
	4j6rc50PbQvfzLf+xBPkxXXudirvcmsfhyjuriNl947Hvnsty/pL5aX2rXWXTYJvry0yn+HP
	1VrxI2F2+Sedue6NDacsF8lcTdx0bMpnHqGuR4VnVymxFGckGmoxFxUnAgByqEKicAIAAA==
X-CFilter-Loop: Reflected

Hi Gregory,

On 2/7/2025 5:57 PM, Gregory Price wrote:

[...snip...]

>> and kernel stack,
> 
> The default kernel stack size is like 16kb.  You'd need like 100,000
> threads to eat up 1.5GB, and 2048 threads only eats like 32MB.
> 
> It's not an interesting amount of memory if you have a 20TB system.

The amount might be small, but having those data in slow tier can
make performance degradation if it is heavily accessed.

The number of accesses isn't linearly corelated to the size of the
memory region.

Thanks,
Honggyu
