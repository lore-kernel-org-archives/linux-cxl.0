Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FA3AC0D7;
	Thu, 25 Jun 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379760; cv=fail; b=AD9gsDDE2+5W9YLbxYgyIDNCdbC8tb17XZb594BhY72qpVnXKNaLdghrbZyhxlLAj2vpawgGqU2+OtRYIclhUep+/N40lWB6/Z5Gg5LBjydT8smrzVxUxFMFKMni15eicQ1YBvUPd89LVvhb+h74iE8F4AJR142gMDSS+w2Cq3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379760; c=relaxed/simple;
	bh=bdLLC+f/QGfnYPB77Q/UFl+7RtgMaSBynrjoypFsGWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O4NOFzn0ZLj8poeadWiImrl5xB9qhhdOiPT5UvwjKDHEX5RhPwzr5aMsPEUoF59Ku+wpzfNZLpnAZQGic8s5yZJr5S+2B5k+zl5Zc9UFjf6eCSwW0eEAJD2jkz3iNiPNg+YHik1tfPpOIxyrgXtFHhzS9JcW1KWfJoXzQu6ir3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n4Ku4gtA; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n4Ku4gtA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTWHemWguiCv7GHLToQb2WcqYbw8I9SvNLYJHJkYjuDIo6XgGoxP7nWlAxB2U8ikrz/Ff2Mp7mux6kM/gCqwhW+LolsZHcNbeGq4n6WI9ZTPDs0OdkSKxOiFStZ2h3FYTCt6WXIU5HiK6LTUKohQaTRe9TbJsgcapK9+SCWFrKh4RhAXPGPVybxE+Eaz7oOl1W8Wr3Hp4tno4ZbBHV049oPAk7Wxm+Z5zdSH72+kXaxAlv5oUhKxlEe6cTPnGJtqND4YX5VHynUL+0kNvp1D89ARAu5Fv9aZBoZ6MobRYkQrMILZp8fOmQfUzlL31Fzw4L/iEDbi2pmFevgRkTaBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNTXVwsWnsfobihKzTN24Ic38wnbKOCUVaNDLpfbwNM=;
 b=bH+1IdBA/VGHx9o9l6fTzY9F2hNmx+pn1vWAqcy6DNaw0kj9Q2hHdJXlN9Si09ps3NzdOLoJTdl6vw3VnXJoWgy4MwSWK9KtJXrMphnSZzsBYMUWdX1rF97Sdr4WVJT9NIiJIB4k175JJPcOBcJPMyNjHFmzd3BW9bYUfHgMBSZwrqPsarpQ8Nu8TEEQInFqRig1ASGKx9sBsYYkrRmABKAbOpcBtgSWI4nLBAhIGoZykuQnPNxV4coGzGfcqjTo5IzRayXy93vUJxK6wZuGFjdXSbUOoKak4o6sr00FKYyTNtX4GvFGu/YNR7hqFsxBCroatMR0paV1KrqohD1Skg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNTXVwsWnsfobihKzTN24Ic38wnbKOCUVaNDLpfbwNM=;
 b=n4Ku4gtAM4uUqnKJEKIGhX69CT0Mqn184zom2kzHaiL9aHPbCTdDCdrlmzq/dDlxymTSWDp4rkJI5lozS4UyomAlkVcu7PqzdXt7Q4Mym8brGQzK5ILdhfiA5H26scF7UKekx10gRQJ9oCjcTHAmuwyATRr8QnSTY634JXC/b4KpJ8vCjin0NkGa0EK6HScto0HL9cxkE4tZ58DnEvMDn0JaLkVydhv84ugEiCPWeAP441nmzx811NN0fPG+Z9TxskWBaCn7WszUropLVNV37Ka/5O4cm7Nob+iG89/4mowYUXiWzdykKoyweweNw3mTXbLJqirmgiV/5w5ErfwELQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Thu, 25 Jun 2026 09:29:14 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 09:29:14 +0000
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
Subject: [PATCH v6 2/2] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Thu, 25 Jun 2026 17:28:56 +0800
Message-ID: <20260625092857.41139-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260625092857.41139-1-icheng@nvidia.com>
References: <20260625092857.41139-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2bbb8a-acf6-4179-c567-08ded29c386b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	T6MYd1WtS1MBhhBmxoaeRrkFxgIlowvPNyg6QErHSTwLMFtgRzdSGAP5eoKXvE7oX3NGIOCzjkwBPPGA1Y5VlvuFvXY4ACc1vMr0N2M8+lgt1wd8Ks/jo54rC3OZ/o5HQJ/VjpJ4ftkEuHbdeCiFTAQp2FbHfeyIShF5XpxYbnsyHyXG9VbDBFzhTrddGPbR/6o9fTfPlA+TL9gydFvB6FeJTeV14elEg/4BCujgf9gGoNU3VzVdepcRlSjFZP6oCc2tQNClqIdzzyseAi0M2TlfQkH7TRCGhaTcV5YuarDMcrgvnlUzZb8UZmp49j5CqRMJqPu6VN7dhSS2+k5yglYFIBoT/ad5mQQ+YEBWpnioTfSSiNOdftYATgU38DyECD/UM0JjSbRgOJC1+q68ndIRJRAVhevwDd/m+2fHo2aKQQCI2+zUjapLv0yyq3J98hyyoMOMT9oMGbvwMRiH7ZPNPQzjxGc2I+vYZFBhPjsxggJEyAsD4z8xwFKDxWZBFe/5thAzsigDdm2Wx1Z3sUhN8V4cYO21NnimqjJjYJSNZyyPFkd/B0mAdyx8r2ZfxQLCQVsbCKJeZQCUsgAGpDHPGoTLbDhGza1C9NCLF+emBtGKFdu4QqKl42183twfFLNpSYggO24h8ZHuoxfuB9znQ4OJK0xTsjMYSokqHfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hOOJEXDPgT+fRDW9r/QIYQZIWQsQINwDMe1VtwP5cq9lMumHsclPM8nGCXTX?=
 =?us-ascii?Q?rIDqudY8ejuNL691eVboKKWS01tx8Td/zmhHpcN1QPW+fr6S1+ZZ4qGZ/EW2?=
 =?us-ascii?Q?9sK3swR9TmgvEuBvxVHDEIQPIs/TxJZAkL1n3MBuq0eXn4sN+lCnoqzrAWMt?=
 =?us-ascii?Q?23AVs7Qp1haXfJX/ogoGADkujhRlssIecTzjrmnCnfTjquykTgbrKbGUQKAh?=
 =?us-ascii?Q?f4u4T1dFiochWlkh8onhru9kYQi0Z9GjzUTSWJw9SBlU8DyKj1ELDYg/j7AF?=
 =?us-ascii?Q?362lOVEUJ+kUYja7A52KCrLNKkZ6EwRDtUmT2YZajrfz3GOiNbjoG03Nlaoy?=
 =?us-ascii?Q?vKbAHRbn/HAfKSFdvk7zUHm+ktN3xiUG3PTUh2WEoCzOFHK9jZtCEdLwVYnx?=
 =?us-ascii?Q?SFvTK+2zc2v15SjYFZ40lju1glgWrtGsYDzXvP8Z4GAQHRwfpa3Ezfr8Sb8z?=
 =?us-ascii?Q?fF7cKwbvNWJvse6WYUAbUZ2JqGx4xNQL1HFSZgQnvTgMYQIyWS1IGzHQg4dP?=
 =?us-ascii?Q?hZA0v9lurHqvNf3fl80dgK/4R+cI4NHhGLQ+AVGC3uu3th69gOuP3cY9Cn8U?=
 =?us-ascii?Q?tr1eLHvRxRdgIq3xCM0rHGf+quryjPMMMfiQ5LfHzWezb0kHcUys5s5HVVFS?=
 =?us-ascii?Q?cKWoIhlZ9IDXe510XCgd6gS7a9dblP/cl0yZFCQxzHMimsAulNRVjpM3Oh3C?=
 =?us-ascii?Q?gQxBchD/oXoOowmaPS79VYRGFmBdkExi5to56fzdVregsL+L1MdibJNYt1lr?=
 =?us-ascii?Q?x9zK/e8oUORsLCQwt+QAxCHeAs0yV3yw4yHMWzIcFavuXt036tFhxWairz3q?=
 =?us-ascii?Q?J+Rpu/Ya289XDapsAVzh7TrN2lfr2a8D5BYfzUsnqy8CBAJT6HrShN4BZPR2?=
 =?us-ascii?Q?ebn1Qg7Xidxm2EQpijrydtWzC+HTqIZPW+w7Q3Kpn84keXTLe+nI7N3E4VOo?=
 =?us-ascii?Q?iGgrnuzEBMjO2Uu0Pdv0wRY+yaj27w3AWazjbSzwMVc7D8XGbgZYR1ses13H?=
 =?us-ascii?Q?6BkAc6hbB1cAKjoK/QFuL+7zTtnEK2WXO/D6MlOrbvaKyUu1+NvrFlr3JqaP?=
 =?us-ascii?Q?IvqQjuYnhgMRmkqjvV8AX+IPY4CS8LpBSmuC2up17ThxUDvT7snVwieYeYrs?=
 =?us-ascii?Q?n6FQ6FeGH6SXYPZucpLF+0w5/onU0UR/ZSJso9RIoim3cTsL+SDXvUgtwzjG?=
 =?us-ascii?Q?umjkE3XlEHsej0qlO4e6wrePCDc/IVdpUr8OaXLvCz8lnMSz8LdKNZHPFg5M?=
 =?us-ascii?Q?SL4pPneHI5dF3T+N1j8riELaFXBg6FMmEG4bw5O0ZR2SR5ZjYCP9Z6CPPyIS?=
 =?us-ascii?Q?5nGX6+5wDi9RjjXO+PUV2+7oZ3ulJs9O8gf5OU3ROLaPfvmj9aGzIw1cEKyS?=
 =?us-ascii?Q?gn/+W45/LMWc178nriGA5XIy3I8CrI45dNkSOeq/cGLd5xlMGpChhjhPssEv?=
 =?us-ascii?Q?AtiOg47r+RFmd4mWO+t4HtPFxdC3QmyaMBR4kyRO+GnZx9fT9wD20pNAX/8N?=
 =?us-ascii?Q?qchrPLLB/ZH4LGz/ojI4UkGSZZItUl7XOSVs7oVYyJKzjZCMvsK6w+jjbDCJ?=
 =?us-ascii?Q?q40Cul/8eQnfQAmq8VGrD7vYmizqxRpkM+bhO8CrIZx80C0rhjzipQd2p/iL?=
 =?us-ascii?Q?tWSQb5nKmb0qDrYEAfkT1X0EKRngPpCnQUhg9a24BnY5OzQLjDqgi8+xVt+b?=
 =?us-ascii?Q?pQyB6wulLruKR+N5PmKLvvkQWzN6aqxVAlVmQlbHUY13+0JDl5+u3fpeSbGn?=
 =?us-ascii?Q?rqswA8q6vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2bbb8a-acf6-4179-c567-08ded29c386b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 09:29:13.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yixGfigVWijTkghNplLUIrDVYXAtV01fGbFQSDN0duuuU3MvddXXZfh4qecppHmJy9KVTF5+7ey8/T4TGZQEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

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
 tools/testing/cxl/test/cxl.c | 100 ++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 14 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..117691b3c62f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -17,6 +17,7 @@
 static int interleave_arithmetic;
 static bool extended_linear_cache;
 static bool fail_autoassemble;
+static bool mock_zero_size_decoders;
 
 #define FAKE_QTG_ID	42
 
@@ -841,14 +842,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
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
@@ -1041,16 +1041,49 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
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
 
 /*
@@ -1131,7 +1164,7 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0) {
+	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0)) {
 		default_mock_decoder(cxld);
 		return false;
 	}
@@ -1145,6 +1178,20 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
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
+		return false;
+	}
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
@@ -1168,9 +1215,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
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
@@ -1214,6 +1263,26 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 
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
 
 	return false;
@@ -2049,6 +2118,9 @@ module_param(extended_linear_cache, bool, 0444);
 MODULE_PARM_DESC(extended_linear_cache, "Enable extended linear cache support");
 module_param(fail_autoassemble, bool, 0444);
 MODULE_PARM_DESC(fail_autoassemble, "Simulate missing member of an auto-region");
+module_param(mock_zero_size_decoders, bool, 0444);
+MODULE_PARM_DESC(mock_zero_size_decoders,
+		 "Mock committed, locked, empty decoders under host-bridge0");
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
-- 
2.43.0

