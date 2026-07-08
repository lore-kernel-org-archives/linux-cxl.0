Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751D42640D;
	Wed,  8 Jul 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507265; cv=fail; b=TCn2B9pVaOaaD7/WD4C20h2O5IPi+hd9kXWUdgGUFdz+mbFVUuJb9AWNycwb6kRoeR8LcoMe4isMY+0BbZNs28Hbople05M5MKbaw5A3HCM0Sa0DXtRyHtE9kXGjpKfWieQ1lglINif0gjSSUDG0dHmV3tZbK0mFOH42jVYaXi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507265; c=relaxed/simple;
	bh=wmDRIcSTFUiIsDiksHp0JHUzjzyx8eeWvpYd1/tLUYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEdf6JS8uVByWuZSH2bj7nwbjzMZnCnSsZCTmziIyrm7XfoUDBq/FtPSzSbaTKmcGiQwP/cYKJ5SFZ1MBtC/7LSRNYvM+9IGBbd+D03fP9qmQkJqBaC5iBhJC76/UMGjJruyf6Sk2HDAq6d1Gc0OK12j/a4tsyDZgR2hQKDuf2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fdGHtWUW; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fdGHtWUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGYHucP2/G88ZC6mO9U14hEU8HCbAHWzXka5gNzQCokYe49gkg+hVBK5RxzA2YWV3DJG6DnLc5Bvn8AgdYl7ax2zpkNDrxVIqTghtbXA137QOvc6h4A7H+cYgfe5mia/qp535QyC5P3kiImzfvGKpMs9Iq8EqC99CTed1XkLwPebcj1lqhrdjMSFTD5mkBD5rcutGoj/2ysp3TB4yPIgQcFrDzlD3upedlOnfl1eFWA0px2nSduSq9x+WXiVCUkp4BUlWrwLC5J2ZAxqPXXuRDlPti58AypzQnYhG7wn/1YRpxrqth//lo9m86sBp72mVCkornldPXVrhHbayeEqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A558qqW1fT8tr7tiakAzzmERjDILPcEiZMdj9Fm03c=;
 b=VGnAZfeFbD4uO68aSEmBNt0zXh8PX1y4QEgxUwl86FNP6DFKUxvXwVqAbyyub7m9hgxQ/BtJ0SbWDDgR/y/ZjPrieRIbvRTMHWCeG0478IJNQ0S2hfw/btwPVxfiaOnoRTTMWC2fpWlPBnXD/N/4ddXQWIqHuxFstC3bRXmUAQAr92rP9qscF7BNU1/RVdIlkFYkCL4wr1BhDBkSubNAgWLDRONrCte3QceF4WQWmp/bSSGmd+X2K2J2sApEOWergPjFw8h+Xjk2g4dI9Ap492zSj+pdbEumgiqn7745Y81ihNM4jx1gIEA+k4MOQH7r5ftKNDmCaed9GmFFkwpumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A558qqW1fT8tr7tiakAzzmERjDILPcEiZMdj9Fm03c=;
 b=fdGHtWUWy6AfZPGMITRUcdNz7ob/Gx/IBJROG+ip1OOzGX2bxAd/Lc+P8AY4ywyc2HEfobeB+YRr+sjkSxVVDz8btvFRW0PUteV24Ugt7sBDLewEvSCpmq/grW++Mtp6RbmjPioCSyTu3VTeUqvCjVEzldrp34GY1AQisVtUddw9SQuvpnGxvV+Uc7phpss5VxZG76jASj01vu+NDoEHZWQeD9NiSC0ROP2DKAB21oKO8eK80urDaquuYWwKwEOwFXHdlwSZgtOHbVp76aECEV1IiaCqmNPSDZo1syz+5/K/2r8JDA3ecs/qRlZDzl1BT8Zz3jTpRez2MlHaGPTFrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SAWPR12MB999294.namprd12.prod.outlook.com (2603:10b6:806:55b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 10:40:42 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 10:40:42 +0000
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
	Richard Cheng <icheng@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>
Subject: [PATCH v7 2/2] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Wed,  8 Jul 2026 18:40:23 +0800
Message-ID: <20260708104024.68029-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708104024.68029-1-icheng@nvidia.com>
References: <20260708104024.68029-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SAWPR12MB999294:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d0719a-88fb-4b39-343a-08dedcdd5beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|3023799007|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	g3huhLryKPCFbv9HnkoSUTEWlk++DoXEL7U/ini36HwfvIvUr9bYxQFtNu5FtjP/EkPg8d6LKK+9Kx/RWGTGdmIE5nyv47M1XqHY5EiErpIJr6hrcWb4Ihsse5V8Ww0eos+RZb8Hnvsg8cdOlhdQ+T41r3GUKF0YT58sz3SyzgKB+xHUcFwMz4EsyFJhu2k3aJF3L2mmG45iFgejUBuup5x43E7Ci8lSvlqRrhvzZ6OIlx34EUIWk2N9mGjz+xpJW2gTHXhJaKfs9/2be2mhmHuBfw09d066j4sHyzuwFStBkwsOtSMOxDfMrf60qBBjcsSTHf7M6UIV/emrl6N8TPKgiucvhFR1CSJMNSMP6dmVqw4dPtco06VIq73IO7Q7kTvzlKUHVfO6JBLTD2M+wNckB6Ljbj7U0TlkcpP+UojbhJYw8Rcf9N4j01MZeIxelwolkqLkGR5+El81W0X24ZMydeFCQ3W6yQN1+jYB2hw8SjRmnPrUymEtdnjuJr6cckNSHyeHO+Y86qzcKdB64qUa3oQX4UA/t43XN/G20dPZzAnr3epvbv+cHtJa2Fp+X+mBM38jJgF4jU83PC3ejvvoDBANeQKTGJAGjfR2JdGtvxEqya5x6cR1i9DO0ChwnDMsWR3IzJx7DCFIcbjmQy7mXzKx/KD8EpaVTqAFpvI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eoqs2JaSYivYWQir7oOxsxSSSqi38dCPBGD5QFIhUjeEE8j867HiG+Rzz4VX?=
 =?us-ascii?Q?ChWyqmnf12jNLKDFxErdlpvJXcDfzv5F2vgYGRPkt/SmSmjwxeyz5y/KLk8b?=
 =?us-ascii?Q?hT2RNSF9TlN0ec0wUe44v/CXi0oUfZaSByy8J+7O3yE+0xsmtNSlGDwrO2yp?=
 =?us-ascii?Q?54tRsaT7rLSxf15sCjlKD343DmneLS4ceXJBKWaWzSRNH3wKG96QgGUu9QKs?=
 =?us-ascii?Q?tSYIgG+5GwiqVB9tAZV2pCJiFLIvib4UAuZJABJqDboWipt5V6PiBHPFla4j?=
 =?us-ascii?Q?0estNhjO7FcLg9v3Fin4qGfGqo6IduR9DceyyzJj81uac6I0xGW7bMEnuUb3?=
 =?us-ascii?Q?8H00dxQIAOqqiebTRh4kfgulAzvuRuD+4FMmVtyXqjY17iBMa+59WZnk81Xy?=
 =?us-ascii?Q?MRYLaN4vHXwAe0qRd8MqfKP8EVaYLFHAY3ok4XMnd7GzZOMCvhCNGTAEsBwm?=
 =?us-ascii?Q?HFh++WN7hDuose3F3Lyrdh/JNi95124Srg3NdZfgIfMUPi6KeMubOt37JUqz?=
 =?us-ascii?Q?uqFx9rx3/q3yuxkjkRExYAWJzza8NiZ47FcozojjezdCcLZ1k193pSAbfVQh?=
 =?us-ascii?Q?3iq8uO9XO8nnmv7RjJebjmXt2JYljZU2zw4iUexldLoUsm/LqLeCIX45MVHL?=
 =?us-ascii?Q?RO663gzvDXiCdkKdVqottqYQs/Q6PLqpUBhZS1UndV/2LQ19tiAEYqiNmVfH?=
 =?us-ascii?Q?Esh4NmER25V5LGCNL3zW6X/M1GNUUmeSJHQ8XfBr6riNp2gu5DALBKe6TR5l?=
 =?us-ascii?Q?5USrV1m69z5HB2pbO33watSyu77CM/3iauvQ8Ij3tS1/PKxwhroeH8OS62eZ?=
 =?us-ascii?Q?LP0PS0qh6Zuzb5/yA9GGFqoRdaND57XmVYMa5g9C/babZ5gykIbffjEseyPg?=
 =?us-ascii?Q?3UKN/CYsfQmRVtAl150cCKkyy9ljtquXZPmCjvfn8U92CsI+Ph8mUA7Xxu37?=
 =?us-ascii?Q?uYFuDAvqqzfIe+7NJnWgdHuiIdzmAx+5wMuBBELgdd70ebnuhjInRcuduBTl?=
 =?us-ascii?Q?avAfhpi9mvdor7uMBVWjX5NFVOrbLZiIwceuGZ0h/8X4jGpol2dv36RmgpkU?=
 =?us-ascii?Q?YXguVznE1lkOtnNG74bVQomxWuOYxs6xF6d56MBq8DAEtZ6Pc4RSb5ryxag1?=
 =?us-ascii?Q?3+h0aY7PvlBRS3YSG/G7/AV8BdVmCURFOqrjMJfOeB4AmoSJWNLold9UpPcq?=
 =?us-ascii?Q?AjsmUpTQ/XmBkSPMVFQivyRsYF2k4kPWQbaPn5PFP7U7/gE2L8YMQlzmZ8Fd?=
 =?us-ascii?Q?U45ya6Ibo96PevwsGVPybe41YcbBVcLgNQVczBBQefNyxW7mxZPabhJjzt8t?=
 =?us-ascii?Q?5nAVquej1Hi3vF2qFwSwvVSlU9Cy7ks7P9KI/T5T9yVmwzzvCweibK3wWqhD?=
 =?us-ascii?Q?Ve5AzXvLY2yF0Ws5D7y+BeNqdk5ksYhYTxIfmZh1HhsyO9xagQt7cp6ahFwc?=
 =?us-ascii?Q?YIdvnL/8Taj5KA7E8LWFpjhA5ZAQflfpmkDRU8NnxTgK63tcdF2NurI3AAeE?=
 =?us-ascii?Q?YA1Y1O8C9uMm5TQN5PX/4HdgRszqKucuYaQD9AQJaL8kXzkr1n5QjTkpIqjc?=
 =?us-ascii?Q?wSvLx9MQOaxFVGr/5k0DjSRrqo8Z81srA/gaoTGDaVsBDk0d23LY37aVcK2J?=
 =?us-ascii?Q?GC+HLNxvHg/lRWeIXumbio7gqXpojGi5phaXHuKcWnE++XRoiYayEnXQkE/z?=
 =?us-ascii?Q?hTK3L5KYsvS5mRft75juZh5NTFhNP792fs/4x0fS59WODb94UhHlHNdKoam6?=
 =?us-ascii?Q?Er/bvmj6/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0719a-88fb-4b39-343a-08dedcdd5beb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:40:42.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvAbpPlykk9MHoIQeuC4btt2qaEWncfozm4CS7b89DEcQecUWFv3xqmE+mQAZAsLUKPjQ9HK77JWRKXZ2GHyOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999294

The kernel now allows committed zero-size HDM decoders so BIOS can lock
empty decoders; cxl_test needs to exercise that path.

Add a mock_zero_size_decoders module parameter (default off). When set,
the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
commit decoders 1 and 2 as zero-size + locked above the decoder[0]
auto-region, mirrored on the parent switch and host bridge. The mocks
take a real zero-size DPA reservation, like enumeration of real
hardware, so commit_end lands on a zero-size decoder and the
reservation, poison-by-endpoint, and teardown paths all run.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v6->v7:
    - Rebase onto cxl/for-7.3/cxl-type2-test.
	- Integrate mock_zero_size_decoders with special-topology parameter
	  validation and reject its incompatible use with fail_autoassemble.

v5->v6:
     - Reword a mock comment, no functional change.
v4->v5:
      - Mirror the v5 core semantics: mock zero-size decoders take a real
        zero-size DPA reservation via devm_cxl_dpa_reserve() so
        dpa_res/hdm_end/cxled->part match real hardware enumeration and
        the poison-by-endpoint walk reaches commit_end.
      - Set cxled->state = CXL_DECODER_STATE_AUTO to match
        init_hdm_decoder()'s fall-through (undoes the v2 switch to
        MANUAL).
      - cxld_registry_restore(): reserve unconditionally for enabled
        endpoint decoders; enabled now implies reserved, sized or not.

