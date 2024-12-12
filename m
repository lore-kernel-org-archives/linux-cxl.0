Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAB2F44
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733973683; cv=fail; b=NLkyHHI3PasFTnDTD5AaItZUzBtBmp8fFeHwYbPiau43El9aOnforPLcYq3fjEo00mA+ln8DMoB0xJ73qxK0w0NEuN1lkIEtXiGRNA+sa5rfY+Ujo/lkuMS4n6LL+bAHCJL9SrXLhc7feGiscfhcdTs0iRPBD5O/cxcgkN5OzMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733973683; c=relaxed/simple;
	bh=HJjTSatOl7Zq3NR9SzFmyfoEctewM4TcZNo30K8/d2A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nt0wzU58QSAIT8tR7tRTOdjt31VfJBHnsNxNbYjXGQeaPg6lirLQhN0faBanXCTilfezAlsKKzDJnnUlTVbm1ryjnNIEtGeqcUlrhOad9u+ZVBKa0ldWBizeV9deJrBtQzasg++ASi77SJzvIhvZvBlHeSnPQGPGkhZDZfEBd+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5E5ulLI; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5E5ulLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733973681; x=1765509681;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HJjTSatOl7Zq3NR9SzFmyfoEctewM4TcZNo30K8/d2A=;
  b=K5E5ulLIRHQX/PDITVnXH5JRsGRiTq9SY0bLDm9CUREPWAr1/FbSA+JZ
   5jzIc2NEsWAD/G5SQ5pw/LJEgXogO+cFiz9Et1BredIvUwDl5bxB6VC0R
   UfeYSwOJaksI/p8fa8Pf9l4Zac87OBpybbxFcuGprjb8Sr1KTh1jYfcA5
   LxVbIPygpUFi6AhCeZDEPhNwZYSiQDjID2k8rVOWonnS67z0wJMpedcRj
   ofAPVt9qI0OUOlC4r/xhBrbZLhNzV02H71a7Spar1YKSzmqhcHMj+bImw
   oancjoleTDGy6y2pTX+nvwH41bkiTx7DQNlyp17KYC5cL23IVC7piE2pF
   w==;
X-CSE-ConnectionGUID: 8ovh2tIkTR+DTx2pVfvjlQ==
X-CSE-MsgGUID: 6v0Y++vtRsy2rUUkzdKazA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34297216"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34297216"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 19:21:20 -0800
X-CSE-ConnectionGUID: shSBIW7AQuSsjWTtNpovag==
X-CSE-MsgGUID: c78AmaisRs2kvwUua05dwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="96151800"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 19:21:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 19:21:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 19:21:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 19:21:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZTKcDyoAIkKZ8uyrDJ6A9rUyEad41f34pJR9Ftzlj5yQ78MG+kExTrEWndnj/v+SIXn+cNomMDfpI8xnK4mepTFaLqevBELJ9AITuqaRUnRpxUjA3H7/Taoz1sX3sMuZ2vJ9vyDRXTts5r3frJ9moiWTj7HU0qEQXJ3HF0v9yHZTaXZsDuCStPfWzNZ9aYu3qWlZabzXJImdluKaGiOYgptXEnHB8Syn2VMQpmuffXl+xeFSXa2jNKVjF73GdZD1Rf9F6pRkcEczuj01Mgdg5x8wBkTTbFFzAsRLr46oLh7m4uoweDQ0MSqLmO7poJSZ1r0MQ17xPiIw1TEbqyyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9NJf3HBZbgxXXGWfwz7csXTRhCIXPBGTJXVrigi+f8=;
 b=wNTeb6zttrSEeND/T4THqpNLrssDAkF0+kpXpC0X08dELc+lvH7LuKGj9S0ZFiLZGy6vlVk+dgxOd4kdsw9EBfAlOZTQnN1ILyu6/c9Gyu3QPI8TktVw7nP0gE3OEshVoNXuo6MrS8HqVMr+N75K+yAwEQTiA6rZcwizNVgoftHbS/+n63WAixSg5uq0TKAf0L2XP9g/MwMe7v4LMYqoKGllRbgBCO8t9urK0MyMktyGacQZ59m6zZhSDNv0b03i97Nzce5UU0ToyjeNHiUWUyi0doPIiLuUDIMyPuHUmKlqhsdpTVXH2p80IrDdmoggR3aUiKT0kAZ44ypxxc9tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 03:20:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 03:20:35 +0000
