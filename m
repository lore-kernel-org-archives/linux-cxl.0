Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9A37269F
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781230214; cv=fail; b=kQjndoIgMgWv3K1XUsyJBht90BvcugTzklA09AIRih7pI0N01GdkgUo9tDPuwwsTlr2zu7cPCVXEe+ZQj4hbOBEVWwc7vH1HHxmVehfePtz//wZPzPG53nBLxN5Cq3GBjgC6+b6wvzKZEMiAPjuNhxGVsO61QrNhEx44p4FDyV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781230214; c=relaxed/simple;
	bh=1CPtAmZWNnopauGsoDJEPLko03w0evA/a6j5+mLXGH4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=go2c2aQwyoJLbSgiV/xEWU9UlqBfPG1TmE9CqFt2vPIO/b6aQ/6XbMyRYNQKALwIwCUe0Q7mMjkXhR+GLgHQp6et97bOnUrxHD8QYPYv41WcncH9NyYPT1x3CU9glFEFxK6L5FzdItWHYlHDMRfsmV3O6y/h8GwKi0/+Ue9sJ24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6hyBlI9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6hyBlI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781230211; x=1812766211;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=1CPtAmZWNnopauGsoDJEPLko03w0evA/a6j5+mLXGH4=;
  b=V6hyBlI9RNOJZ/h0xqENHWvoJ7RBrwgqcNIkZV3iVobbLVCNAtAiGNz3
   dtbi+Tv+Tlf8jA+NBSvSXgce+ire4iS2sZCKrcTqL+jj5UpXuRduTrNYk
   B+cx5baMm3PSkEKIl9dPQZ7i7AMWOzLqLM2GSZZeJgttbnYIjn3QDQJGM
   s0jX9KlpEPGw0jIGZsuSOVkyWNPwzFoPPcRKRk7kJhZVuKD+9T4u54X47
   X70oqJwBEELvvdhpcWuXNjcB/rfCHcHBJVYCJNFr1lBEhaWqFqbraHPmj
   uuutS4EWGHPFcy+xz6pgVi/LfTOBsuw3rJxAiD4IT6dTG1Ez2vrNfizEh
   Q==;
X-CSE-ConnectionGUID: xzQ4/9DJQxuPetzpAXf4JQ==
X-CSE-MsgGUID: 9UIsgV2oT+qE+goET1rBlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="69605033"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="69605033"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 19:10:11 -0700
X-CSE-ConnectionGUID: 8W/6oqqfT3+aCM+8Ech5lQ==
X-CSE-MsgGUID: 56H7A3bbTO67DyfciFdznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="245801803"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 19:10:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 19:10:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 19:10:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 19:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9ZWNhOHA9Hq79dXDaExXvres/N8r/9usXsGy4vGv16SULy4gc2vF2JTF1X9tZPGy1j+Gle9bFtBXPvGhs6UQJS5o+kiBLJeTlpNiPqjunUixFzYrL3WMkSQ0/9phapaJj12TMDohan6jB8U/mIcpU7YpStmf4tdfi9jGUiksS2rXc7pHRN6tWH9IuKrkr6hV+DIDeCUauU5w6kizgX5dFQRlX90mq7FnX3u3RY3dWF02j5g4TA/wdOsCesoixQ6LARXveyoH/KHlcST64qlXlzKFvhXHkvz6LO1bM++CnVPB1eIOaLf1GDy7etK86R7TmsVwOWmmx1T0f/z8PryrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYaGpL+1YHXAvEC8cEFVJWbq8yJs4OXYubRaaoMN6lY=;
 b=gFVu/FPn09hZedSUINzWsI3KmNABtmmqU0jBl6cbYs4v7V/dVlQX3FusK0l3SSXK8zRlR8hMdFF2N6pjsveHslS3yP+Ib0D55Tf+iC+jiWjJAhPufyqjgZcq/rNBn+joWjf+HMTX2IbLWfaKrNuaysosQWU3XRBoEkb4ogk5ieRpC38Xqp8WVEAKjbszLKZn6atbPY0fMoiGokFwD5ZvHs4aj+loNjpWXD4ts1yl612EvpqOLRM5mBxlxQ5461T/ArfQOtj+wYVSWoBPgrbIAoJxvN6XZJzEc4Blu9hQ99iQNPmd7iMbskoxjrYK/vLilo1UIBy0g1ee2epj4CjuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by LV8PR11MB8512.namprd11.prod.outlook.com
 (2603:10b6:408:1e7::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 02:10:07 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d35b:e3ac:6d53:bb3c]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::d35b:e3ac:6d53:bb3c%8]) with mapi id 15.21.0092.016; Fri, 12 Jun 2026
 02:10:07 +0000
