Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935395;
	b=DuIa8fOYaib9jmIwsdPO5R4nmvHxS13Pe9VRzH3M1Qr2i+X/A1bFWAWC2NKsn73+a8fR
	 Pc3EARM8OFTCnquGJCx00tBScy+8QsHACRKYpDz3eSnI304bUAGcG30DIvUoZnQEbvWt1
	 2Nfq5FcjkgfrwWVP+C/KX7jJcieHK73uHzrVLWe2zjOi/LcCf09u+fzh5ObJQjhzqORWq
	 lXnP93VAljQdHKzvZGh2PgstmaHdrQ+9PeHHTJMs5PJct1PQg7cpZI4J0KWLsUNOe0x/Y
	 AFKRHZeAyGDafvk1ZSmENJalvkM3g3J8MyPRFoAbrCGGIVQgxjsslHuY9TTtBMIFDWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935395;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=emPbxkg0/5QWmcFNHB+2nCw1B2TwiWmUMmFbNjnQBT4=;
	b=Lbemf2RLFMlaE9t334YEcfn33XHsD4e7GmMocEbT9eEwmANMXWn2p9b+5P0AHrwlpCry
	 HA3VWs9YeE/3IfJpbUg9GcEQ9P4GNpKEgZh5x4CQhDd/PqLagL9om1iWwHWRQOd07SI7v
	 IItD9mAccRYFi/6Cm8kB/HWC0Uao0JqRDyLXGaB0ZIrwlDZblifR3a4c3pIl3bs+vy3V5
	 DdXcIzTTo+Oi/PRxRRyA0Vmy0jbmk1AgDzVLFH25zB0WSBdDoybOM+HnH1cB9BbA2TjgJ
	 GQkgRhFLqyxbZzP5rSMsynBtjEyqHrTzR3tsvFpbHJPQuQPELFS06whIskZ9xoqE7Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XOoYdaIE;
	arc=none smtp.remote-ip=95.215.58.223
Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA1606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 03:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87AA1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XOoYdaIE
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1iTUSdXTCVsjLijjuHlyn2Zs0ncBSwD81Jn4H+YS6Ek=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793935387; v=1; x=1794540187;
 b=XOoYdaIEO1PLcALd/MslMlMLSoiXfEn/R03bC1W01fF6dOSyhsIhLi5+VnlHEhz5jDJ5wRZA
 TqUx77Ia0un0XKqmsjcvn0wIJFk6AbjbNbPAWP1MUHLArebQg+IZp+JjDFE0Bi9sNF9nOoxDuzi
 bjUgGZ24dTno5+8HURzNynMk=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 01a3aaa1f1fe2691;
	Fri, 06 Nov 2026 03:23:07 +0000
X-Mizu-Trace-ID: 01a3aaa1f1fe2691
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] dax/pmem: fix unaligned compound devmap initialization
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <au0KLseDt4S6b1ME@aschofie-mobl2.lan>
Date: Fri, 6 Nov 2026 11:22:49 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Joao Martins <joao.m.martins@oracle.com>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 stable@vger.kernel.org,
 nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <75814BF9-8CC1-44BC-AB72-94EC5985A39D@linux.dev>
References: <20261016054914.2601510-1-songmuchun@bytedance.com>
 <au0KLseDt4S6b1ME@aschofie-mobl2.lan>
