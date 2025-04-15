Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918F221DA7;
	Tue, 15 Apr 2025 21:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752456; cv=fail; b=RQDGX49MEXQaAkZbrZCc/zpg9CkvRHa5VaOJI1BdbH1tQDQDlJshjhhD8/CWuLBeDdmWgpKvRDObD+WIkT9On5Jv4ImYN1TsYgKFPu70M9gpg8uR3K8mibr39CcsfeVqzTootccVQ5d7Vmx4FGxupkoXNSOqZFocrxnunUyo3bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752456; c=relaxed/simple;
	bh=v6vYScfC8vj03HTDTGd98jkpaxEH/Wi1xS66EaHfkZ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=llHXBx3aexTbMt+ZV7JQAEiA0gZfM+UmmKGhRN9sj+2vkUe3nR4Xo2gy8z0gNfqbxqsfFLojZhs0xY3xKQxsgjmWNsuqQ5ilABMI+oidXb2NI2ktuGnytQ3X0/xdsxvoQlYYpLuxo2kGkzGpkiCvrIxzlcMTqusBbwphgmQE1RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKCxSZDb; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKCxSZDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752455; x=1776288455;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v6vYScfC8vj03HTDTGd98jkpaxEH/Wi1xS66EaHfkZ0=;
  b=FKCxSZDbZNyhK/RDOf66CErBaPuMRMs40+4dYcRgnTXPXU8KXWm23oLQ
   F87mLcCpAF/gID5gDHWpIGh4zy4vDX8lMT4TqyRuen7WpY4YNXdG2CBVm
   9rdTJL1VKD3yfog7aR65tRSNaTxmkLTTfPEeNbhBKq4SeDNHssK7dfagc
   xWF3x/F2hQaC/tB3ghtibsjdyl82GCUVYRoZSPkKX+CSxrBEiLr25Ujb3
   uTYW6rY8tFy1HMkAUCepzHQsE+Hkl8b1kfZDckC91eGvp39ONiZMydPco
   out3L4oE6l8nbONchsTh5yitDXcXTd7+a1HWAVNbZ4j5i6ftbP6HzwEmS
   w==;
X-CSE-ConnectionGUID: q0YlOf6dRvK4JYu7fojNWQ==
X-CSE-MsgGUID: rptea2vpTHylGHILRoWOEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46297923"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46297923"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:27:34 -0700
X-CSE-ConnectionGUID: pxVHMvOkRB6nYQoS3k9hyA==
X-CSE-MsgGUID: lVV5CcpZQmG1LeEOojk8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="167411426"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:27:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:27:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:27:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:27:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHP8tOS0EDys57UAX5vBsIznvzz7BBhGUjrIvgInYX/lYD4d70MgxGBf6jHVxlkmVaur6cspTPBXDRVnteQ5sZc3ORDL1UIJX1wOhlCyfDx+BIbNalgyU8ONjjTN0HAYHIiPUn+DYt2FxVS1A+122TfE93HgfRl8ndUd/9hhgdXSiduEVDZBbgZ3VjdNQ/O4CjsPmKpIfLkdYIMLZTS3du6olSLCeRqnf84bf9ehzOC4qsHv38p2V/jETZzhWuU8OEL+QS8hkIKEF+HFWoBM1T2C2+pMIa0bB8nUYggPbW8AMYd2U+rnBBeEr0Hkg1zXz67yD8Gw6lMKHC2dikbaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUZw3joFNsAgdlah3iabFNX4w53jFeEyv1BejamSRcE=;
 b=zDrLJMnuiHIAUvjKVS5WJvCGkcbUZlELiisje0qgvrKEbz1Ho3GKHUZY4t6IocKphIC7gcfs4bFd9CGEHwfLqF9gb2ThEfcr4qG2g3l/DB2k6EU+DlwrLYnOHzTm//9deE5PogVQiZpskr1Wtk2b2Pf/Qx6h73l+cCbEoeCqLGgLAHSH29c3AvDcy1DCgAcgQ3PbZTE1Z5NyOF6/OWLrP0qS7X1iOgaqWDycs2suRLi/6Nt4Xnax3Sj7tE8L7jPmFT6dKsO1jZBG0YtlJEDdQouRPHpOE7O99Ix+0d80pwD/V8GCquNf5fSyQFqHB2cEFwJmN9UjpGSvqkWATLDa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by SN7PR11MB8026.namprd11.prod.outlook.com (2603:10b6:806:2dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 21:27:30 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:27:29 +0000
