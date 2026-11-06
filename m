Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793937618;
	b=cFYSVXK8XUK2LymCR9Xjm0DGOyEoJJS84N1ba4rTPmVNuFrRadWYNcfTote89BTbtsq5
	 XyOfhw9vLT00cuwx8/ydvxHPs5aWo7BJDfi1lOsoTEgmYQH0wsA75GOKMQD8OmIzEWjYc
	 HAuD6xZOraAh/bcNlKuWZcoDtvrSQvvGNWW/6gcXAQTMf6U8UiiJFRSMcyS0RtdzgQVIM
	 1uaaQLFycq+tR0/505Xlz5qMSBtHSHpulg3x/juboeiysw7ccZymu5iMlElgAXHF0YBkY
	 4/PUymRvfuoFnPSWy5903JS245h5eViLkqP+InigxG0XjPljYf3aShxvXunPkvL4MOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937618;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qNkoFABCgU5hd8vLMYUJz4U1Z4ymLQidAGulG8MvTq8=;
	b=TnnLulPoMTHxXr88WTccxnoeA1ycJrJHBR0qhnpjy2xnBrTFhkMAIJJUg5pO3OZvU/me
	 qz9Mq2NlIDHRYWUJuytzJgXtnGZQHaqbm1Uc2A+CciDDbHjSicZykXRldSi7YD0DdkX1Q
	 KR4eHu0JQsOt3uOfmazKnGL9CZTtPEgFU+4CeRTLAFZzyxdxqw7Bv+fbFFL/Nlk3VLhpU
	 13Swx3Z4CjlsmCttp1E9snGJhpWSYB4I5pshIcib1vsmQ7rR7BS8OZiENfy3Ko8vb5Fe/
	 4u3i1V/VLBt8jhR798SoUaLmcqfYIARYXcpIhU85cujh8S3FQrZ46dlwAszBOQwxL2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oo7b+PMg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4209606A31B
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 04:00:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4209606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oo7b+PMg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQ9JLJdRXBOJ9W+09F91hBWtCoHX5hVUa3G4o5Byl36oD6EOYgfDMfbcNP2PZOzpvaiu3iqgrjEeY9BMTW61njHlzZxbWcVe2ljFvdtOkFXnCRN+kOFUjhwV3bYHdN5l8h6/8DmzFeQ31lBXH9YnH6/G3AHdOBjkU9An8g3+oMilprltGoa1KaA1hb1vooDbsA8efE4590h5yPZyPKDLpN2dYuJ+/uMcwzOvyVRKej0P4LhCwN8X3+h2Fs8DZMEOC1LmlLk2aB1MGo/170TPq4HVAAlcGVQgrGdi3AQxNDcUfw9NQdV+ql4geQ41vXx4Y/f4FLQeHLYvKKJ5gFMp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNkoFABCgU5hd8vLMYUJz4U1Z4ymLQidAGulG8MvTq8=;
 b=G9nqgvHLK04ExhIge4voyBAu+Al9ndeZ7rUCtUt659oZ7Zc7BZR12ewa7CisEj8ixfwyR1jIDxXHAbaOWrTWOCOoW7g0PYsjl32QgyZ6XccXPLnMRbspeR0Q23xezicIVb93PZ/thrOtOiHaT8NiE3fPUmpBRZxNf0hQaNZn7liZ8a9n/n/T6vplEsl3qOzLzJbv5ssBFdOgtE3/iuyvnL4UqAMW6QU0ARoLDzC8o0GbC/yoaZqSCA8hwpvTQjWOqTfiYrYDadGZFQdP1PPefBexEG4nWDN0yZAhaUduM7B6CSHtVvh6hwYZayqj7XyifWmbzlm6Nw91wgChUkax/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNkoFABCgU5hd8vLMYUJz4U1Z4ymLQidAGulG8MvTq8=;
 b=oo7b+PMge6ntHPSIBQdG8c6D/Df53x3fsGXMBXGn11rfK2FFjV7WPlKwy2K88IaIcL7f48hrSu4PIQu2KII+svM3gbvZWV+ldioHBN+1rCumGwcESt6SvMf6apmZizO+nKLx+i9OvkqkSV+y15Q5/MgXrbTy16kA/JaaNNhXHB42IBahEGm2Qxnf2YPW7yjHFmX2azTf+gooWmegf3WQ5brcL7DWt361G7nj4fM+/l/vcbL8V+ZnSVxuH8q6bBN0foSHYJLPrvQQi26BGRguMyGMhAF5szR++S/XvommYmwiJJqPlelo1PD1ZPCznm56vk2qoVz83SzTsYWrJO9Daw==
