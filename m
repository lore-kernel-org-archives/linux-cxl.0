Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DED7081A
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967054; cv=fail; b=us8ZhMYuUtOl8OsqmY0N50lVBkaJgh+c1MG+f1EZEjf5TOnUhUqCF8ugApx68CRry4d1VSvAEZ7/9Zr3nZepSm9aJqrLjkc9gqSd31m3QmvdXyLLpjPKb8jRVQo5Nyyowd48HXSwc8LSEEoi1yxhaSnQL70REYsvjGQMXB8oMjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967054; c=relaxed/simple;
	bh=sK4CFT9QUSjFzsIqBocQ8zNJ1dcZaq/EKr+M/LGxoEc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YMgACham+5bPz4eKeV00/kbH61SO8nHQ1gXdDbjZYLhGny6L9zN8PiE06/RzDRCgL9izXFvDHKrzKRDniQsuqGTMNPN4kOJwtRjyZQargeSXpgHlCbG1prZ8v62HehqWO6kUK4JbZUa7ANnXZ4O6qrFIVlAMZvbpUUXeU5sDIdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qeu+tfbP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qeu+tfbP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741967051; x=1773503051;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sK4CFT9QUSjFzsIqBocQ8zNJ1dcZaq/EKr+M/LGxoEc=;
  b=Qeu+tfbP6aOmy/NNyQ0CxAsTYmrfC5aNa+3RhlNBbTXcKu/cQ3lWMi1K
   7izeUw3/dJOTeqYLdwjEDFQ6oitnPQV2AKKZrWizmmPM0dfN9D9Gc6Kh5
   Q1Wo4jn6YXvKo9Rhk7JeIY9DC8dnCWsoLjvpQRL4MoblCyr/c27lcp7/m
   i76mD3RBgkfSNGiiKkWeSpYqiqXKG9b31shDsweUMVRvf8dyQ5ntKeNml
   NtxpNOMZBAIUv6VrwQC6eOS0kPWPdVfmtzA3YuIeBbb4K4hCboAnZU7M+
   NNyASsyT0WcgShFWDMFo0pz4xVnDtlJ17nixLKgpMGZ41mYCIZcB/DQKi
   w==;
