Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0770808
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679470; cv=none; b=aYkL8JxNchgFfqosuAbSCjrxS45BNjrQkssGXirxOMjIfh8QaMhUtY3tzaQpD/r6Z2q/yVtamnpe0p1qoZmPDumUPFzdW/sC/FU9pt5qO2Y6sxeZZI4QiM+GeI2rb7Kha7tdo55eqFLpcmTawcBcpLkBw0jhuyCbQxPQMWsGnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679470; c=relaxed/simple;
	bh=1GSHdl/cm17drYcNilZjA5obAr8M6gMghEBPtqJE0j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaqZNnJXGFqkWeaheVbVN6SIhuFLyYox7c0EFkFvWV+VwTpcaCjlp2zo1Yd9/qOTeyZ6X5Bs9M/IQarZWUfKPiRLyVO0qwUKJLMcMKNFpRXq4C9y2abCSuTyjDo8W2j63QvLJ5G9DKKw2HbV8M9gQPdZlNKOZDEBomXfyeChi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CA1F00893;
	Fri,  5 Jun 2026 17:11:08 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org,
	sam.moelius@trailofbits.com
Subject: [PATCH] cxl/test: Verify cmd->size_in before accessing payload
Date: Fri,  5 Jun 2026 10:11:07 -0700
Message-ID: <20260605171107.3855381-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-existing issue discovered by sashko-bot.

Add a check for cmd->size_in before accessing the payload. This prevents
potential dereferencing of a null pointer if size_in is zero.

Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
Fixes: d1dca858f058 ("cxl/test: Add generic mock events")
Fixes: f6448cb5f2f3 ("tools/testing/cxl: add firmware update emulation to CXL memdevs")
Fixes: e77e9c107978 ("cxl/test: Add Get Feature support to cxl_test")
Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.kernel.org/
Suggested-by: sashiko-bot
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 39 +++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 271c7ad8cc32..5d812b10fbc8 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -312,12 +312,17 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 
 static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
+	struct cxl_mbox_clear_event_payload *pl;
 	struct mock_event_log *log;
-	u8 log_type = pl->event_log;
+	u8 log_type;
 	u16 handle;
 	int nr;
 
+	if (cmd->size_in == 0)
+		return -EINVAL;
+
+	pl = cmd->payload_in;
+	log_type = pl->event_log;
 	if (log_type >= CXL_EVENT_TYPE_MAX)
 		return -EINVAL;
 
@@ -574,14 +579,19 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
 static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
-	struct cxl_mbox_get_log *gl = cmd->payload_in;
-	u32 offset = le32_to_cpu(gl->offset);
-	u32 length = le32_to_cpu(gl->length);
 	uuid_t uuid = DEFINE_CXL_CEL_UUID;
+	struct cxl_mbox_get_log *gl;
 	void *data = &mock_cel;
+	u32 offset;
+	u32 length;
 
 	if (cmd->size_in < sizeof(*gl))
 		return -EINVAL;
+
+	gl = cmd->payload_in;
+	offset = le32_to_cpu(gl->offset);
+	length = le32_to_cpu(gl->length);
+
 	if (length > cxl_mbox->payload_size)
 		return -EINVAL;
 	if (offset + length > sizeof(mock_cel))
@@ -1336,10 +1346,14 @@ static int mock_fw_info(struct cxl_mockmem_data *mdata,
 static int mock_transfer_fw(struct cxl_mockmem_data *mdata,
 			    struct cxl_mbox_cmd *cmd)
 {
-	struct cxl_mbox_transfer_fw *transfer = cmd->payload_in;
+	struct cxl_mbox_transfer_fw *transfer;
 	void *fw = mdata->fw;
 	size_t offset, length;
 
+	if (cmd->size_in < sizeof(*transfer))
+		return -EINVAL;
+
+	transfer = cmd->payload_in;
 	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_ALIGNMENT;
 	length = cmd->size_in - sizeof(*transfer);
 	if (offset + length > FW_SIZE)
@@ -1415,11 +1429,18 @@ static int mock_get_test_feature(struct cxl_mockmem_data *mdata,
 				 struct cxl_mbox_cmd *cmd)
 {
 	struct vendor_test_feat *output = cmd->payload_out;
-	struct cxl_mbox_get_feat_in *input = cmd->payload_in;
-	u16 offset = le16_to_cpu(input->offset);
-	u16 count = le16_to_cpu(input->count);
+	struct cxl_mbox_get_feat_in *input;
+	u16 offset;
+	u16 count;
 	u8 *ptr;
 
+	if (cmd->size_in == 0)
+		return -EINVAL;
+
+	input = cmd->payload_in;
+	offset = le16_to_cpu(input->offset);
+	count = le16_to_cpu(input->count);
+
 	if (offset > sizeof(*output)) {
 		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
 		return -EINVAL;

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

