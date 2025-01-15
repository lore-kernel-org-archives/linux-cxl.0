Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9071DA305
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977497; cv=fail; b=XkAtfbH6asiOyWU4wCKI4zlJrIr8HhQ+qoEIp9lo3xt0QJoyQ+YwSVMd4w3zvlibXzpBJFTzmUrKVc4jwrRta/jbnvgJ4vmVIXgXzK+mtO+PmGc20bmB0BMtDdU1CND+if5N4jXqii+/E/LOezqFzlUZjWZ7CJyzto8ECfJb8eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977497; c=relaxed/simple;
	bh=J+hkJeNRiXkE8sR8ncJ23SP5QisigonZFbLvuuLciik=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=km2tLpiSinzcP8TEahEJadOsyBiwnzYAZU15Oz2uF+bLRMnkhGb/FX/cWvOXSxLJlUDoXUNL69E3NZ4B+5M/oSeHMtY9i5yUgfC74KjpwEkiKefCkKEU2wjQS6Wux8rZY6PyWeVOHVjNFgcoTw0sI7QEsmsqWZ1K7V1KvE4f+qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8XNeuy0; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8XNeuy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736977496; x=1768513496;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J+hkJeNRiXkE8sR8ncJ23SP5QisigonZFbLvuuLciik=;
  b=n8XNeuy0GLOPVKkn61xdHKY/zCT6n5uqjDmgXyXxUEenEZbnh/DM0LBB
   JzhyyHGw/PQiKPbgPPm3Ibo9x8VCfQcK5GeMYjk5dhiElTpYFlCglpFdy
   iQcYcYw86fGVbLD4CA6XrEx5cnEpRZrAWftjMeJA9qshu9jRnKsJSOttk
   sVxkKpeigpFH1FT7oBYfZZ3oJNFIB4GBVpvhTyf39+0akjNR8aGCIp/3w
   ce36SJBhmgF1OS1PFrf+tnm/VzkqSgyNYnP1tTuIfh9KXJQK4nYGYaUp9
   adUTkw99tnL8iOopFVo4/4iVB8JDsBr9XMRog5dODXU7f9oi0dazsTbtw
   g==;
X-CSE-ConnectionGUID: jQLK0FckT56G/ZfpH7/rZA==
X-CSE-MsgGUID: WEJXunPGTECtFrflgDA0SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="47993583"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="47993583"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 13:44:55 -0800
X-CSE-ConnectionGUID: NJbA0ar6SaWtnWdCsttvzw==
X-CSE-MsgGUID: AcyPEK6KTCGFwo3jzUadEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106123205"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2025 13:44:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 15 Jan 2025 13:44:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 15 Jan 2025 13:44:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 15 Jan 2025 13:44:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py5r05kRp7Fbt89Vp00uGZTdpjLKl1QWeF0tdglWhwMov0GVnMjnj18iR3UU+KAwOt8ywIm0S2EoIqEfatdz0UQnY9xyMGrTgc6x2dRpYNjy8jYYZsG5P+oR7Pbt8db+XadYjw9Yx4MqSISmSqP9mTqaGyqJSGJlpwI2cM+N+/fg+toVpftWafgJH42Hf6vG70K2mMsUAuoGiMNrOhldiuRZOE6A66YqDQ7j2XM2nnXWz9hX4A6LFGI9XzSlnaB08ufQCDdr3iFdMTRFZ6CWbHahq8b5gNx2cbvbX5HfQMXl+lTedXpawoUiwbAZCvvjhvuT63PXy0thk3RJRJUseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7OHMbxkRvIphqbSCVeqw2JDYNxO+JnXdqcXDIB/wIc=;
 b=csG6Tx6/JNC8Z3isjqg1jDhuejLXjTxYK2sW6cADD2JNc6Mv8G0nVszQ4It3felEUZtHd+BV03aNlESqctlRw6KYA1ZvHimVlb1MaQD7ovc+aL15azZFkhu6xwmU+8K459Lq1fdwx63NypzXI2QadRuv2X83l4kMnyypdctLsChULjhYKJUlOoFiKAsadXfV/JssIz765akd9Z8EO80zKYGsbugbHbPviV3RRYHR13ZUiWHFAlxFLS663atD1mdrtK2daSnx3WT7avfRsP/EDDofmYfVgzigmmlyK0qgXdEKnSqxgN+dZr/5EuA35OebqsmPLY3N/MOpLY7YswXVlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 21:44:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 21:44:52 +0000
