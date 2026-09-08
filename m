Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812B3F8717
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862935; cv=none; b=Wi96Y1ZWjEbca4kIFkNjdRTcag/iIqWsO+Vt0BiNK6qIXv4t8P2vt25eQSm8Fq9bchVYc4GHyUVyCL2Q7URiOrK4QNFKzxg4IjFTnMqcZGj0/PtJbaTfQyjr1vgqj3lvolQ07jb+crQMmSzGgpT6qNCPNNiSFQvuA+yH+1W4Axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862935; c=relaxed/simple;
	bh=Eb2WWtQQVDAL9HGVdpkhu6s7eU19gAnT1gKlqZ1PUtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0jkFBdb5oUZ/w+j7+1KfdRu6eGF0bZDNO5AcAXKeGeF6pz8SPOZNXOlpkHzwBx8j3C9O2dNnmHgpYuaxtTaMmXPAiBtKu0yZyOsUcJqOQhcA90bDWq4yLnKVtKq+C+/14i5xi2J2Bn7xZYEbXJI+rc456Qotrm2bj5qt6umu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bok9gztE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bok9gztE"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-395cf2535acso4462925a91.1
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862933; x=1789467733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AxtY9amiZ7CvlitJVxjT++LJyLrgp7EAqzh4ciz0MRE=;
        b=bok9gztEk8eNHZEnBlD4OHI6s7GxQFDPRBRUQYlHKzh1k/YeulMWdkYQjs0ZYDHEfX
         2sVGmoveDPFvULeKRNRzBsw7xkwJr6v7D/BNCSIIeYagxN8gFyY8InSrfkh3uM/mkvDn
         GI/rNbxP3oSPH6G0sfqM3Wjoln62cOgsPjqCXcgMLNBDabV+fX+lLJa9ZatmuJkc5p4o
         cSXo3ez8TG+hYduSLJvxizx/v0UD+DDiFBfBcbnMlxxosabgcQmLlRChPC2Id6Uzv9Zf
         SI2+T+hY3HC30LHmFGLhJfoZZ5Fk+NanyoHjwHFxX/1/ESsJLBKYs+Y651SwLv68KFn0
         ihqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862933; x=1789467733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AxtY9amiZ7CvlitJVxjT++LJyLrgp7EAqzh4ciz0MRE=;
        b=aZA2xv7e9b4AjY0Joz14kOFldD+vNuq2F/OMOci8Z1Di9ilZtjvq1aGhCCZ8X+TMSv
         BCZrafXjCB6k5BBQXk31zTIiRqsx7p0hgV7CNnd6cBGTEz+pkTd9rauFCakS0m+0WSmW
         nGH1HlmxgrmGTGBkGoERdfwk9qHxQEelzRi23FhcjdLeKsp+6E6dIjSRyiJYiQ8LAt8s
         S2BaqRN9OntHIRnUoEsBDJ75LpqYzBQhu4kEfkmKcfEEYsqa6+rihq7ivnjEYmW4QWfu
         rCv+I3i+F2kqGM/6rXY40rG+FucPb3HS2XFS/pb6gKeUBBEkBK4PNzCfwTGt4t6nG+zg
         SnYQ==
X-Gm-Message-State: AFuF++kewREadoHhXXMstkIvVVd513RGtNJeCI5/jh/SvjXqangobKRI
	MhDZW27c0/9S4+3K0bVXyMcPQDiMFZckRpJlgypeLWmuN+SxR+K5/JMAKDqGzg==
X-Gm-Gg: AYBFou0MJdrxkAMP3RDYNbh/Iw42ETfE/g0/s5uy0dDK5jTih2uFzp4fULBMwR0wteX
	2LBOM28BBy/W/dTMNko2mxUBq7E9isJXcug+Id97m54bOzPuVrIq5FlxKFmQlR7/PaFsfnhZUZk
	H5WnS6vPmURPteR7vflC4U/+9Vybv//Qla36A5MK9/EGXPTD/EMVsMuc3zay1W8j+hP2yj3JzUW
	Mdd8n5EYyrlEuXAlLOk/7iayHEQ0PbQvk7pCXZWj7+CvvMg9t1nVAzbqAbrroipItwep+BEXFPt
	7y+6l7pdRiFIRJTbW8eIFkirOMXsFCYrbUlS/eMNNDc94FQZBx4UmO/4daWNlEJE2vEkRuQk+pk
	AZy+VAb5k31ywVXXmscC97cdo2Q+0XYc4KnEHme+xwKoyQT3xxHNM8rgG+KoYDRgz3Let81N8Of
	I8FFRoqJpDwMAr9mlHogLU/s2YUV5gk+qc0m52xo0wsbKzi93HUCdY9/VRrNM4ZrM1pz218F1Na
	e0X/BXAma7YkqZSozAQ2PiVu2gXJkXlR3iNclfR2/5fcJ0u8fmJX0BL8CROlxrtv4U8/b9605IK
