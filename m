Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B316A959
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468672; cv=none; b=DvTjpM9z9x+mJwP5I7yDZduRcZK9/1A2ehN/E5/Q2Rsw7U1z6fgKIBcJXp0WLyMlYq4OcJ/HCjeUlqUqLMwmXMiGmWdz6vKyz1I+2isZX5Pjrd5EyxUEkFmw9HIsxi4+DIiYrkMalXrprry3TkDK9vwnvFVAFKWN0SRTie8xS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468672; c=relaxed/simple;
	bh=KQIU6UYB/0Bq9urc8BJlZbdz4T3y4XNWG8oIsiNPUPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKeOzTcb8bx3SQUEvcQ6FrT9DtC9zhO6da7paPM+Kiea/tnpcOKnttoaC8RFzoaN00Y8IEcvNB7VO8uJCq8ZHRwrTvJSVqUrb6+MZ7nK9niFSnjlRWFZji1gqJcbZtTYRJul+rkG7Qs+vAD4krg3l89tSj4OSiiqgUBa92+FXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg28j17RQz6K6jJ;
	Fri,  1 Nov 2024 21:41:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AAD391404FC;
	Fri,  1 Nov 2024 21:44:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:44:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 10/10] hw/cxl: Ensure there is enough data to read the input header in cmd_get_physical_port_state()
Date: Fri, 1 Nov 2024 13:39:17 +0000
Message-ID: <20241101133917.27634-11-Jonathan.Cameron@huawei.com>
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

If len_in is smaller than the header length then the accessing the
number of ports will result in an out of bounds access.
Add a check to avoid this.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index f4a436e172..2d4d62c454 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -530,6 +530,9 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
     out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
 
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
     /* Check if what was requested can fit */
     if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
-- 
2.43.0