To: Alison Schofield <alison.schofield@intel.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 6, 2026, at 06:58, Alison Schofield =
<alison.schofield@intel.com> wrote:
>=20
> On Fri, Oct 16, 2026 at 01:49:14PM +0800, Muchun Song wrote:
>> Static pmem Device DAX namespaces reserve space for namespace =
metadata
>> before the user-visible data range, and may also include padding =
needed
>> to satisfy the Device DAX alignment. __dax_pmem_probe() adjusts the
>> dax_region range to start at the data range, but the dev_pagemap =
range
>> still starts at the beginning of the namespace.
>>=20
>> That is not valid for compound devmap mappings whose memmap is stored =
in
>> system RAM. Compound page initialization requires the start PFN to be
>> naturally aligned to the compound page size, because the head and =
tail
>> struct pages are initialized according to that geometry. If the pgmap
>> starts before the aligned data range, memmap_init_zone_device() can =
build
>> compound page metadata from an unaligned PFN.
>>=20
>> The resulting struct page layout is inconsistent with the Device DAX
>> mapping. A later mmap fault can then resolve the user-visible PFN =
through
>> invalid compound page metadata and hit a kernel panic while inserting =
the
>> DAX folio.
>>=20
>> Fix this by advancing the pgmap start to the aligned Device DAX data
>> range for non-altmap compound mappings. Leave base-page namespaces
>> unchanged, and leave the altmap path unchanged because
>> memmap_init_zone_device() already skips the altmap reservation =
itself.
>>=20
>> Fixes: 14606001efb4 ("device-dax: compound devmap support")
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Closes: https://lore.kernel.org/r/wlrkqqvg.ritesh.list@gmail.com
>> Assisted-by: LLM
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> drivers/dax/pmem.c | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>=20
>> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
>> index bee93066a849..d3a9b85107b0 100644
>> --- a/drivers/dax/pmem.c
>> +++ b/drivers/dax/pmem.c
>> @@ -51,6 +51,13 @@ static struct dev_dax *__dax_pmem_probe(struct =
device *dev)
>> 	/* adjust the dax_region range to the start of data */
>> 	range =3D pgmap.range;
>> 	range.start +=3D offset;
>> +	/*
>> +	 * When the memmap is stored in RAM, exclude metadata and =
alignment
>> +	 * padding from compound page initialization.  Otherwise, the =
pgmap
>> +	 * may start before the naturally aligned Device DAX data range.
>> +	 */
>> +	if (!pgmap_altmap(&pgmap) && le32_to_cpu(pfn_sb->align) > =
PAGE_SIZE)
>> +	pgmap.range.start =3D range.start;
>=20
>=20
> Hi Muchun,

Hi,

>=20
> Does moving the start here lose vmemmap savings when the old start
> was already aligned? ie. on x86_64 with -M mem and 2M alignment, a
> namespace starting on a 128M section boundary has its data at +2M. The
> first section then becomes a partial add, which 2ef77f4a7d5a
> ("mm/sparse-vmemmap: set compound page order for device DAX") doesn't
> optimize. Would that cost about 1.7 MiB of extra vmemmap?
>=20
> Can you round the original pgmap start up to the alignment to avoid
> that loss, and still fix the crash?

Yes, you are right. Rounding up the original pgmap start still fixes
the crash without losing the vmemmap savings. I'll use the following
change for v2.

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index d3a9b85107b0..d54d23f1cc58 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -52,12 +52,11 @@ static struct dev_dax *__dax_pmem_probe(struct =
device *dev)
        range =3D pgmap.range;
        range.start +=3D offset;
        /*
-        * When the memmap is stored in RAM, exclude metadata and =
alignment
-        * padding from compound page initialization.  Otherwise, the =
pgmap
-        * may start before the naturally aligned Device DAX data range.
+        * When the memmap is stored in RAM, compound page =
initialization
+        * must start at a naturally aligned address.
         */
-       if (!pgmap_altmap(&pgmap) && le32_to_cpu(pfn_sb->align) > =
PAGE_SIZE)
-               pgmap.range.start =3D range.start;
+       if (!pgmap_altmap(&pgmap))
+               pgmap.range.start =3D ALIGN(pgmap.range.start, =
nd_pfn->align);
        dax_region =3D alloc_dax_region(dev, region_id, &range,
                        nd_region->target_node, =
le32_to_cpu(pfn_sb->align),
                        IORESOURCE_DAX_STATIC);

Thanks,
Muchun

>=20
> -- Alison
>=20
>=20
>=20
>> 	dax_region =3D alloc_dax_region(dev, region_id, &range,
>> 			nd_region->target_node, =
le32_to_cpu(pfn_sb->align),
>> 			IORESOURCE_DAX_STATIC);
>>=20
>> base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
>> --=20
>> 2.54.0