Received: from MW4PR04CA0176.namprd04.prod.outlook.com (2603:10b6:303:85::31)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 04:00:12 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::55) by MW4PR04CA0176.outlook.office365.com
 (2603:10b6:303:85::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 04:00:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 04:00:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:54 -0800
Received: from cxlgalaxy.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:59:49 -0800
From: <mhonap@nvidia.com>
To: <jic23@kernel.org>, <alwilliamson@nvidia.com>, <clg@redhat.com>,
	<xueshuai@linux.alibaba.com>, <ira.weiny@intel.com>, <zhiw@nvidia.com>,
	<mst@redhat.com>, <pierrick.bouvier@oss.qualcomm.com>,
	<junjie.cao@linux.dev>, <anisa.su@samsung.com>, <pbonzini@redhat.com>,
	<ankita@nvidia.com>, <vsethi@nvidia.com>, <skolothumtho@nvidia.com>,
	<mochs@nvidia.com>
CC: <cjia@nvidia.com>, <mhonap@nvidia.com>, <kjaju@nvidia.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: [RFC 04/18] hw/cxl: Make HDM decoder initialization count-aware
Date: Fri, 6 Nov 2026 09:28:57 +0530
Message-ID: <20261106035911.1280066-5-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106035911.1280066-1-mhonap@nvidia.com>
References: <20261106035911.1280066-1-mhonap@nvidia.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 57795e60-3448-4993-d3d5-08df3bba74d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|36860700016|82310400026|921020|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8gfYk8pLrGkkT6+4IKWJuPvm6liEEprXCIDAwRE7HrHkv2OBflbW5w/EJDvgPy/yXHAQL+jtNESt6k3IiHVYKZPyOWSwD5D0SpXBpEugnmzo6Y3UJv3rukSXj+ssxT0byO44Aas4t4s/fYTg/IYTGQUZX7NyePT92PDfyIgotcGejHO65dBDM/K84v8MhFriGaRGzRlVPT2qqsLZkSuC9CGqlbi7+ZITgoVjF2Uz9JlfFjVnjxscpJC2d9HL4FmDuv396oAsWynU7BZjaxjh+SQ++1pSsvASLI3M2YlW6pCRK7dsLkeDQHhRprsM5dnYi0QrxsdktbnL6TxVtCsGbh2SOrSia3eUx7LZwhJ5dAlyUyjCxcmW7LbwbhGThwuixR5haceoI6oF4zR/LC5aa/bT2mFRMIu/hQDuo12wKuiNc0mVia/EuNuaEE8j/fiJFdjyNk2sHFBxz2dqd/9QuzrXHzDTZPCHcgtt7LW7VoW/CHPnvm+ketQj39qLn3bFaNPeXuq4fv/7AlSS/o7ZNDH2kfpWa0YKZNCqpgciFtbmVkbwnWwsXeIBWGCXRNDp2B9E939xzDhic8AwXq7rJQJJ7JttPATFx0x/xawESgKuckG24EpKhGdvIfMf1phUFTJlGkDcWDX8Mg2NjYmamj6iVImwwUxUlCFcTbq40m2sTbj+BfmG0s71loXuBsXj5Pwcig2a0/J0/xD3jwwTpfTps/jkUmm1H3A1DBFE4qpDKCEWmIZCJ6Qq7j6XMYKi
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3k3ztIUZ/jk3rTgmtenjKFew2vorMMQWDBN+m2QNQWAOViQ7/hX43qoiz4AXhN8nBJ/jOxD61zcbYirhmT/sbVT0uxBk4+gaDEG1hIWwWZ4L5jpvY8BDrhoF5xCSKaMsRrm6xnrk0jIdEfHaDiRQJ0oCtPlbLJEeGpBjfNe/9zITc3pXATFlQHN7HB9s7kPEtv4XoO8R8eINtNLuqc1EbQa8FJp+d6tdrneHQVPU3yJYlGCSmihY3U0vf9mDte7GqLsgspSlXQ7UufaHRqqJbT1J8p+DD3Gh/7r7B9KHDMYxjNjArWkYYbFFZ6KC91OkDT7Gs1/FXe+dBlCh6TdqriZ/8gEPFpc4SL7hRfsfgYMmA8AmVhDudW6PvScfLfIQMvm3KQ8rT1vy2pIOIS/HD/ek+xWXTqxn8PZHfWTZIvUq8Ij6ScbrKXAYT6m25t2O
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 04:00:11.9184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57795e60-3448-4993-d3d5-08df3bba74d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787

From: Manish Honap <mhonap@nvidia.com>

cxl_component_register_init_common() always sets up four HDM decoders.

Add cxl_component_register_init_count() for devices with fewer HDM
decoders (The CXL Type-2 device added later in this series has only one)

AI-used-for: code (prototype)
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 hw/cxl/cxl-component-utils.c   | 28 ++++++++++++++++++++--------
 include/hw/cxl/cxl_component.h |  4 ++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index bb4c3f541d..f4a7fdb425 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -323,11 +323,11 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
 }
 
 static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
