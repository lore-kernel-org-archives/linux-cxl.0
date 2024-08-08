Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F80190067
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136901; cv=fail; b=XrdvoO7i4h9PWRexu9MGoyxG1lGJxttWAMoMjZVGhHbkyVOA84YiwDolbFdJuGif8nn3QHGBxWJbP+TTyonJiqP2vLJSX7NRrXohVrJbuFzjdg7Ga97rXpXGO7gaTe9ULZNn6inc9XdS+797cxLYUd9KcT2PNtdtuspNJjO1VKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136901; c=relaxed/simple;
	bh=9OmY/1G6z4OhXVBwOkspx0YG6rTq+j7wzuYgISNXIJI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4gbnPIcYsGraUchwG2DEjSu3oq+LHsrsrxDYZHmUs50HSjP0omZgb1leBMFHQWLe/xvervVCAl++Sbn8W0w0st8TxVDUX5Uc6A8s1037lW3xzUleW1crS+4cuX1azlI5Z7hqDCcNvmBjr7i21NH1y4IDRsgu7WvgkVpjjBaUZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iX5LQ22/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iX5LQ22/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723136900; x=1754672900;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9OmY/1G6z4OhXVBwOkspx0YG6rTq+j7wzuYgISNXIJI=;
  b=iX5LQ22/IQ5txDo6ZpT/8+0rhk36++jl/CSUiqVYRpluDvd6sCnvUxMv
   5hkQ/PxBay9E2+0d1+uKeVxMsOluSWfDMny3JSVWZf+Dq+cwdvcQjX+4F
   vqPeRM8DjZ4aZ+jwW3Gi+sT/lwLU6Aakn9KH8exMVXXMEx1q0aiAUIXIG
   xTkL0TSuBH4bicVbSWjMNj/VosVf1MmOXUt5thQg0oSd7xvdAR46ZhPwJ
   FxH38y6figWD8eSFwdhp3q4k0cfXGXo3lT/j/Yiot7XWsM4ox45h5awDU
   TwTrdFDufDAszutSlWAjaKGHqbYR6HPT2ZrnIbbaUJFDSWDDJw1NiYSMW
   w==;
