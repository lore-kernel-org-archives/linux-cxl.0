Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35913A244;
	Fri, 14 Mar 2025 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741934139; cv=none; b=EZmbj4l0iigqgUWDB+CzGSBfIsAntSYCFGi3rILwocEzxv2G+n3jKEBfbiq3ygxjdwnnbNbSuw3P2eiLbtJCeLqFtReD+2ZHRSj3V9IzgfQLsdOWGbvU53atyxTag1A5qAr2zKVbr9ITJ4MNby2jtZTmCFSIt1OwVLgCtVbExuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741934139; c=relaxed/simple;
	bh=zGQIXkMAaHFfg3ZpQh56TFbyK/3WzGnwBf853ZkYZ+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz8BNM64bXC9knMijyF4pqJSyZS9L7mLJK3EtAMxFzyXoV3TCzD7qWrXE1skzbaay2w9007nRtvc4CT1UpC/YtQTcj6WhgzCQglc9M6X7TJj2MyUNWbOc5cyVPLoQ3Gi08KLMLBOTECGKb8MMwC2jr4K9YqHHbbwWWcFZ3cuuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-fa-67d3ce2da8f2
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v2 3/4] mm/mempolicy: Enable sysfs support for memory hotplug in weighted interleave
Date: Fri, 14 Mar 2025 15:35:11 +0900
Message-ID: <20250314063521.754-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9MKYlJW9WtotzR3@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnoa7uucvpBjv/8VnMWb+GzWL61AuM
	Fj/vHme3OL51HrvF+VmnWCwu75rDZnFvzX9Wi9VrMhw4PHbOusvu0d12md1j8Z6XTB6bPk1i
	9zgx4zeLx86Hlh6fN8kFsEdx2aSk5mSWpRbp2yVwZew8soGp4BxnxZV9i9gaGPezdzFyckgI
	mEhs39MGZ786/5a1i5GDg01ASeLY3hgQU0RAVaLtinsXIxcHs8B6JonXm2axgZQLC2RInJnb
	wwJiswDVHNu6ghXE5hUwlrh9cDbUSE2Jhkv3mEBsTgEziQnvLzKD2EICPBKvNuxnhKgXlDg5
	8wnYHGYBeYnmrbOZQZZJCJxhk9gz4wcrxCBJiYMrbrBMYOSfhaRnFpKeBYxMqxiFMvPKchMz
	c0z0MirzMiv0kvNzNzECw3hZ7Z/oHYyfLgQfYhTgYFTi4d2w61K6EGtiWXFl7iFGCQ5mJRHe
	1bYX0oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwFl5n
	uDrRPmVhVPBb/42lzUsXZSobVe3lrO/2kGyr6VTtC52ZsnlaQe7cr3G2XAd3i/z49KxB3crn
	Z2KuYW5wFa9xYn7bE0ll1s/PtV6v+jg76ZgC2+eygIfPFv187GFxuC7ZfWHKpJLFiXKuASon
	JZeUGN/xM79fqLtf8EPb1SeB5X+vpfYqsRRnJBpqMRcVJwIA8J8bkV8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS1f33OV0g8uPmC3mrF/DZjF96gVG
	i593j7NbfH72mtni+NZ57BaH555ktTg/6xSLxeVdc9gs7q35z2px6NpzVovVazIsfm9bwebA
	47Fz1l12j+62y+wei/e8ZPLY9GkSu8eJGb9ZPHY+tPT4dtvDY/GLD0wenzfJBXBGcdmkpOZk
	lqUW6dslcGXsPLKBqeAcZ8WVfYvYGhj3s3cxcnJICJhIvDr/lrWLkYODTUBJ4tjeGBBTREBV
	ou2KexcjFwezwHomidebZrGBlAsLZEicmdvDAmKzANUc27qCFcTmFTCWuH1wNtRITYmGS/eY
	QGxOATOJCe8vMoPYQgI8Eq827GeEqBeUODnzCdgcZgF5ieats5knMPLMQpKahSS1gJFpFaNI
	Zl5ZbmJmjqlecXZGZV5mhV5yfu4mRmDoLqv9M3EH45fL7ocYBTgYlXh4N+y6lC7EmlhWXJl7
	iFGCg1lJhHe17YV0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkm
	Dk6pBsbKg+yux3P221xv2y1mpvFr9wKtqw6eWz6+1RW4t1UrcO7ud29zu3efirsqkf1L7pCd
	p55kT84S46APZVMv1gU5TO+LenelSlxw35e356JrD4QEPj/xaqF+xo/8L0Her/92fMjZ8qfE
	ru0hSxpToOccUUaHt4JzkwvqBX3TavjfB3yfGS8YX6XEUpyRaKjFXFScCABnLrm9WQIAAA==
X-CFilter-Loop: Reflected

On Thu, 13 Mar 2025 12:40:02 -0400 Gregory Price <gourry@gourry.net> wrote:

Hi Gregory

> On Thu, Mar 13, 2025 at 03:34:10PM +0900, Rakie Kim wrote:
> > On Wed, 12 Mar 2025 12:14:48 -0400 Gregory Price <gourry@gourry.net> wrote:
> > 
> > Given that this adjustment is part of integrating the refactored
> > structure, I believe this patch does not need to be split into two.
> > However, I would appreciate any further input you may have on this.
> >
> 
> Another way of saying this is: can you please change the ordering of
> patch 2 and 3 and place the functional changes into "make mempolicy
> support memory hotplug" patch.
> 
> It's a little odd to "make mempolicy support memory hotplug" and then
> follow that up with a patch that says "now make it REALLY support it".
> 
> Patch 2 should read:
>    "Refactor weighted_interleave sysfs to allow node structure to be
>     dynamic"
> Patch 3 should read:
>    "Make weighted interleave sysfs structure support memory hotplug"
> 
> I think you'll find the patches end up looking much cleaner this way as
> well.
> 
> ~Gregory

Your suggestion seems appropriate. I will rearrange the order as you
suggested when creating version 3.

Rakie

