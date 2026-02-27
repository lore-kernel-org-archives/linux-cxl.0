Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD681E98FF
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231527; cv=none; b=OA7+Amxuj3NaTXYt36fPKcjXPOiRNeYFY59HyW4ggRr9NLtSVcWg+hcsz0uchCVSgpbrzx8qCbjcKJI+CIg0qgNTdnpdOpNfCDtYGBmYIbT+S1xrMEDGFkcHuiN5AFOHA9VIT2s5xhYQpm1oA4UwF0BLF5qqRN/rqoZCweuPQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231527; c=relaxed/simple;
	bh=iDMRnOUAJQg9p7zkWOyyRXGrctvK5psIeJoH+xFs1iE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dwk10J6IdNenATT2Jn3TG+Pwpijc97+NnSl2o3H11c8yJ3GCdAZFrd7BXoj5i5K0Cjf8LDSnxx91DvBhSeOprZd+dLDHBUscLXoo1tRP/gY7DMbjh8eNOEx56PyEM89dxIN2brMrb7C9JOrRh311/VqVI2MDLDon9S+LxGY64t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fN32W4JfczHnGcj;
	Sat, 28 Feb 2026 06:31:15 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (unknown [7.214.146.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 44BBF40572;
	Sat, 28 Feb 2026 06:32:02 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.175.34) by
 dubpeml500008.china.huawei.com (7.214.146.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 22:32:01 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 0/3] hw/cxl: Add fixes in maintenance, PPR and event records
Date: Fri, 27 Feb 2026 22:32:03 +0000
Message-ID: <20260227223207.972-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500008.china.huawei.com (7.214.146.94)

From: Shiju Jose <shiju.jose@huawei.com>

Add few fixes in CXL maintenance, PPR and event records generation.

1. In cxl_create_mem_sparing_event_records(), replace strncpy with memcpy to
solve coverity warning because full size of the array to use as length in
strncpy to copy the entire component id data, which is 16 bytes.

2. In cxl_maintenance_insert(),
 - replace strncpy with memcpy in to copy full data because component id is
   16 bytes data.
 - remove memset which is not required.

3. In cxl_perform_ppr(), remove and free the maintenance entry from QLIST if
match is found and PPR operation is performed.

4. Component id in CXL events is 16 bytes data, but event record generation copy
15 bytes only from the qmp "component-id" field using strncpy.
Replace strncpy with memcpy and change length of data to copy to the size of the
component_id array (16 bytes).

Shiju Jose (3):
  hw/cxl: Add fixes in maintenance and memory sparing
  hw/cxl: Add fixes in Post Package Repair (PPR)
  hw/cxl/events: Fixes for component id in event records generation

 hw/cxl/cxl-mailbox-utils.c |  6 ++++--
 hw/mem/cxl_type3.c         | 13 ++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.43.0

