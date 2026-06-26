Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A43ED11B;
	Fri, 26 Jun 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470480; cv=fail; b=nJatODrdVuCnNIkPMxb8uLs6EFzcNO3/Ki3uNj+A4P93jPQUDN1/W+Qtl6SaKWDAXuaV18MLkd30XknMUBxagWx3i8M79VT3lbndZmyPg8aVj4d/v+43HEihC5g9bBacV/SgomeFXjF+7Q8E0okhl+aP4rGibqK2oYKbQqi5IcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470480; c=relaxed/simple;
	bh=+kKR8vNgKpOG6Zk2t2iEpl+WCu0j1gYrAG7Pg48erIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGu8jB+Zs8WEGr8g6wP1TkUpBseyY0YXJAr/5q+O11MtEZz6bNrUwcS8mjHF1fz6wSCPczewat0IUrErg+5O3jBfjWjSH1AgqxdvYKC5U+i/K4Anx+IAJGjpxmFoMvBIzA3wqT9pHZtckk9LA539LWUL1oGrYsLbWU1cdukaipM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DoxqUgUQ; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DoxqUgUQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjPiWqe7k+GYGN5UUy+D6JqbZE6iuTQwGOj15t7iLOX38h2e99CG5N+DKTmzkx1PnXswpAjqvyz2D8dTS0kyk5OGSrvkMe71IIMr3YikWyPIaYIwqcffJ67m3UHf/mf0QPS8c3gGUJile/i3VA8/+ln+I3e04zSfmRT9WWu1znDSKmVwJPD0/VNpbfyXhJoma9cQWRxM2Y6F9Ud+ggtTcKM2ycvtsMG31YQGHyw5ItvokjWi65ApoYk+xaLN2stulzL6OMufR1prdjlbhw05v4/EIpv63iCd3bYqp/OEJPNhQBYZh+NEFZ7p7svR3QBcmJUFrv4JJjTmOgKFmF37Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI3vIzzmW8MsiIPY2GB2exdzfyAiWhjvfSCy/O3KfsI=;
 b=oxNjOjHRSCVFUgTMdw5lzpSEgJM5CWZaZUWkcIXUvTDZ5dh+OJi+B/yQPZC+jMGdUH2PyPVexXKy3BO2ymuKoItz2AEZvcf/eCv7PhIULPVnJrCYSYRl7YbjFlsumPQKawfjBrYDtnDjy6IdvN9OlJd0ETJnxx2K0zToJFeOhg+VF2B5oXgohL9TI2O426X/lHm1AiUME5JZSGjFhQzvqRNU27YX9Q5/gfPS7aIfht978vsUZmZhH7l9vuca54mAFXssDdKSnRFpeqNPHvJRYgsabg/HzsDoP+PK13i0M0YTU+9bL2RBMuu4uzmpZ6vJLoJV8ziMCj3DafSPuGPtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI3vIzzmW8MsiIPY2GB2exdzfyAiWhjvfSCy/O3KfsI=;
 b=DoxqUgUQVk0cS51s7TF+zo98RrOkeiKsGCMUFhMCSqILnZVXz3DXTIY0HF5IZxNRH5sqI9a1YFotDZxEsQy9Akz5RqaNws2NqiGhPk9E+FiPxpsFitZTCEZ23jD7pkMVGMEdryioy1TqSxad/7gLozLWLg/x2pQsOI2dOBME0JHt2JY46uyY3JGsy7JYtU/8Lq7mjUvP+iXlpPr/z40z/iAra/1U8JYmlPu86WMCPUR6NFFf6rXFxI730+dqPDMaa5yBGCaPb3Y6qg1fUpeoIRLi8fofPuysQyMcC5sO4b7ph7VvqJs8cLrfW74fbF6wlBiNFm+kXyMtD4aw4rnC0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 26 Jun
 2026 10:41:14 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 10:41:13 +0000
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
Subject: [PATCH v3 1/3] cxl/features: Reject Get Feature count larger than the output buffer
Date: Fri, 26 Jun 2026 18:41:00 +0800
Message-ID: <20260626104102.53892-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260626104102.53892-1-icheng@nvidia.com>
References: <20260626104102.53892-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 985d3779-bf30-4cdc-078c-08ded36f71b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|56012099006|11063799006|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Hkvn+8xax6BfVYdIRybxU8C52z59iBWgsj/ORYEstqi18AR5lPXUTX82Qz786wDn05yE2PQYGslwxUK5vIOOAzd5W0YRZ0W/QLY66L6TR280/HS0jDzGz0Y2rYn+H4VVjDWLHDxQlHJxPvMhlET4pFzKQJMtkhxoONJ67xx9EFCyj2U4+c+hm6/Pv/9myEgPmKdhtNUp6nEMo5+zdSTbQSlj8+qWBJHCu9G0RRQRM3ZJlwq4Wqr5+RdR5hVOIiTeBoI8VN1Y9Duq7WAn2nh6RZETIKqTrWn7nxf4CdsZcoRviG19UDBNojTihmtGVfFRt08MZCVFjpsv2aUT8Hl2SWIOrMIDbQ+uDk/+VXpl7Aq+uCWqiaKeFxm3kCayIqghRb+gX52MtUuAk6FReVdlNgy6dcZNfm//SqUQFYoLHwLxJbAuEzP2KrC5oJkCgDAo8xE9qOw/mTSdty++7ZF+WG9c2qRt5ZE5ezDxp1AKXCYTa8KkTbRZmEjJSDjubRvq5GnJ4V9dLHSevfH38eRxPkNDNfMeVoIafWPxA+6qEKg1yLtd36Yh57ryrn5pfcnwHfmgA+uDH1hX/kCmnOmQfaCIIVtpkt+lPMC3d3SZwmKSrRo8pOnHZnLAg1wcABvnj6sI/Lr2G38mACrMx7hwYIki5hVXufm5VDMOxwbWip0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Y2e54CuXMGWfX5YPY2iBI3IZkL4pgxNG85fmDofv3p+oACj7jAZCuHiu+z+?=
 =?us-ascii?Q?nMLDAkOpip0xHZFgS/lDv9OMrd3InMHmYlM2tmUeB1xsWwL6BDxjgMqzxTxr?=
 =?us-ascii?Q?CyOU2EstqEsvTKSF1yU42Q206vz86Lhao2y1B48EZ2qDn0nT0drwzeDg2Loj?=
 =?us-ascii?Q?8BLtDnVSArwGm6HXXHCxX4YbrBGbmjydeJnoG1Awv9QR8x/3Hlor5JTxhkM5?=
 =?us-ascii?Q?gS4240S77dDro0hqaMonvh1m4C6oZMymIZ1Z0Z90kI6BCvSgIGRiZ3Yjwlml?=
 =?us-ascii?Q?WhTIHyahZEW9RRj0SWvrqaVUtUsbriFd8K6EJ1ae/oIo0fJzTR/NH4nqW9RT?=
 =?us-ascii?Q?wQ4KBo9GHItyiCC1zWGmNhzE6XQZQlrMNC4qoHabqzP6dvfM4qV8mIkU1ZSm?=
 =?us-ascii?Q?nTiVo96As2TSEkTKnXXzgMYPFi8yok/5T7zteJrqYOihhivKQb/1vqI5gjdH?=
 =?us-ascii?Q?k7gxaCj7ewUEdk2Lhu4IODK0ejb/z/GzOrDTNs0VIvORz6cql40gRHLz2I8z?=
 =?us-ascii?Q?VLftFf7Uh0AzZea+7AhCpw/o7VK9aQq3F1acsfeAYWGyhcqPkWzVqQoYAghP?=
 =?us-ascii?Q?Zaz0sZMxRVYgVh/Aj6nQJ/EqUU2nh/I1+TSbjZoxOddQeOaatdCEslLp9CBZ?=
 =?us-ascii?Q?CBVMsHT1W2PmPpXGYie/eVhQ5OuuJcWw41LFHHOBN2VlaF6NxP+7Qw6havWs?=
 =?us-ascii?Q?6nrixATlFHVx+7GZJmC7+HkDr538N0QwXJCqYUYmmJQZk4yy3xQFnP4d+lRU?=
 =?us-ascii?Q?W6mtevr6ABKtex/hHKmkvEI+BWL/FhjDiTDheTju0zdGazY7vcfwepAJ0PlR?=
 =?us-ascii?Q?R6wvtXuJzwhqmn5yYX2+I0zhWlaa7oTzllJS1oN10LD4naDFmQdFLje9RKSR?=
 =?us-ascii?Q?xQPb7UXp1UbhKTiJh4PEczfJOPqLeMnPSufef2SCDhrhpXUZQCsnT2DJHEdw?=
 =?us-ascii?Q?N0j4v8/aHASW7YCAUhG1ElQQtnnhujZV8b8R7BAohQ5JoLBHRSzEj0yVxvPc?=
 =?us-ascii?Q?il/BxLRvHEGyHivw0P86+3RuLvpHZgYq+A+JshP5maqguvHdsgeA0M9lXZub?=
 =?us-ascii?Q?IOjjHul6GcvTGy5DvYVT483TaPZbztXvK5te9devw06x0rS6JzVgj8m03sG6?=
 =?us-ascii?Q?a5DYlwgzY/E8OGAnj/tCyHR0KxZZxvHPGnNjx85ZlHqRIwWZ2CAQxIEpzw3U?=
 =?us-ascii?Q?j7+rHxAqhJjfxwFY4mrNTJk+ckoZYE2+2VU5ww0D/3UL4UhKYUdhpazVrHJo?=
 =?us-ascii?Q?dlFRllAKiEJ9fY0PZ0uKVoEryXtYRCHVCL+5KBbyx/HR4GEhbdWZgDiTfg4t?=
 =?us-ascii?Q?Bv8u2ZIsFpbuLdrQM+Um6L9VSg2xz6WMhddEc4DYzTgq++WkuVauQHVug8ra?=
 =?us-ascii?Q?xgyVWQGBYuJ87Dg5VbViAyCTUxK+F7uORL1UGr2t04HNGNlqf5arfiXBz5W3?=
 =?us-ascii?Q?pa3Z60et65tnjTItnPPFlCvsrq8PN7hZyefwylke6I35sXynlqGMPPhCrcvc?=
 =?us-ascii?Q?4Dh/si7WaAv4rQFpKWUxFJBRy/OJJl4ue1sxauaJ/QpaHT5MuR3+4qRZTz8y?=
 =?us-ascii?Q?w+RdXxuw+wbxWvwM1mEFhoxCkoXFpueKsKfKRQfx4JyxKg62SoS2O7/9JR9I?=
 =?us-ascii?Q?7JVTPv4GWrJVmX2PG+dnkJdShBW1a2ARLHLNJGLmu23HM3qbSmAASBee/weB?=
 =?us-ascii?Q?HX/JMyEEN5OT7Pvyb3IR9hl1RhvBtGvP3MkkfHxyyskyiQZF+2jd7XbbdvUH?=
 =?us-ascii?Q?uozB0T/CAw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985d3779-bf30-4cdc-078c-08ded36f71b1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 10:41:13.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV+zyu92iPiijE5NNkweuDbnszv1YcbXpoq3kDagpiUzdkXtBo6mHl8MbvTcYS/HXNhjFJbd31gfYOmHzqcLEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

cxlctl_get_feature() sizes its output buffer from the user's
fwctl_rpc.out_len, but the device is told to write
cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
separate user-controlled value. Nothing bounds count against out_len, so
a small out_len with a large count overflows the kvzalloc()'d buffer.
A heap OOB write reachable from FWCTL_RPC.

Reject requests where count exceeds the available payload room, before
allocating.

Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
Reviewed-by: Kai-Heng Feng <kaihengf@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2 -> v3:
    - No change.

v1 -> v2:
    - Drop the reproducer and trim the KASAN splat in the commit message
    - Sent the reproducer as a regression test in ndctl separately.

Best regards,
Richard Cheng
---
 drivers/cxl/core/features.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 85185af46b72..9c714ee42a41 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	if (!count)
 		return ERR_PTR(-EINVAL);
 
+	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
+	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
+		return ERR_PTR(-EINVAL);
+
 	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
 		kvzalloc(out_size, GFP_KERNEL);
 	if (!rpc_out)
-- 
2.43.0

