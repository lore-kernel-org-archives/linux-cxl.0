Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB9348898;
	Wed, 10 Jun 2026 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114518; cv=fail; b=IxvzxZMv3Tjp0lLsgv0lVkGkS2rH6yYe+LJ3N7feVjxbKlZb2CwFIwn+p5wBC9cY2Py0OXfzQzHbVSZN3GD6XiaYk/MP6vnYVyyXjHym0T6Dd71qFONgYdCQ4Mf1frmJ3FSnZ6KrzaiYI3ZRspnFhP3A0VJitFp+hU3LUup5lns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114518; c=relaxed/simple;
	bh=E36LBAnW1+OqwXjKZH9QpvNnzDt49siy8Y4NJDspjQI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C7RXlMvwDpa1zipjVSBgJ1h/wV5SXmEzCJZmOLg7id+Fmcf1A8v6L7/4axGm+o0iCDJeGGHLv5PhtnDxzC/g/3GmNnGh9w1Uo6sru8xHv7VqJLilCxKGcpmMh+VPabHNEDfYtMLy0kpEyVDFdiURhl4fBmrlqchNuNlfVqFAuME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKDzvoV6; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKDzvoV6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781114517; x=1812650517;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E36LBAnW1+OqwXjKZH9QpvNnzDt49siy8Y4NJDspjQI=;
  b=VKDzvoV6dolduzcugPzMXMXkS+REtSZrGRpl8yd4ozhQ6WZdtsx225XC
   UzRYPZyIu0QOGPt0aI9e2rO+ObNvYgWndRE4LP21DVaw425g3Q57+R3Ie
   vqCJSavgvq07GAXWnYhWLg9FsNUbdksb2AvFyAC9ROTlDzfIgUElJKnNn
   cRC27wRadU28U4U224ZbD9ZCOyvmeAFW5/VqYgV8y/NHHJkOpTduSEPYM
   PBGhXrkvaLhNsOJ7p/ciwOCtmuD3JiFXQIj0nfd25jTD1STNsFCR/JNnY
   F+NDE93YITs81b5Lipprd26W4LfkDhFIv6u42Ag4J3xMT/Mvm9BNzhc8q
   g==;