Date: Wed, 11 Dec 2024 19:20:33 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Nathan Fontenot <nathan.fontenot@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
Message-ID: <675a5681fc03_10a083294ba@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <675a12a3d09d7_10a083294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <Z1pFXFGjkMMXgFy6@aschofie-mobl2.lan>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1pFXFGjkMMXgFy6@aschofie-mobl2.lan>
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7cdd7a-ebf2-4ee7-5fd5-08dd1a5bf154
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z2mxSecn/f21Ye9QX7+t5JCiMT8Nz3OZNZU9O0T1ZqBEkpQviOjyMf3Hgivk?=
 =?us-ascii?Q?3nYa7u6mqiGnha0YOu9bHPYRaix8iCFlE/wSjC8hFNciDbMAw5wscoyQ2BuS?=
 =?us-ascii?Q?oNhFFt8s3MV3sirbvTn6glwy6rWIDIDVDiwSopLLyi+HOK4PV4urOeydMD0H?=
 =?us-ascii?Q?ccfxZkZQLzELx+Dm4Q4ApB5zO9YvMvyZJUfaHSgiXpH0YRk82cGsY33Y+yPJ?=
 =?us-ascii?Q?LrBaxl27JOkVXkWlXgkiN44mmX/M6o+Ytl4ViKQmfwY07NoX1Na63YZBoCdb?=
 =?us-ascii?Q?6sHe+JNOJiqBQG3dAtmePlfoD7fNc4yFCQFlorvbuQUd8o0Ng3yHef26eT2j?=
 =?us-ascii?Q?YSeugf8c3B7epfo9qc66rLjRCTA+kPDckBHQHHIAus/+usAvhuHzF9qUvh7+?=
 =?us-ascii?Q?IptM5JUyM1Jan/NvLl3JYQM7Ky8xw5o+Vg33EPQYP2CbfRYJBBAbyXtyGBK5?=
 =?us-ascii?Q?rp8OR0AWeOc6HcC38s8G9YEs0DMqzta6Hf6O6ttsJRbdz+kKaxiyAB4LbIXZ?=
 =?us-ascii?Q?yFaT2tyPYlVbShVM5R+5jchkRqEt6wnwXERSTJ8AgupORaqOFkCdjjzAxzlP?=
 =?us-ascii?Q?flblgDBrVjC1rfKLA5yJ8c7aPDdl3glfTNli6jw9ufpzVvq95EkhRhGBvqPO?=
 =?us-ascii?Q?sNG5UjKpITaxKTFS8X7gr5Tt5WG+DZ6cDRJYqnOwkswIkOkDUaMd4gD3670j?=
 =?us-ascii?Q?79qYzesDUxPtLy0RATGF1ckO03/RoELaO9ZSyWwgETf3tdy03+7U4o7oDxDP?=
 =?us-ascii?Q?/jR17OYua/Yug6UrLQcDG6Cg/dmFpqkiOrL5onmsVMQ4qyEddE+kP6JHZgPH?=
 =?us-ascii?Q?gO7zlVNUuXaKfrf/SFQILqCHqKjPUN4JKFl5OJ3eOz0ECqApjTw9ED3gMLAB?=
 =?us-ascii?Q?rJgYaTXiIAKpFbGRUzNbDdTfaXem6v+HwFpcReth2tbotoBPdwsIv+2EzM1B?=
 =?us-ascii?Q?0G8k/uxRWqGsn6BsuogqvjhUjVDMrEgEZhBQK0Rn60TaliLruSoV5xNz68O3?=
 =?us-ascii?Q?m/sXJOqeZuJGLbCY06DgSc3eY+TuegKarL63yh5AsZ+sjcOd6GtUUaQr5HAf?=
 =?us-ascii?Q?IrgySADy1rV6BGIyQwvZ9hdcD69LpmeNCnfPW8tEmKQ/n+/mF+HFAv+kcjan?=
 =?us-ascii?Q?wpeNLf0e2DTWdogT2FIE2k2qaG921gpH43mnMuUdfHft6Htm2T3wMCRv8HSY?=
 =?us-ascii?Q?uK3ZDJNFtcKkPJb7lUl229bxSN6pE2JSSWejh3MLuVxQNNf4HxthpO3HhU7F?=
 =?us-ascii?Q?x83bvW4SZo7Zgr084VftLHOHSgAUK8R45ML4DuRtdxmlp2u5R0SC1n/6LCrh?=
 =?us-ascii?Q?Y1v82qijJieZi97JUS93ogAdvHHxmUw6gdeufwg2lqwuS1tceUu07txBK3PE?=
 =?us-ascii?Q?emtgFSY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SnP03OApXp+CYbIPHUs2KARmJYHoEPVfFtDbEcHMTT2tRDw8V1RvendPD1iX?=
 =?us-ascii?Q?qj3FqhkcZ9LnbKisbdwgIKX9tGTmghgzP8g1a3HTkzNIO9N1kjOu0I2nykyf?=
 =?us-ascii?Q?v/97/nKX8dgVoyOXfCXNOohd2Z/vwyN+xey9rEaB7Wl3j4fN9MCgJIl7mHpS?=
 =?us-ascii?Q?H0ZSNZF5emoRHKfJCt3wj/rlbeaKqBhkpxTxRDOMjXRumA9danmDL9Fm7mNf?=
 =?us-ascii?Q?QKJ+0HPSL3uvjDZNox59+HrBFcvoDItkG5lpYQteHd9aS93IptcPTQ7m/IWk?=
 =?us-ascii?Q?Fvdl2pGvLHsX30vBSHN+QbjS6X7FbeNqj1RJzGLbRl2xOJf6iDJ/HTsewx35?=
 =?us-ascii?Q?TFGXDOvcBPGL5INjVulip26c5tVilcQjKsHbMFD2+UkM7Mfk6U2Nnf1jWbcJ?=
 =?us-ascii?Q?3lSClX1OEvle1XLwGjilutq0ODPOYA2HtfLLv9HQTbfdTdIQVHZ3KtElpSFd?=
 =?us-ascii?Q?XLZrouNPd5uIUBm2TmWd9Pzc88patAFB8Y/53f7Oknd/TPfLajgR12dxvzWZ?=
 =?us-ascii?Q?cYxZkIyxa9CaTlcIsRDUdsrDbEvIP0PggQMazvASekE2jDaTT6bQdoULN4q8?=
 =?us-ascii?Q?mUb9A5ogJpeCfNQKa/npIr0iY2/Yz26MddzhWklHZIBmsR+Qh5lD+rGtt7nS?=
 =?us-ascii?Q?Dbq3i4F3o6SA3FGX5CJIrvxe+yk8VnfkeBFaEut70TyVH2cBuwXg+kgSIe+w?=
 =?us-ascii?Q?0UkNLZj5VVO3oa4UadS1sOq04TTJK/+JrGABxVP97cFWssjLBg6MsBr4MtFA?=
 =?us-ascii?Q?KIX3Y6t9Glo+LrNtyYaspmhLnI9a8W0LznHO8FzvwiZiLH4QQNrDHpeuoo0c?=
 =?us-ascii?Q?EMakIoIsGRGzCqCRzSAS01W+GyBqgdUDn+nKg9gwFUJSJL7XXXIsFn2Y2WPM?=
 =?us-ascii?Q?1QjFol+eyqvCGSiICnrRqcxhOUi8h9ifECeFJEMwi2ILtqhDNrnmuYANw/mA?=
 =?us-ascii?Q?Onh4rF01s+QSlGkLul7MXL8mycDRqLAQ8AHZ7q5jP1jXEeBI0xREL18TFLXW?=
 =?us-ascii?Q?wHDqzisPZvqK+FURu0zm7+5QJ/punFYgdKCwFqkzrsryOMOic2Hc1BOVMS1W?=
 =?us-ascii?Q?3B+404/lMWKqLZy/1GH9PJ8LxIdCQq5GoRSNpwoay8vO710ZiYwSte6tl79y?=
 =?us-ascii?Q?SZ+YzQYWovQoFbu9+eNdwljXd0mZd5yX7n0r41r9U5uzYXiV6HUJqJtsE14Z?=
 =?us-ascii?Q?u6004zV8K1O60eJbIx7F6dx7KYKMIAyLI7UPdvoyg5TgWMo3SDn/lG4fMdvK?=
 =?us-ascii?Q?3jgMGV1aEshS3xae3zW0j4dFfcjPqtchSIp3d8ZCP2ddOvMG+ok4rWVE6ToB?=
 =?us-ascii?Q?UMj/n+OZ9ydf5obkyoiv8EzRLhW6bTsbU5EXs54drNGoln1UGVVom7Pxa/n0?=
 =?us-ascii?Q?CaZezmSX7mRTk2EhFknXR+WWzK+LZ1RdZ0k1pC8+00VBOQiOjFjgbla/YXMu?=
 =?us-ascii?Q?n8AMeupVujxg8bBjtDE26EJtRjNV03JDB2Q/9XUioonfFN3A6hGlIXTVKwSA?=
 =?us-ascii?Q?xUTp9wDlyYwKbrsKYuSBw8dWJ9u5BzaC+zL4CepdGQFoTKfWLfQmbKvt4xcZ?=
 =?us-ascii?Q?PkGBKp6OwP7dNfZiEKMY6yL66moUq7gEweFYJD2N74QOusSuyYOMTYjZOSAq?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7cdd7a-ebf2-4ee7-5fd5-08dd1a5bf154
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 03:20:35.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYufCAR9M3xc2NEdYnK5/+XC2McdTnieFP4hygRNALwYl5zNzV0521yNrIfwJdBTHgFRuYNiacfV+PDy2c7YXKOdfMDm8UqF3E/rIpoNwjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> > Hi Nathan, this patch hit on all the mechanisms I would expect, but upon
> > reading it there is an opportunity to zoom out and do something blunter
> > than the surgical precision of this current proposal.
> > 
> > In other words, I appreciate the consideration of potential corner
> > cases, but for overall maintainability this should aim to be an all or
> > nothing approach.
> > 
> > Specifically, at the first sign of trouble, any CXL sub-driver probe
> > failure or region enumeration timeout, that the entire CXL topology be
> > torn down (trigger the equivalent of ->remove() on the ACPI0017 device),
> > and the deferred Soft Reserved ranges registered as if cxl_acpi was not
> > present (implement a fallback equivalent to hmem_register_devices()).
> > 
> > No need to trim resources as regions arrive, just tear down everything
> > setup in the cxl_acpi_probe() path with devres_release_all().
> > 
> > So, I am thinking export a flag from the CXL core that indicates whether
> > any conflict with platform-firmware established CXL regions has
> > occurred.
> > 
> > Read that flag from an cxl_acpi-driver-launched deferred workqueue that
> > is awaiting initial device probing to quiesce. If that flag indicates a
> > CXL enumeration failure then trigger devres_release_all() on the
> > ACPI0017 platform device and follow that up by walking the deferred Soft
> > Reserve resources to register raw (unparented by CXL regions) dax
> > devices.
> > 
> 
> This reads like a 'poison pill' case that is in addition to the original
> use cases that inspired this patch. I'm not sure I'm getting the 'all or
> nothing' language.

