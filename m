Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30F2566F3;
	Thu,  6 Mar 2025 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293353; cv=fail; b=UXezVorAtcqpn9ZKUdKzuiq9lv705vaMUM+nqdvSRQhCYRPyLAInIDILssxUjsKax5DaZLCQ1qrLLbC0Di3eBdSSRWiXb8JECMhyoED7vPb/M+btaCeFddvAf1NoQZvymO4Rj8yPgalOlH/iNzVVOg0Sp3jMzI/REFFEkK9FMVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293353; c=relaxed/simple;
	bh=1ySfuGk8BoOFZxf4P2c7Wu8AHYqXb9/iy1rNTH3wiBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bLO2JIaxCDqXiQPeO4db89IKCO7saSVv5Uo/7ZG+A9EW1G/Fe9wp5kRSsn0R7SKdXDGJ/mAZaCJougda/6R6qv+y1OQ233H4j7Ap9+L+7m8dcqaBeMTUY1euLvGS5YV56CamARhaeGLbDNG6QK3X01h1bMinx5UVa7E6jlYRRWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btGc3EHO; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btGc3EHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741293352; x=1772829352;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1ySfuGk8BoOFZxf4P2c7Wu8AHYqXb9/iy1rNTH3wiBA=;
  b=btGc3EHOES5nCJGWkigUCFvP3TcSJ6BjG9/QQlUw0CeLpO5uNZSNnEsn
   67x6kUZAWoJs4Hnqfg4gmDZh7ZTbQ6XTzxEzt8eG0Jc1Qt+8ZUpb+qtsY
   XablJULZA6SEgd+RoAAObMZAl5hOcQ59eLSp1Ids6B4NIGC/5zkthbH+s
   v6XGhVLSVQ3a+C3cE9AOKCJWb8q2YsJLxniVtjrh7U+HnAqK1Xl4e3Nos
   c/xXHHZa4LcYBKOUG6Da+4pWlrEkdD5Rphh3oCNeggr3yvMK4+uomW1p3
   N/BuwN1jpKHvI/B5tXH+avBR/AzocyQNWSDEQakaZ3+gSPo1uWYCoDRl4
   g==;
X-CSE-ConnectionGUID: N42uFSzOTpu7s/MIxtaoKg==
X-CSE-MsgGUID: T7UWkMe6QWGn9Wvlf+L2Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45983403"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="45983403"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:35:51 -0800
X-CSE-ConnectionGUID: 7nG2WV9RRPiK1nINsEz0rg==
X-CSE-MsgGUID: Nx++CyoWRVa3pVS8lcp36Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="118962772"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 12:35:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 12:35:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 12:35:50 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 12:35:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kna4k7mU11vZSxl0K9ppAW0c7qcEQ5a91xj4UflS7QyZb6wWjnlEBQjZLezaEb5ISTU3OKWFtxx60C/gn5P86rJ3TV/4Ac+s1otyXuH5VPzd2BIJOBAH1pMudTvVFvnmW42ziZYCx2I2YyIQ3L98c9aTWmTkqiCDWbFFfhy9tA/4BnVagUW+6CADajpHuG0cZxVJAI1oklKVyYuTFy2AQdOVahk3ReVhz/QzvuZRrxRkmHpcOw37/TEXYkAbnkspNAP10vn1rsu9WEKWH3FM52aEIk3XGl7og2xAAiBTrBYC+tFDQAHJ9US621UkzdeopDH3S/wiM6W67w5ZfJSpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zok7ehi2vAFZYz7Acn8TvycaXwpqcTP00iCqMY/EDuk=;
 b=G37jyny1jA6Pfzmh2+wlCr9CCTLj/WxFsIRxxHs+VbHgjUHOYC+7IpnlWA7Mpv4ZI5ZTpG1tsYy7Eigow9kWsagMlTroD0QduPUTqJGGWJDVygRAPBgCuY6VJfOvtimNuYxU4E3hbw7UlYAT2+5i228gLfeYDGBbhq9ELF7oSo9LyqNoJewdG7+WC20O3oO5VbVdpFmhwn6m80i1GCCMlX0X8bMznzeRfuMXkaYRfC1K6Iv1kub4uVjpWqMR06kWJvlxfj580m0gg1lMPsvAlQHwOp0az87tiIiOav1IutdQNw7PqPsSFdsoiAUsFnVR0jdnceSDauN0B98Udw7boA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8528.namprd11.prod.outlook.com (2603:10b6:510:2fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 20:35:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:35:48 +0000
Date: Thu, 6 Mar 2025 12:35:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 08/14] cxl/region: Factor out code to find the root
 decoder
