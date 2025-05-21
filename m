Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14D235068
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864642; cv=fail; b=POOJO6uOPqPEtTHxiqKvdUUSji2X+c0MDt6ts+70atqi/upyKOB8jpD9x4xsyeXL5Q1B9UzVOJBrDIxxUGM0gM5eNSarn+sEDwOdidFhltIWcdeViXl+hmy7x2nvyg8g1UTXo8qS1xBdOixDfZYmHJxD9MYYzkPUs2a0GY/rysg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864642; c=relaxed/simple;
	bh=5nfAJceKIfI+a4m5x+eBKnpbVoaIlqXlGnIUW6gGHG0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOb0Qk7REx1rabKZNZG0IbE4saXbTw8TQzr8dEKmSUiguPDoCusa03/4lMii9T8JTL9S4AZphBC5AD0CyKHtg+MBSscIVJG4dCh9BSK3SNt5iBw+oR82DrYtyqJiT9uaWNQoaUaD8mBPwMJt8rwGqmGmnY2JAH8MCxOSJlcQKvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv4j6edU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv4j6edU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747864641; x=1779400641;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5nfAJceKIfI+a4m5x+eBKnpbVoaIlqXlGnIUW6gGHG0=;
  b=bv4j6edUPFBeiDqOp8XJIxSq1dsLsfwX1d+XuINwxEc9LIoQTAXeN9SF
   /jgLbnXUEewtecthS1hpcF3EBoTzJEWsaL382riUS96zYhE+UrNlOESni
   yZTxvq1a8hDzLV2OoDWt7Tj61/FsHoMtDIZWT6fkqHpEUe+VkaKBYwyDi
   sNcSvXbFo1TNRGfaGxtuxWuEvv8qWs6lNymaJ5MbhqOE7dOKt8n9IIm91
   ey+p+Rkzwawcjdf/i53zFzhAaDURK6aoCwJXzU0sr95Crk6D9RgBU810r
   YYinJ9S9K5l6FnGDzSyfkC07/U1Rgep56gxGNZu1vrvX4mWPVpt7rVdoN
   A==;
X-CSE-ConnectionGUID: v8RlCG/VRl636XC3zMAbmw==
X-CSE-MsgGUID: iKpkym3ET5ugO+AdFW06GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61211285"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="61211285"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:57:19 -0700
X-CSE-ConnectionGUID: pC+PYruPTdWvenpgjJsAaw==
X-CSE-MsgGUID: D+ef6b2pQgKrqQMJ+KVHyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140789256"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 14:57:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 14:57:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 14:57:18 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 14:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsQVZWTA9F81ZVvWYpB7dtNYSrImyCqTYJ/dunOGntP0ynh86ouoaBvtCNTEOgoEWYXZOuj1mioV3taYvmzSrpuVedtNO8vhHLm/Elu1uIQg/1ofLiP8pLUiqxcD+2IPar9BP1ZAkIMoSZzMZQjCDNmBfMTVn0n3c5+hbA4JJ82s744pQxCtqDZO/zGKlWqAppEbVfinLS2uVEVQxSEKuqsTAKcMVTvPlKQxG8nttPpXoJSKf23tud72gs7jRKjfJ4xl+wwdULO3VwhEBHjaEx+3AlkUN8D0EZzYmQSrAhK0sH0XNDuPY9DhQDwyIzZbcW6SMh4DZD9vFSzeCm+6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL3ZprTEMyCZZ7xjsXyOHbg6l4OBKXICxPpr86hmjO0=;
 b=kwnXbURbfY3Ki46J1/4MeZy66/ekW/EoFX/4ifD+4l1cmSAF6h59I7JajeWVQAAYnsgeYFYPRHLnj6mtIHAxkxGPneaWLQs52M1H/owsCG4Nd5P+gLJ1y3GVz1/8dnhIGMcN2poMkybVPYnDmNb9bh0/uO1RsLG+YU73h9sIe1rc7sisaWLDYbNKlj3ywdIctrHqJC6X5hg9yhDBoW8VmPPUY5NdxAPDHSDKYsdAfCbMkiP0fFfuCLoDE0b5HFLgC3RTfUmSeXQqroS0Kw4qHdcL3sw5KGEHE+zD1OoIcX8ZkHNYn3oZL6e5cEcU5fbdP3mljDIJJql2zlYNW1nL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 21 May
 2025 21:57:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 21:57:14 +0000