Date: Thu, 11 Jun 2026 19:10:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: <linux-cxl@vger.kernel.org>, Purva Yeshi <purvayeshi550@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
Subject: Re: [PATCH] cxl: Align interleave decode/encode helpers with their
 callers
Message-ID: <aitqeGQHdIfKz0j-@aschofie-mobl2.lan>
References: <20260605040801.865965-1-alison.schofield@intel.com>
 <01f42b02-e050-401d-9b0f-f2b0fc6b8d23@zohomail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01f42b02-e050-401d-9b0f-f2b0fc6b8d23@zohomail.com>
X-ClientProxiedBy: SJ0PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::18) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|LV8PR11MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d69bf8-e31e-4905-0619-08dec827b978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: 22a5VkQFdtF7NpsnBQBEq/MS3kSyVwkBML7tsd7R6Oz8qjO88U816IbMk8Nxd2TMFpQ0A0ocdyPehxAdtA+H2S+4akjzLEesOO8/O5qjZN92yqMw8awc7TgULww5whCnyqmBgeDypqiG0s8HW5dNgnO6Ttmcf/1oXMs0+7ynC1buBpdWFBm0Vdp3Xe8JGqdjzQlL7+0gMw+0v1xF7HChE9QrK0j4sJ6xmpAxz+YFz1yYbEL+MjlaX7P0N71f7YoYwh9v1NWXDyvh6CezC+7FVN0V9e92c7doTMk5btgxYpPPpIg66NZsnt5SXLRb5GBmpv6CZqsztOxA/5Wvf+PzFPx0akNbavkhJjK19bbMS+guKogvzCLi2dWl4+hLnwQ8Is/KtN5hHyDqJVbntJ7UvfXh+ghmWqFfozWYLXgV+ZemN/TbNdoKVBaaeY8IhkeoynDJIeXfxTOrUrCcUUwE7FMJjsC2bxtWUDFQU6ivXmALIQZmayePavjzuMMQdtHnN4Yd7vYgZQmhxtZCVeSCUE01XMtEwk6ANayy+ZYU3WyiiOAgNmsAerS+AO0T0iRtUAYLb+tge+VVMDDqQz38PzzJtmOh6pI0zSvqiGs5g8eaDzfrFHAirBXa0cl3fLQpsZjdP8M560CRzla6JxDWwrHRg3CUt5kOgNIrDrjG0vorEnHfYnLmXBkxw8exG/FoKcz+A1Fl7TVK7a6B1uXggQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0NmOUpoNTZENzRpaXdmRE5DZHF6V1M1N0lFKzd4V1FHNC83Sk84V3M1T29W?=
 =?utf-8?B?WXBrTkdRbmZ0ZWMwOUJkQ3ZLMXV3NUVyK0VaNERjc24yQ1dRelN6MTFXU0tH?=
 =?utf-8?B?R0tKeWpJellhckxtSlYrU0ZEdUFnbXhla0xPOENFQ1YxM29jVlNyVjY0UVlv?=
 =?utf-8?B?bXRxeHhqSnhQSE5LUHZNWXNuS1Rhc1FCTGFTU0RmTU9tYWVXUUVyRldDY2ph?=
 =?utf-8?B?M0h4L21kWjVGVUF4Nm10YXp4SlZiNFFGSHV6SWRiaUd4azJJMkVUUjhKbktX?=
 =?utf-8?B?eVFsM1F4Z2Y2MU9odm0wYnphaXJQZXUyOVpNcTc4SEhlT0tkcU1MbVFhRnpa?=
 =?utf-8?B?OHJMS0wwczF5OEhiR3NReTIvUzlDNTJ0NW1pVW9xZW5PemlIZkgzY0E3MmRo?=
 =?utf-8?B?R3Z3aHRLNjhiTC9VVnNaNWlXbUVVeGw4d0JWMG1SNVBvWVdHNjNZbkt4TTV0?=
 =?utf-8?B?Q0RnU21YVFN3Z1BreXNhM3IvRjZ5NTZiRHAwdnpidmpGbDluU0NRRDYzb1FQ?=
 =?utf-8?B?Mk9WRGFhejI1bURsanV3b0N3T1k0M2pFakpSYnFMci9iaURMbzVjekpCRzBK?=
 =?utf-8?B?WGQyekFPRW9yVDZhbU1QNWh3Q1BJUUNKcWpkOTlLaWJMSjgyU3ZDOG5RQzR5?=
 =?utf-8?B?L3R6UTdZUDNNYnpQRXg4Z2ljOHVyRTZWa2lJZVVmVXFkWG9KNlQzU1lrYVl3?=
 =?utf-8?B?ZkJlNDZPOXhqNm9JVGl0NlNlSzZCTWJSUkxBVzdJbmtmczVFdGhIWW54Sitv?=
 =?utf-8?B?TzRDdmQ1YXhnc1NLWVBlUjhXSjA2cGVSNUVsTXFJQ3pNaWxNdmg2NUx1WGRs?=
 =?utf-8?B?RUw2bG5FRWx3c2hac01DRVBQQ2RYWldaczJyZ1BYKzJVL1lRWUxTRnF4Y2t6?=
 =?utf-8?B?Z0NlWFFmQXhBK3RmenVFZW9Sb3FTS1JHMXIvTkxZVXh4eDFNRjBycDYwNElp?=
 =?utf-8?B?WldESEJEWFcxRjZJNFc0ZHYyb2NScDI0ajNUSXBRQzJ3WmhaalVkdDZvZHRh?=
 =?utf-8?B?R0QzZ0VJSlByTzZXRHlxR1R4Z2VzeXBSckNaY0tKVVRFVVB1K2dOSHJkbXVr?=
 =?utf-8?B?ejJIN0xjMUplc1crVDZGZVNjQWdZc2tGSjVwMDFJTTJ4YVpwREx4c3J3KzlY?=
 =?utf-8?B?dHNrRHRWT0dFMXJpVEowSzgxdGlkcGRUMUc5RnUvR1Y5Sk8xM2hNYmdwanpi?=
 =?utf-8?B?bWtCZDJIOWNtMmdsenB4Ri8xcjNjL3VWNVVwN0QyYTcxV2FCbGxwekV4ek8y?=
 =?utf-8?B?eERmWU1udjFhTjBLSDZPKzRPaEJselVMSUxOVzBGZTFneHRTQmplcFJsVS9i?=
 =?utf-8?B?VS9LRThWZlNwY3VrZlBWSXdlTmV6ZE9hZWk2Uk1WL0VRVk5jV3I3QitQNzJQ?=
 =?utf-8?B?MlYrRXBaZjgrUkxWZ2hsUEJ2K3J4Wk15QlFvdm1pbzF1c0xYdmg2NFJ2SGdr?=
 =?utf-8?B?a2VZN01Fc253VDJqVXR3VUM0TnBOVUN0NSt4T0FSR1VhUW1VZ3dXSVlWbFF4?=
 =?utf-8?B?ZVR1MU5CY2tLc00rbHEwSzRycFByUjNFR0RaRDhoS2UyS3RJbWRkY0RsZGhR?=
 =?utf-8?B?SlZ6S2VQY0hJUm5ya0t5WEZjZEtBa1JXanRMSEhLWUNWZjRTd1pwdEo5bXpj?=
 =?utf-8?B?bnAxb3pWK1dVNkRFSXJQTDUyMXV6d1lQV3ZTVUxCcFJrSXNoUm9lSk5rZVN1?=
 =?utf-8?B?OVN5eEMvWHdwYzR5ZFVYOElRNHZRNzBLNDRTRHVpVkpNdDNOU3JveEtkdXFM?=
 =?utf-8?B?aG4zRkxEQU9ndzU4QVBXS1M4bzYxUmhSVU9SK3Q4OVV5SE91MmVIU0psY2Nl?=
 =?utf-8?B?TkRoM013VEFXeTE3bis5VHhaelFDbmZyTWE1VVpWM1pDakprL3p0ZUZ1QlVY?=
 =?utf-8?B?VThtdHd5anJFaEw3bGhsOTdSdnNyZ2FuL2pGVU8rZ0xQK2RSQndpQnMzck01?=
 =?utf-8?B?bU8vaCt0RFNISVFKcURWdVMvWS9qckxVQTJxNkY2YjExZU9iZVZzQTZsSmg5?=
 =?utf-8?B?b3ViM1c0a2F1NFZsWUt4NGd6cnBhczJKcGh1U2FWYmF5cWUrWmtPTkNSdXc0?=
 =?utf-8?B?c1ZqRXdDTms5RWZGOFhnNnRVQTExTGx3VkE5UFUrOVpFVlJzSmRSQnVmY1hT?=
 =?utf-8?B?LzZ5N1FZV0VuTnB0Tjh4SmZ2RHhBbFdBYkhjbktjQkw1Q2t0ZEhOdVpMeGky?=
 =?utf-8?B?UlpYU096UE5BZjE3TE55U3VRa05ISFZpOHVmaUNodGhNaEZMTytnRW92WEFz?=
 =?utf-8?B?TTRGV2RjMFpUT3pIMUhMRmN6YS9ySkJrV3FWeXdyenNvU2JGRk1McUloa1RU?=
 =?utf-8?B?SUw4MEFFTUo5VmVkSDlXZklVSnRxRVErVkQ5azR0b3lpZ1IwVFBHTS9oVTVP?=
 =?utf-8?Q?wm/RSnl65Mdc24uI=3D?=
