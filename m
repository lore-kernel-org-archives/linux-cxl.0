Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE88468
	for <linux-cxl@vger.kernel.org>; Thu, 25 Apr 2024 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016875; cv=fail; b=V7pq6Wjmbf9dTAGJr6hnez2sSgOmD2CTBzL0LSfd9ZCNz1ArVhec+d1/UV6DdDGC8gYRPz8wdrHxAKDo7s5/D+uT6OV1xteXZkM/eZ97SJ3ZnuKAKqnFjWg1gnsssZpVkn4gN12oCXowaRQ9HbY5V1DLTANsOb3HZcFvkm2Mxus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016875; c=relaxed/simple;
	bh=oIZZmBhH3d2+fvo5vH2saKj7pmAUpYVJcIszagaEEnU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KJf7DW0z4lnuLoaUTa+v5E3PTnKyb14qeguut/FEFgGtU10+ly8uHXTUcWe5wmm6ybYSHIwUif5SY4XI7ZMBARF1bBUetGCLQ4i6giE0uUyJBxZ7CHWdsyyWhx+9VsuhtfZVMQsgK5Kc698JoCcgdhiL8GIv2DbgpmHK98Jur4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ntiW8DDe; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ntiW8DDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714016873; x=1745552873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oIZZmBhH3d2+fvo5vH2saKj7pmAUpYVJcIszagaEEnU=;
  b=ntiW8DDeXIfGqA/Wr0xw72qy0pIV9JQMTpYRsKs5fIut3fWIKdbDCh98
   KBV5mBmqsjW34mstSD/+N0oiVgQZhMr+inojy0QU3hNvetJ9shxg1856c
   IN8xuuvkVBE4pEHXW/rt/piFfC3HSNjdXWVfGDrMRWd8ALaJWNC10WYvB
   Qh3WGbZZPQ7EqqyBA+HxhM2H4rmGagG9+bm4NS+HE9k9VixxixAHH5kNV
   QyIFKYiEFGNF17PWQZRNDu6Ac3g8RcESM7bHjUl5mlOaOKxWEa67KpkTU
   IDkRvze/yw2ENscrZHH0B9EN3/UQduxSb6Bf/gpc7LSYW2V1137kTc7vt
   w==;
X-CSE-ConnectionGUID: qneHV4TDRt+kxNbqjcHL4w==
X-CSE-MsgGUID: 6xXb7XehRrWRl2kqSf9aMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9898542"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9898542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 20:47:52 -0700
X-CSE-ConnectionGUID: Fml7TyCpTtGPw3EbSPSr1Q==
X-CSE-MsgGUID: NHVXWVO/R7y7ZjTuD9mZAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="24968298"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 20:47:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 20:47:52 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 20:47:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 20:47:51 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 20:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Afmk1IYL63jhvvJpRjY3g8T4zEZRt/XkGiZiHEVrcKadaojKffdK+xmlAQIyo+YbFaQvJe2qECspWl0WbURowjX/jaNcEVNmOnLH+qkGYCjqIjKpTyogNf9eDmiYNmf++QZncid3EnqPkpGIxE+IRkUoald6e+flLBs7+XR/ZJhITqRZ83bu4trUrNBPgCQ6RAl2DrLykXIPiiu2txGU7VcYTzXsMeu64ZlNe37uzLaqarRsdu6K8FJY16eLVfIQCK8Gd3co8t2pTgfJQI0gqzF5DA9tJIIMyugDT4OZfSmUp8cJWIAikjzvAHd5q/xa70MQwWg8+26SVrSntzYZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38vjgi1QzhZ4ELE+wCIJ3lLipeN7CVN/S69+K/A2t8g=;
 b=j07Aq3L4bQDm6QQKcyKwdSwkhrCwPzvgGaPxLpzF8HfJ4BcB2eAlZhOQDy0EVLGQn6DC1qElXBK9+CoBVTJiSdeqH6DNU37iSaNdYj8344rXbnxCbL2j0whFQRzURTV5fUX3b/S38CbvtDzpC2OgV6VUnf3PJuz13rPlvLBkMEHvr6d0jMB/OieR37AK4O2pMesg3IIzP4pZl7Jj2CkUV9ef1GA+i9dFj7owhiDh3gZBFdQW0AsIVjURxZQUdKcqyf2uLta3rCLsmsftzU4rMRLOkqZvDuWuTROh1rcSG3xcV4lNJlVgw04DUdSQboCK0cPVMyrC3wHOazPLtFTqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ1PR11MB6081.namprd11.prod.outlook.com (2603:10b6:a03:48c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Thu, 25 Apr
 2024 03:47:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Thu, 25 Apr 2024
 03:47:43 +0000
Date: Wed, 24 Apr 2024 20:47:40 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 3/4] cxl/core: Add region info to cxl_general_media
 and cxl_dram events
