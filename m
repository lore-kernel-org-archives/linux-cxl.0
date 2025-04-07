Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0421AAE28;
	Mon,  7 Apr 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018677; cv=none; b=Gbu/Uggsy09rg+UjW2NeiELW7WAtPSPDOzn0O4AOGic0jY+1KC4XuiOLvXMvhlovjU6tKpARjXMW+OrqA7Ckqlnm+ABdGDFJaOR6rCI1SI+LNligDlAzvwEwo60Xoak6yVjfTvpke8uUJP0wrZQUbYaCJz3SYrivmyzc2UKR2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018677; c=relaxed/simple;
	bh=EuEA2yEZnbY0BhR9l4M5pcQ1yh2rrp4dfcKgMY7mxro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAMYvSX0di8Zvq505KylSHiBHKjLBuePPtQB5hb3gg1LxdV9AjoSXaYIoocnlkajCuWwOmEQfpmPJPiLLnDYz5LZgEDv6u6XVR8U4FhtilW6K+1S4Z0g96m0DOwdjS1/QkjW0+VFXSBo8lqA5bmYExbqE+XhWNHR036yn+zvqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-75-67f39ce63774
From: Rakie Kim <rakie.kim@sk.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: akpm@linux-foundation.org,
	gourry@gourry.net,
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
Subject: Re: [PATCH v6 3/3] mm/mempolicy: Support memory hotplug in weighted interleave
Date: Mon,  7 Apr 2025 18:37:32 +0900
Message-ID: <20250407093738.406-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <Z--bppMUIo5k5eOF@localhost.localdomain>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsXC9ZZnoe6zOZ/TDc60iVjMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvFqoXX2CyOb53HbnF+1ikWi8u75rBZ3Fvzn9XizLQii9VrMhy4PXbOusvu
	0d12md2j5chbVo/Fe14yeWz6NInd48SM3yweOx9aerzfd5XNY/Ppao/Pm+QCuKK4bFJSczLL
	Uov07RK4Mi7tnsZS8EOw4sOLDqYGxh18XYycHBICJhLfp7UzdzFygNkf/zuBmGwCShLH9saA
	VIgIqElMe9XI3sXIxcEs8J1JovnMNHaQhLBAuMT3+09YQOpZBFQlPpxKBwnzChhLbHr5jxFi
	uqZEw6V7TCA2p4CpxITPU1hAbCEBHolXG/YzQtQLSpyc+QQsziwgL9G8dTYzyC4Jge9sEnv7
	fzJDDJKUOLjiBssERv5ZSHpmIelZwMi0ilEoM68sNzEzx0QvozIvs0IvOT93EyMw+JfV/one
	wfjpQvAhRgEORiUe3h1un9OFWBPLiitzDzFKcDArifBanvqULsSbklhZlVqUH19UmpNafIhR
	moNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoHR++bmjQ+nPDZVD7gY6sRf6WobxWio7fyp
	3VmEO6dOvzF1+f7rjEkTz63w2bhy/pYOmbd3c8wfOF/2edjezFlQUPGZVXqG3tkL162tpi9d
	qGlytbk1sJlLz4PlmcFy9qRfr4/V29Q+fTAhSu7b+eTmk+I706fcun5g3WHxs3NK4zYdfmae
	pPFGiaU4I9FQi7moOBEA02HKlXoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXCNUNNS/fZnM/pBmc+cFjMWb+GzWL61AuM
	Fl/X/2K2+Hn3OLvF52evmS1WLbzGZnF86zx2i8NzT7JanJ91isXi8q45bBb31vxntTgzrcji
	0LXnrBar12RY/N62gs2B32PnrLvsHt1tl9k9Wo68ZfVYvOclk8emT5PYPU7M+M3isfOhpcf7
	fVfZPL7d9vBY/OIDk8fm09UenzfJBfBEcdmkpOZklqUW6dslcGVc2j2NpeCHYMWHFx1MDYw7
	+LoYOTgkBEwkPv53AjHZBJQkju2N6WLk5BARUJOY9qqRvYuRi4NZ4DuTRPOZaewgCWGBcInv
	95+wgNSzCKhKfDiVDhLmFTCW2PTyHyOILSGgKdFw6R4TiM0pYCox4fMUFhBbSIBH4tWG/YwQ
	9YISJ2c+AYszC8hLNG+dzTyBkWcWktQsJKkFjEyrGEUy88pyEzNzTPWKszMq8zIr9JLzczcx
	AgN+We2fiTsYv1x2P8QowMGoxMN7o/FTuhBrYllxZe4hRgkOZiURXstTQCHelMTKqtSi/Pii
	0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGkN3a+hEH6zmZUq+oVdWWHF4c
	p7EoXDFonuK+CRNds5Jmde9dlrVW8ZhC7DO7OOWT6n6Lfi839Lj1lcFQJeuQ/r792heOcDiE
	79Ls5LxoraxV9mA7U5dp7a97ydHSP5+nTri14Rrvvenf7xu9FJrWuKnrcNxfh87rMQ/+CWv/
	NZluN+P1hPxYJZbijERDLeai4kQAkX4dnnQCAAA=
X-CFilter-Loop: Reflected

On Fri, 4 Apr 2025 10:43:18 +0200 Oscar Salvador <osalvador@suse.de> wrote:
> On Fri, Apr 04, 2025 at 04:46:21PM +0900, Rakie Kim wrote:
> > The weighted interleave policy distributes page allocations across multiple
> > NUMA nodes based on their performance weight, thereby improving memory
> > bandwidth utilization. The weight values for each node are configured
> > through sysfs.
> > 
> > Previously, sysfs entries for configuring weighted interleave were created
> > for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> > might not have memory. However, not all nodes in N_POSSIBLE are usable at
> > runtime, as some may remain memoryless or offline.
> > This led to sysfs entries being created for unusable nodes, causing
> > potential misconfiguration issues.
> > 
> > To address this issue, this patch modifies the sysfs creation logic to:
> > 1) Limit sysfs entries to nodes that are online and have memory, avoiding
> >    the creation of sysfs entries for nodes that cannot be used.
> > 2) Support memory hotplug by dynamically adding and removing sysfs entries
> >    based on whether a node transitions into or out of the N_MEMORY state.
> > 
> > Additionally, the patch ensures that sysfs attributes are properly managed
> > when nodes go offline, preventing stale or redundant entries from persisting
> > in the system.
> > 
> > By making these changes, the weighted interleave policy now manages its
> > sysfs entries more efficiently, ensuring that only relevant nodes are
> > considered for interleaving, and dynamically adapting to memory hotplug
> > events.
> > 
> > Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> > Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> For the memory-hotplug bits: Reviewed-by: Oscar Salvador
> <osalvador@suse.de<
> 
> Just one thing that caught my eye:
> 
> Cannot add_weighted_interleave_group be __init? AFAICS, it only gets
> called at boot time?
> 
> 
> -- 
> Oscar Salvador
> SUSE Labs

Thank you for your response regarding this patch.
I agree that `add_weighted_interleave_group` can be marked with __init,
as it is only called during system boot.
I will make this change in the next revision.

Rakie

