Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95581D5CD1;
	Thu, 17 Oct 2024 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203670; cv=fail; b=nMwOB/h8V6M69bADaogorRf3wPBpwjYx18gG/+U3DwC9mK4GStf4TogmNywQZXMaLjokiNVHYytr8OvTCcWYlonfkeLT9wQ5zhCq5b9zL27Rs+v2dnVjwEUiTr8bpwgxspT7ZqnMfVm8NrlMhMHjQYGuQf9Kn8Rj6mL++bimyFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203670; c=relaxed/simple;
	bh=DlmMICuy8CrNhEYB94hGbE6uHy2p31379lflo7Htc9s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PmLztiDAGGN8i9mpIKwhwf+VL3Sd9yvQ4xAxotp8ZLZTSPQCuYA9A0QoDBniqTWAkziEVsFpRx7tPu2jPInRlKhHxHiAWbuqcqyfhwq52cfVcOMFKzVL11xjwVjzMVM9+mAAZVvVdQui+qYUYEUQHsEihADk7+Vw10BG6tzH34M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+0SA62y; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+0SA62y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729203668; x=1760739668;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DlmMICuy8CrNhEYB94hGbE6uHy2p31379lflo7Htc9s=;
  b=m+0SA62yPsxl/CpSM/jNnJcP8zWyZawhbWAYK3DtF2UhLRxzJG+/Ofde
   71NiHdAwe+pd26i9ZKoQsYFEzEiJBL4SsDtjryewawPaYi+mObwpIkOdM
   pm1BZUFMwexGiUhmCl3lmj+poJc/2cqeQW6ue6Syes3lO+yo5+KaAJ/Q2
   DwFrd1+VzFzKonw9jeBneYSVUwy6nsJi+AmX86Em2mcV+NRzUlmOBAIxf
   i6W7rVWKlvYU3mF8tboD415fSgZKZkzPlFEBxVr6vLy0xAXtPy+OR/Mwa
   RwpUDjCIQc/aZvuEPhMusPbJAwyUp/oXvScaKqDIsldYxircLd3QymNPm
   A==;
X-CSE-ConnectionGUID: rjDGTEOhQXKZ4wO7d2o1mA==
X-CSE-MsgGUID: YOVgTCQPTcmZJp4wH2PZpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51261895"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51261895"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 15:21:08 -0700
X-CSE-ConnectionGUID: zgEG+ZsmQRu0MN+LxYi46A==
X-CSE-MsgGUID: XsIHbh19SBO9zy0PbXXudA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78291710"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 15:21:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 15:21:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 15:21:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 15:21:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 15:21:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/ZKEOTjqu3q+o7fibib1iMwB4PJVqGk6kejSjSQdN/KQR+TQAuY3lnmPRw/wINL//sKlgbzTDSyBA90fgFpAkswSoc4C2DdcMuB8Yvt8FBAONdAMnt3WA1kBA+eMFIEy5ebP5TWXypAXlNmHtnvfNqxGLrGqkXdn9sbycgwGoaVojKsIU3tHK5Ilo1nIK5Al64zG8Uoe8g0YAZdJlf6HywamsTMKLuhHGWpmCv97EgKJ5j5DG4bWajZpvjW8Xg1VVxNCLk8rE2blfLDiWqdNo2NrEDNTgJF0/ubgFRhNwzzpdvkDrfK7K2DE67LkE/vCtwNbICUqWSqdwbd5CvYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adI5F8dpVXn9xzoquTHap1l5ujnOVA/mox7UloVNTCU=;
 b=n2L7pc95y2LEbsper9i0hem7xA+EnAfDWR2qHQPsRR1Ww/Hxxndc273kwllIAtZt/3tuqbjsiquenbx8FmqJyAA47zrqdx68R/Zg8lR+EmaiaS3jrHh6H2PLSAaXQaYjWrdh0ZYNU8tVbLMumAvEC5T+lkxrrDO6hbA5Cc/KpmQG9BbnC/ZXoYwsewViDrgyl2xLofu9zKma2LdUcg8rAMNl2q/N8rAGei2nQincnDWUQuAd4YQnIeyebKA3oYyC2zk637+94c/4u2B4BkogBkI/3LMh4L03+JCQN5kXUAPE+upGwSlWewf4Rs3b2uVorqb6n4ejl6wQ/jw7RCh5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BY1PR11MB8054.namprd11.prod.outlook.com (2603:10b6:a03:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 22:21:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 22:21:03 +0000
Date: Thu, 17 Oct 2024 15:21:01 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Huang Ying <ying.huang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Gregory Price
	<gourry@gourry.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/5] cxl: Rename CXL_DECODER_HOSTONLYMEM/DEVMEM
