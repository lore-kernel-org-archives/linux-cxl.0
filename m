Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF10486424;
	Mon, 14 Sep 2026 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390959; cv=none; b=q2UVRZR7Noue9gqKbwexiHYq2sx15OYONSupFNcrfc207wYFcMFaRaxVpuLXNGZd+tOjjr3mmgXbWoulHjTxn5Z5qXMoTOAk6ffLM1wzBMyTVi4sdDXfhaGE6iy4yN6gsd7+iKDTgSaoiFCnMrdEDagYjqlDfE50wSls9DozazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390959; c=relaxed/simple;
	bh=LqGS9Eb2l3Lg570G7hppxAYGPGcpW4Hza3JY5sXhCPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6ho6WWapcCtkjCMG81i/I0mnWAxsRCOuOd24L/lcBkKtQJ5nqAxi6JaQ3r0qGQS0ZuaTKomwcymdpZAEjkemMLdP86L/Di4Y4VO2vupfg7Cr2IqHcUCTU8fcT1rgIu3MY2xOajm4+afIHW9DSdcU52ITf0+pk1xJ39HOkJRhJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from localhost.localdomain (unknown [159.226.228.11])
	by APP-01 (Coremail) with SMTP id qwCowACHWOwe76dqyj74Bw--.19200S3;
	Mon, 14 Sep 2026 20:57:08 +0800 (CST)
From: Gaobin Huang <huanggaobin23@semi.ac.cn>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cxl/mbox: clamp the event record count to the received payload
Date: Mon, 14 Sep 2026 20:57:00 +0800
Message-Id: <20260914125701.1160136-2-huanggaobin23@semi.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
References: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACHWOwe76dqyj74Bw--.19200S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF15XryfWry8KF4rtF4rAFb_yoWrXryxpF
	WfAFy3trs7JayxuwnxXay5Zas0kw1kXrZxXw1qq343Kr1fJrnxZasxJa4UZw45Kr95JF9a
	y34jqFW3CayUZaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26F4UJVW0owAaw2AFwI0_Jrv_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUkqXdUUUUU
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/

cxl_mem_get_records_log() walks payload->records[] using the record_count
the device wrote into that same payload, and cxl_clear_event_record()
repeats the walk with the same unvalidated value, reading record handles
past the end of the mailbox buffer.  The handle it reads is then handed
back to the device in the Clear Event Records payload.

The command is issued with .size_out = cxl_mbox->payload_size and only

	.min_out = struct_size(payload, records, 0)

enforced, so the count is never compared against what the device actually
returned.  __cxl_pci_mbox_send_cmd() already knows that number: it stores
the bytes it copied into the driver buffer in mbox_cmd.size_out.  Derive
the record bound from it, and pass the validated count to
cxl_clear_event_record() instead of letting it re-read the raw field.

Seen with a QEMU Type-3 device that returns one record in a 2048 byte
buffer while claiming more, so records[16] is the first access outside it:

	BUG: KASAN: slab-out-of-bounds in cxl_clear_event_record+0x1ad/0x2e0
	Read of size 2 at addr ffff888003306834 by task irq/27-0000:35:/58
	 which belongs to the cache kmalloc-2k of size 2048
	The buggy address is located 52 bytes to the right of
	 allocated 2048-byte region

A sweep of the claimed count agrees: 16 stays inside the allocation and 17
does not.  With the clamp in place the same device logs

	Event log '4': device claimed 4096 records but the payload holds 1

and the log is drained normally.

Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
Signed-off-by: Gaobin Huang <huanggaobin23@semi.ac.cn>
---
 drivers/cxl/core/mbox.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836..a8f51bf0f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -992,11 +992,13 @@ static void __cxl_event_trace_record(struct cxl_memdev *cxlmd,
 
 static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 				  enum cxl_event_log_type log,
-				  struct cxl_get_event_payload *get_pl)
+				  struct cxl_get_event_payload *get_pl,
+				  u16 nr_rec)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_mbox_clear_event_payload *payload;
-	u16 total = le16_to_cpu(get_pl->record_count);
+	/* count validated by cxl_mem_get_records_log(), not re-read here */
+	u16 total = nr_rec;
 	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
 	size_t pl_size = struct_size(payload, handles, max_handles);
 	struct cxl_mbox_cmd mbox_cmd;
@@ -1070,6 +1072,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 	struct cxl_get_event_payload *payload;
 	u8 log_type = type;
 	u16 nr_rec;
+	size_t max_recs;
 
 	mutex_lock(&mds->event.log_lock);
 	payload = mds->event.buf;
@@ -1093,7 +1096,20 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 		}
 
+		/*
+		 * The record count is device-supplied.  Never walk records[]
+		 * past the payload the device actually returned.
+		 */
+		max_recs = (mbox_cmd.size_out -
+			    offsetof(struct cxl_get_event_payload, records)) /
+			   sizeof(struct cxl_event_record_raw);
 		nr_rec = le16_to_cpu(payload->record_count);
+		if (nr_rec > max_recs) {
+			dev_warn_ratelimited(dev,
+					     "Event log '%d': device claimed %u records but the payload holds %zu\n",
+					     type, nr_rec, max_recs);
+			nr_rec = max_recs;
+		}
 		if (!nr_rec)
 			break;
 
@@ -1104,7 +1120,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
 
-		rc = cxl_clear_event_record(mds, type, payload);
+		rc = cxl_clear_event_record(mds, type, payload, nr_rec);
 		if (rc) {
 			dev_err_ratelimited(dev,
 				"Event log '%d': Failed to clear events : %d",
-- 
2.34.1

