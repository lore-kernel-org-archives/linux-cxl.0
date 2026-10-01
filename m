Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C11F8691
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790820366; cv=none; b=kzMwKnhz0eN50xNSirIJQ6DlhLkQttwWGWbI3XuN9g8mww7hq41kBCbf8cLCwCr7EsTlaLJrcL2X6/ptT+l/gVFJsP4T3M/dfyB3wuFXTysBH3ASm83iuRr5mlkgM1ZQXxJbDRod4Da1qLjI4N/X4evZ/Yg2yYRM11GWtNqPb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790820366; c=relaxed/simple;
	bh=YagsZlTkcHN2bddnpunvmPCH8Cip4+WkjbvDyxAtdJ0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UsiA+wP4ZmlnDtwtdhrtJA2BHXQ4sO/fllp+SXfkLaCyQcFUDsUEA8whBdzbIQxNE2hHKEaF+GbbpDeA5YRu4ioqGCkR1b1WqCt6TxFKcbrCCUE74/7Dory1XjsAKavUEjv2xiEaql0/VjKPwGWjd5nddEiXfBrWRvJtVh/NpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qhVMhNPg; arc=none smtp.client-ip=95.215.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qhVMhNPg"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YagsZlTkcHN2bddnpunvmPCH8Cip4+WkjbvDyxAtdJ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790820361; v=1; x=1791425161;
 b=qhVMhNPgSbaAEQOJ0oA9YzP/aQIoLOlFQJBbwUProbKFs3I5Anf9q/253TKTEI9z9fct+Azs
 Rz9Xy5HORawsNhtlVJVKI+zAcIuzm2cPY5crc9XeXX9gp7NQAf+TigpRj6xfPm14nUpAt0N8YVc
 XpgJIpRtMG8/4iUQFHtE3jdo=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id a8a0d2bf9a452d40;
	Thu, 01 Oct 2026 02:06:01 +0000
X-Mizu-Trace-ID: a8a0d2bf9a452d40
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 1/1] mm/memory_hotplug: fix missing rollback in
 __add_pages()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260930160432.5564-1-lance.yang@linux.dev>
Date: Thu, 1 Oct 2026 10:05:43 +0800
Cc: david@kernel.org,
 osalvador@suse.de,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D52186EB-026B-4C9D-BBCE-875F259634AB@linux.dev>
References: <20260930160432.5564-1-lance.yang@linux.dev>
To: Lance Yang <lance.yang@linux.dev>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Oct 1, 2026, at 00:04, Lance Yang <lance.yang@linux.dev> wrote:
>=20
> __add_pages() returns on a sparse_add_section() failure without =
removing
> the sections already added in the same request.
>=20
> For memremap_pages(), the failed range is not counted in =
pgmap->nr_range,
> so memunmap_pages() skips it. The sections already added in that range
> retain their vmemmap mappings and subsection bits. Retrying a
> section-aligned range can then fail with -EEXIST.
>=20
> Save the initial PFN and remove [start_pfn, pfn) on failure. For a =
vmemmap
> population failure, section_activate() already cleans up the current
> section, so the rollback excludes it. If the first section fails,
> __remove_pages() receives an empty range and does nothing.
>=20
> Link: =
https://lore.kernel.org/all/BAD58999-1EDD-4A37-ABA0-DB1BD8AB3453@linux.dev=
/
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> No Fixes tag, as I couldn't identify the commit that introduced this =
issue.

Hi Lance,

LLMs are quite good at tracing this kind of code history, so I used one
to go through the relevant commits and identify the correct Fixes tag.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")

Before that commit, __add_pages() ignored -EEXIST and continued with
the remaining sections. After a partial failure, a retry could therefore
reuse the vmemmap of sections added by the failed attempt and continue
with the later sections.

Commit ba72b4c8cf60 made -EEXIST a hard error because
sparse_add_section() began using it to report an actual subsection
collision. That semantic change was correct, but without rolling back
the sections added earlier in the request, stale subsection bits make =
the
retry stop at the first previously added section.

The vmemmap removal infrastructure had already been added by commit
0197518cd367 ("memory-hotplug: remove memmap of sparse-vmemmap").
Therefore, ba72b4c8cf60 appears to be the commit that made this bug
observable in the way described by this patch.

>=20
> mm/memory_hotplug.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 796af1028ee2..ca4656698148 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
> int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
> struct mhp_params *params)
> {
> + 	const unsigned long start_pfn =3D pfn;
> 	const unsigned long end_pfn =3D pfn + nr_pages;
> 	unsigned long cur_nr_pages;
> int err;
> @@ -413,8 +414,11 @@ int __add_pages(int nid, unsigned long pfn, =
unsigned long nr_pages,
>   SECTION_ALIGN_UP(pfn + 1) - pfn);
> 		err =3D sparse_add_section(nid, pfn, cur_nr_pages, =
altmap,
> 					params->pgmap);
> - 		if (err)
> + 		if (err) {
> + 			__remove_pages(start_pfn, pfn - start_pfn, =
altmap,
> +       				params->pgmap);
> 			break;
> + 		}
> 		cond_resched();
> 	}
> 	vmemmap_populate_print_last();

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks,
Muchun

> --=20
> 2.39.3
>=20

