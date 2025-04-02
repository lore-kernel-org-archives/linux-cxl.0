Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F5F1F561C;
	Wed,  2 Apr 2025 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630101; cv=fail; b=MEaHaH+wMr0LzAolzOZPXDqLxpuSx6u6x1V3AA1g3mhks2M5l66x2s8U843pX7nwXX8YqayOc/oJFU2TYiWNH1RMKI8SSHVcQmkQUZ7qJpP75yGD+MT4gRFL6A3D7E5FR9SoGpJ4PZ1uiIVuVXC+HZIzLQmfBh9NqpCkEv8w/L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630101; c=relaxed/simple;
	bh=1oY3k4EQRDLFPMkqh+c8Gc4IPbc9fQLZP3WDT91/TC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YeQbS6zTyP8L7aOnLdYLd6ZH/b9kLJyp2nsKMNMTsnnkw4pBIyj1axeM0Mo3iucKh2lEjR7Xk7VlW/38i6fWb0SVe/TthamCzGlelEyydpxOSvi43VmVuDr59HsJHiqiUv9UDLlUqtwjwg53Khxhlks89WOMT5u8f9d8YfIPgR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BK2LX7vt; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BK2LX7vt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743630100; x=1775166100;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1oY3k4EQRDLFPMkqh+c8Gc4IPbc9fQLZP3WDT91/TC0=;
  b=BK2LX7vt69SjdqxEcbpcQQ+zaOQN/7pL+IBOW0Kj4wqXBAG/91vCrhKV
   uW9bKiiPzWlzw6TlA/VPOJDVOeLvATvBFoXPkZw/2WztTIRvjmL74dfCQ
   4UeOTTbvCo3S2lnxizJvspi6tWzoUbUdpQfMc2qSv7Wi67n50ghOjpr0w
   oLRdJ3Wug2VF/KmDGt4475tepMWCmOsXSs7vmXmui1ITuEpR0hICFnA8a
   mzW9keIeZ71R5eRUkGRl4a4P4YjR0bq2btupZT1jmAmvQ6b7QGYwzhPR0
   CWG4LBY8C6XdfH/HJe8IbuCDqsTXupA/u2jo00PycCw+nP82M+P6V//cl
   Q==;
X-CSE-ConnectionGUID: Bkd2ollYRke0+SLmL/aU0g==
X-CSE-MsgGUID: Nj26HNSbTmi7bt5FppzZXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44277462"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="44277462"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 14:41:39 -0700
X-CSE-ConnectionGUID: BxNTxb/1Q+GCkKfaffCqNQ==
X-CSE-MsgGUID: 6KiT58VnQnCMqYcTzkBtGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="150025577"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 14:41:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 14:41:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 14:41:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 14:41:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDp3PPB6lSi9y6qSYAEgyIg0sv0CIqciHOVnCGDPusMLbsjGmkn3x47sl8KiWFR7JJ/H1cZD+74QQcJkL1BMy4FIgv92y5MOWeU9wiFoZBfwtESdLK6MzAkUOkA3AOTxGy07v9MNr2B7RI+QN32V8BBF8sbdv8y2TArFPSmvO+yXN+LPXzC3Qh8JSn+o2HSgs3VbLH3jucE07vYjr58TckBAJu8RHN/iIfapQEn/d90lUSDo7zz8ufhDQZ0o8BNk6BZ9kyzIaEInDbTanA0pmnT7L+X61A9URhuSALNg867C0To70RGEvlFklbaB9ZXbYCrOggHIuj+kNdZpUxk6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg/WAjX5GQ6eVwtknV2obwzBGkf7691TmbGDnybXO38=;
 b=RtVwEWUHzJZRDx6/7kTJC4V6eTtE87MnLteSWQY9nKfPKI1KWNbgBknL975bn5XMfOThCoZxgbYgThB1SAPEFSydgC4Re0widWJgsZ+hOFV1tc5A5f/LzPmw4r0st5CLJnnfvMzbGdcM6Jbp6XUAlgGD6rnPfYg3xBAHDy5qO5WpDVgFwt1rbim1CnrCYanoiF+yy0CQ+XTNKkejg5lxa7cR/I47PUGDU2yreHVLvbho974A68sfFaymkf70KMelIt18Y/zJwSomnb+7Qp6ftEYgR8z7lKN4Yv75ZJYQ5he9w7lKi9iq46k/mzPNiFpQXakgt0jCRL4JpTVP1e0s0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 21:41:16 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::c4e2:f07:bdaa:21ec%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 21:41:16 +0000
