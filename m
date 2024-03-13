Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60315EB0
	for <linux-cxl@vger.kernel.org>; Wed, 13 Mar 2024 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313961; cv=fail; b=tym1zS40N4p4hgWS96CXtVfe2ECjTmtCTkrwTOXVbDpG5c8ufJtiky8JJcksW6Qlb3D4UqiFJovAyYDQjs+EJQemi6KS7ATBMcHs0tM9/gg0QacChzH4aWhsubXUA3+BZYAKmxl33Ahjea9PYKHclWCy7RWx9uNW4RrJnh8tIZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313961; c=relaxed/simple;
	bh=nIe5ffLYgTxjpxj66Zyu9UkvTVDYJZfScLq5bA6puGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lytlIB9cntmfq4yhoSWhd52XfZNQGvfF8paYaCv1O1CPQ4+IJGbiMwKvt3K+YYSV3dcrQIjiSkfwybeSuiJWOB1Clkx2mO7SePc2c9Tbd1Cz+Uq0ACFkGpf/jYqcyXIhMFwFioVCawZ2EPGqimxEmBkr8gI4Y2gOoZOp/sFL0/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=m8nomge+; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="m8nomge+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBMSQDqwhFPsIirYwFZbJiL5uupSXnzZsnu4TDpu+4brvZDkZmi3Pg+aVwGCOdmYMyrn7cP/VqGqiGwOO6uuMNY8+2l2ezZU/9S1TnBDaztLl40pUXdCVUugELxX7yr75rSiXZg8n+323qVdwlc6OvnTjYMGa9aMkk3YB42HOV5Bf5Gt/MLTXvDJKS/2P8JGuOpAWiuhmpGm89rmq29ZrHAhr1JRN8gdHOjYSBlwvpW++yg66y0ERRgHchoOCOY5H03Ez+sLB1IDQw1QmlLr74x8jYu/4R07GVLI39KY5sJ4L1kSgEev25X+krk0uHEWPJupWjDmAoBdIoNW7g6nkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpQtlxeaxHqz7ePih7IsC/k0cB2+J0Ew9+hGvW5CCHE=;
 b=k1qi97SWDHsDIMJDyJDC3eEmT9j2xhg5AHIUl5vAhHK6SUlEXzkDj6NZjTEMfHQYBAmwqybrmL3NhEYefVpY+D1esFtR8jOZ73hUSaCjJrrcCaK2wLCJ9i3/uJNe+RXq91EXgq2OfPeguBKfE7SjMV0tD2WHWoek0WxJhcpVmk1tCoIq17SPUYtVOAvRU5ybs7AYpbQB2QyS/QXJZGlYpV5ncIs3c3c2zIItMc8zV21GE0pMv0KqU2BHDIgKK1GNY5Y7K1j/xqme4CjyEmCQU0wUjtlyh4PPD1W40GuCbaLX+ywFmTeAKROejv5HtePAbktPXodh6bf3kkGeMFxH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpQtlxeaxHqz7ePih7IsC/k0cB2+J0Ew9+hGvW5CCHE=;
 b=m8nomge+I+4TH1t/Pff6DVtmBzXKnfRt39kvr6cghiZaG+DX4/0hZbD6ar+dA04bRtRSJRY8kvqgyP5t4NZRDYUpeM3Lb5epKalWKCkVFSK6MbT94gyLMcj9WONcNmiVEYgLDV21yQXavrhhzQ5GxiR/UaT98LHmSiSJLO+Ll+HH2qlAOZAY1ltcdok6NSLxUnyddZl+niN20X1tCWnBIDnnHG9xP4MrCGeziCM7V/OXZLFimuFfCycr3khR9+dh80yVbQK/SbTGb4s/RhAFjVpaPw1js/Zm9jDwZYLo5bbrn1X0W8luDiJD80H0mWYldz0vJKbkxkJTTAtmH4q1iA==
