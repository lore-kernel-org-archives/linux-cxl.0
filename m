Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794020504;
	b=Yy6wmqFMxTD9R83kxRb9vlLfbR+sCMtRPTVlm7PN1H6P3JyhTE1YchijM3SQzWI7VT/p
	 IXs21+BdFMByxUIIEzIc610GMQKwYqVZLWvLUUgV5ZzOzsqCofzJYLJ06LDFpu+gXNkRd
	 AyLv+YWF7xiLiqzNRf/JjvV1Zom24WM9dDK5BHT+w1bwP5w3SZZIHVOs9gumIklyaigEl
	 UAs05FwoZhSO4v1X9wn2+8qLLipKE/Omcjyq/DKAKKHpN4LcXvcLUrTn11i2Wbx2CYWiA
	 ptHeQc7Z8j7lg4Eq4gJBZIwvAM/frnEXYeYzfIPriuheyJLrxnU2cMTsSfBxqxfie8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794020504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c7RdJd1ac0ZTEx+/NYzXEY+S8dr+3ZAZRK/h78/Mnrs=;
	b=Y+cv0pqpliH8XDUClXArS5uZQn87KQMKsboVWNNIXk6ze2EZfXXia4HEGBZgKUMYDCRS
	 u5wCXfIE8OOyx4j/iZUyX4yCpCFXdhgRGQsXFJ1earsNCrx8yDN7Rpr8f1vv/C5aq8Nz6
	 xFUdScgTd7Uy0Am86yFwQ3KQqmIjYQLrSCR1hAYvJtggOn9c9VYObkbP7kMFxeuENlqEJ
	 4aUWhOoMHIH8VUyk7nasuc/Y0OmM6GXWzuHJDO47HHx4wDErEOm0Eh79Pkpc2KB0NOITd
	 4vJtPizxu8qifZR04VLPvYsrnHGdi5sCtBs/ZDLCPuCsHbi+AGcWxxZ3MDbJnT5Rj7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EXL7qNvo;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B6606A32F
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 03:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 983B6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=EXL7qNvo
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1512253c88.0
        for <linux-cxl@vger.kernel.org>; Fri, 06 Nov 2026 19:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794020503; x=1794625303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7RdJd1ac0ZTEx+/NYzXEY+S8dr+3ZAZRK/h78/Mnrs=;
        b=EXL7qNvoixipFHmUbTzJDnVPsqgi4j4biZQDDbJ1xQAQJHf2NXHxgCekVjOp/+aZVb
         yp6VqeTgewe26Myz7al0S2vSkb77+amT1dxIRHwQ2MBO2lT6wQK6EdXfpzk6bOnKZFHf
         1FPyaVZYqU9QWAvjgfe0vPkEPQW+O0CUwWAB8c3jRbLOHFBBIig3mpQure4oPc+30D/W
         gDsmH7CpNhQ1Hs8QtINZSFd9o/aReNI9OLi0R1eyEFjaIJ/npVDPGcNoOm/sW+CjDmro
         EXWj1yBbGE43wfG7YU7UZNX/c730VtWabz1UQ+x6vtpqvv5/1OErICSYMxBJqWtH2VZX
         QhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794020503; x=1794625303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7RdJd1ac0ZTEx+/NYzXEY+S8dr+3ZAZRK/h78/Mnrs=;
        b=gz86+0eB4cCRn8EQHjuuxtVpnkkkWwZW/DMaELFA2L7I+8ZlPBm+KaFzI8EslmGJNJ
         bZXG+65KnM6Tvb3YsEAe3QHCyNkPpxMrOfJl0zgb+Py/rwdOyzEnMVguhXg6VrHUnJjr
         eMZoMXVnAmqMx7HMKp/GHtsOv9fzwvzWpXA2PG7p7NF6UqyXpwtYt+V/0fmIm0d6Q0FL
         BxzSpbGMBQzWb2VshUhXgwD7pfnB6cVMTimZs6KyUsvKA23em3LRznH3gIi0kNkQygPB
         6hZxyfvgMW7f98kOi45RO7mqdxQSjHX+BR8KrNl8NWc4e4+JQJAOpAeTXaIBxtie/uOA
         8w9w==
X-Forwarded-Encrypted: i=1; AKwUvByvoRMY8nP/egqGRGS1BsjZJlDSt8aazbRgdlL0oCg5iIt9sA5vsMh88zLLWSHC+a6yC92NfeStMdM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uCldRIMYfAwhLZyFNVQAQU2eIqHfw+ZMmaDTmVpKm78k4+Gcu
	LYvn1zytYqaoTZL30jkDNgUmjwviIa/EI2DcDy5ZRLBLqFpCW1Zq5YBOb6N2MlCnc/8=
