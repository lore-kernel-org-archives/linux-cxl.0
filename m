Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C09353A70
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649274; cv=none; b=tRShlBbRESeulVB1oCQXHFWwpgR2o4biyzzChcc88yVWgTW1IQRyGdy4ESBKdIWaT3MIjjCHBc95XyiekyhCT+xKQShPLl6ptzNgeXT6TIcICsD+5y0RtU9QxO+ziHcLZLLCAbI78l2nPMH73BKJJvsGpGoGH/cZ7o/5B4iUVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649274; c=relaxed/simple;
	bh=TuhJuG5GU5NO3aH3f6T9z0d0DxTiWj7zmgIgXAEy9Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApPizFp8i/y5FnreWPNfGaZMOMBnUgP7/Spo2gUN8CI1Qw7dcD9dBTVP3WAx+oK4jb7sD49tMXZXBuZBATr3ShrHXdJLZ64xn/90piKlEumtIj6y0nUFKGa8XZga9p28vdp2nHvbyojesEr924vAGPPnR0MVWRCpaarYQ3UExzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1N2ATni; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1N2ATni"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-16ad92569b5so611904c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791649272; x=1792254072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HD3NcIDPdwUreYfDUge++wJHXhKnRmGfEpR/CtJof+E=;
        b=g1N2ATnikM4BvLiYC5XWNKBHiYiHO/fabEX4Na2JDxytambUIvLWM78TIjkuqfLeqM
         hzZLaKcDmZXZdN9orXMIynOZkuHfdudVmILEjUo15vALeiDti2Rm/HX23wQevu6ZF9Vz
         XXHY1wVH4Y8kzNzfPJgZPOiBmdqJ85v6GoYJ23oX4DdTeplrWBy5iWUGK/72laU4PLDT
         MnssNveBc2RU6jBLZ4bluc5Z45pCo+JZj41hypBXyd5IrUDTmYd0meunnJj28Mjq7lgM
         J3vAeydRP1kRBw9AuzhuL4t2A8FFB37gfXRxHVFg5KjH01TogqgAxIt7vKUcPTG60cWr
         yoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791649272; x=1792254072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HD3NcIDPdwUreYfDUge++wJHXhKnRmGfEpR/CtJof+E=;
        b=Zc/YW33Anc8HPLGCCjeEuqqcsFdiCrZur7CQkF+cP1SmcMSD/beGg/3q23x4t+OUC3
         Eu9bW8DoNEBGpVsMySTWtoBRdJtYQyJDtAKkNSH54wJWKrQJWbvWo+jTJZ5ZNfxA9kSJ
         sRRJ1Dtq+crKs7orPJAOUs1iyDGSdDHHadfeTs//dD5+NtI7bLywmQY5fiID611im9x4
         9Z7Ez/+D00Xxv8PJomIYHURRxgwBz9X8S3kY9yS36yjnj5C0kVPeKG1IHDWx5eWOTvjZ
         O7Ov2k1TzE19xXFgnpu7j2O5mqG63PdLILmYPDqZirg/KfNQW/sDm7sX0u893NWVipnu
         JDkw==
X-Forwarded-Encrypted: i=1; AKwUvBzpOFIsujorhc0pZqaehkeoFd9F68S/aI0j9Sl8OOt3P0QK27sdQq7PqVI+jp9fB23NWuW/WBWLFwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo9rT9aiqaUvgSjb7XYQWrnEZHG4bKpgsKCuFyJjWysWztyXzv
	HyYbvU9PeI0+RB50KLRu4f3DjJuuUw3Rws1GGU9FGDHwc+mJnCRR5olR
