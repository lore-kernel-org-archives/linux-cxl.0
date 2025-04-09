Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3500726ACB;
	Wed,  9 Apr 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166937; cv=pass; b=svz8RJ6igqi/M2pGXIMulDvdb2wC1eX8LQAB6x4XEJyA8jWSKYnv6SjU9bWbgxQ4+2VAeB0E/o93mnkZU8zX1ig00fEMiZm40h+pcJT3uOd+4CxI+mnrppMTlWIXOHubyRmp/vbcOJh5trmmhZhmT1EmFwm0jeaIVeW+vsnfkgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166937; c=relaxed/simple;
	bh=lscGfddQOWE8AhqxBdTatyY2pkbkU2TqgJ7DNijPCQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ulBc1ofNsIyJhJY5Rt8yEUKsNtpSgJ9DnoR8exZabFyGW7b7d9aFCWOLUgrn9N7b8Jd3dj3IaPA4lDpOadW+3rEUARgJuaJYGaIuUzikFbKdXvWaUdZI0BLtqd4zyvdAOlioCw2SIQYftzdd8oblM7/pVh6vz0ux+JAEd/MBFDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=crxGwqIc; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="crxGwqIc"
ARC-Seal: i=1; a=rsa-sha256; t=1744166924; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j8kr/U6Mhg6pNnJ59+Ueg3DXV7i8FnpJgdofZdbPJPoD0iy5v4oa05jKdB1yINAAaP9EgQ6eOl2cRP+uwL0IbLVCfN5Lp9ntusM6aC65vFDcfIrinn/w7bssIMyLmXwACwu6jvnnPRP2h0D/I1FZUJ+3FmqHPIYPOqQsjwzzNsQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744166924; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Lo6rdbpVKNpqrSIHHGzsgA1k3qr45/jNwyi8MvtoIIw=; 
	b=PPTJbscpob4lLJfai1vezKfdZyXwqwU5GO+l9gSCMvqMJmpf1SaZhv7lj36H/qgvpVP22gdLdCxa3RjAFdhJJa7EOc3V3rvkTLPgn+dZhePkW3ebQtiIfqNn/kZ8MmtXcA55fSRFVcZHj9upHz9Twg+7/DLY71E0mz6yPB8CIQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744166924;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=Lo6rdbpVKNpqrSIHHGzsgA1k3qr45/jNwyi8MvtoIIw=;
	b=crxGwqIct4nGSKOU6B67xz/gTuEmgQxUx0G6HJl+dQ8gsEWIyn0oTdJ65DN4oGeB
	ecQ68eW6/CcKACYF+t/27AH9gfkhnWX8uJgFlGntFPzefh4gkLitzzcgN0WcGyB14TL
	INU/IoXMWgI1W9hZHj8lRM0Vc0RJrY9wahZLCJJ8=
Received: by mx.zohomail.com with SMTPS id 1744166922314423.9205214893128;
	Tue, 8 Apr 2025 19:48:42 -0700 (PDT)
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
Subject: [RFC PATCH 1/1] cxl/feature: Using Full Data Transfer only when offset is 0
Date: Wed,  9 Apr 2025 10:48:25 +0800
Message-Id: <20250409024825.510632-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227f20bcca5c106d8699ac36b9a000053f8b3e81b113ef9f3641ee97bd85e20a86509cb1e8636800a:zu0801122782f97f2525511600c75b1c5a000080bbaa6f63aba2bc0f88beb6a2e927c4f46ff526ae8eaae98d:rf0801122d7f72687dca2b6df80bade99f0000368d6f36486f75a5b6b022f677aaecdffd7ec0da5960db1f6d71e5db776d35:ZohoMail
X-ZohoMailClient: External

Per CXL r3.2 section 8.2.10.6.3 Set Feature(Opcode 0502h)

"If the Feature data is transferred in its entirely, the caller makes
one call to Set Feature with Action = Full Data Transfer. The Offset
field is not used and shall be ignored."

It implies if using Full Data Transfer, the received data should be
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

3. data size + header us greater than mbox payload with any value of offset
	Initiate Data Transfer - Continue Data Transfer - Finish Data Transfer

Fixes: 14d502cc2718e ("cxl/mbox: Add SET_FEATURE mailbox command")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8 v6.15-rc1
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

