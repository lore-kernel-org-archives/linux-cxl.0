Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296273E1691;
	Tue, 30 Jun 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782805636; cv=fail; b=Y3k8GkFv86oUT51pnUKxfnywcyZazuAgJkHL1OFpAu7kPEFGHUr1pOJqMTvyE+Cid0eYnnYRWi8XFGpR6UaA/rIWfIxtfUxGF8siOqOQARAYLCYv9QiJLpxezDoAVNA/+hvLK/miOqrUxvxrtbXNdnh0znuQqaAN0m4Rkk4qpAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782805636; c=relaxed/simple;
	bh=WFQOql+ka2XFm9DYg0E5IyyzONoko7iopg/1+nUL2Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LP+CuGkRRsleXfhskQ24Xzbv1Et9zlcODGy5vbT5/XWdFZARMWsNPZHsVYlXwzJO88i7Ns/v9+nDeSCthakAZnr1ONI9F0wxBMbjMct94zBuk3Z1k6Iw2659GJ7CqT8gbAsb4ZHwpig6hkCW0vjV5O8o91HSDB30q03XfG2CTdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6oLQ5g8; arc=fail smtp.client-ip=40.93.196.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6oLQ5g8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uklboBn6RWbbhEB+O6HxHfIFReeoccwUABek7lIrZIiE6LuOFWjQdU0WYEway9eRf/gskx33UJN2pOigbgCd2eOHWx/Ulscx+oFuRd21l8FT3lvMmKhZNf8HR5VadSDj6UHnOTRt4MtTgNHmR74gX6h506Wajw4U4aeUJ8NJ44ZiTafnkMHyHmRJ3WrCBRH4YpfKTdNtAQrElOEo8zxoRQiuqZOwi6UVQxQpnC3R4Ii8o0ht1R4EjC6CmBCexA/1sBuPyUwtxhb+V0+eXjffgdwKafl6WjvpKo99/7EH9/PrZp/52PLulgi6kocZHFz7742NGdAV1r6SCfviFsjvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSFzsfonIT4AhWJ8+Yr2apQfhFCcTXt1EsSCs+uGbJk=;
 b=jLv79De29fb9cu2QZLb3PJHOLYZ5Y9VnC68F3PqmotbA0VpgMDpRzWnF6eg3TSbEwuUJ2eOcZ6WW/NlBxP+Tv8suxXW9eiQTEqsDb4K8y3VpxXs0yheJVNlvYaaTUuxx/yFG8tpC9mzgiOfmQgyMfj8tUcbXKLbt/VjenUeUAMTWsHuA9vogDphDPYIr553mexqqVd1cMwVrwfaq2jfbKn3DQdsm0EnRMuLDuzztnNuk7uwX3KOv3DbdXLV41rIaKiiaSL7U8d5BuHc8zaDKQNRnlqGm+RsfcegfmNRYNdVC5jQoSvHf6qm6qPtA5s2uFAAUQWRWj0YYlqtW7XVJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSFzsfonIT4AhWJ8+Yr2apQfhFCcTXt1EsSCs+uGbJk=;
 b=X6oLQ5g8RbQDW54x7pw+qZu3CXMHUEC+Hoh6S+pCHkPLMtdyP82WibkHPMuUrmfykzfkxH91po9Ui9K+GOIYJOqsBbvKSy854ZEgjdkZbFy/txbxbydB9zI1KLVeDg2i0UeHx+8VwDvzHD0tR0NduN6bxAwM4O3USBbOBwOsYSCL7Uknh9UJWGw+bcr/7RfLuxWBJ8EOhQp4SCb+v3dNMRfbXEtx/GMfgqbfWX8Ep+KKj13BGp/+MB+ygIyX09uFcony1HJn1+E3X5F49ro9QLTjUYSc17zwfr0LGhyxEuLznbxyq1rNYeXqkxs1Y57Yqe73QtOJv/Llg9jlupQwDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:47:11 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 07:47:11 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH 1/3] cxl/features: Reject feature offset that overflows 16-bit field
