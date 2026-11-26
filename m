Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660557;
	b=IcpXzkwZg3LPoSAz58SqMVTnW7VVJqRICdh65Tox0n0V8t9tnEyq3wRBCjpwRT2wVn+Q
	 pLeNIFbUo/yvoC6li7ds9mMOv/LR8C7u6XcUP9Vqlu+IzQHHcBTlVJyOa8uN/imMhd5s8
	 RKTl5Vu7is/2zyRhB1g/y3O56GN8m80b23qJBj8z9Rz7mGVsl1sPaQLl0flPJQfX7qREH
	 1L1qDTPMA3eER7j1EZeYMPnGNZA1xqlTcCAu1754uMajQgN0lgDd+ikXM255dcqPItqnB
	 zQJEV7kAWnzUiPm144XnlwmndhpKxM8t1/ORFwynJH4IAiY2kVjhqEqSeYnKdC+c9Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660557;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oAUPMN5BwpiBiOVIjy6/1EXKeR6EBy8T6wvaSzK4OqM=;
	b=oQUxKWYJNVJF3gWVApfx3+HGVtgAJZcbaAuHcYRoB3c2JfxWAPXDOkODeIGGXeYW52po
	 p1yuRVg4ICHRdewgfDuZzpa4RdDTk2n2AwVdzORhZ8pks4y96xnmarbh01Z+yb7Ca0+Ky
	 WQti/+6X7wmHJWYFzooY40WrQeIjtVs9zwAhMehFkSvTuO/9RCGyKAkcTHCctaR8mKpe7
	 Q8OgX2vIwMbFfhIibBE/kZHGb7lXYI8wouKIhQJL/p8+DjDEykfx1NrN/wyM3fwXGNTvn
	 CWmNU6/pQ1/YG+lYkjsxiO58tFKDNrC6NpdxCzTpbzDXos7ECu15NcIh31RYbOeYPZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C51606A326
	for <linux-cxl@vger.kernel.org>; Thu, 26 Nov 2026 02:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-386c71feeeaso2873790eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 18:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660556; x=1796265356;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oAUPMN5BwpiBiOVIjy6/1EXKeR6EBy8T6wvaSzK4OqM=;
        b=bH7G4oGleLB5sIjxNAfLCVKUT30stBku6asrEuKf3+uY0yxrW/tMlWAGN0V+YVhnON
         KofCoGsJA70hFXqD0hsGDUhbgkLlodmA08oUQmMKxCPBdZHDoAzOEgMrnVPfgJPa8lr5
         x8joAIE7OQJt6R2IcEI0fpJ9nQc7o1zfAt9s0Kiqvm7sBePG92h/PLAxxFxBfUfYMLBu
         J622MLTe5u/lxnh2EZ9koa5lkmernpWCj8kMRxDiqy5JiblmaNcFhslfJD9Z1KFGj75W
         wC0NWa2Y3Q7Eql7ePv5XWeP/5usB2D3Kcuaru+pncLb9dHkkXzI8JoRFUEJQFPcDpW81
         EhmA==
X-Forwarded-Encrypted: i=1; AL+hErEoaouay3eWQf6jJ5ibZ/CwZhsxMYKnj7nOJrxdlaibsRbQzGqkRwTA2KDsnxzMkNpbNG6u2HOvqec=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mYYlTfoozbqY4rxOr9S7hWRjjbX4v5VLUKNYNl5ukZw1+7kvC
	bN2A6AzWHzcGy1NfCTK4oAEaJ0vx9iNmK6ATo6yJTj+oNrlZgFoDmXUqChiZnIeR6ISa