X-Received: by 2002:a17:90b:5242:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-39b08046aaamr38267667a91.14.1788862932861;
        Tue, 08 Sep 2026 03:22:12 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:12 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity configuration from the device
Date: Tue,  8 Sep 2026 03:15:06 -0700
Message-ID: <20260908102124.2231730-4-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Devices which support Dynamic Capacity (DC) are configured
via mailbox commands. CXL r4.0 section 9.13.3 requires the host to issue
the Get DC Configuration command in order to properly configure DCDs.

Implement the DC mailbox commands as specified in CXL 4.0 section
8.2.10.9.9 (opcodes 48XXh) to read and store the DCD configuration
information. Disable DCD if an invalid configuration is found.

Linux has no support for more than one dynamic capacity partition. Read
all the partitions the device reports but validate only the first, and
configure it as 'dynamic ram 1'.

The specification requires that volatile capacity starts at DPA 0 and pmem
starts at the DPA immediately following it, but DC partitions only need
to be 256MB aligned according to CXL r4.0 section 8.2.10.9.9.1 Table 8-347.
So a device could leave a gap between ram/pmem (static) capacity and its first
DC partition, or between one DC partition and the next.

However, Linux follows the precedent set by PMEM/RAM partitions and requires the
first DC partition to begin at the DPA immediately following static
capacity.

Based on an original patch by Navneet Singh.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>

---
Changes:
1. mbox.c: validate only the first DC partition. Other partitions are read
   to make it easier to add support for additional partitions but not
   checked. Richard/Alison

2. mbox.c: rework the cxl_dc_check() validation. Run the checks in
   dependency order -- block size, decode length, length, base -- so the
   block size is validated before IS_ALIGNED() uses it as an alignment,
   and give each failure its own message naming the field that is wrong.
   Drop the block size alignment requirement on the region base; CXL
   r4.0 Table 8-347 requires the base to be 256M aligned and states the
   block size alignment for extent start DPAs, not for the base.
   Reported by Alison.

3. mbox.c: range check the number of available DC partitions reported by
   the device. CXL r4.0 Table 8-346 requires a DCD to report between 1
   and 8 regions, but the count was used unchecked as the read loop
   bound, so an out of range value failed later as "Invalid num of
   dynamic capacity partitions". Reported by Alison.

4. mbox.c/pci.c: cxl_configure_dcd() returns an error instead of void,
   and cxl_pci_probe() decides what to do with it. Failure to read the
   DC configuration is now reported rather than silently swallowed;
   -EINVAL for a partition overlapping static capacity, -EOPNOTSUPP for
   the gap Linux does not support, and the mailbox error propagated
   otherwise. cxl_disable_dcd() moves to the caller so the function
   reports and the caller sets policy. Probe still continues without
   DCD rather than failing the memdev, which would cost the device its
   static capacity too. Reported by Jonathan Cameron.

5. mbox.c: check the block size is a power of 2 in 64 bits.
   is_power_of_2() takes an unsigned long, so on a 32 bit build blk_size
   was truncated to its low 32 bits and a value such as 0x100000040 --
   non-zero and a multiple of 40h -- passed validation. CXL_BUS only
   depends on PCI, so this builds on 32 bit. Reported by Sashiko.
---
 drivers/cxl/core/hdm.c    |   2 +
 drivers/cxl/core/mbox.c   | 235 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c |  37 ++++++
 drivers/cxl/cxlmem.h      |  55 +++++++++
 drivers/cxl/pci.c         |   6 +
 include/cxl/cxl.h         |   3 +-
 6 files changed, 337 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..0ef076c08ed2 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -446,6 +446,8 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
 		return "ram";
 	case CXL_PARTMODE_PMEM:
 		return "pmem";
