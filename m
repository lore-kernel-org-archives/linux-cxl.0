Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B9220F58;
	Wed,  7 May 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602613; cv=fail; b=foQPx3R2DiCgISvu1MEB3HHKE25KJwmMpCmx5Q1Tue/8sm/DBbarnnam5R6+2sFrAqI4wyiqquHld4BaymJDQkp1F2h1utLHl+6x1m4myNUriY8vZzhYK4jtxLpulxRZzAff0u/KJLpGhnOKFK4/qgVdefzZIYgzGlE/A4L4LPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602613; c=relaxed/simple;
	bh=o2LKMhI9P3K65t/zCxV5/zl8SG6L/mrCv9b9IdeYFqg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N1xFqvcVDbIb+/3K2Uq7tpL62P1lZLZoSjfv+52CI+KZtdRuLUPrENpEWWFImJgMX1YgWNZwTQFdahLH4/957lKFU46BSQ40Q1I/yKRQDP7m8uRW+BIHzahuvnOPNaG7c/v3xrplx0SmPG15eATBSgYgOcCcb29Jb4vuWxQmcsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xzb33Dn1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xzb33Dn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602612; x=1778138612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=o2LKMhI9P3K65t/zCxV5/zl8SG6L/mrCv9b9IdeYFqg=;
  b=Xzb33Dn1+6z7NEkbHk2UTlGMZy4Uz9STKev/WqqHT1sT+HyUQtwV1gRt
   NI1WZrtfmwqtXqBPY4f1ofv3qFH8ixCKWExVjaJZcQvX7aXH5HMYRGUar
   r97G7lkO2E/to3AYfgRDgRrDMJaoNpt2yhC206k7OiteFnzgN923FZtGQ
   4M31Mp0J78W1TgsoWtssU61fwIIkyzx78zf2KHRp1iOl+kmF/wU8CLYwD
   aedRK2rMwT0iWkVix7BIIT5RkZsN/98B1G6+sivaJeDKADUocP+xOTPvo
   2MlLzlqCoVjFAo0nTwPgS7HjkQ8wVggQOYHUcVQBEEUK6fK9VJeZAbXxM
   Q==;
X-CSE-ConnectionGUID: 6CEsYyYjTCyC7++V5JlOSw==
X-CSE-MsgGUID: YXu+jki2SLe/qM7MUskdmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48450243"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="48450243"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
X-CSE-ConnectionGUID: 7aVrcu0dRPmS+STTDBiXBQ==
X-CSE-MsgGUID: zf8rWGuyQnqNdzXEauNUWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="173062302"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZewkaJuHN8Cy+k28nZM3r0fvArJh2LxHbOJx2lflBQZvIZxIqOCWrNCv3+mAHlSB9WXiXHqs2qPKCp0GsQqbl64cC7kKGoSHiWE+RCUwHjFXwY3h9HNAdM2k0SdPtj+CHuipFag0iLcX7kaYy5EsmmnFCt2GVndvGvxOEUlxNgaslEvlX0ZdF2IXRketqPIdLNkh8tllwIRqETovt8P0EUFW2SQSCnHdVowlTvk3etU8hrkSx1H9bf7/cKTu2vfCqJq00ICcZxFhQ8yby7Cg3Jm9aHaxtcgi7GdPjjD0hKvZ5a09p/c8UsspgqGRPEn3DkFrgDyuTS/YcNzYGD73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nU5ZWCDfqo+khgB5n6shVGcRqm5omtjkd03su2sTlA=;
 b=cc6TJOBFSFiOty4aWAv3LSnT9LfgA4S9IaawTLebdbHF0hUM5AUMnHny8cf8RveFUa0V2FT3SKf9gfq1aT89Wg8jvnpkxLPv1e4pPxt8AjzM7e/x8vXumwf9R1XhLXBRVDlg0z2JF9crP+oywrRC2j5e1JXoTgdHh3IOeHQCOsqqx5RXnXOBo5myX9Nh+pgz80y5Lg2B3hPeESmRMFvE/crtZK9Pgo/XYVDv2nbMcDvhtVWJCrNLhkNoj0irBKFc1bShmDX1yaMNyCt6h2sKkPDxNB/jSPraPBXPKQhkD7wfQrzp/VJsEd72v1/vggAfVnPtFXJRKl86l5tc3UGvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:52 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 4/7] cxl/region: Split commit_store() into __commit() and queue_reset() helpers
