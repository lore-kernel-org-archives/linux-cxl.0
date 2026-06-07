Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE76233948;
	Sun,  7 Jun 2026 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780810754; cv=fail; b=s1WRG7mp1jEXmyuCAlRByvKTCrpuEqmLkDDtsPpN3eWzlpX2z8ZHpitHFcRyBbyCGlIuAtyknJy2Q1kp2MdvpJFnH2YDmzQOgcVV/2l3na9WAyf6YCnAtYYQE8URdzti6122JZSfZ4IUNPAuCE0ahBlNG8qsGNMRYVoA37f6X1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780810754; c=relaxed/simple;
	bh=GSVODaVMaL7mJTHdecaHED6sHPW8FB7Hw58nuoKOFqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WE34TUc/VkPK+xpFzvogScWUwLlCSrcA7cPLK5ek07xDdAw8XglKrQGwDI8423FwgeOiFrVVLWWjl0Y/J56Tzknr4ghWHwOYfU07xRRXmMAnaKgN4C1NwbSbPke9L7nbndxAcd7oujIaR9UaVfeeuVYiZTjwew1OWQhGegh4CKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gk7z+mks; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gk7z+mks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v11LYn8rdJPrrHTl5sPgcUO83Y2FpeJimFwwizKvkvIz/gvbiTkLkifHlRFmrl4tubXrBUSBrwFfOuvBkT+uOHTJFEBvT3JlAJJfpmiDbazFeWMhdDHcMK/vYBtgk8AICAsIWUb4D6KQJ58qooXFu42Eu6LcIRhPPW43MK4+98zVDaWWJCxejSCKU/5WWzEOSQ1vUHRl5TRZrA4A2DYDpd1rBqZpNsH9e9rZwIgwxiTymCW9nN6tMCSNalxrThMAqPAWy93Gg/55bfc3hpaZAmGfmp+kryUMSdTjL3Q2vQLgbz7TYvbkkK+aGA7RZySqU+rTHyLblx0uvFjG0ChYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN1WIRLkoWg0uALwIpTjTCfdhb+JnqjuimI7nhyfi28=;
 b=x9P6ud++01YEn2ysarkzE8yjZwQjs4jykx5uhxXaSmj6c5A17yco2v/DeeVhnthfsp0Gvezen3Kik8/PYngovHLfqTbFeCQpYtCZ7nyKfOXEhGOIciNBZ1pP/DjTTHbsh/uYi1tjStzIyhzjrXb5flORJOD6HwuyYSN9c8zckKW75nUtkfeJGoceqXw27iIHUE9x4BF5RSMQLdohVPHg4lIOD5xHBhKt9LwviOTfo/cnp48uPxvuATuCN88GIxVpJankrQWn250UZKA3gI7IndujBmrhUULd8QlNBp+ISi2GQ9fChL9NsotN3klxl897glbEGei9xbC5MYhRi6diEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN1WIRLkoWg0uALwIpTjTCfdhb+JnqjuimI7nhyfi28=;
 b=gk7z+mksBy7TG1uRAQRJGxDBlGuRukhm9RIWwMY6v7dKFfbjWoVL3uxTPbsbRGL7naVmUD8T5qYath/t0umAVWfv3EKLLDEX6hQAWAdLEUq/b6HlFfGI84ZmhH7txTBiq6H6fBkMsK5wgGatW2O4W7hcy1PrgL2UKsKTP471n0njmSMzlaXK8GFnvpeBJ9q5roPTO60tdeuOqpUWMLAUPmHn7PwjiS1OdVmza4UrjQqEkJJW3jiypo1FOBEDYLsSt3kwTUJL7UrAGW0tWCNuko70Nq4xh0L67rEifH11KrrxgKFWb1BtzqjY6kCznS8KUKNROul7zwt1+XELUudRzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 05:39:09 +0000
Received: from MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5]) by MW2PR12MB2380.namprd12.prod.outlook.com
 ([fe80::90d:c5c:6a5e:94a5%6]) with mapi id 15.21.0092.010; Sun, 7 Jun 2026
 05:39:09 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 2/2] tools/testing/cxl: Enable zero sized decoder under hb0
