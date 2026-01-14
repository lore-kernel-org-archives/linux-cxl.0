Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC19362157
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426505; cv=none; b=TrN/O9DZp37ZoljlJNfBezjQHRxW4EfOWiY2nka/q36vPY4TiYxzTDqqMKzva2FP/IN5eK/wkWxOP0vTkT9r6CYsccCv+6yghUGwo7AmFiQDv0tDGVPImdLecKb//dKQU7ya6tNqL862X8F4VF/VbdVql8TkXvPtBBmMMzbJZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426505; c=relaxed/simple;
	bh=VJhZh7W86znk6T4YU4zDAnr6xplKZCmyhBUSPOyJHg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4yud7pZ8Vofyvnjmet1ymBY51Z05fQKB3jQ7EhYw+B5Lazivj+vkcmgJJ/XhWjGrC9LOhqcjP7ZJu5ce/hOzSyARJedbEXLB+iavwwetlFJSkDRc7GpUp0LYouKyRL+icsgR4GvApYDoAnh2XNsePgQmNJ/8jz1JTOdyGVA2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpvHmTlk; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpvHmTlk"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c7660192b0so199433a34.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426497; x=1769031297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZsKBgwQfRTYfl5tr8Q6BwcIVeayQIJR9+JPKX7ldDM=;
        b=EpvHmTlkd4h43mRZ/zud+Xdm6bUE6hs/6lONcTdqZt98vIpx7ZNhOhP7gcZz4Qfis3
         I+RwfhEtdQ3zRZAXEBaQxpVWPw8NGx8D36u3WYoRvMn0mxbGQuAIo94V1RM1LM+DPQhs
         lwLbFi+ohtx1uSjXVrKDp9hI4KGs1OxXyleaZ9RFNhaeJJRaSnHU3TiIDYNZY5Cj8hKI
         423LISk6X9Yo4IGOLgJ4KrfPmrDQxMLVrEPlkzHWODTA4iqY6CJtMQx9vltbMhmJACTr
         /0tDyyrUzeI4pJ+YBqonvFKy5bzLa6yy+iQ/7hGO8pAW6GhfjoF2rseTast8sbx1V/jY
         FlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426497; x=1769031297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZsKBgwQfRTYfl5tr8Q6BwcIVeayQIJR9+JPKX7ldDM=;
        b=bTTAah4wVnSm0Lz11WlSNmJh8bIWWI1PReEzHEKubDFzBgCk+IBJD3wR1wzZd9b4tx
         dRzKCV219DH9B6Vfo8+/yIJ5jMsXqTwxX35CI9UIFedgATFGpesUf89zwtuYB8G5GcqC
         PY0twjWHhgeU58USMhS+cB1AONY14cmMxMDOPk7etZWipsLt/yhtXxykWAzZLHBqXllc
         iiz0V2AI3tM4Qmli+CBCglFIHpVY3V3xBu0R1S3p928ErFg+8sZr72aHqts45juRewwG
         KbE+nqYsmr2qfN9y6jeempgITfW/5KG2mFbbUf2O88b2QB9sUO+u8rPEe8kpgY6ktD0X
         ihAA==
X-Forwarded-Encrypted: i=1; AJvYcCUKttUekP73SMjrCzjhK6Y9miobK1+EEYyLY3c1P9+UyTXtDcN+SEfWHJ7uVeBFO21qrZdmqrcHbcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpMmn6az9I4ojLXtnlV2r46LrBCXQpni2JpEOueX0LJMOzFqh
	iHP+3paVrtJM9RZuQ0BSHBGXrVT9nqb+Dy4WUK0YMz0Qc92X69mgqO9Y
X-Gm-Gg: AY/fxX7kZEEsCTl34lqnSuQRto9JBW67bTEiJ6Jh3T4J9zD7b8/5FuZ6MdlZm7/4Ur0
	gIgDFu1DOuprRG8LrSGxSMVR1kfwk2AeqIgEhDpg/UzGbf+wUgpvjlC3VaTQF3Ypp5VMfWCbcJy
	biwYkKSPncJt6szMa1xE6EfOLHR8KC9JTGHIHL/Bzab2yXCdGGVbqhrMypz38ZWjoN7x+VDK6WV
	2LSDrzd4N+YGDLtBBB/MacTXRrj03bUF1pIu4FE50JFbkjNVPvRv40CsMRPAvSFSoMCWiWgjhWn
	KkA5LKaw+0wDXZJzV9GnH0A06ho50j8niqc1nMSp9OfKqrVZrdr8RjytNiwv0WRQemaErlikbUG
	QVafueOqWPCkhA+lvtKYuuw+KViC+4NE303ps+EsbB2bdXSO9KiZHG9d9bqIw4kypM4PMmLNjLe
	m+0koDxYuTbC/cpBAsS430/q/dYGD43N4mDTrcz7y0wgFl8OvZ04RK0M8=