X-Exchange-RoutingPolicyChecked: KIDm30sKvlikJsW7ZdVyyzC+Rv9q3FKZWZJFMHJKbVbxl2eqU+Sugu3OAuVuV49SaqHmsrSfrfZjQXNxYuIyHcLV4oRsIAHY52Bz97D/MZNJoQsu9E4vO6x/N1kahoCaHz5birf0dIVd/UQjlXFdoMRSjc3mW+JmUGEgK6j31gQ5wTnu37iPZ0KW3VOA7lwUPSENWpi2iLhTcUBnckOCFep//qKxXsf64MlQavLZIkaioT13c1phoolPVRRpx2j3y3D9NDIej+Kyfu7Ek0xJY2hYX3oon6Mxh/mTQ3D6HdInx3OFHezNJlHVXadMYAxyz385SvuWnHsV3i5LPUsJSw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d69bf8-e31e-4905-0619-08dec827b978
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 02:10:07.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDATMYhdSvjZd54mvI2jDT4rIPujEereL4tYtV3XpIh37+997diKLk2u4225UXdQxO/NybV6ctPeHoFXEW5zdimFLFw90ub2eKng1J9tAKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8512
X-OriginatorOrg: intel.com

On Sat, Jun 06, 2026 at 12:21:04AM +0800, Li Ming wrote:
> 
> 在 2026/6/5 12:07, Alison Schofield 写道:
> > The interleave conversion helpers translate between encoded HDM
> > interleave values and the granularity and way values used by the
> > driver.
> > 
> > These helpers have been a recurring source of static analysis
> > complaints that expose type mismatches and potentially uninitialized
> > outputs. Fix those issues in the helpers so callers inherit the
> > consistent behavior automatically.
> > 
> > The decode and encode helpers have different interface issues.
> > 
> > The decode helpers return values through unsigned int pointers, but
> > the decoded values are ultimately represented as int throughout the
> > driver. Align the helper interfaces with their callers by changing
> > the out-parameters to int * and updating the handful of affected
> > locals to match.
> > 
> > The encode helpers leave their out-parameters unchanged on error. That
> > means callers that ignore the return value may observe uninitialized
> > encoded values. Initialize the outputs so failed conversions leave
> > defined values. This issue was originally reported by Purva and the
> > helper-side fix was suggested by Dan [1].
> > 
> > Tidy up a related, pre-existing, printk format specifier mismatch in
> > cxl_validate_translation_params().
> > 
> > No functional change for valid interleave parameters.
> > 
> > [1] https://lore.kernel.org/linux-cxl/20250419203530.45594-1-purvayeshi550@gmail.com/
> > 
> > Reported-by: Purva Yeshi <purvayeshi550@gmail.com>
> > Suggested-by: Dan Williams <djbw@kernel.org>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> 
> Since the types are changed from 'unsigned int' to 'int', maybe we should
> drop the second parameter of these helpers in the future?
> 
> A negative return value indicates failure, other value is valid.

