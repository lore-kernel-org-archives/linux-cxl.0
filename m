Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F52346A02
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146358; cv=fail; b=ZvmM3ueSMZUrFrk5NHHWv0mkwkjuyNeQbwRUlSWvvoagvaiQPXxm4dyHDaigSHkM0QvaYFUl0SjxO8hrFVy3lb4Mz94aeBw4nZCn2PBbxWIRuu46PQuGM/ByIIkStNm6ZYY+drFdB9e97ZIJRTSpW5EU3iPQCc0uEjsKL83Psac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146358; c=relaxed/simple;
	bh=uohVJX3dxnm0PfcI/3RHNp8x+IqhdcinUnXk2NridTM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DcboADgV/KAhkcFMw5cpClot1kZmIuv9ttNa2/gc5D06p7Of5fZ4hGNlqmEEXAS+Ft85EZ+tmIh5Sxq0tHOepvvvw81u8r1WzMPZF1KuPFbdr6Ug9ndjCMkw6/8S8Sg7HtP5TxG/I1ZU4wzhzd0PZ7YSoNJQTsZxhLM7okckp+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTsfXBik; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTsfXBik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786146356; x=1817682356;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uohVJX3dxnm0PfcI/3RHNp8x+IqhdcinUnXk2NridTM=;
  b=RTsfXBikSsUECRFDnuAuPW1RlOY1fAP9nb4esUKzHFB4Q/WBtfAekGXn
   IsdsWdedNP5J41qMhQf79ut+kqEaCvhRQbiabuq8tVNVQ6cTjSLv1UgkE
   pk9LbhgLD+XUeIxBIGgL45h9JTlcRwpfPCC3fyhufXog1PBdKadSh52eZ
   2jhsps83jxLhwH3HEH/G+IsA87rnQkYVWapRz1ZdZEfmSL4gHAAUWfj8Q
   wemUDTUuQngSvhbvPjy4C0Qrm2LA/RMnSTIg0+eAF5Ib0TDCsxkTvQup/
   T0KgFwuri781zt2Fz6cn/C3gP4L+8YBo3nFjeUs4Vf15vOrLDNewcrTuf
   w==;
