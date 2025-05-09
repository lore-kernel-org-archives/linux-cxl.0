Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825357E1
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746811382; cv=none; b=IHSkSOzFC+XL6C0zwQE5P61eNZF3PolsGc4tERF5pgKn3YVXs3CK+rxZziEjB1sKg1/jwbvI4vB/3ykYVgCvKtjlDkDF9VJzR7mMqaVP8S6ygXetJqOlLtGyzEKB0QD+DFzPqwpb2otmFiS/QZR7cirUqljWrZFFMBVA2ckPNC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746811382; c=relaxed/simple;
	bh=+h0y2sUNw4vQBLd3hP4KUqmjKY63SILqj+hBcFdORKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICRm/9s8UTaJLGnxobuKvuaLhqpKql2FSfnjYaPdD0IRm6DceQFbU2GiOXhlfey0QnLMjb6651ahKX7/ZWQ+VIiVgqSiTeLjub0WOQW9rFT7ET1rGq93/7dfzaOHmggHGX7tkgLdYVq/vSK6k7CqV3yEElh6zOI/Q2uAIMHot54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZvG3P1qZyz6L5HP;
	Sat, 10 May 2025 01:20:17 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E2B11402EC;
	Sat, 10 May 2025 01:22:51 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.35.8) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 19:22:50 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 0/7] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features 
Date: Fri, 9 May 2025 18:22:22 +0100
Message-ID: <20250509172229.726-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Add updates for the CXL spec rev3.2 changes, in the CXL events reporting
and QMP command to inject CXL events.

Add maintenance support and emulation support for memory Post Package
Repair(PPR) and memory sparing control features.

Davidlohr Bueso (1):
  hw/cxl: Add Maintenance support

Shiju Jose (6):
  hw/cxl/events: Update for rev3.2 common event record format
  hw/cxl/events: Updates for rev3.2 general media event record
  hw/cxl/events: Updates for rev3.2 DRAM event record
  hw/cxl/events: Updates for rev3.2 memory module event record
  hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
    attributes in cmd_features_set_feature()
  hw/cxl: Add emulation for memory sparing control feature

 hw/cxl/cxl-mailbox-utils.c  | 499 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          | 181 ++++++++++++-
 hw/mem/cxl_type3_stubs.c    |  20 +-
 include/hw/cxl/cxl_device.h | 128 +++++++++
 include/hw/cxl/cxl_events.h |  38 ++-
 qapi/cxl.json               |  88 ++++++-
 6 files changed, 924 insertions(+), 30 deletions(-)

-- 
2.43.0