v3->v4:
     - No change.

v2->v3:
      - Gate the zero-size + locked decoder injection behind a new
        mock_zero_size_decoders module parameter (default off). v2
        applied it unconditionally on the host-bridge0 auto-region
        endpoints, which the region test suite reuses, regressing 7 of
        17 cxl unit tests; defaulting off leaves the shared topology
        untouched.

v1->v2:
      - Replace second_decoder(), third_decoder() with a single
        match_decoder_by_index() helper, so all lookups share one
        matcher.
      - Use DEFINE_RANGE() for the empty range instead of an open-coded
        struct.
      - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than
        STATE_AUTO.
      - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model
        the BIOS-burns-slots case.
---
 tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 8ab2ce1262f3..fff2004a08c8 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -18,6 +18,7 @@ static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
 static bool type2_test;
+static bool mock_zero_size_decoders;
 
 #define FAKE_QTG_ID	42
 
@@ -872,14 +873,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 		cxld_copy(cxld, &td->cxled.cxld);
 		cxled->state = td->cxled.state;
 		cxled->skip = td->cxled.skip;
-		if (range_len(&td->dpa_range)) {
-			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
-						  range_len(&td->dpa_range),
-						  td->cxled.skip);
-			if (rc) {
-				init_disabled_mock_decoder(cxld);
-				return rc;
-			}
+		/* enabled endpoint decoders hold a reservation, sized or not */
+		rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
+					  range_len(&td->dpa_range),
+					  td->cxled.skip);
+		if (rc) {
+			init_disabled_mock_decoder(cxld);
+			return rc;
 		}
 		port->commit_end = cxld->id;
 	}
