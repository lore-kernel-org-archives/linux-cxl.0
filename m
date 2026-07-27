Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DB4378814;
	Mon, 27 Jul 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148679; cv=fail; b=WFHDO79I22V4XRp6vKpr2jc0O/qW4sM0zBmTwWQ2OJUIXrrdsfgl//pphYHNZQiSH+6pg7VBUNH+749WgXt3NOw1+EmVCdjjpIn69I4j44cdNDxf7lNfb5VkfPtPkpWXiWj+rsVDy1BhwYBR+eBmhGLjuw0Deqt58zzkV4zFfTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148679; c=relaxed/simple;
	bh=aJal4WBJUoKoYe+Z49YP5uHlgxw7z8cefr4+Kmfhkao=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mE026HOhP+G1vcNWbg+jghxZFter5v9ixFUslW7fx+5Df5gqGeu33viMiH9YFSvHLKncypT1dWdEkba+tA9q6y0ksRhgc3M6U03hPu0BYqRuXPbcHcilQXL3VZmAY1BsMDHUVuH9WshmnIYhXy4zgjFLdYeXuVPaHCj6OkDpBXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DyDxuHzn; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DyDxuHzn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9dNIMRcddgGGa5Rmz6l3uHYZOF/9s3/xGtJ52InLitO1Y/OEmC8xjkWszIeBbkE4X8tYKqLp+ulmUcKgSFz4oh8EWxkmhNQX6GB0Owy9VNEoWGftIDBOfYtFkx/mBjQWTfhSa/2qBlDs1NmwaI2Xc6hnwBuzNy651MsgnKL/8DgOHXSt9+aibh/Y9w3p+JRo4gJ1YPcXoqq4R/ak+rgf/bXg/tIa00RWvS5Le8oMFnuxYKg5jiv/h769VSFGz33MTNdk0bMdIpytFwtCuSJP/tDOyJnK5OA2N9HMnTJi4pWN3uuBY/X/emJaoRhaZOD23iS8IbL3HmhFBxlEjwO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/GaOjHljSaJgOqj9L1dRoyqrHA/68VCaHQ3RjXHhJM=;
 b=DScQhRSOalBWRSdBmXbGjBK4hHda3aV0Qr/ZgBlxVhGvCOGw3e4Jc/enzRdoyUwU1xHAz4b6z7/jWWW8WoryEEAfeeQADD3SGFIFb1AqDtFC4eMM9Uou8jveM1KxnI2EzvLTQhE0MHanoywIMwH6ywilRecg4fv9stwTwF7TkWIp8gs5bs17udgBeBaWoDU/8ZGRKSLMQGq7HO/wiog4IzKO6g47mNz5mCzJtAtBoyxQX4a0nPcEWIihKiqI6hYrT7B8qbRdOwn4l40dVRfJGO+ks9V0uFDdF7vl0YBuk5KrjK6pe9XGzpFwvVsBaaAeO++1yy2W/OofJJXJOlyehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/GaOjHljSaJgOqj9L1dRoyqrHA/68VCaHQ3RjXHhJM=;
 b=DyDxuHzngZ27ZGRmjFU9scVkVl8kbpkkLT118cFDdy8NYSphsoX8weGyWV2HHrU1Tis99j6MWiSqXFt8vWS5D9ThyxuP2/gZZHH43/tFMpwNbXJ00XhJQgrXgUCboMm6lW65mZEJ8D5X3hIv27w7+i3cj5X3qxHH6HD4RgJH83UQv1xnYcVLg0SudoRdMaYeHDS7Mru/tR80fuHopY0l7fqyqKSX4qBxQqbzCAnFQ0dU/cA/XmYzdi1R4m/4wqUXCdPRiScYL+FDb7uaPglokn17gd7raUjfyjB1hFAcnk4Qj7SKYvE5qhMUbmaveoU1RnDeQDuLCRsegXOQwcR7VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BY5PR12MB4100.namprd12.prod.outlook.com (2603:10b6:a03:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:37:51 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:37:51 +0000
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
	sreddym@nvidia.com,
	smadhavan@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] cxl/region: Restore passthrough decoder enable on region re-assembly
