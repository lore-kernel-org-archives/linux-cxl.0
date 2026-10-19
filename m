Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792442369;
	b=WTLS2MqL0MdLYPXHwpxsQtiFPOeqVZTMbsb6I97IIdGfehwQGEh2ZFhrdbdkMcegWzcl
	 JNLdisRrZzaOvmlwUPPxBaDVJ+AZJsslXWnp7fyNW2xds3N2Qrcn2DqYkIge5lUCDebL3
	 Cry2PvrJpr8VttzG8r3RJ74vk44O9UtPqF6yeiwKM478YxVNSpItmnBTnSz5sxvppEJ8G
	 lNlfYFbxYiHgAY9klylDAI42H9V0DUYBIlGE2oJ5kE7dekxUIzRFD4lrqeYWAMWeMz6XE
	 Jn6kmQuCKuiZV/2cKwXLkj6HDQGemCQJwjt2s7vbA91dVMG9o7J0ZnGzOD2Tds+Rxhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442369;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=vaDkPogIZLQdy9PJ7lRa+s/VcUE2/4J6yONQjZkmbNI=;
	b=wCiTGq+PwkO3kW5/3cePy73D5eTTl5cB5ZvomcP+Y8Ufx7L+ZX0W1koSyh2WSAd3D4e9
	 VQuRqjT10nsxBkN+HWtHnNXlf3GGgjSiFY8jTfMwlagvn8G+VlNdiTu7FpIpQzW3u40xA
	 NPqbksGdmCzwgzwJO4ErdldPqu+bKISlXvbO2vFtzFVc9qJ7c3P7u/0r5R52AG6XIb6Vz
	 pY/R+Ks7ASdQJViSfI++OzBkzNc4GtHxoQ5dBtKxVH5fETmqn4QJTvaWqFLCMmggu0QT5
	 z/iuZegUwZx1kJh3U4CTqDTL++j3vbarto+PGtzd3OH5AXLRf+BEwuTueFQMHSlOVhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fwjrfuOd;
	arc=fail smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E04606A31B
	for <linux-cxl@vger.kernel.org>; Mon, 19 Oct 2026 20:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E04606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fwjrfuOd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792442367; x=1823978367;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bThwSiJZ6AFyJeijad1zi8jyqfuXXGplbgL6UwTaz/Y=;
  b=fwjrfuOdYf0xI5J5IB9QZJXXQT6KO3x1ogUqCYfgtXZyFf6/rR75VqK+
   z7K1Sj9GKwrghmHCroPmS2xFwBJIYPQggN1Xfue4+ojQIUqJJXcVCuvBD
   mQboa03psFgUjBxiqANHYC4WAe1i+jPUmuWDJW6c9m7bSlQ5g6jMDu+bb
   BMD34RkwnUOp7XbDLekVI4h4T6vVvLa37vioFsi0BNXCpzMBQDSR70krU
   0rBJrhNFKomXUmXT18J7LV0KW+CiORz97lAM5Ra2JbWjjpIUQHeufKfrm
   AGfWCYpcEnmy6u+egCsY/HKwUJz7z23jv9zXk6IF6FYL5xkZgb0Ixv17Z
   g==;