Date: Sun,  7 Jun 2026 13:38:37 +0800
Message-ID: <20260607053837.4389-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260607053837.4389-1-icheng@nvidia.com>
References: <20260607053837.4389-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2380:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 1638d112-170f-4ab6-930e-08dec45717fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	AiKHcCLR1BGJA+eBBgHh1tb3LFQdcX1hzrtBdMG2BWEn/4ZBjS4EAlzaWKb1uC//ZQX7voAilZq95iQj7b2EfZWpns6A/xeM1TXXuzF+73zQKB+Qs4led5bhD2SRE5EA14zYt9In1FECn05Zy2y4Prlyy6JIZ8xzv0XST0UEmQmHoDcUu4Wwe0g8PW+cj76WQ0z0p+kUQwvTp4i1uGbkJz2c/hScGpSJ0XwzKw5ZZ8nsFX2GrLwC4ntH+nxxt1fqU8BDnWSkzanMiIIp+2FY12VqBQ3efq2AUU7DLEV7Ll2K56aegJHeGxJZDrP1ACHcs0ddHozPiMMAOgxgApO48F8KCWHzyr1/QmvxXfYMR8WoEQcYV8lvaHSUfL4IRGB5Oq7Q6uSZaiv863ll6GqVAimLLqrJzd6bI6tZWVBnU4lFYLdmkYLGA5pp6CMlsAVsBVZcoVzxAksVlH0TtoMV85uKh489MpTqyV8mOVAeZH2qZr2sBvqVmDQ3VMat0oLthfnGHdLS/+lNdcFtsveAFnp9FE9Ul+YAf/9Xm52J3ItuiYNXl5viwk7fwDgBvrhP11kkdB8DGoUpjb5ARfbCWbdO/CjfTBJjTCdMkhktGOB5U2GVbgqwX5boAY/H62JOcx5VVW7/qA0b+ehalWWo3YCrOaheATDAEa/YJWutee23ymIxC2LzZ71Oxhe/XSFw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w2ow1BTmFSrkfqnIX+YP7Js0NHFWsv/QdOeFj7XcoN+WDWCK9tQFCQPZxVGR?=
 =?us-ascii?Q?rxXKZrYFlhpZXovhHUMmrsJbtYVrxJLjMWmk2qLrKHd5mem1n75Ybg9Yj1sB?=
 =?us-ascii?Q?mW0WJmtXXaA/7JpFi0J+sJG2PUiYPQ2UNHZBlIN8e3LCiwaZNYK5SDY7nj7d?=
 =?us-ascii?Q?ErcA5lO3dbv7Lx9BBQNeR9vwgs84xTOAqMChWWLMoe7viiZn6w94Pi1YJ7pq?=
 =?us-ascii?Q?p4K23Dq9B4Vsr5mdl8XeW2cbimWoWR72r97Qp/O9LBSaCL6oQ4wewuQWAd7p?=
 =?us-ascii?Q?hh79U5lo/UMB/BU15HyF0G08GejsSe3YeKd4EvuH6McZwbiJVAhr71JHWNVT?=
 =?us-ascii?Q?CxVlMnC+yT+OAC6alOpzhcOW3VJemD8jg9v/TdQblItFtBk7E2js5IsRzMU+?=
 =?us-ascii?Q?DQLfEl+SCvdD8zjrjs5l23xlmLAovDcXiYBzYcUEZb3YGZBz4R0/WjwOluFQ?=
 =?us-ascii?Q?I/v9F+tSYT93ZWvSbg5VmNjTr+6LvF8IfBRNtv64+IK7pbS/a9dqzgpFQcGX?=
 =?us-ascii?Q?hnfBqRyH49K92mPk5HJzykkQ8/sr6+x8rMQzNzOqv0YSN+zEHvC99FnhpnI2?=
 =?us-ascii?Q?5n5wTDEEGUv5dtHtlr9GzgOf8CICWji1iz8ULFZ4IoweciPbo1Nf4u1iRPBA?=
 =?us-ascii?Q?xdho+eOHGOgvrbAx7KI3VKv4h2ELmhP7flMkRZiyH9nYRG+d1ypgV81dV4zU?=
 =?us-ascii?Q?UPenlW9Prz3e8m7HMDIPDhYOqlblDycKsqpAgutJAkNd06dRKCTVceHc4U++?=
 =?us-ascii?Q?Z2i3urEiKHmTVT9VOsHjvVoI/FKaZI0DixriJORfJVskhJum9xyNppvclPE+?=
 =?us-ascii?Q?ctN8AdA48FujdsfbUwAvyZft2Xo3LYiWdwHU4KWS/v520EQSC9Ezs2N7s18K?=
 =?us-ascii?Q?XKSy+uh8ECVtWFRT7Q7ZvEtwNxoxgNllXtoUm7AuVq0HuHjkxASZ8s6wEhdN?=
 =?us-ascii?Q?zPwlOrWpsxfo8MOuH7GlRsBqdJOB8Jv009YqHvbhafG3/r8UIcNYsuFKpfE+?=
 =?us-ascii?Q?mHf+NLhJgQfku6+rBgK0emMEEA02mVfHd2ga99LpSOgs/RKsNA0wWgTaXF3w?=
 =?us-ascii?Q?BLQZPMO9F2uW3H98sGXfIMfT85WyneKmVLP3YupYEXKx1biIrbOSaNsVUt5C?=
 =?us-ascii?Q?NXje8LPfs+4V/X42Bv2ifwjJTJolOvXwc2v2Vn5hVLzOZ/a3bbMlypVx09ER?=
 =?us-ascii?Q?BkxdMC1Agc3yBpzDeQuQ6L8IGnZL9jU9jRClNcCL0T0MJ+naZTTNhWt4vYKd?=
 =?us-ascii?Q?gK/Ym3573YemyzafMOPicq7l0eKY3yQMDtRwVkeWUO7jwdJ72n9GPKnXqL5F?=
 =?us-ascii?Q?TBWlkEBsCneqrlIBGgGrrwCozEBkrNRJdk2qKiaZePn5AGjGdEk3TxIqGXvu?=
 =?us-ascii?Q?A4U4XxkYSd8DMzsFzsLIvy+rSsuP1TZlwnQc+BXNhv1DC/Q87YFlzRSAofed?=
 =?us-ascii?Q?Gq6f440oANo0vXxFk6Y7INIJ/CuA0CukYEFUIPxieX8n1RdU3Hh4bEA9nVPL?=
 =?us-ascii?Q?6IKBC6ZoFBm1HLJozRsa3faJ9qlcGfHAPTNdzJypGYle3znJPdm3NZqczIBL?=
 =?us-ascii?Q?5/CT1U+mNhmHz7dpsf3SFAT4YqWW8SwRVOvcRvAHKkk1tRmuWm74J1h01ajI?=
 =?us-ascii?Q?hPZP5+r7tSOyilY7VAxQSsSQDTb9IG6dMJ1cB6kzcgOZm4+0c0/oNt+Uaebz?=
 =?us-ascii?Q?3V2dmy2Cb2+ymyhDrSgDMe42ISDri9lsrO44Xa7D42NlB7F4FyIGgaC85bl9?=
 =?us-ascii?Q?zTRDFZ6qyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1638d112-170f-4ab6-930e-08dec45717fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 05:39:09.1968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycknrcn9Yiu1l8b5UvRKfs3LZL95fMXkX8LPtM9fEhEul6rFVghc5u2yEH6bFGEmaLJaDS4MhP8UBkbPj7BJuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

