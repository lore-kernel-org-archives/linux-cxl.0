Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF4374188;
	Mon, 23 Feb 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876139; cv=fail; b=cq3FUlJuKqVO3f7ugEJKHDoFLjf7wfE7d1lTvVd9LSi9yOrOTAO7zE7kv7itQQmaEBF+UqbJSWrbmIt5jvgKB+jEqMyjWnRqKO3pmAiAc4z5+Aj/cb/XgelNvcNuG9aRxFXxYa/wLgqxubddtGasXNUuVKSuh8/NefUU45Om8uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876139; c=relaxed/simple;
	bh=8ZQluaP68vVzn3nnqj4d/1VROqVwm4CZX8Mzx7X/ehg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J7aBLUITBVApgp9evcmrfzFtxjjAf5i14guPloDN6R3bGlmZz4OTNnqCKLZZoe5jrtUrFoe8DCDwAA6+Rm5bXDb5i4kNHm1i9PCHJjB6QqhXmD2DHkvfefEwNZ7Er74vUROO4HaJrnE45lv3yIzFz+m0lrApQhih05nrqZHrHFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAj6a0iA; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAj6a0iA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771876136; x=1803412136;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8ZQluaP68vVzn3nnqj4d/1VROqVwm4CZX8Mzx7X/ehg=;
  b=VAj6a0iA/zl/f/ZPj3XdiAvLGreGNioEP6xH2NfnNku1jM7/LUXB5W8W
   Ygzq1AsDaAUFDFKe174Tz5hLYD9ZjV+BUOpCHDlWiezr5cmNDXp/UKk9c
   DJNL4T++MQ17BAA83TLHIuRIpGsWVH9MVLiWKIbSJ1qlcGuZrUoKd1HAC
   Jh8r7EF6QQkdp9wcHea9Sumo9JG0xYHvygopTWfuNEI/loI6xBJd7asu/
   8MIjVW5QYc060uBFU68lDXYOAjq9yNPaNXTYZOnulohJr88xRJpLs2NSP
   5IOC+QWciAZtEKmI5pVcutwafvweD4d49XqFs0o2+YBQQXShZUQs/WLB6
   Q==;
X-CSE-ConnectionGUID: IQv/DIBwQtyDHWBhREUjYw==
X-CSE-MsgGUID: bfAggJgcQ0yw7fxemmYWFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84333312"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84333312"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:48:56 -0800
X-CSE-ConnectionGUID: 3s7d3RFKS62xYVuMS4aWpQ==
X-CSE-MsgGUID: ZP5MpHSIRP2V33gNJjul3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="219778115"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:48:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:48:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 11:48:55 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:48:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORZ7sIxAW2n9H3o1Nx+EJu3PlfVUMRrfj2KIvo46gO9xG3wL5ritTGr/TQ2PGYTybKyhreaBvDdIL5PHY3vtPvRD3edxd8TJ8BPVQGEiQ/uvKnq2C/2i5qv+FLQOAH0Yq5cVZXDRYR0oiKZY7AXqa/kaYsd9ncl0og2V8UT/CkO49wSIviMrBD5VekXuTus0jmXtWSnhCkm+gDJmBGvBIpmrZxsaNAR+T3W+Z3xKULcu0RwLMJ/dS71clzRVYmJWyYs2UwL/pG40lohEk3JWt8u7d0oEVlmg8YA7+2v7/dwU02m0K+VrxEoX1QyvuwwJLTJljbIazVQT9vLA8bzXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PU6jT2t3/xmgeWZLrAcUl2cC7TEGZLggmfVQSCIpNw=;
 b=c4iOIwv1zJQSTdt2TUR2n+JlC/zuxbCwJUNg6AH/0DO5wRaAp/4KgeNYJeri7hpPDLIRlzw1PFceW/wPhqF1V4LOAXjmeZsfbY7CRA40LGohjl7kGRkXSQfqXVXI5JrAFcD9rXcplWOvI/+O8SjTiqn3s5N47FRJdYcFq+VdM5qWslqApXMIWKgiqwkg+8u1/g3Fi5ZxBd20jQs9IHAt51ZZNtwlL0GpH3iafs8RTJGtQALpNuoovDZtT6q+YbuOECkEpsZkLd+MyJ2Y81QXj+yv6QO387moN+/coCUFJkPUtIBXqnCf/FRSVic1a2w65n+igtwZt1ZVQHLufAgp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 19:48:53 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:48:53 +0000