Date: Wed, 15 Jan 2025 13:44:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, 'Dan Williams'
	<dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "mj@ucw.cz" <mj@ucw.cz>, "Daisuke Kobayashi (Fujitsu)"
	<kobayashi.da-06@fujitsu.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: RE: Unable to display link status of CXL1.1 device (RE: [PATCH v18
 0/2] Export cxl1.1 device link status register value to pci device sysfs.)
Message-ID: <67882c522a8b8_20f32948f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
 <670efd5389f6a_3ee22949b@dwillia2-xfh.jf.intel.com.notmuch>
 <OSYPR01MB5352F167B18CC4DFC908D692900D2@OSYPR01MB5352.jpnprd01.prod.outlook.com>
 <OSYPR01MB535257C0AE84CC123A656E1590192@OSYPR01MB5352.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OSYPR01MB535257C0AE84CC123A656E1590192@OSYPR01MB5352.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 653e14ec-5669-4ce0-8393-08dd35add7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p3YQB988mIA10k5WtQOYeA5GdDuMQyuiPKkSP63TZZ/gToyUFIFu3n3ZWcWB?=
 =?us-ascii?Q?eGDhcCBQEOCdT4hb+8OSNpmIXwmO6EiqH3RXgbcIogRwZJK5leqcvUmzrJgs?=
 =?us-ascii?Q?fbhuCHLvqcTKgZhQovIg5uOWgnvHczNANLLoXSFwvhkNVAIVoG7HiG0u01rV?=
 =?us-ascii?Q?bTCY5fxDIbxlxRa6TjUvzS7oDDi/xWXfyBYhB7qqOkYq1LzV1PIBrj5TVrFs?=
 =?us-ascii?Q?zrwSriwUsU98z3xltuB8Mn5UbshjHQsDoSLQGcX0s4g7pwJHyVH7hci97QHU?=
 =?us-ascii?Q?o7IXdvVWWX6kOCSMWNDTqDZOmyRFu7sjlciMXmUkmpFlLO8pKg68IFtVG0jc?=
 =?us-ascii?Q?npbxYIpjlVb1Pudv/x+cTnnSGla/lerlkRj7aOfdQ5Sc1awSrrIYPRuw12jv?=
 =?us-ascii?Q?mGl5OMEj/Z5YvQXv/v57YcYRQgeHTWJWOtU0qaaLcPcX/EsD7q6GW9DRsMlv?=
 =?us-ascii?Q?53eP6qSlYKwedP17jQWO0N1XBChT682mp60V9eq2a+3uQ0Mp9/Goa8VyIaEG?=
 =?us-ascii?Q?YPCqL/LRjkoiblr4BCIfS30i1rYBhsA4Ub5MIG4mZ7vSzfDen9xHB3P9ZV5v?=
 =?us-ascii?Q?GFsQ5232R6/vFK7sEwg7OfnUdY/KZQcgoFMTEsFDM5apoWG6bOawnRGwhYOz?=
 =?us-ascii?Q?xel5Hv+jw3YCff1LvrFJhxwDkoDUzLcOiZcunlFHcFcawYCr2g5sWThT3DQM?=
 =?us-ascii?Q?6o4FT+mD/5kt1LIWHxpXYzDkjWLLChGJBMBoji+zjJz3AOxMLSJfQLKeieLw?=
 =?us-ascii?Q?+eVyuW9pbYDyxpn+M9Mm0oBnZpLsXYRkhp8n6tRmiulGn4eGAogPtz1T+eZj?=
 =?us-ascii?Q?5XHcKqyiZCdLqIOOzcgNiRuNrjsIzpve6CMWn/PPE9mUVG9JdD8oY7Uzd5lw?=
 =?us-ascii?Q?aaZ1PFDjxuN8s4rP0F/CuDgwkOfeWGrPbdxfpmhQIeGToDK16WLu4oomFa6B?=
 =?us-ascii?Q?G/eXEthRbeGUklmyqeN2xpm3bFmrCWxvTd3oA7Tz27nrWoZatLHp04Mu3Pv9?=
 =?us-ascii?Q?NNot49LjaKcGbwwjD9rISWfrPkZbtDc54ql2vZqYxVNJwKqliwJSHFf3/vJ7?=
 =?us-ascii?Q?O1ZppbI8nrSFChgRAtpx+mPUoBEbFV56/5mm+GRQE3/JfJDzoJrW7hDSMRWw?=
 =?us-ascii?Q?2AyYJmZ6F9mV1zPkkxOjxnKqL97FdZS2R0jedAuawciGdC4EMgGZO5xM0lvC?=
 =?us-ascii?Q?2g81DSHyFiUea3MFtdEb2Evv+WeylrOcEL9J96QsWWI4/BHi2/yTMBVOUuXV?=
 =?us-ascii?Q?GrOCLVfJUSzA3w8euHYvLvRmlVWCKf2Qh655V4JfL+8jQ/M6kWNrdh21rSqE?=
 =?us-ascii?Q?4BTLDnHFrO0suV+cOdyoQEllbj5JeauMpSP/tydJUMmbGzKfbejDesTr6JUR?=
 =?us-ascii?Q?vog1b12w49vEDT6nwcrjsk4CgseW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRl99tWx3PpwdT01Wr5BOHCm+3zOfo8OWN16tj0UKiXiAZrnAccHU428XQUQ?=
 =?us-ascii?Q?EEKEau/yhmwzPvfsBk0YwFoUcN33SMPztMsFRnegbh1h722HG4WUeU0VacbD?=
 =?us-ascii?Q?5U5Y5KmLvPoZhap3QJdOVsAG83JYyW9uGtGPpUrbFjkXA15Co/foIHFfwJxh?=
 =?us-ascii?Q?MF2A0/GQDgIpxLGByB/aLKDRNeVKLWCAssRGxUsdnjd/Kx5f+txrRmgU0ljh?=
 =?us-ascii?Q?duCwCW3U4tQw7h+y4OdqFzCN78RAnViib/wjqMewQqoNlZR/nrx0j26+rj+I?=
 =?us-ascii?Q?3inQlVXEHRnruXEMkEsrd05F7/Kyk3OLPbzBqBZZb/ulc28afjqxW0U/ue4Y?=
 =?us-ascii?Q?pW/7AeQTgqV5dh9Y1v7gSCX565V/rBTA8p7cyaSVu2A8JFVtdV5ltjb4uXYF?=
 =?us-ascii?Q?S8jxt1y77toOmfle3SyugigbLDCKdiYflYURyBhY3RgopiTKqSexq+TdsQtt?=
 =?us-ascii?Q?U+9/6CjQWT9doz/yz60im++MNOdI9F51pD4aBjRtPjHiPf+FgnCz8bAci1mC?=
 =?us-ascii?Q?StmElcsRuL9k94LSNESmJmH2I2W20HUJDzNsOJa69F8lLKU+NW7zgzWPFErg?=
 =?us-ascii?Q?fyh9FPm0XCs6WkmnIJHrXpWyerJ0fh9SsXbm4nrW3j3gmct1oKCPgExhHKIx?=
 =?us-ascii?Q?RrNBww1gNV3ETX3x7Di44mTmRXr8HgE9ilCSD8eqHEiRp48GpCb94qzWc+26?=
 =?us-ascii?Q?LRKkILVA/80N5XcRgORRjL23g/QdFCOsVxjldd+Vzk5Q3wRLcXW8oi9I5eg4?=
 =?us-ascii?Q?zPTwO7MOmrzj4z7Z2tdovth5rK4FYb0NaCC3/cTPDXfwiXwv4sc0oMcpgfUC?=
 =?us-ascii?Q?hfSl+O+Yg7pgZSq+I54C8Z8zi44Lm1RV4b21anuiqeFFo6CgZdXPSZHxo92B?=
 =?us-ascii?Q?/cBF6hMbxQHptfyxIAzMESfIB4NfCkbnWLsiMFR4qg8QeIRcyra5t4tJaexN?=
 =?us-ascii?Q?+IT2xMhlHLBDC5WlJ0IG1700FVvV9LImwu52vFCbIMvyYX+Ym99sK3FFyiLW?=
 =?us-ascii?Q?GgycU/p5lqrtAvt/tNoGeBZP35PRxAdBryeXeSAwQ2pMz4OngyszvXLJ3Ei/?=
 =?us-ascii?Q?VJI5e/2VCd+a1VFr6Ogur0iGQ/5C0yugz+L5rVuvtRoIryR+x+kLP2VZzErW?=
 =?us-ascii?Q?2P482KBDpUZr3XpX/P42jpR49TF4sBxI9T/O+w+gUlzALp+ZLoSh7pFXsq0m?=
 =?us-ascii?Q?EZ2nRVaFIrgirpI3P3yIz4nSJBx6lMZnCvkDE201YU4OGAwlCG1O1Ui/jp+V?=
 =?us-ascii?Q?hFTWGYunTet7EBtHatfzjWeYFJQGyAXeKJBobt6+shwvE/kOnyWeoowVqaWw?=
 =?us-ascii?Q?wFRu0ax1b6HGbhXwD2a4vXVcDnWAklDhlzfelOVUYAhKONQMMUCGxfMjaaPj?=
 =?us-ascii?Q?l/d/oBBqdcf6Zz34iGqFgV4/2D77xTYSGVsouurA4hg0Hu2KTaceoQFi6LfO?=
 =?us-ascii?Q?HQQqmcL0M9H2BxhIxZ0swOl/IOi1FGj/Gj6NxbPmiI5uQBxTN5K9C2bSmanN?=
 =?us-ascii?Q?OMXuZDHym+gzy5TpktR1q342ojSp4AWRBGJJkEDT9w11CCZMSRovAnawQZxg?=
 =?us-ascii?Q?rIRm99n4NpGDvxYgxD5HtvS1AJp+05qufl7oxcbGa7lG58XDfi4rKVDBaWR+?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 653e14ec-5669-4ce0-8393-08dd35add7bc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 21:44:52.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKhZcrL2Oq28DzJoznOKL5HHJ1Td0nGCHRX1imYwwXTsLK/TMCF/kz5xDi6YsQIyKIE4TTliQk5rRmKxqMMl6FGHYwFuxzq1UPZR6svKge8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
X-OriginatorOrg: intel.com

Yasunori Gotou (Fujitsu) wrote:
[..]
> > Fortunately, I can use the real CXL1.1 machine for some time.
> 
> I investigated this issue a little bit and I discovered a significant
> detail.  The "ACPI0017" is NOT defined in the DSDT of ACPI on my real
> CXL1.1 system.
> 
> Consequently, cxl_acpi_probe() is not executed, and I guess this
> prevents the addition of an entry to klist_device.
> 
> I suppose that the current code assumes ACPI0017 is defined; however,
> it should handle cases where it is undefined.

Early CXL 1.1 systems pre-dated the addition of the ACPI0017 definition
to the CXL specification. 2nd generation CXL 1.1 platforms added the
ACPI0017 object, i.e. the CXL Root Device via an updated BIOS.

The Linux driver is built upon the cxl_pci driver finding an endpoint,
and the cxl_acpi driver finding an ACPI0017 device. Then cxl_mem driver
*connects* a cxl_port hierarchy which triggers enumeration of the RCRB
etc. Unfortunately, without a BIOS update that provides ACPI0017, the
Linux code is not prepared to enumerate the CXL topology.