The kernel now allows committed HDM decoders of zero size so BIOS can
burn slots with LOCK, cxl_test needs to exercise the patch.

Add a mock_zero_size_decoders module param, When set, the special
endpoint under host-bridge0 (cxl_mem.0 and cxl_mem.4) commit decoders 1
and 2 as zero-size + locked above the decoder[0] auto-region, mirrored
on the parent switch and host bridge. commit_end then lands on a decoder
with no DPA resource, exercising the new enumeration and
poison-by-endpoint paths.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
v2->v3:
      - Gate the zero-size + locked decoder injection behind a new
        mock_zero_size_decoders module parameter (default off). v2 applied
        it unconditionally on the host-bridge0 auto-region endpoints, which
        the region test suite reuses, regressing 7 of 17 cxl unit tests;
        defaulting off leaves the shared topology untouched.

v1->v2:
      - Replace second_decoder(), third_decoder() with a single
        match_decoder_by_index() helper, so all lookups share one matcher.
      - Use DEFINE_RANGE() for the empty range instead of an open-coded
        struct.
      - Set cxled->state = CXL_DECODER_STATE_MANUAL rather than STATE_AUTO.
      - Set CXL_DECODER_F_LOCK on the mock zero-size decoders to model the
        BIOS-burns-slots case.
---
 tools/testing/cxl/test/cxl.c | 83 +++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 296516eecfd6..190cb18d6932 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -17,6 +17,7 @@
 static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
+static bool mock_zero_size_decoders;
 
 #define FAKE_QTG_ID	42
 
@@ -1041,16 +1042,47 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
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
+ * Mock a BIOS-burnt slot: a committed, locked, zero-size decoder
+ * (CXL r3.2 8.2.4.20.12). Gated by the mock_zero_size_decoders module
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
+	cxled->state = CXL_DECODER_STATE_MANUAL;
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
 
 /*
@@ -1131,7 +1163,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0) {
+	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0)) {
 		default_mock_decoder(cxld);
 		return false;
 	}
@@ -1145,6 +1177,20 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	base = window->base_hpa;
 	if (extended_linear_cache)
 		base += mock_auto_region_size;
+
+	/*
+	 * With mock_zero_size_decoders, decoders 1 and 2 of the special
+	 * endpoints mock BIOS-burnt zero-size + locked slots above the
+	 * decoder[0] auto-region (CXL r3.2 8.2.4.20.12). commit_end then
+	 * points at a decoder with no DPA resource, exercising the
+	 * zero-size enumeration and poison-by-endpoint code paths.
+	 */
+	if (cxld->id == 1 || cxld->id == 2) {
+		size_zero_mock_decoder_ep(cxld, base);
+		port->commit_end = cxld->id;
+		WARN_ON_ONCE(!cxld_registry_new(cxld));
+		return false;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1168,9 +1214,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
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
@@ -1214,6 +1262,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
 		cxld_registry_update(cxld);
 		put_device(dev);
+
+		if (!mock_zero_size_decoders)
+			continue;
+
+		/*
+		 * Mirror the endpoint: commit the next two switch decoders
+		 * as zero-size + locked so the burnt-slot layout extends
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
 
 	return false;
@@ -2030,6 +2098,9 @@ module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
+module_param(mock_zero_size_decoders, bool, 0444);
+MODULE_PARM_DESC(mock_zero_size_decoders,
+		 "Mock BIOS-burnt committed zero-size locked decoders under host-bridge0");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