Date: Wed, 2 Apr 2025 14:41:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Nhat Pham <nphamcs@gmail.com>, <akpm@linux-foundation.org>
CC: <hannes@cmpxchg.org>, <yosry.ahmed@linux.dev>, <chengming.zhou@linux.dev>,
	<sj@kernel.org>, <linux-mm@kvack.org>, <kernel-team@meta.com>,
	<linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<ying.huang@linux.alibaba.com>, <jonathan.cameron@huawei.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<minchan@kernel.org>, <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
Message-ID: <67edaef8da732_1a6d9294e4@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250402204416.3435994-1-nphamcs@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250402204416.3435994-1-nphamcs@gmail.com>
X-ClientProxiedBy: MW4PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:303:b9::12) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA0PR11MB4686:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ea8bab-6776-4c27-9e84-08dd722f18da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nfHOZcIkcsFI8CvtOscX5cs7rRaRdWU1JCG0unmy7P8vtjmHUM1a49xmOLxj?=
 =?us-ascii?Q?RGJqRCXsTOkJ0ccjxJeWg5KKygWjhsd1xIYpnNA/yjG4x/1Dsh80wkpEZSIn?=
 =?us-ascii?Q?9wuv1inaqL9wB4L4M5XPK7B4J4XpCT4rNUpvOrq6x31kG3YjZ7ERX5FAF9OC?=
 =?us-ascii?Q?3qrw9zXA2PMihGY/7Um5a3dpzp5DKCC7gP5JxReYd7LN+sOcsjvO6NqK0hwJ?=
 =?us-ascii?Q?P8iUZxAYuGKg8iJnNT5VmzMqprx0///pwDdKsGD/0cl1FOxmRxZUzv/9tsOq?=
 =?us-ascii?Q?RZYy/2ROh2LbHlXtTE6uNJnK7Z0givS9Gf5hedluxx5IEFxzHHKUYCov3B0/?=
 =?us-ascii?Q?bcgu//Lo5eZzunE6iIyWeymna44WuQ2OrNP5UZ4AvUe9Id+CeEoO2xzy6w2w?=
 =?us-ascii?Q?5UbWNj8jlAOJteNEQvtBXCzXqgnFzKQs4qUQ/jpPtulavSbzHlq3f1oncfZy?=
 =?us-ascii?Q?I/SAalhcg3QgWLEfc8mXBXu3qlC8PklVy1AEaZRth9nJNpacrEE5qf4/k1wy?=
 =?us-ascii?Q?aTiFcy5DCzGRUK1Qe5bgtM6qWIgTLLKQ80vi9eJLB93eYw5J3Im7h9lkBHYb?=
 =?us-ascii?Q?UBEmM8PHKllLp/7fMvaNGEb0X8dU4RTzKoMtgiddhfdIRVDmUkXy3TXBvkCb?=
 =?us-ascii?Q?GrsZm79Cyac9QL4rmuagnFnux+ycneMKG4O7qIdBJZQPyJW2L0u/N0yNNO2w?=
 =?us-ascii?Q?/aBiPuw8LI6ExqKIJfbnpURWTaBffr8oKL3FP5ZqVHHX5PnaZ/imuXCz2vBQ?=
 =?us-ascii?Q?MhGVhgHmf362LIijqJgeVUVV4SIzOsmULW2Asluv7wv98b8YRyWy7lOxlhSK?=
 =?us-ascii?Q?D9YkFIW6CPBcV9O7pn/AOCwfUo1lqop+wvwpnNnp7KjStbYevs0KGMywItOu?=
 =?us-ascii?Q?f9w2nGoa2UCCK83fyqhYtoy935Wp9wzlS8xDyqN2bAI456ktZQj9S5D154Uy?=
 =?us-ascii?Q?fMe3FVfXvfoac7/owJ9LpeuIPBIT2EUlCSq4JIKUl/nfpGDXzd90OAnLZUsm?=
 =?us-ascii?Q?muf1ivKPBnwbze117ALMgL2wBjKpj7w9Wg2j6NZ+P3vzex2bQKMNcVHceg3V?=
 =?us-ascii?Q?BKohivllFN/yJ7iif339ZfKdxyjN/0wxaSSVvOjqWLZ/X1XSo8WatyS3upT+?=
 =?us-ascii?Q?FXe8h/CAnzz6ivcjyuZ5ennkABnItzbiY+W0VkF12Q66zu8f1xeHo5NEiGx/?=
 =?us-ascii?Q?sAo2THEPqOSccRPJ8F95a1/JA1u7wNXwa67bIO7DPCNjKAaJIQSKLw3ZaY1o?=
 =?us-ascii?Q?9AbAujDjpiaDSMTG1oIABCfOvKvqEso9bssb+iprsIC+j+lBLxxFfV8WX14G?=
 =?us-ascii?Q?gOj8LqbicSTWIz19T1UHTgbU/TIBDb1zQONdZbzZwknmVQcAMntAenub2omN?=
 =?us-ascii?Q?8t/Qj4JDtjaS4phS5e0iiQqKnBTCxwnkfK0z10TNBvVlmFqgVVFYztWM7FRW?=
 =?us-ascii?Q?XzRtezt7WRQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ndPvnu7KUOxnCK2dmjtFr60GJ4W+FuCMEU8ISwYJsJAnlUMmBfFEfoCcYyY?=
 =?us-ascii?Q?aIx9pEhVrkILxMkWqS/Q3YXMOzq6GTuRVUljFPeolgDrjgUUGdtrEPtlAsg3?=
 =?us-ascii?Q?ECdjUlmZ/GNa0AAqT7sMzU8b7a9zoyfatloNJ/4RhHKrGVEd82oqC7X/a4hj?=
 =?us-ascii?Q?M4/PwV95WalOwZfIiwln+Q7+LITpsWTD1pGFoqP+Znu56RpkT0DXkjxftnYi?=
 =?us-ascii?Q?tq4coBx/Ow6/qFELYkH0TER3w+TD1o3UhIrVnXpvgFW3rqtkeAzV0Hkue7//?=
 =?us-ascii?Q?jWOFm3blDn+SpSGqvIkyiyoKyPaAwenHPsIK9BkLjrB+BAjzNXLUmoPo6EjY?=
 =?us-ascii?Q?tTTm0QglQlL9plTj31kGfo6+lS74cbZ1mqofvL/R8R3qqWoQ3koaNSFP8XIp?=
 =?us-ascii?Q?oDgkD6qiLDdjTlNNQ0ktl9kPxf1+matZlTdNr5+SiqBoTuqDOAAUltIatelE?=
 =?us-ascii?Q?T0H1JwfB5Vb2DV4zlJxrxq3Z3AHZjZJ+ct0jBHHZUg+iQsCYCYzHFevsMVa0?=
 =?us-ascii?Q?FEC+Dv1usELY6GErb1oya0yUYKKroPPFnkYaE0tT1Vps0Qi5l7wVP32jfNiI?=
 =?us-ascii?Q?dLbSGVlpxgHt/C6ULtkVTiQQiMxmjFyqJ0k6QKYpuVdly6sRvmwWnINOELs+?=
 =?us-ascii?Q?skvB/K6JBWQW+Xs7Zesxvm2IWlTk2vIdo4+5xA0rdqAn3f352FP1PkT5EH1F?=
 =?us-ascii?Q?adwl4hcYyB+yA/Gezs6C8xR4HP9QVIdosuDapkr8t5ITjICylGQGU1hjJHAl?=
 =?us-ascii?Q?gPUmXAQYFh4B8D4WqxcHqGeMNtP6fvAaHD5fKycwbKqx7XRI7Y/qtJXSEiuu?=
 =?us-ascii?Q?Bzx8u1lkXA6Jd7QXXSxIq3MeRJ5pX4hvlsWXzkdSTjyuKkBhE8K+O72a4qqP?=
 =?us-ascii?Q?QVWaZ+pmhjFQ5NhgiogMb6DJJOdx19FofEnV4PbKdiZT2Tgj0xnlzlHc2kjI?=
 =?us-ascii?Q?wOv0ByiSLCKVCIvZbD02QKQZV8/UvXMKjEVOd7DxfSxdF+17dtwIwvA+Lr3I?=
 =?us-ascii?Q?9yScVa8PYYoR6JYGP+tmsbUnh6BDkUWAwCX5a0jWbBDmIj3dzdQ7jM0s+xv7?=
 =?us-ascii?Q?o9mLS6FF8pOB5vSDuwxV+nX5gCNPeWHkhqWpQAZe4gqbQh+jGNbFwYv1QvLm?=
 =?us-ascii?Q?q3MuTwiSr+vaf7bdnYfILE/dZwgyWThxctspzt7a/A8gsziCu6IFp+uvcq8i?=
 =?us-ascii?Q?xkzvFuqxKBwEQFo6xpHoCMcXi/hxB2FI0IwCvln7CeYIAJwQZz/+LL/W+1ET?=
 =?us-ascii?Q?VluoH3wzyi4TPkfyVAq2se/K5qxOs/afPKwREriH5eO5Ll/0nyrU+vYOwcqz?=
 =?us-ascii?Q?+2KvvRGqAhueYR2icOa7l6P6ovjtwg3qtZr6wFc3ykn8Q220xfgZMmz+nZKK?=
 =?us-ascii?Q?UytoOA5EPav6eRx9LqMv0eOPdGHiNraJfdrgaeAiI/dNyMZ9B+vlgD9SGoQs?=
 =?us-ascii?Q?ClDYiQWvuYqze/HvmGygOzMKB9/3EBJ8akaGjT3H6l5muG7fbth3FbRVB9oP?=
 =?us-ascii?Q?ZejwAY4Pj42vBCeqgbdkKvSkNPjUzO2RLAFzXcc4F9DjgraLEJ2UGWXZpGUy?=
 =?us-ascii?Q?J2nmkNu3JydglfuRkMHAq7MYJwo+v+7I8TFMDj1TGKYLW/Dm8w1wcg5mh6AZ?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ea8bab-6776-4c27-9e84-08dd722f18da
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 21:41:16.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3apc+MHd3Xp4dr9Xsw9lyRMEhFeOf+C4JzB5uk0o+awWQfVelaI3eZXcDtDlLGHu0ApkakIGXoRr36rHtBkSiaRKjytdXF29JcIWoPpLObk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com

