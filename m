Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D9B129E88
	for <linux-cxl@vger.kernel.org>; Tue, 26 Mar 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496248; cv=fail; b=VMPsgwHDAyg5/IDh/ghAylNOBdfOYm/unmyNkKydjU+Y+bkhWS41rSH83gSzzLs6cNH8tiTJCk3NYpU3nBfu+qvwGqwgPb5E1GIJU48UZdhTZUULXf3aZvTuRd/d2gkH5jVgxtlI5xZqarmHBSf4fxZt/my7/oPVX7C+ZwgVPHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496248; c=relaxed/simple;
	bh=ZrZB0ogVVJWm4DBPmPKdtSY4I8vU2na2q81QPVNaov0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hheOAqyV6v1n/o9ul/2zBvZl0K/YGAMZ7J1mgfJSM9nAuoWl6N6nI2CI9uWOXcnBPV+3Ba4WUsEOSZDxocSHp/BEL/b9k1XndKM0/4UfVRS7JCP/8M50vO+OGrOZKDPk0/N6HU0htxKk70oVz9FvHyiWz54j+Moz0Rx0PsYdG6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHgimJ/y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHgimJ/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711496246; x=1743032246;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZrZB0ogVVJWm4DBPmPKdtSY4I8vU2na2q81QPVNaov0=;
  b=NHgimJ/yWIHUN3iJhKwAcLMROZsWZ7cBtCsmJ2CB6aloXmvqiI5QeFyu
   F/5wew5YJ3VUzva5I66l/503fptrwL7tE5WvVG1L5UIi8vwZaRU6D1/wE
   WYHMkhDpAYdk9G+h5zm7gzgX/8/50aA60mrLIUsU3nDzLYLo3bqdTRkVB
   O3TgerQXhZ1EGUlHxKvgGdaCItIauuwKC8Aqx2oWGg+/IFEw5/duq8rHd
   kab12IG9WId3cb6tIY/4gdIarKIfqgRmR4LohyTPpZwqZ1Txhy/Wx7aTt
   qV7XaqAV3Fr8LCmkTdBOg3A2872duFde8UAvFwGFOxktbAToUgAbrdXLK
   w==;
X-CSE-ConnectionGUID: wKpBCJPDSjWzckjiDS54Cg==
X-CSE-MsgGUID: J9h/Vr7IREKxizLbZIfeSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="7177535"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="7177535"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 16:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16111652"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 16:37:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 16:37:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 16:37:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 16:37:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 16:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlqxPkvkYs6jldQ/atMTelqB/iduvfI/joAE6LTiVW0rBZNfJBDfiNePJ+2heKVWPjdzROnhYp5q2Hb+4Hec6QfG38o9Gu4AugA/hn01kGv2teLVO5o0ucm4kIInKLNmVtr5LMEIV2fy2hIKc4IWoteBH/M9T3o80WAhRcGaEpnAjOBC9rAYYKl9apF0sxs/nD/RNJ9Do2RRBH8bUNvS9T6d3g6FVqzjZX3OSfm5PFeiibMOYcF9eMUj23sKFltTYv9L4cz96F4g4XKA6sIkUd2v/Y+G0sZreSOH7uhjO83gXYApPLBZvPIcpmUrhQsBIHPpsPEkYj6kVLaoyIzOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrrBcSyjx3XPfc0Ln2edPgsr78A4dP1hjSsjtGFW3oY=;
 b=ZQy20GbCt3LunTdiEl625056mAPT/JaM6cr9dU+X3Xu3SVyKU70w33pYsxNNBqkp4+JNcAwQenRcIFykD2lcprXcoqIor23xMX6FXzVwjDioExzV8LZN8Xxqsxhya45uWGIDCcUzDN6BOPdNWQ9e2I0X8Mwp2++VoVgKpVpdrhg4JQMCHYZRceY52cbjohJZ9Z64nHdbQkalmjReKlms/9vU529F9DGzRhkrkQ3QrFgkSvGUmzzX3ifW0dtI5Av5jEDGweyq0E8sXH8h82NpvzCaHqGndWVhKm4PPbaVlggmRzTkaBvR4xuV2fJ/VJch40k5bHirJwgw+oGhEWK7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 23:37:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 23:37:21 +0000
