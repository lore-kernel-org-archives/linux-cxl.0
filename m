Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794013185;
	b=vfWoM5jJI+RnckAEnWWU6b5olEHrekqoyctBg486rCgPTWfA4rQgcYX1buhp9mr2MlFq
	 WsFHLkvDn0OWRlAsInE6UlxqvmseozRoro+b7GuoLsIWc5uPZzyZ3vZsfPsHNJQw/Ity4
	 V9k1vvo/PUMD+JXE0kB/9UlaKmWI/h8bWjoDrkGvkZO0pwKEeoyZXHUZfqH7atlvILyAa
	 qqSUxE9WZqTHWvwEqiFeYisrntH2XRD9Uv7DGkMds9g5FVtBQ9+UY2dfqUNJTAEEFrypF
	 EJYJxzAgSgh0j4NvoylJCe8cSPjJxbwEPx54ibTogmIVEfw4mAePCO/DCwnQMFktZHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794013185;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=aSPMS9R5QMfnG5aITN+IhxYMN8VmDhxB4VrcLYBDEgw=;
	b=1hmSZ6xXSQSUY5XeEjj0U8dnOiF2pXwByit3lrMMVzco1WQcXKnmk46xGuGTtu8wtNs3
	 LdaBwdybWAWy2WzBHIrYoJMjxL+mv319Kh6xLhnFoWbbX1ioOA9Gyxi4QnbqJg2HIt5Ty
	 8B9GZGz22rs4js7rxS/vcjt54pmeuBETJ7kW7yyX2SnJlEi1zlHJPDQhlCFveV4tOv3yA
	 YcW+FZuXM5jHQpgH1Nm0Ry18bwEHORDe9kHhVOFrPdk2iWdmHZdZL70kqfHQPaNiItxuO
	 5DcdBSFRLc7WrZ+M9NFAX/Lk0XnU0Q0G482+rgXedKMIKcfgzDAOen9b21cwb0nsXQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kYySKDhx;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22F2606A32C
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 00:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D22F2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kYySKDhx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794013184; x=1825549184;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Q2QNehJYd5w1wD1kRpYowgq+Mh/JWmCEw55R47MCtUY=;
  b=kYySKDhxRmDvxdJ5stb2DQudO2krvzEjI1qBC0sbo4u8+MIDwFY3PnD7
   SKqmAIyJy+p9dOsGQv7a5FTmSJYUkIsDmwaGNOork4OFx/57bXspu03we
   NzhwGm9L2Gsx+/teWH6W4S0G4aepeipm3h3xGfEYyml3ClbPz0Nhyb7bz
   EmbXwMmHgYPr4JGkUBtsUONcxP1VVd9kkxaz4s5n51i4VnFnTgjXdkEox
   BKEPY2u/BRkV9S/lV6QxjVS4nVD9n9VPwDaPO79ADWY7SQLX+4Pj2yqea
   rBvkOI6E9hxmz4+nxAs30DsLWlklEuHWvxrX6Rge5fvFhQHB5g/f7pGUf
   g==;
X-CSE-ConnectionGUID: kJxNQHPYRqukDK+No3a09w==
X-CSE-MsgGUID: zn8Js/ThTnK5fzAKopE2WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2732811"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2732811"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:59:43 -0800
X-CSE-ConnectionGUID: Q/+dV6sQSPKDgEeCjTDtYg==
X-CSE-MsgGUID: 9RpOg6SFT9a367DjnwMBTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7395461"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 16:59:42 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 16:59:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 16:59:42 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 16:59:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to6rSEYMN3s//jNSELVyMIMP72UHGXVc5bP8/7wIF2/we/bMaaeDz66W2l4eS5JMiZHsbteqB1MY3RIhWp5U3Et3LABDdcnmCnpZJzOxaRUPyGzT5an6yjC2IMs9sQ1MiFXyEnxLHASbLvarkxJI4XTuUzQgbTuYoRuRO39YTXVSVCXOO0W5uAHFA0cqZUF7nQFs2qDkbI1YsJsjHkNwvJdeqGWFjaw04Rj4NwRs1s3VCcVqjSrBhdKVkiqsAdPT46p0VJUzJBtUGyU7J+9JPPeLFK0Lm+/lrAIjgn90dqKcnK87LvJTeS75grFeDlV+2kALNeFxkRZZlxRkDSMW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSrnss2VEuq5m6C5GBFBkKzyX1Olxbg31Pfq4D9wIAc=;
 b=Wx+9HuBUh3m9mB9UWIeUcrENIUsZFv85lglWnqwaoA5StHDs7T5fVDl/ZSmREYaVyvWflTOMG87zv8QEB5YdjSVin8uvCf0aUmlpc5HzXHf7nngjLcSU/rBk4Z0p58UQo1hJQ6tzKxFYkIY4H8LIxEnbIMdYZ+LHMHnsJpJ9qMYrVJ5ygoo+q2ta/MSFLRhYIDX5JyHiPfBbZeA4RP2YQ9RN0nCGedwXmvryMimHa+CFb7R4kj1Lm7Y1flfGjTPFVpeXW0MOusH/9lfqw2GRpsiWKyaEK5zsx4wzvZp0VkH5Dr+dr1+oShDUos6E4LTdYTWDJEM/OcPRj9m6rqUPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 00:59:40 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 00:59:40 +0000