X-Gm-Gg: AZFdTZfW3LnVBFahqBk/n+iZO81ecE9lojdSY/kMWjvWcyahM2yQ01B5T8zK+hgg3EF
	bXbe3B8UlshiWtOdFLKLknEzRx3Z2zn8rrwXZ6+ZnRNTB2+imZzzWaAEOrxy0JNO9AkbCwlOm4C
	5gOIoqxjkXCLNIOkLSmfL7XakBzG8SEEIhhLK+wIMOqhjGRcXPIcxjC3saEruiqZahbTJoqe55A
	6HWzJMub9A6HgOMlZ5A/qGUo8yNRMC6EuNg0TB6CU3IZGQOzAVII9+CpLHJeg+fHL121AolKAcC
	gr1Knwo+VH3Xhq6avn2drYkX71trI78j4+zG+5Ltps6ySiN6EhrA3wmFtMAtvzAXApYyEWQbfRU
	VYJQ4fu/wCkLj1X8Ciawb7C5WQvyWIZy78GtIliED3zrEw2tCzUh1jzbCJqmKPjwkZjjWCuHNmO
	uyKFwbwsNaQoVAlXYkHFur5OMjRvFEE2qq+u70mdY2OINaCkoQgf6KQd5bp0XhC2XEwm17eCwDO
	JV1CHT06tZj2cZp/LknWXSmkPdDCC74UctNCzF+9c/cc2KWLcjrfPc5ZTlPCTJDo+Cn0wArBAiT
	oTqEtrxz5GqpKQ2WB4mXc5cbw+Y51qp+lBttTkVg99itsEoyaA==
X-Received: by 2002:a05:693c:4143:10b0:36a:1f4f:3e9 with SMTP id 5a478bee46e88-386b1067bf5mr12715979eec.20.1795660555606;
        Wed, 25 Nov 2026 18:35:55 -0800 (PST)
Received: from alanui-MacBookPro.local ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26703230eec.27.2026.11.25.18.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2026 18:35:54 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Michal Schmidt <mschmidt@redhat.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/3] cxl/edac: Skip event records marked NOT_REPAIRABLE
Date: Thu, 26 Nov 2026 11:35:22 +0900
Message-ID: <20261126023520.39368-3-ai@linux.com>
In-Reply-To: <20261126023520.39368-1-ai@linux.com>
References: <20261126023520.39368-1-ai@linux.com>
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

Skip NOT_REPAIRABLE records in both lookups, so these records cannot
satisfy the cached-event requirement for an online repair. The trace
events already show dpa_flags='NOT_REPAIRABLE' for them, so user space
can tell before it asks for a repair.

The next patch keys the records by the masked DPA. After that, the DPA
from the trace event matches these records too, so the check has to be
in place first.

cxl_find_rec_gen_media() now reads the record, so take the xarray lock
there too, as cxl_find_rec_dram() does. Its only caller just checks the
result, so make it return bool and rename it to
cxl_check_for_rec_gen_media().

Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Jongwon Lee <ai@linux.com>
---
 drivers/cxl/core/edac.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index bd217dccf119..7aaf1242ba2f 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -925,24 +925,30 @@ struct cxl_mem_repair_attrbs {
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
+static bool cxl_check_for_rec_gen_media(struct cxl_memdev *cxlmd,
+					struct cxl_mem_repair_attrbs *attrbs)
 {
 	struct cxl_mem_err_rec *array_rec = cxlmd->err_rec_array;
 	struct cxl_event_gen_media *rec;
+	bool found;
 
 	if (!array_rec)
-		return NULL;
+		return false;
 
-	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
-	if (!rec)
-		return NULL;
+	if (attrbs->repair_type != CXL_PPR)
+		return false;
 
-	if (attrbs->repair_type == CXL_PPR)
-		return rec;
+	xa_lock(&array_rec->rec_gen_media);
+	rec = xa_load(&array_rec->rec_gen_media, attrbs->dpa);
+	found = rec && !cxl_rec_not_repairable(&rec->media_hdr);
+	xa_unlock(&array_rec->rec_gen_media);
 
-	return NULL;
+	return found;
 }
 
 /* Caller holds the xarray lock. The record may be freed once it is dropped. */
@@ -956,7 +962,7 @@ __cxl_find_rec_dram(struct xarray *rec_xarray,
 	lockdep_assert_held(&rec_xarray->xa_lock);
 
 	rec = xa_load(rec_xarray, attrbs->dpa);
-	if (!rec)
+	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
 		return NULL;
 
 	validity_flags = get_unaligned_le16(rec->media_hdr.validity_flags);
@@ -1845,7 +1851,7 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
 			attrbs.dpa = cxl_ppr_ctx->dpa;
 			attrbs.nibble_mask = cxl_ppr_ctx->nibble_mask;
 			if (!cxl_find_rec_dram(cxlmd, &attrbs, NULL) &&
-			    !cxl_find_rec_gen_media(cxlmd, &attrbs))
+			    !cxl_check_for_rec_gen_media(cxlmd, &attrbs))
 				return -EINVAL;
 		}
 	}
-- 
2.55.0