Received: from CH2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:4e::29)
 by MW6PR08MB8797.namprd08.prod.outlook.com (2603:10b6:303:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 07:12:34 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::20) by CH2PR02CA0019.outlook.office365.com
 (2603:10b6:610:4e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 07:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.0 via Frontend Transport; Wed, 13 Mar 2024 07:12:33 +0000
Received: from BOW17EX19A.micron.com (137.201.21.218) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 13 Mar
 2024 01:12:30 -0600
Received: from micron.com (10.68.136.12) by RestrictedRelay17EX19A.micron.com
 (137.201.21.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Wed, 13 Mar 2024 01:12:27 -0600
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [PATCH v3 2/2] cxl/mbox: Add Clear Log mailbox command
Date: Wed, 13 Mar 2024 12:42:18 +0530
Message-ID: <20240313071218.729-3-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
References: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|MW6PR08MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 05087899-7351-403e-cd1b-08dc432cf49b
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MpjXsOXd4IMugxE5MrTy7nfzJKCUU8kYe21J7Hq8mWO5sCSVN7NYOWLhPTKUNQeIzDDoQCq+2z8t7LChmbnVYPoTZcLZPe7uKau12UId0MRMBUwnIhECJ7p5Tv0e52RPphUUn7CiPxXEEMs1xF2iMQg2QpUH44IwrEUPf5gVFNf+f+6TKbL1jhShZCVjkspCfaT5KuwGcaMis2WGzsu1UymBXQnozwNon+UfrwiLCE207u3klBeboSdxBWJt/tXH9UXobT16Y2wo7hGQ2uz3WNV6EDoR+q+b5pXGB481zSR6rHElBV17gl9+qsXzqQw0hFadZl1PuweqpvH6n8MoRK4HKR1QbNc5pk+qcyGgGshrCQ5bgAtrdFsN6LFw9LBxN6HzaAwKV8PpfrJpQx0DSC/jmq4aa7rzsmnGabHMa7ILXsflrdGqsInSfkUPGak98ySMOWx9W+oqGIT1C0R5tWomMAHvbD7aZMmh1bgg8YL/DQ+ric7SfpLRbS9S2VnGx8uQkbSoFaRwEpzm5J9WXNQFCdsRK8HLScypk+QeJ1APdZ8ypdycNm6b4CBWPSG0p6KeEgbe7MBTye3U+TAEn0sAmw7/VzuPb0B4VJQiDZZPdNYbYohMjgUCAghQ1RMsyeqCJoDCuanFagKokF1FChuLnfiMYluZpJ7rkcnGoz+HAON/qE89jc3pOcE6HZTNWlvScRbj5sJ6AIcRECZYzv+BIsRssdMpIvPCbVX4DcnBXmZsM/fqDwMsmSpH3ZiC
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 07:12:33.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05087899-7351-403e-cd1b-08dc432cf49b
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR08MB8797

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Adding UAPI support for CXL r3.1 8.2.9.5.4
Clear Log command.

This proposed patch will be useful for clearing and populating
the Vendor debug log in certain scenarios, allowing for the
aggregation of results over time.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/cxl/core/mbox.c      | 10 ++++++++++
 drivers/cxl/cxlmem.h         |  1 +
 include/uapi/linux/cxl_mem.h |  1 +
 3 files changed, 12 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 30bd8264292f..58437ae56140 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -57,6 +57,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
 	CXL_CMD(GET_LOG, 0x18, CXL_VARIABLE_PAYLOAD, CXL_CMD_FLAG_FORCE_ENABLE),
 	CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
 	CXL_CMD(GET_SUP_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
 	CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
@@ -333,6 +334,15 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
 			return false;
 		break;
 	}
+	case CXL_MBOX_OP_CLEAR_LOG: {
+		const uuid_t *uuid = (uuid_t *)payload_in;
+
+		/*
+		 * Restrict the ‘Clear log’ action to only apply to
+		 * Vendor debug logs.
+		 */
+		return uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID);
+	}
 	default:
 		break;
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 671e46538baa..11a5cd4f3ae1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -530,6 +530,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
+	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 49c25056c222..c6c0fe27495d 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -48,6 +48,7 @@
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
 	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
 	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
+	___C(CLEAR_LOG, "Clear Log"),					  \
 	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
 	___C(MAX, "invalid / last command")
 
-- 
2.25.1

