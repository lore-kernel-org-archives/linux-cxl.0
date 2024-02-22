Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD91155303
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622661; cv=fail; b=hkHfxfjM62Nt+zOOqgI2db45jJ22wQdEX7AKwHmqB8sPWZ/71xyXR763Zcx3hk/frF5YajehhySldwvQa8mJ3b7nCjHdTS694Yf11uKyipP6uTXY26QHEa6CwMtA/htkffVhVF8sVu5aQ7avfbedf6nMtbZ8p+ByYH+4StL++gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622661; c=relaxed/simple;
	bh=fGHNxs5saWOqHvfCufVXoN/zqoZobvWFAOPyBAACD8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlFmBA7sZ0VowuYa9jjLViZD647/n69ght9xe1iayQkvQ2Eg889Fw2UZ5fAAjKl0mnIU2cmJOGbmf190CwRzibp5zFNeZ27R0AOmCRUVk9URB24tM2BWyFkTreNSu8xIxAhqvocMHIdTPaI/8v6ehggZvN+pniYjeiReSj899xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com; spf=pass smtp.mailfrom=micron.com; dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b=U++CcJ77; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="U++CcJ77"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry3SJCc8Z1O38+F8bjehfRGFfukiJZurCgCVU+ZeakR363qoGyX+W3eRQmhI/BiLNCpo8r5o1bmZ1rH1XX5o7SgYsHGf0hygm+TQYcDtscjAtai1/rqf9A3/kXonrLHC3xIeBEwZqerr5L5vqSI1ZhWtGes4FMCfuZurYseB3wihUejGunMEKoCkRkjAwcZsQIWel1LLXSS57uRIQdQ3b4/B5+u9MJ9fzOXgYDr1PAIfRdgCm3zT65SzHoE+D9eboTDVxP/NmmyH2JB+1Bqd8IU5/mECDmzjI2bFrJqV9Y/Yal43PqH7Dh+YP0grxd3WCfqxmqP6Y7NEcVtTRwkYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMWNL9y/3luJyqwfdPQ9EjWS3YwYvjZYot8wKMHF3VM=;
 b=dgx44TxiW2BzOicUbzeKWdvttuDsriQyFj/TTTCi8B8Z3uG/4ebV5Xc24Y2O9Z0TIs1R9amAp6wr8m5P6O6jaNKaGZYtbJx+jJgNxsSxLQ5heexsW50Tx7H8QvAZYmSxkHEfKsVzHiogm3qScrSih9h3PdFtuAweV68h1fSoEpQSt3tX1o5w1osNHOtWfnP+kwD845iHzwVAiXZw10Uy6TdMIevGVzeQs+wu8+umPDfL5IFXYuCm8XCJMKOb4Gi5CfO3s++t6DzwHHC7L94yL/02/9VgZRsFVLOVVVT3x9kY9F2jp4t5QGcfP/2R5K2RakFml5ghfBxPo6MMVIyzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMWNL9y/3luJyqwfdPQ9EjWS3YwYvjZYot8wKMHF3VM=;
 b=U++CcJ77ykLkzi4/qZ1IGQ1M6/ZaAueECq8AD5f5sMwwj5s6wxMAABvnT4ouIWAYTYq3vHx/sytRBAnArHPft11kkzEIkG3oiMxk7S8mDShKnSCl2iuVfsG0b0K/iRrBFx8CJkZERt68jbdBFQUKKruF1RycJloyZ8/U8uqUvUeoXMXSNBIutSP/qrv8yWFp8bb+dTl2rIFZ7UD9dvvOMmkbVGY+NG+VQLZ8AS/Z+KkX+Z3BmbPfdIdGML538uphO8IAwiWzr06RvkKARfIUG10GQxMAhFUf0f9PjH9uAkw+o7WRU4jEETOKQdzoDgytcuiuY6ypCM7SOXfmsORuDQ==
