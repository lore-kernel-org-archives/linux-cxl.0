Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC501238C1B;
	Wed,  3 Dec 2025 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764733983; cv=fail; b=IRmC9mRsd82i5uNb85u5azy0kQAgnsC1ZHwytnYDJ6eJlK/j0hFLvo7AuJS3owiZpYFblu2960FQ57yO8kTTKq/h2ALJa67I+N+yoJaKoWbLhS3ryck9KorBIWE735cbiFBKlfAbG7+crZg433CbMs+I/BYH5SX7Tl2QgOMI/0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764733983; c=relaxed/simple;
	bh=p1ysYyEaYUfe/EBVHbOJXk4syGNOgjQ5XSYBpVjWjg4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fVcgcj0Wayum3dq9bQ6xOGYYJQdBfnxI/tBnC29eQjsmfMX2CiIKVbQ4W0q5mveHpMzXy0NJhrKrIPIryAaY3KCxWkT6Lb2wEWBOcvbHyp6kvoDFDsxRsuZGF1MU+q7DGljDc7nzw/EO9WFRkUnmH+wy3e8mbxPtoutLueEjf1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Soa3nBIz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Soa3nBIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764733982; x=1796269982;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p1ysYyEaYUfe/EBVHbOJXk4syGNOgjQ5XSYBpVjWjg4=;
  b=Soa3nBIzyd003oFIegTgL7hybFz8jxy+3cM+JjTRnAlpIHspgSzpNpEf
   3d9BvrmgFGIMZPw8mtJuiKDApRdFi6EpGWdvCmqiDkABV+TL3XeF0NEqj
   uT88w2+9zjdxa4pR60ynA2TtY+woSxTDkrZOLEkhfU70NC9iHn0Gn/Ep0
   yVrjfxYyj5BG5iVvIJcWgFtGQIsZrJEwvyHAc7uMEw3yrv3J1yYq0s7zp
   P1ankytB4rT6h+J83RBJ0Zo4B2/P0CqckQ1L8D7TBPVAtOvnj7JDogIYV
   tpKRmS7MDPeKgP5JtsmsHB+2aEO/9kgk1/VcQUgyPGS2hj1hFd6ga/7hi
   g==;
X-CSE-ConnectionGUID: ggoiTERuQf2K6Rgtr3k5cQ==
X-CSE-MsgGUID: CESfCZukSziqoC/4g/2F9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70577014"
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="70577014"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:53:01 -0800
X-CSE-ConnectionGUID: qmptcWBaQtalGdKIqPWgwA==
X-CSE-MsgGUID: qdMTIK9JSeKZZD3Bo7JfHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,244,1758610800"; 
   d="scan'208";a="194556500"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 19:53:01 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 19:53:00 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 19:53:00 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.56) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 19:52:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FEWwIcXITBLwJgZacyht/5ePhQCD0ym6JabAdpvCz54UWySA8kpYCvMcGbMeMkb2LHjk85T+ffLbF+PC25UMEeLbhO09tvFMeRSsn/ydtriPzQXCIJqMQCAnnXfKLiEDDTWJfVkZrv49q1mdjxcE81pzJBUAUGmsSurAqwto2Z0sITppk3PojXWJSf9F7Xk4vBwfHMVJ2l8EhgfmgkJh+nJjxtx70UljxJuUmbhVWX/4mBVcI0RPEYGo6fN1aXVWDm0YNDkfJQCwWVkxUKZvgEtL1Ms51zloNBjpuBg228c3+LzUs2x4JXWRr7KW6SveHoU0NBd+YW0C/+g7vhjv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KooigZawXAch82PlmAZsLQQtAVD8TaQodGiUiN7P3bE=;
 b=H9nUZA8/6hG6QjRrT5hToZ1jRYgax/3fof2PeXUkg411FxeXDbnh9AJyVXUqgmC7/OIbiLYyqTbn2Bu2i+Kyo5SmXM53Kmd3XaZzUx8lxc7VbeCL8PI62GpCIZW1aQmYibd6+FYh4kJwqNH/88RhQL03g8edup77lSef5HUICr4b499GP90AbL5bcIdkNZL91Y93jDR3gAsfMgNdri3tNVspSaWzjbHZ31gpS2UwnRlqKfi/aJHuTAkcRdzxFu9YD4RUdlXZrNkrDF/1lA4DnMZZHHL2FVhRA5M+cDcrj28WkWHEZv5T6uTmdX9mh0YK45A1T7o551pBhL6CHS+CKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB5114.namprd11.prod.outlook.com (2603:10b6:806:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 03:52:53 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 03:52:53 +0000
Date: Tue, 2 Dec 2025 19:52:44 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
CC: <dan.j.williams@intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v1 1/2] cxl/cli: add helpers to collect and sort
 regions by HPA
