Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056CA35F17F
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 10:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792097; cv=none; b=Q/ClhYkQCoPY/d2mhFPw+sxboll7V1De+5jC2jnXQU3jx+2G6iDXU+PidS5ipixrKTD9WnI72HzmCexq2DIb5TQzPYyuSq7au9PI3Cm9jOZ8Um6tO2Oo/9lEzrvoAQw5rs14YZ+gC3ocSQRP2WIDOcgkO4Eb/XWXaZT4ULy0wDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792097; c=relaxed/simple;
	bh=X0+KbL9hzfflz+BNXhS4hbnzoIDNlbPWsK8Vr7ZLcl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uwd9AKH3yTi4b+XsfB2BoK1yD+HlbhCzYCugHdK/5zGNvLViFLk4lETi5vrOd3F2Jot9t4CPnmhjToorp5JhXMYy+nNel4I6BniVXJz+pWG61hpN3egs4LVgF8R4KfyVXXKrU+apbJ7nRJ+SGr3cG1Rf89CSt87CyyPFKD2mccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS2Lt6hbtzJ46fB;
	Fri,  6 Mar 2026 18:14:14 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (unknown [7.214.146.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C093C40587;
	Fri,  6 Mar 2026 18:14:52 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.67) by
 dubpeml500008.china.huawei.com (7.214.146.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 10:14:52 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
	<peter.maydell@linaro.org>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 0/3] hw/cxl: Add fixes in maintenance, PPR and event records
Date: Fri, 6 Mar 2026 10:14:19 +0000
Message-ID: <20260306101423.986-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500008.china.huawei.com (7.214.146.94)

From: Shiju Jose <shiju.jose@huawei.com>

Add few fixes in CXL maintenance, PPR and event records generation.

1. In cxl_create_mem_sparing_event_records(), replace strncpy with memcpy
to solve coverity warning (CID 1645325) to copy the entire component ID
data, which is 16 bytes data, not a string.

2. In cxl_maintenance_insert(),
 - replace strncpy with memcpy to copy full data because component ID is
   16 bytes data, not a string.
 - remove memset which is not required.

3. In cxl_perform_ppr(), remove and free the maintenance entry from QLIST
if match is found and PPR operation is performed.

4. Component ID in CXL events is 16 bytes data, not a string, but event
record generation copy 15 bytes only from the qmp "component-id" field
using strncpy. Replace strncpy with memcpy and copy the entire component
ID data.

Changes:
v1 -> v2
1. Fix for the feedback from Jonathan.
  - Modified title of patch[1] & patch[3].
  - Added fixes tags to all 3 patche's header.

Shiju Jose (3):
  hw/cxl: Fix handling of component ID to not assume it is a string
  hw/cxl: Add fixes in Post Package Repair (PPR)
  hw/cxl/events: Fix handling of component ID in event records
    generation to not assume it is a string

 hw/cxl/cxl-mailbox-utils.c |  6 ++++--
 hw/mem/cxl_type3.c         | 13 ++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.43.0