X-Gm-Gg: AYBFou1pa7AS/g4wwqIokvtTk63t6mCuQRrUenKrQ/3F9/QcUGMXnTlZqFM3NZWmCUa
	5MmB7qs3MYbaF83hLBw1W+N555W0X0uUnVLieHfRY0WHz0uIQilWYTXQBJfmqCm33S7H/I1KoMj
	GBW6iBjHfv4zFgTWf8j8EBaf6Hxye6LyCbFnFkd7afzKOGQy0YFd8yQnwwGWwKLIf6zAD5iIBxg
	I4WVqtT7zm0ahigVVjaAR7z8USRWe3NwYYwax6FD4uq6VPerYBP/NXk2m8zfpt1q/DXrLoq3qPN
	mYORvoM7mpuoeCeADzpF0ES5QQvortHI4Mw4cI0dgEEcTAnOeqSUldMzU4oXhJc+2tfQ8Wk/MD3
	qIEWfFhWlMmeYkWDkt716h3BN4f9KO0rKVX5pa/tW2YvBaSoPViCRB8tdR4LOgbyRLOFllNDKMp
	Y8RC1HkMqBiPdPCtLssRNeT14stBm1ooACbWg1H+JhruMRKkcXguvbNhkXrfcmEBLxuIPq5pSRk
	W3cAP8zvFTpaqt1rf4aJp2WfmKI1iCor8EJk+2p+Y9v+hGfzFb+qvPrUyAodQtp08XOLi0e9uJe
	esn/ZxnjABFzUNNMBYFavMWONJUmloDfGtN6pwkRxhk7RX8tk6Z5a2BRDHKMGg==
X-Received: by 2002:a05:7023:a5a:b0:1a0:e3e2:22a3 with SMTP id a92af1059eb24-1b25d33a590mr5333663c88.31.1794020502203;
        Fri, 06 Nov 2026 19:01:42 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4b4aa7sm9534473c88.13.2026.11.06.19.01.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:01:40 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Pavithra Prakash <pavrampu@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>,
	stable@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] dax/pmem: fix unaligned compound devmap initialization
Date: Sat,  7 Nov 2026 11:01:26 +0800
Message-ID: <20261107030126.90894-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static pmem Device DAX namespaces reserve space for namespace metadata
before the user-visible data range, and may also include padding needed
to satisfy the Device DAX alignment. __dax_pmem_probe() adjusts the
dax_region range to start at the data range, but the dev_pagemap range
still starts at the beginning of the namespace.

That is not valid for compound devmap mappings whose memmap is stored in
system RAM. Compound page initialization requires the start PFN to be
naturally aligned to the compound page size, because the head and tail
struct pages are initialized according to that geometry. If the pgmap
starts before the aligned data range, memmap_init_zone_device() can build
compound page metadata from an unaligned PFN.

The resulting struct page layout is inconsistent with the Device DAX
mapping. A later mmap fault can then resolve the user-visible PFN through
invalid compound page metadata and hit a kernel panic while inserting the
DAX folio.

Fix this by rounding the pgmap start up to the Device DAX alignment for
non-altmap mappings. This gives compound mappings the required naturally
aligned start while retaining full-section vmemmap savings when the
original start is already aligned. The altmap path remains unchanged
because memmap_init_zone_device() skips the altmap reservation itself.

Fixes: 14606001efb4 ("device-dax: compound devmap support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Closes: https://lore.kernel.org/r/wlrkqqvg.ritesh.list@gmail.com
---
v2:
- Round the pgmap start up to the Device DAX alignment to retain
  full-section vmemmap savings (suggested by Alison Schofield)
- Update the commit message to describe the alignment approach

v1: https://lore.kernel.org/20261016054914.2601510-1-songmuchun@bytedance.com/
---
 drivers/dax/pmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..d54d23f1cc58 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -51,6 +51,12 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	/* adjust the dax_region range to the start of data */
 	range = pgmap.range;
 	range.start += offset;
+	/*
+	 * When the memmap is stored in RAM, compound page initialization
+	 * must start at a naturally aligned address.
+	 */
+	if (!pgmap_altmap(&pgmap))
+		pgmap.range.start = ALIGN(pgmap.range.start, nd_pfn->align);
 	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
 			IORESOURCE_DAX_STATIC);

base-commit: a91337fb5e8e0127c8b5be87be9f3027f95b48bc
-- 
2.54.0

