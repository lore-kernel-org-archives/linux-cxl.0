Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361F67FF
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 01:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120023; cv=fail; b=Ecg2OO3xn35z1zkS9hVfa69aHegniL9NsSgWHGKbgTYiPu4Zb+Ea56bOUtNkDc7kbyTCbWYlvYzt59uBCs23SodIF6CjtVCfi4QGJo4uXPmPvJjept6gjCX2MlxFh+NairezLzo0bRk4RsnD8c0Ol9bGwX3dKB1hk3QAQamSEPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120023; c=relaxed/simple;
	bh=+HhncC1icRxmBfciTO3WxAoGG/iitwFp4f43VgTeAUQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HxxW+xTBI0pEIdTtOSY4iMj6K+WUz24b2jS7iaNhtcL//L7Jv/NMow6yqV2mdE58QQ008UbM9YoBHigQyi841eTKFXRbGro2TjUbApUgo/+N++B46IG/RfBHZ3zd/Bk4r1dK7OX66eHMDUjbCg1hzSrm6Rdw5Bz+27Lil6G/4zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBR+/Uz1; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBR+/Uz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717120022; x=1748656022;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+HhncC1icRxmBfciTO3WxAoGG/iitwFp4f43VgTeAUQ=;
  b=GBR+/Uz1e6Amc8aU8r0dY2Fisl1HQ5br23euKNFDeK7J+ccVlHtmw18V
   TxD3vhLsR+A6bf5wLLOsbpvJxFTxHrLiXNZ9FNRq0OmR0FZVTjgDW9eio
   44KUtSQbRg/R6nwRhBha2lmsXFCy1fHJH+2u/4x4G7MMgDJcb4821Llql
   0sqK5EE1nrJowaNx+IxwxO6Dwy8PMqKOxxMdsl5TfS6zRKpMZsWhqhvHX
   ucisxhT1gXNGSB/GZS6y227HY4z2BJqHT9CmrL3zTkDd937FmPYukY/m9
   6b+zlT5zAZVpF9qw+pIHCjOg8InVGGbqBY4s/t6mKk97Yk9mEGP/Bhd4M
   w==;
X-CSE-ConnectionGUID: OooilV27RGC741rUphX78g==
X-CSE-MsgGUID: sm6dzUyRTviz3wo3iykcoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13816885"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13816885"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 18:47:02 -0700
X-CSE-ConnectionGUID: 8x2WTarNQfOrgGsKnqTDlw==
X-CSE-MsgGUID: uWRAequnRNe/HWjitbkBMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36006969"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 18:47:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 18:47:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 18:47:00 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 18:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieX0AZetI2v+xYRNiIWd4an6NTT6rqLh2/D6pGrkmJ+0eVvka8cp97RIdF+oih1S6Ul51zCBM6qHRKLvaIwmGptzD37UPU54rUcLEcZNvtEbvsdQhr1jJwZ0H2U7/RPrdYdt5JDNHdNn1rfQtPoIyWq7s2T+HFaGbNum8RtJYOSvpf6bClH1Azs9qbuq/+dBQFaXWFS3jOPy5857vHVbFlX0zCa2CQNbF8SYY18g0S+uo3K71f67hu5s2HpEigyr7GtK+Z5eFUGC8oz1bhXLtYF47prN5fc7OX2vN31QqVa+pXm+gnusqWp3oa1Vym46NkzXlCb6pliSogwoLeujTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eZEAxaKyTmDMBdUI4zRdmfQhOdbkHD0re0etgaTNtY=;
 b=IH0oqr72Ziwo4cf/X4hS6IQIxmxp9UwgCw799yAnEs44KnQgi3+I+n4rEF3J/m17cZ4vxe6LSTusn1Dml3ird1jVSFClQYEn3Yurt3/t8Xx9Lq3BKGzKsNzInlOpE3ZXF0Kj9J/8TbnfRS8vllJ+A2OAd+XZEm3Ksallp56JIzUOfjEn7KyJFFnu4KvkFDuuYnNwSI9nX/bhp6jwRSFQIVIBI86rVt5FwBdrOXuRV34ZiP//hxahF8pUq7FD5GG0Cs+fEs6f+ymPwbz3JYaxMk0WSDzRmAj8AdAnEQuW6Orfm4dta4lSExL+xM1k0hNDWvRi537WOJT5Q4eJ7wSnuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6493.namprd11.prod.outlook.com (2603:10b6:8:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 01:46:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 01:46:57 +0000
Date: Thu, 30 May 2024 18:46:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cxl/acpi: Restore XOR'd position bits during
 address translation
Message-ID: <66592c0fbb2d5_1668729486@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1715192606.git.alison.schofield@intel.com>
 <77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
 <6657f8b2d218e_6ec32943d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zlj9wBHEXpF8M/xD@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zlj9wBHEXpF8M/xD@aschofie-mobl2>