Nhat Pham wrote:
> Currently, zsmalloc, zswap's and zram's backend memory allocator, does
> not enforce any policy for the allocation of memory for the compressed
> data, instead just adopting the memory policy of the task entering
> reclaim, or the default policy (prefer local node) if no such policy is
> specified. This can lead to several pathological behaviors in
> multi-node NUMA systems:
> 
> 1. Systems with CXL-based memory tiering can encounter the following
>    inversion with zswap/zram: the coldest pages demoted to the CXL tier
>    can return to the high tier when they are reclaimed to compressed
>    swap, creating memory pressure on the high tier.
> 
> 2. Consider a direct reclaimer scanning nodes in order of allocation
>    preference. If it ventures into remote nodes, the memory it
>    compresses there should stay there. Trying to shift those contents
>    over to the reclaiming thread's preferred node further *increases*
>    its local pressure, and provoking more spills. The remote node is
>    also the most likely to refault this data again. This undesirable
>    behavior was pointed out by Johannes Weiner in [1].
> 
> 3. For zswap writeback, the zswap entries are organized in
>    node-specific LRUs, based on the node placement of the original
>    pages, allowing for targeted zswap writeback for specific nodes.
> 
>    However, the compressed data of a zswap entry can be placed on a
>    different node from the LRU it is placed on. This means that reclaim
>    targeted at one node might not free up memory used for zswap entries
>    in that node, but instead reclaiming memory in a different node.
> 
> All of these issues will be resolved if the compressed data go to the
> same node as the original page. This patch encourages this behavior by
> having zswap and zram pass the node of the original page to zsmalloc,
> and have zsmalloc prefer the specified node if we need to allocate new
> (zs)pages for the compressed data.
> 
> Note that we are not strictly binding the allocation to the preferred
> node. We still allow the allocation to fall back to other nodes when
> the preferred node is full, or if we have zspages with slots available
> on a different node. This is OK, and still a strict improvement over
> the status quo:
> 
> 1. On a system with demotion enabled, we will generally prefer
>    demotions over compressed swapping, and only swap when pages have
>    already gone to the lowest tier. This patch should achieve the
>    desired effect for the most part.
> 
> 2. If the preferred node is out of memory, letting the compressed data
>    going to other nodes can be better than the alternative (OOMs,
>    keeping cold memory unreclaimed, disk swapping, etc.).
> 
> 3. If the allocation go to a separate node because we have a zspage
>    with slots available, at least we're not creating extra immediate
>    memory pressure (since the space is already allocated).
> 
> 3. While there can be mixings, we generally reclaim pages in
>    same-node batches, which encourage zspage grouping that is more
>    likely to go to the right node.
> 
> 4. A strict binding would require partitioning zsmalloc by node, which
>    is more complicated, and more prone to regression, since it reduces
>    the storage density of zsmalloc. We need to evaluate the tradeoff
>    and benchmark carefully before adopting such an involved solution.
> 
> [1]: https://lore.kernel.org/linux-mm/20250331165306.GC2110528@cmpxchg.org/
> 
> Suggested-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
[..]
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 961b270f023c..8ba6cdf222ac 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -243,9 +243,9 @@ static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
>  	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
>  }
>  
> -static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
> +static inline struct zpdesc *alloc_zpdesc(gfp_t gfp, const int nid)
>  {
> -	struct page *page = alloc_page(gfp);
> +	struct page *page = alloc_pages_node(nid, gfp, 0);

Why do the work to pass in @nid only to hardcode 0 to
alloc_pages_node()?