Date: Tue, 15 Apr 2025 14:27:26 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 01/14] cxl: Remove else after return
Message-ID: <Z_7PPlANtmwlijY5@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-2-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|SN7PR11MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff11fbd-1db5-478e-7cb1-08dd7c645393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bBEmILQFvvWGpzb4o/OA+QrxMSqpp0IrK+REk0Youeo0759NsP701N/BYgoa?=
 =?us-ascii?Q?LyNBy01QfpyCxT09bL+/GJfqtkkv2AKUh/fEoBBwm/pQNHAqmJElJTfkFwXL?=
 =?us-ascii?Q?axUMigrwvzbAw6wYO2o2yTp7MXi9aVjSM7c+Y0qv0HvvpqObQRqwHwKmvjoK?=
 =?us-ascii?Q?ahhapd1qZFMal+cPLCncGbuhxMuxXXRpFuCJ8EbyvrBnPKG2OFcc11f91+iT?=
 =?us-ascii?Q?2O9J2kUbKH8ap3bIi2oL1VzJqTP52uLS4z5uYRrviMNviDKVtQEtfqmUliIl?=
 =?us-ascii?Q?/JEuTd/msBk+rdD7W4lXvM0iLEfRChEoikXzgGhQQThPqAbgRecHlRdaMsYJ?=
 =?us-ascii?Q?vqh6tFwuTRkLraFqnPx+VbA/GIxKM9zrLGShDqFYg1vUgrrg1Qi/sMGfxBAs?=
 =?us-ascii?Q?aM57ZgnWh7hDugqrcEKUY0GEcw6MeG0pY6KOzRjeH8P0vQMZAbt7JF1Ag5p8?=
 =?us-ascii?Q?BDiFCgQrVUH21wjZ5Ji9hHP37OSCISVgyxGyAID65oG6B2RKabDP+TnJ0BSH?=
 =?us-ascii?Q?6AlEJDGO1PZsnnZ1LbH4j+iDH6e7LcnIKv/2a4alrY/KIVIOnuDx3mApaaqf?=
 =?us-ascii?Q?yi8Rc7oFXFRjLnBfh+kXXQDPGN4ba5uGOHCsNI7Qoj+EZazNRHAQ1G7U+2BF?=
 =?us-ascii?Q?qPaK7P0ySVG6JxyYRjIqVzJJsd53QG4uAhzMLdX6mIsNZ1laaMhCxoYT4p6P?=
 =?us-ascii?Q?lHWElPC/YmPoCPyEw9OpKvTlxuNk9WG5/kQCXQM+y59nArTW/VDtIodkZXSq?=
 =?us-ascii?Q?LmoQlCSDJ5IfkVVZAcg79MyBzjeFodoG47KByeqqwnzyfTtIFZ78IWLpG1BQ?=
 =?us-ascii?Q?cVAvEFRa878JvS8//PMRh+MrE7xzDtgwgozvEGw9Bijfvcaw2u80EjbrA+Vz?=
 =?us-ascii?Q?DC2OGa8XIQmNx9TT7Sl5f5guRuX3VZR4ALSEpPSzZ1Ugvh3GCZ397w6qneH1?=
 =?us-ascii?Q?YZ8g4Pl6YM3h7Czk+0d8KmrKmjaFLP3WHwRyGx8KNDlKIBJw6G7C6YtPS0RA?=
 =?us-ascii?Q?RLaTZAlqYAOkP4P9Y0UDJVIX1RKM/1iiE9NhgmhiJw6nuMYZ8s0U9s9ncmka?=
 =?us-ascii?Q?jUW4tkLY3GSqysGTFtEyEAEgWbGUTVczBpj/ZGxyMr5tCQg6/8AB3nfNpq74?=
 =?us-ascii?Q?YJ6U9WPb7FBDsnqRa17/sjO9ywPqqW05PGhiHZXqoYwwosGi5xiZ+v9ETz+s?=
 =?us-ascii?Q?I9Z9KM/uS4oAtCnENLEthdCh1q/FVfTtCKFaCB7S8arTrTVOszpigOZ+sWZf?=
 =?us-ascii?Q?PSXgKj8HkKFVYzLNhXAeCSQzyemDfl4qjiLPFFIJ1nskxcF4+7HFJDPI66pe?=
 =?us-ascii?Q?9qwtRy6yzWugA3WJJnEHQPHXSLR4mOIkaxo1MfeMgXYOZdG2g5r6EZ0Sm8/Q?=
 =?us-ascii?Q?VPTNuuVUK/t6tO5KPQQfhIIEn4mAwug/iBMZKZ5Kin0KDFLl2EMDRikVsgrE?=
 =?us-ascii?Q?tFrmW9vgH7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?epty//xp8fne5DJC7+kWwAG/xqqdwR1YM8X6dCRL1p+9ju/RJFeUO+EbA1wy?=
 =?us-ascii?Q?jRS90u20guxzhFcaPmuSqC2FxmIF5pXOi5QO21VIIXXdGG/so2+wDCaO+V+8?=
 =?us-ascii?Q?VXF2j3eSLS30TuM9vYzYbdPogxmNp2nm9ULZlpY/nXJ0dEuPZ7b5heFMkftt?=
 =?us-ascii?Q?p4wn0dojJlhcoqSxizxc5QiO7gUjqfM2GPdfUqrdqyvjnkdoNPp8rx9f/+qY?=
 =?us-ascii?Q?+cZAUKivAvo2OyMxf2TdvFYjV12TYEYp5Eu58ooK8oGtgJCHYYn5JRBirDz2?=
 =?us-ascii?Q?0GhhsoAby/zs74KvE/ASAeLovZ4uaS6XPdnpg4CYM1U59hsuuAqAZTjTRA6d?=
 =?us-ascii?Q?ZbOLX67m18wjjp24K3q0pOIpHxfwVfOAsvSmpYAmCZCuMMvEGM14uveRjZuZ?=
 =?us-ascii?Q?EeMBFxw06BravVzHFo2rRBHIjdwnoULD868Qm119LiunxO9xvVjaBNdN322E?=
 =?us-ascii?Q?AYS0b3ilK0D2sl2XfGE4GyD0loc/Y3OuG3Am9e0o5tEIteB+sKbndsK5WCOe?=
 =?us-ascii?Q?9uH7zsftBPlGUGxuIxsHURG/Zj5jwIQeZ/tu1MtJbTJea/6RG6mxBPrxDOVM?=
 =?us-ascii?Q?5vqrxi5ILXgHibKe9tmOwotuwXlbCfPrrvp6ZPoAI1gbecQDIKPr8X4OZoi8?=
 =?us-ascii?Q?fjDSejbZARGpk2iWssMAysZGWWzz+dGc9SNNVcxvYxUC2mLzpgD3fYhAfLt2?=
 =?us-ascii?Q?EMMUWym02/CjNaIvmVDOumfxTCY4O+aH71rS2gK0IHcfGTGrSNHwiy00nsFL?=
 =?us-ascii?Q?yrOPknxSGbIhg0fJkh3K/PhtLYbUkG435FIhyrB3MZpmkD9LC0FvAphXWPOD?=
 =?us-ascii?Q?ojkIk2HrYqXq5AI5eAPxYXCjfCibcoFQgVi+RxSBJswOHmGo+oDaoY4DC6df?=
 =?us-ascii?Q?S83M5styYAmKbxQH64xNIxxqdEJ/vpVLcGJEL3+zjxodnponu6f5xam626mU?=
 =?us-ascii?Q?K9gy7x/YkxYBtqKRnomcVsHrQ92Lfg7Ry/zwY9BBB60S4QO63Z50qLpiPBTB?=
 =?us-ascii?Q?m/g4y+fuVEj/O27GjuG3gi2kLpCsdX4V6cNRFTFL9TjWCTV+qkFkFNSp+6hX?=
 =?us-ascii?Q?qboKZSkarKbIRWfeP4F8Z9KlVX2v4+YAc3PkBoFo+jxzn6NUu+msbJZo5SqW?=
 =?us-ascii?Q?nXbsTZA6JTELG4u2GApHyWDUNML22aGbed6sWG74L+XeCW9RvRLDmwXsluXN?=
 =?us-ascii?Q?GQ+nIHZlP9LbHs47PnLrGxVKsioRr6dIorAgYVaA2bfOjuJ7pwGjGpEJ2p9g?=
 =?us-ascii?Q?NN1iVmXJGAU0IDNjpUZj24hY/XLaZWISaYM7k6f7rCi0aIab+T6Fc6pcRCJz?=
 =?us-ascii?Q?Sk/plf6yPjVVYNOcgL8hDrNiiGAdOVF2/zy5HO65yh7C8oBW6+4NVwIQ8lxy?=
 =?us-ascii?Q?lwR5o2jv2v/NGofsGXzp37PIYlGiFExo+s9VCx/zmcCOXOqKFXRXc0cuhw5s?=
 =?us-ascii?Q?/OkpjEaoo5cxrBUvS6HLqsoFhtLvS8RbzmJDah4v2h1Wm7D33WGdjFb9Z0ts?=
 =?us-ascii?Q?G5zKILD1+gbiqnTxTlbhReZw0vR8HC3dfBErSMrvp/v6ROKRR7mScA6ftLBh?=
 =?us-ascii?Q?ojA4lDx7MoH6SDw/xOLtnDAq2qUgjzzxS0f8OfrFeW8SJltfqCn59MGlMiNN?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff11fbd-1db5-478e-7cb1-08dd7c645393
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:27:29.8800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMS6uuxBBJeNFAUaARq0yW2W26BqoP5aXRSzefIDWl0dfplycCg5g+5Ou71qA7/0Netr7/HLn9zJYLeVqL3p5W09VdSklQ1tvJn3e/ITFo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8026
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:35PM +0100, Robert Richter wrote:
> Remove unnecessary 'else' after return. Improves readability of code.
> It is easier to place comments. Check and fix all occurrences under
> drivers/cxl/.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


