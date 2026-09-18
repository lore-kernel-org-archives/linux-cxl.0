Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2A5187C1
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749561; cv=fail; b=uHP3mRNfDSSbkxkw76qQJRcFoKP9R5Px9C+i6cf77FyPtm1oaJ7tuTHmIUutZEcWKwhAEo/BqLMusZd4vTW0y47IoBoWhAfM6j7mVnSpu754Urom54Fb0LVmNNOIeykiNoX3TYPsaQ3KrHixUVGuXghQbsgTld0AfckhlGllBMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749561; c=relaxed/simple;
	bh=vrGi9oqDj/BzQhEPLZwsQcSsUIWU7UZYJCCwBbPXP/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Th9jThI9FGx746F78cNCYLBztUcpd/h4jWDZJweGrIyurIZRCpMO5IDx9hZEEqa4k63AX2kKNTd4yCtW0OsYhQpnz8FodCgvCT1PyEWn+C8Io+Ycu24/Fx7kZ6EUoBcKfQsxypBB08tRnL8Xi35HCprst2o7O0ebPAgsuJ5yB1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMCz/iTz; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMCz/iTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789749558; x=1821285558;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vrGi9oqDj/BzQhEPLZwsQcSsUIWU7UZYJCCwBbPXP/A=;
  b=XMCz/iTzQRe2X4UyHCdVZYQREhI8yvYQ2wikex5lAG3jNvJAW/4GgO4Q
   PUkyTijgZjRQXc1Wn8mxiA9/KnsDowALTHU97OIgpAt+nEqB7NG8NlKo3
   k/lWU3PVVzZuW0zAxzphj1mRq6M4PHySemhL/CwT2d8dr+w7HXMvo9Ld3
   m8xl5R9ChpW3ubYMjxrUFC999L6wBynCorvMv7/7yVdLj2YcgK3d9AHDY
   ipjid9CKlEeG3Rx6GSpijNZicdXLTJqj9b9QxOjUvC5wkAd5W8xYy+QwC
   /JZh7Z9JfFUo/XW2FHUwrk1L9D4sV/5qJWOPKsT6lS9VW/dfjCChhBCfW
   w==;
X-CSE-ConnectionGUID: YtLfP5WDTk6FIWmRz/wEdQ==
X-CSE-MsgGUID: lpD24UxyQKuqO+urCtigyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="101619497"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101619497"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:39:17 -0700
X-CSE-ConnectionGUID: jnIEHz84SRKAAjD1dKRqjQ==
X-CSE-MsgGUID: jLsCy4RdTHWrEl699V+DXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="299584391"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 09:39:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 09:39:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 09:39:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 09:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSbZW6hdeB5hfn885b1RR4MviGv2W4flkuowvmqnnl3r8zQeFOFMlXBrxSpku9fIa/1oNKArIti0R6tKFSLMflOOCmXzGwP1UVvxYLAMpHJ1Gqsj4H9ZjoUjv7mCzdrF0goVQbscDylZH7z/VnpqPmssjOlmnSUMCg13n2DEQ/V6zWPRf0lK6RJiZVj9TAcbNYyE5QElO1kfE8D/l4q5QPwUUYqpHe7YQavle8N1dOC6zav3MzhqCTD2zvv5M4D0XhPp62l3BAJtEnCcCF+XwLF/YCHBl9q98Ui6GpyBhYpuFiHctRLfVfXyz7b20mmumapb40ACKXZM8/6pPDgq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEEUllb9RWOR17FP5gWanXAwfpJpL/mUyjOR9HWe8Rk=;
 b=opDFBPfnJ9zd208EYPHbzp8nEuj7ydqke3KFOIq1bm7ziiq1sKDuewRxZjTTTws6XfWsSP5o9vOch7acE1mggQompzyiwdZCSJY0AorLCNa00HCV+u1BeJSwKbc1O+r4m+IFNTA1mRdhdpAoR4F0pvWX8p5q27Qgp3WtWcyamtBrpUSS4WHy5p09dAQXeaAV629Auto3ntEMOsfvZecPdcMWBtwGYuMZM3kzAQEYoHT60Um2Yb2G1+b1/SWcikId0UvNHLtWXDDkgMZ1Eu3dZcAQkYt2d01vB62EX2dsDgoR9GCyLTJ9x22xh+n3qqbSeuTnjmDFGxC/l3vUl43ZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7746.namprd11.prod.outlook.com (2603:10b6:930:86::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 16:39:11 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 16:39:11 +0000
Date: Fri, 18 Sep 2026 09:39:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jic23@kernel.org>, <icheng@nvidia.com>,
	<ming.li@zohomail.com>, <benjamin.cheatham@amd.com>, <alucerop@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v8 0/10] cxl: Support Back-Invalidate