Read through this recent regression thread:

   http://lore.kernel.org/20241202111941.2636613-1-raghavendra.kt@amd.com

That is evidence that the ways in which platform CXL configurations can
confuse the CXL subsystem are myriad and seemingly growing.

So this change of heart from me is realizing that the solution needed
here is less about how to recover the Soft Reserved ranges after CXL
successfully takes over, it is about abandoning the notion that the
driver should continue to best-effort fumble along after discovering
that a fundamental assumption has been violated.

For example this would also mitigate the "Extended Linear Cache"
enumeration problem:

    http://lore.kernel.org/20241204224827.2097263-1-dave.jiang@intel.com

...where the driver fools itself into thinking it knows what is
happening just based on reading hardware decoders, but not realizing
that DDR aliases into the same physical address range. Yes, you lose
important CXL subsystem services like address translation, but it is
arguably worse to confidently offer a bad translation based on wrong
assumption than offer no translation with an undecorated dax device, and
in the meantime the memory is usable.

The driver should stop guessing and say, "there is reason to believe I
have no idea what this platform is actually doing. The platform firmware
seems to think it knows what is coherent / enabled memory range. In the
interests of not dropping precious resources on the floor, or proceeding
with potential misconfiguration of the memory map, just revert to 100%
memory-mapped enumerated resources without CXL decoration."