Date: Mon, 23 Feb 2026 11:48:42 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Message-ID: <aZyvGnKfWI1Mku-c@aschofie-mobl2.lan>
References: <20260221043013.1420169-1-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260221043013.1420169-1-gourry@gourry.net>
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CO1PR11MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: a3489958-0c82-4f8f-7aa4-08de731492e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wuuKgiKT6QsxIklNUsYvwWLHFN8zXpQssDx/WjC0z2Z/ewBrYYwG4/5dUP/j?=
 =?us-ascii?Q?TIu8jLlgF3qWSxo4yiIqZFVNmAylL83im4s6P0ACtNf+mGAtNVaceZ4K0LtP?=
 =?us-ascii?Q?KIFaNK9J3pc7nX8eA7iYmCJaF+48eAjMK8/0HS97FbnQGssb1pjfIqVfzQoY?=
 =?us-ascii?Q?Cvd/wXh3HcOKZ17P+2W8J6WXf3okDBPpXMFFJu6oXJb+5YY0YvPsYJ9tUD5w?=
 =?us-ascii?Q?Plc3h7lTNvWAN5le0a+zyRmPRGOlwYzmO1NrM/AxD5OQPRAK9wH8SYRAQb3b?=
 =?us-ascii?Q?zxDjzHiEIhKxKLAhf5mmKAMa6V6d9W81UD1mq7hHjQG0l/XFq7a6Kwey5z6M?=
 =?us-ascii?Q?V5yjhbzuLXtePK9S4/oxeyua9bMM6X525R5Qn8HqAmoydwaJa00m4mO6yBFw?=
 =?us-ascii?Q?euygsB6ytHOxE5Bmx/TK9fnqqMH6yna7hkglJ7NrK8ZhG57j5844OMtTdnEG?=
 =?us-ascii?Q?PWvJvkmtUfND1uStPnBE7Jj0YFfUIwZ4oPbzm5gQJFZF8AJ4ZB2t/CeB7cSq?=
 =?us-ascii?Q?S0/j2Tt4b1zn164GRgzyyg66Sjzj29AvDCXcW6woIQIThOtyszpg/kl7EO8+?=
 =?us-ascii?Q?yHGp92hFkdXvcjb3v5vSDG20zbRMRSJ2w6wYuCMkFr24sTwC0PRw6vraqKef?=
 =?us-ascii?Q?soPt1zXg5WkHTm/lQWIzeiv4EstM4MTnXgOtpuXCXIWpFNGcDIlg669m0+6b?=
 =?us-ascii?Q?BKCtxIFLCNPHaW26NberNIrqjQiY0CWQWadOj/uZBXUQP84ataf3PInO7wwp?=
 =?us-ascii?Q?hZ+aYZiF1xSmOSKdd3dH//8oc88kQiM/KUcLu9UJZH525bQoUrVwnNNbVvcC?=
 =?us-ascii?Q?84eisbpVjthpqSxvUzJJQFQQZIk37UgJN5quD3LvaA6ZXoZyhpxzh0kPBxX4?=
 =?us-ascii?Q?GKCYxchzxl5PSgycDiyDe+t+SyNS/itrr3+qP2m2yqIxhxvY4FH3jiGjKBwd?=
 =?us-ascii?Q?ZA8W3QN9QjMpQI4IwzyrWcYrT0JIurgIFn3iPKdqOuYZqGCSqMHUnD7a09o0?=
 =?us-ascii?Q?bNZWftemE0nhvWyGz9Op7ZBB+Mr1dsRQE3sN5JZQpANAWHTOMeYdNAWojshG?=
 =?us-ascii?Q?z1Bw2zUJOzVE3dMzRNXh+MBbVYbfnafZ8QmZDYGuqJ88vhMYBy+LfLNLrmqI?=
 =?us-ascii?Q?s/Z3s1Cdi7oO5cdQiQd2q9dv4X8FQk12rhTRfpDsx3jKkd8vNVnNuibxrIRe?=
 =?us-ascii?Q?Z28zlN6+/cZqc9mGw/NcO/Ff5HXdMi48VLARjKoOj7HAcheAYRR9dOf8R5HU?=
 =?us-ascii?Q?UA4vDL8ife3Ns+8dNtn9M1Haorkt3VSDDaDomPJ2VnxLlJj7GIrbWRZyO+20?=
 =?us-ascii?Q?mb6iNRwKNLkIMBV02N04ZiTXQNY5z6gllLkU8vA6kwCOs6dHsKpNtr1FUydg?=
 =?us-ascii?Q?kgi0S62ieaqwIC/O8DlRyFiIHS+/JIS/FIcFc5MvITnGgsOqmF7F2PPyQS0A?=
 =?us-ascii?Q?00Rh5BZgZs2BISkiISbhl7HU3ehx+82xCj/nEfvMuhAqH7WL/vJX2+2qc2yz?=
 =?us-ascii?Q?bPYqhFVXATQhxg8is0lWHNVRF7OIzZc/wnEkPp3tmGgJ1fz8jrvOtcxvIWgR?=
 =?us-ascii?Q?2G/1s04dzyAvvkALbnI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKGD0KE3rm87wk4VfvuW4vpBAw1EVSnz9PLW/2dOqK8gZbu9K3CNf5wukrG1?=
 =?us-ascii?Q?oN1bA1b8abCKSmLaobszEXvcSKsJIEV1bd/IvICXWXrzvBPgKlOIAFy49vKq?=
 =?us-ascii?Q?zfvmsP/r3sEa+KriDpJx7xTk56mrm4o2gWW9P7b4KrPsjyjtKMlU/iwEBs8h?=
 =?us-ascii?Q?FsBhD0G8NJtNXWWTWYn/SJgJ1z3HAL6mdKC/ODRvJx1HdbBF+v+n/FY1SkRS?=
 =?us-ascii?Q?f/qqKMhIpZmpR9OxpE4Mnpjly121bpNdQxDOH/vXkndnJ1Esl6q6RCoZ+6X3?=
 =?us-ascii?Q?mHy32w1Y1y6L40NGdK1juyii8zWPH3bbWJyB8UgkNMQWXQNws0qWpELSZ7lz?=
 =?us-ascii?Q?NogwPwnYI/wjoq1IUe7HNL0I2lEPPHl2jeH2naiFRdGkIi5omqtz/8tyhHKZ?=
 =?us-ascii?Q?Vqkm/9sQUmtQXB2kesmH/kxBpRvZOWZuCDwE4pNnmfSHe8vidpGS2KFNi5Ae?=
 =?us-ascii?Q?xj7Nhs9a5YwgxazjlAhmblKumiDct+NfvIoR+Wur/OY6eQ5qubD2xBL6HAH5?=
 =?us-ascii?Q?xsoF0dsB69LkCjDPjUzH6vfI4b4SXkRtLmb8QixHzLZ28HtXUmN/HmPgB06f?=
 =?us-ascii?Q?TCv8sj8Q6a3S57t+5ZNibJi99vkS1D7hsNXMXfekwKP29jP0a4mKuKa+iNFM?=
 =?us-ascii?Q?tbo7zU8vUkAnw4kg/gP/552Nf2C6vFNHIobmVu/7ksoZSY+oEzOJuzR4pTCO?=
 =?us-ascii?Q?DGLo1koqXGLQKY2s8V20S0coBEPekWzv9vqqF7LQl/9VWdlVIByrmRQ+IEQ/?=
 =?us-ascii?Q?lC9bgcB5NHuTpM+7CL6Y6fCvHcpHrNsD0r5YL0Ewi6NOuV0Wc4ufY3v7CmfT?=
 =?us-ascii?Q?0vFelGSyILOSeo3h1pxuVqWzhLS3CZaBP2GmuR7FpRwFJfHqerey4jdlpOaL?=
 =?us-ascii?Q?lGNlb1CRjI7FGtvymchi2rPx/I6aZCDDf0FhbuQUtptOskhKGVS6MtENUpXi?=
 =?us-ascii?Q?hT/8JR3/9vvDAa+qM03IjWq+15poWwmFMhpynUtPyuqHBv0YjtY9vXNPZbIJ?=
 =?us-ascii?Q?0vAogYTj6AcfI+bR34qKRGQgT6IpFNKkY1qcyaRxNLTgtYdHNnpFMMcPEptr?=
 =?us-ascii?Q?DPpbE6GrZMHFBYHt+bN3u6UEgZOS+armNBg4+tQiXDmJUQ8xagltUXceQi/t?=
 =?us-ascii?Q?/taTJ5vqiKpp4YXwkM+HRGUvRu31aU5BmhywA0Maokrx3oFJ3S4Hi/meEPfo?=
 =?us-ascii?Q?21JkcHbw/VhmHa0YOK5rFdW5+J8pItmXTvYCcxh8hxVFGdt+qcEiA30VorBz?=
 =?us-ascii?Q?B4akAZejT6uOhpMCLOg0DobUsBowcAvjTzRsTHhmnNOkMsUcJGcy/w7CRojl?=
 =?us-ascii?Q?yl0AC7clW8wV/lxOxYjYNRjTXvh38YqBTh4tuzL+JIv3B764uHyC6XE4SUFB?=
 =?us-ascii?Q?ILv/AbMtas6u6CZXrk1KQWAjIWmSDIhP13BT3/OFndNZGclnMnfCXZATSRMl?=
 =?us-ascii?Q?8ynnWpUnpcImSFW63pxQ7yHSUjBlPkuQr+qVGAlbcuTPdz0RWWfPPttMo8fb?=
 =?us-ascii?Q?R22xUp3BUAc65unzT81XiZMlReIugiBnhGLx2QYXBQGIiFQZANThgJnsok4k?=
 =?us-ascii?Q?PVBR1mO1YjiBfkjP0h6U8amdUkTn5C+BQyW1QIQiiLGZ16Rk8SGSM1C5BR42?=
 =?us-ascii?Q?vJnZb4NUhlcjF7pOMrCrHIW9svBhsyv/MlHWFPw7nLlM8Qu2rO1/mvOK3j07?=
 =?us-ascii?Q?otNNxucDJJZKBu/KzcF+wrv7eljmz7ynr3aiIAtsGPim+KxDdqZc5ISjNbdN?=
 =?us-ascii?Q?fBpREfN7toPpWdZliIhzgQEfYPJhdmc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3489958-0c82-4f8f-7aa4-08de731492e4
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:48:53.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj715340dcRZY72FMmCa3VekwRkNwBpUztG61h0C0aA+wNkShY+YsCKOdzBSpXU/gNMRrrz+CJc+CtKxVprODBvg1YcUjLBTBILvdxAfvqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com