Hi Ming,

Good catch and good idea. Thanks!
I'd like to address it now, probably turning this into a 2 patch series.

Not exactly as you suggested, see if you agree w this:

I'll convert the two decode helpers eig_to_granularity() and eiw_to_ways(),
to return the decoded value directly, while keeping out params for the encode
helpers ways_to_eiw(), granularity_to_eig().

Decode converts cleanly: results are small positives, so a negative return is
clear, and no caller is made worse. ie ones that must check already do.

Encode I'd leave as is. Those helpers run on two kinds of input: raw sysfs
values, where the return value must be checked, and already-validated values,
where the return code is legitimately ignored. Keeping the output param,
together with the *eiw = 0 / *eig = 0 initialization this patch adds, lets
both kinds of caller share the encode helpers.

I'll go ahead and code it up so you can see if you like it when you 
see it.

-- Alison


> 
> > ---
> >   drivers/cxl/acpi.c        | 10 +++++-----
> >   drivers/cxl/core/region.c |  4 ++--
> >   drivers/cxl/cxl.h         |  6 ++++--
> >   3 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 127537628817..3b818adbd38b 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -101,8 +101,8 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
> >   	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> >   	struct device *dev = ctx->dev;
> >   	struct cxl_cxims_data *cximsd;
> > -	unsigned int hbig, nr_maps;
> > -	int rc;
> > +	unsigned int nr_maps;
> > +	int hbig, rc;
> >   	rc = eig_to_granularity(cxims->hbig, &hbig);
> >   	if (rc)
> > @@ -160,7 +160,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
> >   				 struct acpi_cedt_cfmws *cfmws)
> >   {
> >   	int rc, expected_len;
> > -	unsigned int ways;
> > +	int ways;
> >   	if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO &&
> >   	    cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
> > @@ -405,7 +405,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >   	struct cxl_cxims_context cxims_ctx;
> >   	struct device *dev = ctx->dev;
> >   	struct cxl_decoder *cxld;
> > -	unsigned int ways, i, ig;
> > +	int ways, i, ig;
> >   	int rc;
> >   	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> > @@ -464,7 +464,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
> >   			if (rc < 0)
> >   				return rc;
> >   			if (!cxlrd->platform_data) {
> > -				dev_err(dev, "No CXIMS for HBIG %u\n", ig);
> > +				dev_err(dev, "No CXIMS for HBIG %d\n", ig);
> >   				return -EINVAL;
> >   			}
> >   		}
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e50dc716d4e8..61877483cbcd 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3060,7 +3060,7 @@ int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
> >   		return -EINVAL;
> >   	}
> >   	if (pos < 0 || pos >= ways) {
> > -		pr_debug("%s: invalid pos=%d for ways=%u\n", __func__, pos,
> > +		pr_debug("%s: invalid pos=%d for ways=%d\n", __func__, pos,
> >   			 ways);
> >   		return -EINVAL;
> >   	}
> > @@ -3106,7 +3106,7 @@ EXPORT_SYMBOL_FOR_MODULES(cxl_calculate_dpa_offset, "cxl_translate");
> >   int cxl_calculate_position(u64 hpa_offset, u8 eiw, u16 eig)
> >   {
> > -	unsigned int ways = 0;
> > +	int ways = 0;
> >   	u64 shifted, rem;
> >   	int pos, ret;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 1297594beaec..66cb2293fec1 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -91,7 +91,7 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
> >   }
> >   /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > -static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
> > +static inline int eig_to_granularity(u16 eig, int *granularity)
> >   {
> >   	if (eig > CXL_DECODER_MAX_ENCODED_IG)
> >   		return -EINVAL;
> > @@ -100,7 +100,7 @@ static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
> >   }
> >   /* Encode defined in CXL ECN "3, 6, 12 and 16-way memory Interleaving" */
> > -static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
> > +static inline int eiw_to_ways(u8 eiw, int *ways)
> >   {
> >   	switch (eiw) {
> >   	case 0 ... 4:
> > @@ -118,6 +118,7 @@ static inline int eiw_to_ways(u8 eiw, unsigned int *ways)
> >   static inline int granularity_to_eig(int granularity, u16 *eig)
> >   {
> > +	*eig = 0;
> >   	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
> >   	    !is_power_of_2(granularity))
> >   		return -EINVAL;
> > @@ -127,6 +128,7 @@ static inline int granularity_to_eig(int granularity, u16 *eig)
> >   static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >   {
> > +	*eiw = 0;
> >   	if (ways > 16)
> >   		return -EINVAL;
> >   	if (is_power_of_2(ways)) {
> > 
> > base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