Date: Fri, 6 Nov 2026 16:59:37 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] cxl/region: Support auto region granularity finer
 than the root
Message-ID: <au53-SG5utxXaTbE@aschofie-mobl2.lan>
References: <cover.1794000806.git.alison.schofield@intel.com>
 <15338cf5f174c87f414e4518b24edb3c1f8371bd.1794000806.git.alison.schofield@intel.com>
 <sashiko-outbox-202327@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-202327@kernel.org>
X-ClientProxiedBy: MW4PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:303:b9::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c2e281-7452-4c92-1c85-08df3c6a66df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|260925022911599003|260925021911599003|260925021311599003|11063799006|4143699003|56012099006|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009221227099003|261009223327099003|261009221727099003|261009220027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 1HJ9TPTWRpLGRSoSapYv1eD0/Q1SKhvz2oLPkxravpBKLAxQUsCnP79B6Pk3b9EGt9C0MwPLVyZfaV/MJENihwOVY23hR4qtS5UvKCkI2sYj9uGNbsBCEMksnxexXldGwj2MrCgn/KZcWes5I5TGe4TdWGvWNLvmCA4Q6i3J/xulnWNU4qlEGp4Jb1vP8jIXfjhSJEzah7IkDhgGP3W6k1I3c8zTKvh+YjkifXrCFG+/u6puKtB+g+ob/gPjH4nEfMahd78UrGpo7+BC8PsNPgAhdpkC57AVyZ9WHzyhngVpPtD5Wwkrrx6A1ylh07z3ZngmjWPuxJvJWF45dMILEIgPqHWPeUSv0rNgYlp+KTSso58iFwqd+90LcRt/U/J8FqnKOllwOLzS1bYPUABsUgy3CIlUT/uccsz618k6AIx0Ew+llBKJbjIC2y7+xb+oU5yJvreqgOvgd1uxa+YzmP6deTQ5lqf0aQIEbYHehkXVLbuWNUg5bOuxshPtt8q9xVBqcWqtKMR738RUesZcRFc4fwFJPLAv6JKpKmzwFmHVmMVb4Td2oI6pWhbRw9jsBQSlRm4birZlhIdqMPLtrX8IUMwq54xxO1WiCjxXC4M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009221227099003)(261009223327099003)(261009221727099003)(261009220027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?y1G5hLHibFnQRgZ+bS9wRHwENSFwyXNCuiF8UXLGVIuv2+COnXciS9PSJR?=
 =?iso-8859-1?Q?wgOTtMyvHA3NGi1M5YZmjBO1pnrmSvH8VQLAgYK1BhlybYvC1sY8bUMA26?=
 =?iso-8859-1?Q?9E9mr0fiy0qxTrIamHYfMGUnvvRUHK7ZH1mA+LaTk/pUkVsVCz171AN5Qa?=
 =?iso-8859-1?Q?tF14rNWj+472LJ3sNW/ztGdUd/VqFvSLFV/3A6uaIzwrmGFWnkvrSupfTd?=
 =?iso-8859-1?Q?zv02IVeuuttF9b7li4oPMTw06smgF4wtJADRXQw+VgyDW51yQgwO5EJZLe?=
 =?iso-8859-1?Q?E3/Ty99o2oEbRBBjpbhuJHbmLUpdggODk/+ZGgqNCv//8d/foqdZTRqMdo?=
 =?iso-8859-1?Q?JQeUuCgIzH23rY5gX7aH36m/O2/ZFuf9OnbbFuYKKoHUXIzRDvRk2qe8DQ?=
 =?iso-8859-1?Q?i+9bCUOHKumePOgh7CTHxNmcFHke4rYTWpPgwxZDClOoK9PrY/jJ2VjHX5?=
 =?iso-8859-1?Q?pBn3rh47eTfvsBbcUu+wG32YWMnBTpgZ1fNMKv3a8D5U6ffaIz8M0udkpp?=
 =?iso-8859-1?Q?ldIGgP9FSz/BY82zyWvU77gE5qIzvR92S5Yr03dIRWbIdZUmazFHsGURDJ?=
 =?iso-8859-1?Q?ZW3sc2KNSdIqpE+hX7F0f4WlzpY6DYFjzgxyimVPADQpJZMI1Y2bJJ9rT6?=
 =?iso-8859-1?Q?76xe4HjgsLEnV7os+FuFFJWtZSoHMQ4DZgqyYWOCW/pnT8M5ubtru3TGMt?=
 =?iso-8859-1?Q?xflsXi5HYTCjT9DTvkCM7HWsjNA+vIZcTlcqYc/1mtFOT1sz1qoj4ibSBi?=
 =?iso-8859-1?Q?I2AYlkpGseahqosmzHNM5zM3B9eGqH9b/rgadj8bnsr4Y5cljT+nK+YcyL?=
 =?iso-8859-1?Q?xCMUPr4iwTx7CgHEStcgjR3Uuk25PrVJKzfbzfJfwNseMpIcET8Meqt02f?=
 =?iso-8859-1?Q?3r/lo/0yKW3sLjRfxvmxm/ua1IFcXHGlV/0aEpxXlafJxuCGvyaA+r+Bhe?=
 =?iso-8859-1?Q?PKOY49S22owMGwBK91Ro5dRcP1IzGf4r5W/mOucEe5rg/R1CJvOynTTTU/?=
 =?iso-8859-1?Q?RxA3WtMj+p1dGfrv3FvCqjO5kVquAR6XduLJ/5YEPMYQC9KKyaZjA1nM91?=
 =?iso-8859-1?Q?l3Fyw5uDaA2Wn6gS049+AnfHPq7DqMB+CnW4OUYOr40H2giAQLF1XjPM0l?=
 =?iso-8859-1?Q?R+CLSXY6KJ48q0pHjGeyAVHItPtbFdOBKdUxxI/pT0zFTHvx3tspysAZQK?=
 =?iso-8859-1?Q?ZpTu6Vc/yB3E1uRAevgaE6VBxALw9/cUJnzJUv7g6vrPQ9EKiu5PhLo0/k?=
 =?iso-8859-1?Q?dxd/fegd2uYfASn1J8W3fhKIdBaTGXkgZaHaIWp0+1MJXJLzcy8tdeFdMV?=
 =?iso-8859-1?Q?4VbuuPCXl3j+C9CQC9dNzXDgamjYQFD49FE9CfGePM2la/SOWMSHeJz/x1?=
 =?iso-8859-1?Q?AjO4XqiNTchEqyhkYXn7/wi6mE/eD8pcKc281nI0lXOXE8fCSU3J32RXok?=
 =?iso-8859-1?Q?uN9w67Ul5/yz5sWaw70XmHLzwTrlIkM/kkrCStNAOTYKauk+yV0B4077lm?=
 =?iso-8859-1?Q?99TFfEVJbnFJQfLNS34r/NOYl6Sz08JrEeCczqxx2SdQAwUjyQUuG8iYBz?=
 =?iso-8859-1?Q?N/s6JcZyS319Gz+Txon+LYjCCOfeemRJHXgCr3dGpX+Kh8VwysaTDWjEeu?=
 =?iso-8859-1?Q?Xit9o5Qc3YkB7eNfNW4F1lLjzE/Z9BTo6hmpDUg8kOTR+oY0iz3WCWvulm?=
 =?iso-8859-1?Q?FkYCEKfCjvC0P3RfJ599T+qMwGRibdIBrbdNL4HKtmUd58EJByfIw4iZa1?=
 =?iso-8859-1?Q?uYFISPLi1BW43LBuGl94vDZO48AtmdnBnWwc0oeI0g9qs8O308RozexUFW?=
 =?iso-8859-1?Q?3epdBnbi2GOpwZNZ+QS/Spx0mrkavl0=3D?=
X-Exchange-RoutingPolicyChecked: SMMCO2RjkTO858DeQqlP5SexAT5Xmn8U3FKZvnykoyXXv1uiCx9wGDjpnrR/P8KVG9jw7CPaczCWsMfK/yi2WWZGDApu6c3D/S2bw0GNZ6qdAUGFOg10O/fgVGwrY+4nMMfbQ5+Y4qIWsVoC5TbwLv/OWBVdQLh+uCBS6Z5Yk380w1/Wd2j3VkxvpqxVgjZmYneAxQsKCmU26jzAvmiufNgZRAapvd7a+JTQ4LYcUqqMqKm8CGdZutEJFuyKOJfHJg53sK9Itn7n1PD1z19bZaQfjZk1sHnVtzYOb3Vz4GGW+pISvWuFhkJTUfTlwLHr67gz6OF6x5Gj1Owkqbwwkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c2e281-7452-4c92-1c85-08df3c6a66df
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:59:40.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENGvZfXZYdPCjbp22K2kwBYkVWtlS5uyaoiM0a5jU3wzGVH+ReiQJQcrufV37rSd6kwecbNj2P8DnKhp7sBGvFIe7+kE4ZXnNgp8T2ddhPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com

On Fri, Nov 06, 2026 at 10:22:37PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] cxl/region: passthrough parent granularity used in
>   cxl_port_calc_interleave()