Date: Mon, 27 Jul 2026 18:37:43 +0800
Message-ID: <20260727103743.63343-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BY5PR12MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 234e1341-66ab-415f-6fc6-08deebcb1b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H9A8VNx8oSzqvTpeOaSX61XMw5xEzKwidkRlwiij8uLXvpW4VD0kOoERxj+hLJDv0vOIJtDDCDMbcywC7eUuYccZHVVoPLIydeyxO8fokpxCirF0isVGldnoBmpu5tnrLsfsuZe6kdX0r+DwW4zssyMoIPouqSrFB82TKKoO4gt5HqYxf+ZyXCA/Q5ZLMA1A9r8xkiw7mxh1sLkGBQMhzLbTmDPF0kYExY0GU1+XYa1Uopio2OcaBFiyU9SYLnh3Ex4YFT15IWI5U3vC89nKaoetoCrv62UTCzfSmlsKOuqxwGip8buk/3vBZRYYIUsELx7PK0qXeeiVpL6EyO2zYUMJvEHZEN6awNH61jk6Je73Cxh6WB52nVDuMilUpY1JQ3IZDHTjY41rlYCp4oLCVdtH/fq+jBrdL3jpFuW9/naI/6O90mWZv7g5un1iVs9/5wvDWOFX2u/OrCK2Q0DPRJ5Q15IXuXn4vrfEC0YfPmupzAmLbzNPZ0V1YEKXs46gXwoxXncQ72aM5od+Q1Y2GxzbSGU+XO2jiHnwryTDu+jgSX0w/269+b3F8HG9TFspHKNeFKtSzrNg7c8m3YNSHuYSKZoH4yNvBFNxv5aWn7yKCFtSDhmYAbxsoEAd+5xt0yczq5dilk4J1SLKsXCDa9+WA1eTWDX01tWQmcQk938=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ySVx65P3f6/niWyeZjIKHxoXMaKzW2Y0x18ORly5MUU9lgEl+x5XIOPjzAsH?=
 =?us-ascii?Q?/o9btGClut2Dv/b2lftlfsDNiB5j1U8S+mb2Uwm8LoZobOCWlHtLZ5aAqsW0?=
 =?us-ascii?Q?kbER8iLzv2ve2UC26d2MKAVtVFhivFzFVXC3tacYBGePE5rO366OjR7qEhCw?=
 =?us-ascii?Q?FWbNcP+az+4gUYdlBg+7b9DT9M5MWziwAXtAg3WX68bBiShAMEFkIfarUNJs?=
 =?us-ascii?Q?aJrbGlimU+Exfs2p+2iwkIKwEqAD8SRQbsAMU2hVDIIPXmiSBpBruuYnAT1G?=
 =?us-ascii?Q?LIvT1wTMnecUo5buGoWQxvUQkSK/HDihZe1V8A9aygymrz7PtQ9lnjYyapZn?=
 =?us-ascii?Q?qcndo2xd+1Taz/NQU5wyPHNbZoFluagv0Mxc5uADONEQkNrVArD3ehSYQg9u?=
 =?us-ascii?Q?R0vHbbHrZ57F4RA7Tk5cfUvrkmi53i6/Flky4hz76SzT7mhq+TnXWMfbtosB?=
 =?us-ascii?Q?cBPmo5WJTIQSvb0EdrPgsYoK/SdNZV0kHud0ZYVNvOqxBvIPsGQiyzn6A0BU?=
 =?us-ascii?Q?9gXvwewbC8Gsf9LQch1VyS7tZ5ZtEyZyBAMIKks12E+DIy/w1XbxqXGBymK0?=
 =?us-ascii?Q?qxnfC/kKibF6t/fIea/AgcnFhjFQCHaQfbxHK9QlitMrSonS5h45DW844E5e?=
 =?us-ascii?Q?bDG+mo5zJIRbjgvxVzW4EKm32fcXQ+Ru9s/B05N1/86T2bVf27aJedLgRcpO?=
 =?us-ascii?Q?Vv86wgLOXnHiaQwJ4Jqfopb7L2PTkofXF9urfc4JInBiia9iM0hoSFk3cQrE?=
 =?us-ascii?Q?H6x3nDf1XmT57bP0178t9NknCPkjJJTj5uEJApYquqGicnWEhnWVCALmgevd?=
 =?us-ascii?Q?rU8LG/hbbEzZHiDsPYLPo2k7+p0cm/JefCdi/6oP7vEgt66SyBQwQJ8VHpcs?=
 =?us-ascii?Q?Tz9i8iZnSi4CfWX4kOdUfSx9D/S7gDKPGXKY8DlD5ul2Tdq54Wt83e7Jn26I?=
 =?us-ascii?Q?US6tc0tDugmxxtsxgTiF8IGd6i+Pmt2+to9cj01/Cs2bMehXyJOITD8Xx39S?=
 =?us-ascii?Q?j/XK/llqRnkru8JMw+20aiTzBzMYLcrEaJQAURMJvhkT6qLmFXKwOfRlduZA?=
 =?us-ascii?Q?TA+OzhZ33yKkTaNYKbNiHVwBxUsT8eJqX9DsEvqSv8u9qgXFUVzKDh4Qiuqh?=
 =?us-ascii?Q?mC746ZRkFRM1emoZd9ArIobdoXnLjJ8kk+Ovk08RErjI1RPJnKOBtXxLgCzW?=
 =?us-ascii?Q?rHedKHW1QYLBJ9siJVgjVVh+niGrP/FJo9dTdhPl8kk42Ylq6hvSREfWIMCl?=
 =?us-ascii?Q?W/rXFFKURk4U8InsetTIo9issoooZT2A0muLvwiUx6o1A2raSbopkSlW1m9h?=
 =?us-ascii?Q?cTB/XGj0i/MYcEsy9QVqFSbNuvstx90/nbRkxFgdAG82YM1fZ/tu6M8ZMMpU?=
 =?us-ascii?Q?n+oUpQG3AHNoJ0f7W0mvHMym7HUf1jMIu/JG15E7POBogzCUQh4GI8O5EJWh?=
 =?us-ascii?Q?dj0k3pTz5el1kBgyalj4loJGEYS9hAXzpzjuLCS7EbHOVvqcShmgNQYS/mdx?=
 =?us-ascii?Q?7Ulj6/koZtmed6UcB0zRfWjK1FKqO5zY8BwvfMTve5ouFtqBxtdCmwY2R9vp?=
 =?us-ascii?Q?0EoOgZ9O/bRj67sSysC1IGSLikeID3RaTP8joVQEfG8p/XAyTCRuPpnlLhQT?=
 =?us-ascii?Q?R58n0DfqpvFj7uD/0Miawq163g5gshBjGtSBUDKxf/OsdN4Nhk4ssRrzHt4k?=
 =?us-ascii?Q?9h8+u+0VLY5GD+X9X1SgRrLiHwl9uUfa/LXfspymQVUVFSKw3OcmOjx8OaKn?=
 =?us-ascii?Q?hmUIk25haw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234e1341-66ab-415f-6fc6-08deebcb1b91
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:37:51.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0jOy971ZepMdMwCeqG57mwl4zDBM1C6BMHBtY+sjubcABJGYMgpmfIY8BBJQFGppuS3+MJrN75RRk+LCgs1BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4100