@@ -1072,16 +1072,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	WARN_ON_ONCE(!cxld_registry_new(cxld));
 }
 
-static int first_decoder(struct device *dev, const void *data)
+static int match_decoder_by_index(struct device *dev, const void *data)
 {
+	int target_id = *(const int *)data;
 	struct cxl_decoder *cxld;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 	cxld = to_cxl_decoder(dev);
-	if (cxld->id == 0)
-		return 1;
-	return 0;
+	return cxld->id == target_id;
+}
+
+/*
+ * Mock a committed, locked, empty decoder
+ * (CXL r4.0 8.2.4.20.12). Gated by the mock_zero_size_decoders module
+ * param so the default cxl_test topology, shared by the region test
+ * suite, is left undisturbed.
+ */
+static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
+{
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->interleave_ways = 2;
+	cxld->interleave_granularity = 4096;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxled->state = CXL_DECODER_STATE_AUTO;
+	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermark */
+	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+}
+
+static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
+				      int level)
+{
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->interleave_ways = level == 0 ? 2 : 1;
+	cxld->interleave_granularity = 4096;
+	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
 }
 
 enum cxld_init_type {
@@ -1114,7 +1147,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0)
+	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
 		return MOCK_DECODER_INIT_DEFAULT;
 
 	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
@@ -1147,6 +1180,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *root_port;
 	struct device *dev;
 	u64 base;