+	case CXL_PARTMODE_DYNAMIC_RAM_1:
+		return "dynamic_ram_1";
 	default:
 		return "";
 	};
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 199bb986d674..a484e23b2b3a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1349,6 +1349,241 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return -EBUSY;
 }
 
+/*
+ * A partition unavailable for Dynamic Capacity reports zeros for decode_length,
+ * length, and block_size.
+ */
+static bool cxl_dc_partition_unavailable(struct cxl_dc_partition *dev_part)
+{
+	return !le64_to_cpu(dev_part->decode_length) &&
+	       !le64_to_cpu(dev_part->length) &&
+	       !le64_to_cpu(dev_part->block_size);
+}
+
+static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
+			struct cxl_dc_partition *dev_part)
+{
+	u64 blk_size = le64_to_cpu(dev_part->block_size);
+	u64 len = le64_to_cpu(dev_part->length);
+
+	/*
+	 * Not an error; leave the entry empty. A partially zeroed partition
+	 * is rejected by the checks below. CXL r4.0 Table 8-347.
+	 */
+	if (cxl_dc_partition_unavailable(dev_part)) {
+		*part = (struct cxl_dc_partition_info) { };
+		dev_dbg(dev, "Partition 0 unavailable for DC\n");
+		return 0;
+	}
+
+	*part = (struct cxl_dc_partition_info) {
+		.start = le64_to_cpu(dev_part->base),
+		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
+	};
+
+	/*
+	 * Block size is a power of 2 and a multiple of 40h. is_power_of_2()
+	 * takes an unsigned long, which truncates blk_size on 32 bit.
+	 */
+	if (blk_size == 0 || (blk_size & (blk_size - 1)) ||
+	    blk_size % CXL_DCD_BLOCK_LINE_SIZE) {
+		dev_err(dev, "DC partition 0 invalid block size %#llx\n", blk_size);
+		return -EINVAL;
+	}
+
+	if (part->size == 0) {
+		dev_err(dev, "DC partition 0 zero decode length\n");
+		return -EINVAL;
+	}
+
+	if (len == 0) {
+		dev_err(dev, "DC partition 0 zero length\n");
+		return -EINVAL;
+	}
+
+	if (len > part->size) {
+		dev_err(dev, "DC partition 0 length %#llx exceeds decode length %#llx\n",
+			len, part->size);
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(len, blk_size)) {
+		dev_err(dev, "DC partition 0 length %#llx not a multiple of block size %#llx\n",
+			len, blk_size);
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(part->start, SZ_256M)) {
+		dev_err(dev, "DC partition 0 base %#llx not aligned to 256M\n",
+			part->start);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "DC partition 0 start %#llx size %#llx blk_size: %#llx\n",
+		part->start, part->size, blk_size);
+
+	return 0;
+}
+
+/* Returns the number of partitions in dc_resp or -ERRNO */
+static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
+			     u8 partition_count,
+			     struct cxl_mbox_get_dc_config_out *dc_resp,
+			     size_t dc_resp_size)
+{
+	struct cxl_mbox_get_dc_config_in get_dc = (struct cxl_mbox_get_dc_config_in) {
+		.partition_count = partition_count,
+		.start_partition_index = start_partition,
+	};
+	struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
+		.payload_in = &get_dc,
+		.size_in = sizeof(get_dc),
+		.size_out = dc_resp_size,
+		.payload_out = dc_resp,
+		/* The device must return at least the fixed header */
+		.min_out = sizeof(*dc_resp),
+	};
+	size_t expected_sz;
+	int rc;
+
+	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	/* A DCD reports between 1 and 8 partitions */
+	if (dc_resp->avail_partition_count == 0 ||
+	    dc_resp->avail_partition_count > CXL_MAX_DC_PARTITIONS) {
+		dev_err(mbox->host,
+			"Device reported %u available DC partitions, expected 1 to %u\n",
+			dc_resp->avail_partition_count, CXL_MAX_DC_PARTITIONS);
+		return -EIO;
+	}
+
+	if (dc_resp->partitions_returned > partition_count) {
+		dev_err(mbox->host, "Device returned %u partitions, requested %u\n",
+			dc_resp->partitions_returned, partition_count);
+		return -EIO;
+	}
+
+	/*
+	 * The payload carries trailing extent/tag count fields after the
+	 * partition array (CXL r4.0 Table 8-346) which the driver ignores, so
+	 * the response is at least, not exactly, expected_sz.
+	 */
+	expected_sz = struct_size(dc_resp, partition,
+				  dc_resp->partitions_returned);
+
+	if (mbox_cmd.size_out < expected_sz) {
+		dev_err(mbox->host,
+			"Payload size %zu less than expected %zu for %u partitions\n",
+			mbox_cmd.size_out,
+			expected_sz,
+			dc_resp->partitions_returned);
+		return -EIO;
+	}
+
+	dev_dbg(mbox->host, "Read %d/%d DC partitions\n",
+		dc_resp->partitions_returned, dc_resp->avail_partition_count);
+	return dc_resp->partitions_returned;
+}
+
+/**
+ * cxl_dev_dc_identify() - Reads the dynamic capacity information from the
+ *                         device.
+ * @mbox: Mailbox to query
+ * @dc_info: The dynamic partition information to return
+ *
+ * Read every partition the device reports, but validate only the first:
+ * Linux maps partition 0 and nothing else, so a defect in capacity the
+ * driver never touches is not a reason to refuse the device dynamic
+ * capacity.  The remaining entries of @partitions are left unset.
+ *
+ * Return: 0 if identify was executed successfully, -ERRNO on error.
+ *         on error only dc_info is left unchanged.
+ */
+int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
+			struct cxl_dc_partition_info *dc_info)
+{
+	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS] = { };
+	struct cxl_mbox_get_dc_config_out *dc_resp __free(kfree) = NULL;
+	struct device *dev = mbox->host;
+	u8 start_partition;
+	u8 num_partitions;
+	u8 partition_count;
+	size_t dc_resp_size;
+
+	/*
+	 * Bound requested number of partitions by mailbox payload size. The
+	 * 256 byte spec minimum, verified in cxl_pci_setup_mailbox(), keeps
+	 * the subtraction below from underflowing.
+	 */
+	partition_count = min_t(size_t, CXL_MAX_DC_PARTITIONS,
+				(mbox->payload_size - sizeof(*dc_resp) -
+				 sizeof(struct cxl_mbox_get_dc_config_tail)) /
+				sizeof(struct cxl_dc_partition));
+	dc_resp_size = struct_size(dc_resp, partition, partition_count) +
+		       sizeof(struct cxl_mbox_get_dc_config_tail);
+
+	dc_resp = kmalloc(dc_resp_size, GFP_KERNEL);
+	if (!dc_resp)
+		return -ENOMEM;
+
+	start_partition = 0;
+	num_partitions = 0;
+	do {
+		int returned, rc;
+
+		returned = cxl_get_dc_config(mbox, start_partition,
+					     partition_count, dc_resp,
+					     dc_resp_size);
+		if (returned < 0) {
+			dev_err(dev, "Failed to get DC config: %d\n", returned);
+			return returned;
+		}
+
+		if (returned == 0) {
+			dev_err(dev,
+				"Device reported %u partitions available but returned none at index %u\n",
+				dc_resp->avail_partition_count, start_partition);
+			return -EIO;
+		}
+
+		/*
+		 * Only partition 0 is mapped, so it is the only one checked.
+		 * The rest are read to complete the enumeration and dropped.
+		 */
+		if (start_partition == 0) {
+			rc = cxl_dc_check(dev, &partitions[0],
+					  &dc_resp->partition[0]);
+			if (rc)
+				return rc;
+		}
+
+		num_partitions += returned;
+
+		if (num_partitions > CXL_MAX_DC_PARTITIONS) {
+			dev_err(dev, "Invalid num of dynamic capacity partitions %d\n",
+				num_partitions);
+			return -EINVAL;
+		}
+
+		start_partition = num_partitions;
+
+	} while (num_partitions < dc_resp->avail_partition_count);
+
+	/* Linux only supports the 1st partition; nothing to do if it is unavailable */
+	if (partitions[0].size == 0)
+		return -ENODEV;
+
+	*dc_info = partitions[0];
+	dev_dbg(dev, "Returning partition 0 %#llx size %#llx\n",
+		dc_info->start, dc_info->size);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
+
 int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..fdd6b395dcdf 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -643,6 +643,43 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
 
