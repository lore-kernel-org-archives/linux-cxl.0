Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B63264FD;
	Tue, 29 Sep 2026 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662033; cv=none; b=h9vTg9rOe1HFq074LleRhBK/FORkv2eWb1xSEUaonNblm4xaQry5AnwKxQEfTll/EAKvcVy/uu7Vz4NK6y/0xXODRtC4HSNJp8b4K7eWm7vFH87w9IcyxLbU08+1uHzspfxw+EcbYeu9l9H7j+ZLSr62RPOwgKzzHqnyeGYNnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662033; c=relaxed/simple;
	bh=Ih2VPIhidB+gM8QP6NjAEIGb9QwN+AdtPV56PWxcjVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hj6Pgvox0DxubV2RCIAlBQU+I7i/JW1p7IVZsk5O81r1ckQ8/sE/HooFpyEAOh2EwWBr6LrqH17jsesGocskvfhsn7lGa4uhhuzEKkRVlE8QFWPS4DILUzlv+8sE76VRElBbPiArDF3ChbT9mftAgumVPHKcrl/y3mPtkL8RTCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.11])
	by APP-05 (Coremail) with SMTP id zQCowACHuEJgVbtqLC2mCQ--.3783S2;
	Tue, 29 Sep 2026 14:06:50 +0800 (CST)
From: Gaobin Huang <huanggaobin23@semi.ac.cn>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Anisa Su <anisa.su887@gmail.com>,
	sashiko-bot@kernel.org
Subject: [PATCH v3] cxl/mbox: Bound the Get Supported Logs entry count by the payload
Date: Tue, 29 Sep 2026 14:06:10 +0800
Message-Id: <20260929060610.3549718-1-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHuEJgVbtqLC2mCQ--.3783S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4Uur47Xry8tr4DKr4DArb_yoWrJrWDpF
	WY934UXrWfAFy2vwnrAay5urZ8Cw1UXryakFyvg34YywnxAF43XFyjqayYqr1Y93s5Gr17
	ZrWqgFW5CF4jqaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBCb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF
	1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GF
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUypnQDUUUU
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwMFDGq7TSQcvgAAsX

The Get Supported Logs response includes a device supplied entry count.
cxl_enumerate_cmds() uses that count without validating it against the
returned payload length.  The command is only issued with .min_out = 2,
so a device may report more entries than it delivered and the driver
reads past the end of the buffer.  This is probe time, so it happens on
every boot of a machine with such a device, without any host action.

CXL r4.0 Table 8-249 defines the count as the number of entries returned in
this payload, not a running total, so a count the payload cannot hold is a
malformed response rather than a partial list.

Validate the count in cxl_get_gsl(), where the payload length is known, so
no caller can use an entry without a count it can trust, as
get_supported_features() already does for the feature count.  Raise
.min_out to the response header so a response too short to hold the
count is rejected by cxl_internal_send_cmd().

Reproduced with QEMU modified to return an inconsistent entry count.  KASAN
reported an out-of-bounds read in cxl_enumerate_cmds().

Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/all/20260917105302.165CF1F000FF@smtp.kernel.org/
Suggested-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
---
v2 -> v3.
- validate the entry count inside cxl_get_gsl(), which owns the buffer and
  can return the error itself, instead of returning the length to the
  caller; cxl_enumerate_cmds() is unchanged (Richard Cheng).
- raise .min_out to struct_size(ret, entry, 0) so cxl_internal_send_cmd()
  rejects a response too short for the header, which removes the manual
  length check and the underflow it guarded against (Richard Cheng,
  sashiko).
- the early return that leaked the GSL buffer on that path is gone with it
  (sashiko).
- cut the commit message down, drop the claim that no existing hardware is
  affected, and capitalize the subject (Alison Schofield); the count is
  malformed rather than partial (CXL r4.0 Table 8-249, Richard Cheng).

 drivers/cxl/core/mbox.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836..6fd074dbb 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -799,6 +799,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_get_supported_logs *ret;
 	struct cxl_mbox_cmd mbox_cmd;
+	size_t max_entries;
 	int rc;
 
 	ret = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
@@ -809,8 +810,8 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
 		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
 		.size_out = cxl_mbox->payload_size,
 		.payload_out = ret,
-		/* At least the record number field must be valid */
-		.min_out = 2,
+		/* At least the header must be valid */
+		.min_out = struct_size(ret, entry, 0),
 	};
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc < 0) {
@@ -818,6 +819,15 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *
 		return ERR_PTR(rc);
 	}
 
+	max_entries = (mbox_cmd.size_out - struct_size(ret, entry, 0)) /
+		      sizeof(ret->entry[0]);
+	if (le16_to_cpu(ret->entries) > max_entries) {
+		dev_err(mds->cxlds.dev,
+			"GSL: device claimed %u entries but the payload holds %zu\n",
+			le16_to_cpu(ret->entries), max_entries);
+		kvfree(ret);
+		return ERR_PTR(-EIO);
+	}
 
 	return ret;
 }

base-commit: 999811aca000b0d3d1c838c60dc9db7c72eb0c73
-- 
2.34.1