+	int id = 0;
 
 	base = window->base_hpa;
 	cxld->hpa_range = (struct range) {
@@ -1172,7 +1206,7 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	 */
 	dport = port->parent_dport;
 	root_port = dport->port;
-	dev = device_find_child(&root_port->dev, NULL, first_decoder);
+	dev = device_find_child(&root_port->dev, &id, match_decoder_by_index);
 	/*
 	 * Ancestor ports are guaranteed to be enumerated before
 	 * @port, and all ports have at least one decoder.
@@ -1232,6 +1266,20 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 	base = window->base_hpa;
 	if (extended_linear_cache)
 		base += mock_auto_region_size;
+
+	/*
+	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
+	 * endpoints mock committed, locked, empty decoders above the
+	 * decoder[0] auto-region (CXL r4.0 8.2.4.20.12). commit_end then
+	 * points at a zero-size decoder, exercising the zero-size
+	 * reservation and poison-by-endpoint code paths.
+	 */
+	if (cxld->id == 1 || cxld->id == 2) {
+		size_zero_mock_decoder_ep(cxld, base);
+		port->commit_end = cxld->id;
+		WARN_ON_ONCE(!cxld_registry_new(cxld));
+		return;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1255,9 +1303,11 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 	 */
 	iter = port;
 	for (i = 0; i < 2; i++) {
+		int id = 0;
+
 		dport = iter->parent_dport;
 		iter = dport->port;
-		dev = device_find_child(&iter->dev, NULL, first_decoder);
+		dev = device_find_child(&iter->dev, &id, match_decoder_by_index);
 		/*
 		 * Ancestor ports are guaranteed to be enumerated before
 		 * @port, and all ports have at least one decoder.
@@ -1307,6 +1357,26 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 
 		cxld_registry_update(cxld);
 		put_device(dev);
+
+		if (!mock_zero_size_decoders)
+			continue;
+
+		/*
+		 * Mirror the endpoint: commit the next two switch decoders
+		 * as zero-size + locked so the empty-decoder layout extends
+		 * end-to-end through the switch and host bridge.
+		 */
+		for (id = 1; id <= 2; id++) {
+			dev = device_find_child(&iter->dev, &id,
+						match_decoder_by_index);
+			if (WARN_ON(!dev))
+				continue;
+			cxld = to_cxl_decoder(dev);
+			size_zero_mock_decoder_sw(cxld, base, i);
+			iter->commit_end = id;
+			cxld_registry_update(cxld);
+			put_device(dev);
+		}
 	}
 }
 
@@ -2085,6 +2155,12 @@ static bool __init have_multiple_modparms(void)
 		count++;
 	if (type2_test)
 		count++;
+	if (mock_zero_size_decoders)
+		count++;
+
+	/* Zero-size decoders require decoder[0] to preserve commit order. */
+	if (fail_autoassemble && mock_zero_size_decoders)
+		return true;
 
 	return count > 1;
 }
@@ -2493,6 +2569,9 @@ module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
 module_param(type2_test, bool, 0444);
 MODULE_PARM_DESC(type2_test, "Enable type 2 support testing");
+module_param(mock_zero_size_decoders, bool, 0444);
+MODULE_PARM_DESC(mock_zero_size_decoders,
+		 "Mock committed, locked, empty decoders under host-bridge0");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