Message-ID: <aS-0DNw3Jnw4ZR-y@aschofie-mobl2.lan>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20251125143826.282312-2-pawel.mielimonka@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251125143826.282312-2-pawel.mielimonka@fujitsu.com>
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2065be-e512-427b-7eba-08de321f6f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4hCk1gcyNYFsxrQxGE7k7YD8F7DYv7dteYsVAJyZqNysgb3gjiZyGBSm2DPK?=
 =?us-ascii?Q?V6nTSvz+ZX1wBvm9m/WzIci20v9VkRFusYqPXcuetkJZikdc2pobMO7aqe1w?=
 =?us-ascii?Q?tWqpmlXp8vaQ80w9Iaw38LnDriI7s444AK4KMVNt6zddJyOx3FrFvPDxunwU?=
 =?us-ascii?Q?Mf4fAz/g4S5C6SQ88JZBRtTk50jhSASXYfWM2uMuMFnEdIhAjYRM/paWBSUo?=
 =?us-ascii?Q?XKaPV9wPGJxZrQvEEbdr18rX3BRTndDaejLNYzKmKHXzvsHG09BDOhkrw2FD?=
 =?us-ascii?Q?CBgoWj7J/JQ1TsIf52lAkR9LCHAPy+ZK9PTubIBV6wlNQ/yPTkq/aFSrTHmv?=
 =?us-ascii?Q?ytf1vbx8V2W6FnkJxqwb5y9QJw0IZOh6Ero4MoCLO9eAv0HRnw2CIfVfV6Hm?=
 =?us-ascii?Q?Qvj3mRNun0bRjWIQTsEjTYKWzmXLiahj1qeHaxyOt2ZZp6alC5/IWhrUtm5l?=
 =?us-ascii?Q?LQynuDFUvd0UZPmCGA7nXFcwG+GvQ/IyUMhhbdzSBf/sdebulmoN+C/L9DSm?=
 =?us-ascii?Q?Rl2OCVproqqRU2oyO5JMeLCu4DLxX3q8ahyHTsk0T4w9AyVaxtwH1vxSuCBK?=
 =?us-ascii?Q?xOqozDpE2O0qJJCog6LE6ed1O/pWmkSEezxIFseNNQZ0y5ZsyoFqh0r8As5d?=
 =?us-ascii?Q?h0qNWzpDYxXP/kxjrhOhaDn+xRvwtKbQLaJnFkJZ5Hson8ojmpbN0M6fqXFi?=
 =?us-ascii?Q?P3Kv/Rs8sizWdtDyYq1sGREO9jHgtZNevQZrpaELfM539LHdopJJ8SnWq2f5?=
 =?us-ascii?Q?DruBwW4mFJKgkkLGYSNtPhU8Xnqds3m61CmCLccTZ3yC2nwdoPIAUzUjLJbt?=
 =?us-ascii?Q?vC1DxPWdByUl9BnEy43MYhm5IB0oVnIBwhTEXZ9TjulotGuxKAIeCTG5wry2?=
 =?us-ascii?Q?10+UBGyidhYu14s3iICZ5h0afwomjG83g1wjUPfxefQbuJZW6ku43io+W0Wd?=
 =?us-ascii?Q?J1ef64+Ftl/BTPuppOhgfsieze3ExyiEzsd1FIUmroZLFXb2vkhLfJIBvZJL?=
 =?us-ascii?Q?ILGt8We5hVAcG2tOUBHCPjiOYDFOXha/FYEc+0Yqg3bvPNhMP9PNzJOBu78g?=
 =?us-ascii?Q?g88SsTxbsTQtLey2PiGJbylh19uW7GtUk0ZANxfuNa5hKyhYXMRG16cFa460?=
 =?us-ascii?Q?ja3KNU5JWGblIYUaiTwlM2djH69/EOe9Ctt/8yuHxger3p3fB8HlRVlsQkj7?=
 =?us-ascii?Q?rTnIddMrjxFS22fRa1A7XFesAzQKMSt0v+Dx+7eFNXZ9lLpQHYTcTl37xAUB?=
 =?us-ascii?Q?tbPuoJ7EpmsYJQJW5F/zmcBa08lpF3JG2aQM5Ibv9Z/3RYGxBqg5DuUPqA/5?=
 =?us-ascii?Q?DtOb643bFDkHRfoHCCW+REABHTuys653lBvZ22Hb3j8nxEB7RIqC9viNm3Ac?=
 =?us-ascii?Q?F8Y8Xeutzqg+QprjFDfEtiArLkb2TTp1JA2aUvY6oAA5JNSBwD/Q5wv0oTXH?=
 =?us-ascii?Q?qcQyNL42zhwcwS+bNl+clYI7McyXzSxZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rr4I+wZ8NrEjrFwZF2fiD93V3YdK+qXHbLpeF70OUgIi9tArF7tjGy/4/3B?=
 =?us-ascii?Q?7vCUNByDpMZGSR3IChjmTU7bYYcytxL5rWFO1qvNHsbx1lspNWcHcQH4LtO6?=
 =?us-ascii?Q?5nsHD8dRxItw9fK6IU5aOdkvJss1a5jhRT3EbVxps1wGMRx4ERjEkDg/pG2r?=
 =?us-ascii?Q?xa18P6NKeL7b8CpRDubBhRv8odcyeEYgXvVUSJO+QmkrpzQvtZWC/gjaaaH9?=
 =?us-ascii?Q?Z7Y02JweLNoxYSvP4d9nqEfjYJwF9WcDOTIqci4HJatBx5Zqo0+1+lLWvoa9?=
 =?us-ascii?Q?sIdDWKeVD0PoaGbqzu/wsar2GKEY2uHcpOWjxFilYVek5toEBhHceSh6Xsz5?=
 =?us-ascii?Q?FUn8N1KoaP+uKGqunsZZrJrq75PCq/EmH0R7y9Md1zU7vjH70knD5rolCV0R?=
 =?us-ascii?Q?9nsqYbaAikNVScobvQ1O386c50XqZjI/EEh+V02zAaI9OzKnpxPYOhO73Qa8?=
 =?us-ascii?Q?30umcDApgwBjsuApRRxNc8xfHXC0P48UL5TSD346ZNC9h98o5RzbMeU/5X5T?=
 =?us-ascii?Q?H4ElMiRbBc3r9/hrPIkjGlxQsmJwTTaflx7leaX6Au25R2kHe5aR9TyV0/Hx?=
 =?us-ascii?Q?qVOW44Sxbx3GEuLi4jrGKN4z91gSDivasMsvHeoVRTrBkyX6mOR04fqhc5Vu?=
 =?us-ascii?Q?L9kdQjhrV5caPipKgk+CYzHoDDMkiQHlLZncmf61ZT3wr9YsiCIxFSCxPD5u?=
 =?us-ascii?Q?A4rrsehDSbxKQHj3wT8frlda/5c3XmMbT96R1vO8J1E4/3Gfrq86koSw896J?=
 =?us-ascii?Q?7NTZ0WEPA/ixUUs796Qu2+QllyG25dMhthiveGBnYtzOb2XQmGT320Mc4TSr?=
 =?us-ascii?Q?CtQNG8AfHgfzlQiAkhtyh61ZMCBefAo62eA04YEgzrZwrCilr88k6rqPW/uB?=
 =?us-ascii?Q?2ArJc3+8op9nAXZmrFbUEpqqfGmKXMkXY4EMYMa8m17qonmg/ls+f9hLFcYT?=
 =?us-ascii?Q?H98lOQp+MRv/wMjvG/ToaOj++DCqd1XMi5haPIqs1L9q7/jRrmxJpRrO2Wzj?=
 =?us-ascii?Q?i9lZLxfzrlwrs68kK2t2PptBXqhosVQ3nRFFMg16/9lDVLBroFGZ2K0T5N+F?=
 =?us-ascii?Q?NBvtSx6+luQcQCWw7hwxROEL1RnyCKoaqb60jgSHmLwDqq1qXigRyxQbJd08?=
 =?us-ascii?Q?SgZrJMVzUslJUPwzB9E3+AQcxZPwW5u496la+DWjrX+WIL5JLhK4b1tL3OrY?=
 =?us-ascii?Q?oSemcJXrYZJuZCPYdry88+MeInBdSEddLpqLuvmjGuQsesNOFhTvyljk8o93?=
 =?us-ascii?Q?SadHkTomV50WcsPCTr9X5EhP9M+SVebkU1PVDRgiwkq9ZZxPHyadr/EhGzGr?=
 =?us-ascii?Q?lGRxzkBbtsguWopWu+rZCCVo/OO9UfAKgXSsf3BT260KbqADC4NxaG3RSEZ9?=
 =?us-ascii?Q?qt3YOi6r19kONJlpqLi6VDax+S3M8//JmLbTu0bTCVnC7llnMY0exIKWCg3a?=
 =?us-ascii?Q?M2n8f5mhYNnMWoJT0zTdIme+kQ9o1udAPoKFdQBxXMiphzYnl1GQCqZIRt8J?=
 =?us-ascii?Q?QG331NYKnBi7uptdiCg3F8IPm8zlnf93sl7gCfjBpy60ABlpz07L8xWCHoKD?=
 =?us-ascii?Q?bjS+dtzNZU15slbnOIRvCKSrQSuLOLgbdPqzaNAF+aQrR7RaTlv/LaF+2MdF?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2065be-e512-427b-7eba-08de321f6f59
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 03:52:52.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeTJ5XTZl4QknRH7cTdYeuKy+7ldW8YvkE61g1kAJuF9ZzyLZomorcfV44RM4RrCsT5tKR0vure7aTl1tqGj7W2ReVItGBCKGl9bPxdTXwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5114
X-OriginatorOrg: intel.com

