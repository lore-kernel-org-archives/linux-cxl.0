Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5CB3A1E6D;
	Mon,  5 Jan 2026 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767654401; cv=fail; b=JVGak6btUg1YsnYsXokT2W5NrBMQdB92xx0mTnMWgCgP2b0ioWWzKrzaD82kgm9i7L9Y5AXe2J9OWMdQDIg/W3ggCv48dddcxC7z8o6VZIRNXxSIlGW4GpbNloc6kU8DBNwvN5qZrPP6vbbdyvUFyyRRU4SYLka/KfFNZgjOlv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767654401; c=relaxed/simple;
	bh=C1E1mvKTTzE5q+HGOHbiq3HU+oDuaWeTieRI7b8RsSo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pWnguSy3wdbfWFnFfxTfoSAK5NHwTO/LZ9g1/rmX5jISVUMnhGpBzEU+mIK0zqRzP8J2YRPxGTUDu+epj0YD5ZAfiSEpdUyyJymnVK1GHXd2H3yI/REnLRjTJ1BpOZAXbQZAnle0O65sgkd3XMTSxPQxQS7AwySNP7N4kR0gYwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejDKmI41; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejDKmI41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767654399; x=1799190399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C1E1mvKTTzE5q+HGOHbiq3HU+oDuaWeTieRI7b8RsSo=;
  b=ejDKmI41LsD+ZgeDnbEE4jXgSWXoIKZ1ag2dQF/rS6px2o5B4YnGc/0u
   +SeLV1wROg9w6cSIzSHcTT2dlSKggE8jA+1oUdylNKwiMCNBiuM4O/9Ze
   FGJ2m41wbN9Jisq2aNnG19ixYMqW6bBQrES4rSIREPQx8kWn9RfXhrtT8
   ZdILUbbnq+8ZfQKgHyj2yNy96ogq28pFHiprN7HGuflZ6JVL/n0VvgG71
   vStHpu5Ykcri4A4f83kJqKaG2Pd75wfIplgRmLZR8c9q198XhVeX/tzjI
   IwC+Fuh4dhvB0jmtn4aiOmkbAqpZrs/LcwP8MljzZAomDBIDk78KS++ji
   A==;