On Fri, Feb 20, 2026 at 11:30:12PM -0500, Gregory Price wrote:
> cxl_add_to_region() ignores the return value of attach_target().  When
> attach_target() fails (e.g. cxl_port_setup_targets() returns -ENXIO),
> the auto-discovered region remains registered with its HPA resource
> consumed but never reaches COMMIT state.  Subsequent region creation
> attempts fail with -ENOSPC because the HPA range is already reserved.
> 
> Track whether this call to cxl_add_to_region() created the region, and
> call drop_region() on attach_target() failure to unregister it and
> release the HPA resource.  Pre-existing regions are left alone since
> other endpoints may already be attached.

I see you dropping this, perhaps just for the moment, because
the drop_region() you wanted to use is not available yet.

This looks a lot like 
	https://lore.kernel.org/linux-cxl/2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com/
	cxl/region: Unregister auto-created region when assembly fails
	When auto-created region assembly fails the region remains registered
	but disabled. The region continues to reserve its memory resource,
	preventing DAX from registering the memory.
	Unregister the region on assembly failure to release the resource.

And the review comments on that one, or at least on that thread in
general, was to leave all the broken things in place.
I didn't agree with that, and hope to see this version move ahead
when you have the drop_region you need.

-- Alison






> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 385be9cb44cd..276046d49f88 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3923,6 +3923,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_region_context ctx;
>  	struct cxl_region_params *p;
>  	bool attach = false;
> +	bool newly_created = false;
>  	int rc;
>  
>  	ctx = (struct cxl_region_context) {
> @@ -3946,15 +3947,23 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	mutex_lock(&cxlrd->range_lock);
>  	struct cxl_region *cxlr __free(put_cxl_region) =
>  		cxl_find_region_by_range(cxlrd, &ctx.hpa_range);
> -	if (!cxlr)
> +	if (!cxlr) {
>  		cxlr = construct_region(cxlrd, &ctx);
> +		newly_created = !IS_ERR(cxlr);
> +	}
>  	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
>  	if (rc)
>  		return rc;
>  
> -	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> +	rc = attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
> +	if (rc) {
> +		/* If endpoint was just created, tear it down to release HPA */
> +		if (newly_created)
> +			drop_region(cxlrd, cxlr);
> +		return rc;
> +	}
>  
>  	scoped_guard(rwsem_read, &cxl_rwsem.region) {
>  		p = &cxlr->params;
> @@ -3972,7 +3981,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  				p->res);
>  	}
>  
> -	return rc;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
>  
> -- 
> 2.47.3
> 