Date: Wed, 21 May 2025 14:57:12 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yiannis Nikolakopoulos <yi.nikolakop@gmail.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <yiannis@zptcorp.com>
Subject: Re: dax behavior on CXL 1.1 hosts
Message-ID: <682e4c386cbf3_1626e1007b@dwillia2-xfh.jf.intel.com.notmuch>
References: <CA+CExOgLYnVYdhHADBp4EEmDgfvhv81R1RW1iHGJZxd+V_1wSw@mail.gmail.com>
 <682bb71427ee2_1626e100f1@dwillia2-xfh.jf.intel.com.notmuch>
 <CA+CExOjX2f5BOVu4bAGDRS11EwLevefJ7ziPHHUSK-hCFsZkPQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+CExOjX2f5BOVu4bAGDRS11EwLevefJ7ziPHHUSK-hCFsZkPQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: d9422610-0397-4192-5625-08dd98b2722f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+AlNlDIws9SwICGO9/BGeWvcQhRGruPyZzHsggnp4ktNLe+dSYvO1gOOK6OK?=
 =?us-ascii?Q?cNTnXZtQHOB01kPnqooGOmsEBEYI2e2AWsrZ0XiDaAeZU549cDRzUhT6wwKM?=
 =?us-ascii?Q?h/Jb4JDfVib71VCvq6VMXnsiZXR2oZSF0vNwwGhAp3oqMV9AfXDVLJFM9EHA?=
 =?us-ascii?Q?/co/icbxPApYeX0fZrphS+6uPjCXGeIL0ugdWW9G/oEcXJfG5+f4JQQOjKm1?=
 =?us-ascii?Q?qFfOK4IIy78AcBZVJZVYgm+EXWxDmg2JRyTgxz6obmpz5aJy4BhUwI9dIjTu?=
 =?us-ascii?Q?TxKExzEtzVAe3+5/iIbh+ISy0ZVDWH86H0tSa3mKWXLwnSN0bKLqjR5F+KBU?=
 =?us-ascii?Q?Xme/ZiY514WDVu9jaTtBgF6FLjp2q/xDjgqbbw8fAsQkP0F7DIhMsqocfB+T?=
 =?us-ascii?Q?7SfmuT8fTkZM6+7VKe0ilLzzUn7YDNKyU1weoXuOZNkT9tl8acYcaPI8ML1q?=
 =?us-ascii?Q?Gk3wSU7qXwrIWE/EM4v9udR1zE9AETD1YmBl6lizbnfKcchiQVKpajbfYljY?=
 =?us-ascii?Q?GS9FnRl3ParZyksEHj7rCNY7yTwqPTWGLxOvL+AhqCk08fajbXYD6QgxvZOW?=
 =?us-ascii?Q?z1IQl45PkBDqlTPxngv451vVKmQWmv+drRCzVq28oGvWqb+v/vnYuV68MVHG?=
 =?us-ascii?Q?FtAft6YVMDERXlMpCgCNWPxOgju9J4ofoKwVu2Lo1aDkoqGPXDY0ESTgJdcW?=
 =?us-ascii?Q?k8TDqGT05e5K63iF8qCYMrRYPObf/lbXFPnXDT40AhVkcPLMJlZFQtQIHeP4?=
 =?us-ascii?Q?4mTeVp9AfpJtoyrzdMisGuVGW9yaln2/8hT5BmEDZztdWhLiObKHcfBRkDoJ?=
 =?us-ascii?Q?bQrFNxuml4m6U95uJp+8cf+gcW7gP+2i1tCX+8YG/pwvDzV5Gz//0OfhK8iR?=
 =?us-ascii?Q?26YyPc/8/6ZRK70UXlIjpkNEMfJjzTm2+oXC0E6WeI+L8c6N7aFRBoS9U+vA?=
 =?us-ascii?Q?yKKF7Ka81jqko+UBNUtXpDeD0I2GPgTVaztYZa1GkdhtWq5IxbuDD83bgYBe?=
 =?us-ascii?Q?Nvdkrzsx93S7zYbTbaKZalFKGq67lvnfQqPWNoIxdPIZVwX0aU+JTacjRg1l?=
 =?us-ascii?Q?ySBjUDx3KVdeNDE/EsLMIkmux6jMpPWeu10BLE2EiDtMD24OcKoOUmbQWeaf?=
 =?us-ascii?Q?hw1UJ4ZKDSb4YiC7CqkxipZSk/0yHUCNej3Knjeup09Vlf+GcGmQ0PzRetSe?=
 =?us-ascii?Q?AvMkQq2nPHoYuf+zL/r4wlSpXxflZt23hsTqE+/VxVHLAQYh5MhbRug6L/je?=
 =?us-ascii?Q?8ukp6fB5hnxL8ysh71RDvIk5zQ3gOoHtKaixRmfnm/oLQV89cDxocMr1wxW0?=
 =?us-ascii?Q?peG8tmnDIm/LCdtovygCkZvjigAiG+VUQWndiWW9KnGbQbzEtxSYNBVZ4Vy1?=
 =?us-ascii?Q?y0r1WKw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bcK3pXdbLXRqCoD8esTzl/g27Aj2F4UwoYbZ7rWEfPLnmuy55R8z3sCCbN57?=
 =?us-ascii?Q?OII2nR+daoLMvqaaSX8jDGV7vRu60qr2Ew5MRgSDlvISRbaOOJ0mGzE5bbCx?=
 =?us-ascii?Q?o5oLOEqShgIPI3wkpWHNaNXHrRtseFqZeaO9QoHD4EPWe7Z7fHVGQfKUqa+Y?=
 =?us-ascii?Q?BexzqmlLGxW8HhpasefsIKIIiI9FGrwCP88bQAD873rXCXDYbdRVZb0Pqgmh?=
 =?us-ascii?Q?cktPq7nDkOdSSwa4yYPiIw4P5ek3z0muwEvUfd10ELrQGeEsQ2QMbmMb/QyK?=
 =?us-ascii?Q?JLGgTc15UVvLghr5WK/6vFOoSNmDEJ4Iz9oS9Ca9mVjYRqkaD3/qWqIDDysF?=
 =?us-ascii?Q?j5fixeZG/mJYBspySaO1z8R9wxxEau9IarS3bHrWaBppUHTPD0WYfK9LiweU?=
 =?us-ascii?Q?xCjuoYP0cVwwDLwHZH334aOIk5KTyKFoYPGB8Z/TxIQK9zGyY6FsJxy6UuYn?=
 =?us-ascii?Q?VBaWOE6130pH/igReY/PTQUZl+/cYGXYfaW3LxHun0s5CZjEx/e93uGb7uYG?=
 =?us-ascii?Q?D3Y5JenIn7nlvYv/A4yX1SblKKhdpIIKlJcXsvrJ3RtIM/LqADtT5M8e3vw7?=
 =?us-ascii?Q?ct8/dU8KSoyrXoWKJrzprAUCVRHB3zR1dSiMQuU57EeqqRYons1WCjWE+V6j?=
 =?us-ascii?Q?qorgDkhw1aGUFUyd+J2WmHS1SAPU6qQeU/dI4iciGb0Uv7WMuxYBYdcbxmts?=
 =?us-ascii?Q?5EwTbCIRNGIUk08PUsRUKVL57ea4UQJfsCDd4awz334MRGT6jiouPOtCioQP?=
 =?us-ascii?Q?KQqw16+4WNXJ0bW7aCu7bvPJRxn668mDE903+v6Ng3oP/f5NvZ0QSOfUrIvJ?=
 =?us-ascii?Q?FwsVMlkKfafFbXqlYsUdxAekEpxmlue/FUwEUc7FPMSFDodEo7YDbYzSTaje?=
 =?us-ascii?Q?/4N/vGS/EleBSq2ZZ3F12EiJlnO/H+cdn7tPXR2cTqB9awTzzxUyKn4hwM6b?=
 =?us-ascii?Q?78+i1lIREokkeRRrfl9j237XIK8NdS58stmwv30oRAWu6dHt57rHNuiLy4mm?=
 =?us-ascii?Q?L1Ufaz3Rm6y1ZnelLb/LfrlaDtYDsY7RZrVk2MtZcW/Qem4V8BRl4U3CHEy8?=
 =?us-ascii?Q?6vAlGnE3bFFyfh4QmiVw71uLudUxBklo50148MggDnu3zhsO6S7DHeJfb8FA?=
 =?us-ascii?Q?uiyxPUQFlJwMG4dAS0YCmrBwMLFVc9VmCCOzZbPCZHdhYt16F+iuurLV9R7z?=
 =?us-ascii?Q?VZlzfPXSk+bKQHOInQn1g+4Zi7ABjHVNgDTTCukpBaRlcBCh7SMu1Y8duLpC?=
 =?us-ascii?Q?hAjlvmDFYVrqLe+l7UOhmTc+9ZHEMdVfb9Fv1pQ99DwAFFYa0XwCa9f24F0G?=
 =?us-ascii?Q?vY9tWL25t/Pa//rQ2kGBCCm1CV0ax1w5e8kOAI4ug9Z1YrgdwsRVdc4deVF4?=
 =?us-ascii?Q?xK2mxVaAWvGkPlCfF8Hutd/qKii2AqiGPgKHEO5avsXCFwlQmyxJ2fiCNbTR?=
 =?us-ascii?Q?rNbC7t9thVKWIgoK6fM7GFzBNLDuKPqXHMGKM4QLgGQNEmXNbYTUGZoy1kJC?=
 =?us-ascii?Q?3StCMwd5nWVBmeCkck409RPds46TicHffuWe+xvq10zxsc31Kwes+tUbIiyI?=
 =?us-ascii?Q?dDlzWKHMaIwLLAGibn4gUGB+l1N7/vXmiLyamaFFdY82BtgJDcJqtq0ztP0c?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9422610-0397-4192-5625-08dd98b2722f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 21:57:14.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWIkwvRWDTQ9PEXnO+s2xK2oZw7cvgh7xLtW2ByOIHMe+Uc68fNHCwYiXnHqBpX3n68r5i87GT9EjFema2MwJ7XCaYFuiSxUEoNYASmIxdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
X-OriginatorOrg: intel.com

Yiannis Nikolakopoulos wrote:
> On Tue, 20 May 2025 at 00:56, Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > Until then, the workaround is to disable the cxl_acpi driver from
> > loading. When cxl_acpi is disabled, dax_hmem proceeds to produce a raw
> > dax device. That configuration forfeits all the RAS support, but that is
> > to be expected when the CXL subsystem needs help to parse the system
> > topology.
> Indeed the workaround works as expected, thank you very much for that.
> 
> Nevertheless, if figuring out the quirks of this platform provides any value to
> the core driver and the community here, I can find some time within the next
> couple of weeks to debug and delve deeper. I can of course give more details
> on the platform, logs etc.

One of the larger known platform quirks that gives the CXL subsystem
heartburn are platforms that translate CXL HPA to another address space.
Patches in-flight to address that are here:

http://lore.kernel.org/20250218132356.1809075-1-rrichter@amd.com