X-Gm-Gg: AYBFou111esGE8BlsQKkyHgLAJ8K3k3KV6SoscB7iTd6bD4mH1rCtGDu5u2f77OlSd3
	bgFYp0RpH1S+eVr57ec0CPk8+k9XHUPTQNzUA98dW+oKy8ShhDfb3PYVKUmD4NjH76dAOboNfDh
	AOPN0aufkoWhNUzclpuZfhpIuJaa39tlXYuZVOJPkgy6hMqR6z/O0GOHxDbhVwmaJjtuT5faE6j
	JcvZCMS5gOeDjIVVsNSp1fx8/GClTH/8jjZFeQBbMtLwaSXhVtUL7SSBdcELxI6MbvFn8x6gc5y
	t50Q4JzX8fUC9Hz0e1deSgeqpI81Tm4NAsvMIQ2V4i7a/jKVzWS2QL4a9iBbpQ96ktaLhogJoar
	fH1AvlWyvQO2sRv5VB1jsAyr50azsQ7AqLdyjHVZjiL2P5wYEDMTduHZbHaSyBKxGRZ/JZefgnq
	6FIvtVrceGP+9CibzZP3KUISefegG31rQ3uU/v2V7z5KwF47PIwGGoaixw4Q4RZde3aTz86XvRf
	a82DdbG20QWSIOfAd2Au+GaMCnG
X-Received: by 2002:a05:7022:7f04:b0:13d:974:a2c6 with SMTP id a92af1059eb24-16a5ad07499mr5876271c88.7.1791649271910;
        Sat, 10 Oct 2026 09:21:11 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([115.96.176.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm15778622c88.14.2026.10.10.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:21:11 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [RFC PATCH 1/5] cxl/mbox: Add Get Poison List snapshot support
Date: Sat, 10 Oct 2026 21:50:09 +0530
Message-ID: <20261010162017.62506-2-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_mem_get_poison() uses a device-owned output buffer for each Get
Poison List response. It traces the records before issuing the next
command, which overwrites that buffer when the device sets the More
Media Error Records flag. A caller therefore cannot inspect the complete
set of collected records after the function returns.

Add a caller-owned snapshot and copy each validated mailbox response
into it. Preserve device overflow and scan-in-progress status, and
indicate when the host stops collection before retrieving all available
records.

Keep cxl_mem_get_poison() as the existing trace-only wrapper so its
current callers, including trigger_poison_list, retain their behavior.

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
 drivers/cxl/core/mbox.c | 137 ++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxlmem.h    |  25 ++++++++
 2 files changed, 156 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836c01..2752b46ffee2 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1376,14 +1376,91 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, "CXL");
 
-int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
-		       struct cxl_region *cxlr)
+int cxl_poison_snapshot_init(struct cxl_memdev *cxlmd,
+			     struct cxl_poison_snapshot *snapshot)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	u32 capacity = mds->poison.max_errors;
+
+	if (!snapshot)
+		return -EINVAL;
+	memset(snapshot, 0, sizeof(*snapshot));
+
+	if (!test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
+		return -EOPNOTSUPP;
+
+	if (!capacity)
+		return -EPROTO;
+
+	snapshot->records = kvmalloc_array(mds->poison.max_errors,
+					   sizeof(*snapshot->records),
+					   GFP_KERNEL);
+	if (!snapshot->records)
+		return -ENOMEM;
+
+	snapshot->capacity = capacity;
+
+	return 0;
+}
+
+void cxl_poison_snapshot_destroy(struct cxl_poison_snapshot *snapshot)
+{
+	if (!snapshot)
+		return;
+
+	kvfree(snapshot->records);
+	memset(snapshot, 0, sizeof(*snapshot));
+}
+
+static int cxl_poison_snapshot_append(struct cxl_poison_snapshot *snapshot,
+				      struct cxl_poison_record *records,
+				      u32 count)
+{
+	u32 available;
+
+	/*
+	 * Existing cxl_mem_get_poison() callers request tracing only and
+	 * pass no snapshot.
+	 */
+
+	if (!snapshot)
+		return 0;
+
+	if (!snapshot->records)
+		return -EINVAL;
+
+	if (snapshot->nr_records > snapshot->capacity)
+		return -EOVERFLOW;
+
+	if (!count)
+		return 0;
+
+	if (!records)
+		return -EINVAL;
+
+	available = snapshot->capacity - snapshot->nr_records;
+	if (count > available) {
+		snapshot->truncated = true;
+		return -ENOSPC;
+	}
+
+	memcpy(&snapshot->records[snapshot->nr_records], records,
+	       count * sizeof(*records));
+	snapshot->nr_records += count;
+
+	return 0;
+}
+
+static int cxl_mem_get_poison_common(struct cxl_memdev *cxlmd, u64 offset,
+				     u64 len, struct cxl_region *cxlr,
+				     struct cxl_poison_snapshot *snapshot)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_mbox_poison_out *po;
 	struct cxl_mbox_poison_in pi;