X-CSE-ConnectionGUID: Mctg8MZZRRy9suSUw7M4Cw==
X-CSE-MsgGUID: 55zy87ZVS7eUnEAfMCV7Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1154232"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1154232"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 13:39:24 -0700
X-CSE-ConnectionGUID: HgYlnDdOQhap4VjZ5+gUKw==
X-CSE-MsgGUID: jvFNQ7L5QoWgdKSs6NoehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2629651"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 13:39:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 13:39:23 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 13:39:23 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.47)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 13:39:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhU10Tkz8L4Ytvtacu9ebmz7srUsenT1tIfE9OK3idYGb0zK3APsP55Qi3bC82LJad/+FzldiLhPmVepYssgODmVTlVN4VXoDXENPlEjCMwI+6/QfDKkEmnPOcTJTjQb0bfxCtk4kbLyuOLQjDeCTKYiqWWjxVEJ9GmXJhY/c8e3h2VA783jF+EznKOeOhguZJ85+ux/Tsr9zlCRuOOpDMON39NgbqTCbJ2zu83oK8zySU7fEt7VYfD5Ex6C4u8tYdUtcfNYgAXyfPWZ9EaW6cyZXyZpegtRr/XoW+xWJzuufmF6iQQpO/g1GelUrUzZJ2lj7AThnli/qzcb0fOozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaDkPogIZLQdy9PJ7lRa+s/VcUE2/4J6yONQjZkmbNI=;
 b=jMSUTPuINH989Epl78ZLb40XcbTMDf7GkOoS2CLW9hD64IEEmEpYuOWckv04kSYJLjP+OxX/3xuXUQ3AlD5lSES+m8v4eWt7SMU99CuLWFbGlOcpjsV1Kt/V42EhKRQ4k0jgaYfXxn9k/CgkO79K1XdE/g6EEF471AoG/gAN9GQfWPALEM7YkPyzQnP9nMoFbMRjrvWGKqDs4U31hkoXO34+vOSRqQjLA9TMRq/VVo46q/CNpRXrpPU9+MRkv7Tt2yHzjqY73h2YtAnb4cv2/8CR9ksuWIyQuL7BmMMa8NTc0B5BXXSpYcw2kldcD/FZSPaR/JdqwnnlmVmXqSalJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB9533.namprd11.prod.outlook.com (2603:10b6:510:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 20:39:17 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 20:39:15 +0000
Date: Mon, 19 Oct 2026 13:39:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] Documentation/driver-api/cxl: Add a testing page
Message-ID: <atZ_75-jlBACRvb0@aschofie-mobl2.lan>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
 <atKqrRww5GlgzRlA@cxlqual>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atKqrRww5GlgzRlA@cxlqual>
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5b2bf0-7c00-4387-8b89-08df2e210a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|5023799004|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ndWtYrNTUhfK3Rylvs+saQ5mwxnufIGvf/Atbs5RTMUyJP2nh5X9ZO87vEarsgKDaybeBm8MVvps3CV3zKhrEDlPLDe/o15AZRvIiN+pckLjTBVzd5hKI3dnW3OGafiiG/WhQxG5XcWekMuXJztqwXfezOUuzAQqXcBEJsVwVWIbK6Cjc8RKxk6PbOvPhTK9n9OUmzkXPFbMLAW1LXV0ZQpJEidv/wzfyniD5weZqsBHAS2X3WCB0jmqYdFrC40oAqqsZvRpWSOGUJfvTOeqb+i+EA+ovaGMfqcmTMP6H0yW5vP2iAeqEoPlzWB6SPw+MoDRMmdcKUMeHL0gy7Yb3zilNywk9A3/7ImiowT5gPClWqPRSD53SPMUdU0D+Cuj29h0+m3GQ24bWpeq5phyArSC8q1NUK8JlZUpQUMZ0JpstDuicAagWbQ4Fe3GdGp7BVTlw0U0pVFa4OYV4YLVHW3Ez6cXbxy/4gWnzKcXvPn3QPEAdVX8j0ubJpCqxprxZ96da2rZxlAD+CRmvnnvbydm72GQQGuhGHkO0ewLP0Iu9XYvuy/Y++TLr0+fz5qSgR9CEN9HFOuHTniK2Y1Ne50ezAR5nwa0P5NFvcyoqSEjrdZhUl9ywhn1e0onvfkZgkxAtI83MT1nZIrHE3eja//Fs5f8VNHHy3XNO1swfxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LR5I1eT6nHZKTo/pTaBaGHbEA2bMYYLeaa49HMfs+EobeYuC5E8mb5X2Wocx?=
 =?us-ascii?Q?csQka+5nCeOKOx0iY9ymj49WEa3OMaGCrW6IrC9/JvsT123mQ0sNPET/Bpeh?=
 =?us-ascii?Q?dV9nrQ8w8VqfPYpAU1qsplz8xRlqokqKw5qIdSKUQ55+czXWF3blG3OhHUyS?=
 =?us-ascii?Q?TDLjZsebIQCr5YbXOzqbl4HEVGMChAFKvYtP1i1JfGVTymozWcXpTASFls2i?=
 =?us-ascii?Q?CNOA+Rto84ciiOGK870l8qeZShvSpl3DQuLWP9IGNuZ6PQRed/un7g4wGPJN?=
 =?us-ascii?Q?RrPZRvtw//vLpLMruGQKzVQHXVkOJ5kVTmMhxteDn9hRQ2Tv+fj/oWLPXteS?=
 =?us-ascii?Q?IBGMcIy0FNGse9d8vqCGQJSz4CoHuA4ytq3CWK3iIJwuJzRf2tEKcADuKg37?=
 =?us-ascii?Q?zd6j2MOWFq7Tm18pABBrd3zi71U4aknfE4tAMC7Xj+cybuZNjszab1mm0pvn?=
 =?us-ascii?Q?PWca5kpr1IcgBSeXKJ/5/vevsS/61sR+GIXEL4nePS5fyWTNnw+bd5eOQ14o?=
 =?us-ascii?Q?nikAnHSKkIr0xmdpiX659VZA/RS0s9B9+a4zytlSjxOe6xDxz101FBjZPuUq?=
 =?us-ascii?Q?s18DWREn62FehCaD8ThIDYOo1ND9PwyXAOBXwH7iDUNRfmWUDOYslgQcnGDn?=
 =?us-ascii?Q?c6F88oeeTTXTKXAD/1cP6wsoibdMvjAqra4RoTLwm71B/caOChCbv5JWIZ4d?=
 =?us-ascii?Q?oX1cAv8Dff6qIQA5MMQkEDxKg+0HkOPLvCOX62CaIYbQ+vt7A6Kv2+eX0RWO?=
 =?us-ascii?Q?y5qn/caBmw+XhP9DBJfB8QEpOfe48cE2t13VU1LQVNB5ycEtgOtS2pUnhrFQ?=
 =?us-ascii?Q?iNU7SIBeoeVwbjrroPRrwNlJp+6KlMZXh8GZZVJAxnNJcMu9736jYVGbEHcw?=
 =?us-ascii?Q?nzVVyeEnl/jTMHaI2NZeHi1dXao02E6ipYqjpaOmNS3uAcpT2gidRawUdAUw?=
 =?us-ascii?Q?i96XZLt+xM2YqeW+LT0BOQc4m9D/Bpt5ni1XJGq1FC8xSgVzFALuhIpOAu8S?=
 =?us-ascii?Q?9o3gH0aRDYE5Z3uvU1lZNgrk7t29ofq3jQdiuWUCV8SXMB3MMq9avTVbc6BB?=
 =?us-ascii?Q?1+MgY1Qgq+D+Y8oDLPL5UwA1spO14ti/JGwfLxUjLilyYgsM/rVm58WRkBRH?=
 =?us-ascii?Q?alr3+s8c4CTUIhBKRTquv9JblKkqzv4zb7rfjQjUULcBJsfh24s2Z/qlK6Nb?=
 =?us-ascii?Q?DvfstF57MjiibRVxNCfyrJnJuft/2vvACvaSWUkVim0kApFt3zy+uNJA7IuF?=
 =?us-ascii?Q?E7dZAXbPVbgDf+aEFVAFQVDkjWsAsqe1sv0r+AqsqPbUM7G5iJX+NlBPinFs?=
 =?us-ascii?Q?xwXNf9v15v3jSQVpHuJKzhDuHmdsXnOnNtLIvq9H+pP95MbPLxV0t9N9m+iF?=
 =?us-ascii?Q?NycnzxEOreiZHxu4jHBTGf8NsuKEZbTgABU4qWISmk++WdCjdv4klTKaPLMP?=
 =?us-ascii?Q?2l+952jp2h7Kn/vh2KW2xWtJdutiRX7WBMuq6i42K945KhTAJT7TjWesJGD3?=
 =?us-ascii?Q?lVkqcWyAOEQTKyNt8kV1AhxuYlbeUxvBeZyLwVyS7cQdn2sm2abmF4aZM7OC?=
 =?us-ascii?Q?dkWZBzeOuSZZ2u4lLv5n67NZhzE7PmIj7G2Ed7J+vFjhnVoDzUIwme9jKvU6?=
 =?us-ascii?Q?XCuLxi4DMj87ZzHbZJzVktlEYFnFhkTQxFy0k7tCGoKcg2CEmcJI4GVM0nAg?=
 =?us-ascii?Q?k42aH5aNgRHtez5J24KIsyhXntE4++a1OXU7jbEBlX+NmbdK11LIOhLvXNZQ?=
 =?us-ascii?Q?UgbiPFD/sdpEermJ4AjuFDApk6uS9Z0=3D?=