Message-ID: <aq1pK9oYEjoXpicU@aschofie-mobl2.lan>
References: <20260909170302.1550680-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260909170302.1550680-1-dave@stgolabs.net>
X-ClientProxiedBy: BY3PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:a03:255::10) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 951a0415-501b-40c2-eac9-08df15a35ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|3023799007|6133799003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JezDmdqieqYwM4mLTdFmO3Je0ZO4LK3pxmxOCD3aHmw2QzRGaK3heLJauYWLM0f1qfd8atOcb50D423chZmrA9OrHMSZwFuXBsWerA0SjNqxjGiuVMJVhPSeXt7uV2JSnNA3UfcIb+dzw/VrB1873igops3BARuv4EkoX7fN2zz2ie7f8B2paFlHg8NhdHBXycSUPv/zydb0KSCUUGJ4JqTsazGPZ9ApLSOL6+Y9/wufsOaNr0pNOVorqEZugV3G9vJx2R0eMZ/vYnelEMK8BPSLCvOp6T3/5xk7tfKK8HLHVTnxdci59W8PUeFGTCnU9GM1G2qgPkhRSwRsSap+DNyK0FJDrG2TcHnuX3tt7rSjoZj6st4r0sXbKZ7dAEUbTJaRhjcr3B2MGZkqSCSSBcA+nQE401k6uWxi4FfmWZhI0vrP9Io09lyjhJ4cMUZ1Hiqk984/ioRlea2oLZZEwMOBy3LqMgu3XtPKR2hKIDuvDzP3yyMC3koHxeOo1KomjYFa8EXJmuvVUsrrCfL1FKLJfhrRQ7/sENbdYrE28pXlfYKD+4qxJlnBI9OXpRVBD5C+JOHB5x7OOh8DU6xsDl7mTQV7XcY+OacQ6ejtm+xeqMD1txYVJao08R97l7Dn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(3023799007)(6133799003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vCA4C+opPKiDTkLAHLxsQL3MlIWhiG+gnd30ySSlmEB+grOBgtibJoiew9Kw?=
 =?us-ascii?Q?mBbTbK2V0+NcFN6vHXsj7lBM5K60DIuBmKRbOxx+aXYyNGnNQOJFhRkfBuGS?=
 =?us-ascii?Q?eqOsjp8K85dlimBj69rhAMElrYA2g8bgifAZ4BAySSjvVZ5HMb1V9Uhqy+7H?=
 =?us-ascii?Q?rMpIEk3Ae52rInTnK2WWhJiIIszZQkYoLAvl4jFmupJSJmAGWhTThdRdzdcV?=
 =?us-ascii?Q?3rc15dT8k50zKwCcbVUvGXty3T5EkOYpJerOLRZUAg7/OFFlGN/r2WK3dE9U?=
 =?us-ascii?Q?SfSEHYLdSHtOfWnzJnmTnNyXPAah1ACfzANN2l9Mu53wdsyJ/6u2Qv5cb50T?=
 =?us-ascii?Q?FnVA+EuVEhK9vTYeGXV6uJi/wMJC/5cDO2DOI/ysRkfG6Ro1vjq2iqvsPAFc?=
 =?us-ascii?Q?h/ZxoqgZ4L+AAHAid9Y2fz30zCfTTsB65noE+o4z9C2EcMV4LG0PPkBJQLAc?=
 =?us-ascii?Q?rwkigruoyseWGN/Gvwiu6IV7CfrroOJoKrtqTx7vzDQQffg7drPSyjQ4QAWM?=
 =?us-ascii?Q?0ntwzS73gRQUl/2AgnTfikTxtY4SjiiR3aNWzUTZUdubw2XtAYrYSl/8u4DC?=
 =?us-ascii?Q?knYxpQeqwuS3/05MaRIZthJFZ6taxqXtQG+m2pkG1Spzavd7TpI+gclwEAok?=
 =?us-ascii?Q?ARFrRM60EchdsLpMYyvbz8XsV+rsULWQmFgIKKjIovXtfbNyzK58x1xOr2r/?=
 =?us-ascii?Q?aov/UfsAWkbiiYTsXQyK4nWWHdekg8lZ2+kVQNglPFPJZbahTpTcBt8VLF9p?=
 =?us-ascii?Q?VpRSSvB9iw1XOcdIyBNK7gIsPSvXkNHASAxSibIQqkajEZRmlahwPlWKmmJv?=
 =?us-ascii?Q?i0EXceiW1+2+r6uz7PzLRbtX+Uebq8bl8IlO9lQwlB4Z0iDvt/NkYRCC8VSF?=
 =?us-ascii?Q?yWKQ8S3xr9Qst5zculE99WHjPdMJJ6Eyjwg2HqCXGtG7TmJJPjRu+GkML/Fx?=
 =?us-ascii?Q?DZ5UgEd3PW4uCrCB83e7nnTeJhpPjItDiMqqZgUAh6HHfNtvFOs8ubIcm3OM?=
 =?us-ascii?Q?l0sxlqxpUVq2QYuX1aU47Qn0A1HHZgkPOFTE/P1uI55BFSM9e8xXG1tyIVco?=
 =?us-ascii?Q?SS4V2wsG2Un6u5WRal0ezwtlqpL4bOcwifPNGgbFZAc/4ni39fpVwt3SEDvt?=
 =?us-ascii?Q?KZeQlYOEU7Us2fl6JzKs+ozrqKb+8501USpTbByHxLUZZfDAz+8l4TVrmEyB?=
 =?us-ascii?Q?NQxg2t/8WWe+ez4Uj8kRc9fEu+1QolKLsSWvbjebCRy1RE1617pRW3jPv0rN?=
 =?us-ascii?Q?jnUAMmD5u2ZBA2WrupDqFLG+ixiKFsR7M5l3RnsrVTFxdPd64ek4kj+GiRA4?=
 =?us-ascii?Q?A8YFYPtioauGqllthr3vpqHOTTdeaQ56p2MIYm0fvpa0MoMI5frTbll5hUlJ?=
 =?us-ascii?Q?3WWz2Kwc2/H0wkRwyhR0dIPZswPd9sLjgjA5PaKVY2/UnHs2sUQqwgF1dNyF?=
 =?us-ascii?Q?ZXI2QpgqMv+W+rpgHyAx0OUUpbit60ZAJPL8GifBQmSMHHf0G9QiIJOXFfMm?=
 =?us-ascii?Q?GxpVntAaq5XWBz8d6ySDaSZZIye7beCmd3gK/Cf+5qx9KnVw/yWKgh2RudmZ?=
 =?us-ascii?Q?9+v4QK/zL/WxY8gA7FBb3/aMe5QgewHpCVWlXawIrzO1KAQp0AnKxwiJRT7u?=
 =?us-ascii?Q?2VlGCHc+gR/tsX2ruoFqGkX1tG/1SAj6/dVX4FwSJJFj4E8thFSa3pjTYIX2?=
 =?us-ascii?Q?UZxUnFndiuTT+zxBnMKWquxcZUlSCulddMIxEPPs4U0m81yV5acn/w7FBKuU?=
 =?us-ascii?Q?5aiUNIgBXsFJvwQE+M7DKm86ZLsSeY8=3D?=
X-Exchange-RoutingPolicyChecked: iILGq5wwB0lGHxefX3fNNOxYdHLq9hvOMf4oWsDs0OWjZMvIsux81fNYCe5ujSmCwIVR4gqRDIbgbMEwJPGDkaEKSYnOxXa17kYDeJA5duNt4bKPOS8yn91Wd8E1HJ0oWbaOX0k4mqsDrghkNer0ElnFV0NnVbvRLfrdvZA1+hXwGbKQK01Mqf4XaeewWVF3jOvijgxiyDBWlduOXv2ZDobZhj0OBpP0ZHZOL9hKg0JUhgc/x5jHpnS9o3G9pyB9oH+j1GShwBfAq1fJaMsGpSCC+uWantz9bvhgsrqETrzPoN133az5A0+YaBt4eOURf98Yj5l+6d6qqJcKvXgbtg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 951a0415-501b-40c2-eac9-08df15a35ded
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:39:11.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpgYg0kdyz0V7PNuxsHvmH2iWuWLNICyINOmTABaXNDLyJd856ddebyU1mx3fXZmanmhoIMi3HGIfvt1cthd2Jyyus1TtgQ9dQ6S3FrR0v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7746
X-OriginatorOrg: intel.com

On Wed, Sep 09, 2026 at 10:02:52AM -0700, Davidlohr Bueso wrote:
> Hello,
> 
> Changes from v7 (https://lore.kernel.org/all/20260728144136.709882-1-dave@stgolabs.net/):

snip

>   - New patch 9: cxl_test mock BI topology, so the ndctl suite covers
>     HDM-DB assembly and cxl_acpi rebind replay.

Hi Davidlohr,
This caught my attention, more below -


> 
> Testing
> -------
> 
> Testing has been done on top of upstream qemu with the CFMW options series:
> 
>   https://lore.kernel.org/all/20260720233242.901544-1-dave@stgolabs.net/
> 
> The qemu-based test suite covers 34 topologies, including cascaded
> switches, interleaves across switches, firmware-adopted paths, device
> resets and AER recovery:
> 
>   https://github.com/davidlohr/cxl-bi-tests
> 
> This passes regression testing (nothing breaks) ndctl suite via cxl_test,
> now with the mock HDM-DB window of patch 9:

I'm seeing test output below and wondering if that is done the cxltest
module config or qemu config.

Is there an cxl unit test update or addition to specifically validate BI?

-- Alison

> 
>   == phase A: cxl_test load/unload x3
>   cycle 1: memdevs=11 ports=8 rootdec=7 splats=0
>   cycle 2: memdevs=11 ports=8 rootdec=7 splats=0
>   cycle 3: memdevs=11 ports=8 rootdec=7 splats=0
>   == phase B: ndctl cxl suite
>   cxl-topology.sh            PASS      kasan=0 warn=0
>   cxl-region-sysfs.sh        PASS      kasan=0 warn=0
>   cxl-labels.sh              PASS      kasan=0 warn=0
>   cxl-create-region.sh       PASS      kasan=0 warn=0
>   cxl-xor-region.sh          PASS      kasan=0 warn=0
>   cxl-events.sh              PASS      kasan=0 warn=0
>   cxl-sanitize.sh            PASS      kasan=0 warn=0
>   cxl-destroy-region.sh      PASS      kasan=0 warn=0
>   cxl-qos-class.sh           PASS      kasan=0 warn=0
>   cxl-translate.sh           PASS      kasan=0 warn=0
>   cxl-elc.sh                 PASS      kasan=0 warn=0
>   cxl-dax-hmem.sh            PASS      kasan=0 warn=0
>   cxl-region-replay.sh       PASS      kasan=0 warn=0
>   cxl-update-firmware.sh     PASS      kasan=0 warn=0
>   cxl-security.sh            PASS      kasan=0 warn=0
>   cxl-features.sh            PASS      kasan=0 warn=0
>   cxl-poison.sh              PASS      kasan=0 warn=0
>   BI PHASE DONE pass=11 fail=0
>   SUITE DONE pass=17 fail=0 skip=0
> 
> 1. HDM Decoder with BI through ad-hoc region creation.
> ------------------------------------------------------
> # cxl list -D
> [
>   {
>     "decoder":"decoder0.0",
>     "resource":6710886400,
>     "size":4294967296,
>     "interleave_ways":1,
>     "accelmem_capable":true,
>     "nr_targets":1
>   }
> ]
> 
> # ROOT=/sys/bus/cxl/devices/decoder0.0
> # EP=/sys/bus/cxl/devices/decoder2.0
> # echo region0 > $ROOT/create_ram_region
> [   10.754350] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
> # REG=/sys/bus/cxl/devices/region0
> # echo ram > $EP/mode
> # echo 0x40000000 > $EP/dpa_size
> # echo 1 > $REG/interleave_ways
> # echo 4096 > $REG/interleave_granularity
> # echo 0x40000000 > $REG/size
> # cat $EP/back_invalidate
> 0
> # echo decoder2.0 > $REG/target0
> [   11.576260] cxl_core:cxl_port_attach_region:1319: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [   11.576369] cxl_core:cxl_port_attach_region:1319: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> [   11.576381] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
> [   11.576385] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder2.0 @ 0
> [   11.576404] cxl_core:cxl_calc_interleave_pos:2077: cxl_mem mem0: decoder:decoder2.0 parent:0000:0d:00.0 port:endpoint2 range:0x190000000-0x1cfffffff pos:0
> [   11.576410] cxl_core:cxl_region_attach:2319: cxl decoder2.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
> # cat $EP/back_invalidate
> 1
> # echo 1 > $REG/commit
> # cat $EP/back_invalidate
> 1
> # cxl list -D
> [
>   {
>     "root decoders":[
>       {
>         "decoder":"decoder0.0",
>         "resource":6710886400,
>         "size":4294967296,
>         "interleave_ways":1,
>         "accelmem_capable":true,
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "port decoders":[
>       {
>         "decoder":"decoder1.0",
>         "resource":6710886400,
>         "size":1073741824,
>         "interleave_ways":1,
>         "region":"region0",
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "endpoint decoders":[
>       {
>         "decoder":"decoder2.0",
>         "resource":6710886400,
>         "size":1073741824,
>         "interleave_ways":1,
>         "region":"region0",
>         "dpa_resource":0,
>         "dpa_size":1073741824,
>         "mode":"ram"
>       }
>     ]
>   }
> ]
> 
> 2. Type3 device does not support BI, but CFMW has BI restriction
> ----------------------------------------------------------------
> # echo decoder3.0 > $REG/target0
> [    8.780244] cxl region0: mem0:decoder3.0 BI not enabled on device
> [    8.780271] cxl_port endpoint3: failed to attach decoder3.0 to region0: -6
> 
> 3. Type3 device supports BI but CFMW does not, create HDM-H region
> ------------------------------------------------------------------
> # cxl list -D
> [
>   {
>     "decoder":"decoder0.0",
>     "resource":6710886400,
>     "size":4294967296,
>     "interleave_ways":1,
>     "max_available_extent":4294967296,
>     "pmem_capable":true,
>     "volatile_capable":true,
>     "accelmem_capable":true,
>     "nr_targets":1
>   }
> ]
> # echo region0 > $ROOT/create_ram_region
> [    7.957185] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
> # cat $EP/back_invalidate
> 0
> # echo decoder3.0 > $REG/target0
> [    8.781886] cxl_core:cxl_port_attach_region:1319: cxl region0: mem0:endpoint3 decoder3.0 add: mem0:decoder3.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [    8.781969] cxl_core:cxl_port_attach_region:1319: cxl region0: 0000:0d:00.0:port2 decoder2.0 add: mem0:decoder3.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> [    8.782006] cxl_core:cxl_port_attach_region:1319: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder3.0 @ 0 next: 0000:0d:00.0 nr_eps: 1 nr_targets: 1
> [    8.782014] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port1 iw: 1 ig: 4096
> [    8.782017] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder3.0 @ 0
> [    8.782024] cxl_core:cxl_port_setup_targets:1638: cxl region0: 0000:0d:00.0:port2 iw: 1 ig: 4096
> [    8.782027] cxl_core:cxl_port_setup_targets:1664: cxl region0: 0000:0d:00.0:port2 target[0] = 0000:0e:00.0 for mem0:decoder3.0 @ 0
> [    8.782041] cxl_core:cxl_calc_interleave_pos:2077: cxl_mem mem0: decoder:decoder3.0 parent:0000:0f:00.0 port:endpoint3 range:0x190000000-0x1cfffffff pos:0
> [    8.782046] cxl_core:cxl_region_attach:2319: cxl decoder3.0: Test cxl_calc_interleave_pos(): success test_pos:0 target->pos:0
> # echo 1 > $REG/commit
> # cat $EP/back_invalidate
> 0
> 
> 4. Unbind + Bind
> ----------------
> # echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
> [   13.990226] cxl_core:cxl_port_commit_reap:888: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
> [   13.991350] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
> [   13.992203] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
> 
> # echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
> [   14.805903] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
> [   14.805925] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
> [   14.813031] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
> [   14.834525] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
> [   14.835712] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
> [   14.842849] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
> [   14.843183] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0
> 
> The same applies to the endpoint port, with the memdev rebind recovering the endpoint:
> 
> # echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
> [   16.495810] cxl_core:cxl_port_commit_reap:888: cxl_port endpoint2: reap: decoder2.0 commit_end: -1
> [   16.496640] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
> [   16.498846] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
> 
> # echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
> [   17.310871] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
> [   17.310901] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
> [   17.320476] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
> [   17.342413] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 4096
> [   17.344062] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
> [   17.352670] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
> [   17.354769] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0
> 
> From a cold boot, without a region ever created, the endpoint port
> unbind only disables BI - there is no committed decoder to reap:
> 
> # echo endpoint2 > /sys/bus/cxl/drivers/cxl_port/unbind
> [    8.261704] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
> [    8.262349] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
> 
> # echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
> [    9.078114] cxl_core:devm_cxl_enumerate_ports:1879: cxl_mem mem0: scan: iter: mem0 dport_dev: 0000:0c:00.0 parent: pci0000:0c
> [    9.078145] cxl_core:devm_cxl_enumerate_ports:1885: cxl_mem mem0: found already registered port port1:pci0000:0c
> [    9.086044] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
> [    9.106885] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x0-0xffffffffffffffff iw: 1 ig: 256
> [    9.107812] cxl_core:add_hdm_decoder:39: cxl_mem mem0: decoder2.0 added to endpoint2
> [    9.114859] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
> [    9.116939] cxl_core:cxl_bus_probe:2307: cxl_mem mem0: probe: 0
> 
> 5. Discovery behind a Switch
> ----------------------------
> [    0.697822] cxl_core:cxl_probe_component_regs:103: cxl_pci 0000:0f:00.0: found BI Decoder capability (0xab4)
> [    0.704872] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0c:00.0: found BI Decoder capability (0xab4)
> [    0.710326] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
> [    0.733373] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
> [    0.941065] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:0e:00.0: BI-ID commit wait took 199255us
> [    1.184128] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port2: BI-ID commit wait took 243024us
> [    1.184364] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0f:00.0: BI requests enabled
> 
> 6. Corrupted hw (commit timeout handling)
> -----------------------------------------
> [    0.472917] cxl_core:cxl_probe_component_regs:103: pcieport 0000:0e:00.0: found BI Decoder capability (0xab4)
> [    2.624316] pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
> [    4.656108] pcieport 0000:0e:00.0: BI-ID commit timed out (2000000us)
> [    4.656152] cxl_core:devm_cxl_endpoint_decoders_setup:1320: cxl_port endpoint3: BI setup failed rc=-110
> 
> The second timeout is the undo of the DSP write, committed on the
> way out.
> 
> 7. Mixed Configurations (BI-capable Type 3 but DSP 68b)
> -------------------------------------------------------
> Not reachable from upstream qemu at the moment: x-256b-flit=off on a
> cxl-downstream is not reflected in the LnkCtl2 bit cxl_pci_flit_256()
> reads, so the path still enables. The suite's t7/t8 record this as
> a SKIP; the refusal is by inspection only.
> 
> 8. Auto-discovered (committed) BI decoders
> ------------------------------------------
> For testing, qemu emulates a firmware-committed decoder (x-committed):
> 
> [    0.607519] cxl_core:devm_cxl_switch_port_decoders_setup:1270: cxl_port port1: Fallback to passthrough decoder
> [    0.611600] cxl_core:__cxl_bi_ctrl_endpoint:1225: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
> [    0.632964] cxl_core:init_hdm_decoder:1116: cxl_port endpoint2: decoder2.0: range: 0x190000000-0x19fffffff iw: 1 ig: 256
> [    0.635422] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
> [    0.635808] cxl_core:__construct_region:3855: cxl_pci 0000:0d:00.0: mem0:decoder2.0: __construct_region region0 res: [mem 0x190000000-0x19fffffff flags 0x200] iw: 1 ig: 256
> [    0.635871] cxl_core:cxl_region_sort_targets:2107: cxl region0: region sort successful
> [    0.636344] cxl_core:devm_cxl_add_dax_region:101: cxl_region region0: region0: register dax_region0
> [    0.636348] cxl_core:cxl_bus_probe:2307: cxl_region region0: probe: 0
> # cat /sys/bus/cxl/devices/region0/commit
> 1
> # cat /sys/bus/cxl/devices/decoder2.0/back_invalidate
> 1
> 
> A committed BI decoder under a window without the BI restriction is
> refused at region assembly, the refusal naming the window:
> 
> [    0.501711] cxl_core:__cxl_bi_ctrl_endpoint:1225: cxl_pci 0000:0d:00.0: adopting firmware-enabled BI
> [    0.522975] cxl decoder0.0: mem0:decoder2.0 coherency model not permitted by the window
> [    0.522977] cxl_port:discover_region:55: cxl decoder2.0: failed to add to region: 0x190000000-0x19fffffff
> 
> The window check runs on both axes. A committed 2-way set mixing a BI
> decoder with a host-only one under a BI window has its host-only
> member refused, and the set never reaches a committed region:
> 
> [    0.633614] cxl_core:init_hdm_decoder:1116: cxl_port endpoint3: decoder3.0: range: 0x190000000-0x1afffffff iw: 2 ig: 4096
> [    0.635468] cxl decoder0.0: mem0:decoder3.0 coherency model not permitted by the window
> [    0.635473] cxl_port:discover_region:55: cxl decoder3.0: failed to add to region: 0x190000000-0x1afffffff
> # cat /sys/bus/cxl/devices/region*/commit
> 0
> 
> And a committed decoder cannot inherit a region's coherency model the
> way a decoder the driver programs does: a committed HDM-D (device
> coherent, BI clear) accelerator decoder joining the region a committed
> HDM-H peer constructed is refused (t16):
> 
> [    0.639668] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-H region0
> [    0.641060] cxl region0: mem1:decoder4.0 coherency model mismatch: HDM-D vs HDM-H
> 
> 9. Device reset
> ---------------
> A Secondary Bus Reset through the kernel's reset attribute clears
> the device's BI Enable, whose reset default is 0. .reset_done
> compares cxlds->bi against the hardware and fails closed. With a
> region attached but not yet committed (t34), the commit is refused
> rather than programming BI into a device that no longer has it, and
> a rebind recovers:
> 
> # echo decoder2.0 > $REG/target0
> [    8.755919] cxl_core:cxl_port_attach_region:1319: cxl region0: mem0:endpoint2 decoder2.0 add: mem0:decoder2.0 @ 0 next: none nr_eps: 1 nr_targets: 1
> [    8.756041] cxl_core:cxl_port_attach_region:1319: cxl region0: pci0000:0c:port1 decoder1.0 add: mem0:decoder2.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
> # cat $EP/target_type
> accelerator
> # echo cxl_bus > /sys/bus/pci/devices/0000:0d:00.0/reset_method
> # echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
> [    9.574349] cxl_pci 0000:0d:00.0: resetting
> [    9.580344] cxl_pci 0000:0d:00.0: reset via cxl_bus
> [    9.593981] cxl_core:cxl_bi_reset_detected:1430: cxl_pci 0000:0d:00.0: BI disabled by reset
> # echo 1 > $REG/commit
> [   10.407149] cxl region0: mem0:decoder2.0 BI not enabled on device
> # cat $EP/back_invalidate
> 0
> # echo region0 > $ROOT/delete_region
> # echo mem0 > /sys/bus/cxl/drivers/cxl_mem/unbind
> [   12.048411] cxl_core:cxl_detach_ep:1564: cxl_mem mem0: disconnect mem0 from port1
> # echo mem0 > /sys/bus/cxl/drivers/cxl_mem/bind
> [   12.874360] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
> [   12.904836] cxl_core:cxl_bus_probe:2307: cxl_port endpoint2: probe: 0
> # echo region0 > $ROOT/create_ram_region
> [   13.752094] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
> # echo decoder2.0 > $REG/target0
> # echo 1 > $REG/commit
> # cat $EP/back_invalidate
> 1
> 
> The same reset with the HDM-DB region committed (t27) trips the
> existing decoder-loss detection alongside the BI invalidation:
> 
> # echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset
> [    7.962842] cxl_pci 0000:0d:00.0: resetting
> [    7.964156] cxl_pci 0000:0d:00.0: reset via cxl_bus
> [    7.970272] cxl_core:cxl_bi_reset_detected:1430: cxl_pci 0000:0d:00.0: BI disabled by reset
> [    7.970292] cxl_pci 0000:0d:00.0: SBR happened without memory regions removal.
> [    7.970293] cxl_pci 0000:0d:00.0: System may be unstable if regions hosted system memory.
> # cat $EP/back_invalidate
> 0
> 
> An FLR leaves the CXL.cache/mem component registers alone, so BI
> Enable, the region and its decoders all survive it and nothing is
> invalidated (t27 flr-region). The unbind after an invalidation still
> unwinds the dport refcounts, and a reset below a switch leaves the
> DSP's Enable and the Root Port's Forward in place for the unbind to
> clear (t27 switch).
> 
> 10. AER recovery
> ----------------
> An AER Uncorrectable Fatal error injected into the endpoint (t28)
> runs the recovery flow, which never reaches .reset_done: the memdev
> bounce brings BI down through devres before the link reset, and the
> re-attach after slot reset runs the enable path from scratch. An
> HDM-DB region commits again afterwards.
> 
> [    8.440748] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) Error message received from 0000:0d:00.0
> [    8.440765] cxl_pci 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal) (Inaccessible)
> [    8.440797] pcieport 0000:0c:00.0: AER: broadcast error_detected message
> [    8.488496] cxl_pci 0000:0d:00.0: mem0: frozen state error detected, disable CXL.mem
> [    8.488792] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests disabled
> [    8.492650] pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
> [    8.492673] pcieport 0000:0c:00.0: AER: broadcast slot_reset message
> [    8.492675] cxl_pci 0000:0d:00.0: mem0: restart CXL.mem after slot reset
> [    8.499135] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:0d:00.0: BI requests enabled
> [    8.519570] pcieport 0000:0c:00.0: AER: broadcast resume message
> [    8.519572] cxl_pci 0000:0d:00.0: mem0: error resume successful
> [    8.519687] pcieport 0000:0c:00.0: AER: device recovery successful
> 
> 11. Cascaded switches and interleaves across switches
> -----------------------------------------------------
> Two cascaded switches (t9): both route tables are found and committed,
> the transit DSP takes Forward and the device-adjacent DSP Enable, and
> an HDM-DB region commits two switch hops down next to an HDM-H one:
> 
> [    1.034321] cxl_core:cxl_probe_component_regs:97: cxl_port port2: found BI RT capability (0xaa8)
> [    1.062426] cxl_core:cxl_probe_component_regs:97: cxl_port port3: found BI RT capability (0xaa8)
> [    1.261552] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:10:00.0: BI-ID commit wait took 165339us
> [    1.368376] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port3: BI-ID commit wait took 106716us
> [    1.621908] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:0e:00.0: BI-ID commit wait took 253353us
> [    1.822125] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port2: BI-ID commit wait took 200178us
> [    1.822162] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:11:00.0: BI requests enabled
> [    7.676495] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
> [    7.929159] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.1: created HDM-H region1
> 
> Three switch levels (t25), one commit per DSP and per route table:
> 
> [    0.971529] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:12:00.0: BI-ID commit wait took 148067us
> [    1.171001] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port4: BI-ID commit wait took 199395us
> [    1.371332] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:10:00.0: BI-ID commit wait took 200263us
> [    1.571774] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port3: BI-ID commit wait took 200339us
> [    1.773070] cxl_core:__cxl_bi_wait_commit:1034: pcieport 0000:0e:00.0: BI-ID commit wait took 200452us
> [    1.973680] cxl_core:__cxl_bi_wait_commit:1034: cxl_port port2: BI-ID commit wait took 200378us
> [    1.974046] cxl_core:__cxl_bi_ctrl_endpoint:1243: cxl_pci 0000:13:00.0: BI requests enabled
> 
> A 4-way HDM-DB region across two host bridges, each a switch with two
> BI endpoints (t32): the root interleaves across the host bridges and
> each USP decoder lands iw=2 below it, all four endpoints at bi=1:
> 
> [    7.877568] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
> [    8.039467] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port2 iw: 1 ig: 8192
> [    8.039473] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port2 target[0] = 0000:0c:00.0 for mem0:decoder6.0 @ 0
> [    8.039488] cxl_core:cxl_port_setup_targets:1638: cxl region0: 0000:0d:00.0:port3 iw: 2 ig: 8192
> [    8.039491] cxl_core:cxl_port_setup_targets:1664: cxl region0: 0000:0d:00.0:port3 target[0] = 0000:0e:00.0 for mem0:decoder6.0 @ 0
> [    8.039498] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:40:port1 iw: 1 ig: 8192
> [    8.039501] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:40:port1 target[0] = 0000:40:00.0 for mem2:decoder8.0 @ 1
> 
> The same under one host bridge with two root ports (t33), the host
> bridge decoder interleaving across the root ports:
> 
> [    7.754721] cxl_core:devm_cxl_add_region:2867: cxl_acpi ACPI0017:00: decoder0.0: created HDM-DB region0
> [    7.824452] cxl_core:cxl_port_setup_targets:1638: cxl region0: pci0000:0c:port1 iw: 2 ig: 1024
> [    7.824455] cxl_core:cxl_port_setup_targets:1664: cxl region0: pci0000:0c:port1 target[0] = 0000:0c:00.0 for mem0:decoder3.0 @ 0
> [    7.824465] cxl_core:cxl_port_setup_targets:1638: cxl region0: 0000:0d:00.0:port2 iw: 2 ig: 2048
> [    7.824468] cxl_core:cxl_port_setup_targets:1664: cxl region0: 0000:0d:00.0:port2 target[0] = 0000:0e:00.0 for mem0:decoder3.0 @ 0
> 
> Eight BI endpoints under one switch (t31) commit 4-way and 8-way
> HDM-DB regions, the USP decoder at iw=8, and the shared root port
> keeps Forward until the last of the eight endpoints is unbound.
> A Type 2 (cxl-accel) and a Type 3 device interleave in one HDM-DB
> region under a switch (t29).
> 
> Applies against v7.3-rc2. Please consider for v7.4.
> 
> [0] https://lore.kernel.org/linux-cxl/20260428200410.705675-1-dave@stgolabs.net/
> 
> Thanks!
> 
> Davidlohr Bueso (10):
>   cxl: Add BI register probing and port initialization
>   cxl/pci: Add BI topology enable/disable
>   cxl/hdm: Add BI coherency support for endpoint decoders
>   cxl: Add HDM-DB region creation
>   cxl/hdm: Rename decoder coherency flags
>   cxl/region: Log the coherency model at region creation
>   cxl/pci: Split BI capability probe from setup
>   cxl: Allow auto-committed BI hdm decoders
>   cxl/test: Add mock BI topology support
>   cxl/doc: Update maturity map with BI support
> 
>  Documentation/ABI/testing/sysfs-bus-cxl       |  17 +-
>  Documentation/driver-api/cxl/maturity-map.rst |  17 +-
>  drivers/cxl/acpi.c                            |  31 +-
>  drivers/cxl/core/core.h                       |   2 +
>  drivers/cxl/core/hdm.c                        |  67 ++-
>  drivers/cxl/core/pci.c                        | 523 ++++++++++++++++++
>  drivers/cxl/core/port.c                       |  48 +-
>  drivers/cxl/core/region.c                     | 134 ++++-
>  drivers/cxl/core/regs.c                       |  14 +
>  drivers/cxl/cxl.h                             |  57 +-
>  drivers/cxl/cxlmem.h                          |   2 +
>  drivers/cxl/pci.c                             |   8 +-
>  drivers/cxl/port.c                            |  46 ++
>  include/cxl/cxl.h                             |  13 +-
>  tools/testing/cxl/Kbuild                      |   1 +
>  tools/testing/cxl/test/accel.c                |   2 +-
>  tools/testing/cxl/test/cxl.c                  | 159 +++++-
>  tools/testing/cxl/test/mock.c                 |  13 +
>  tools/testing/cxl/test/mock.h                 |   1 +
>  19 files changed, 1106 insertions(+), 49 deletions(-)
> 
> -- 
> 2.39.5
> 