X-ClientProxiedBy: MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: f2240a1f-bff6-4851-86a6-08dc81138eb4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vRlypdLyT1fnRKDfsBKtBUwjFjfRydLIPWRA91yOIkwXPKo9UoHrMMRo6YgJ?=
 =?us-ascii?Q?OUUPDy9jXRW75OsFXCFSx4ZkbxWTUHlTpi0Z+l1defd0rz36LBJ1QBJwO30r?=
 =?us-ascii?Q?IcyotdbhtDzVvjPOKlsIIZg6+HnkdE/SJoIyIBv0oErWV2ZtzPF6YyHOiJJP?=
 =?us-ascii?Q?3MejHgPf4auKCCWpOZWUMIUgDcbW254FclO6zmnOtCKjOU26D//LoPJYZqAK?=
 =?us-ascii?Q?19nFHuOUACVvjqQIfaOcbWIOC7+aQbr1dsTx2vdPxwqRdlAtLSW5+VDUqrHF?=
 =?us-ascii?Q?Wj3gTibl85742WeTLwrpTznK/QyH42mvJGT5QyuOeTGCARv17smmnKULhf8X?=
 =?us-ascii?Q?4glafa9Wmoj9ZqyXeIfKm1jsZQe3//tu0KDk2iOmO1kcm70p73IrPrkDC9Bs?=
 =?us-ascii?Q?UfoVFbR03fD6Ltilo5xcol2Xha71/o7/pUzl2QvurEpZQOwf/5wDJT8muegg?=
 =?us-ascii?Q?rRXAv49fyuVFiaePtHzzYMqO/GnnsK3yUlPuLn5R5JtXPtEp+EgIX/cwq32J?=
 =?us-ascii?Q?gwjYenHHGPZo2K/xtON5x8NEfF8k+YHWxX2Pz05VhRy0PpdGVUv8Nh/DOZ3G?=
 =?us-ascii?Q?f7CUlt3T5NbST7k/fL+GI3dnNlnhz0sbIq5XvHVtqBkTwwtCNr4i52FC4JAU?=
 =?us-ascii?Q?W2kjjRHQ5l+tqtNgOJw1gaIU71aJBvkYB3oevm6WHDZnWeOhRrWTVjrxsxbc?=
 =?us-ascii?Q?eJztnjHqYKVeAnIFtjPsD+PijR2frS2EUgrSEErn+nWoXY10CEikYDfhNgCj?=
 =?us-ascii?Q?Ro4O6melNv2AA2FXBk3hCbfEA2pAaBaa2t9r3QrVUulYNKeidn539WOGSqEa?=
 =?us-ascii?Q?IMviatnUiDEoksAZnR9mwWwpWQhOt8u8Rf3FGN8jdlXTXJUgOb/Ew3VYMe7/?=
 =?us-ascii?Q?MQqqqhTf7oFSNsC8NdWd/4P77EPwwJcPNJXGLhCw7TA5FFN8ZwXKb0Rw3OVf?=
 =?us-ascii?Q?D5jJ3Y7Hv+FCOdC2uLoSnDgyReBk4zYi8am4FF6SnICgH4+X84T59vm/B9K2?=
 =?us-ascii?Q?2lHsolUyBmfdV3/+C58IEiYlvPe8lljgBXYdiZjXqkSHB/d4YVw/k5OuS2Q0?=
 =?us-ascii?Q?u3z3xFM/9STwVa7d/dzQVsUFADR7wIS3Co+evgxmw4IjIomWtXlDW1YV9pYb?=
 =?us-ascii?Q?OqrHRj1OgRZ0WBe6RtnH5P+/1Pa1SIbL3F53Ch/yUdi9SI5Ru8PHl2/BJFfb?=
 =?us-ascii?Q?q4mILYjS7gcUgXaqXuPwJHxYT6IcbjLZHPWunT4OmeWm5XPjtYg4v+tO6j11?=
 =?us-ascii?Q?63JYGuQHTZc9wnpBKHXYRS2bgnncN8A2l/DOZwMvsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4+WIXWhv61icN8YUc1P4wtFumytQzXQblVLIeR1QtkCU83HUrZD9f3KjxZ/r?=
 =?us-ascii?Q?fvjjDfW7ebTl2etWrrqNU0P82UQBM3i7qZr1g6/qpcRtw7vLszQFl8V1mZxu?=
 =?us-ascii?Q?ZGNFMtYu38Qr/YqiMvY3aGKexb47ZvhyA2UueL0T33jTDQEvdMZkYkLP7xne?=
 =?us-ascii?Q?YFLVWv/vvjnmI30RK+1l7buhj9bEPE9jDsH2ysAIn/LQUn/wzLm0No849t28?=
 =?us-ascii?Q?kRyOcRuK85h/2pqPrCAHTA3z2vOaMsJt7iflaa1aO0vI0fsV6YJKapfIMKz3?=
 =?us-ascii?Q?rM4W+XNOjVhZ2ohHDuzA40Fgjn5RYJusWaTZCmKsHc7UHrcOf14qNA5JTgTq?=
 =?us-ascii?Q?hTZyiYkcIenhzZfOicEDradNFmzSGjBmgtnDc/+cum40zuo4oMAzAPF4Yuyj?=
 =?us-ascii?Q?j5CDY1jYtYeC7JJ+iXxZW/Di0sMRpIrRy7ebXMszdpj2NtVUoecajop+BiJa?=
 =?us-ascii?Q?C1M+tsLVCkeL0apLvfcauxBd/S9ChL+y2vT/siNu5G81fXNyIVa/sRasNQNm?=
 =?us-ascii?Q?pUB1+abI3pL9F0uQ/X7JlODdmf/7KBSYM8TRMPVtEFJLvlanbQGzHcUD8DFG?=
 =?us-ascii?Q?k6ObeQTp0eDvRVMfX7oZdDf2rqJG9kR4C6UiDXtwRTT7o6WFTeevD6Iz+73M?=
 =?us-ascii?Q?936kp9uWDyF3BUCAPN/3KVG/JX3II4umDHjt7gv3l1CbpK1rUg4OTeHjbr9i?=
 =?us-ascii?Q?PhtYrNjQ3jbP+3Wn/aaU8fiO5pFeq2zJQVLyZXMNNJRdb5eSSCx2vHrY76O8?=
 =?us-ascii?Q?xNH9xnjh6aljao3db8idNJQJznF5XjtLP9UsmPWs0TGg+dMQux3hVkxZcB1B?=
 =?us-ascii?Q?7AKpxSuFRsmen/l25V35zSAbSGwq8affvdMa25iv2Yflho5Ndl8ZHHqAFGdd?=
 =?us-ascii?Q?xvKfr2X0dAbil7tE6Ef+FqkISyQATyaqQQ6EQhHF4ikA0bVLV4hSFK8U3j4e?=
 =?us-ascii?Q?FKeTQ5NHgQ3jqTbD5OdtCPgdlFemfwQHrhSpUlks18NjlsYypi7hgcR+TW/c?=
 =?us-ascii?Q?NCmecr43wr10iGj9fSLxv3RbUlkOAYEGowary7d9ORJdItBeQ8A9gfUvLEdM?=
 =?us-ascii?Q?lDkmM6FewM774hYV5dFz3eB3YADkB0sxqkTDGShKCXvmdmxiatBi3SJ5/3ZL?=
 =?us-ascii?Q?Px600ozpv28yDnygqy2JyrTDZqvrbewYeMwshoM7/aMlWkocW+bNdqOrdPh+?=
 =?us-ascii?Q?qIg7D05O3u0h5ZcHYUQbN7smWKmhywWw4+CEFrg6xlBBr+pl7n6uvFqe/Nhd?=
 =?us-ascii?Q?YKpDA/6ig9v9sTP2EMVHLCL845qb3c2sKZI40oFFr6ofe3gq2f18Ecev2rIC?=
 =?us-ascii?Q?IQiNUu6I+99liWLDrLLyQHhk55xbTwyfxjCDtKX/UiSx0v11G/yn6D3AnCI6?=
 =?us-ascii?Q?LeWkTWZqUt1d8QKgQ2IU9NXx7bpxBwxbKLy0isryHIkc90XSgRttUan9hPsS?=
 =?us-ascii?Q?OKDdw8KIWOdDfgksaGfclncuc8fv9S9MJySV1XtP2TBFuoYHeFJ9S6Wf1sB/?=
 =?us-ascii?Q?Ooz+FgYOKWDTnlQti/VtfNv6/EaF6bR+SclX4A5vsdWApVkENYxjsECCw0hj?=
 =?us-ascii?Q?RvHRJkUj2zafqeNJFZduwfr4y9wzPz6vaYGhvNxsqUX83o1flQIXgnPJMKx/?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2240a1f-bff6-4851-86a6-08dc81138eb4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 01:46:57.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BTqDi5I+lsxKSgHp9ywMVQde1XnS/cYjSMCMHr/3LQ1e5ySqtwsaKfUKACCL7ptwvNKoDpL+7JvHHCowtUhlJrHpUFJ39sckACRNZNiCHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6493
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> Let me see about adding a unit test to the cxl suite that exercises the
> translation path using data from the sample XOR translation tables that are
> currently being added to the CXL Driver Writer's Guide. That would allow the
> test to verify against a known set of DPA->HPA offsets for a given XOR region
> config. 

Yeah, that sounds good. No need to worry about integrating that into
cxl_test. It could just be a sample test program in cxl-cli that shows
the algorithm and then can be referenced as "see, the kernel does the
same thing as this test that passes with the sample data from the Driver
Writer's Guide.
