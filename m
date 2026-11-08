Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794104437;
	b=KBrFpL2hFu4vLmQvMcLUC4DMeT7bzxa3U7uidf1sTiiDYPd6NlfFHy7r5ll90XVNW3At
	 OW5Sqyt2SuBMWXug+En/0yXOtJ2xI5gl6vhCCzOhBVo98xWowd8ASeOqcFg+mSJuDKByP
	 ZDa0pduLxXWDU9rQY4sDYnPm2VlI8UMwJiFs5ykTaah+010nXT5H8+g9M1NquXBNWokhV
	 vOtAdioGMOwRf+Vd7xWbZn/rC+In28vUH+DIRH7BKIxL68ke9frHi9Ik8xlSgfOksQuHM
	 ycF24Ewq0/GOPUBmJLlvy+RfnYz4CMraHNwPEd0e+2mniKT8NLnqXTBTYJVMOkE1UmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794104437;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SYW4ZnGaz3QDrVdkhtkAhNL8qGxqKG9vxvJA64ntbyc=;
	b=Hxa832R5nDuf/0VUb4yPdQ1nKvEZhDrDnU9pMCqz+9lsV+YcT1+sj2lPquawLaKfl5kA
	 zQXRdaejlF9SD3l13+a03kXVJ8feAjGUUQ7xuBCiFVGPcFuAGax2NKS0UAeepuay/b1sY
	 OwT1o69Kh6sv/lSKgGa6Fs5jZSydRcehUSbLPVZfLKkN3m3V6/VKudbZajnmbWdj2OGSb
	 5o1Cre5gC0RVYTt0wvAtROGuSPbQU0UNAHMD5RzaAGrqkPp+bu9vT0O0Z/AFe/zLKAgv/
	 3gamP+NswGPGAU26WQF4QcsXZOUCbaWZQJBG1IAHTCKMR5JlhOFZW3zNEDP3R47h8Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A5606A31E
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 02:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D49A5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so189100c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 18:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794104436; x=1794709236;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SYW4ZnGaz3QDrVdkhtkAhNL8qGxqKG9vxvJA64ntbyc=;
        b=B3hh/vA/nmgYXRBRes+cOnT65ByPELLgwGLg10gSzuCUw1rx9f3eFqk3BtKY7vLMTA
         xt7MW6tVLGj7ZTS6fbsUjkq6gOABzQrb5G7ZhWW/DjbzqjOgdaCmcT8R9j5H62QFQ+NM
         CX4FLs57fnkVSuzWHKmlaSso64ahLjNbERg12WACQA69TgVKIh7pjyjT6REu1xSoZ/3Z
         ndnKwVTI1dwRDE1Hy6zNaB7WaaIkr/RXlBYbJpwvI2XYItFBPTXeyeEUpefvVdTTUpat
         sNNGkf+4N3mgIHLKGHLNCTsruviGK2XvywkyWggj+QEO88tACXPhilcQ/NxTS26cgDZG
         zxZw==
X-Forwarded-Encrypted: i=1; AKwUvBwD3oy8gW6WWh6GWCOizUZKIhkdjT+Ot1kKEjSG+Itmx/PnZWbQevNo4+1ZqCO6FIwHPBeXjk1mXdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z0MzT4y87JJC8pCo5wZb1E5Z0W8v0Licr7P0XOe7nfQ+Tifww
	LMTj+QUo35wn3EGfByqYtGsfhTsnFqM2+98yDIdUi/xJhRtr5GuoL9h9Pd9UVUs2YBPo
