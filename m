Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC3498902;
	Thu,  1 Oct 2026 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856112; cv=fail; b=T02wWrj4GSrsQzP3KEKA3sVwHfkRwweaV3hz7vmhh5cVG1xbKXkJPtYAnJU2mOhjJDByHJG2o2gwTHM+MpaiRqciPLkwMbRZx+G8XclhyeepTP844H8nAdaPkwbDnpVxXTSPxrb0FwvySdoFFvfll12OcdJIYLP85i5pvJIh40I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856112; c=relaxed/simple;
	bh=zPEZ62+jOb1P8ElgUqzkGQLZODsdeBUUqFqUN5IJyIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcwXc0PPThv14gr5h3Pgueq4ntK05oSRwuD3xHEWdFCA89stP/Oit3WnIIzmFhn/aQ7ufA8fCRgwHHMsR2H+TrRZlhS+Xoptqme3hvUu9F4Jdve39JK4MuyQF/V7vsmZy1kjGf9LoFpD5KMSUbK00/hgWgHpBtTI4xS843j17mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2vy8RZ3x; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2vy8RZ3x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2n8M/dtqMA2TLOJHV9iPfg1o2mQSfp7XNfqg1uQM6nwf9Rs8mLo7zD/Xzb4Oj+IDlQIMo9VLCIgSQvyD9iimYuSaP2t8W6uPJLJ1/AgmiqPmoJ96YTE2lZejkf7yCbuIU5hSUn3ez4YiQ8HwWNIyZCI0zk7EbeIG+8kBQA/DfhOHzFogMim7ovGukQwnBtv/jPaEB2lSCPTDS48dZsgbrr6ZFv4iSTvUSFeKWzmBMPsHPRBUFJEi+YKaLkX1F3TkoC0NabUlEYgSxwR0k2tc0478n2bVZU6S4DuZfe1yWua68Ak0XpFKqgsbUldvw98lzvX7L9wReiEnWaAKpTHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMMhDJWh+IZhjfOMUPQeQbGkit/0t9Jpi1iowDQVypE=;
 b=ZbB/nVnCpijVcu3PNJg3pXKD8/gW6AfcVyphkosN5ZvR1xx9DNUxPvqdn0uLdmjy3AvIlqrnM6yWveVYu/IN63DT3KQ2oZOdg1VEvQLrfehtrWiFI6DRQYtb8VzhL9pPvoyxUFOdMlCg1ht1Pt0P3mAQw36np/4egBHw7BKY9R/KTDaMr+tnMUOKAwNoMGnnTA1kYsyYpHbfXE2BMuCqlH7uKevBX3AtaKu1tvf0zUY5ZMLxkfi5sqRXQwPWuWfn/QgiMo8BxxXlabK2q7DQGU4V9GvJ7aRWU32O91NQ//Hon4Hr62eKeNI1XKnY4nE9v9fCAzm0nXx8GpS5U2nlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMMhDJWh+IZhjfOMUPQeQbGkit/0t9Jpi1iowDQVypE=;
 b=2vy8RZ3xvN+4ixhy1vx/lRV5/cluCao5+IhJ3PRaAK3K7RcOuC+QeEFdALJ62wED7jCV6nc6cuSdeR/CG1O8/dbwhllJJ866K24XJKxv3dJAexd+f2OZNZSLRCziK7pueROHL6V5AYGRVQatCdssjNEQNKV4GS/WrkE87qrHHbA=
Received: from BYAPR21CA0013.namprd21.prod.outlook.com (2603:10b6:a03:114::23)
 by CH4PR12MB635819.namprd12.prod.outlook.com (2603:10b6:610:509::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 12:01:48 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::63) by BYAPR21CA0013.outlook.office365.com
 (2603:10b6:a03:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 1
 Oct 2026 12:01:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 12:01:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 07:01:22 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 07:01:21 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 3/4] cxl/memdev: Add support for multi PF devices
