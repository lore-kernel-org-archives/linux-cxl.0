Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6E482EB
	for <linux-cxl@vger.kernel.org>; Fri,  2 Jan 2026 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767368919; cv=none; b=DgGFlSG6VxMPUOmubIIqt1HUgD9GqTdhkxZ5e/5DaRHZxSH8uhPiZoejucRi+ckMhBFcKfRabwdZP3WILqxU4SiHR7R6Zbk9sX1kscrYVKLzoEl0xvLoYhcdpgDPe3dTMb73Vog8vOcoERBrSBvSuTc/PpgbKwqEIN1n+JWFgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767368919; c=relaxed/simple;
	bh=6z+KCJtd3JxYlghpW3cDFNvW8o0LUCQlAXq17pF4JOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rwse4FC4AX1FSkFbMLJbDO7WAIX6wdBGbIO9I8LhVqYVX3cA33UvrcLhn7xqVUs5JohyqBlmcO8JLo/69eOt3Puz7jW6DT3lvxWjp2lV5kj/Op6M8wIZsQFzBP7dqE/cvyhblyWqqMhPIVATZZfbX8FNL3vf0F6KYLGjF9Cdizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djSkg1bb7zJ46DJ;
	Fri,  2 Jan 2026 23:47:39 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id DD80E40570;
	Fri,  2 Jan 2026 23:48:34 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.122.19.247) by
 dubpeml100005.china.huawei.com (7.214.146.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 2 Jan 2026 15:48:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>, Vinayak
 Holikatti <vinayak.kh@samsung.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>, Ravi Shankar
	<venkataravis@micron.com>
Subject: [PATCH qemu 2/2] hw/cxl: Take into account how many media operations are requested for param check
Date: Fri, 2 Jan 2026 15:47:31 +0000
Message-ID: <20260102154731.474859-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
References: <20260102154731.474859-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

Whilst the spec doesn't speak to it directly my assumption is that
a request for more operations than exist should result in an invalid
input error return.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA-p5wZkNxK7wNVq_3PAzEE-muOd1Def-0O-FSpck4DrBQ@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index d8f62a13a8ec..2f449980cdc0 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2547,7 +2547,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
      * sub class command.
      */
     if (media_op_in_disc_pl->dpa_range_count ||
-        start_index > ARRAY_SIZE(media_op_matrix)) {
+        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
-- 
2.48.1