Date: Tue, 30 Jun 2026 15:46:55 +0800
Message-ID: <20260630074657.43077-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260630074657.43077-1-icheng@nvidia.com>
References: <20260630074657.43077-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: f64d5188-3fa3-4c2b-a913-08ded67bcb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bk1XJvrtwc8wCOS3QUaEp7yVprJOGM/6wIbAkZWcGClyxW9JZg7KNFOYIsNxdwdqtbNZZ+uUR0GqNWL8O9mvjaSLkHS+bllqdmH6iVKzruNSAC6oDT/ZuMmZHhyRzIL9Lp53b0O6hfeqtGFfvZKiQDN7smsaDEFnyvchlyj8X66OtKfkOwO7EKj+eIOK/K8iTUcDbnC8NZRP9Lyc4barbs9z4Cy73/zHDU1zgu7LGRo73yv+HFPH4f7CMZoJaCaYUsH+RdyI5Iy2eGBzikSduKd7ZfzEprEt3hvzZQ6J3aw0j8gOEVKxJ8WH2NekTJ9eIuyqWI9TVxlHaIB7op1PgK+ON/eOLeyv637RpkfdNFeHt69sRdoNbndMnbYTLEFS0pZ5IY/RU/dfaenf3BGBRaPCpiO9fJDUNSEiMf9HapQEePg++JNCuVWRfyIaW8yUplyRf2NI4Ptqoo0TghTle/QEdQjSdn4OUkNUFtF62iEitxdIPBE3s6Txj5fTZgL0nHjNoBLWIfYZxnG0dLITtho6AMGzOCvC3OReSyPpW+j0Ci9tDa73ZepEJ4ZsCRbSwlPTMhwBudntZ6aWxc5D6Pas/UiAjwCt7gKSgLLOy3/qhU2xCQbisrsBfEpgtkcrwpIGRPiPZzcvajAGekVD52mdut/LYLNNZVE6MBRzvl8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RKE39dkxaJeyFI9zaAmCcWxelg9bDBYGHRuJ9EG4PfS4Jk7W2vj8MCe878oT?=
 =?us-ascii?Q?s5Wc8fjCJkjTMEd16/xPF0/7opsAVmVmCFl4VDJQ9dZGmp22WM5/lloGeJhJ?=
 =?us-ascii?Q?rA3B4Z3+RdHzlUzihnC7B6ZPNSWcqP3cJEeD/W47xxAysUOTIKfwezynSYxw?=
 =?us-ascii?Q?xgeqTQAHx3ezIy1db9zKFhCqSQ92OUIz3k4SI5R7QjgafARNkitWrn3NQ0wf?=
 =?us-ascii?Q?l5htp1TXv80oKbc2L4+znfNMQqwPYpHmlzfkShtCCvZoenLv+FH9xiYkIN2d?=
 =?us-ascii?Q?OrRaxcFHy+vfIFFAAuTDc42HLCYK2LD4nHBsf9S5Y7iUVSj/FktAaWGwKGn5?=
 =?us-ascii?Q?GBuMS7O1jniTuvLHSlDLA3eNXkH1AVIVAmBGjxChN7xndTd5r8oRgt5ye0fn?=
 =?us-ascii?Q?uV3v3Q7Ws7gZOszl1p5fVkuEEZ/rF9jZktLJrFJchdF/g//eirMSCckVPIXT?=
 =?us-ascii?Q?Y8DqbH85O1a4J1GE4/ybfP8UnnzpTklmMJmetR502bNA8RVjgHtumuurWtMD?=
 =?us-ascii?Q?cHncBu2wTqgFl0Dc0ozCh2kZVs2EL/MPeqnufrN8Saz+eH86X+edsAhk7+b4?=
 =?us-ascii?Q?sJh6EnZFCyLVf8+ZZRG89SAkNBOMa1xA9oNWhPtYpv9U1cUAlpmRBEbrgF50?=
 =?us-ascii?Q?1L4tls7gqrt5wMFJcFIswNE+R58k1QgitIXzpg/qembaw0oMZZBQnN5EylHU?=
 =?us-ascii?Q?Mjxakesils0qV5a9S0fmJgFCUwdeBHf4dM+kr57q6ac8CyCCSEb8HuQYMSg9?=
 =?us-ascii?Q?zSIyllztKgF3GllGG07yEB+F04XJDMfb2s4ffAi9TyrG6u8sojhkikgzmRSt?=
 =?us-ascii?Q?SX4IbpKBMCOCDNzhguBrYiS9vWSs8CIhwh0/HBiYlmTISZroLg9hstH/LUMK?=
 =?us-ascii?Q?XpK0BzXMrQtDVZ4ULACQx/9nYHg0u/OXU5Q0D1N2Jz1szeLI3OrOcL4x0QmK?=
 =?us-ascii?Q?FCxW36H5TvwE5aqzARavGU7uPU2G1eCqBmkPh42LvzZRQjTWyfnLiUigsBg+?=
 =?us-ascii?Q?gC58Mj03uxmbGOkxui3id/GsUtVVIEnlbg5dLh7xozbvk5RUjUuOUFiyUHO5?=
 =?us-ascii?Q?e4VbbX/oym8OHXB1kpn1TBMEPuFpPdCb0zo+VJb4VAAgqKm8mSqOUUb8tFa+?=
 =?us-ascii?Q?d9YA4KRCGsHwta+kVphFwgkJeaPlNdYhnLe8P6H3qkP9MkuYVUiCaEOQJ9vZ?=
 =?us-ascii?Q?uBBvvaJKVMJ6ACz2I7bkRyVIfM9XgjmNUk7RdBiCsBr2hWIKxxtfljUH8Hyh?=
 =?us-ascii?Q?aq4mEUmETOZktNI6aGouHzPAQQ7SwTER8x5OyP0BrZcsg03C8KA8rml1Z9zs?=
 =?us-ascii?Q?XGA1uUPpnf4I7HCdGSECG+DEm3MPXkgmqa1AMBdeYvLOHpbzmTQACxKKVgHr?=
 =?us-ascii?Q?J/9Y6muL2CDVCUgJAjRIMiRFi0C7miFeqbLAqjnVpPMBWK1ZgTBXp4l2CDQS?=
 =?us-ascii?Q?3yGijt5ze+OXPI/v+fWmD3Wy4Iiiz220Hbai4SZ91PnAUYJhRv9g93yqLrHg?=
 =?us-ascii?Q?Vc/WzSSXgR6UUBFDNF5NYz7mwMxs1PxFhdWP89C1BGCkfQ+PxKwX5AxmTDtl?=
 =?us-ascii?Q?ZWvF+W6A4j6kpbz3jq/3ep4wvMOqoRM/eUM5B26ZlxhwjSOHjaXlxlIZ9/xU?=
 =?us-ascii?Q?eQ9gq+wjNeZVMYM6I1m6ugLecG2dOOck0YreqEmicluw6K4tU5lrtXA2VQTW?=
 =?us-ascii?Q?EpYfLjry6IFiV5lgBhgzUW635c11GaMn5ROZmb6SUABNfdforikcaLlBAqrD?=
 =?us-ascii?Q?cUqpnSKkjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64d5188-3fa3-4c2b-a913-08ded67bcb59
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:47:11.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0p/m84IM+M/HQkRE34RnABhh/ySVupJq/WjveIqnhWoLrO914EXSDVhxbvmORtqhmsAhLOIknwPUX6XUvOgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

cxl_get_feature() and cxl_set_feature() build the mailbox command's
offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
check the sum fits in the 16-bit field. Via fwctl, a user-supplied
offset plus count/op_size summing over 65535 silently wraps, steering
the device to the wrong feature offset.

Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/features.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 85185af46b72..db5964ea184f 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	if (!feat_out || !feat_out_size)
 		return 0;
 
+	if (offset + feat_out_size > U16_MAX)
+		return 0;
+
 	size_out = min(feat_out_size, cxl_mbox->payload_size);
 	uuid_copy(&pi.uuid, feat_uuid);
 	pi.selection = selection;
@@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	if (return_code)
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
+	if (offset + feat_data_size > U16_MAX)
+		return -EINVAL;
+
 	struct cxl_mbox_set_feat_in *pi __free(kfree) =
 			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!pi)
-- 
2.43.0

