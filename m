Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E2F391830;
	Tue, 17 Mar 2026 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741176; cv=none; b=d0KDa/EcF24Q16eH/IS799mfwajM+MWC0GF5vRrUM+yecgOJRk1hWTTqeMe4zX7xpR8wsAShOf7NeftjXxv+l/09tgiO43fFILjLOBcFyPv+i2WRHxUvrJsXfvDxkWwCyNOnEbNTsl7KQ9jB7wLVQxzjiE+AE6sMWE259D2zMIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741176; c=relaxed/simple;
	bh=afzmyroVDBhuX+CTzQzCF3iSFklEc8ryjkRgpNgZWjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruEQiFUnzk1h11e22sialbl7o6l0xqs6MmVDUrkxrOZD6MTQs3uxy6bltiVuYGZfWjgtBMBqddYAIl4FMXNtoltqn7HcjjqBD5wHrYzy3xQl8ib7sdddnVoThBwGzto0Uf12e4yFCfYUTNtpeie2oiQSEwiJXtXswTUDiGZ13MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-9d-69b9246bd355
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	harry.yoo@oracle.com,
	lsf-pc@lists.linux-foundation.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	Rakie Kim <rakie.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce socket-aware weighted interleave
Date: Tue, 17 Mar 2026 18:50:03 +0900
Message-ID: <20260317095226.269-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <abgNTMDM5xhRsWFU@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsXC9ZZnkW62ys5Mgz1PuCzmrF/DZnH38QU2
	i103QiymT73AaHHiZiObxeqbaxgtnm/9xWjx8+5xdov7y56xWOx/+pzFYtXCa2wWx7fOY7fY
	3vCA3eL8rFMsFpd3zWGzuLfmP6vFyVkrWSz2vd7LbPGtT9rifp+DxZH125ksJl9awGYxu7GP
	0eLWhGNMFqvXZFjMPnqP3UHKY+esu+weCzaVenS3XWb3aDnyltVj8Z6XTB6bVnWyeWz6NInd
	48SM3yweOx9aeky+sZzRo7f5HZvHx6e3WDymzq73WL/lKovHmQVH2D0+b5ILEIjisklJzcks
	Sy3St0vgypg9JaPgDW/FvRtPmRoYe7m7GDk5JARMJBp33GaDsfftWMTcxcjBwSagJHFsbwyI
	KSKgKtF2xR2kglngF6vE8qPGILawQIbEhOX/wapZgEr6Z8SDhHkFjCW27PnJBDFQU2Ldxlss
	IDangJnEx09zwBYJCfBIvNqwnxGiXlDi5MwnLBDj5SWat84GGskF1PuXXWL3gTPsEIMkJQ6u
	uMEygZF/FpKeWUh6FjAyrWIUyswry03MzDHRy6jMy6zQS87P3cQIjOJltX+idzB+uhB8iFGA
	g1GJh/cG645MIdbEsuLK3EOMEhzMSiK8y45syxTiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/St
	PEVIID2xJDU7NbUgtQgmy8TBKdXAmHXr90N+fmY20zXmE9q/MLoqM+53m/N/sug238hqb6dv
	5jcfnLsU46ArIca9Z0XwVc30Neo3tR2mXzF0tY7daNQwc0nqjJ1bov7MjM2yV6h5dO7O8o0z
	Fq0+U7ak8faEO/mJLhc5jG6Enuk1CThSK9jAsMuGjXPD6a8L1Dje3v3ELDypg3H6OSWW4oxE
	Qy3mouJEALA5+eHeAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsXCNUM9RjdLZWemQfNZU4s569ewWdx9fIHN
	YteNEItzU2azWUyfeoHR4sTNRjaL1TfXMFo83/qL0eLn3ePsFveXPWOx+PzsNbPF/qfPWSxW
	LbzGZnF86zx2i8NzT7JabG94wG5xftYpFovLu+awWdxb85/V4uSslSwW+17vZbb41idtcb/P
	weLQteesFkfWb2eymHxpAZvF7MY+RotbE44xWaxek2Hxe9sKoNDRe+wO8h47Z91l91iwqdSj
	u+0yu0fLkbesHov3vGTy2LSqk81j06dJ7B4nZvxm8dj50NJj8o3ljB69ze/YPD4+vcXi8e22
	h8fiFx+YPKbOrvdYv+UqS4BQFJdNSmpOZllqkb5dAlfG7CkZBW94K+7deMrUwNjL3cXIySEh
	YCKxb8ci5i5GDg42ASWJY3tjQEwRAVWJtivuIBXMAr9YJZYfNQaxhQUyJCYs/w9WzQJU0j8j
	HiTMK2AssWXPTyaIgZoS6zbeYgGxOQXMJD5+msMGYgsJ8Ei82rCfEaJeUOLkzCcsEOPlJZq3
	zmaewMgzC0lqFpLUAkamVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIERu6z2z8QdjF8uux9i
	FOBgVOLhvcG6I1OINbGsuDL3EKMEB7OSCO+yI9syhXhTEiurUovy44tKc1KLDzFKc7AoifN6
	hacmCAmkJ5akZqemFqQWwWSZODilGhgVjBKfpdwO+PNw/+rNLp/Ujj1zfSW5SplLwr7pw9ng
	gqUBfjKrGs4x6Gqvm8H441zO6fefbX+dn3PPtWj77eOzDyek8+p6XTu59MvXicahZU9lHXhv
	pLrf3anevqDNv+iH2+IPPnfnCFgd5Xl+Rs9TLNFgcevVI3GOzEfChHXduJ9nd3M+vNujxFKc
	kWioxVxUnAgA6K8H3dQCAAA=
X-CFilter-Loop: Reflected

On Mon, 16 Mar 2026 10:01:48 -0400 Gregory Price <gourry@gourry.net> wrote:
> On Mon, Mar 16, 2026 at 02:12:48PM +0900, Rakie Kim wrote:
> > This patch series is an RFC to propose and discuss the overall design
> > and concept of a socket-aware weighted interleave mechanism. As there
> > are areas requiring further refinement, the primary goal at this stage
> > is to gather feedback on the architectural approach rather than focusing
> > on fine-grained implementation details.
> > 
> 
> I gave this a brief browse this morning, and I rather like this
> approach, more-so than the original proposals for socket-awareness
> that encoded the weights in a 2-dimensional array.

Hello Gregory,

Thanks for your review and feedback. I also think this approach is
much better than the previous 2-dimensional array idea. Since this
is still an early draft, I hope this code will be developed into a
better design through community discussions.

> 
> I think this would be a great discussion at LSF, and I wonder if
> something like memory-package could be used for more purposes than just
> weighted interleave.
> 
> ~Gregory

I and Honggyu Kim are actually preparing to propose this exact topic
for the upcoming LSF/MM/BPF summit. However, I accidentally missed
adding lsf-pc@lists.linux-foundation.org to the CC list. I will
re-post or forward this to the LSF PC list soon.

You are exactly right about the memory-package. When I first designed
it, I wanted to use it for memory tiering and other areas, not just
for weighted interleave. For now, weighted interleave is the only
implemented use case, but I hope to keep improving it so it can be
used in other subsystems as well.

Thanks again for your time and review.

Rakie Kim