-                            enum reg_type type, bool bi)
+                            enum reg_type type, bool bi,
+                            unsigned int decoder_count)
 {
-    int decoder_count = CXL_HDM_DECODER_COUNT;
     int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
-    int i;
+    unsigned int i;
 
     ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
                      cxl_decoder_count_enc(decoder_count));
@@ -406,13 +406,16 @@ static void bi_decoder_init_common(uint32_t *reg_state, uint32_t *write_msk,
     ARRAY_FIELD_DP32(reg_state, CXL_BI_DECODER_STATUS, COMMIT_TMO_BASE, 0x2);
 }
 
-void cxl_component_register_init_common(uint32_t *reg_state,
-                                        uint32_t *write_msk,
-                                        enum reg_type type,
-                                        bool bi)
+void cxl_component_register_init_count(uint32_t *reg_state,
+                                       uint32_t *write_msk,
+                                       enum reg_type type, bool bi,
+                                       unsigned int decoder_count)
 {
     int caps = 0;
 
+    assert(decoder_count > 0 && decoder_count <= CXL_HDM_DECODER_COUNT);
+    assert(cxl_decoder_count_dec(cxl_decoder_count_enc(decoder_count)) ==
+           decoder_count);
     memset(reg_state, 0, CXL2_COMPONENT_CM_REGION_SIZE);
 
     /* CXL Capability Header Register */
@@ -449,7 +452,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     case CXL2_LOGICAL_DEVICE:
         /* + HDM */
         init_cap_reg(HDM, 5, 1);
-        hdm_init_common(reg_state, write_msk, type, bi);
+        hdm_init_common(reg_state, write_msk, type, bi, decoder_count);
         /* fallthrough */
     case CXL2_DOWNSTREAM_PORT:
     case CXL2_DEVICE:
@@ -486,6 +489,15 @@ void cxl_component_register_init_common(uint32_t *reg_state,
 #undef init_cap_reg
 }
 
+void cxl_component_register_init_common(uint32_t *reg_state,
+                                        uint32_t *write_msk,
+                                        enum reg_type type,
+                                        bool bi)
+{
+    cxl_component_register_init_count(reg_state, write_msk, type, bi,
+                                      CXL_HDM_DECODER_COUNT);
+}
+
 /*
  * Helper to creates a DVSEC header for a CXL entity. The caller is responsible
  * for tracking the valid offset.
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index d6fdb6c1ab..3ed8dab92e 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -312,6 +312,10 @@ typedef struct cxl_component {
 void cxl_component_register_block_init(Object *obj,
                                        CXLComponentState *cxl_cstate,
                                        const char *type);
+void cxl_component_register_init_count(uint32_t *reg_state,
+                                       uint32_t *write_msk,
+                                       enum reg_type type, bool bi,
+                                       unsigned int decoder_count);
 void cxl_component_register_init_common(uint32_t *reg_state,
                                         uint32_t *write_msk,
                                         enum reg_type type, bool bi);
-- 
2.53.0