Received: from DM6PR21CA0001.namprd21.prod.outlook.com (2603:10b6:5:174::11)
 by IA1PR08MB8694.namprd08.prod.outlook.com (2603:10b6:208:447::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 17:24:15 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::b4) by DM6PR21CA0001.outlook.office365.com
 (2603:10b6:5:174::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.11 via Frontend
 Transport; Thu, 22 Feb 2024 17:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 17:24:15 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by BOW17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 22 Feb
 2024 10:24:12 -0700
Received: from micron.com (10.3.107.163) by RestrictedRelay17EX19B.micron.com
 (137.201.21.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28 via Frontend
 Transport; Thu, 22 Feb 2024 10:24:09 -0700
From: <sthanneeru.opensrc@micron.com>
To: <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
	<sthanneeru.opensrc@micron.com>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: [PATCH v2 2/2] cxl/mbox: Add Clear Log mailbox command
Date: Thu, 22 Feb 2024 22:53:50 +0530
Message-ID: <20240222172350.512-3-sthanneeru.opensrc@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
References: <20240222172350.512-1-sthanneeru.opensrc@micron.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA1PR08MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb8a890-b5cb-4169-22aa-08dc33cb180d
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h36hGzG3NcabWcLz4xkX1IF3+Qd8+QT/O7cRSehdwTFsFWvNek7GCrBRPN9rNKOnT7jFwXK2i8VJXSuBo0oMvYnzbDA4CNe2aMsYrg8HpxF0M7Oc8MRq5SP08qOcC9fNcyqcR3rDZG6yW4XDYGe94BXetJ+EtTnF6XEiCQcuZNL3NNQiR4Y3l/ffl+jVX/VSUPRuWyx9rGfbxlWBwOj3O76M1fDi+MQQ5IvnAfxQr1IAwilGdmXBL/oEFjCV0tehXZHPi5H95YFCnqwBJoWuN36Tk6CxHSMDzsdOP1VF0oewzP1bhIhfbyIziIopyU3tUKZsSosHF16dt4IVeYM3IA1jfwAenaEPxmfn8+hZCOS4/kssRu+1hN1R5zAZQHtGMea/oJrkmykgCefNA6EscA5ZVznJVTgZ9mYE090TSIvUMoJlhX0XbLZ/xFFx1IlDL9rJpM8lZPjNomp+lqUuFa4KT5YWZn+IqKsyS2EABOhwNZCpdPsuBNw4AM5K8umAwIfX6Xyb2NIW1c1Tab+XkVtegbCzf3vye9ws7IpcV6IWNI/7V6zFozhePZMB7xtvLRxBeXXlkX7lhJ/txHzho3di9uu/wr2snPpxO/A23esEzQztbsHFzyg8gcZIHOougkUMUGEfnHvPUwg5DZoHXCaJbgOZBOTJJIfsFc+E/QM=
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 17:24:15.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb8a890-b5cb-4169-22aa-08dc33cb180d
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR08MB8694

From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>

Adding UAPI support for CXL r3.1 8.2.9.5.4
Clear Log command.

This proposed patch will be useful for
1. Clearing and populating the Vendor debug log and Component
state dump log in certain scenarios, allowing for the aggregation
of results over time.
2. Clear the log when the device is shipped from manufacturing.
3. In some device failure cases, customer may want to clear
the log before shipping it back to the vendor.

Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
---
 drivers/cxl/core/mbox.c      | 11 +++++++++++
 drivers/cxl/cxlmem.h         |  4 ++++
 include/uapi/linux/cxl_mem.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 30bd8264292f..5fb01194f16f 100644
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
@@ -333,6 +334,16 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
 			return false;
 		break;
 	}
+	case CXL_MBOX_OP_CLEAR_LOG: {
+		const uuid_t *uuid = (uuid_t *)payload_in;
+
+		/*
+		 * Restrict the ‘Clear log’ action to only apply to
+		 * Vendor debug logs and Component state dump logs.
+		 */
+		return (uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID) ||
+			uuid_equal(uuid, &DEFINE_CXL_COMPONENT_STATE_DUMP_UUID));
+	}
 	default:
 		break;
 	}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 671e46538baa..af7f8a4b84b2 100644
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
@@ -565,6 +566,9 @@ enum cxl_opcode {
 #define DEFINE_CXL_VENDOR_DEBUG_UUID                                           \
 	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
 		  0x40, 0x3d, 0x86)
+#define DEFINE_CXL_COMPONENT_STATE_DUMP_UUID                                   \
+	UUID_INIT(0xb3fab4cf, 0x01b6, 0x4332, 0x94, 0x3e, 0x5e, 0x99, 0x62,    \
+		0xf2, 0x35, 0x67)
 
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
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