Date: Wed, 7 May 2025 00:21:42 -0700
Message-ID: <20250507072145.3614298-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507072145.3614298-1-dan.j.williams@intel.com>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a575b8-24b2-46a7-ea2e-08dd8d37d6e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0YuL+kYZm4NffAvENRDszNbMmcJeLRWxNmQoAciKeclEG9SvFjimGZdQ/wpk?=
 =?us-ascii?Q?OlYgOF5MNW57/+2K93LKuyzGw8tTxwLemPIzB0B/+uihK9xrl+k8OfNF9cln?=
 =?us-ascii?Q?GCkHm5Zj+U8gqwHZ4k7mJ7NuVEjne+1rD+kWRQ9U66B2GkO8XOGS2yN71683?=
 =?us-ascii?Q?ZJU2qe5IZlK4HhVOiTI6Id66AjjlyYLg9p3sNV7LVdvqoW00+xRSVWTEFZ8+?=
 =?us-ascii?Q?f58OYWLjVv+djWmz1LcqhWYh5wT8JuMJXdYPIR1QRnEds2luD6h2J0ftRcUk?=
 =?us-ascii?Q?yml3+djJCTjsmVwRw7YVUeMazBvEjZTJnnchLFIRttcnyyW1r0vMPN6O+0lF?=
 =?us-ascii?Q?I1EmMoa2RQTFkLwKnuZrG8rH5qt0cIWneZ4k61Wu+FIAejmognnqmFUX5/v3?=
 =?us-ascii?Q?DoLzlG7xdFeLwh4lCtPDeda/UHgZMKNLBVHvFIn+WxpicSdEiafU0ed7LnLG?=
 =?us-ascii?Q?o5HhDqH83kzuyjYPIlV7qjVra2lBUh96dnp0bqfXfcN0samv8zJ+cE0SI4Iv?=
 =?us-ascii?Q?I19SZKIAKhQFx6qH0fD53m4agF36xOWdRD/JGGV02jFQJLFMLmo4xWPoRGMA?=
 =?us-ascii?Q?gh0b1piMdfyE8N16/IGm1H81sN4vPcvK2e4WrHsc5AKafRSTlbVAHEelZ1gz?=
 =?us-ascii?Q?T2dkhyUxVwaPFVYPnsUld6JTIngxe+vsgOxWl2oIRzSBgznfge0im7Jcqcwb?=
 =?us-ascii?Q?ympuPrRh7xveCpAP2k2Tn98x1ihv8gAJGQFbaqxzv60PTPe8PWnbEolfPY+J?=
 =?us-ascii?Q?YpVy61HNUO9BPDuILiN70Re45q+tcO7fBm7DxJxo/0SoPUyZIPK/AGrMtJ1d?=
 =?us-ascii?Q?f08xR2+2x7cMqZyXa+vi7EZybI5aBVYtHRi5UQPZiaza6qehuagiyvFhFi5b?=
 =?us-ascii?Q?JltIBDCyhYYH0bX0uFBPPoQPXn82PvAS24gcy0aLp41xtvPFef3IajbiUyyr?=
 =?us-ascii?Q?n9JBNJqXrlOEvnxz77iQreSb4MzNfpAxe12oRKjX3KdKPzxY24iw6XzGugov?=
 =?us-ascii?Q?zaqjglhA+d4Y7Zj5McNjG11cNgzcWd2JtWgunOZC/joEcp9vIhnlQ9m96CzM?=
 =?us-ascii?Q?5PJEIAsSA521TzYUZBpeNIUBW28uDVrTwrqrZktKjjpVrw6o9cXN3YsHLXHN?=
 =?us-ascii?Q?YzIfkOEJkLJRjtLEV5m0a1ttcOht1mZfku9dHaY7VykNaloOlep2tIkYRwk8?=
 =?us-ascii?Q?PZnoAPXgM6EGLoDFJliG0Qq3WsMSdSfiCSP68zqzTMd1bJcSLaRQOysPGv3t?=
 =?us-ascii?Q?I6mFKPZelLA7EyB25m4hf2buy7lNIMbALqdtuEAy89AL9WqgMPRCmD2KFSPW?=
 =?us-ascii?Q?4b6DGQnzTUeKxLTSC9PD94/zE5Q3GAabwpUlmj/aBdoyARmLFS3AJuCfrVMi?=
 =?us-ascii?Q?2ogAG0xTXBwcOeObeEahM9Nuk74w2xAWObeLjLPmpng9Kf+ts4ElhGu3yhB7?=
 =?us-ascii?Q?rcKXfKyjlAs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ibIKBcUTq4WKdCxNyBx4lcVzs0OygwtdnvSSfXCd+OcG9V+mzNUpsFGpGr0P?=
 =?us-ascii?Q?aDRwYHbDxV6/mVxrbPiqbmebSHod266C3LZQ9guBGCNo5iLk1lkAskMk72IB?=
 =?us-ascii?Q?cafTiEt143MyOToXodSgESITxQgilLmhrSgSfEwVQpsbuLRgpKfn/Nedy7Mf?=
 =?us-ascii?Q?b762bm8ANghNqFBjVANxbvd6DnTbYCZoWPQ0fLgyt6EGdTU9mAZHBWG0NlYa?=
 =?us-ascii?Q?hMzlYEs/VELNRdwf0isBY1dLtfJguICiNX+I89mSTJRaVupqS0/oSUEAcxz0?=
 =?us-ascii?Q?APKKUWJAeEEElyaldAstt42Ujs/nKwZ1w0zOTaVN9FagZWYjA5Sobgsla7vQ?=
 =?us-ascii?Q?h8/WeriQlfWYhdv0FCyeVDXNFeCYaTXaGCQ+QLHMORcV/lpSMaeNzzRdj2TK?=
 =?us-ascii?Q?lSMLqvDq4Qg/kFBkv4VSW5sctF9VSr2sF/KsbbhCoTU0Qrw4+r8XQaoEMojw?=
 =?us-ascii?Q?0w8eufZz1vIBCENjp5RmbsgXHZeQmf79lwqo/9eCZWKU4Iy8T2p3avsUI+x1?=
 =?us-ascii?Q?otRPLSOzJc0Qj+1Dcz6iGIyG0ykl0M2TMktEP0YtdN7AZFJqLjA26xkHh8Uq?=
 =?us-ascii?Q?sddptNYVN2VQembOfE2Vpyc2ImLuPfuMzGhYEaU5bs34PcRBl2HK47LD1qyN?=
 =?us-ascii?Q?iIks6Ps+U4fdlyqbtrN0eywHNiWi+Ca3mFL4hxWPkw4PpT/suljnaAT0+qUm?=
 =?us-ascii?Q?4Y/slgT6RIYSEZFTQlytF0JOaLqQHaaCzky+QRmdhjTD0lwG0ZIzlUAMGBy1?=
 =?us-ascii?Q?cOnotNzHPcLZpk7C7Kmgv6azK2orb/Wlh8DiggiSTbnlcxSaa5sdFdVdza0W?=
 =?us-ascii?Q?PBAWmEP5CmpXNz33bh/0OyJ/bG4RG0XCzHSrCiRKHIdYfy9Pi4Xasgf1DPKw?=
 =?us-ascii?Q?mJZtktnjxLY9ycAMpuyXr7XFi69o+EXJ7v7olN19j8Bn0Lmh8733FWf2qOzI?=
 =?us-ascii?Q?nrtd57QbYr7ZQCdvRt4zDU5qsNSYJuwaGIvLDJqeYimVns92tt+1CpfPTLeT?=
 =?us-ascii?Q?vmFJJd39jHy9MlmMjvJtQAKFP6yrB70J9wWR487bUqF737hmyhF7kPfZOXvr?=
 =?us-ascii?Q?oDj5jw/KcltFsCaIdVHURcSm7hrv0WfaJSyxXcSlzwrNoDdBgyHI55JTub2i?=
 =?us-ascii?Q?t7wTZAp5f2/YL6o632XpbUSTaje5SRNWHOIv4/iJv6eDFtewJn6NFv946AkX?=
 =?us-ascii?Q?wwvU9UyrVGxtp4QjvXWCIDfdWrJLdgK0YXbbrGcn9DASZOuMZMlAHQ9Uc6fJ?=
 =?us-ascii?Q?oq6xbSSzKd1wYi+kCe7/kSdN5nIMyuOS2LqOUvsIk9sjevltijdJPZQ01j61?=
 =?us-ascii?Q?4OMSp3vcLKmEhuGgD1wP+psnIbqOgyhXoR9kERMNvVZAIjXhKVbJsgMgdGtB?=
 =?us-ascii?Q?mSVPVkBHl0boG5lBPS+lk6u+mI56hBW40EYmuWCq7l1eC/6EFLG82t2djZfD?=
 =?us-ascii?Q?HZdisLHdEsgMl9wSGRqEikcwWYgpiYSBPfzIuG4pJxAuoUNbrEONXObLdRPe?=
 =?us-ascii?Q?M5Iq0mX41U52mQ81itLEo9bzwBZgvK3Xi31ykXNEoJMrz+Do0owvDNbH3Z85?=
 =?us-ascii?Q?Hhq7MX5VDgh/OcXvD3z6gQZV1CponWwTZtsNK2mzvFzrj5MUGPuAmeutrrgq?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a575b8-24b2-46a7-ea2e-08dd8d37d6e7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:52.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f40Mi+BszTt0Hj1uHVsUDiqdKVCaBeCwqWb14cnaAiTsDRuPMsjvwAOP9rr62IGndeuszFc93svGRMpUMLtO94oQsbWfsdDgyF+JbUK8nVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

