Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408D36E46F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679560; cv=none; b=ibFHc7lByoUKwMaQL6KbCfEWd3bw9xQlFgKtr/q0IUv9PU70H0AhUnH3H5o5R7RlOe144mc912+mISqlzhnljCe21IxhY6ioQ68RXPRjJB+T5hhWFWLxJgArV90v4oy0GlxuIV1byAi7d/w+apdQdQH844v4+HuW6VOqAtAIpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679560; c=relaxed/simple;
	bh=zvCjqxqf4IDXAA/iMzHz69T5oz1ZVlUI/GWc6zO5f4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SG6OMd21FUlvskQG0RlEK4EoKsP/o5mJ/irpdU9O9t3DNl1mOc2Vp05VSpRIEkoh8If/RMst0U+Z9epYfiprwVAk6rLNhNzcGK+i3kvIQ3W5ALy8CyiFT4cSFyBie2ewT72IWg4Rt6G9rzzWzTiqZ7PSskzhQCpO7P+uZAfvTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129551F00893;
	Fri,  5 Jun 2026 17:12:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org,
	sam.moelius@trailofbits.com
Subject: [PATCH] cxl/test: Fix integer overflow in mock LSA bounds checks
Date: Fri,  5 Jun 2026 10:12:38 -0700
Message-ID: <20260605171238.3857744-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-existing issue discovered by sashiko-bot.

mock_get_lsa() and mock_set_lsa() validate the requested LSA range with
"offset + length > LSA_SIZE". Both offset and length are u32 and, in
mock_get_lsa(), both are taken directly from the user-supplied payload.
The addition is evaluated modulo 2^32, so a large offset combined with a
small length wraps around and passes the check.

Rewrite the checks to compare offset and length against LSA_SIZE without
overflowing by subtracting offset from LSA_SIZE after bounding offset.

Suggested-by: sashiko-bot
Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.kernel.org/
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 5d812b10fbc8..f9b11207ae60 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1063,7 +1063,7 @@ static int mock_get_lsa(struct cxl_mockmem_data *mdata,
 		return -EINVAL;
 	offset = le32_to_cpu(get_lsa->offset);
 	length = le32_to_cpu(get_lsa->length);
-	if (offset + length > LSA_SIZE)
+	if (offset > LSA_SIZE || length > LSA_SIZE - offset)
 		return -EINVAL;
 	if (length > cmd->size_out)
 		return -EINVAL;
@@ -1083,7 +1083,7 @@ static int mock_set_lsa(struct cxl_mockmem_data *mdata,
 		return -EINVAL;
 	offset = le32_to_cpu(set_lsa->offset);
 	length = cmd->size_in - sizeof(*set_lsa);
-	if (offset + length > LSA_SIZE)
+	if (offset > LSA_SIZE || length > LSA_SIZE - offset)
 		return -EINVAL;
 
 	memcpy(lsa + offset, &set_lsa->data[0], length);

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
prerequisite-patch-id: 2230e8cb1f5da168992ad92776043f6632681665
-- 
2.54.0

