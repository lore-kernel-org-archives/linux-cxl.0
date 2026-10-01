Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F32FE56F
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790822019; cv=none; b=qUn5UKx5ptWpRNpoUKA3wU1DGmckJKU7rCfR+cNFIWYShq0Z8KfXTkWJEgmI5BXi7s1s8EGB/uNRs+lOGlRrkVcb8u9ujZXjfkm+zZVF2HjNtuZLV1baq14Bdkm5N1EISqVxGvIx6ZKBmHidgQWyE6mHlUcDHTJpOOTydaWumdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790822019; c=relaxed/simple;
	bh=cbH3JYvqlDpyYTN0NgAeZSXpYyTEo/j3lBZbAtwH0nQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AE6efJ+O+QBxBaiAmHnxgmiDotwhC7S7+ee6tmzXZw4Hoj4TF4LIATzlAS7WKOxhShClvIDOIZEVxI6AwCdaCrJe4Od0KJZsanw8SDMncS/ium9mztsOoWIIdlppZuJXEjnokelon3X2cKFRuRe7EpVUjPLz7wV1ShQ5yNfwRss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mjsLUnBj; arc=none smtp.client-ip=91.218.175.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mjsLUnBj"
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cbH3JYvqlDpyYTN0NgAeZSXpYyTEo/j3lBZbAtwH0nQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790822014; v=1; x=1791426814;
 b=mjsLUnBjBUUwPSEy8KHj9gphd3r92ca3Y7C1dBFv8oSMrD1eciLn3JDtet6Nx34YTEcPF8w1
 s82Pf79xxJ1IWndAHqwPmaYvi9VwfsDIG7mevHCxbg1C/GImMOG+vHLon8Tp15/NJgXIA6SEH3+
 WO41M+kX8YVlIFF903SxX7DU=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 796f1b244d11ec4b;
	Thu, 01 Oct 2026 02:33:34 +0000
X-Mizu-Trace-ID: 796f1b244d11ec4b
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
In-Reply-To: <d4fac8af-fd71-47a2-bfe9-3c6559b92209@kernel.org>
Date: Thu, 1 Oct 2026 10:33:16 +0800
Cc: Lance Yang <lance.yang@linux.dev>,
 osalvador@suse.de,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <203892F4-B04A-4F69-A1B3-DC1619176C67@linux.dev>
References: <20260930160432.5564-1-lance.yang@linux.dev>
 <d4fac8af-fd71-47a2-bfe9-3c6559b92209@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Oct 1, 2026, at 00:46, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/30/26 18:04, Lance Yang wrote:
>> __add_pages() returns on a sparse_add_section() failure without =
removing
>> the sections already added in the same request.
>>=20
>> For memremap_pages(), the failed range is not counted in =
pgmap->nr_range,
>> so memunmap_pages() skips it. The sections already added in that =
range
>> retain their vmemmap mappings and subsection bits. Retrying a
>> section-aligned range can then fail with -EEXIST.
>>=20
>> Save the initial PFN and remove [start_pfn, pfn) on failure. For a =
vmemmap
>> population failure, section_activate() already cleans up the current
>> section, so the rollback excludes it. If the first section fails,
>> __remove_pages() receives an empty range and does nothing.
>>=20
>> Link: =
https://lore.kernel.org/all/BAD58999-1EDD-4A37-ABA0-DB1BD8AB3453@linux.dev=
/
>> Suggested-by: Muchun Song <muchun.song@linux.dev>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>> No Fixes tag, as I couldn't identify the commit that introduced this =
issue.
>>=20
>> mm/memory_hotplug.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 796af1028ee2..ca4656698148 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -380,6 +380,7 @@ EXPORT_SYMBOL_GPL(pfn_to_online_page);
>> int __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>> struct mhp_params *params)
>> {
>> + 	const unsigned long start_pfn =3D pfn;
>> 	const unsigned long end_pfn =3D pfn + nr_pages;
>> 	unsigned long cur_nr_pages;
>> 	int err;
>> @@ -413,8 +414,11 @@ int __add_pages(int nid, unsigned long pfn, =
unsigned long nr_pages,
>>    SECTION_ALIGN_UP(pfn + 1) - pfn);
>> 		err =3D sparse_add_section(nid, pfn, cur_nr_pages, =
altmap,
>>  					params->pgmap);
>> - 		if (err)
>> + 		if (err) {
>> + 			__remove_pages(start_pfn, pfn - start_pfn, =
altmap,
>> + 				       params->pgmap);
>> 			break;
>> + 		}
>> 		cond_resched();
>> 	}
>> 	vmemmap_populate_print_last();
>=20
> Makes sense and LGTM.
>=20
> Do we have a Fixes: tag? It probably dates back quite a while ... not =
sure about
> stable, we never saw this in practice. But if it's easy, we should =
just do it?
> (not sure if we ever had __remove_pages be limited to hotunplug =
support)
>=20
> I'm planning on picking this up and sending it for the next merge =
window (so not
> as a hotfix).
>=20
> Looking at this ...
>=20
> x86 does not really expect add_pages to fail:
>=20
> ret =3D __add_pages(nid, start_pfn, nr_pages, params);
> WARN_ON_ONCE(ret);
>=20
> That's probably something to clean up as well?

The warning is a historical leftover. The original code
printed an error when __add_pages() failed. Commit
10f22dde556d accidentally turned that conditional printk
into an unconditional WARN_ON(1), and commit fe8b868eccb9
subsequently changed it to WARN_ON_ONCE(ret) to avoid
warning on successful memory hot-add.

There is no no-failure contract here: __add_pages() can
legitimately return errors such as -ENOMEM, and those
errors are already propagated to the caller. Since
WARN_ON_ONCE(ret) has no effect on control flow or error
handling, it can be safely removed without changing the
failure semantics.

This also reveals a potential bug introduced by commit
ea0854170c952: when update_end_of_memory_vars() was
added, it was called without checking that ret =3D=3D 0, so the
end-of-memory variables may be updated even when
__add_pages() fails. Returning immediately on error fixes
that as well.

Thanks,
Muchun

>=20
> --=20
> Cheers,
>=20
> David


