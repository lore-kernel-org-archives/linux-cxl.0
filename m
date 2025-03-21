Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD26282F1;
	Fri, 21 Mar 2025 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533597; cv=none; b=ST0+IRz7EFP+KPap7WKRT9kTYwenEotJzpfcR27PwFHrHjIJBce/cL0P4dg6pzjTtzFBQbb7sBztkqDwPxOGAhGvL9KHw892JSDGWD0aZEenZDad7hxg6FvcBJ5s2tatLCy7QYiBaVnsnwrLPZHGLHPm1NSCGJOeXNckLARCnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533597; c=relaxed/simple;
	bh=QekAbbPEkoztBFSu1XZeqrSFydw7/wSuY/OyyJBpfwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzeGfqeyBRAW/IzdxtavCjF3txJWjaS+xB3gAbIPmsfC1fnabF8df24xaQtMVGanrwAnBb6nZFbrHkzY73nHt8PTfWGCNEFAjTXe+ZnmuMkdycQOhqCIFIaRDfqAjeL3ULi9ZE0BGbxE029ynor/B5VSe5kDMFT+NXznI0B3lUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-ac-67dcf3d5454c
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted interleave sysfs
Date: Fri, 21 Mar 2025 14:06:19 +0900
Message-ID: <20250321050625.950-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z9zww6ClrqH7lFom@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsXC9ZZnoe7Vz3fSDTbO4rWYs34Nm8X0qRcY
	Lb6u/8Vs8fPucXaLVQuvsVkc3zqP3eL8rFMsFpd3zWGzuLfmP6vF6jUZDlweO2fdZffobrvM
	7tFy5C2rx+I9L5k8Nn2axO5xYsZvFo+dDy093u+7yubxeZNcAGcUl01Kak5mWWqRvl0CV8ap
	NYuZC+5wVtx4eIitgfEkexcjB4eEgInElDbnLkZOMHPhpw4mkDCbgJLEsb0xIKaIgKpE2xX3
	LkYuDmaBR0wSp9uXsoLEhQXCJVpniIJ0sgCVHLtygBnE5hUwlrj2qIMZYqKmRMOle0wgNqeA
	mcTrpitsILaQAI/Eqw37GSHqBSVOznzCAmIzC8hLNG+dzQyyS0LgOZvE8V+TWSEGSUocXHGD
	ZQIj/ywkPbOQ9CxgZFrFKJSZV5abmJljopdRmZdZoZecn7uJERjqy2r/RO9g/HQh+BCjAAej
	Eg+vxZ/b6UKsiWXFlbmHGCU4mJVEeEU6gEK8KYmVValF+fFFpTmpxYcYpTlYlMR5jb6VpwgJ
	pCeWpGanphakFsFkmTg4pRoYTRdLzNn3i1OrPqDcLjfeQe99gN/ihGMSF33ObPsgPpv3RENg
	aNIkhacui7RmLWw/edHzVaHcZtZIq/mlgVwTW1a3tDyUfyn0wnXu/bvyJ15/9DwWZpwpan3s
	4+Qvn35f4r5c/yyB49UVzU62O6tfN7FMmV55vmDJLPuCclVBJqtXyZObXferKLEUZyQaajEX
	FScCAPoCQCNxAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXCNUNNS/fq5zvpBicNLeasX8NmMX3qBUaL
	r+t/MVv8vHuc3eLzs9fMFqsWXmOzOL51HrvF4bknWS3OzzrFYnF51xw2i3tr/rNaHLr2nNVi
	9ZoMi9/bVrA58HnsnHWX3aO77TK7R8uRt6wei/e8ZPLY9GkSu8eJGb9ZPHY+tPR4v+8qm8e3
	2x4ei198YPL4vEkugDuKyyYlNSezLLVI3y6BK+PUmsXMBXc4K248PMTWwHiSvYuRk0NCwERi
	4acOpi5GDg42ASWJY3tjQEwRAVWJtivuXYxcHMwCj5gkTrcvZQWJCwuES7TOEAXpZAEqOXbl
	ADOIzStgLHHtUQczxERNiYZL95hAbE4BM4nXTVfYQGwhAR6JVxv2M0LUC0qcnPmEBcRmFpCX
	aN46m3kCI88sJKlZSFILGJlWMYpk5pXlJmbmmOoVZ2dU5mVW6CXn525iBIb3sto/E3cwfrns
	fohRgINRiYfX4s/tdCHWxLLiytxDjBIczEoivCIdQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	XuGpCUIC6YklqdmpqQWpRTBZJg5OqQZGrtkLj57dx1Tw4s+C3bNWdrjVnsh+vPvh4WWVHHYt
	PVv5V6f4LtLg0/Tt+ZotknHBb5nBLY4QBcYqBp6TzjkFWjlma5czrOAyWlylcvGnXKV5hE3t
	27/Gaf2bu5xMbeUXcz7m/XBT7T/PzVlrX0/y7DVPfGf/TE0nvPP9QoOlXgc+5M6pT5BVYinO
	SDTUYi4qTgQA66H2DGsCAAA=
X-CFilter-Loop: Reflected

On Fri, 21 Mar 2025 00:53:23 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Fri, Mar 21, 2025 at 01:36:55PM +0900, Rakie Kim wrote:
> > 
> > Patch 1 and Patch 2 are closely related, and I believe that both patches
> > need to be combined to fully support the functionality.
> > 
> > Initially, I thought that Patch 1 was the fix for the original issue and
> > considered it the candidate for a backport.
> > However, upon further reflection, I believe that all changes in Patch 1
> > through Patch 3 are necessary to fully address the underlying problem.
> > 
> > Therefore, I now think it makes more sense to merge Patch 1 and Patch 2
> > into a single patch, then renumber the current Patch 3 as Patch 2,
> > and treat the entire set as a proper -stable backport candidate.
> > 
> > I'd appreciate your thoughts on this suggestion.
> > 
> > Rakie
> > 
> 
> All of this is fine, but it doesn't fix the bug in LTS kernels :]
> 
> It would be nice to do that too, since you identified it.
> ~Gregory

Following the previously discussed patch restructuring, are there any
other bugs that remain unresolved?
If you have any additional insights on these unresolved issues,
I would appreciate your input.

Rakie.
