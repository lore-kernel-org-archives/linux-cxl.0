Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C874B3381;
	Thu, 17 Sep 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642045; cv=none; b=iC+IVHe9eVDfIpTpwZWYwH2DUL5ga5NCaCy3mHY/zkEU3WYCt/Znc0iLroTnlkDT3FYKopP+YXDrZcPqSL1iQ2f91mVeYOO1MuxTClo2xhVF95NmNXAm2U42AZkJdHvS3Uaea9FcHYo159bAfYyIyAHegWZtR01/b1UrcEo1oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642045; c=relaxed/simple;
	bh=wr1aXBvyBJukYYMDKSHvl8FMA7wtnqflYs6XZ0zjMmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ummAJ9JOfpNF9CGglVOzf3N9boEy4HSlkaibyhtvFhDzC6VmXWq3OATqylIFAJxF+trAiTeF0a/QynauJnwwmi3VVFsPmq77qpogOBXoc/oQpbu5x9CDNg98gZIfGZv8FsDj5KQq/N5XBPzCG0sH5yfS64rcnZui7ScDL+ZhSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.11])
	by APP-01 (Coremail) with SMTP id qwCowABXLPAhxatq4Yc6CA--.4898S2;
	Thu, 17 Sep 2026 18:47:06 +0800 (CST)
From: Gaobin Huang <huanggaobin23@semi.ac.cn>
To: Ira Weiny <iweiny@kernel.org>
Cc: linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Anisa Su <anisa.su887@gmail.com>
Subject: [PATCH RESEND] cxl/mbox: validate the DCD extent list counts against the payload
Date: Thu, 17 Sep 2026 18:46:56 +0800
Message-Id: <20260917104656.2658591-1-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABXLPAhxatq4Yc6CA--.4898S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr45WryfZr1rJrykZF15XFb_yoW7Jr1xpF
	1ayFy5Jr4kJa47Cr9rAa15CFyF9r40vFW3ArnrKr929F45JrWrtry5KryYvw1ruayrK3Wj
	yrW8tr4UC3WUX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5QeOtUUUUU==
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiCRMNDGqrq01b7QAAsK

__cxl_process_extent_list() trusts two counts from the Get DC Extent List
response: returned_extent_count bounds the loop over the flexible
extents->extent[] array, and total_extent_count decides when the enclosing
do/while is finished.  Neither is compared against what the device
actually returned, and the command is only issued with .min_out = 1.

A device that reports more extents than it delivered walks the loop past
the end of the mailbox buffer.  A device that reports a large total while
returning nothing makes the loop spin forever, because total_read never
reaches total_expected; a stable generation number and total also keep the
existing -EAGAIN check from firing.  The caller cannot recover from that
one: __cxl_process_extent_list() never returns, so the retry loop around
it never runs.

Derive the bound from mbox_cmd.size_out, clamp the claim to it, and fail
with -EIO when the device stops making progress.  min_out is smaller than
the response header, so the subtraction needs the same underflow guard.

Seen with QEMU emulating a device that lies.  The response header is 16
bytes and an extent is 40, so a 2048 byte mailbox buffer holds 50:

	BUG: KASAN: slab-out-of-bounds in cxl_validate_extent+0xca/0x310
	Read of size 2 at addr ffff888005758800 by task sh/1
	 cxl_validate_extent+0xca/0x310
	 cxl_process_extent_list+0x2c1/0x430
	 cxl_region_probe+0xb2b/0xc40
	 which belongs to the cache kmalloc-2k of size 2048

The Read of size 2 is extent->shared_extn_seq.  extent[50] starts at
16 + 50 * 40 = 2016 and the field is 32 bytes into the record, so that
read is the first byte outside the buffer; a claimed count of 50 stays
inside and 51 does not, as the sweep shows.  Reporting
total_extent_count = 100000 with returned_extent_count = 0 instead spins
region bring-up until the guest stops answering console commands; with the
fix it logs "Extent list: no progress after 0/100000" and fails.

This is in the dynamic capacity device series under review (branch
dcd-v6-2025-04-13 of weiny2/linux-kernel, based on 6.15-rc2), so the fix
belongs in that series before it is merged.

Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
---
Resend note: the patch is byte-for-byte unchanged.  v1 went to
ira.weiny@intel.com, which no longer exists, so the author it is addressed to
never received it.  The v2 revision of the linux-cxl patch (drop the Fixes:
tag, struct_offset(), fail on a response too short for the header) does not
apply to this one: this code is not in mainline, so there is no commit to point
a Fixes: at, and the bound here already guards the subtraction against wrap.

 drivers/cxl/core/mbox.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0b51a5d..c12ff86 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1764,6 +1764,7 @@ static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_mbox_cmd mbox_cmd;
 	u32 max_extent_count;
+	size_t extents_hdr, max_returned;
 	int latched_rc = 0;
 	bool first = true;
 
@@ -1808,7 +1809,24 @@ static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
 			first = false;
 		}
 
+		/*
+		 * The returned count is device-supplied: never index
+		 * extent[] past the payload the device actually returned.
+		 * The device also chooses the reported length and may return a
+		 * response shorter than the header (min_out is 1), so derive the
+		 * bound without underflowing.
+		 */
+		extents_hdr = offsetof(struct cxl_mbox_get_extent_out, extent);
+		max_returned = mbox_cmd.size_out > extents_hdr ?
+			       (mbox_cmd.size_out - extents_hdr) /
+			       sizeof(struct cxl_extent) : 0;
 		nr_returned = le32_to_cpu(extents->returned_extent_count);
+		if (nr_returned > max_returned) {
+			dev_warn_ratelimited(dev,
+					     "Extent list: device claimed %u extents but the payload holds %zu\n",
+					     nr_returned, max_returned);
+			nr_returned = max_returned;
+		}
 		total_read += nr_returned;
 		current_total = le32_to_cpu(extents->total_extent_count);
 		current_gen_num = le32_to_cpu(extents->generation_num);
@@ -1823,6 +1841,18 @@ static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
 			return -EAGAIN;
 		}
 
+		/*
+		 * A device that keeps claiming more extents without ever
+		 * delivering any would otherwise spin this loop forever
+		 * (the outer retry cannot help: this call never returns).
+		 */
+		if (!nr_returned && total_expected > total_read) {
+			dev_warn_ratelimited(dev,
+					     "Extent list: no progress after %u/%u extents; aborting\n",
+					     total_read, total_expected);
+			return -EIO;
+		}
+
 		for (int i = 0; i < nr_returned ; i++) {
 			struct cxl_extent *extent = &extents->extent[i];
 
-- 
2.34.1