The complexity of dropping the lock is removed in favor of splitting commit
operations to a helper, and leaving all the complexities of "decommit" for
commit_store() to coordinate the different locking contexts.

The CPU cache-invalidation in the decommit path is solely handled now by
cxl_region_decode_reset(). Previously the CPU caches were being needlessly
flushed twice in the decommit path where the first flush had no guarantee
that the memory would not be immediately re-dirtied.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c | 99 +++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c3f4dc244df7..d52e98e2f7a3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -350,30 +350,42 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
 	return rc;
 }
 
-static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t len)
+static int queue_reset(struct cxl_region *cxlr)
 {
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	bool commit;
-	ssize_t rc;
+	int rc;
 
-	rc = kstrtobool(buf, &commit);
+	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
+	/* Already in the requested state? */
+	if (p->state < CXL_CONFIG_COMMIT)
+		goto out;
+
+	p->state = CXL_CONFIG_RESET_PENDING;
+
+out:
+	up_write(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static int __commit(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
 
 	/* Already in the requested state? */
-	if (commit && p->state >= CXL_CONFIG_COMMIT)
-		goto out;
-	if (!commit && p->state < CXL_CONFIG_COMMIT)
+	if (p->state >= CXL_CONFIG_COMMIT)
 		goto out;
 
 	/* Not ready to commit? */
-	if (commit && p->state < CXL_CONFIG_ACTIVE) {
+	if (p->state < CXL_CONFIG_ACTIVE) {
 		rc = -ENXIO;
 		goto out;
 	}
@@ -386,31 +398,60 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		goto out;
 
-	if (commit) {
-		rc = cxl_region_decode_commit(cxlr);
-		if (rc == 0)
-			p->state = CXL_CONFIG_COMMIT;
-	} else {
-		p->state = CXL_CONFIG_RESET_PENDING;
-		up_write(&cxl_region_rwsem);
-		device_release_driver(&cxlr->dev);
-		down_write(&cxl_region_rwsem);
-
-		/*
-		 * The lock was dropped, so need to revalidate that the reset is
-		 * still pending.
-		 */
-		if (p->state == CXL_CONFIG_RESET_PENDING) {
-			cxl_region_decode_reset(cxlr, p->interleave_ways);
-			p->state = CXL_CONFIG_ACTIVE;
-		}
-	}
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc == 0)
+		p->state = CXL_CONFIG_COMMIT;
 
 out:
 	up_write(&cxl_region_rwsem);
 
+	return rc;
+}
+
+static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	bool commit;
+	ssize_t rc;
+
+	rc = kstrtobool(buf, &commit);
 	if (rc)
 		return rc;
+
+	if (commit) {
+		rc = __commit(cxlr);
+		if (rc)
+			return rc;
+		return len;
+	}
+
+	rc = queue_reset(cxlr);
+	if (rc)
+		return rc;
+
+	/*
+	 * Unmap the region and depend the reset-pending state to ensure
+	 * it does not go active again until post reset
+	 */
+	device_release_driver(&cxlr->dev);
+
+	/*
+	 * With the reset pending take cxl_region_rwsem unconditionally
+	 * to ensure the reset gets handled before returning.
+	 */
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Revalidate that the reset is still pending in case another
+	 * thread already handled this reset.
+	 */
+	if (p->state == CXL_CONFIG_RESET_PENDING) {
+		cxl_region_decode_reset(cxlr, p->interleave_ways);
+		p->state = CXL_CONFIG_ACTIVE;
+	}
+
 	return len;
 }
 
-- 
2.49.0