+int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
+{
+	struct cxl_dc_partition_info dc_info = { };
+	struct device *dev = mds->cxlds.dev;
+	int rc;
+
+	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
+	if (rc) {
+		dev_warn(dev,
+			 "Failed to read Dynamic Capacity config: %d\n", rc);
+		return rc;
+	}
+
+	if (dc_info.start < info->size) {
+		dev_err(dev,
+			"DC partition 0 base %#llx overlaps static capacity ending at %#llx\n",
+			dc_info.start, info->size);
+		return -EINVAL;
+	}
+
+	/* A gap between static capacity and the DC partition is not supported */
+	if (dc_info.start > info->size) {
+		dev_warn(dev,
+			 "DC partition 0 base %#llx leaves a gap from static capacity ending at %#llx\n",
+			 dc_info.start, info->size);
+		return -EOPNOTSUPP;
+	}
+
+	info->size += dc_info.size;
+	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
+		dc_info.start, dc_info.size);
+	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
+
 
 /**
  * cxl_set_capacity: initialize dpa by a driver without a mailbox.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0c8e23276dc6..4fac65dbb808 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -407,6 +407,8 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
+#define CXL_MAX_DC_PARTITIONS 8
+
 static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
 {
 	/*
@@ -689,6 +691,39 @@ struct cxl_mbox_set_shutdown_state_in {
 	u8 state;
 } __packed;
 
+/* See CXL r4.0 Table 8-345 get dynamic capacity config Input Payload */
+struct cxl_mbox_get_dc_config_in {
+	u8 partition_count;
+	u8 start_partition_index;
+} __packed;
+
+/* See CXL r4.0 Table 8-346 get dynamic capacity config Output Payload */
+struct cxl_mbox_get_dc_config_out {
+	u8 avail_partition_count;
+	u8 partitions_returned;
+	u8 rsvd[6];
+	/* See CXL r4.0 Table 8-347 */
+	struct cxl_dc_partition {
+		__le64 base;
+		__le64 decode_length;
+		__le64 length;
+		__le64 block_size;
+		__le32 dsmad_handle;
+		u8 flags;
+		u8 rsvd[3];
+	} __packed partition[] __counted_by(partitions_returned);
+	/* Trailing extent/tag count fields unused */
+} __packed;
+
+/* Trailing counts; cannot be a member after the flex array above */
+struct cxl_mbox_get_dc_config_tail {
+	__le32 num_extents_supported;
+	__le32 num_extents_available;
+	__le32 num_tags_supported;
+	__le32 num_tags_available;
+} __packed;
+#define CXL_DCD_BLOCK_LINE_SIZE 0x40
+
 /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
 struct cxl_mbox_set_timestamp_in {
 	__le64 timestamp;
@@ -812,9 +847,18 @@ enum {
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
+
+struct cxl_dc_partition_info {
+	u64 start;
+	u64 size;
+};
+
+int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
+			struct cxl_dc_partition_info *dc_info);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
+int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
 						 u16 dvsec);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