> The patch was doing Case 1) and 2). This poison-pill approach is 3)

So it is not "poison-pill" or "sour grapes", it is "irresponsible to
continue when fundamental assumptions are violated, and wasteful to
leave the system with reduced memory capacity when platform firmware put
it in the memory map".

The "unwind SR on CXL region destruction" use case comes along for the
ride as a bonus feature.

> 
> 1) SR aligns exactly with a CXL Window.
> This patch removes that SR so the address space is available for reuse if
> an auto-region is torn down.
> 
> 2) SR is larger than a CXL Window.
> Where the SR aligns with the CXL Window the SR is handled as in 1).
> The SR leftovers are released to DAX.
> 
> 3) Failure in auto-region assembly.
> New case: tear down ACPI0017 and release all SRs.

release all SRs back to default enumeration behavior.

> So, after writing the above, maybe I get what the 'all' case is.
> Are you suggesting we stop trimming and ignore leftovers and just
> consider both 1) and 2) the 'all' case? No SR ever makes it into
> the iomem resource tree so all resources are available for reuse
> after teardown. And then there is 3), the nothing case! I get that.
> 
> It will waste some leftovers that could have been handed to DAX.
> I know the SR greater than CXL Window came in handy for hotplug when
> the SRs were not released, but I never understood if SRs greater
> than CXL Window intended to serve any purpose.

...and that is another example to prove the point. If the CXL subsystem
can not definitively say why it is trimming too large SR resources based
on the CXL Window size it should default to giving the end user all the
memory promised in the EFI memory map.
