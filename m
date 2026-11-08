Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104441;
	b=gy+Giem7ksZwHb49FcPRmHsHmHX79rpWw0IYbe+Y8rN5ePZJafojOpEPkGR2mT5LShkc
	 Xt7oNUTPn1OQv2yrPiTlV4C9NlZAYPaqNJ3KiSVa5O0yNSu335aQgjGrIbPUI8EYx8Hyh
	 ZVky6mX6VOWwE0BQDfaCcH2H/Xkq7ZFpJYiA0UjMK0dXyYPzUqug+LX2HYur4ho+/7U66
	 9EtmAu0y88ubr+s1hY8vYp9b/jpkwTOPDl2mYTKqLdFQa0/Z/756K7K6yuI9S8E423Qft
	 5tSopv32mX1EaGwZOH8q/Y0suiqTMEdFLHOeJYv9aXPJhIRyVkqcEVvxVoqXLidi/tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104441;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SrIhumD197mx4pl6yQkiB2jctqSFaHU4JKWvTq2PlBQ=;
	b=C/ZZ/Tc2vc8Iu9tevF2nP6gdVLb/ICDu2xJSS5oMDj4zLnqmkAu4SRzfhw9R2sNpf0wb
	 e+mrvBiOJ7UmvE/cW3hvwhzsRBFLRy8PnbPrMx4K6deXF13i/wvTRFbyYrdOtux4sOsaW
	 xKwfDcfi2PspXwPF+sGW8BhQ0nZwTBTV1MK4+GWMx1+0HHExVH4NITRlQFq7e1Cu81HVj
	 YM7SS11i+d/o9BzxHhY2xkrNFGdSJXVhVokhU1a/Oz5QTvjKIx7jvr+MBCwSp47zmSRlo
	 2CiQ+DIHgqpKgubzXeUTRvxtP5sSDpft23JvhXu64hiyxArBinPi8Tc8MvIp+VrJZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732BA606A31C
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 02:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 732BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14394530ec6so123747c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 18:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104441; x=1794709241;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SrIhumD197mx4pl6yQkiB2jctqSFaHU4JKWvTq2PlBQ=;
        b=q/XNwjFJ6kMKF3ifEBa8Bmbp1fbFFYdxs+tVbP3DbuVt91SysLgLStxcbmL8nrNCnx
         yiEfAbsDfUyJLpAdI82lTuAT28yHFb5m+1FM0aQlMgwb0DO2IoRU2ATo6tg5hzWk7zs8
         3n6KE4iap9SBe8/hbE/FpQ/R9Fm0e4KkuoSz7o/5X1zE0VDvbzbkEQPkfX5M2O1UnRhF
         bt16gjXFDlhvjUwld08wVjPwP9QGMr+tS6gX/pjPXygO0rgcmggvYPNT48sagQVLE4Dm
         6Ir0OBPBltSZny3XYhtayk/KVqFqdoET7qEj8+1UkYerT4S+5iUc4KpZzp3cOkJYbmve
         QKtA==
X-Forwarded-Encrypted: i=1; AKwUvBxMC/ryAbAFBiuebA/ZBK3MwSnFop/8Pz5katvmuDhUf+0cgp1HAQPm5CZsdB5OiKdBczSW2zuQqx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FhzmjmOTISrKvCUqMWJfvZScLUCG6p/tXlzJPwCPaqcKCwmOs
	vktu2VeJ4W8fjIqhrgIfRpb2nGMDILiu7NKwc8VXC4ZmVqH4ZcR/J8IMofuTygn1S1/Z
X-Gm-Gg: AYBFou0i+ceqfvAWv6TKJZfIUfyoSWu6y1P1ivYsBv4SxsvejFFJCznvushzX+wXAP6
	jsPhbd7jjTG4D3phfH4rXXQJ6wg5ipotgoH9keUkvXgxO8O5TUbzO2vF+naVxXvD4vJ3gzSGt2M
	72nwj0iwWz51OiktaFgSbXGRvFdwAtJQuLuGT3/N+OdZsqe8dumTgOmMsu250ScylE+aTc6Nrrg
	7Ot6q9YjybDKq+27x8sxAJFL8cl9ydHoUzyIx5IVHrCNIAStkSsNEQYeiX9YuiRbyoWaZ+dhelQ
	s6nRAdTabxyH+WiHIgO6pOZrdwKAO0o0ilGx4nARmi4kanKlOMuY/ZeDE/rQEJXioqryneGkyGF
	XqF7wwLgWo/Sm5rA0RXWzYnRKJegkuXBC97IjnDrfLkBU6tRZuJg4lNfLG298krVFCssvIGgw7r
	X3eCKs0KltdWMedy/XXU+m+H4xYuaZWDdUETnlRmSnW8dHBGeorfZ1ZK+ngoI0IGk9Cd9A3cePu
	ZhHUGARYQJMo8bOcg/A1TSr1xGVswl8q8na8Tjo3DKDMA5HmJvObvj5jK0pPQhKfRgE2XQllbjB
	TBQ26oMsjYWJ20/3OIj4qOmcfs1ksiutUNJEu1CyFgUyIxEy9BkvTsrzPA/DZzeVeKun3GDg/Zy
	qAuJ9/1b2Yz+8By/wFqcZHutRHc4Trge6cHqIXPE=
X-Received: by 2002:a05:7022:1586:b0:1a8:b566:80c2 with SMTP id a92af1059eb24-1b39fed11a6mr498579c88.17.1794104440609;
        Sat, 07 Nov 2026 18:20:40 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm3027961c88.1.2026.11.07.18.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Nov 2026 18:20:40 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] cxl/edac: Mask DPA flags in the event record cache key
Date: Sun, 08 Nov 2026 11:20:25 +0900
Message-ID: <20261108022022.3352-4-ai@linux.com>
In-Reply-To: <20261108022022.3352-1-ai@linux.com>
References: <20261108022022.3352-1-ai@linux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The low bits of the DPA field in General Media and DRAM event records
are flags. Bit 0 is VOLATILE and bit 1 is NOT_REPAIRABLE. The trace
events print the DPA with CXL_DPA_MASK applied, while
cxl_store_rec_gen_media() and cxl_store_rec_dram() use the raw value as
the xarray key.

User space takes the DPA from the trace event and writes it to the
mem_repair dpa attribute. If the record has any flag set, xa_load() does
not find it and the repair fails with -EINVAL.

Use the masked DPA as the key. Records marked NOT_REPAIRABLE are still
rejected, because the lookup skips them.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 42683b7c54..f627c73ff6 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -918,6 +918,16 @@ struct cxl_mem_repair_attrbs {
 	enum cxl_mem_repair_type repair_type;
 };
 
+/*
+ * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRABLE).
+ * Records are looked up by the DPA user space writes back, which comes from
+ * the trace event and has the flags masked off, so key them the same way.
+ */
+static inline unsigned long cxl_rec_dpa(const struct cxl_event_media_hdr *hdr)
+{
+	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
+}
+
 static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
 {
 	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
@@ -1131,8 +1141,7 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_gen_media,
-			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
-			   GFP_KERNEL);
+			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
@@ -1161,8 +1170,7 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
 		return -ENOMEM;
 
 	old_rec = xa_store(&array_rec->rec_dram,
-			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
-			   GFP_KERNEL);
+			   cxl_rec_dpa(&rec->media_hdr), rec, GFP_KERNEL);
 	if (xa_is_err(old_rec)) {
 		kfree(rec);
 		return xa_err(old_rec);
-- 
2.55.0