X-CSE-ConnectionGUID: QvrrIzjeTjmyXJq5GX8Tkg==
X-CSE-MsgGUID: kJuuO5CWQqOqD5UZ5nfnvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38738063"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="38738063"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 10:08:17 -0700
X-CSE-ConnectionGUID: hJ2799BARwO7YsopSVeSXw==
X-CSE-MsgGUID: YHX2buf0Rw+68s70A4Bcyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="62131660"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Aug 2024 10:08:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 10:08:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 8 Aug 2024 10:08:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 8 Aug 2024 10:08:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 8 Aug 2024 10:08:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7cXbDraF/YJTU2sDS+dm/1wA6t131RmTdjsoN2MPN5FBSh+vdIvkkCj+0lW/5+sH40yUjT/gNHl8NeBALHm80IhWUGEp2CSUJTsehio+5MsUsZ2j9uO2trufJ5jplvnYN9l3okiAFRRefnkHOYkcKvfXM0z1IOxZyqOGJNipmryeQziggAPiYBSIDKo94AgUvgyvE99b9XSXcz1G6fVRMV4rLaF/Ui56I2KEdggFQ7zT+eO/Cuad5ToF1vvLBLWionHVx2khp7OiXrhTAgiLlAsHbBk6tGvRX8YMPmzbfK/UiAcuUBpCwtkGvLTU0TsH2/kZicvvFtD8R1dKDYFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OAzLUcrjW/50S5ac5mhe/ZPM4tokE+0OOM7xycGjSM=;
 b=t/5RnJW6zQvqviYMhRyD80A9v0yi+hSjHHcTQl4jV5Q+9of2i41GJnw/JmZoz6zLCaZsqFx8DksfbxY5q2JLVxI+4IsT2EVdiAeaO30yd5q6DGVA5BtrlX31BvEMyP2rgOWSLASid7t3ip7K6XU8zkugYt8GARO5Wvl6dk0qPNvjJPakeNo1g9egXwp9qb1jeIKzsnL0ujWm6bauZ05oSSesWrPSmZ5AE2SaMFNt/ox4QhF7dPjB0I1tpxc83nyWCWAAZGVAzCjccJ/+SSu5Mzh8bgftQIFrJrXUaRvEKFjmirh3VCN1Y5eiku11CWjPKvYC9h2gO+fwym4aM8HT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4980.namprd11.prod.outlook.com (2603:10b6:303:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 17:08:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 17:08:12 +0000
Date: Thu, 8 Aug 2024 10:08:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Lukas Wunner <lukas.wunner@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@vger.kernel.org>
Subject: Re: Odd lockdep splat involving mt_adistance_algorithm
Message-ID: <66b4fb7961376_c1448294dd@dwillia2-xfh.jf.intel.com.notmuch>
References: <66b44389e7b5f_71e8129499@iweiny-mobl.notmuch>
 <87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87wmkrzgsu.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: MW2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:907:1::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c58aef-a6b6-4e6c-a788-08dcb7ccaf79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qycypIqCpRVGjXaOa1RP9A0eqr+JgBYGrFwdkpUhvRFcxCDWNKwEO9eAVYP/?=
 =?us-ascii?Q?6eRIBkIUnwv6loHnO9T6bSz7Lwl8v4z83MPNrS/3xRolhZxiGt5hC/Blk0LC?=
 =?us-ascii?Q?bbRrbC0O63RfRZPnMfIBVq2Qd3kwNamuNgQhPdWO2adjOjd15YLL8oolSkQ/?=
 =?us-ascii?Q?CYqOHkqNDj+Odnm16nSa79WQbuqtOgXz7BocnxtEMc/tztDKufvSENHYjHl/?=
 =?us-ascii?Q?sFLAAIUF8lie0gYT+LaAmB/YfCLFDcydN3Nn74FLKBhkx1Xn09jm05gyhxxZ?=
 =?us-ascii?Q?kd74fqBRyj6CBU7dGwFvJXAne9ifqnfllHzgO50gouzy48zX9GYQHfsH22lw?=
 =?us-ascii?Q?82+uhh0DoOJJs5QDwHlV7Koty1a2IL/b/4fapaHto7TQe+Qsou6Zz/BbU9qR?=
 =?us-ascii?Q?Wz/d6jgHcrLNvWUrfmEJN5rjM6jW4hW4lAewWetrCOv2WAK1MRVtQFHDLQbA?=
 =?us-ascii?Q?LwMCueqetaqrY0maGfjJgEHCBp58jOxvv5/HOEbmhyJcDra2hba/0bF9yx2i?=
 =?us-ascii?Q?sRHbypljUzEmXJ8Pw7GwscbHPLEhN/GhZ0DjXAXJrJKfk6CCumf5RS8xVM1r?=
 =?us-ascii?Q?x2dhmlEyZXl+64iAHC9nuTOqjwFi7YfdaUCozEh9PbQ6lmgbd87FdppfHLf6?=
 =?us-ascii?Q?BZwuXOFzD30KonfiGWFsImK2I9bpMWOmrZqb+kTBmH7BNrYrQaDMykVJJotd?=
 =?us-ascii?Q?mOidK2pZ2OBkFIyYqEPlMXDF5KXO9M/7Fchtp901WyinuGs7TuvMr5NBCXwf?=
 =?us-ascii?Q?cHvLuTsIRmZbMqgDGNaq6aP1PVgce/KimEfK/EJ2GKngCBI8Ycw0agURdciQ?=
 =?us-ascii?Q?gxL+lJuwut5ZgFwZeqoYsN7bRS9VEifMSAI+MdYmR70zmM9O1rdbVRF7JT+s?=
 =?us-ascii?Q?MCZPLNvboOPleiMHVtV4L+W4AXc/VPqvo3XefSG927I3AAs9k6CBrA04ixyc?=
 =?us-ascii?Q?PAxQRacLc3WBFEOqtQn+lfouCr3lLUuS0AIfLSUiH+Gvwm7ffIC8YM0QkE82?=
 =?us-ascii?Q?4bQp3TOil0idq5QWGLToBNWaISPZQQ9CT68NDYeqv07Ks83K+o+HEvUuANH5?=
 =?us-ascii?Q?flL2vSwBuhv/M54Go8FNlGGgL3NggqC+3JS/+/n49vzUCOyLoCzSJiEWYzbB?=
 =?us-ascii?Q?RzkIO/v4RUyzUCdh77DN4C48+LlHeAFwd1xPD0uo6kjobACEEfnxj0badEi3?=
 =?us-ascii?Q?NkYUp1+Y08u3Q7BZRcscBRoNzsjR4Es8bysrbLifF8PCroThSuAigOf6gLvc?=
 =?us-ascii?Q?NKZpKTl7ljoZw3DJH3hNkNsMhIJuIM7ybvn7Kqy5130HejHPW4woiAXVZf+U?=
 =?us-ascii?Q?81TmHGOmuSu7hOH+IM5zp6htnKxLZMPyeI/Vme2HQ72enA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DVile/fqFLRj4q+Q8V4eiMgv3QQP6NMvMGIGnRjbIHQj52PsjYmv3lm5o5Y7?=
 =?us-ascii?Q?sZf+LqcX/h8paxi4Xkgos96oPYgQsxPSa6Rhnmjb9fr09LzK5tV+S8MvEvt9?=
 =?us-ascii?Q?1Yw5NvyoBPGaE6DEtCkdhhBD2uezgDFNpjqTdRAOXEkzMnpFHtK73G7KjM53?=
 =?us-ascii?Q?nAZcrINctPbKWocfT3GDauk69ry3xB1MsLdQuj8JjhCxIFdrvtY00NvoBGgn?=
 =?us-ascii?Q?cG8RPrlAJJnLnNTGkrEyU0VMn9y44UZdeYXNIUFQjA3QNoWviC19hjw8jqMa?=
 =?us-ascii?Q?WwaBFhpO7zvuoE+VC5LMfEEBg7vRFq2I7K/38VswRQ96RoKICPYo/KpswpgO?=
 =?us-ascii?Q?RY/SA3d5Gp3ps7/vZEHVi6BNw3gcwlV006OUcg7biPUbSvRFa+A7bTpcjT0C?=
 =?us-ascii?Q?X3zcvShB9qru2WgDP13/6edZpe5ABEC8hnfGLk2UTt8Ah/77hnLe550Oewub?=
 =?us-ascii?Q?Tn38lCJeyZbaExND2zwNkMHJTGzeBEOryxbBoJQHWKJFLCRNveQ+39xzXQci?=
 =?us-ascii?Q?g7qRUjGy9sOpbxqr+kkQsphi7MJBHle8nAWZnDfZKHMc/uyVu0Vsl3bzu+j8?=
 =?us-ascii?Q?y+U7ayAX89QlBgSY4xItuhLZp/L1a9V5iinLGNYSaKX9qF1bBFaFS4REhk9+?=
 =?us-ascii?Q?WMIUpHmdYfTj+xe1AgmOp2Uvw6m4x2RzISBPRRduJoRPazZ8fIWn9NhIkeUN?=
 =?us-ascii?Q?Tz/Hyk7sOpT5aGs46mRZRsGUnD0OJwmJ8EavIGuxjY/PACw42qJrFu8IXa/p?=
 =?us-ascii?Q?eVYWWmhkL7JmsBJPG5IWrMOdksBqOK8y9J/epl/SN/h7t4ESXx5wjLd94JEE?=
 =?us-ascii?Q?WAm0lQt6dMv0usGvM71/KfwuSbCzw0TIRksGQxmj2SL2M8E0heQiZZ3FHD7B?=
 =?us-ascii?Q?y8eaziKKGQwEJPYoyN+g1aZhk7ds1IGquoplzMXMQz85khZIp+MPpoHtVZPc?=
 =?us-ascii?Q?HoaI00Qn6qXDSQZ2CRpvgJMRMZGj6xULbadUByTi7oF65xL4dvpTgfK7ErvO?=
 =?us-ascii?Q?73P3FSDf0ZFT7I6qZORTeFyx9KDKbye86pQIbVmwxRQMEkZCo5dB77x3yjSo?=
 =?us-ascii?Q?ggY195Muw6clZfSDmIS6mB7N0MeX5dQigiEFnSegOPErtMJ+dKmwHbzaleqV?=
 =?us-ascii?Q?f6WxArYpxnPLqGHTWTUCTA02DG1GzcTXzJz6sK5Jz6B0ZkpIUhvSoMHaDluc?=
 =?us-ascii?Q?FYRwlyrGn64sYSSNBqasJ0LK5dXs5EoJnxUpWH7mEedxd2X//ZG5WMcAcqDF?=
 =?us-ascii?Q?Xwe/ZZbcaMIrCwwloYzNqG/D5j65WYpviTKPs9fjIfO7c5GJQWJ+00GDJRAa?=
 =?us-ascii?Q?1ywcgRKPHWQEUdjhzZnKeeDLikAN9R00YD3UFR/7uMbH3w9Vc3wxYxuK/+9f?=
 =?us-ascii?Q?4fVeFqstNkz+IJa2UPsTPgsOUsJhyOtmyq//TZXKdVnMDHnOZN4csI4SbaCW?=
 =?us-ascii?Q?Z7wsuknAo0wkJUFt/ePsF0laqkpijhuVC7hIhBj3CDzjnNGnF+foKlXJDPxt?=
 =?us-ascii?Q?4OsfJb6FMumnfqbqnDTL8oVo3YhXy4xyIWYBDWJ5chZglmm2dn4oQJa8+MGo?=
 =?us-ascii?Q?VtqAP6RPN15m6SDaexdhLGymES7s+iER8HPAHnq98p9s8HrGiupiyiU0BcYR?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c58aef-a6b6-4e6c-a788-08dcb7ccaf79
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 17:08:12.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrPzspPj61i8JL2Z2fkcLibg1JgWoqgqlXAq7Nn4pxwvfwCQCIowfpkPdMDIg69xk99FjVhWBvrNMZKdNKRWniladc5DmBfYOO/6SkJiQ0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4980
X-OriginatorOrg: intel.com

Huang, Ying wrote:
> Hi, Ira,
> 
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > Ying,
> >
> > I'm working on the CXL DCD support[0].  After rebasing to v6.11-rc1+ I'm
> > starting to see the following lockdep splat[1] in my testing.
> >
> > I don't understand how lockdep thinks there is a dependency between
> > (mt_adistance_algorithms).rwsem and cxl_dax_region_key (the
> > cxl_region->dev mutex).
> 
> IIUC cxl_dax_region_key is for cxl_dax_region->dev mutex.
> 
> > Do you have any insight into how the notifier rwsem gets associated with
> > other locks?  I just don't see how the association in this splat is
> > made.
> 
> In v6.11-rc1, a new dependency is added between cxl_dax_region_key and
> (mt_adistance_algorithms).rwsem via commit 643e8e3e6529 ("cxl/region:
> Support to calculate memory tier abstract distance").
> 
> When probe cxl_dax_region device, cxl_dax_region->dev mutex will be
> acquired, then dev_dax_kmem_probe() will call
> mt_calc_adistance() -> acquire (mt_adistance_algorithms).rwsem ->
> cxl_region_calculate_adistance() -> cxl_region_nid() -> acquire
> cxl_region_rwsem.
> 
> In your new code, cxl_dax_region->dev mutex may be acquired when
> cxl_region_rwsem is held in the following call stack,
> 
>   cxlr_notify_extent.isra.0+0x31/0xc0 [cxl_core] <- cxl_dax_region_key
>   cxled_add_extent+0x376/0x400 [cxl_core]
>   cxl_mem_get_records_log+0x586/0x760 [cxl_core] <- cxl_region_rwsem cxl_handle_dcd_event_records()
>   cxl_mem_get_event_records+0x99/0xa0 [cxl_core]
>   log_dc_event+0xc5/0x180 [cxl_mock_mem]
>   __dc_inject_extent_store.isra.0+0x30d/0x3e0 [cxl_mock_mem]
>   kernfs_fop_write_iter+0x141/0x1f0
>   vfs_write+0x262/0x500
>   ksys_write+0x59/0xd0
>   do_syscall_64+0x75/0x190
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Ying, I think it is dangerous to be acquiring locks in notifier
callbacks. I am not understanding why this needs to be a notifier use
case at all. Shouldn't the adistance be passed in via dev_dax data
somehow?

Something like:

diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 9b29e732b39a..3ac20f4b1c63 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -18,7 +18,8 @@ static int cxl_dax_region_probe(struct device *dev)
                nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
        dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-                                     PMD_SIZE, IORESOURCE_DAX_KMEM);
+                                     cxlr_dax->adist, PMD_SIZE,
+                                     IORESOURCE_DAX_KMEM);
        if (!dax_region)
                return -ENOMEM;
 
...notice how the dax already knows the node id which makes it extra
unfortunate to need to take locks to recalculate the node-id all over
again.

Can this be reworked to make all the paths that care pass-in rather than
ask for a awkward callback in unknown locking context?
