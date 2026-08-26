Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F241282F1C;
	Wed, 26 Aug 2026 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708781; cv=fail; b=fs6SawpHtznQwIsAZ4NuEySUB9nhzGGowOYzM+dDVd/jPW3WiAAR51cgLVr6qfzeaAHuRTW+vKXr4oc8bTPzFhnfqTujSgPXMdbco3a2+/iWjeC9PEPLWz5QPDNo2XDmCMswTqmcvCJ1dcdB5LI6bfU5SmHc6g7CgUa8dD/v7UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708781; c=relaxed/simple;
	bh=dDvBQTgWeYn/eDWsdViByxzvVUY9VP0smPhzVo9kOfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wb9bDUWoJXwV421izyquo6qxIcqraQl2RwyIky/oW58Sa4esfpfApSDe5ZU1FZP2YZDakapjT98H5BOAD7t1JDsnQ0iR4r5BZHzd/UCZs4MA/8xaqpDenbf8vFkSHps3lyRX4/MsYpmGy96KlUxt6RGh2eyMsJlNCWa8xF3euPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MayvHFck; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MayvHFck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9rZAL4+ZMI89DRZfjKsEeSm/18F9BVxviPtRzlMNu88kMftAZNa1f/bNtYWacwzNNGMKp8CIs1EK6U+yzoA+uFun9GsuDx4QRswP8XgDqkJ4O5Ghwgzp+WOABRXG6xsu1nZh7on+N9M0unK+mtmGZI9hU3ME9AdIq8tEuwsOpO26Wir575g5Z8/N64xi2onZMYFs+fPiqrmYIwDDq2oQbKKoXoKaMpyhGee7Im0HHLFremFe5G1PTDSklho/atuGywSrLgXyUAriXNHX7d8kfKf4iLUmhgqEYsJhFj4p1pC/kIV1EpMaU1fFQN+WtRoB/B9zH5iusBZgoldmysdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4aH2UV0UHK3FFxYaNue4h+KHByKEqLhs8nYlBfJ460=;
 b=T5nC12XU27TC6UYNA2qqThkvGQsR/g8IJX762JPrRO9Al+xFQIyGm0RhMKhd5i1czzava2DSmcE61GDKJNoUvdUiWXRxkC9V0ODoWPyxiopN0o9mnuh8KzcSqQsYFCPjPqk5XcwoiMezak9az1KbGZvLK8v4tZZ4b+WQxRN2XwwBT/p8vxlXPMG0/yhTX+ccx4tw8hZJiGH6ig45RENia/wPMW509VYOteN4uCPI4ETLVkvhVspIAbBGeFSLlCbdit+5kFrfl5sd2rIZRnJsK2HzudETdsFLbSLvHiiqicm+YFmSXAC/Ws+fdPiQ2HdTqkO8X3Xlh6v27EvypEyJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4aH2UV0UHK3FFxYaNue4h+KHByKEqLhs8nYlBfJ460=;
 b=MayvHFckAQ9oWm2J6duP8g9jgj5jb7DWgySIXARVBj6BooLvS3Ne5PLSkkRbjiDcHaMsc2SLuyM+dawrcUiYJrhfczdYza7hw70fEW6cogM8QSHQtjMIojnI4uDhp+k/R7bFJATSGv2+VMmORwVrV4eE216eaWcsLxdYYIoXB6B0X/WwVdxY2NtXmYJ5NhFBojtzk9sYoo6optIXAFo8D81H2kXBWiaGnIuf2IzgTDE5KQ6DH6m1IYTH8Ob2OCbIA7643jqk8//ko6nJhBAqtF/dLs7YHQXSZCQUrd6Wmcot4znquXdxtfnVcwr/yDUEXMEnq7x5FU1SPpPipsi+xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Wed, 26 Aug 2026 01:46:15 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:46:15 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v6 7/7] cxl/fwctl: Propagate feature RPC delivery errors