On Tue, Nov 25, 2025 at 11:38:23PM +0900, Pawel Mielimonka wrote:
> Introduce cmp_region_hpa() and collect_regions_sorted() helpers to
> enumerate CXL regions under a given decoder and sort them by their host
> physical address.
> These helpers will be used by the "cxl destroy-region" command to tear
> down regions in HPA-descending order, i.e. in the reverse order of
> region creation. This matches the decoder programming requirements from
> the CXL specification (8.2.4.20.12 - continuous HPA coverage at all
> times when Lock On Commit is used) and avoids teardown sequences that
> can leve decoder state inconsistent when the decoder is fully populated
> (known problem).
> This patch only adds the helpers; no functional changes is intended yet.
> 
> Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
> ---
>  cxl/region.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 207cf2d0..58765b3d 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -831,6 +831,61 @@ out:
>  	return cxl_region_disable(region);
>  }
>  
> +static int cmp_region_hpa(const void *l, const void *r)
> +{
> +	const struct cxl_region *const *left = l;
> +	const struct cxl_region *const *right = r;
> +	u64 left_start = cxl_region_get_resource((struct cxl_region *) *left);
> +	u64 right_start = cxl_region_get_resource((struct cxl_region *) *right);
> +
> +	if (left_start < right_start)
> +		return -1;
> +	if (left_start > right_start)
> +		return 1;

Suggest calling them hpa's and using this more common kernel compare pattern.
(yeah, in ndctl, cxl/cli, we try to be like kernel)

static int cmp_region_hpa(const void *a, const void *b)
{
        const struct cxl_region *const *r1 = a;
        const struct cxl_region *const *r2 = b;
        u64 hpa1 = cxl_region_get_resource((struct cxl_region *) *r1);
        u64 hpa2 = cxl_region_get_resource((struct cxl_region *) *r2);

        return (hpa1 > hpa2) - (hpa1 < hpa2);
}

> +	return 0;
> +}
> +
> +static int collect_regions_sorted(struct cxl_decoder *root,
> +								  const char *filter,
> +								  struct cxl_region ***out,
> +								  int *out_nr)
> +{

I think there is an alignment issue above.
The filter parameter is always called w NULL in patcht 2.
If it's not going to be used, remove it.

> +	struct cxl_region *region;
> +	struct cxl_region **list = NULL;
> +	int nr = 0, alloc = 0;
> +
> +	cxl_region_foreach(root, region) {
> +		if (filter && !util_cxl_region_filter(region, filter))
> +			continue;
> +		if (nr == alloc) {
> +			int new_alloc = alloc ? alloc * 2 : 8;
> +			int new_size = (size_t)new_alloc * sizeof(*list);

Looks like new_size should be size_t to match what realloc() expects.


> +			struct cxl_region **tmp;
> +
> +			tmp = realloc(list, new_size);
> +			if (!tmp) {
> +				free(list);
> +				return -ENOMEM;
> +			}
> +			list = tmp;
> +			alloc = new_alloc;
> +		}
> +		list[nr++] = region;
> +	}
> +
> +	if (!nr) {
> +		free(list);
> +		*out = NULL;
> +		*out_nr = 0;
> +		return 0;
> +	}
> +
> +	qsort(list, nr, sizeof(*list), cmp_region_hpa);
> +	*out = list;
> +	*out_nr = nr;
> +	return 0;
> +}
> +
>  static int destroy_region(struct cxl_region *region)
>  {
>  	const char *devname = cxl_region_get_devname(region);
> -- 
> 2.45.1.windows.1
> 