Message-ID: <6629d25cd951d_690a294cc@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1713842838.git.alison.schofield@intel.com>
 <800328a3fdffa0f3ece709be337bd64a07089bff.1713842838.git.alison.schofield@intel.com>
 <662895f86a0d9_a96f2949d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZilhtqkbgYTKs8A3@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZilhtqkbgYTKs8A3@aschofie-mobl2>
X-ClientProxiedBy: MW4PR04CA0127.namprd04.prod.outlook.com
 (2603:10b6:303:84::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ1PR11MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 275d5b5f-bdcb-418c-f0ab-08dc64da765b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IUOtVnPvtcSo14NR2NtWyC9LYgK6/KL9gurYo4IQd9x4MiRNh1Xjr0gGPfIu?=
 =?us-ascii?Q?xob7xyE/H24QjCsQKpCzrlBNSgy/FHWLyvIg0JYuwAXKPxnWAqcLqX6K5U0A?=
 =?us-ascii?Q?6U+7TR1jGS4dSfivHT93G5w9BidvNNS4BUNe6k4PKbhX/3z70bdG/illsf+I?=
 =?us-ascii?Q?v8wn1mtkde0uIvfvtSTvj1uSbSjG6w8bMDa0oxAPwrrBQQTL3x16ey4nkFGe?=
 =?us-ascii?Q?BMkUymwrxncY9etuacvfeYP7BnSUjgZBH/4QOusQcSD6TQ/qcDxFKAxFfMcy?=
 =?us-ascii?Q?6L/YRukucT4bkL2MLSylBi1jYmESfp4sKYIb8PwEts5i2c3zbBeRZ+hm59xb?=
 =?us-ascii?Q?uceVGSq//uZ3O1lfw1N5Pw8eRllU4MQJ6vqLw0Nm8uWSS+9JM0n1AjPX28T9?=
 =?us-ascii?Q?kqRyJi/YJ2UciluwQTfG8yWkkePWPzxVbBnx2O3p1eAa3jh4vJoF0M+PMD+U?=
 =?us-ascii?Q?3rOxhBO2PiQhQAjUlzALkJ3AKLW2Sg2AG1Eau2NIVA7BGexKyq6Ld8rWW433?=
 =?us-ascii?Q?5aqK1AmxOMbWFPpIQF2PLqw3OcmAqnUd+IfywWUfDGru9UWc3Izkav61BB80?=
 =?us-ascii?Q?+Ww0VYbPa+zmyQYgUs5ZzUb4Cn7mwMgLmFp6z3g1rLPGUyt5MRrDrCe9zPRp?=
 =?us-ascii?Q?JGEEiffs6mYXiuBRIB/5vPlRrqvZjqGEpGpg+hwvNJ5XN+ySmhZ8g3lk7OYg?=
 =?us-ascii?Q?FzU5VUeon7IdTuOi2N4+nKB1WifjFzXbY67Khr0Q1iqpCBy0R6Zkg4s//8p0?=
 =?us-ascii?Q?oO3/UhQJtGyp8erbAt8rbpyVm7u13K1VlzW5wmOtIdAqwKCYNmV8MDfME8ml?=
 =?us-ascii?Q?VLPMEViLLs+9TrYkDDnzqcAUO4aEOFFJY17iW1ElV9l9LRgw2l5Itdp11zex?=
 =?us-ascii?Q?k7BdqmEfuKECLWetDVl2+bID5FWIpeH8aD0tHQlQohRVLZ92Lx1o6CtFe55A?=
 =?us-ascii?Q?Rn2BrNVjTuKKtnATwTIoj/t7WCp/AhvwNz8CYWL81MQgjJxWbZoCgqwP1nhE?=
 =?us-ascii?Q?KbNa9kXLgodcHjNJ650+WzIomczeFUZW9zmA7IIOJxzkhPij09Cn61yVQcqe?=
 =?us-ascii?Q?XjvolSDucc41nIvBLypVRc65SeiSKN64BeTUVHy9BSNj69rxxec3P81UWB1I?=
 =?us-ascii?Q?1rUgEGK4EghVd8tmpkFiLA2Sl3qWO/wKZ71wMC0jjWqZcdqwgnkqUMZTj4zd?=
 =?us-ascii?Q?IHyt7hLm45DiKQ9Ag02HncVAsLxchDv1/d8lVYnYJoJeI2W6XMnfGcQbyngm?=
 =?us-ascii?Q?iV73pfg6iuBpt5BJsgSv805HUTg/GZz5+pVLqtIcqg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8zfgBEvfAUizyY8KvfthuOxKXHD/CGFr+a7AKvUZB12VjhwwlQcZMcSbMC2r?=
 =?us-ascii?Q?P0oV5jNi70+UdvhoK5ghwbIwAV0gBrDuXR4TRhvmeQnR/f9bFVTVRxh9Jq7M?=
 =?us-ascii?Q?5xoXTh0oR8pyLm+X9tBM3o8f8d03ZXwu95wP7vUaZup5dgTtr3WCDUaJDwRH?=
 =?us-ascii?Q?K4zAfw+8R2NoV1weSohasVkf8IJY/rQE5JSuCR1pl9xVeUYOdY/qA4QH8FZv?=
 =?us-ascii?Q?Ff0OpO2sCuT3jfIQKlbXETEWjWse4ieTgAkaT8yelF1oUEWdlmzVbJGxmBv9?=
 =?us-ascii?Q?MvFNi9ghF5v0RMHCZ+DytAeR9P2gDziar444rDaVh8UbqqRayqjsmi+xSMTn?=
 =?us-ascii?Q?zlFkVL/1BA4WpDTEELQfA0hcCm5Osos7n01YBdrv/u6hawvSKrd96SGaVqaO?=
 =?us-ascii?Q?ysuK0ENirRXgHJEOz7D0vXuF3rCvs1AC9dRv4/+c19gi2wuVDYZvJgs041S3?=
 =?us-ascii?Q?HvoZQcX9zsK27mDmscvTdFK4o/oIBr9TpLqjKpEKJ4OYDz8NsWIhBRa3qgrX?=
 =?us-ascii?Q?WHpEFIfHcZadFwUTtF/hlbV5h3w1lvaW/+0N6Hqhk9BT51BlOkGuewmb3RB9?=
 =?us-ascii?Q?Qj7dMdQEYueSNQSZhW6Jt09GNCspCiSUNKrmHVSQSVlMu5EdIPqqKSLbG7hD?=
 =?us-ascii?Q?eUbn2wrothrEPBhqyd31DPGzvtEuYIdmEgxuLbXSXxVopCGXv2eT203qxXPy?=
 =?us-ascii?Q?OiQjOr7o4D+Lr4cQo8Aeg26mVkUuUGAOxe5NZ2MRR/GAGmaeXsAbg3c6ICEi?=
 =?us-ascii?Q?yjwdiH281snLiV8m+i1fJWAx9H7EAJJkKe+YnNug4HJBF8dQVJpcv1C3jFvW?=
 =?us-ascii?Q?p5YMI02/Hi5nfbc5kJmQacinClfwY+cikig7kPRl3ALCnvLRB1X2+1VVxcIy?=
 =?us-ascii?Q?xGwomM4dAOS80C1VCaFJe+nbh1VTHp4LCb2ARpHlfSRBSU6CUthCFtZkiDTt?=
 =?us-ascii?Q?YR3ysw7niuN7QE/XpXAa5FFbXQwZVfU2v5yQoSO/flv3RyYvrpIrEyEnPgUn?=
 =?us-ascii?Q?v42UDV7bUHDIcQ1R4wkOzEq7Ixj8x58js32bOlL6YbZbytZ/EHfxtU1MPneR?=
 =?us-ascii?Q?x4qDjTsodIXVGtV/qTP4spoTC9kPorDwVjrYmnNz6zSbl7qXcUHcDafCajBC?=
 =?us-ascii?Q?pz1ZHaOQqPoyGw+itJRvMUemCospm0gf6hrE4+O2dIL3FQBVzB6XJ2CJy/H6?=
 =?us-ascii?Q?dHrXah5XHh36hesS9tKfipQ3UnWPnykOb8qFYD+iax47tCIVlm6ic/UTQ5h8?=
 =?us-ascii?Q?xWHB/KuG5D4mMBrSwRaxCHli+WdNW1AZbwvUyUPm9VQiIEoKaSNRgZILpAct?=
 =?us-ascii?Q?6rg5ATVnU4r/FXg+MJesRMrJuSei2+WByzJgy2Zj72BggoAwBgPGvXTrQQfX?=
 =?us-ascii?Q?cqgpVT3D87K17fV5lRIYlGmZ8es3vfPi6A7d5h11lz4SnzNMRmZ4oPpbkaCX?=
 =?us-ascii?Q?DPVxiCNXYRs8v9VrLGzyn7zyh0HeRqCXrkG4m5GF705NNRz335cz8ZkQjodW?=
 =?us-ascii?Q?kyI7RODTLrB2D5GRVOBy2Lr9NaxfYoxiow7WhILdBj4640VQ03VbAmBn/1vy?=
 =?us-ascii?Q?BgtbBXj4vbNxSU9jQOaHatmEkXl8eB46bW/EsoqSscd4Lwx2nMEokEGD2GvS?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 275d5b5f-bdcb-418c-f0ab-08dc64da765b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 03:47:43.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpHcKbU8JbOgMudnHlIZk1WISj9Z3zPe/vyXXP58xWy2AzBUaZX/UIC8P5V7M1B5zZ6fLDl9pyEc//uIw3vJl5W7eXpC6/IhjvBdpOutnNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6081
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Tue, Apr 23, 2024 at 10:17:44PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > User space may need to know which region, if any, maps the DPAs
> > > (device physical addresses) reported in a cxl_general_media or
> > > cxl_dram event. Since the mapping can change, the kernel provides
> > > this information at the time the event occurs. This informs user
> > > space that at event <timestamp> this <region> mapped this <DPA>
> > > to this <HPA>.
> > > 
> > > Add the same region info that is included in the cxl_poison trace
> > > event: the DPA->HPA translation, region name, and region uuid.
> > > Introduce and use new helpers that lookup that region info using
> > > the struct cxl_memdev and a DPA.
> > > 
> > > The new fields are inserted in the trace event and no existing
> > > fields are modified. If the DPA is not mapped, user will see:
> > > hpa=ULLONG_MAX, region="", and uuid=0
> > > 
> > > This work must be protected by dpa_rwsem & region_rwsem since
> > > it is looking up region mappings.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[..]
> > > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > > index 161bdb5734b0..2e24364b2b8d 100644
> > > --- a/drivers/cxl/core/trace.h
> > > +++ b/drivers/cxl/core/trace.h
> > > @@ -14,6 +14,28 @@
> > >  #include <cxlmem.h>
> > >  #include "core.h"
> > >  
> > > +#ifndef __CXL_EVENTS_DECLARE_ONCE_ONLY
> > > +#define __CXL_EVENTS_DECLARE_ONCE_ONLY
> > > +static inline
> > > +void store_region_info(const struct cxl_memdev *cxlmd, u64 dpa, uuid_t *uuid,
> > > +		       u64 *hpa)
> > > +{
> > > +	struct cxl_region *cxlr;
> > > +
> > > +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > > +	if (cxlr) {
> > > +		uuid_copy(uuid, &cxlr->params.uuid);
> > > +		*hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> > > +	} else {
> > > +		uuid_copy(uuid, &uuid_null);
> > > +		*hpa = ULLONG_MAX;
> > > +	}
> > > +}
> > > +#endif /* __CXL_EVENTS_DECLARE_ONCE_ONLY */
> > 
> > This ifdef usage looks awkward...
> 
> I only mimic'd others that defined static inline funcs in trace header files.

That's fine, but that awkward trace hack can be skipped altogether if an
@region argument is passed to the tracepoints.

> I originally thought it would be protected from this define that already
> wraps this header file content, but it doesn't.
> 
> #if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
> #define _CXL_EVENTS_H

That's what TRACE_HEADER_MULTI_READ allows which is needed for the
tricky way that tracepoints are built.

> > > +
> > > +#define rec_pa_to_dpa(record)						\
> > > +	(le64_to_cpu(rec->phys_addr) & CXL_DPA_MASK)
> > > +
> > >  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> > >  #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
> > >  #define CXL_RAS_UC_CACHE_BE_PARITY	BIT(2)
> > > @@ -330,10 +352,14 @@ TRACE_EVENT(cxl_general_media,
> > >  		__field(u8, channel)
> > >  		__field(u32, device)
> > >  		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> > > -		__field(u16, validity_flags)
> > >  		/* Following are out of order to pack trace record */
> > > +		__field(u64, hpa)
> > > +		__field_struct(uuid_t, region_uuid)
> > > +		__field(u16, validity_flags)
> > >  		__field(u8, rank)
> > >  		__field(u8, dpa_flags)
> > > +		__string(region_name,
> > > +			 cxl_trace_to_region_name(cxlmd, rec_pa_to_dpa(record)))
> > 
> > ...and this looks complicated.
> > 
> > A bit too much dynamic resolution happening within the trace function
> > for my taste. Just do the region lookup in cxl_event_trace_record() and
> > pass it in. That also makes the rwsem usage more apparent rather than
> > digging through trace to find the dependency.
> 
> When these cxl_general_media,dram,poison trace events were originally
> created once of the goals was to push work down *here* so that if the
> trace events were not enable, no needless work is done.

The moment a code path needs to hold a lock, (2 locks in this case!),
over a tracepoint it has already incurred significant overhead. So if
the name of the game is "skip doing unnecessary work when the tracepoint
is disabled", then just check if the tracepoint is disabled, something
like:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 60a51ea3ff25..31f44101582e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -851,14 +851,23 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
                return;
        }
 
-       /* Protect trace events that do DPA->HPA translations */
-       guard(rwsem_read)(&cxl_region_rwsem);
-       guard(rwsem_read)(&cxl_dpa_rwsem);
-
-       if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
-               trace_cxl_general_media(cxlmd, type, &evt->gen_media);
-       else if (event_type == CXL_CPER_EVENT_DRAM)
-               trace_cxl_dram(cxlmd, type, &evt->dram);
+       if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
+               /*
+                * These trace points are annotated with HPA and corresponding
+                * region translation. Take topology mutation locks and lookup
+                * { HPA, REGION } from { DPA, MEMDEV } in the event record.
+                */
+               guard(rwsem_read)(&cxl_region_rwsem);
+               guard(rwsem_read)(&cxl_dpa_rwsem);
+
+               region = ...
+               hpa = ...
+
+               if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
+                       trace_cxl_general_media(cxlmd, type, region, hpa, &evt->gen_media);
+               else if (event_type == CXL_CPER_EVENT_DRAM)
+                       trace_cxl_dram(cxlmd, type, region, hpa, &evt->dram);
+       }
 }
 EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
 
> When you suggest doing the region lookup before calling the trace handler,
> I'm thinking something like this where the region lookup work still gets
> skipped if tracing is not enabled:
> 
> 	if (trace_cxl_general_media_enabled()) {
> 		cxlr = lookup_region(cxlmd, record);
> 		trace_cxl_general_media(...., cxlr);
> 

I am chuckling because I wrote all of the above diatribe after finishing
that "no needless work is done sentence". After building the example,
compile testing a version of it, and pasting it into the mail *then* I
read this next paragraph.

So yes, we came to the same conclusion. Please use trace_*_enabled()
which makes it clear what the locks are protecting. Some
lockdep_assert_held() usage in the lookup helpers would not hurt either.