Date: Wed, 26 Aug 2026 09:45:08 +0800
Message-ID: <20260826014508.9989-8-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260826014508.9989-1-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PUVP216CA0027.KORP216.PROD.OUTLOOK.COM
 (2603:1096:301:16e::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: b45a9d9f-4444-4b16-083e-08df0313d04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7lsFiuoMPvNbGbEyH8Z8i/gjh9avNSeQL0uJS4r4jnkgUmONwErCseY92E7pKGGRPijgmMfqWJAliETCoxAWdGYp0+lv6Ffm6Xzcbr2IViSeF4WGX8gbxrqMDYSEB4nZBgRvK70c0kYA9QZBEQ9Br2lSZybuBmxjQgn41E0CYfCpStDkZ6oSBGmtxQTFecOhljfcvBsgP+olkSgd+CaeD2YqILDCao8t2r7etmQGKZTnFkkqvPJakXxH5+GL4n0JAs1gYfwvafosnrFuy9F0CZ8tMRIIx1BBcUA2n9kOw5vUYe1F1ROk9BzLTStd9yMbus/AqL7N1oTvC26u2Y6j+4OOdlOUcltwDilydn0sGbQdpwWWUmIqx/jJ0Q0xyQ1ksBtRgsmUiu/y9n/1TVUyOM4RYulFyVuvJpVNta7zW+bnIikY+ulr0g/joBfZNfCwVj4rL+LXfclyRmNklC+cpWKfCWs73IKRSu4Eo1+braBphnxk3UbUHjcTPATMwZ+VSok2aeZ7tGBlyaoQIktzPAjpf+wpBnjFrZWNQgUZ68sGmNrpkHsn9hsW0rBTXLqiLaDBzvZ59E+/qF892+MtxrTBr4PB9QZoqu8mYKhBfTBrAQQ/nf8UfQIEdWW06BNEfrzBc7tApPJcJL91MgGNmwW36/WRaR4JxZtIfqLojvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ndbgLLytXtUFo0RrWWkf5onOo+6PtzguPVXLo/QOoBdhlty32hPXhHcVCGmI?=
 =?us-ascii?Q?hYWQXTTYVh06d5oDZmGJrgNF/hTP506wVmLLE5RBThoJPTAuET3g8myiAKP+?=
 =?us-ascii?Q?vz6LQW5yauayD2AiSzwKHgdSDFZRpAzyssPmu7ybd2R9phfvfXoTYc5JM3+6?=
 =?us-ascii?Q?M5o20pP5hjvce84zwYMfD+tVJ0tDFe9SY871Ez+Nmx3QcVUNFXkCVMrRaVGM?=
 =?us-ascii?Q?ZaQO5z3nCf4iE1r6O9jCtglM2Ni70sCFswr50WjLT0Bb2sXeo5eLbLKEJAO2?=
 =?us-ascii?Q?adcZI2OjHBwe5r77il/d45wzkrJAalnx7G4O0/W0ctUeuQJnV063nrdI07Ar?=
 =?us-ascii?Q?jG4pGdTP88StmqUEEVPlpvy8Ci+IrYqrz+Ef6WO0rLW1MplOT0UpW1DID3OM?=
 =?us-ascii?Q?MXmeF2M4jdAz5LE25dJPUQyLFxuvM7pD43ypeCpK4Q3Fw0ddwrBEic5UZ2RZ?=
 =?us-ascii?Q?sxQpGDWpS/IDgHF3hmN8Gxqxn9ofqFztiuOfQXQdjKoJKoG77NRAXyG+bYSh?=
 =?us-ascii?Q?exk9Co/UC6OiVDz0RIONdlZNqutpamm7Hk5xq1Kw0f1N1wzxsAAmR0zxMF2Y?=
 =?us-ascii?Q?lHIIQYTfLUWpzQXh12wyLfRUhd5P9assoATFj2qtgAPCcVFA6afhvOiBzI7P?=
 =?us-ascii?Q?l4oObSYWkvUhyHWMdvWh7nN/5dqqiAnJs/cqfj17JJ7cYkf0KYjQe+Vwi+c1?=
 =?us-ascii?Q?KVYop2Uq5GM/tGY1j1ispLlhbIFKu+ZRbArrMGB8vImI6CWkGHQoN24C05nt?=
 =?us-ascii?Q?iEtxsPzzrKunyl19/yVFhxDTmviVlBFow+ZPZ+WdhZrLwYfjCKs8+qwfWXIn?=
 =?us-ascii?Q?tY2JfjTsvFCBVuK8FTn0CpcbCYytUSB432Gmvzgkv24bJ7kGFz468cI8pjhv?=
 =?us-ascii?Q?SK6H8dPIBPjSeDL7nBX09Q+OHxM3JBx3RK/cXSm5o61E4mtpOHeXupZUTpO8?=
 =?us-ascii?Q?fDt53aAIoefrDEXWcWBsXNBhYS1Icdkm8ObbM2qk5/AisJ+qvFFtV0Xk9i/m?=
 =?us-ascii?Q?knuup1G+gXO6pmELW9R2xa3GOFsu0iVrCCTp2WlzYh8jf4O7y8rCP0pt+44b?=
 =?us-ascii?Q?XVcByUfwSB2HJrynfgu6ls/0K7isqDupldXQOYogkALo2FpJjqqPFomX6JGK?=
 =?us-ascii?Q?+kDsFXqMiOzm854YFDzXctnriWVeceq0oJXvi4WCmCTudSEOoAwPdczFKpMc?=
 =?us-ascii?Q?FKshoeA+/mcLgjEuicff/kIQJX54Rb4u02SdYa3T7wfcHj4U31HPkKvmvHvX?=
 =?us-ascii?Q?TqVtQkbADMbGFkExrkoAMoUZl74FjSSLBmAs45MljSI6BTi6tPrHR34wBoxD?=
 =?us-ascii?Q?p2veyKEBMI93YSv+pjAAnlrx8b79pXfyUTjMh9py8h9Cr8Lh/WJ0+Ut8RlGy?=
 =?us-ascii?Q?ZbUM5ZV0ouHtVbq5hITWlWnpi+3khdy5YpZGIOEB81+S0wXeq3JzPNA8oxmm?=
 =?us-ascii?Q?RUF9LgMsmgE/R7rRI8aWsxiM6MNgWcl+KSj9jOB2OSafR02rb7k4TNTtCEPm?=
 =?us-ascii?Q?cKEOKrAFMCbI/xmcZpFYq5eY6qzEfEoUhESkipv8KYzR/LOULwFpCNJqAw5O?=
 =?us-ascii?Q?8A2bQfFcsXhYEfdzOTK5LsbKZnGJpCwpDYSVgA/cImYCFPDoG6TRgk+A+xoe?=
 =?us-ascii?Q?i0SO1A05GA04uvyFhK+rjDKXdxkiTtocWxMpmW2roQTbd9ENOE5Z7+9vUlgc?=
 =?us-ascii?Q?0Tj0Bnr8TcPqRkMjaBh0pI1o9IIEmSWPp0HO2haPVxnIpNFISImf7P9TsbOm?=
 =?us-ascii?Q?IK7nYjNfCQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45a9d9f-4444-4b16-083e-08df0313d04e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:46:15.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+ad/fPZOwHFI9wr5O0dgLT7IWl12Ll9EUUgfWTn9UUG7VXLz3MOIqOYrIUdbyGEUoBkOjkesauIA/mvnxTZfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

FWCTL_RPC requires delivery failures to be returned as ioctl errors,
while device errors are reported in the output. Get and Set Feature
instead converted all failures into normal responses, sometimes with a
SUCCESS device status.

Initialize the return code to SUCCESS. When the helper fails without a
device error code, return its errno. Continue reporting actual device
errors through rpc_out->retval.

Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
	- Remove redundant CXL_MBOX_CMD_RC_SUCCESS assignments. (Dave Jiang)

---
 drivers/cxl/core/features.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 8d44ce829497..28b326df3398 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	int rc;
 
 	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_INPUT;
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 
 	if (!feat_out || !feat_out_size)
 		return -EINVAL;
@@ -267,9 +267,6 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		data_rcvd_size += mbox_cmd.size_out;
 	} while (data_rcvd_size < feat_out_size);
 
-	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
-
 	return data_rcvd_size;
 }
 
@@ -289,7 +286,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	size_t hdr_size;
 
 	if (return_code)
-		*return_code = CXL_MBOX_CMD_RC_INPUT;
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 
 	if (feat_data_size > U16_MAX - offset)
 		return -EINVAL;
@@ -341,8 +338,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 
 		data_sent_size += data_in_size;
 		if (data_sent_size >= feat_data_size) {
-			if (return_code)
-				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
 			return 0;
 		}
 
@@ -492,6 +487,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
 				    feat_in->selection, rpc_out->payload,
 				    count, offset, &return_code);
+	if (data_size < 0 &&
+	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
+		return ERR_PTR(data_size);
 	*out_len = sizeof(struct fwctl_rpc_cxl_out);
 	if (data_size <= 0) {
 		rpc_out->size = 0;
@@ -544,6 +542,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
 			     feat_in->version, feat_in->feat_data,
 			     data_size, flags, offset, &return_code);
+	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
+		return ERR_PTR(rc);
 	*out_len = sizeof(*rpc_out);
 	if (rc) {
 		rpc_out->retval = return_code;
-- 
2.43.0