X-Received: by 2002:a05:6830:4124:b0:7cf:d18e:706e with SMTP id 46e09a7af769-7cfd18e7074mr1365370a34.5.1768426497284;
        Wed, 14 Jan 2026 13:34:57 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfd447151csm542661a34.14.2026.01.14.13.34.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:34:56 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 05/19] dax: Add dax_operations for use by fs-dax on fsdev dax
Date: Wed, 14 Jan 2026 15:31:52 -0600
Message-ID: <20260114213209.29453-6-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

fsdev: Add dax_operations for use by famfs

- These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
- fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
  newly stored as dev_dax->virt_addr by dev_dax_probe().
- The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
  for read/write (dax_iomap_rw())
- fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
  tested yet. I'm looking for suggestions as to how to test those.
- dax-private.h: add dev_dax->cached_size, which fsdev needs to
  remember. The dev_dax size cannot change while a driver is bound
  (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
  at probe time allows fsdev's direct_access path can use it without
  acquiring dax_dev_rwsem (which isn't exported anyway).

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/dax-private.h |  1 +
 drivers/dax/fsdev.c       | 80 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index f3cf0a664f1b..164dd5b9d933 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -86,6 +86,7 @@ struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
 	void *virt_addr;
+	u64 cached_size;
 	unsigned int align;
 	int target_node;
 	bool dyn_id;
diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index 72f78f606e06..f58c88de7a4d 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -28,6 +28,81 @@
  * - No mmap support - all access is through fs-dax/iomap
  */
 
+static void fsdev_write_dax(void *pmem_addr, struct page *page,
+		unsigned int off, unsigned int len)
+{
+	while (len) {
+		void *mem = kmap_local_page(page);
+		unsigned int chunk = min_t(unsigned int, len, PAGE_SIZE - off);
+
+		memcpy_flushcache(pmem_addr, mem + off, chunk);
+		kunmap_local(mem);
+		len -= chunk;
+		off = 0;
+		page++;
+		pmem_addr += chunk;
+	}
+}
+
+static long __fsdev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
+			long nr_pages, enum dax_access_mode mode, void **kaddr,
+			unsigned long *pfn)
+{
+	struct dev_dax *dev_dax = dax_get_private(dax_dev);
+	size_t size = nr_pages << PAGE_SHIFT;
+	size_t offset = pgoff << PAGE_SHIFT;
+	void *virt_addr = dev_dax->virt_addr + offset;
+	phys_addr_t phys;
+	unsigned long local_pfn;
+
+	WARN_ON(!dev_dax->virt_addr);
+
+	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
+
+	if (kaddr)
+		*kaddr = virt_addr;
+
+	local_pfn = PHYS_PFN(phys);
+	if (pfn)
+		*pfn = local_pfn;
+
+	/*
+	 * Use cached_size which was computed at probe time. The size cannot
+	 * change while the driver is bound (resize returns -EBUSY).
+	 */
+	return PHYS_PFN(min(size, dev_dax->cached_size - offset));
+}
+
+static int fsdev_dax_zero_page_range(struct dax_device *dax_dev,
+			pgoff_t pgoff, size_t nr_pages)
+{
+	void *kaddr;
+
+	WARN_ONCE(nr_pages > 1, "%s: nr_pages > 1\n", __func__);
+	__fsdev_dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);
+	fsdev_write_dax(kaddr, ZERO_PAGE(0), 0, PAGE_SIZE);
+	return 0;
+}
+
+static long fsdev_dax_direct_access(struct dax_device *dax_dev,
+		  pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
+		  void **kaddr, unsigned long *pfn)
+{
+	return __fsdev_dax_direct_access(dax_dev, pgoff, nr_pages, mode,
+					 kaddr, pfn);
+}
+
+static size_t fsdev_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
+		void *addr, size_t bytes, struct iov_iter *i)
+{
+	return _copy_from_iter_flushcache(addr, bytes, i);
+}
+
+static const struct dax_operations dev_dax_ops = {
+	.direct_access = fsdev_dax_direct_access,
+	.zero_page_range = fsdev_dax_zero_page_range,
+	.recovery_write = fsdev_dax_recovery_write,
+};
 
 static void fsdev_cdev_del(void *cdev)
 {
@@ -163,6 +238,11 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
 		}
 	}
 
+	/* Cache size now; it cannot change while driver is bound */
+	dev_dax->cached_size = 0;
+	for (i = 0; i < dev_dax->nr_range; i++)
+		dev_dax->cached_size += range_len(&dev_dax->ranges[i].range);
+
 	/*
 	 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type and
 	 * do NOT set vmemmap_shift. This leaves folios at order-0,
-- 
2.52.0

