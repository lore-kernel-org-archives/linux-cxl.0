Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD538737A
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 02:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044466; cv=none; b=eFMcf+GDagkLgTQkq7KPMO71iig/bIHLiS3nMwspug1m59fXKvqyMuavEUdVS+fxfILqRQ9a78m8RQAalg+5kdGh5uxBm4Za7+zomoewMrC4lLP5bungog2ehmoTMzkuz7iA0GJ3CxuNSP31GNMenfX07qINkG79eCH7qd4aadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044466; c=relaxed/simple;
	bh=zmvXUaUh0x7Iq7a1F/nNLaoOJ/x9bsxphrerv34hNIk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HLbT+BHWC77jt3auM+c0xTVPCqGjGv8O/tJRv+fZsOT6KJjlhQ4HRrDvDyRsiDCNZJTr5vh+9Sx8ZgXRR4YnvZZ7J8Dq3TV8VnIIXvK2KttJPj2VANbE2v0T3z9G7kbFoKPty+B9XzE5dEv8M96bUBO45Kn7Ix7SvfSLJ4QlUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sn3LW23F; arc=none smtp.client-ip=91.218.175.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sn3LW23F"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zmvXUaUh0x7Iq7a1F/nNLaoOJ/x9bsxphrerv34hNIk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790044461; v=1; x=1790649261;
 b=Sn3LW23FtZNFu8/Mbwet6R4yJXEDRqNlYfe5P2ue0ktck9vAFi6sFm1PSq9NxNM35zNIkNgj
 mcP7G01BxxKkVQZGzjigwuFHTQ25COq2HXGPT9DhrnaR9faSEGV4CfTCVSNHC4uwko0eVH2FkRK
 bywolCw9+YANKN8z3CLVdEpI=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 8af55bfa8c8b6846;
	Tue, 22 Sep 2026 02:34:11 +0000
X-Mizu-Trace-ID: 8af55bfa8c8b6846
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 2/4] nvdimm/pmem: avoid HWPoison flag updates for clean
 pages
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <arEovvqEpquODZ6X@localhost.localdomain>
Date: Tue, 22 Sep 2026 10:33:54 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <djbw@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 linux-mm@kvack.org,
 nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Ira Weiny <iweiny@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E55DD139-7B33-4269-8854-3469375AD587@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com>
 <20260903122128.12264-3-songmuchun@bytedance.com>
 <arEovvqEpquODZ6X@localhost.localdomain>
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 21, 2026, at 20:53, Oscar Salvador (SUSE) =
<osalvador@kernel.org> wrote:
>=20
> On Thu, Sep 03, 2026 at 08:21:25PM +0800, Muchun Song wrote:
>> pmem_mkpage_present() is called after persistent-memory poison has =
been
>> cleared. It only needs to clear PG_hwpoison and undo the MCE nospec =
state
>> for PFNs that are still marked poisoned.
>>=20
>> For clean PFNs, test_and_clear_pmem_poison() has no semantic effect, =
but it
>> still performs an atomic clear operation against struct page flags. =
That is
>> unnecessary today and conflicts with the FS-DAX vmemmap optimization =
added
>> later in the series, where clean PFNs may be backed by shared =
read-only
>> metadata.
>>=20
>> Check PageHWPoison() first so only poisoned PFNs update the page =
state.
>> Poison recovery keeps the same behavior, while clean PFNs no longer =
require
>> writable per-PFN metadata.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Then change itself looks good to me, so
>=20
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks for your review.

>=20
> but any reason not to hide the PageHWPoison check within =
test_and_clear_pmem_poison()?

I indeed hadn't considered this point before. But now I find it
unnecessary, because a patch [1] has already removed =
test_and_clear_pmem_poison().

[1] =
https://lore.kernel.org/all/20260903053535.17611-3-kaitao.cheng@linux.dev/=


Thanks,
Muchun

>=20
>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs


