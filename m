Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E07EEBB;
	Sat, 18 Jul 2026 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338190; cv=none; b=lyMbyku9GgjEQ+IqXpur9WvzJnK78nWu5sSHFO0WQmVEqk3jphPFw02Vp8xrTS2fiGX5aZ02SJglEmNRbBCT94dW3TTjS7yLJrrDXpR1vqf4UfitEGqryOcD+e7ZfH5M4w46rUVD28pZFDBwVnMSKigrpohV/i+DTlt5b3MLMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338190; c=relaxed/simple;
	bh=dVdq03l8k8rnHkF2qT4pI32vsZll6gDNKxmxd/jMmgU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aqtX0zAWtZsTOO8J10GpBjsPUtZhrLBbpH4s6DShuF5bG1B/1TlltQk1gQ4Xht6mbYUwFuslx9Nxaq+z9BrueM4oWXGVXfWB364uyGVn3qzkmNI2kFoYAPcT/+tGEVh57bmoBxee2i/t4tptMmA5EMTtss90ajpc2V11+etR9m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aYHkjg99; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aYHkjg99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEBC1F000E9;
	Sat, 18 Jul 2026 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784338188;
	bh=nGP1qpw+teL8hrbVXIODrPReZTXoSMVoPewT58BkKRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aYHkjg99340LaoEW+nC6j/pobLTfRsTslXzRUwPXTHiNjEJadkub9WwJRQgp86jFn
	 5+NJNrQuZhOT5lp9Bw4Sj0JMFtWWc4BWUXkQ6wlqgwBPxG+QcXQbg+Gzm3pm0QIhlE
	 LVQ5wOhwRIK1Md1rIdk9Eo4FSl5T/rwYi7n+OXI0=
Date: Fri, 17 Jul 2026 18:29:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: Barry Song <baohua@kernel.org>, David Hildenbrand <david@kernel.org>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ljs@kernel.org, willy@infradead.org, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 0/2] mm: fix PMD level mTHP accounting bugs
Message-Id: <20260717182947.534af296aaa1831d13f8ae6d@linux-foundation.org>
In-Reply-To: <20260717064502.1980173-1-npache@redhat.com>
References: <20260717064502.1980173-1-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 00:44:58 -0600 Nico Pache <npache@redhat.com> wrote:

> While running selftests I noticed the PMD level per-mTHP stats (nr_anon)
> remained elevated after each run. After further investigation I noticed
> this accounting error occurs for both the migration.private_anon_htlb_test
> and the HMM tests.
> 
> In the HMM case this is due to folio_add_new_anon_rmap() incrementing the
> mTHP stats, but never containing a corresponding decrement in
> free_zone_device_folio(). We solve this by making sure to decrement the
> counter when freeing device memory.
> 
> In the migration case, we are incrementing this counter without first
> checking whether this folio is a hugetlb folio, which relies on a separate
> accounting system. We solve this by adding the proper hugetlb check before
> incrementing this counter.
> 
> With these changes in place, the two tests no longer cause elevated PMD
> level accounting issues.

Thanks, I've updated mm.git's mm-hotfixes-unstable branch to this
version.

Sashiko is worried about the existing code ("list corruption or a
use-after-free panic"):
	https://sashiko.dev/#/patchset/20260717064502.1980173-1-npache@redhat.com

> 
> V2 Changes:
>  - add RB from Zi
>  - Drop unnecessary check in __folio_migrate_folio(). HugeTLB has its own
>    migration system in hugetlbfs_migrate_folio().

Here's how v2 altered mm.git:

 mm/migrate.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/mm/migrate.c~b
+++ a/mm/migrate.c
@@ -624,8 +624,7 @@ static int __folio_migrate_mapping(struc
 	 */
 	newfolio->index = folio->index;
 	newfolio->mapping = folio->mapping;
-	if (folio_test_anon(folio) && folio_test_large(folio) &&
-	    !folio_test_hugetlb(folio))
+	if (folio_test_anon(folio) && folio_test_large(folio))
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
 	if (folio_test_swapbacked(folio))
_