Date: Thu, 1 Oct 2026 14:20:22 +0100
Message-ID: <20261001132023.17032-4-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001132023.17032-1-alucerop@amd.com>
References: <20261001132023.17032-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|CH4PR12MB635819:EE_
X-MS-Office365-Filtering-Correlation-Id: 529d33ba-6a92-4b75-98e0-08df1fb3c598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5ZSJQSrlzpid2b2Bi6sj3D9lc3bQq6U1F9+HK01pvgOjP2vJGAhdDNlcu7geaOSGsJLxkFZ9EQtZsdmyznHn/7A9KvgMLHhv4doKOamiK123hk2BMV84C94Lyi+KxHDhQxgpQM1319cZfnLe9fq81z9FnscyvJjO8Wz/9n5sBuGSuPMNChWcjn5r+nQKkciMJ+m2NHCfLmn9udBqNxQmPe1mFBtssaYiqsTtLuOEzNwgZktlb7lVpS1ePmliXfTXUkprcRyZia8bfihpBOmTD1Ybg+7GzCYnfyjXkIQglrT2Q8YUxc4pjyv6tg7L3ZtfZq4vtmrP4ck8DqdHR62XSIF0lsxa52bhmv6swZyPn7VxWGLGWxWdGTdQXg5B9y3TPZ7Np650TVn/F0zwT9vYVtU4S8qIG7vVIk59/TKhSezTnULWdSCibUqyiCo5MChZLonfWbp3ZV2EZgpWgSf8ZZFAsiNb/i/xy8lQAwGYD104iSXqfPT9AjoPZdB9dwrqj4I9bnGTPHZKobWGstl/8WnbWgGgix8HLdZ/nwct7Ygn7bE9ZfgTWQbK3X0tH0DL3jJwftqARtglVqMc1U5K8fzv1Wgh7jo64l4SfR9bdOeemB7F/TO4nMDsiUDob6hFsS/grwd3kiyweU/722bG4czLmR5gDpwqwK18TG50x7zv+WVBjEvyo3xUBrPfc5HWZOHnwbDsv7SYO7z/PLN1Jw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ob4oc+22soE/H+9507OaGCKvSm8LK3o3FGph8UCsNlG7g4WzEVeO5xKIdPoZQQLJ39jV5agkmbjiNus+LBHTiD/xEBoBJXhHv83LlaLJ3EvhZAiVxLpRhI11g4YXZbm04Uir/BXoVTC4Zmfy6o1D/GyZEIL65xgRuI4QCWLMhMVCJ9lBAWrjJC4PiRNF8p8i6finRpYQVAHiXgmirXVvUysx46NZmTT8Wm+7dF54pF6lzpJh5wST/g5VinesWaKE8/Lv17b/Tldc0PxUTZGYRAcsEtrCiuj3qL2pnCZpyxczRMUDQGn1UHwWgYODt7s/QLXZ39EYzc0ft9pihN/WwWnYB4uGhBdTXQ9wTQ4IMO/QsqMv9ICRFFBCeH67SCrMKwBasE5I6p3esgmWwnGNFwkHXW+jHBNBPW852bDHB1muzECFVZYOkg8W/mR4Fa/3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:01:48.3612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529d33ba-6a92-4b75-98e0-08df1fb3c598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB635819

From: Alejandro Lucero <alucerop@amd.com>

A PCI device can present multiple Physical Functions(PFs) but the CXL
specs restrict to the first one, PF0, the discovery and management of
CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
obtain the CXL.mem range to work with somehow.

Add a device link between the cxl region a PF0 memdev is attached to and
the non-PF0 wanting to use the CXL region. A CXL region release will
trigger such a PF to be released from its driver first.

PF0 being unbound from its driver triggers memdev and region release
leading to non-PF0s being unbound first keeping the CXL memory use safe.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/memdev.c | 92 +++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h         |  2 +
 2 files changed, 94 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..799cb6e75639 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -802,6 +802,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	return ERR_PTR(rc);
 }
 
+static int match_memdev_by_parent_device(struct device *dev, const void *data)
+{
+	const struct device *pf_dev = data;
+	struct cxl_memdev *cxlmd;
+
+	if (!is_cxl_memdev(dev))
+		return 0;
+
+	cxlmd = to_cxl_memdev(dev);
+	return (cxlmd->cxlds->dev == pf_dev);
+}
+
+static int __cxl_get_range_and_link(struct device *pf0, struct device *pfx,
+				    struct range *range)
+{
+	struct device *mem_dev __free(put_device) =
+		bus_find_device(&cxl_bus_type, NULL, pf0,
+				match_memdev_by_parent_device);
+	struct cxl_attach_region *attach;
+	struct cxl_memdev *cxlmd;
+
+	if (!mem_dev)
+		return -ENODEV;
+
+	cxlmd = to_cxl_memdev(mem_dev);
+	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
+
+	/*
+	 * The cxlmd object does exist and it can be found in the cxl bus after
+	 * creation but before attach probe setting the proper HPA range. If so,
+	 * the caller will need to try later.
+	 */
+	if (attach->hpa_range.end == CXL_RESOURCE_NONE)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Create the device link between the region and the consumer device.
+	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
+	 * consumer unbinds first with no consequences for the supplier.
+	 */
+	if (!device_link_add(pfx, &attach->cxlr->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		dev_err(pfx, "device link creation failed\n");
+		return -ENODEV;
+	}
+
+	range->start = attach->hpa_range.start;
+	range->end = attach->hpa_range.end;
+
+	return 0;
+}
+
+/**
+ * cxl_get_range_and_link - register a device link with the region PF0 memdev
+ * is attached to. The region release will imply the link consumer to be unbound
+ * from its driver first. Return the cxl region range to work with related to
+ * PF0 memdev initialization.
+ *
+ * @pf0: device to use for finding target memdev and supplier for the link
+ * @pfx: device to link to PF0's memdev region, the link consumer.
+ * @range: to be set with the PF0's memdev attach region range.
+ *
+ * Return: 0 or error.
+ */
+int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
+			   struct range *range)
+{
+	int rc;
+
+	if (!pf0 || !pfx)
+		return -EINVAL;
+
+	/*
+	 * PF0 cxl memdev once created and region attached can only be removed
+	 * when PF0 unbinds from its driver which implies to obtain the device
+	 * lock before the unwinding starts. If this call from other PF races
+	 * with such unbinding:
+	 *
+	 * 1) if this next lock is obtained first, the device link is
+	 *    created and the later unwinding will trigger consumer (PF
+	 *    calling here) unbinding first.
+	 *
+	 *  2) if it is the unbinding the one getting the lock first, the
+	 *    memdev will not be there aymore.
+	 */
+	device_lock(pf0);
+	rc = __cxl_get_range_and_link(pf0, pfx, range);
+	device_unlock(pf0);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_range_and_link, "CXL");
+
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
 {
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 802b143de83d..b28dce1f6f76 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -228,4 +228,6 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
 				      struct range *range);
 
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
+int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
+			   struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1