X-Gm-Gg: AYBFou0ispTJ/FT+FeS8q+fpXHtge4xtd/1cAdVsuNU3eNFZ17+obbXjyTWIDj4mDBj
	YQ6VxQOOmHwGykbnqT3oiaFLZFE7E+Jsat3PO5tRGTlRrKb3hdk2iWB8BGuOZrM2hZ+pbQ2NU1K
	ukIIgRuP5/I5auCOXmvXXv4Q2ESWppmgF45j2Qj1vBLfGnxDge/QdIsuNY5EpPAqQOh7UUYV4IE
	wLV08tKfWXwZAQKu4Dp0/CEmgpzjkrFuOGKTsob47TErlRtZB7BeyZKlJNe++VPlEIWlzP54DAp
	3TRknXtb8mQkU9MgEy0UKD4X3UOLHO6apUn2LD7ohpOsL2zk/6boFGDtCw3VZCFC3q0agJaeLSD
	9WSjLz0WZevbHRoT5iWcnMzXUH7surce8k8ThsGkO6g96MarvqZWYZ/3aaLtOIyLhYTSfdnPxpZ
	A5DH7/j2uQxnEayCaPN5ZgYhu9FFTSvv6J81ej8BDgD4Mae1RZVpp76Gu43eLtuXUXtOzqifEi1
	NXOdmFvEI8/nf7K8fdh7502ZgCGFcauIVdJEnM+ucUqQvBRGwlpLniW8/881sOyzVAzEmVkAzwK
	EvnupnoFqnAYqMqqOVhc7bY/lHBHDYVKTny1sbas3AxEZIggkJrbg10dkAu1/HzKV7Z6UbzPi90
	rA9oyC41t6WQx2isUuqrq7q5lzkwzbsTqSJugTL8=
X-Received: by 2002:a05:701b:2816:b0:17d:7b45:f927 with SMTP id a92af1059eb24-1b39febf479mr389625c88.33.1794104435796;
        Sat, 07 Nov 2026 18:20:35 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm3027961c88.1.2026.11.07.18.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Nov 2026 18:20:35 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] cxl/edac: Skip event records marked NOT_REPAIRABLE
Date: Sun, 08 Nov 2026 11:20:24 +0900
Message-ID: <20261108022022.3352-3-ai@linux.com>
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

Bit 1 of the DPA field in General Media and DRAM event records is the
NOT_REPAIRABLE flag. The device sets it when the memory at that DPA
cannot be repaired.

cxl_find_rec_gen_media() and cxl_find_rec_dram() do not check this flag.
A repair request that matches such a record passes the lookup and is
sent to the device. Since the records are keyed by the raw DPA, this
happens today when user space writes the DPA with bit 1 set.

Skip these records in both lookups, so the repair request fails with
-EINVAL. The trace events already show dpa_flags='NOT_REPAIRABLE' for
them, so user space can tell before it asks for a repair.

cxl_find_rec_gen_media() now reads the record, so take the xarray lock
there too, as cxl_find_rec_dram() does. Also make it return bool, since
its only caller just checks the result.

Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 4624ab4644..42683b7c54 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -918,24 +918,27 @@ struct cxl_mem_repair_attrbs {
 	enum cxl_mem_repair_type repair_type;
 };
 
-static struct cxl_event_gen_media *
-cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
-		       struct cxl_mem_repair_attrbs *attrbs)
+static inline bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
+{
+	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
+}
+
+static bool cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
+				   struct cxl_mem_repair_attrbs *attrbs)
 {
 	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
 	struct cxl_event_gen_media *rec;
+	bool found;
 
-	if (!array_rec)
-		return NULL;
+	if (!array_rec || attrbs->repair_type != CXL_PPR)
+		return false;
 
+	xa_lock(&array_rec->rec_gen_media);
 	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
-	if (!rec)
-		return NULL;
-
-	if (attrbs->repair_type == CXL_PPR)
-		return rec;
+	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
+	xa_unlock(&array_rec->rec_gen_media);
 
-	return NULL;
+	return found;
 }
 
 /* Caller holds the xarray lock. The record may be freed once it is dropped. */
@@ -949,7 +952,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
 	lockdep_assert_held(&rec_xarray->xa_lock);
 
 	rec = xa_load(rec_xarray, attrbs->dpa);
-	if (!rec)
+	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
 		return NULL;
 
 	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
-- 
2.55.0

