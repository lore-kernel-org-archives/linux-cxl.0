Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440E38F80;
	Thu, 10 Apr 2025 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253275; cv=pass; b=HotaWUib4y1wFStcLyqdg6IPmoT/o1bgMCGuUUdVUM/cV3E6okFMyxMD7jD+tXibHetc7zzseoBY9eDWHcs/bH0jxlqmZOoxSYVLNzWwDXItSVGpDBlEsFGCERDIMNHy0jDOrcVcQ75wVyGDeLjaA4m9O9SpfmNT1cT9B141+fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253275; c=relaxed/simple;
	bh=V2+eqICYcR2afJREmYpW8q6aaS4HFXGfLL1G6+76JLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CtJLtqU/LzYP8rWc3cMIay8YH9PW4uWwjDFvvXiN+SAb8JT1vvA7y9eOMsWtYyuvcytnVTsDc4aYV8AEMvv1pj+5/9tjtkSMcX4j85juz4GF6TR75B7Cc01iNeNLPwY3ahGifscWF0X29l30dG7rp6VJnCjXdSFkAoAkVboSbdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=YziRertb; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="YziRertb"
ARC-Seal: i=1; a=rsa-sha256; t=1744253259; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AScMilOms0nHdKmRawVWhD+zVPm1NxWpJSBxv4qCvHenxbhDZjTCRwcay1Ns+Q+L81YgcoRD5tl4o27yXdOz1dGcmQtRjegqiKJAnJexUWmER4AAG149KFScPCPg8eztgEqiNBgULtP9yp7cCNHGWpAzPMmr7EUEHd3ON7+SFR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744253259; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9sK5g4CBmElHUEKgj48pT0GOpRw0wtqgCLJifWEmYRc=; 
	b=cgEQNcSn5yz72WJnI/zeqUpqslXtFcrcrDGRu454MbaMeu6ecz4i+2UyrLHJnBDpCuHCItXt3ucftt7BIbQGoinm+pbLNovA/psFoZPmVDWD4BA52D0/e0XJASbOjSnnARuF/uIlwYaPpze2CzkMf9QgTx01m+sgtqUtyIALVSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744253258;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=9sK5g4CBmElHUEKgj48pT0GOpRw0wtqgCLJifWEmYRc=;
	b=YziRertbWfXsMKVYxeiWaLP6LtaDNRR1fa4GOa6mcLbG9NJvB7iRzECLDmzIM/jI
	IXxXjXalmZq12mKuewhtNBYaHAZauxeuHmGJEJlvLEB2OTuFwN1l8qz7Lbd5stnWzMK
	h8luLTtbYHjs3P1MZcopLOAhPcygKrGbGOpzK07A=
Received: by mx.zohomail.com with SMTPS id 1744253256739340.1341885488831;
	Wed, 9 Apr 2025 19:47:36 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 1/1] cxl/feature: Using Full Data Transfer only when offset is 0
Date: Thu, 10 Apr 2025 10:47:26 +0800
Message-Id: <20250410024726.514170-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112278271cfa2fba9f509467738cc00006ba6dacfb7be599d12093cd85f80dbd5d545065ecbf80a7f47:zu080112279e0903e7835bd38c18db22160000a5f8098144cc8295739cd2664163cb0166b5762a69fb134f0f:rf0801122d48826ba0bbd7240d0c33376f0000fc0d4cd5c444bd578b9265302d16f3b8b06c695d5c3b896f82a59e5f44190d:ZohoMail
X-ZohoMailClient: External

Per CXL r3.2 section 8.2.10.6.3 Set Feature(Opcode 0502h)

"If the Feature data is transferred in its entirely, the caller makes
one call to Set Feature with Action = Full Data Transfer. The Offset
field is not used and shall be ignored."

It implies if using Full Data Transfer, the received data will be
updated from offset 0 on device side.

Current driver implementation is if feature data size is less than mbox
payload - set feature header, driver will use Full Data Transfer even if
user provides an offset. Per above description, feature data will be
written from offset 0 rather than the offset value user provided, the
result will not be what user expects.

The changes is checking if the offset caller provides is equal to 0, if
yes, using Full Data Transfer, if not, using Initiate Data Transfer -
Finish Data Transfer.

After the changes, all Set Feature transfer scenarios are below:

1. data size + header is less than mbox payload and offset is 0
	Full Data Transfer

2. data size + header is less than mbox payload and offset is not 0
	Initiate Data Transfer(with all feature data) - Finish Data Transfer(with no feature data)

3. data size + header is greater than mbox payload with any value of offset
	Initiate Data Transfer - Continue Data Transfer(s) - Finish Data Transfer

Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1

v2:
- Drop RFC tag. (Dave)
- Fix typo issue in changelog
---
 drivers/cxl/core/features.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index f4daefe3180e..fcc624cefe89 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -259,6 +259,17 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	return data_rcvd_size;
 }
 
+static bool is_last_feat_transfer(struct cxl_mbox_set_feat_in *pi)
+{
+	switch (le32_to_cpu(pi->flags) & CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK) {
+	case CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER:
+	case CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
  * available in the mailbox for storing the actual feature data so that
@@ -294,14 +305,14 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > cxl_mbox->payload_size)
 		return -ENOMEM;
 
-	if (hdr_size + feat_data_size <= cxl_mbox->payload_size) {
+	if (hdr_size + feat_data_size <= cxl_mbox->payload_size && !offset) {
 		pi->flags = cpu_to_le32(feat_flag |
 					CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
 		data_in_size = feat_data_size;
 	} else {
 		pi->flags = cpu_to_le32(feat_flag |
 					CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
-		data_in_size = cxl_mbox->payload_size - hdr_size;
+		data_in_size = min(feat_data_size, cxl_mbox->payload_size - hdr_size);
 	}
 
 	do {
@@ -322,7 +333,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 		}
 
 		data_sent_size += data_in_size;
-		if (data_sent_size >= feat_data_size) {
+		if (data_sent_size >= feat_data_size &&
+		    is_last_feat_transfer(pi)) {
 			if (return_code)
 				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 			return 0;
-- 
2.34.1