@@ -828,6 +872,17 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    const uuid_t *uuid, union cxl_event *evt);
 int cxl_get_dirty_count(struct cxl_memdev_state *mds, u32 *count);
 int cxl_arm_dirty_shutdown(struct cxl_memdev_state *mds);
+
+static inline bool cxl_dcd_supported(struct cxl_memdev_state *mds)
+{
+	return mds->dcd_supported;
+}
+
+static inline void cxl_disable_dcd(struct cxl_memdev_state *mds)
+{
+	mds->dcd_supported = false;
+}
+
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c7c91e8dc51d..2fe9db4b3d86 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -868,6 +868,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	if (cxl_dcd_supported(mds)) {
+		rc = cxl_configure_dcd(mds, &range_info);
+		if (rc)
+			cxl_disable_dcd(mds);
+	}
+
 	rc = cxl_dpa_setup(cxlds, &range_info);
 	if (rc)
 		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..4ef9511fbbdd 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -133,6 +133,7 @@ struct cxl_dpa_perf {
 enum cxl_partition_mode {
 	CXL_PARTMODE_RAM,
 	CXL_PARTMODE_PMEM,
+	CXL_PARTMODE_DYNAMIC_RAM_1,
 };
 
 /**
@@ -147,7 +148,7 @@ struct cxl_dpa_partition {
 	enum cxl_partition_mode mode;
 };
 
-#define CXL_NR_PARTITIONS_MAX 2
+#define CXL_NR_PARTITIONS_MAX 3
 
 /**
  * struct cxl_dev_state - The driver device state
-- 
2.43.0

