Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F3344021;
	Fri, 31 Jul 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480585; cv=fail; b=iQJ0rk3lDSKq69gIoiRITRhGpaQNyykpvTdEUIiGrh2KZP8FuLxFv2gF+3mKYx7z5JZkoxGZSitBM8ML2MDkmTz/GiBoepQKp9ybK9ZTPwgqDvk+5pqe2rAqjx6pDMpct3FsopctUqLqDnWHIed63dKsz1723QfzSa0qUkxES10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480585; c=relaxed/simple;
	bh=o443tHFaDflTX4joWo3j8crJ6+erM7Pl+JkxOiiHNks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPtpEbatRKQhJem4K2HaSR6w0tqPrMVUMBe1HyPelyzbxgPlt+DyR4paJRZC2hlnjGJj7fjW6VzVjFkZuWfNdnSg/feOtLZXSN6HOZM7iUTfpagoeiNwwyT1ITfdItdrXBo3QiV4n20NTfAFzE8q/7NBPIXstVT02Zx8WSVvBvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uYK1bkdm; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uYK1bkdm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2fhDaSc9a0HHsj3pyD3VE7FlKhSx8pbVGigMnPNcBD7hPvgQrqUAcbB3FGLqvoL5Gwy/xuweh2iHGGLg/ZvMDnVoMAOCSKS3gK0jxeqXpee8+jqhyI1D2C+yym0YtxtDf3FxT6KXre37EbGpec7oO1EB5B9H8aOFQXygjLVmHMB3F8xawWfTM3CtSJBT3xvrg4C+L4Uy5m4vtvgtrObndD4f/8b5DxI+UJJ+hPKGC1jeeRJmxKoKdQgfJmKShG0a5Q/G+SibM968LANELseMHHnT89d7XfceN4ZqyIE6OktwtgHK5Hkz38DS4Qw4hqdgSYwnkcK93zOh31/YJldtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2SCC4lkrcYmqDZ/9UWkNohuHEhBEr3nOScDfhkhssQ=;
 b=AO6/eAniIT5FEjGNSNJLQ4KOWIau5F6yDafsJFNDxlUuGPRlcrmFNUxE6Ntsu8alzzY4xu1T0k67swXkWcCHCMpby6oE372DkyQepJ1AQTfbn5kAmItxrhvFxJiRunW5uUMpdW8kDLXmaurB5awP3pGW5spnpOjliFqBd8mBJfsHR3TIvfGvdqChmzqQY1P7B4GnSpHiWYCcropJ1t6eoczH2dn4hGauDxO3EhhX1CnXgLDS714zgEAm6d23nHUiMqB3lS9G1BlaXiFZZ+7FZkbHXXTDV+PLQfvhaqq9ZdN4cKt78V22JJ2zeZ1WuILiDo2AqMH55Ny9kHBuEJkuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2SCC4lkrcYmqDZ/9UWkNohuHEhBEr3nOScDfhkhssQ=;
 b=uYK1bkdmKOTCg4y8YhedLcY/2aRtXKUr/ObF9c7rZ9N0WKXsf7us9jmeGaoyLhVOWSb7IJVASmR5TWijbDmncv0kuiYGVFftOLYr9n1Z2rueX3eQGBUfynTPm1KV0M080wqHdyFzYCYZ5R0Z2cAYZ1FBUPLZUsfii3psxVt31Ip2t62c/cXXHyvyQnkGXWtJFxa33Bg85o1/7TZVm63kSFurCeQuBm/HHMxuDLK4YmmzDfCfyt0lwZQExL2J70n5znA7ER+UKpcYNKR9tzsXpcEU1OrE1IiOwxvi1fPNr0O4HJDhgEOe0vIOKCgxsvSGZQtsbjgTKF4iIW5xgE1b0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:49:40 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:49:40 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 3/3] tools/testing/cxl: Enable zero sized decoders under hb0