-	int nr_records = 0;
+	u32 nr_records = 0;
+	u32 count;
 	int rc;
 
 	ACQUIRE(mutex_intr, lock)(&mds->poison.mutex);
@@ -1408,29 +1485,77 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		if (!le16_to_cpu(po->count)) {
+		count = le16_to_cpu(po->count);
+		if (!count) {
 			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
+
+			if (po->flags & CXL_POISON_FLAG_MORE) {
+				if (snapshot)
+					snapshot->truncated = true;
+				rc = -EPROTO;
+			}
+
+			break;
+		}
+
+		if (struct_size(po, record, count) > mbox_cmd.size_out) {
+			dev_err(&cxlmd->dev,
+				"invalid poison record count: %u\n", count);
+			rc = -EPROTO;
 			break;
 		}
 
-		for (int i = 0; i < le16_to_cpu(po->count); i++)
+		for (u32 i = 0; i < count; i++)
 			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
 					 po->flags, po->overflow_ts,
 					 CXL_POISON_TRACE_LIST);
 
+		if (snapshot && (po->flags & CXL_POISON_FLAG_OVERFLOW)) {
+			snapshot->device_flags |= CXL_POISON_FLAG_OVERFLOW;
+			snapshot->overflow_ts = le64_to_cpu(po->overflow_ts);
+		}
+
+		if (snapshot && (po->flags & CXL_POISON_FLAG_SCANNING))
+			snapshot->device_flags |= CXL_POISON_FLAG_SCANNING;
+
+		rc = cxl_poison_snapshot_append(snapshot, po->record, count);
+		if (rc)
+			break;
+
 		/* Protect against an uncleared _FLAG_MORE */
-		nr_records = nr_records + le16_to_cpu(po->count);
+		nr_records += count;
 		if (nr_records >= mds->poison.max_errors) {
 			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
 				nr_records);
+			if (snapshot && (po->flags & CXL_POISON_FLAG_MORE))
+				snapshot->truncated = true;
+
 			break;
 		}
 	} while (po->flags & CXL_POISON_FLAG_MORE);
 
 	return rc;
 }
+
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr)
+{
+	return cxl_mem_get_poison_common(cxlmd, offset, len, cxlr, NULL);
+}
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, "CXL");
 
+int cxl_mem_get_poison_snapshot(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+				struct cxl_region *cxlr,
+				struct cxl_poison_snapshot *snapshot)
+{
+	if (!snapshot || !snapshot->records || !snapshot->capacity)
+		return -EINVAL;
+
+	if (snapshot->nr_records > snapshot->capacity)
+		return -EOVERFLOW;
+
+	return cxl_mem_get_poison_common(cxlmd, offset, len, cxlr, snapshot);
+}
 static void free_poison_buf(void *buf)
 {
 	kvfree(buf);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c401e3a1af06..1d6f8d958bd2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -812,6 +812,31 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
+
+/**
+ * struct cxl_poison_snapshot - Aggregate Get Poison List result
+ * @records: Copied Media Error Records from all mailbox responses
+ * @nr_records: Number of valid records stored in @records
+ * @capacity: Maximum number of records that @records can hold
+ * @overflow_ts: Timestamp associated with a reported device overflow
+ * @device_flags: Persistent device status observed during collection
+ * @truncated: Host stopped before collecting all available records
+ */
+struct cxl_poison_snapshot {
+	struct cxl_poison_record *records;
+	u32 nr_records;
+	u32 capacity;
+	u64 overflow_ts;
+	u8 device_flags;
+	bool truncated;
+};
+
+int cxl_poison_snapshot_init(struct cxl_memdev *cxlmd,
+			     struct cxl_poison_snapshot *snapshot);
+void cxl_poison_snapshot_destroy(struct cxl_poison_snapshot *snapshot);
+int cxl_mem_get_poison_snapshot(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+				struct cxl_region *cxlr,
+				struct cxl_poison_snapshot *snapshot);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
-- 
2.43.0