Message-ID: <67ca07215fd48_1a7729464@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-9-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-9-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4eb055-1f96-4d84-e279-08dd5cee7a4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t2McF5kPyTQerldks3x2iAcKit61E2YwMkW4pHaAmSZCFjI9gbusZmPYGUAl?=
 =?us-ascii?Q?SKeEWOaeq6kdCdR+bB15ZFWlppp39Jmx0OdCaBwmLVfBMnJsxHUAWNChK+sz?=
 =?us-ascii?Q?ovr54+N7BBxLoABtKbmMxtUO4IbOdG3fWbXXNrNf0Mw/+lKXv7apEnEMAeoY?=
 =?us-ascii?Q?kRZlPrUgbSMYpuGSsajZMg2KDi24thUlmYCjMjsMCLRMJxQqebZJbCRyXDZ7?=
 =?us-ascii?Q?t+sXOnz1UzlOM6WcTz3EXdjkoZAsRbnAIbqOqy4eGAfTeietaauxsf9K+YEE?=
 =?us-ascii?Q?2W8owYee8e2NccGCijkbS51v+mOY10R6U2/a5Ly3GcvxUmieYXK8A8aafeV8?=
 =?us-ascii?Q?Jyx22h5dFTouWVuNcOXUKj5RlQU4W+S53lzuKSd4t4SEEH0N3uIsN2IO8oWk?=
 =?us-ascii?Q?by0gpMChaDxOldEsibSIRqeddKfpaqHUmgIOqjqZ2klvVhCkt4g/BbCb5c9p?=
 =?us-ascii?Q?Vd69qNh1/U2Xqvv9WgJ0i7gPSpBDYeVybqaZRcV1axtOq9lmYHVVLThX4BAD?=
 =?us-ascii?Q?HSmF/3ua20mrVV/lroZ8SpnspIp3BlwAEGYZ7xVb2/2/2po+TOe/rk79ds7Y?=
 =?us-ascii?Q?3oYKoQObX3lgUwmriyH3DRsYPpNKJgavjkmAKQyDkDZdI7zSyYGXN5pIk+ON?=
 =?us-ascii?Q?KRvGv+ee+CHM9x21YpChIO4D7QbgQcWF/g5iVX9oh+VURI2CtZrSJU5sdEaG?=
 =?us-ascii?Q?JMwD+Et/BQoa+DP+gs0kKP7U+QYHF8gj8msza8p+QpWD/IqoMxEXklcSMAbA?=
 =?us-ascii?Q?WvMqp2SAIVOVppgPp1ctuW7Sy7TNjpT2hO9rqqjA16Fr67Gz1gICI4/trXL/?=
 =?us-ascii?Q?TzLfW9UbQV9QbUKLpykXSwDMl+SLM1Vwq1+I4+6Hmbv6EHXmqVIHt2wUuHMx?=
 =?us-ascii?Q?6wkWe9v9sQzNVGeMlssiKuCY6H3HdWidW6fuZslaqbQRm/jsuSruyp6ZZLhj?=
 =?us-ascii?Q?Y+A5fv1Bf6Odg0lJVoBbQzGgbncQCkQjYF3vUll6ovHPNg4yE2u8GfvIOqp7?=
 =?us-ascii?Q?aXVOwCP+tabQ7HgZtle6ylP6o3DczthYYoItyUtM470woyrQW8+P2kFy/1kO?=
 =?us-ascii?Q?cJiEf7uxyU5/1u/t460juRSREkReLW/WmqQJf/7kbZhgLyrbHggY1vE07201?=
 =?us-ascii?Q?w76DAYBsw8Zd9OhliEBRhrfP1HceSeOyLILUApghpW03Q9U6ppvbHFqveoqb?=
 =?us-ascii?Q?tcc3OGpkPHzw4oE56uhWOseCzhUN+q7saDwdlJLF9Vh/EBkXuGN5ArSTAghO?=
 =?us-ascii?Q?uriurBuClB1OJrzZbIjIJ7zMG74zuiP8ejvTsRcQhX15KPCjFkpaT8i8c19V?=
 =?us-ascii?Q?M8zOefCfLY/1zkhUXmEsEJ/VMJInD505RFOS4tbqljkujsLVFGgPGoaeKGLx?=
 =?us-ascii?Q?Coq/wMgA+uYinGg/0syIvQaJKb3C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PX1oH13u5x3E0Ee/1CSjkLw8dF5VScM24gKyT3GxNECbRfKA/Q4WepyK9+3J?=
 =?us-ascii?Q?eT+rkB22EKr2qSmhZRhsdzBmvX4QNQ9hwaW9iHM2QI6pJrmjgb/7avcLZGTb?=
 =?us-ascii?Q?kwkrA91CX2kuKHCwNy7VHj18ZTgX7VpPiz0Iw4v78CREM889YuRkedXzSsoi?=
 =?us-ascii?Q?FE4YCPpcEyqcpaJJQzQokd2UlMBKYHk59BnIwxUsqUMIHJo4pS/yDB6I0Q1F?=
 =?us-ascii?Q?p88e787EbY2N9FMLhWyQcaHImozod25toP6+3ytw3sJ7bSLvwVCElvWmFdh4?=
 =?us-ascii?Q?NIMvhO52OTYSBMrIbDC5gl4baedCNGfUuHCqRB2p0U/Uv3ye3omBEXdedrrZ?=
 =?us-ascii?Q?rPqTK+jz+BK2L4WgEFK1hV5WwIl32pqW4B3zOsviowuxpwwodJWS3xYcXaRU?=
 =?us-ascii?Q?X9AYtALs7bfwY9LsIZEQt5otlS9g6ylRR06TnE9BOjbVNFMC8g9/c5k1xlyI?=
 =?us-ascii?Q?xsi/tGtUjD3siHpIdVvYYvdj8nef7aw+efN8uyBLrlxnidkjy7ECKI/VWcOc?=
 =?us-ascii?Q?nd8/LqWHV2jRx6T+rb1HfPnP9del8DlcWaHvmm9oV1Z2Yg6CnnPTnA4ITGRn?=
 =?us-ascii?Q?fg/N/uVbSyXkUrNeKg9jVVrGP611v6a5n3+NiMSRt33MmXBrn6lYR0kVG8hG?=
 =?us-ascii?Q?GjWwwCJfHkv9Ye0PNssuXJpx2NgxbQir3W432LI0eahnj8DKGlqI6cW/kANr?=
 =?us-ascii?Q?V2DCLNpvX7tMWLa0uDpDghgREdC7T0p/LJnvhQjG3lykXA3OhhU8HHNtKD6F?=
 =?us-ascii?Q?f0siJZyYcs12C7BYF/rc5q1627ETXAlRCBO4ymj9Bgx7+aciseU5EeXz8cqx?=
 =?us-ascii?Q?J/iwrWsIRy1PU8ckeOmRJFwCGJQsc96OHmkCkLNsgFOrWPvAIbz+QU5Cn3R1?=
 =?us-ascii?Q?6ssL1hPFCF2oxvJeEg0X9FfJkyqSxuJuHpzhaVzMIF4TK5MrQAhTHnOOFSK/?=
 =?us-ascii?Q?BtpKy7SpsHEQEOEyYiYY9ioUquhPXwci3ZTZTB3Zr2mpXeAKzTSSLX8XKlqV?=
 =?us-ascii?Q?r/sw2EjesBt436qD6zi4O7BEYBnHlZyOR4zRXAxZ3JUuWtBgNyo1h3hJuncx?=
 =?us-ascii?Q?SgvtHTwL6t2d24bVWQ+MdEfUjxxYt5RWYUiakzM+5bTwcU7nST6mkIJr3DSi?=
 =?us-ascii?Q?vq0OBYURMJCh14v2I3hvQ2ORzO96trX3Fye5ACQmIqX6F9iWVQDdAhOceHkv?=
 =?us-ascii?Q?s37LcZ69WFqaTN3wEgnlGfLSUBr2RiSIg5dSIMgy6G1k0lL9ctL+Vl9jWTAv?=
 =?us-ascii?Q?yMi5V0tBEG8Kk6gTQD49GeY5tzYgzRlmhsr23TCvecA7c12xX076GmEncuFs?=
 =?us-ascii?Q?NFaBfYLjc2mzf+AJVYAYfj77GUo2lj9sYVeneRLb7VoR2WZQdzfKNYLPniC0?=
 =?us-ascii?Q?pcPvaAYKmrOIGh+OEuJVaqwY+HdIjRzMLcy+HUrOjme8BanVG/ChH94nHghT?=
 =?us-ascii?Q?iDZkhwtk9eawTNYz+7parW+s8cw1PwQjFUadjGGPZD9hGcALEsvKM0PBkCfb?=
 =?us-ascii?Q?uCVyNnt1gdNy4iK44XTbUxeizD5XdiH6PDHLtBmmPok8km/t7cTaUGIPSYPH?=
 =?us-ascii?Q?SGjz3I0SWO4BVOFO02JYRwjxQkyqDWltozVlv5Uou0sjXE2bhMcZJrvYAGlF?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4eb055-1f96-4d84-e279-08dd5cee7a4a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:35:48.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUrakjyC9wi1LZa78gnu8BdjtbJGPBzSMD5xvGEqbiZmb73pVNORXeTY26vPZo81D1tycmqNrJDPenWLuB5PiVjCeMHswkmfK9RXWaOfMJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8528
X-OriginatorOrg: intel.com

Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine the root
> decoder associated to an endpoint decoder. Factor out that code for
> later reuse. This has the benefit of reducing cxl_add_to_region()'s
> function complexity.
> 
> The reference of cxlrd_dev can be freed earlier. Since the root
> decoder exists as long as the root port exists and the endpoint
> already holds a reference to the root port, this additional reference
> is not needed. Though it looks obvious to use __free() for the
> reference of cxlrd_dev here too, this is done in a later rework. So
> just move the code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
