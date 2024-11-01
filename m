Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B674168DA
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468640; cv=none; b=qL57bXXtSg4YFkCE2R+ipy/QFbpppHTCu1zQ7lkVPUA/t9RM2tcTLIJTgtsObUBGQDfH6iOFEn5BP3SPao+rnnmiFYpRyZEt8XD5CdpAe7C+4hKph/CHDi6M6FtCyCU3tkDLYb575TKnVXz2zpAGlExEXZWLreO1KizZJXxfduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468640; c=relaxed/simple;
	bh=PpziNjUypsrUEP/BTIwS+zWycCjSvI6yDAepxjvktyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or9Witjv4IvlXqt7G8pKNK33tJhXjr3drV2avFncR5r18jvmWzf7Q+VeRwlutkEbzwmfIjLAhTmJ3uU7AhgppuyJC1YWdYvqj6CfPaSkazr3B2xyrrlLrDIZNpKRFw0WRzLKYeJofNP8ULM7g3CNcrhyy/bCNJbqfDcS9nzhXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg25M2BJVz6LD4k;
	Fri,  1 Nov 2024 21:39:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 67F0E140B73;
	Fri,  1 Nov 2024 21:43:57 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:43:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 09/10] hw/cxl: Ensure there is enough data for the header in cmd_ccls_set_lsa()
Date: Fri, 1 Nov 2024 13:39:16 +0000
Message-ID: <20241101133917.27634-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

The properties of the requested set command cannot be established if
len_in is less than the size of the header.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 078782e8b9..f4a436e172 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1503,8 +1503,8 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
 
     *len_out = 0;
-    if (!len_in) {
-        return CXL_MBOX_SUCCESS;
+    if (len_in < hdr_len) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
     if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr_len) {
-- 
2.43.0