X-Exchange-RoutingPolicyChecked: qinY5zfQl+ExJCZ2j8SoH38KyeY8P3aiM9eQnraqlYxmijQ8neWhyS0aoqFPxgMfism8TujRoROLRRCndVNPMd5WqTstCEXXpqS8Wp7l3MqW0pYpooMdqKg1ZPXwY1xDSjaYfZxkbcqODhI5PI0gVAyqK7Sp1Nmqh6+jlZA69xg2uVtaLIRtetHWTPuz/cgaTwK/CVaO59OC40kDZZ2abrO0VZvM9lxBN+OqVAsWFeIXPvgvgvK9rdsuY8uPnPteElJQ5fYYGOQIJeQfHP6oaqcWVBdEbIDPznMcIbuu/wjYpWCWcnN0T/Le0+/YN9uv2ExNPwVIm9QAI4hTVoY5UQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b2bf0-7c00-4387-8b89-08df2e210a24
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:39:15.5661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3y4IXLPowEKfIvJx9S+cJ0LFqeYo2ivPOi34F8TE9zDpDvW3GRon9IT/e1UMHYzgYmogu/1pFz94PU+CNji4p+gl1ViuYexJ4WbopcxRzHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9533
X-OriginatorOrg: intel.com

On Sat, Oct 17, 2026 at 07:52:29AM +0900, Anisa Su wrote:
> On Tue, Oct 13, 2026 at 09:17:52PM -0700, Alison Schofield wrote:
> > The CXL documentation does not describe the subsystem's testing
> > infrastructure or provide guidance on choosing between cxl_test
> > and KUnit.
> > 
> > Add a testing page that describes when to use each framework, how
> > to run the tests, and how to add a CXL KUnit test.
> > 
> > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  Documentation/driver-api/cxl/index.rst   |   1 +
> >  Documentation/driver-api/cxl/testing.rst | 117 +++++++++++++++++++++++
> >  2 files changed, 118 insertions(+)

snip

> > +KUnit
> > +=====
> > +
> > +KUnit tests run self-contained logic in the kernel without any CXL topology.
> > +KUnit is suited to logic that can be exercised with controlled test inputs,
> > +including encode/decode helpers, address translation and interleave calculations,
> > +parsers of device- or firmware-supplied data, and mailbox command handling
> > +through a stub transport.
> > +
> > +To run all of the CXL KUnit tests, from the top of the kernel tree::
> > +
> > +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
> > +
> > +This builds a test kernel in .kunit/ using drivers/cxl/.kunitconfig and runs it
> > +under User Mode Linux (UML). The running kernel is not modified, and no
> > +installation is required. The test kernel runs the tests, reports the results,
> > +and exits.
> > +
> > +Add --arch=x86_64 to run the tests under QEMU instead.
> > +
> Add --arch=<arch> ...
> Maybe also point at "--arch=help"
> 
> Reviewed-by: Anisa Su <anisa.su@samsung.com>

Thanks for the review Anisa.

I have this prep'd for v2:

-Add --arch=x86_64 to run the tests under QEMU instead.
+Use --arch=<arch> to run the tests under QEMU instead.
+Use --arch=help to list supported architectures.

-- Alison