X-CSE-ConnectionGUID: lOjLqa6KQM+TBpuomTtOAA==
X-CSE-MsgGUID: VlkEKLGUQwypp8aQzpnAUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81918683"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81918683"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:01:57 -0700
X-CSE-ConnectionGUID: PY8kAGx+TgmA/to6IRVL2g==
X-CSE-MsgGUID: UWqrUHoyQ9KSAT9Fjx01Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246102317"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:01:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 11:01:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 10 Jun 2026 11:01:55 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 10 Jun 2026 11:01:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzCITML417RvjUHIT8t0pgiaSZfLYPFitJd3L+RlXmCX3FxS4nQ4boRBRYxkaGSzR4pqvHBBqrpx/+960LgTip9r/99GxNH0lfUT41jaNm8iUkmqz6ETHI/ZMeICy4JKp+sEFrklfUAguO6FvmHAZlwSL7xKGkHcO8XHp5I2J/gvPiZuL55oMecZdvCnUR2QsD9CzDyhA8T8SrtytWJgyIUJAED2HTWYxMOQPsa6raAraa9Q6gU4GvAXTEx4qvytlhZVHbtwJnTHzj36rQOTWI/O9COrl353c5fREbHEPJEgMVWsFvcpGS1m+puJdO4TuSlu/AhqZ/VdrxDi+s5YOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M29UfIxbWFM3aOu0DJTMrwaf18BKLHWYrhCVjFFOL3g=;
 b=v+VsM/H96sI2zhxmNoVmid6+3X8p3vyrVpjCX0X48XNKK9tQjrx1SzH30AdScCwMV5641diSt9qcOIRLGq9IBD3PDOjtWK+ioDROvKKPrM5Fa5XO6bNcRhEucklvCDbo0fOVBQGSx+3QcfoCFFwYt1yc+5aFwy3mRfdqwh8Ur5DI3CIAdbaqUeI+XBbq/mjUEP82wq8VxqCzmDk184P3E0UbCVLpZZRhAJKp1T6ZWbwXD90QluqKhSAVSTXpyzoSc9LqXYkhZHA7ffkNSX1otmbfmKM69ds95RrbfqX17fpgOdsMdKCjGPo/042gakznIF/Ci44aYVnlmOnjXgOPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY5PR11MB6161.namprd11.prod.outlook.com (2603:10b6:930:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 18:01:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 18:01:52 +0000
Date: Wed, 10 Jun 2026 11:01:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>, Eric Biggers
	<ebiggers@kernel.org>, Alejandro Lucero <alucerop@amd.com>, "open
 list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/test: reject wrapped GET_LOG offsets
Message-ID: <aimmfgWS6IPtwLVA@aschofie-mobl2.lan>
References: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260605142036.2062347-1-sam.moelius@trailofbits.com>
X-ClientProxiedBy: SJ0PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY5PR11MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5962a2-9c3c-4010-2558-08dec71a59de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /DYRb57sjlr33ef8uuEuC61C1PGZWAOzhUPvUrhJtTlSnclC6eiUq2xLGV9g86+2XR0glRoQcdP07SjYRNQ9UVKBw9v8Sor6GJxjM9yOpSzNXu9EZsqQ1Ax64A+yWVdApoz4sLsb0mKWqf4VhBvttqPSk/NBcawu9+HDcuAx9KNv2jf3jEGuZXqyUSLM3G/cGVwq8hD+VgCAjI4p1nVQgMFZDHal8s1sytONVxkSYuJj3vNwnlH35DGqlA2b/5n5lEi8ir75sv/4HaM9hKB0h35VLpk8qM7sxoyp30JtTwtklqfbCe/CNb0o82Q2ty9C5gnRpvl/GuoImm748JLGPRGhilicuS+XSjqgDpb0vElrUZal5dXDyaasCrYICg7gDj0S1ZTuJDS5ssL+GLnHNG/jlNnh689I3OlpZ6gEtMVpScCkLy97CC5ubpzZQiPYEB0bWu0H/ky/0jaJ6lhC7AGeYxXLUDj2hRysSLrp85mPzINhOXH1zjuDF8lXuVLL2J8ZWCeJS+m+RnIBRVvxZXvS+CsJgMk5HFs7FHTIk3C69x3wFS9uhfknlxHDBl8EGMCyEsG/11jQX2gKL5GCOxRkjIaqljBQlGQPtQlKfQnTWta5zeYbTnn3OnklcSMgxk6GwPSKn86NcAn4xi+W3Nocfw67hU9/BTkE6kS40u99ULWT4eMz2B/+2HqXeqbU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBqrgJ5rlRi3J7Z6BpWRgMJbjgMS5HsfKjynKd5rhBwwr5gStVpAZdmfOEoj?=
 =?us-ascii?Q?7ovrOqwKdfUUT42ETk2PefyXpXVmAZJmU5QmA17rlK+tsSWxmBQETFFcSfP0?=
 =?us-ascii?Q?cF5PtpKapHJw8+yVG/953mji/Oyim27Du8cY3/eTnT+Q6Ltba6QbJ0MVDeMg?=
 =?us-ascii?Q?/PXZwn/zct+fpyI7XQLDzKstOEB+8vFxq8YVagsnKXZkTsLpZAB57rIwypSj?=
 =?us-ascii?Q?pnO0CNsR5Pw40v+9lJtjNQTxNon/vXPig5SceeRW3qQmJLAmuxeHFyTmqz+V?=
 =?us-ascii?Q?6PnDO+DucNSZKnIj1esajdmFgihubTfbSzLSQSJ07Eq68KzetU1nqqT0eFC5?=
 =?us-ascii?Q?iqJciS8tvgSYqqCm3fNGecF+NZ8lHSNKnkVADwc5cmFAlSbNbDjE6RDYIGu9?=
 =?us-ascii?Q?07mRFNZRR/7iMPAlIdUcFkt96mjVfDqEIDIdhdafoXAUWc6+U69BbesoNGvM?=
 =?us-ascii?Q?WJlr7mTj/uu4rIxc1+eFVout/uW9pKipY+MaysAvjhgzNc2N05mh6vgXsc65?=
 =?us-ascii?Q?bB6akUidk3dYDKJH+9ceytCzDOz8fFWz8zAMg955wcrIImS2e35xMpByUvGN?=
 =?us-ascii?Q?6I4yGzv3kWS06SRFwWh23V9e3OQf58fjRpLryop5u52edBfYSTxIQL/cwM43?=
 =?us-ascii?Q?IPUZAg2+Q6ZV6lHTTj47Z17/Eqx10kLb+StBoRLC/yoYEqubdmen3PtYKCoW?=
 =?us-ascii?Q?udveuYvbPkmkybivAqB7KsGHrxQ2K6ZjqZZliLc4qawneRISe1edirbF8Qfz?=
 =?us-ascii?Q?1pWDrJsKTycFcVruxUcm2UrcpTYJPgL01cLnZ0Z7txWHxLWcz0xzle3jyagW?=
 =?us-ascii?Q?NGDjQxoviESn7ASagPkq1NsvaB/V+kPMMi4YgxTQG9b27q/+op651ca66L4k?=
 =?us-ascii?Q?k9wx6FZvr5wdgL6vOpVBy7oxKDg/4k+voHNprRIBt6596eFc1N+5M0QX2U55?=
 =?us-ascii?Q?EDLPYRWd7k/4lvHHke8xocvuWflRwR5GZ8REXlU+hhzIrAw6DQpFjF61nP3S?=
 =?us-ascii?Q?QgxsojDPZWdVjjvaqLGbofAUhUqpjVNaODY/IJ1pfjJe9B6HOEGe33qDfQPV?=
 =?us-ascii?Q?OadqDoLF+X2RHPsPmnZUYByzDHHbT40sMhy7iXOVXLa22j2Acvbw3juJWqgF?=
 =?us-ascii?Q?gHV35tjqV5lB0OXr48m6HgNTLjnGDktpT3RVeOdnW5jUMirC4GodAQCKu4Zd?=
 =?us-ascii?Q?Rlz0ghyL2gOBocZUlLpcJBThDH7T8p4FUBLkl+D4k2V3eKAfqy1/BJpzmufH?=
 =?us-ascii?Q?88DgaLPdtDApP2IeAYHnbX93Rsg1Y/2bVgVt+SWjqGVSjhDXhUUej2GzAiBR?=
 =?us-ascii?Q?fAbrlwsMk4+F/032NEIb4E/VkQadtu0DZ2Yj2upRTNCRwgo6Rvqh0Rh0ZMsM?=
 =?us-ascii?Q?kiqQQ4ljIKZk5dT7jH5YX2XjMUrWh2mETUN2cBkzIp8bSrE/u52ueRfRwFhD?=
 =?us-ascii?Q?gFx67KviM5eV3y8g23YOgcOHveACcgRkw8mPo44Yo4puUQUnLGy9M8NFcyj2?=
 =?us-ascii?Q?5XoYloXtLWnq149Wr8xL+cQufJOkQrP7U38lIPsUqg7MWjmnEz6Lvk025K7n?=
 =?us-ascii?Q?O2928ygKuJwLOL63EqToV3GLIttQK5XL3kO6Vk6A9wqHlcJ7a7ABM5jcnNUw?=
 =?us-ascii?Q?Sv4Qk7PLKUOL7XrjvMOs/qoep+NazKsv+HfQEI2RGRR1eJ7pBmjvn24m5SfQ?=
 =?us-ascii?Q?f7vXtw8GyIUIyl0vi9aJgVsk8CKj7/oq3OvJm/BzqQk2mnnOzZoG48EL52vn?=
 =?us-ascii?Q?0SbOoJCaRZ2Uh6e0EbrckZJsLZSk7jc=3D?=
X-Exchange-RoutingPolicyChecked: MlinSGL71pMcHJ3Uxm+ap4XTj7hqxku3kp0fqMBZebUbdT8vIAH0WosrvMfEgcJhCgSUZWQPX5+CIFruT6EceVqLrj6CJK/RsXhTUWQI3RTkNMeU9Jg4tuz7cpMk75xWPB6kCBB6w9j5HX2aeibLpZKST4Dgyc2OL68Te4StjI9LsfzRXreoBOdPDqWFQZKU+ypPmgOo0y67i1hPAkApUTXdG188u+I5kOl3wfiPgea2yBzdKwK/7EZP27xsoQLwC8yQRUnxvwvskY/yIQBw1gSt5soeI/KxQlPFUFDNyf8yEbScap995ksSbBZHempGACBINwykAjJoYq3acEno3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5962a2-9c3c-4010-2558-08dec71a59de
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:01:52.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rph0GYNzegITl5FvDjqTQZHvqydFP6BBAG7/0SDnLdFOcXWEE5S/WlglOItElh4TRc2vI5/vB4/qBqZpSCDbpMwnMSth2aAZmjeW4CFxaDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6161
X-OriginatorOrg: intel.com

On Fri, Jun 05, 2026 at 02:20:31PM +0000, Samuel Moelius wrote:
> The CXL mock mailbox GET_LOG handler validates the requested CEL slice
> with `offset + length > sizeof(mock_cel)`.  Both fields come from the
> userspace CXL_MEM_SEND_COMMAND payload and are 32-bit values, so an
> offset near U32_MAX can wrap the addition to a small value and pass the
> bounds check.
> 
> The wrapped request then uses the original large offset as the source
> address for memcpy(), reading far outside the mock CEL array.
> 
> Validate the offset first and compare the length against the remaining
> CEL size so the check cannot wrap.
> 
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>

Hi Samuel,

I'd suggest keeping the commit log focused on the broken property and
how the fix restores it, rather than tracing the individual arithmetic
operations and later accesses, which are already evident from the code.

The GET_LOG handler is intended to reject requests that describe a CEL
range extending beyond the available data. The current validation can
incorrectly accept some malformed requests because of arithmetic
wraparound, and the fix restores that property by validating the
requested range in a way that cannot overflow.

The discussion of the subsequent memcpy() access leaves me wondering
what the observable effect actually is. Does this return bogus CEL
data, trigger KASAN, crash the test module, or something else? If there
is a demonstrated failure, please describe it. Otherwise, I think the
property being restored is the more important aspect to capture in the
commit log.

-- Alison


> ---
>  tools/testing/cxl/test/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32..5dc9601a2a7e 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -584,7 +584,7 @@ static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>  		return -EINVAL;
>  	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
> -	if (offset + length > sizeof(mock_cel))
> +	if (offset > sizeof(mock_cel) || length > sizeof(mock_cel) - offset)
>  		return -EINVAL;
>  	if (!uuid_equal(&gl->uuid, &uuid))
>  		return -EINVAL;
> -- 
> 2.43.0
> 
