Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B311BDAA0;
	Mon, 10 Mar 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597435; cv=none; b=mBVOcGdt2dM9Ny0FoQptk8D728BRYmIK6XVXn1zw+/qAcbkw1ZakMOQEB5kZezxwZnXkXT7hNzkCgEu5Jg3nzS9YL/aIiCEvNoJI7cVQQ0CKgWrV+EbVdtXjYCYd8LvYpnBHxJ42T+PizrrZMLVSDNcY1vPy9j0TCEhuv36l0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597435; c=relaxed/simple;
	bh=x5y52ORsIAdc8VJ9E9ytWhkH3OBDUo5wo5YehwWbcr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyhgOAerITaO411EHUaEEFyjy4uLPSAWUi6k3QMSm4Kkj59akj3t3YdNn6Yfer5t0H9xv8KW5r5UmwhT7R7e9ps1cnVZVEWPIv8PBsecZ+B2++kd4XzJ8/+f5b9qj8xb5PAFAt2ksV/PENUHhXaldB3SL7r8L/ITuly1qFe3LGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-de-67ceaaf00db8
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
Subject: Re: [PATCH 0/4] mm/mempolicy: Add memory hotplug support in weighted interleave
Date: Mon, 10 Mar 2025 18:03:34 +0900
Message-ID: <20250310090340.620-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z8sXFGBYFlG2Z1s4@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC9ZZnoe7HVefSDfY9ZLSYs34Nm8X0qRcY
	LX7ePc5ucXzrPHaL87NOsVhc3jWHzeLemv+sFqvXZDhweOycdZfdo7vtMrvH4j0vmTw2fZrE
	7nFixm8Wj50PLT0+b5ILYI/isklJzcksSy3St0vgyvixpI2poE284lzjUtYGxhVCXYycHBIC
	JhKPV81i6mLkALNXHTYCMdkElCSO7Y0BMUUEVCXarrh3MXJxMAusZ5J4vWkWG0insECExNMz
	LawgNgtQzeZtN8HivALGEpvfP2GCmK4p0XDpHpjNKWAm8XLDB3YQW0iAR+LVhv2MEPWCEidn
	PmEBsZkF5CWat85mBlkmIXCCTaJh2XJmiEGSEgdX3GCZwMg/C0nPLCQ9CxiZVjEKZeaV5SZm
	5pjoZVTmZVboJefnbmIEBvGy2j/ROxg/XQg+xCjAwajEw/tg3tl0IdbEsuLK3EOMEhzMSiK8
	attPpQvxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgTGdh
	uvtuUdnvTxIBjeeOe1/smO3G6X/r/ULtuj2SZU+NuAN/2nO3qvR8XrS2Ymm/x0zDNrEPhWn1
	y+Yd5Ny98JLQtwNpZ72vH/36Xl+H+9p7lZbXcz8Z7X9bvbVcbNZWxhlaR54o6E2I/nRva6jv
	vAeRKnesLBoko31fpW16wvKIc+v1g3q7+5RYijMSDbWYi4oTAfMnmo1eAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsXCNUNNS/fDqnPpBsv+GVnMWb+GzWL61AuM
	Fj/vHme3+PzsNbPF8a3z2C0Ozz3JanF+1ikWi8u75rBZ3Fvzn9Xi0LXnrBar12RY/N62gs2B
	x2PnrLvsHt1tl9k9Fu95yeSx6dMkdo8TM36zeOx8aOnx7baHx+IXH5g8Pm+SC+CM4rJJSc3J
	LEst0rdL4Mr4saSNqaBNvOJc41LWBsYVQl2MHBwSAiYSqw4bgZhsAkoSx/bGgJgiAqoSbVfc
	uxi5OJgF1jNJvN40i62LkZNDWCBC4umZFlYQmwWoZvO2m2BxXgFjic3vnzCB2BICmhINl+6B
	2ZwCZhIvN3xgB7GFBHgkXm3YzwhRLyhxcuYTFhCbWUBeonnrbOYJjDyzkKRmIUktYGRaxSiS
	mVeWm5iZY6pXnJ1RmZdZoZecn7uJERi4y2r/TNzB+OWy+yFGAQ5GJR7eB/POpguxJpYVV+Ye
	YpTgYFYS4VXbfipdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJ
	g1OqgdHAS/xNycSb/QYL2AIfHdBzVdzH4/5gzfWqlMid/KZ7lkzg21Bz62LXJPkS2YAlgqFv
	bWpqN2WIh/e/KmdZkvQv6MLbTRIBvZteiM9xLpBd6sih/rnr1DfO3KD7DmL6GZsYl0z5cdao
	P+8af0Vs2wwxyTtphTka/KYv/iUFLLoj+DtVws3KXYmlOCPRUIu5qDgRAECD5n5YAgAA
X-CFilter-Loop: Reflected

On Fri, 7 Mar 2025 10:56:04 -0500 Gregory Price <gourry@gourry.net> wrote:

Hi Gregory
Thank you for your response regarding this patch.

> On Fri, Mar 07, 2025 at 03:35:29PM +0900, Rakie Kim wrote:
> > Unnecessary sysfs entries: Nodes without memory were included in sysfs
> > at boot.
> > Missing hotplug support: Nodes that became online after initialization
> > were not recognized, causing incomplete interleave configurations.
> 
> This comment is misleading.  Nodes can "come online" but they are
> absolutely detected during init - as nodes cannot be "hotplugged"
> themselves.  Resources can be added *to* nodes, but nodes themselves
> cannot be added or removed.
> 
> I think what you're trying to say here is:
> 
> 1) The current system creates 1 entry per possible node (explicitly)
> 2) Not all nodes may have memory at all times (memory can be hotplugged)
> 3) It would be nice to let sysfs and weighted interleave omit memoryless
>    nodes until those nodes had memory hotplugged into them.
> 
> > Dynamic sysfs updates for hotplugged nodes  New memory nodes are
> > recognized and integrated via the memory hotplug mechanism.
> > Subsequent patches refine this functionality:
> >
> 
> Just going to reiterate that that there's no such this as a hotplug node
> or "new nodes" - only nodes that have their attributes changed (i.e.
> !N_MEMORY -> N_MEMORY).  The node exists, it may just not have anything
> associated with it.
> 
> Maybe semantic nits, but it matters.  The nodes are present and can be
> operated on before memory comes online, and that has implications for
> users.  Depending on how that hardware comes online, it may or may not
> report its performance data prior to memory hotplug.

I agree with your assessment. The existing comments, as you pointed out,
might indeed be confusing or misleading. I'll make sure this issue is
addressed in version 2.

> 
> If it doesn't report its performance data, then hiding the node before
> it hotplugs memory means a user can't pre-configure the system for when
> the memory is added (which could be used immediately).
> 
> Hiding the node until hotplug also means we have hidden state.  We need
> to capture pre-hotplug reported performance data so that if it comes
> online the auto-calculation of weights is correct.  But if the user has
> already switched from auto to manual mode, then a node suddenly
> appearing will have an unknown state.
> 
> This is why I initially chose to just expose N_POSSIBLE entries in
> sysfs, because the transition state causes hidden information - and that
> felt worse than extra entries.  I suppose I should add some
> documentation somewhere that discusses this issue.
> 
> I think the underlying issue you're dealing with is that the system is
> creating more nodes for you than it should.

I will reply to your next comment on this issue soon.

> 
> ~Gregory

Rakie