X-CSE-ConnectionGUID: 33EwkGa5Ssy0tRULm3eoHA==
X-CSE-MsgGUID: hzQh1UKUTCuiwy2v8SN9zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="112309191"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="112309191"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:45:55 -0700
X-CSE-ConnectionGUID: m0w355AeR8KyLVJsy0QLwg==
X-CSE-MsgGUID: uQI+jYUqSAWTuaCaWQcPaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="261230470"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:45:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:45:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 16:45:55 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.69) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 16:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4PlpeIW9U9RB/65neOHrmAEyk6lNi5OeAASHUTqH4ksNsYntrEN+nH7cQnXcZ5SaCgecNY7cZbiQ8//H9zcfvQt/ZtEf+1P65eQH8VWRYbbA8Ty3loZ+2ydGOJYAomNZUHSj7IhVBWJzqHOcU40w51Lb6WDztWT2VmmAaf/KFNxXaDJbkdFx6U522+wjveaqlD7DyHWuyyjaxt0zBmDvqAExvgH8z3tzYkuYrfrDWn/n2RhK0p6sqieKkRMU7tvTYqHxTyglBmU1J10xry5e0KSxsdZcO8DGZa04lLtMPDoA8JdvYVKg/6VrvzICDmFUOXmGQmYLs2V99eK9IVJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNhgZpx5FvOuSCapFwek7ob4sGip4+5sE9XEkrG9/YQ=;
 b=K0YgsDj6SAVQOoUHbdVMQaIoAKiCMlWfShXJ9NljjgRYSdEHonNk2sgj+NXyuRmySwWE03uZspEBQFrsiF9D3FeJJZwArDcPoWKsuFDImHBiqH0wEq31T7P6EfdBgXpA3jBzatwA124XnvjNtaNxx5QzfVN72+jNws+PPQdtMUGb7tS1z8LXx9zNsMrAILAw7z6U46AkfyaYhWZXjBJYzT6MxpVgNJnqtaJ4ZcRuTOWGFgD9ONN9ErGO7taFYnvJRjcCIf4yQxs2B33P8PTNzH/uMNqK93zCCJL3eWrcoNJjbPbIhiX2Rmq/CMVfBnDhqXRnLl1ob1ozAh1uOZngTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB7574.namprd11.prod.outlook.com (2603:10b6:a03:4ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 23:45:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 23:45:52 +0000
Date: Fri, 7 Aug 2026 16:45:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Srirangan Madhavan <smadhavan@nvidia.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <anZuLSw0Xha1GLSV@aschofie-mobl2.lan>
References: <cover.1784595445.git.alison.schofield@intel.com>
 <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
 <b40874f6-4f53-4fdb-98f7-193c8dd639b8@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b40874f6-4f53-4fdb-98f7-193c8dd639b8@zohomail.com>
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc4298c-d60e-407a-e129-08def4de045b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|10067099003|4143699003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: Jvp4Xqc34OllNHin7mJ/dEuAegb+GtTL2iMQjFZRyjadH5nvOLt2yipTqHHsPg1JiiPbkxEwe5R3HPlhFS6roW7ulTUXdk7hgmzIra8W405rhD/vQqdYAtneAHQd0qX3dNUtU2lFL5yQlZqVrFQxpXvB0JODepvBfMfj4tZfTOXNzlRcp+N/g6acp0Hfr4S6vvHo0I0fVGhtaG0UPFOVFW6pQwrb/JZ0DN/J54abbPyH1VYII+Imkm6tMO8t2pZH2yfKvbNfzsghI2ITjE8Poda9L+vt8IY0HBw+Cy/uqeK9UlKC1//WXDwGH3W/cwzZHNPzWD9aMSySAXJK9oP0i/cvj7de2eSKXQ6r5CUXc+oA5ZtYrPsg1bK/T7yrHi2raWbb8F0ZqJZ7UGzTfLslJedU6RHQifVgFW9a84n9EhjEE/M5I6nD5nXDGLNk7rGcRU/yPawVSfei7kLRLiI9k+476+oh/Cmp/JZaa6ILT+1iK75bUcLI3xk8rgf55UryzNv1Ctv6gR+S5Dvu5sOioguLyqpKLxo9Bsn3wUF/CPpZTYQe5G9gDChRoCOaTkx9wcLmfBFZ+heTjPLGSuFySZLQT+rJ5xBIa2DH1KC5siUPRkHewApNMUmOMs/fK3UaY+yv9EGccMLHnYG6rx3fY6k1550qwNbR9n0XGPPpRM8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjBNWlRCdm8xcVIzdmk2d1E2cFQ2VzNFRVlESVFUai84bWIxdHRhZ2NXaWQ4?=
 =?utf-8?B?L2ZFSDJhbmhxWXRJYkNBMGpOR0Y3TXdRVWd6Z2ZwR3kvTE42eGN5UjhjVWFk?=
 =?utf-8?B?enMvYXBteEQ3bXZmdm5Cajhob1hLdkpEM1I0OUtMdk1jdThvcEt1Q0FlZDc2?=
 =?utf-8?B?VUJ3OVh6UTVPTzRQd1BteUozWG9EMVpGbVFqMmlSd0ZPb0hRVzlEaDdnTWNn?=
 =?utf-8?B?azJyejlNOEpwalhFd1pYOG5UODd3aHhCUDVhUzB6UkU0NGxPNWMzWVNDMUFV?=
 =?utf-8?B?M2R2QmVpUWRtaWs1dzM3NzBCVUpHL2NPTjRoNjlCNGRsdkNMMDQ4QnlvNXZx?=
 =?utf-8?B?VTJ3aDIxTEZDb0hyRlpaUytiSXVpN2s4QUlwK2JqZlNGWlNzeU9ERXFyN2hj?=
 =?utf-8?B?TGNDUnlMeTZRcVM5VHo5NnJJbU1VcTR0T283T1J2Tm1UalMyU0dBQWM2NTN0?=
 =?utf-8?B?ODd1UFNrVFBqa29sMnQrQWRtSTFLYjZaMStaYWZXZEZWQ1VDTWxYTEJtMlFP?=
 =?utf-8?B?NmVIckp5NzBUcnQvZHllWVdCdWRGWHpEV003VzFmWDJwRWlRK2d6K1o1WHlW?=
 =?utf-8?B?V1RScWQwM3BVekJZbVA0Z2pLcEtRYWZDZEY2bkc4NFpTNFpacHBzdHptc1Zz?=
 =?utf-8?B?UnpHVDAzcUpwTmlqZWhPbU5sQmFmZ09BT3BTb0Jyalo0VnVSWTQ3VVN2SUdl?=
 =?utf-8?B?c3VZOUVzeUNZUWZaZnp1SU5JQmlhRG5vOVVqM3ZCWWVBbk1BRTQ4YVZoNVB3?=
 =?utf-8?B?NnBSZzJVekFKOWZueWh4Y0RjTXQ2Qk1aNytYakF2ZVlpdExQNFd0cjRQWUxs?=
 =?utf-8?B?NFZCUmYvRnhRekR1YnBKUVVBV1hNY2R2aVRLU1VOMEZScEpwSTUrUUpJekdY?=
 =?utf-8?B?Z0FwUGVHUlFNYmhxOElWdGpHSWN2bTRaZlVpekJqVTZNRk5WTENxVmI3bk9v?=
 =?utf-8?B?Yk9oa21QL2ZQbythZGxHU3J3TGRPUVRoOTRGVlcxN3h4UWpzdFJEOUFpU0ZP?=
 =?utf-8?B?MkdwUnpNdDQ4UXUvaUp0cFRzb2liS3lEYW1xellqeW0wcmRJUEVGazFYY1lj?=
 =?utf-8?B?U3pvakd1Y3Y5M3kwTTEwTk1nZnppUW1sY1hFSmxxOVBFTzZ0UWY1dGx5U0p2?=
 =?utf-8?B?dmdvMVhlN1lweTVMVFljaURWc3VualZxcDhpTVdySFRUR0dMR3pKTnZvUjdT?=
 =?utf-8?B?OFRxL1YvOVo1dHphVUJzY2UrdXBvY1RNdGw1eGc5NjdpK084ZkxzV2prcisz?=
 =?utf-8?B?TGJjRU8xZDJIRUF1azJidVV5T1o4RnhGeE1GWHEraThZaEZLZXBTamVTZjU4?=
 =?utf-8?B?Rkt1eCsvZFhvYUozVmlaTmFsMzZWOC9HZ2NpTVgzWnQzMmJFaGxpZ2FkalB4?=
 =?utf-8?B?Zytnd0tCeXFmZWlqQlJKMjJ0T0JkTWY4QUVkQ0N3ME5kc0JSb3MvdkFlaG1H?=
 =?utf-8?B?c0VYS1ZpOWUxcExaTGR4QmhYR2Zaek5adXRhN3RDNHhsVHNaS3E3eVNkQU5y?=
 =?utf-8?B?MHI5Z1U2YjBvdE55M2xta29nSDd6cmVTZ1FsclNiOUN4aFdEdzM1L2grRUt5?=
 =?utf-8?B?b2tlWllUTFBWUlp3d3ZrZmEwd1ovMklreVYwVnY0VlpuekxSOWRPNU1DQmto?=
 =?utf-8?B?Y241SXFCcGw1clR2S0ZrYlRSSU03Q0hLUWplU20wdE9aa0UyT241OGhCR2V4?=
 =?utf-8?B?TW00OVdHMWhtMEkvWVpzNVZwS3RnVEw1SjIwaDIyQ1RnTTZoT3VGenVKSVI5?=
 =?utf-8?B?RWpxRlpodUttd2M3Skc1Z0ZpcFZnNVRzWGo5NGNwb2IrL2loNU0zcUpFSEtG?=
 =?utf-8?B?aUc4UUIzeDg2anQyeitVV09yS1cwRTA5U3p6QitrUUVMbDdBOGZweitlWnl4?=
 =?utf-8?B?RmI5YTVMcmo5aGc4R3hUdXZBWldlNXN6WW9iRXBOUG5EQmVWazZvK2gxR0d2?=
 =?utf-8?B?TXg0Zjc4UmlsaFhqVU5vd0E3TG1vN3BXeS8yYWFYRHU5VDBPUG1rU3BWZkkw?=
 =?utf-8?B?d0tHZkIybjZKdHBtM1haR1prSjluSC9PTjl2aExCOUlibjNsOE44UjBncXRY?=
 =?utf-8?B?bkQ0ZTZVYUpRKzhhTVlrQ2FRWm1tVDk5R1dVMUJaVm1CMFBjWitYL0x5TGxO?=
 =?utf-8?B?SVhjSkV0QytXa0FMcTk5a1BlS0NIeHRocU81bC9MSXhnS3RUamI0RGZzUmUv?=
 =?utf-8?B?dmVCbmQzeFZ4Mm9hSjJydDJaK0hKODVkZFhuT3ZJRzZrNm55V0JyNVBZQTlK?=
 =?utf-8?B?d1lBb3B6QlZmNWVNc1lYZ3VvdnlqSzNxZHR3LzFGeXFQYXg1REwyVUxKRnJs?=
 =?utf-8?B?Zjdldk1CUzk3bFM3eWVpWk1xKzdxOG41dVpmWWJld0MvQk9mMmlrSUwrZUV0?=
 =?utf-8?Q?rgK2GbSJtft/JDsQ=3D?=
X-Exchange-RoutingPolicyChecked: epZEyX5aMjoYkLP+y+i/aFMDQXb/awHmsCmZmhVupjWMP/TGZnK82EklfaUPK7PETHaW7p/z2ANs9nhD9xNwG5JKjKvFqeDdB7V/+8H5Lt0/fSGzk/FeGMV5Pu+SQwxu+MdsV57v35QvzvnAtHQdeHOho4F69kXed86ZzWF2CKQfZXTIJfGo8pgcgeWYHtStE7wZ7TyiSjTIOc3drUe16yPVcZdexIfJxfxIdTgWOiay1FdNAmge1UUoWFshryphXq2D3KZ/wTnBqEAfaHiLzozfjLMBJSVbPBjI1nmDwFgNRT8S8Os/omVYNzU4wNpZ7hVTRQpHx+mqI30rvzifEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc4298c-d60e-407a-e129-08def4de045b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 23:45:52.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWCV27JqY7HxoNnmprQrVhCjT0dZbEXR/har8fP82RiGamfdYslvjqqkbysBn1n9QvS6XeBLdhnCtS9fSvc7nmhxZbQ2HJfGo8ox8aMWHqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7574
X-OriginatorOrg: intel.com

On Tue, Jul 21, 2026 at 02:27:27PM +0800, Li Ming wrote:
> 
> 在 2026/7/21 09:59, Alison Schofield 写道:

Thanks for the review Ming,

snip

> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 0c80b76a5f9b..d81df45d8005 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >   	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> >   	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> > +
> > +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
> >   	cxlhdm->target_count =
> >   		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> >   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> > @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> >   		cxld->interleave_ways, cxld->interleave_granularity);
> >   	if (!cxled) {
> > +		struct cxl_switch_decoder *cxlsd =
> > +			to_cxl_switch_decoder(&cxld->dev);
> > +
> > +		if (cxlsd->nr_targets < 1) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: reports zero targets\n",
> > +				port->id, cxld->id);
> > +			return -ENXIO;
> > +		}
> I noticed cxl_switch_decoder_init() has a check for the value of given
> nr_targets before setting cxlsd->nr_targets, maybe we can move this check
> into cxl_switch_decoder_init()?

Done in v5.

Jonathan asked for same treatment of the target list capacity check,
so I moved that up to the port in devm_cxl_enumerate_decoders().


> > +
> > +		if (!committed) {
> > +			/* Ignore interleave ways until commit */
> > +			cxld->interleave_ways = 1;
> > +			return 0;
> > +		}
> The following part is related to a committed decoder( including target_map
> array updating), like my comment in patch #2, maybe it is worth a cleanup.
> > +

No, that part is not committed-only. Enumeration reads the interleave
fields for every decoder, and interleave_ways and interleave_granularity
report them to userspace. Gating the read on committed changes what
those attributes show, so patch 2 is dropped in v5 and the code stays
where it is. See my reply on patch 2.


> > +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				CXL_HDM_DECODER0_TL_TARGETS);
> > +			return -ENXIO;
> > +		}
> > +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> > +			dev_err(&port->dev,
> > +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> > +				port->id, cxld->id, cxld->interleave_ways,
> > +				cxlsd->nr_targets);
> > +			return -ENXIO;
> > +		}
> > +
> >   		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> >   		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> >   		target_list.value = (hi << 32) + lo;


snip