X-CSE-ConnectionGUID: rueDPqc9RNObM3iTzU2QZQ==
X-CSE-MsgGUID: 30vfSqAdRwu1sZWVxuIiAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="30710770"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="30710770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 08:44:11 -0700
X-CSE-ConnectionGUID: MpDCEPq3TCOmCiLfraCDYQ==
X-CSE-MsgGUID: jmseVQf2TbSsrW55EpgN7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="122034698"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2025 08:44:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 08:44:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 14 Mar 2025 08:44:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 14 Mar 2025 08:44:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y48Hnac7RnaU8mKhUEeuugpaflibjehDdP7c/EdmScizQnwhHjialZp/+3BnjdTyRKMCqI+BFBy+49xWZANVX9hPawXGa2Vg9PRXfbdSA1cXY50/ienF/QrXZErSp//1HZWPgnQ5EE3K+2fIk6J8qvdtylIWoQsCyVr9sH0InZohfJgzNhHxXLvBw515xfQK/YY6EL/2O7BHYsTbtYnet3CZ8GfGMx2pz4pr+bSvpHvj51B5/pSOCAAw+m67yEelN/mZ2OQZOixJX4JqnAwdCY2lcmsg8zeXdIPGp1M6C0VRdrzWE9Pa1s8zQtK6e5GFaGlzU/mNF8Mih0U52FGO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya9iIqy1/HYEn0AskArQKxvduLtal4uhLWFwMYmzzgM=;
 b=voVhFtEfLArNd1JlBJMGq02orntyJv59oUXuIhkkn1+D4MqEBKS+wi/loXxMmKM0wxZsI6n3QZpH6RK9wcjgb9YF+x3k0a4SrhaIRNnYF6U+p6PeRbJTr8EkYtohshPav5fddOKNW4dRNwRC6Ik1L4iMW7bJiYs8VkUtwTKO7CSBcjC6U52hcJTQI5et6qgapl2guZ2jUytAEKHHmYiNS0KeDXzK8okorEEh+cKS3Gd0SDeB7M0q50exrXe3xgtbr9JzMnARjSjjUteuOCs5CAyXdU6l6AH9hP8SFaoqRE1brr0NtMWySnUj/C5iVbMRV+hu4g/mjQ4Ccj2SVzxe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5132.namprd11.prod.outlook.com (2603:10b6:806:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 15:44:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 15:44:08 +0000
Date: Fri, 14 Mar 2025 08:44:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
Message-ID: <67d44ec5a79c1_12e31294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
 <20250221065509-mutt-send-email-mst@kernel.org>
 <17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
 <20250305141359.00001288@huawei.com>
 <4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
 <20250312181035.00006e32@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312181035.00006e32@huawei.com>
X-ClientProxiedBy: MW4PR04CA0323.namprd04.prod.outlook.com
 (2603:10b6:303:82::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1e93e5-9cce-4a6d-c622-08dd630f0e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mis1ZXV4T3lLZ05INDUxVytIUCtyL0FmVklYUE40MmpFMEdURjFXRitGUW52?=
 =?utf-8?B?ZzZlb3ZKMXhVSDN1NHpYbEpjTmlBa3hEdTBKenowLzI5Z1JCbE1MWGRvcjVS?=
 =?utf-8?B?RG00QlFoQ0RsVzR6NUlrRVQ0TVZMK0hjaXkwWUFoUk9TenNWUkp0aXk3NEtS?=
 =?utf-8?B?dk1xWS9pTytvUVYwRVJBTUpYNEptbjlIWGo3VTRhdUl1ZHRrN3U2QkVYa0J3?=
 =?utf-8?B?Z084M1pjbldTR1NxWGdLN0RjT2kvSHoyS1FwaGdlaDh2S0VkbXg0bXZKMU5P?=
 =?utf-8?B?SExqNmRGRzRDMlN2RXFKekJST3diK0x4YWZSK0VJd1daSDNKRjhxWDZrWE9E?=
 =?utf-8?B?Qy9YdlcrWUhwVllLTTdPemlNRHk3bXZBT3FaTnY2NVpmWXFiVTduTFYyZXpl?=
 =?utf-8?B?OXd3TjQ3TkE1RnRRN1kxMXZ0a1Y1VzRSVGkzYmpWQkYvbE9yaVVKLzdDMU9L?=
 =?utf-8?B?R1kvL1RTekZsbVZ5QnJlQVpweU5samVVc29WSFVwejJNd0J5YU5xNU4wWVlo?=
 =?utf-8?B?cHFTNzlpN3d2TmVqT1FOeS93bjVKZU1GNFVMTXc4OUpDenlkWWRON3pzK3F0?=
 =?utf-8?B?SncrS0xkSnlJV1lsTlhZeExxdEZCL2NpcEZaNGhYOG02WFl2VW1PM1huS1NR?=
 =?utf-8?B?Y3Q3bDVBNHdCcUdVK0JNYnJOWVVCZ2RCWDVCSXB2dDR1cXFTTnlNWEdZM3kw?=
 =?utf-8?B?RStnNWpia0k2MjJFR0hnVjdCT3lsYy80WGJrWTl6Y1lneGduZVBuQlNVK2tP?=
 =?utf-8?B?bmx3b1VteWU4NlNRTlpOcnp6Q0dOZ0dFNGpiSWgyZ3UrVXBYaFVDSU5EOTBn?=
 =?utf-8?B?Q2JScUYrcER2TkxwS2FxajBta1lnZTdYUWhrTzk4ZlRKbVljbUdHL2VJYVd3?=
 =?utf-8?B?RXZNZEE2bzF2NU4rTll2OEVjZFNiRjFOekhHelROcEhoK1dXaFp4TTFnb1ZK?=
 =?utf-8?B?dTRIUlJQTFpjQXE2YVJCWEh4VUl6d1JDdzVWSDA2aXErb0JOWXZOU3VQcmxZ?=
 =?utf-8?B?cTlCM1BOMUJyVEF1eGUvZlBJL2lVWXpDeHM4OFZEUUROQVlEOFJ4WWgrTW0z?=
 =?utf-8?B?ait5ZUJqRUw0dzVKdUVyaGRzVkFOR3FDVFNkRDFXaU5QaHEwT1pGUDlMck93?=
 =?utf-8?B?R0hVTE11SWs2Wk1rOWxuYVR0THlkRnpheTZvQkd4eVBxNlpHYlhudVRxSlc0?=
 =?utf-8?B?K1BTMFFPem9uSHZOdVlXOVRNWXdQSnVsWDgwM0wwOWlZVGtnUW5rUDdWMVd5?=
 =?utf-8?B?SDlyT3dMQ2N6UnhHT0dtWitlVGRPdmZZNjVMWlFIRjlDMlJwb2Q2aGc0SWJr?=
 =?utf-8?B?YkJqeFd3bGd4am85UFpXV1VkMEY0YkpPdlp4Z2tzdEtPU09rZDhWQ0QxUENj?=
 =?utf-8?B?b3hHaEt2YW4vR21pZGczVjM5d2dsYXJ1eEwrZ0cwMXlnOXpPNGtQTzViMEg3?=
 =?utf-8?B?d1YrUUVRY1Y3MDhGZUpCU0J4ampTTnNPU01CSjF0MEdzQVJYUjhyeTNwdHRC?=
 =?utf-8?B?R1MwTEZ5U1pIa0pRV0NKb3BnNDJEUUNNb1c5Y3Y4eU1UZnFrOFB2UjJrVmx1?=
 =?utf-8?B?NUN6SHgwQTdjZktRemVyL3ZFWkdqd0RzanB4R0YxbkgyOUNobFh5aDRaTmJa?=
 =?utf-8?B?UU1rQWhlblNHai9tbFhaNTREVnNOMkxOc2xGaGxUTTN1V3hsQVExa3l4T056?=
 =?utf-8?B?Y0tEYXVtU0RXVjNZWTBBdDVRMjBIOWJ4SU8wTVc5WkIwUTdvY2VacXFQRk0x?=
 =?utf-8?B?N2E4cUx2bHBkYXZPemhJNWgyUllmTmhzQi9PZzA5c0NFbFo5TnNWdmdWV1lY?=
 =?utf-8?B?OTRkWW1Tazg4b052QU9lZEtOS2g2b1RRekg4aW1IcHJFWldGRSsxaTVGN1c4?=
 =?utf-8?Q?IQcCQecV7nm6L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVRJUm9WVXEwaGJwMEk3UURkWWtXaEhWMWRKU0duTHRIbVdLTkNUSE1PRXFB?=
 =?utf-8?B?a1NxTGlldFRneXRZOFU0SEg1MjFaRlJ4cm1jQkhKU0JGU0g4ZVR0eUROMDRN?=
 =?utf-8?B?K2VmckYwNkNLSnBFTG5kenhuR0tEaXRnLzZhQ05nRnhlZ24rL3cvaGhVaFJZ?=
 =?utf-8?B?Wm43T0pVaXZoK05KMERmM1VsU3VWbEdEa0Qza2VjZzNiSWg5Sk1vTVBTay81?=
 =?utf-8?B?VTlZWGhkd2o1VXp1c0ZVWlZ6bXh1b3dTUCt6RVBwemtrNTFQRlF5OFpKWVYw?=
 =?utf-8?B?T3BOS3lHbndXNEQyODZKNGtiSThtZytWY3NqWGtUQmxJRnNheTd5dFh5SnlU?=
 =?utf-8?B?RnhIWFVrUy8ybXhEWTZNQlc3NDFIeFZzU1BnZ1QvS0tRMDVzdWtnWnJNZ2Yw?=
 =?utf-8?B?WVNUZTEvYjRGdVBoMEZGZVdjNjNTNWxvR1dyRW5pdjhDNFlwLzA0OE9KeWRU?=
 =?utf-8?B?Zk5rZDNMOFJ6V3VCUENMbnl1cHJVb3c2WlZxdXJpYkxUbnFab0VDQUJlVHpN?=
 =?utf-8?B?S0QvU1Z6dVE4cXRNZnZpVnNRdjl1OTdHZWV5Y0xlR0NZMDdjN2EwaHc0NFBl?=
 =?utf-8?B?aHQrdzdYK0FYY0grcmVsWXdYRWQrZlBaUTdsTk1vWGFUMXRTWmFHV1dtZWhi?=
 =?utf-8?B?c2FRM2RpeUdlSitlUzdjRk4xUzgwdUt1b2xsT0hGVlZCUE1aY3RxS1FLaVVX?=
 =?utf-8?B?WCtwUTRhVEJLbU9PVnRqUHdGek8yN1h0L2Rxa05pekdleEdaU0REN2Mvbnp1?=
 =?utf-8?B?SmhERG0rWXgyNWhtTnZuWEFnVFlvcDVTb3Vrd284djBhZzQyUjNSd3FFY3pJ?=
 =?utf-8?B?dFVOY2FGYWFNOVJ0ckZxNVhLM1M2bm00bnl4V3ZpYSt6ZnBlcGl1M0JJMkxS?=
 =?utf-8?B?ZjNFQWJLYjFlZE1qcHp0RGoxRmZsTEttbmFTL0h1alh1TmZPSVd0OUJPbDVG?=
 =?utf-8?B?bUV4L3ZmeFE2R3hmQmNwWlhYQmwzZFNHemxCN21KelN2SmN4aGV4eUU5eDhj?=
 =?utf-8?B?aFlnMG9kOERRY1hNQ3RkZ1M1NGptWXByRy8vdVN2RjRWakdaNnFxZGlPUHNY?=
 =?utf-8?B?SlY1NDJ4ZUJEOFl4Rk51YS9yc0VEOTNrWlQ3Q0wwUkhkaDEybDhKUzZ4aGdT?=
 =?utf-8?B?bk1rUi9zTkY0QjJWRjEwbTJwTnRtQUU2c1ZyMTh6S2szTnBZNWk1NWVDT2xS?=
 =?utf-8?B?M1VlR1BhM3ZKTFkvTnVzYm1ETTA5emRiUTJsbWZxTE1NRXBpVlBjOWlaTEJt?=
 =?utf-8?B?eXhYWlJvQUtZa1dRYjdiZWZBV3VKSWM4cDBoUDd4Mk9KZEwrNUJicEt4eVN5?=
 =?utf-8?B?QkZrZVphL2lpZzNVSDJacjRRQi8wYXFZWXFuR3JkV3hEaTZ4aFYwQ1VIZUdN?=
 =?utf-8?B?c1ZOdm1xMmhzVXIvQ1RhckUxcDV1aUgxY3RkQzhuZ1ZaQlFJUTArb0ZEU1JL?=
 =?utf-8?B?Q1RKY0g3OE1YTU0ydWp4Q0U3M3psaUNQdGxBcGVrM0ZoWVZaUW5jdUVaTWZO?=
 =?utf-8?B?bWJWakJaeDBvaXAvSlVYWFdPcTFSd3U4ci9MdlNTcjV1VEoxZENvcG93S1lU?=
 =?utf-8?B?WUd0OUI5SmdWdXFJQ0NNWGdpWG00WjZaYVlIaHJsei9rUzhnMTNIRk9FSFNH?=
 =?utf-8?B?a3B2RDlRNjJYR1ppN0dRckU2ZURTNWZ3QnVSd3hRMmVyR0tkVTdreS92TDhl?=
 =?utf-8?B?emNwa1M5eURsM0ZydzhJRW1nL0k4bUpCWmYvMkd3SXpNV2szY3QrTEhyWkFp?=
 =?utf-8?B?R1ZPWXVpTTJTUE1sL0lGL0hkOXJ4dlZ3UjJaaDJBWWtHT1k5THRBRVF1UkZE?=
 =?utf-8?B?MmphUEljZlNjNDVuK3IyUXo3UzIvc3prcTdqenRkNkpwU1NrcFcybnl2Z294?=
 =?utf-8?B?Mm16Q2NuWWZBc2lNazFaRDg3TDkwclZzK1hSWnRjNFp2QmFBaHpLZ01VRkJJ?=
 =?utf-8?B?M3dzUTdMeFR0cWZTMWsrRlpUdU5EVCt2ZHFFNjBrM3huandtVWZMeHFKcjJn?=
 =?utf-8?B?dXhPSm02aDBPZzFxV1FyekpjZ3Z4VG0wU2V3TmZ0blNEalRVRnhsZ0dyWHg5?=
 =?utf-8?B?aVM2YnpzbzArTlJLVXY3WGwvdWJ6dE9KV1BZM2hkUktZbmJVRjk5dkh1ZlRn?=
 =?utf-8?B?MFlRcjExTzNYSThCZDJEd09ZTmhjSzJtS05vM281Qmx6YkUxQ2JDQWhBUzlM?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1e93e5-9cce-4a6d-c622-08dd630f0e95
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:44:07.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/0QOuSun2GYOEW/VotE/VXalQ7B2DoAqMpXqTkF8tnh3bOpHVgUwXzpHZNY6tRb/mkm92eouWCZz8Os6ebaaTyWvVwd+SAWoDE/DjwU33M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5132
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 5 Mar 2025 18:35:40 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > > 
> > > On Tue, 4 Mar 2025 14:22:48 +0800
> > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > >   
> > > > > 
> > > > > On Thu, Feb 20, 2025 at 04:12:13PM +0000, Jonathan Cameron wrote:    
> > > > > > On Mon, 17 Feb 2025 19:20:39 +0800
> > > > > > Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> > > > > >     
> > > > > > > Add serial number parameter in the cxl persistent examples.
> > > > > > > 
> > > > > > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>    
> > > > > > Looks good.  I've queued it up on my gitlab staging tree, but
> > > > > > Michael if you want to pick this one directly that's fine as well.    
> > > > > 
> > > > > See no reason to, I was not even CC'd.    
> > > > 
> > > > Hi, Michael
> > > > 
> > > > I'm sorry, this is my fault. I used "get_maintainer.pl" to check this
> > > > patch's maintainers but it shows "No maintainers found, printing recent
> > > > contributors". 
> > > >   
> > > I usually stage up multiple series together and send on to Michael.
> > > So it was be being lazy for a minor change rather than anything much
> > > that you did wrong.
> > > 
> > > If I get time I'll post a series with this a few other patches
> > > later today.  
> > > 
> > > Jonathan
> > >   
> > Thank you!
> > 
> > BTW, I found a corner case in CXL numa node creation.
> > 
> > Condition: 
> > 1) A UMA/NUMA system without SRAT, but with CEDT.CFMWS
> > 2）Enable CONFIG_ACPI_NUMA
> > 
> > Results:
> > 1) acpi_numa_init: the fake_pxm will be 0 and send to acpi_parse_cfmws()
> > 2）If dynamically create cxl ram region, the cxl memory would be assigned
> > to node0 rather than a new node
> > 
> > Confusions:
> > 1) Is a numa system a requirement for CXL memory usage?
> 
> Obviously discussion has gone on elsewhere, but I'd say in general it
> would be a bad idea to not have an SRAT because the moment we add CXL
> it is definitely a NUMA system and we want the Generic Port entry to
> allow us to get perf information.
> 
> So I wouldn't mind if we fail CXL init in this case, but maybe
> it is worth papering over things.

I think that is too severe. If a driver has a path to advertise
resources, even in a less than ideal way, it should make every effort to
do that. There are plenty of ways for the NUMA information to fail, that
does not mean the memory needs to be prevented from coming online. Let
the end user decide if lack of performance information is fatal.