X-CSE-ConnectionGUID: xOZYF8u1SxSXOVlZdPBw+g==
X-CSE-MsgGUID: G/G0llMFRQGiUjbmVQwbJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79329186"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="79329186"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 15:06:38 -0800
X-CSE-ConnectionGUID: smirXG8+TZS+oAqHZ5WZNg==
X-CSE-MsgGUID: gydLVS8gQ7iZRA9yEpbhxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="206980095"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 15:06:38 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 15:06:38 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 15:06:38 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.13) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 15:06:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suZA8SPGZJ25cIQmgfbwFr2l93M37CMFRu7i7P68Eu0oRMaL17FJBdOKOrwoS1ndwvC81h9sGc36Yto0kMbtOZph/pAf9KWG7etV125qmXpVAVGrcT7vRoqSevPrjvgJDxmlIdnQ/mY64C9K3kEYuVYRIyWvsDnKNaVsrGbXjmokZyKmHDYJnqfxlC/laT3vCpaMe8E9ll/JhjICzOnN0KZNp7i6I16Az5Mkwu7oMrcOjdHS0JRcjTvkRKy9FVT5m2Vuaqd20qb0uhx4Pe+u2fjZGOD/0ybzdL3GBpbkHHR/ZzgsaRp+LwqoOVlXn1uRVPXzRVye3nVKaTnu8eaBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD2lKCn/7fUnKWYMzxLbkV6usqB3O1WiIer+FRvIqVg=;
 b=x+oX2FTTJf43lgOwfT+R0j7d80N5HzfUKkJ6qxBh6BGmebjvL5rCCqsxJCt4Sn6c0gEyaPberSwLqNPSdzc0plIh4q1Awd38Iy9vwolvWyE1XwlWfhTGn++m0PkpWvycXtCosiPk/RhTqZIfSeZRMg4nObJ9l2m2X4Mokf9+/wK92pYsq1cmju3cW8st+wos5kx5eTQxcWLSDnP/bB7iEWa3Bx42elqcqS4uLsA63i8nYSI9baYWUDXHiTt0yf2qCjKnGC1O/Y5iazJWR3Gu33oUUP2fACuKlKEjELemcPHudWJ8lPTaVo65JBcZyzPC9QHq2jBiVL2ExiRIlAgi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB5879.namprd11.prod.outlook.com (2603:10b6:510:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 23:06:35 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 23:06:35 +0000
Date: Mon, 5 Jan 2026 15:06:31 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Arnd Bergmann <arnd@arndb.de>, Gregory Price
	<gourry@gourry.net>, Robert Richter <rrichter@amd.com>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: fix format string for resource_size_t
Message-ID: <aVxD9203_f1T6fG5@aschofie-mobl2.lan>
References: <20251204095237.1032528-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251204095237.1032528-1-arnd@kernel.org>
X-ClientProxiedBy: BY5PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c62bcc5-b1d3-4133-0780-08de4caf12e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sj9dujcHfUTHDnAqoaGhLAWbsYDhoWlB+i0HMkVwcnfhU4gdFbdiaCVGuR7E?=
 =?us-ascii?Q?zsn/z9+GMnSLBNcShcOrC1ICmxWPeg+BBfZzDsvEsEJxnf52/+GUIfInslNZ?=
 =?us-ascii?Q?J5zO7Nil7aL8wecJhqNkTxArD1Ar55PD0G38N2Ujdg7eCCL/kR5bNIRM5H31?=
 =?us-ascii?Q?VrVIvBuwczD9KigTiDTfv/QVnev9iW/OtCWaiA2XJLi8IplyDq088YFHvD8V?=
 =?us-ascii?Q?R4ir5HHpFGeKoyfWM7RFrc0cUyDGwJkuAkRaykHhW1+u46SUfRJO82U53P1f?=
 =?us-ascii?Q?/CefLtw+CYBQCjNzPC0baP+bQRcxahqvNSqTBG9AoQL03e/uPXjsfdU1RAkj?=
 =?us-ascii?Q?aDpeJ5lv9FCE4jUMbLOHxk+zWgLRKG+ogcRUHJRZd6Rp/mWDJE4wYyIaMLMS?=
 =?us-ascii?Q?T3ZwqMVf4NjVVVQuVEvFZfGhRIvfR3r2icAtGu2hHKpy5p7HyWegaQbHQKPT?=
 =?us-ascii?Q?BW6mUxnqzn3TyX8nJDaYqiarYgXyDqzBQvtKOf1YoCkILWnMFz1IKEUWwlOO?=
 =?us-ascii?Q?L87Gvwh6rC0vNow2xd5StEg8NAteHQd1ns1kr7cjXbfHxUYBsPLkXdwWNihL?=
 =?us-ascii?Q?A0PP0OnMBucBqn72xmitbo7Wkb2WhZCTmRQzlI43kqf+U8cspWSrKkB9kSuB?=
 =?us-ascii?Q?jPrPnH9cuWjvMkjxqgDnaWDUsY0rUaDRP4vu59tUIFF1yj4skIos/dPnVFIS?=
 =?us-ascii?Q?hMwZCUHUq+TG48hr9iyYtTSzUpTq+NNX8FXYVRJ75bDjC4kEmuSTp5TfzZKF?=
 =?us-ascii?Q?PhvVF5B3dt3VBVGP/jE748g6ezui37q7xjiFUoulnKQosdd7K0dl0P7Le9kz?=
 =?us-ascii?Q?9jizRSrB2fF2D6e99piAsZtgi0WTsy1kzH3XfdrOZKKJTA31rlOOnllHMsmK?=
 =?us-ascii?Q?gTDySovT2FSS0C+mEVfWHt0idkLjmiltIbwzwPMxe5noyYAH3jx0O32n4cpx?=
 =?us-ascii?Q?6Kp00v/u7C6ky4wob+2ltN0Ha6pYHrtDHWB3/CQO/2XhDd/mkMEQamiqhx8T?=
 =?us-ascii?Q?ff3fyljrEQ7KQhP4Rlsae2nrug6o50pcxrisbu+V+Ln2EFznCYxjfx2a5SYv?=
 =?us-ascii?Q?hUYnSTMM5adjOuKTOsHye95wyvd5G3Wke46JG6nhM7W4r4ai1KKy3V+53WyM?=
 =?us-ascii?Q?TXjQeJNxh8SyZD02RzMfigUKdu9BN917AXEX2Hgt7IpYFd9UfrjXqB5lM58+?=
 =?us-ascii?Q?4xMmmlIdZRDaCUpdf+PhRtWJCTn9wncEc0RXXjugfo5k4ikCPN9WJAiJAEkI?=
 =?us-ascii?Q?nb70kYA3WeUk8/9YC6JIrlYQGlJAjEsPhzKN3UIiKt4YtQ9pkknBXa3Kz0MT?=
 =?us-ascii?Q?+14XP2lHJajB90RpH5GlLnusuptAnSZ0bq+j78WPs1za1ZcTn7jxvvVfnRMZ?=
 =?us-ascii?Q?/ZYHseuaxR+8y/iZsE14kwlEsu+0ZzS3YPoIj7a2wwhYjQXTt5jtLmNNVxXs?=
 =?us-ascii?Q?+eXSaoM8B6wrxiUuEQyp/sBk6CQpIVM0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G64jYrnah9KkLRBisRtWO/PrgqasnRCfg2zPxuK9Fi9Ly2xnzuYxr13akf/K?=
 =?us-ascii?Q?N1oPjbktJsEy0TX9ngkpjmI+fieOTOtYnzY8WS3VyNdk/sH+re+b8BgaTB4z?=
 =?us-ascii?Q?DeV/wsd5KZvlIUZ4EVRJFpqLPhAaSYIRUI/rhsv3M5GGA1rZqmQZZop2gUYV?=
 =?us-ascii?Q?KC69I7PBTP9O7jFTgF9NHgWsrDDLg62UVKsaCVmA7HvWC1407xYM+f7s6SjT?=
 =?us-ascii?Q?s97oymx2pfK6s7hgsCsMsJj9Ov8So8uB3JPsNUz69tgVcqpOBcbujrAnuVQ8?=
 =?us-ascii?Q?jkuKfpKw93xsZF7lTVvCneALf3ErBKX4dD4J9mU2aAM2O08ElBAsZ4xRMV+3?=
 =?us-ascii?Q?GK4sxVT6shJ+j6nvPc8e3W/P8lnbgW7s8uK0ATSUHZpjQl4ZN8lI2UP9XAGb?=
 =?us-ascii?Q?Lu8nHLkiqNbqyoy6rNIBERePceeyPv55oTBUVR2zBVuXeN9+ZvmB3zFZU5Qh?=
 =?us-ascii?Q?O+LNxmSAsEPiWWhzwdK2ALwZb03HYERqk56fwa5N8WcAuC9E1lVDey/unLD6?=
 =?us-ascii?Q?L0/x4aLOGf2NZv/UpQm9U2/sBir144DsZg18ljYmI3vHmksKjA4BqERUuViV?=
 =?us-ascii?Q?fJ45wD5TK1P47g0r1DNLpdGM+dc0USSw3lVtIfaY4uzQJxgCO9wd36mb0HNR?=
 =?us-ascii?Q?1p/cEnei2YMJJkwmND4+B4wSGM4piRV7j/ORG7a2kUGzEufC0Ti8QWscPtT+?=
 =?us-ascii?Q?u1EPr1lbWK/HoR3B9PBix3s/ciI3rx5aEPswx4E8GcND7hVOOt1vPBCrGCCL?=
 =?us-ascii?Q?174ltUNFhgwZfoIwGySlz+QV2jXXAAN6HV5Ijf0UH1fJRI0bLdEgY99GYn+L?=
 =?us-ascii?Q?vKJYrZVsB3X9vff8f6JOc7B7a9Z+O0CeTN/exsGe6aoomJzBDQ50Bm9NlU6A?=
 =?us-ascii?Q?io6JVsdJfH0JjMjzoP0t+03r3T6UavHGv1LwvyLEDvZ3xsJ7okiV1DieeWWO?=
 =?us-ascii?Q?C6vFn17xObfqkibzmMdDC4GRdSna2O/4h8ZmzGtb18BtOBmlHCKKCxZJpO+B?=
 =?us-ascii?Q?nnePoZ7+jjX2fRgg8sfafyIH3JjqcFPUWJDYiPJmbe2E184pe7M7q+Rw93cW?=
 =?us-ascii?Q?qraGM2eEM/mWDysJJ06jn5eMGJapzfF7g44cpopT0Rhd1fsJzdWEb2ApxIgo?=
 =?us-ascii?Q?CntD6FAEVhvqJpY1bo6VSTuRnaisss9xZiCV39gCwc9ldht6CO+sr0U9r7ZL?=
 =?us-ascii?Q?glO8I+EW1UunEDazQ6+zG1TCD553R8ueVbLkt981+s/55wvvm1ifIGOYZmNY?=
 =?us-ascii?Q?Zoj7Do+ctBHxXI4xN6i7Frc7OtgtgXjJ1L3s/ZKdpwBbc+oOPL0J/eRw8a/6?=
 =?us-ascii?Q?6TvZWiWSIlIVGcQgFdWxBAxxnvgashMX5gBGbQCyxdN4asp6aOzxJF4OWL8X?=
 =?us-ascii?Q?cW6cufUlFI9/HOO5aw1JIsKZVwN1bEfN3yCrtfJ3UOtGiJKJyicQgHCFG/Gz?=
 =?us-ascii?Q?Yt0Cx/ZBJx7Es5z25n2kq9A7c6j8IEFguL+RjGxgU78eSLecvWSsWv7JsLRQ?=
 =?us-ascii?Q?YA/IqTW7wiVYISZ39gLyS8V5j8nVjF4kcAI3B24mXs3KFzxDmAPfigMhqYL9?=
 =?us-ascii?Q?U6lO6dFYTP4glYNQ72xFTmAErLmRM5L0UBiqDZDo40l4a+PsDf6SrrO33kqJ?=
 =?us-ascii?Q?Z+UxUjOfCUNCelmgXjHoDnfB//KTDOAQprl5AtO55BW5DVT7Nz5cCuNQzkFu?=
 =?us-ascii?Q?5lM2bXin5NMjXUkGLZJA0qFSuXgKUSPJhQPRhp+M9eDJ1Xy8qMiRx+35KYt4?=
 =?us-ascii?Q?BIO0yB3/2Kp3muFKRXXaQ6TE3/G2ezk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c62bcc5-b1d3-4133-0780-08de4caf12e1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 23:06:35.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBAolStxOZiyhZitRl2Fj3tM7IuzLFRphGIj4nIUBNXpAU+YpLuLaZlSCikgiU2S4IDAGJC0TKV/h+eXbrB6daKwpCed2yJ+9SpHPeiDCBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5879
X-OriginatorOrg: intel.com

On Thu, Dec 04, 2025 at 10:52:26AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The size of this type is architecture specific, and the recommended
> way to print it portably is through the custom %pap format string.
> 
> Fixes: d6602e25819d ("cxl/region: Add support to indicate region has extended linear cache")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