Date: Tue, 26 Mar 2024 16:37:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <sthanneeru.opensrc@micron.com>, <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
	<john@jagalactic.com>, <emirakhur@micron.com>, <ajayjoshi@micron.com>,
	<Ravis.OpenSrc@micron.com>, <sthanneeru@micron.com>
Subject: RE: [PATCH v3 0/2] Add log related mailbox commands
Message-ID: <66035c2e8ba17_770232948b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313071218.729-1-sthanneeru.opensrc@micron.com>
X-ClientProxiedBy: MW4PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:303:6a::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7475:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8f1FCsfvZD6xJZodAp50EnVXlvStb0Mp014St5c5/ng0d03KoBoqXmNCNokqnYnqIyU8w9U78NCYrzz4SNYEbjDna3e7r2D8uu0l1eFeS/dMbkqhcPy6glk9titBuPGeIucyM2B17VWWE/nzewpMrn1zlOQnjSH8ACq5+e5pLcsQIsFIqeT0rt6CvrqY/U3il4nJHD7za8IYkMtUwLwzh3jKxOgYKQjzMuJZXtSwx+Pngx6q5/w3Fx6KZz67gxTMdFpvX6cKsl08h3qZGBr8ukls3Ok8TL0J9j91tyqtie4E76B/YCvd1+X7D6k01cIDJbHQXKGBquR37z80O2CN+SoH0sdreM+E1QEuWPBRE+WkzoAW4GDKi0w01UC+Q3FkFvyEtjmQI7wvja+/3tvQccWByQJx6RINrOID/Am4iM7UOkbdmIix2QchO9WJRAZAgPxYWxXyY+khuKAY7/uWlRF4lTG2p6i2gNS5plNdZJILiitS1Zty25k8i45MbxQJOrG2W6Qm0QCuXV3SConA39Bb9AERH6dZBHjiWwuoMPcBdZWRFf+r9wUxmgQ2YfuGPciXvTgT76smuZvnR8AK5SBYmhnBodczb9K8nXD4RuRA3JgkKIOqyyoLjxg4kqWZc6RpPwa9+xgJ+9/A0iPyM7OMfw5dajGpplvDZ+lmwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQ8a2ec21MTDzqIIp9WrwujqxinVg4uLy3qgU9IN8/YwTTBh07eOj448d5pd?=
 =?us-ascii?Q?+KPgqMfyjE58HeCRrqJJIoeGyEUerk1ZOR7wyLCmprIsP9YAsLe8EvMdwHEn?=
 =?us-ascii?Q?CWzSKosCf3PJbGZb71pYJbP45q0du8V7/BaWfFBG0uscFkCM0RTCsq2tFECn?=
 =?us-ascii?Q?bCdoyIe5NADKWPAxuSlq2gW8dNTC6UGyb0QGG0OyybzCiG0scT6FwlUwkfmE?=
 =?us-ascii?Q?1yjfL16jBfa7xBGT0Db3gyfGwq4swzQ4Qc+lrZ2W96tgotkqG75Gz3Wbmgmr?=
 =?us-ascii?Q?yOMfYc0NJaFiPr088o0HRwauO+56jPj29o9y8QEf8tm4u9ls5TjqXuIxEiif?=
 =?us-ascii?Q?Un7K8iC8zw5yyZX8JFp9LX7Un9b8lq0wX+bZs2C2bc9ciNvJUbVv/XdYTXoo?=
 =?us-ascii?Q?tJYdK6X2MTHQ/G7s53ch3syLg8BjZpu9bYA0qA7eulFGDRFI4OZn1BL0nkrx?=
 =?us-ascii?Q?p/ZB8OeSV26pUDZbPgl3Nts7Ed/hAozLDTxhMExg0XBT8Ql/2s2r0vRlfDYZ?=
 =?us-ascii?Q?7pb7uSk8EY4WRSjNxKq//QqalEqAVz0vcPgbcTK4zfL5Hh60EcvEYkWayMmn?=
 =?us-ascii?Q?q+HMWRLDZ0B5262JrVXZoulGoeiY7znKuD3KiwXpeVMYVs1z1/q8V/e5Ex3O?=
 =?us-ascii?Q?0aC4kan4RRmXrZpYRfoJzUUe1hmYYal8NaSbwpR3Xmb/Xd0dfF6OgS3euCW/?=
 =?us-ascii?Q?Za+aOFbI5BmbRzos2bCiOVGSW0xbuTfjcpRPxxS/jMCR8sOEv+77dT3zNCr0?=
 =?us-ascii?Q?AJX3o85AJeJdK8jieRyvoXlth4ohzSz/SXLgeWzGIFM1eycQseV5MXwhnnai?=
 =?us-ascii?Q?ggvOM7ftropX3kh4B7+kgi4fh7PT3Eo3N7JoRSRYXzRsyuTcGFRSYr5HO+iV?=
 =?us-ascii?Q?wb1RqTBh5BOi7seOfDszNzpgmK7aq3NPCRQwOWa/ThflJ+Eh2UDx/LvSwQg/?=
 =?us-ascii?Q?Q+MX2KhUK8MMGOBW45xqNh6UITjKhHpI3Lr8vrZIHl8xAm9g5qCRWpd+1ES3?=
 =?us-ascii?Q?aWjfugZ/AZCCcJY43TA6c/JSjm9BdwzOlwrWX/B4cuMZspJc6twob4Og+xbl?=
 =?us-ascii?Q?aRzblKhOxcvJ6wzmZfgL78e2uiPEuhEtZ4jtOe96hzFDaBH8SymPrzeH3+Wu?=
 =?us-ascii?Q?btq1C4Ru6msGOI/PpJgaujg2mgqjw8CeHUTZ43A8DgXyPWhFlxq9FE3wzYGk?=
 =?us-ascii?Q?56d4bLowLkmtL8OHy07KTUGeFLlzQMTLmm/Jm3DDX4ljQpfCkEXstA+DegoW?=
 =?us-ascii?Q?4CAccXw/16bRFVr0GjiEla+4zQYL2j5DAQEfJfYduPKzVT/HO+3U6BfqwsN+?=
 =?us-ascii?Q?H+ptNbA8RULf91B/IPVjTMdvXQLYfZOhzg/agHNqpkNbuarI9BQ1UXiRlQn0?=
 =?us-ascii?Q?yrqOh2jSYRqGTkoY2T+emMTQXci5QQWyxeyVToL02s0ILXW671TazAKcr2eo?=
 =?us-ascii?Q?MOZIvYEZSuiycTU6Q14MP7uF+KlUcUxl11Mdpl3UZ3AM0IeWvNq+XvjVaGA6?=
 =?us-ascii?Q?JhWcYYWgrMs7dsrCL1gCiO3fsH9Ci90pQgvxjGa4Hznp9uHm09MkZHHoX/sH?=
 =?us-ascii?Q?OSoaZ/qR1UruGewa1o9vWh9BcD+LeeHO+iMwQ5hqU7VTD2Qw2UXNdLr4BJq8?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b719c634-402c-4f0d-567c-08dc4dedae5c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 23:37:20.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRVIm4CxKlmMmbgzq0fpY20Zje2eFRW5PXg8MOi4dWY+D6LOnfrMLkvBR5CROUSxEY9Roz627whE22YcfTUBF3wCHCxofXmlYbXkfXlVP3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
X-OriginatorOrg: intel.com

sthanneeru.opensrc@ wrote:
> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> 
> Add support to expose following mailbox commands to userspace
> for clearing and populating the Vendor debug log in certain
> scenarios, allowing for the aggregation of results over time.
> 
> 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> 
> ---
> Changes in v3:
> - 'Component State Dump log' has several caveats for ioctl()
>    not being a suitable ABI as pointed in v2.(Dan Williams)
> - Remove Component State Dump from Clear log filter.
> - Implement a seperate patch(yet to do) to address issues as pointed in v2.

Circling back to this question... I had overlooked the fact that in v3.1
the "Request Abort Background Operation" command was added (8.2.9.1.5).
With that the kernel can safely support background commands with
indefinite residency. So as long as the device supports that command and
advertises that Log populate requests can be cancelled then we can build
a facility to cancel any user-submitted background commands when a
kernel internal need for the background command slot arises.