Message-ID: <67118dcd2ba4a_3f14294fe@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241015065713.308671-1-ying.huang@intel.com>
 <20241015065713.308671-3-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015065713.308671-3-ying.huang@intel.com>
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BY1PR11MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fe736c-1f8d-4c57-ebdb-08dceef9fce0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xOEevPfI5lxDmIKSCYL1PN+g0NyTcIR7hHYdowK6xwF3E2bHPW5tdXdTpVKw?=
 =?us-ascii?Q?KhYvv9zMqBmkuPh6Vp8q8CRKcNQEp+UdCRml4hg9GGIgn7iEgwgF+J8oDHvV?=
 =?us-ascii?Q?Dv/VONFr+XpgMx+eqZjsPn54A13D1XZp+ieyvzsXdRmSIcJj534vtUllvOC5?=
 =?us-ascii?Q?TEfpeMI14bl1TnIqiVH6tfgIehQijASM5bv3XYaNrAKVucZ89HvfwZPnfLji?=
 =?us-ascii?Q?6fpw/y9JbxtzlnKkCBH5+7TtxPG/josH9hlPumTvzxg8MfRuVLJIqwtk3BP/?=
 =?us-ascii?Q?z3WqyfP+5qvIYzHCyBALFtBHAG+ZtIvSNdjadcGpQPcA5HVbHCqQLHUgsVba?=
 =?us-ascii?Q?apDPyWRliN4EvEJwAPYLjFe4BmCVJzpx1IqgW7SGcMZ0g8eVvzyCSCP6qG5U?=
 =?us-ascii?Q?+dtHnTVCYoB+mxcnUGYcOY42CvLnRi9xhvVpNerS2tX7hUoQU3PEtAunBtGc?=
 =?us-ascii?Q?wdHxVmCx6+/mkyv2WWoASQbYj5gklEQVSphW/KudXw0z8MPDUXHDyBb+FWV9?=
 =?us-ascii?Q?yDGDWmqJSPY+dQLjJTj0E1d4/L5CTCV7GWWC8raKiadwm6FZgKnxbnhom38I?=
 =?us-ascii?Q?MYyvZCOS1CnxH9GR9KsVS0XDSIMiIr4wsBzc060K+R3jgZU5szBWvK/Rltup?=
 =?us-ascii?Q?EcwyuBmPtCeGwXeawt+WUhiwZuQ5x9b9fCFiF6BdnIxEmz4gjas2HnJad8Wd?=
 =?us-ascii?Q?QGl3ANq7HeNGd+VvJInqtUf+hwrKk44QPzm6wC0Ay6fZdFVoiicFkAjziWaq?=
 =?us-ascii?Q?+hkH/jgkbicIIQV++szIGrjJ7unxtFlclDQX1MUk5B6PCAOt6xelKlBe7SQI?=
 =?us-ascii?Q?7wXDzH1DWuuvAq+XyreMSctISvHfX3bpGNPyV6FEO9cYhHMuAW5YrEgnB6mf?=
 =?us-ascii?Q?9P5oXKNIOiR9XSe4Q2P418g5OwdBIy18dQ1yd7InneKVRYhTAhSLsTYxqGpl?=
 =?us-ascii?Q?8Cq+aRLVrGbfFO+fUOLo9d/3VZYTxpfMGc510OxKIACdLLxF6AMPrNs90cyj?=
 =?us-ascii?Q?O+z9+aF3m00nniuIbdkPf/SLFeFcPf5ekyksSe9ZiyLJ3WbVq4bLdYnmpj1P?=
 =?us-ascii?Q?a95FOpysHmtrYU2QiIbd36jCkM05UDvMz/GVsZH4+uo/6bBsklrNTrO6UmTC?=
 =?us-ascii?Q?eCeSBNll5EpUF58P+R1nrgO2JPiHUAGy6XktRbqijfemPKbQMJ5QR81fRDN6?=
 =?us-ascii?Q?JoXA/Q2GTYSNGUG477NAN58c3wb9Z6V7gw4OOSI/FPDcj5CZYXLv0aY4KN/v?=
 =?us-ascii?Q?xdY880HqdG48VDCUDk73csryaprvv3oepdOjEoji/Q5SEV5p31448myjg9pX?=
 =?us-ascii?Q?QG0crHylP2pOtXtwi+6ZN4FT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6mQCaYMHiNCHrmcNjy9ot0k230g58DokKjhDz6wB9VPP1SrEev+IoOdUE44?=
 =?us-ascii?Q?kKk9d5ry/NEcLbwvLQemZTPinqki9qOZxAT2COUb+joHCgijqbxq6NBq1+WH?=
 =?us-ascii?Q?NOw0q7q5ppkZXbv9PTNCIpvku0cv536WHjR3qmP6zwYPxlFrKTDY8rdTJSFA?=
 =?us-ascii?Q?oln7lpZjZUf6DWXgs6p8X3HiDrqwj175bykIfGIOvIlCRMBscsD/LCSmsKQL?=
 =?us-ascii?Q?hOnsFhqXBeuw6VXiPW1HgVys0TCMmUysE2WHqVIImZfbMxqR6dsE1bzH4/hK?=
 =?us-ascii?Q?GPt/4YlMkbobzInvofjYn6M3uBG+layfBTnojO7yIu9+5dDX6NQ1yTnU+3Nq?=
 =?us-ascii?Q?Z4eSZAfE6mRNHgqbRwoz22e51wnXlsah8ubSkVnIeM/MZckKd0QTa6cyju3W?=
 =?us-ascii?Q?l/crVBfsg0iqPpGCfAnkHMtdt/rfpZoq4pkaG+i+/bE2CW6odBbIJZ7Fs+/x?=
 =?us-ascii?Q?NcKEqFyZy2RixLKUSbo3MddQKDX75tUZnfbv/S+7F1pQLMB1Ixr9RR8PlFoU?=
 =?us-ascii?Q?8trQIALQFMFf6SrEBDnTveTuoxwWCRQaP1pQBS7nXdvStIA3Iiv7oEX7rq+5?=
 =?us-ascii?Q?y6ZOsIjecDxrm6HirjKPAZzDGShPXZTs1vQXshrWC6y/i0SNufsgesZJDBT+?=
 =?us-ascii?Q?WvHJ8hfarKcHNJY3lhz2690O9dLqmUDJgmigWcj3A7DO8JtlWKTkXNp8s6cf?=
 =?us-ascii?Q?gC3JfB5PlencEVNhYPrhqnUC53ZwG5fiaAkk4/F0XVnlvPOb2PVPLXQU3PXD?=
 =?us-ascii?Q?ezefEerkR4CP4ylmYPlctYdheuwYUJ3lLYo6OFpgqcPuZwu1mg2HWBgfxuPc?=
 =?us-ascii?Q?i3whBzcPhZfMEFq1cwC1s0+94zC2+vOAv313MgW2paOvyZbPGgipRu9eNKp6?=
 =?us-ascii?Q?hLRxAUz/Ma0B9Fd/54gtxKFxnPTm89aGiUrewjIEjfrqlCI/T0XfJKnDUIjb?=
 =?us-ascii?Q?NObrWLpabWJz4BfkfZ3RlU6MhmUvJRfQiTvNtrHC7dHZZg1artH+GAz/d4QD?=
 =?us-ascii?Q?whU7J4ZVhhJaoQ2Ni1Qnk5LBx0nQjA3jtjFni702LE1a01BRPcwPuRrEYlDR?=
 =?us-ascii?Q?EnE6gE0bRFkyHmZCIKU2+GqWbU82A9lOTvPzOgI9Hq9Wz1GYj4M9LexU9/bO?=
 =?us-ascii?Q?0B+KcytBkaIUkFEP7u4Q7X+np/ZnGaOIRhoxrT3/FdMyTvkH0Uii4AZWFUeD?=
 =?us-ascii?Q?S0OSpvEJSg7MALYr5KgbqP9S4Ggb4SfW/v2IHIR8hLw0XmJxWSM8yCgtwsfw?=
 =?us-ascii?Q?SSbMTXJSySNpWAc2/uFwQJPwiv4t3GbGGT35HkV2Ywv1BYBQA3eIcag34lJj?=
 =?us-ascii?Q?HX5zFej68EajQWq5+4rJzAiqBHsYZiNYEUTuDcFgyBVIh5WsY7GcfIMXyfDy?=
 =?us-ascii?Q?gl23SL7tF8B2IS5dth7R+uomSWfRpZqGOxVhbV5IoPe2VGipWznr319Q2jB+?=
 =?us-ascii?Q?ynG1aSc1nNWC9D0mQ8WsoWqpP0YgO22wYBgN+geOEfCEwFbto/WIG+gA/s7s?=
 =?us-ascii?Q?bvZH4HVAVVYHsrl2+QE3wpONDG4dJzea3KzUXtzH8bpHFqt9ZyIf1p685qpu?=
 =?us-ascii?Q?MlZbFdars7K6epKrqbK3yGNrsftlz6hsCxRhiedTXwPU+Gld7fPC6BM/MAdT?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fe736c-1f8d-4c57-ebdb-08dceef9fce0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:21:03.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLkRZElhpIZLh1TbBV85pDQBZyGvqmcZK4ttoHDNhQLOwOFJ5uYb8wMbX2Q71PjNf+fV0jD/BnWcT7CZ44rcLPDShgBHPo/1gXl+1/sJ9c4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8054
X-OriginatorOrg: intel.com

Huang Ying wrote:
> Previously, CXL type3 devices (memory expanders) use host only
> coherence (HDM-H), while CXL type2 devices (accelerators) use dev
> coherence (HDM-D).  So the name of the target device type of a cxl
> decoder is CXL_DECODER_HOSTONLYMEM for type3 devices and
> CXL_DECODER_DEVMEM for type2 devices.  However, this isn't true
> anymore.  CXL type3 devices can use dev coherence + back
> invalidation (HDM-DB) too.
> 
> To avoid confusion between the device type and coherence, the patch
> renames CXL_DECODER_HOSTONLYMEM/DEVMEM to CXL_DECODER_EXPANDER/ACCEL.

This does not look like an improvement to me. Type-3 devices that
support back-invalidate are DEVMEM devices. The device plays a role in
the coherence. 

Your explanation is the reverse of this commit:

5aa39a9165cf cxl/port: Rename CXL_DECODER_{EXPANDER, ACCELERATOR} => {HOSTONLYMEM, DEVMEM}

...so I am confused what motivated this rename?