Date: Fri, 31 Jul 2026 14:49:02 +0800
Message-ID: <20260731064902.34127-4-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260731064902.34127-1-icheng@nvidia.com>
References: <20260731064902.34127-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: c8980fb9-aea4-4a58-4221-08deeecfe375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	LfLokhHpU1V42ddj4bzuH6c7VvAYEXYE880DAp4qj5UQQZ4Qwglz0qW1rwc2zhjAqIIjvM202GFyyfRdGdVVlVzdWW4WqTv1LmAnWYJ5vN2zUsaJ+6OUU5lxD6GeTbEclAdVpQzNApfS4TLYI3nCcmiw115lPZEIOoaoxQNN5zPJPwycuY7kkcWUzE60JnPn/h5b/41ucjVoTI4jFD5hLyEeFmgyWC6NBHsBM3pXR4Ec0r4ZaSh5dDABk4l/9Lv/nJ7WB9jJHQEIrhlsG5QRJCEZY7MMWo5zirc3t4rmilqrZ02kowpbn7nS0/P29TnKGuKtQHOUIR2BUAhcLKauwVrX44nj2ewG+cxi9/YqUxygc1sp2mUkvoegygGMwKf8j3TMZgop2qIrK4/M35M4Wvm06imKADKeKBLX00loN/rICKLTg8TFA8t8vS/DhMPzBWGqqIMZQoY2L80lwZxoawyawjxxAGdb2JEXqhyDnaxCKqAQBERsUoB2bi83gUop19zTqCidBGifbmit7wS5Pp/hRTSei7vImcAU8a5Yc9GHLlElm77XUoMWpCAAA2l2hzjZuBN9n0ycwaOAKIQQtng/Oc6qeHgC4FaJGbziZRYaniXydK/Q5HlelcP+mFWtNrR1zZHCXCIxjuK4vpBKMpoghY9jzwGBCsw7YieIvBw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frQgayI/FnZuVb6uB3F7gZPuJMar87qmddGDCXBcaUl2PZ42BSjWN62KUoRA?=
 =?us-ascii?Q?HM5U9uq8jGpTCpmQElW/0JHyatkin2M1mNnPlm67h6Ul8c3sCrvoifWhBnmE?=
 =?us-ascii?Q?JLT5aq1ngNBOY8xJFL6/IyZNwI+00ovIL7y2YlvwHulGWKIzQPOmqWFx2vZE?=
 =?us-ascii?Q?6Yvrf/dXa+IBRo7hYVVKaLV38J8Q3QSo+ciYyPbi5HHvV5RzfVRWguJASGcb?=
 =?us-ascii?Q?qiyiBeTfWRU0RZBhUH7+zUU00oBynndGcYF33lVqOMmFkIODgDnAFEc7cn+U?=
 =?us-ascii?Q?BOHrPa8mionxbnhcXcop2Lg6hGsQaYaQmK7TuIdGp+fbgFngVXxRectF72UG?=
 =?us-ascii?Q?OdI1D/b5lqADwOlPesrlQLEvZkx5QCpWOyGYmDrohkQiXdfVKvBx0rEKlQCm?=
 =?us-ascii?Q?NO8TnGJoYn1jSs1Hxghb+pQ/v3pN4yp4NkHub1yQ7Fl0Cf8UkOMrrY+kT2n0?=
 =?us-ascii?Q?cUGVSLdxb3EEwZH6HHyQXa1ZuuRJH2ug9wN73BBAlE2bveRRxiyZbtonuAHe?=
 =?us-ascii?Q?DpXUbhOPDyA1H3bc9m67+Z9brfYCVt82hAha77+3vmd7zYfIkLKf/qIny80P?=
 =?us-ascii?Q?CqyDMyUugWAZ082W/ijJpCR1jSC/WezgW8NOasGANVf/jMOam8QEcthLkCk6?=
 =?us-ascii?Q?XzbljEMQR8WZow+2m+rx3JGMoH4RT3/F0JOBg27T6Zfychcb7JeslDalauOJ?=
 =?us-ascii?Q?z0jEl2MWaZhtY471RCAPeAGLxVknNQnfIUGAxse4uotdWPxVUr3rrs+vAbdZ?=
 =?us-ascii?Q?cVtWkdgCUPIpBYn1UfRjAXgyP8QQnP2Sq0ldYBs2FhrA6RtNELMaLxw5PxCB?=
 =?us-ascii?Q?YaxY7B/0RQ9Ku/gsNqg32zAUSatdsTJqrUYahvLXBSTcWaHMUXQO6dbNm37y?=
 =?us-ascii?Q?UFg/QdSG8acjU7twWOEoKpiv61uK7Vt7oD8gYNemIybjAarSgVtuBrUH7hna?=
 =?us-ascii?Q?t87EV4fONtwXRy2OCjcvh6271lBh3IDU2CtbDDELF4n4RNocKweBXfDNgmcZ?=
 =?us-ascii?Q?SZB7g7mo3U/TV7+ymWmQ1pYXq+dVHSoQ1EwXEhnVc2r7yq0Y6A5qTuQqYsa/?=
 =?us-ascii?Q?z736o4vfOD9Xw7KaZp+kabZQ/9rxVypIaox5ksBn1PTRU9tadnvMTCPKLfzs?=
 =?us-ascii?Q?o1rqP+ZFftLPxH++jgZ/Wb/aHLxip+hSx7xKNkBC01q0GSrnfQdfI9hc03qw?=
 =?us-ascii?Q?t6d4CHYiP94t6o9uDXcHMoFtcMjXel45KQHptVfXFr1XGiCGZ0Sh1i+/xkha?=
 =?us-ascii?Q?tcUWw6VjdGstOAJ50IxM7EBSdezpp8aBtq4Vouk+3T6lYMzZjXlNKrwDnr7U?=
 =?us-ascii?Q?Tf8GRF8I+K2f4qchgklhkgZZCr+2kgIUZ+ABLQA2bwK0mc7j542yYgBlmXri?=
 =?us-ascii?Q?7nS09xQPNFTeZU8vrh3va6xTceKTLDIHN8dDOaKOAnlbtlfTwikyMnGWvtWH?=
 =?us-ascii?Q?vr39A+xg9ytmvMjdoR/aYTLy8FXHZlOC7s0qpnblJpM9QfQXqhl5W8fNaCmA?=
 =?us-ascii?Q?LJC0NfCwS+a0MNwKcc1NnR6zNHtPWnoy1YrkCk770+rAOZPmcH56liSK7brS?=
 =?us-ascii?Q?jojXsEHuFT7eWH8F6ShZtU+P8Uc+ApDZgTI2tE6S89TzWwiPDV4jlqMoi+8D?=
 =?us-ascii?Q?HSUMfU3fDuZiJAfkt3fyqexoKrXik2r9JN0tIGkLxjfWYkgRVwPjRbKR4b+z?=
 =?us-ascii?Q?gaVJ5nH9YiuzY/RGRfHTMWgDM/x9dm0RCzpR2s7csCbdeu91Sfs0BuAfdXtw?=
 =?us-ascii?Q?DdfIlB5tdg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8980fb9-aea4-4a58-4221-08deeecfe375
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:49:40.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDuPgUBGx+BUAp9mp+2vr8AFhZvkTmdIE9oGnW11B2Shx/4IEfLJV24cQh6wko/EMNT2ldVJCku/Ezd0jucOwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
Changelog:

v7 -> v8:
    - No change.

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

