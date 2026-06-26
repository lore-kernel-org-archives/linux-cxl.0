Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491143EDAB8;
	Fri, 26 Jun 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470488; cv=fail; b=hl/N1sL4SnAwH6DtYanucqB+cNBlfAWmsHlKzo4eHDbcoGaVx/ee4MZCuama0+M3aWwdabv2sIQTngLATLxUstzbhjuKRY5KrQoO0CJbABARZhIHlsLBgX6Pe7CG0vQhqhe2W/G9a5OhW7x/6xoHpwo1cLrR/PAr6HN0Y60hdxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470488; c=relaxed/simple;
	bh=KCV6OXuyIjU2TG8bpZCESnVYhbd++IQRqm6eWeXW7iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MV3K7NI9Mr9Ool+i73MUt/2Y9GGWCYcobZqfRIb3PyMJHlZhuOG5prs/yrNVCqG8FejVXFtfYKan1Ms/r3JhuJ1eJhY6M7JLnf39K/mSlUkOodj/un2eB7gwWMxVvyuafbdCbT91GQ2w8H2V7QrCtoUKsBTpTwcmci1s3CBudLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eSpJFakJ; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eSpJFakJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akIxIRuKaGtWEvxEvT/OFJhHQdDd/6HS52NgcFRY56PsBxguA4Hla5qORcZ0smHx5yRp3upgJxiPJwL02kLY6cloFg2wJsNjw+5zux79i4Rg2q8RFxAKxMvVy77yXTmUmhGAJFeMdFsgxXI0mEtbeyDAHWF1OWS4sNncRi1GXpD2b32Law8kDtbS1TUmKH/jNUegIMaiN7KUXcDPV3t2ZlV49UqY/+ipB+tLkxzADCfu5mTV63k01YPqkuDXJ9v+0qMzCYdgkRsJwWO3EoHcKj4aRTWK1+cUfBQ3vAwebJzksFlAnzc9KIW1ElcBlBV6E58825FEc9BYZUrqzKPhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y0lOCsTMN8SU9/0I76s9Ql46r4XPLr6XrEq135610Q=;
 b=T+T8oDri4XY6+FUJq7ElVvhasXLHXOSF1ZjkN2hx/52GXq3GAFJ6YJpTAKSX/M8oxCigSLhQ7JMubdtHR/gldH/88uYBcRUxO0GTTA0XL0y5rpPswUc7phZBOCMT7MgY7Vjy24oDLHRF2y1LEbzbJQ1YKIZGAOr49RIYWeOAOnVFAejwbexSQOlHKdiOiMNRRFqFRLcTMOlVkvinaQjOKUqXKJnRInrDjyKHE5sf8lS/nuX6LrWgwD3hCEGgufShu+GdHnAjKJ1y+Rqqi7HWtHXyCJhAkN1Tgaw4zkI55rwoVR+v/2lTTn+63oQLOjtbrBQ3Mvls/MeerrINIZVhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Y0lOCsTMN8SU9/0I76s9Ql46r4XPLr6XrEq135610Q=;
 b=eSpJFakJ6obWYeaN/56cImUmEymikOvPzkyFpJ5IKZySYMOLAoiNySi+3r+GvxcN8hZhkXSpIxom6QAf4SfRg94OUCn8u4SCWcaCwL27dWFr6L6r3toLVjBue/kGSwcD/20VUCaJCbbz3ZI45sobpmaHwsq/kZmIr9dNNX0dMurS35cXFEm3DhaIAHiZJdCalaXhhLXETZ/Kg7GpcJTDUs/tHHrtpSpqHbXLQwSAPkstTTluSA+/1+g3jHmqbGwKwVBWjL+vF3rcXp5YJlhIGHVWpuZBgzFc4eUlCH4Fra0OfacjOxStprciREg7E6UPnhW8dszNiAK5uDYVIMKDDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 10:41:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 10:41:19 +0000
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
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 2/3] cxl/features: Reject Set Features output buffer smaller than the header
Date: Fri, 26 Jun 2026 18:41:01 +0800
Message-ID: <20260626104102.53892-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626104102.53892-1-icheng@nvidia.com>
References: <20260626104102.53892-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0050.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::6)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6ddcb0-6cd6-431b-5bba-08ded36f7531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hXlVfDW6k/r0WOvcrupIQCa1BaiBYNJ8EkjC4BjB+GuXTpXmELzjVU1W41s0qs2r1bvMQB0tcHo74iFhZwO7OhA08rDH2kD44F/GmtOKOZolLR7g+LJHcUZkAiNyqdOOyovI2WxjnoUIjUxtdvNFMkP8zQ48OtiFdTY2vBGp0wvRSeLTXZ7VKNSO2AxT+/rIV2Mme14UfsAP/FeIus/gh6WDCjj3R77tb3SjW0zgG2+1nfWnnePDzjSMgPqZ8vz3kPykOgJGUTH+bkVNTOlIlEZTXW6MM2IUXtuybzaHtVKmdfAONp3eExOD7hSHtPB65Cn9MHPeG+e7/2US7AcRTmCEBDEDRqDsjOonW+nxgHrMdrdt22iv7RrYndXfYYdtW/Z6E9om1jlNT1nYcZnJIfAwscEcgKEHsEK2w7wjQHxubuYRa1TiYwsV0wcrA158jFp83EeB7SJPGR9PKs6rrv9Myhx+dsXsYjmq9sbZK+02yaLlrT5Jt9eq+w7+Yln0PAcaYkKRy/R8Bynj/wf3l/DYbHmZ7A3WMLodigh3Q+eST72X/Ue7s1GIJMRtMSJEpU/g9pofSN7UcJBkPqvyfyfO6eAqEdugsCeStnVg2uz2OJiM07ZkRAYSxKM75TS6c1VGo+e3s2cfcGdlewJDIjdsKoo6Ef4FL7L6MYLEeKM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1vPgdNYyUdmZMHoYXfU2y2ePnL3JXGHsYPPetWvUA4cILOlSDzRbzwe5eEu?=
 =?us-ascii?Q?zrvZXdiLVx7etNMFEv1JdWb4mFKHimdIlhCeIAkK1tO5/r77iSNDSDcgyLp0?=
 =?us-ascii?Q?rxwdzbMi8bP70F2ONTknKRp+K5fKFxaXQuV4UcUAOwBAtWcM07YAuI6ggL2o?=
 =?us-ascii?Q?KlNkGIZuyBaI988npQK/0ndRUZejs3PQqWp5YO9MFbuqbuhCNbsIkF22Op8M?=
 =?us-ascii?Q?YSRn5qAOibQC+jWKTyZlcmtFR+ZcVbwFoeBH2ieiBhOBpcA4BrIcVoYvyrBQ?=
 =?us-ascii?Q?izH4K4mbXA/r/7mU5EthUZhos1E7zFn/cE9OA40ZQ11tM68rZ9va2geLXZ8h?=
 =?us-ascii?Q?i1spbqHxfjCI+p9tVO4GU77S+8cAwG4J3gPvihq3e7DpQeDRrir6LcJRlbWD?=
 =?us-ascii?Q?HlBqs6ifi2fsfjCAp22d//Lu/GxQLBp4lCY6pe5uyWKgiODGI9GxbZS/XqKf?=
 =?us-ascii?Q?V+nu6JEg9wR6o5ipYp9hcXoux0E6rzwyfpvDbrhNwMM8XzOdhb4scJ4kzhHy?=
 =?us-ascii?Q?yW63eZeCAUvT4FgBCGmskFnPnsHOP03cZ+hbJahQXwqDvwrJ8hnKrgrG7IWB?=
 =?us-ascii?Q?+Punoh8SMmuhGDOKP5JQmrldeGOPgoiSmDXy9kksJIUMl5kuRLi3V2Zhd6rt?=
 =?us-ascii?Q?D8SYtnGJ7BzgIzLRI/NEOHPmskjTp4OSiYsZv84ic6J8ZEIpplGyaGgBf0/7?=
 =?us-ascii?Q?V6TcKY+rOt/DwvEKIpkqp5YZ0l0lmJbu3fCr6xvve1PX3eDLGAYAPgVqyUi0?=
 =?us-ascii?Q?JVJIHmlcrEUNcKBT0qOL/djspYNCDM8y6rGi/peKkOl4APdHUlTd8ofp44WH?=
 =?us-ascii?Q?2y/pUoo78QDUc3NYsGjwvPW/7670gPzl8qcKhLiyzvRE15EY3JR/Lo74dZrk?=
 =?us-ascii?Q?kyqAUTfs8K0cBiAlz9Il7rH2MZ0g6f98TpqVfkvdTgl1G/hUV8MsN/MnI12g?=
 =?us-ascii?Q?GGoxpvRl1N62N/9mMEqJ+I7Af4ff5dJ7vc8UiodA3sQzk4SQl7g14lUMJFjI?=
 =?us-ascii?Q?EFAfjGdT5ahVclngiU6UdfD15vDx36QHSDlYVs7fX8NuAis2bQ5LTMpCz36W?=
 =?us-ascii?Q?Tl2sB1NB4Uu2Fx23fY4UuOcg5q0qMsLF6Dm8tBqe1YULylHawlIxeh2m99vh?=
 =?us-ascii?Q?zGixd0bwLQxiuRiiJV0FxaYvdAmL00XIxnMPkTlwLQ7BVk03nV8tvN2lnoDN?=
 =?us-ascii?Q?atO9wzNCBid04IJ1rwGC+2JLa4ePxBLpggGtLXY3bCSnMOo6RJF6khuZwsYL?=
 =?us-ascii?Q?i4VH0Q4JJFAf655gY+CVy7NVuxPb8ytXSET7lpoqKD201OkK2VASBCRHTxdo?=
 =?us-ascii?Q?/kOR5gMIDGsj22kQCGs+RfZ9erO6aeCmfReLYPyk9Pc1EDp31ejqQRflK5tn?=
 =?us-ascii?Q?UeDQ53A8dl+GhkuYWu7sCqqgZkm+q6KJqmVL+BckiPW6RY1zkefSxLrlLPPL?=
 =?us-ascii?Q?gtz1ZJy6SDIwzJIGvM1aZEHmFB/3fPS9yr2BrKdFzqScAvVAzBfKj5gBBBXs?=
 =?us-ascii?Q?aljXUnLhcA+xkeG3xtLwru3aIG9xzNDqyt+ZXwLl0f4fNj0Dt7vEAbLFyO1C?=
 =?us-ascii?Q?cxF8yQlN2pRKNUx5j0/kE6GHn3IfDO/jrJmCJe0rJ8CLjjSJ8G0XDDFw3fvJ?=
 =?us-ascii?Q?4WPVHAe8bm9FZEDMmc/Z+uv7U57ZzTBIaMaITiv3jOlj0YgDmBE77hJF0ORv?=
 =?us-ascii?Q?HI+O7pKQnGdUVZanWEZuK1oeudYdY40vDRKBXV3KumtCKjtJDijcfOU0r/l+?=
 =?us-ascii?Q?6pH+Qy1e3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6ddcb0-6cd6-431b-5bba-08ded36f7531
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:41:19.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kfpl+6RBh87ouM92ebKrq1xZb6ko6QJXPXpw0BN0mNGWVFBtC5QldM17YKeBouO1NSZuEtVZxxTjdnU+m3r0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

cxlctl_set_feature() sizes its output buffer from the user's
fwctl_rpc.out_len but never checks it is large enough to hold even the
fwctl_rpc_cxl_out header. With out_len == 0 , kvzalloc() returns
ZERO_SIZE_PTR, which passes the !rpc_out check, the subsequent
rpc_out->size = 0 then writes through the poison pointer.

Reject requests whose output buffer can't hold the response header,
before allocating. The Set Feature reply carries no payload, so the
header is all that is required.

Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2 -> v3:
    - New patch.

 drivers/cxl/core/features.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 9c714ee42a41..ed18ccb5e236 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -520,6 +520,9 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
 	flags = le32_to_cpu(feat_in->flags);
 	out_size = *out_len;
 
+	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload))
+		return ERR_PTR(-EINVAL);
+
 	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
 		kvzalloc(out_size, GFP_KERNEL);
 	if (!rpc_out)
-- 
2.43.0