A patch addressing this is in upstream review:
https://lore.kernel.org/linux-cxl/e99646b0692e6e01b2f71c6a80cc664b0066db57.1794010889.git.alison.schofield@intel.com/

> - [Medium] cxl/region: unvalidated endpoint positions in
>   cxl_region_sort_targets()

A patch addressing this is in upstream review:
https://lore.kernel.org/linux-cxl/20261106233711.2654827-1-dave@stgolabs.net/


> --
> 
> commit d69ce1cc3e00f111d2894f426382e5b9afaa5815
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/region: Support auto region granularity finer than the root
> 
> This commit adds support for assembling auto-discovered CXL regions whose
> interleave granularity is finer than the interleaving root decoder, and
> updates unaligned region offset-to-DPA translation to use the region
> granularity and ways.
> 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1594bec3930bf..0a39e634b4b0a 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> [ ... ]
> 
> > @@ -1449,6 +1495,14 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
> >  	struct cxl_port *iter = port;
> >  	int distance = 1;
> >  
> > +	/*
> > +	 * A finer-than-root region refines toward the endpoints, so peer
> > +	 * targets at the finest interleaving level occupy consecutive region
> > +	 * positions.
> > +	 */
> > +	if (cxl_region_is_finer_than_root(cxlr))
> > +		return 1;
> > +
> >  	do {
> >  		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> >  		distance *= cxl_rr_iter->nr_targets;
> 
> [Severity: Medium]
> Can check_last_peer() index out of bounds or dereference NULL in
> p->targets[] when cxl_port_peer_distance() returns 1?
> 
> During auto-region assembly in cxl_region_attach(),
> cxl_region_sort_targets() runs before cxl_region_setup_targets() validates
> intermediate decoder granularities.  cxl_port_interleave_pos() scales pos
> by gran / region_gran using the unvalidated decoder granularity, and
> cxl_region_sort_targets() only checks cxled->pos < 0 without verifying
> that the sorted positions match 0 .. p->nr_targets - 1:
> 
> drivers/cxl/core/region.c:cxl_region_sort_targets() {
> 	for (i = 0; i < p->nr_targets; i++) {
> 		struct cxl_endpoint_decoder *cxled = p->targets[i];
> 
> 		cxled->pos = cxl_calc_interleave_pos(cxled, cxlr);
> 		...
> 		if (cxled->pos < 0)
> 			rc = -ENXIO;
> 	}
> 	/* Keep the cxlr target list in interleave position order */
> 	sort(p->targets, p->nr_targets, sizeof(p->targets[0]),
> 	     cmp_interleave_pos, NULL);
> }
> 
> If firmware programs a bogus granularity on an intermediate decoder,
> cxled->pos can exceed p->nr_targets or CXL_DECODER_MAX_INTERLEAVE (or
> produce duplicate positions).  When cxl_region_setup_targets() then calls
> check_last_peer() with distance == 1 at an upper port, pos < distance only
> rejects pos < 1 before indexing p->targets[pos - 1] and dereferencing
> cxled_peer.  Because cxl_region_attach_position() attaches endpoints using
> the loop index i while cxled->pos != i, later teardown in
> __cxl_decoder_detach() also hits dev_WARN_ONCE() and fails to detach the
> endpoint.
> 
> Validating that p->targets[i]->pos == i for all targets after sort() in
> cxl_region_sort_targets() would catch both out-of-range and duplicate
> positions before attachment and target setup proceed.
> 
> > @@ -1476,15 +1530,17 @@ static int cxl_port_parent_interleave(struct cxl_port *port,
> >  	int parent_iw, parent_ig;
> >  
> >  	if (is_cxl_root(parent_port)) {
> > -		/*
> > -		 * Root decoder IG is always set to value in CFMWS which
> > -		 * may be different than this region's IG.  We can use the
> > -		 * region's IG here since interleave_granularity_store()
> > -		 * does not allow interleaved host-bridges with
> > -		 * root IG != region IG.
> > -		 */
> > -		parent_ig = p->interleave_granularity;
> >  		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
> > +		if (parent_iw > 1) {
> > +			parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
> > +		} else {
> > +			/*
> > +			 * A single-way root does not interleave, so its
> > +			 * granularity does not constrain the region interleave.
> > +			 * Use the region granularity instead.
> > +			 */
> > +			parent_ig = p->interleave_granularity;
> > +		}
> >  		if (!is_power_of_2(parent_iw))
> >  			parent_iw /= 3;
> >  	} else {
> > @@ -1521,7 +1577,7 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
> >  				    struct cxl_region_ref *cxl_rr, int *out_iw,
> >  				    int *out_ig)
> >  {
> > -	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> > +	struct cxl_region_params *p = &cxlr->params;
> >  	struct cxl_decoder *cxld = cxl_rr->decoder;
> >  	int parent_iw, parent_ig, iw, ig, rc;
> >  	struct cxl_switch_decoder *cxlsd;
> > @@ -1537,16 +1593,24 @@ static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cx
> >  		return -EINVAL;
> >  	}
> >  
> > -	/*
> > -	 * Interleave granularity is a multiple of @parent_port granularity.
> > -	 * Multiplier is the parent port interleave ways.
> > -	 */
> > -	ig = parent_ig * parent_iw;
> > +	/* Finer-than-root regions refine granularity toward the endpoints */
> > +	if (cxl_region_is_finer_than_root(cxlr)) {
> > +		ig = parent_ig / iw;
> > +
> > +		if (ig < p->interleave_granularity) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s:%s: granularity %d is finer than region granularity %d\n",
> > +				dev_name(port->uport_dev), dev_name(&port->dev),
> > +				ig, p->interleave_granularity);
> > +			return -ENXIO;
> > +		}
> > +	} else {
> > +		ig = parent_ig * parent_iw;
> > +	}
> >  
> >  	if (!granularity_valid(ig)) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s: invalid granularity calculation (%d * %d)\n",
> > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > +		dev_dbg(&cxlr->dev, "%s:%s: invalid granularity: %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev), ig);
> >  		return -EINVAL;
> >  	}
> 
> [Severity: High]
> Does cxl_port_calc_interleave() use an unvalidated passthrough decoder
> granularity when an interleaving switch sits below a 1-way host bridge or
> parent switch?
> 
> In cxl_port_setup_decoder(), an auto-region passthrough decoder (iw == 1)
> is exempted from matching ig and its cxld->interleave_granularity is left
> at whatever raw value firmware programmed in the hardware register (such
> as 256B):
> 
> drivers/cxl/core/region.c:cxl_port_setup_decoder() {
> 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> 		if (cxld->interleave_ways != iw ||
> 		    (iw > 1 && cxld->interleave_granularity != ig) ||
> 		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> 			...
> 			return -ENXIO;
> 		}
> 	}
> }
> 
> When cxl_region_setup_targets() then descends to a downstream interleaving
> switch port (for example, a 3-way root at 2 * IGB -> 1-way host bridge ->
> 2-way switch at IGB), the non-root branch of cxl_port_parent_interleave()
> reads parent_ig = parent_cxld->interleave_granularity directly from that
> passthrough host bridge decoder.  cxl_port_calc_interleave() then divides
> that raw passthrough granularity by iw instead of using the granularity
> from the nearest upstream interleaving decoder, causing auto-region
> assembly to fail with -ENXIO.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1794000806.git.alison.schofield@intel.com?part=3