After a CXL endpoint is PCI hot-removed and the bus rescanned, an
auto-discovered region fails to rebiuld and is lost, evne though the
device's HDM decoder is still committed and decoding.

A single-dport host bridge/root port has no HDM decoder capability, so
its switch decoder is a SW-only passthrough. Its CXL_DECODER_F_ENABLE
flag is cleared on region teardown and never restored on rescan, so
cxl_port_setup_targets() fails with -ENXIO.

Re-enable the passthrough decoder when its interleave and HPA config
still match the region, it holds no HW state.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..011ceb5bae79 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1574,6 +1574,19 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+		/*
+		 * A passthrough switch decoder holds no HW decode state.
+		 * It's CXL_DECODER_F_ENABLE flag is pure software bookkeeping
+		 * that is cleared when the region is torn down. On auto-discovery
+		 * re-assembly after a subsequent rescan the decode config still
+		 * matches the region, so restore the flag rather than fail to
+		 * rebuild a region that HW is in fact still decoding.
+		 */
+		if (!cxld->commit && cxld->interleave_ways == iw &&
+		    (iw <= 1 || cxld->interleave_granularity == ig) &&
+		    spa_maps_hpa(p, &cxld->hpa_range))
+			cxld->flags |= CXL_DECODER_F_ENABLE;
+
 		if (cxld->interleave_ways != iw ||
 		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    !spa_maps_hpa(p, &cxld->hpa_range) ||

base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
-- 
2.43.0

