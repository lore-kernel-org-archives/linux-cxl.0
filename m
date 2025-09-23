Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4130E82D;
	Tue, 23 Sep 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758664338; cv=fail; b=F6TVz81rABHnVAJhjLz2YVXyBHf8IC01SJTCWDSu39n0FXjtMRbv5zXHI0rGVpzltDrxOU4Tf/xIQkI3cV37endCOfSB1AJ9NwoQiiQidkJhptIGgvQZCXS8JvsphFZdPQdiagqgt+2pSAn8+Ch6lEgNyR+uf1h/CD398KGGLig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758664338; c=relaxed/simple;
	bh=5Bmmv/yAaHKjp9T+fPQd/rCUbui8femWfZbjFKssae8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4MQYV+tSnP5fFXVouxe/j95IXPA7H+Jug8i0RzPPsSJRfwYKYMH2tIpIya+WKLEQldR153IMdO+vjlSAtIgrQ7J8VhyN45aApyhE0r+DVhJzPBrrI7nJO1JXROhZMpkzu24Zma6GQ9dCmI+8K8NkFghxo+G8tyL0yrqTWZqN+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkoJ8cxL; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkoJ8cxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758664337; x=1790200337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5Bmmv/yAaHKjp9T+fPQd/rCUbui8femWfZbjFKssae8=;
  b=SkoJ8cxLpxlt8bMr8DZPrt2CDFXqtr/u7yA0kpZUCOb/u4ixNIncxrz6
   xPegdcLi1x/WDn9aJpmL3I9iDHAtfrdzAHuV0aHP/1XgGqNPBpuYhVKQV
   LhjNv3m0tFTMSCGn3IrV14/MTagZOsTJ420diB7hN4l8/dnltUmCU9fH4
   qkB22omZuOFzGT2KpPjlydTLh6IWuKY63f/WUI3ky4byF5XZY7Ax7DhpA
   yFYmT6aPC2nUKsHEUss2Tk97vlMOJfeMN/kCWbA5zyXSZnUhMIH6XnZsZ
   TBv7Vs5TaWKWpM4hTPWg8aVlv6kZJ1gCl7QdMdHeCbC8FXiEXZqDqDglD
   Q==;
X-CSE-ConnectionGUID: /6OiV6DDSImnBPkwuhmyCQ==
X-CSE-MsgGUID: jKkOC0SMRNy9HbQmnyw89A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63582817"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="63582817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 14:52:16 -0700
X-CSE-ConnectionGUID: 5q+wUnCYQR25mI25XVIbxw==
X-CSE-MsgGUID: tQe7E1/AQN+vxmC9Z3Vzdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="207800793"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 14:52:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 14:52:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 14:52:15 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 14:52:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5OoYa89Uo1nWbW8kUEL13O0obY8XgjRsGB+3LTbSL1kvObrxd8IgQw2hbJDXzvwnDkEkDpWKzHS1yynBx8wdzXULdNr5aNEVcQljuDJ3+RENnbyLogXHQzeusitbt3An9DE6NLUgnYb/LIv57E0UDkmHlxlEOCa63a6y5XRqNtc7gqm8jxUWOsi7419aR6gwL8XjGjiaUlTXikC1dZgwmiIhQg5MVoHJxb/Qpb3YjkSkGhj8TgIMSryYLihhaiGdkt0mGVReV/+mz71m5BweI6YtFeEGaXYBFYtIKXUsMmupOyUwRxjn8Cst1gQwUGpo98uZOEGhcdpoV0osyziDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkb5lND+hSGvRlkMLGEe/n9D5FgLzIli3bqGBaMSB8U=;
 b=XZYtDJHYHor8c3njocNi1sB74H6AaCE+wITjKeZ5iEK1MZmBb7Uftv9adcwJ0QXv5Bta/25ZjPhTMlhRosf5ffXk12gyh4ocOE+PDJtS/F3Ca/u/Vp1GLngWDRaJ451Zu930PGxGcXQQp9BcxeECuq6/fT+FTsYXLYBGFmHlY+mOTvsnZIWWmTJ+NMjD/K8zDiTqBPV28zY8FH+LZcqTE3hItLjaUdj/GnDdwUMEAInKQHJONrGT1bKA92zvc0FnLBusUJF6xrGAJCBTrZFOJp3vR5L7LCUjaBffN5IyxM6KTABi/Nq3De277E/ToD4PCBDE0AYqFaYLrNWoqZE9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by CH0PR11MB5297.namprd11.prod.outlook.com
 (2603:10b6:610:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 21:52:12 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde%8]) with mapi id 15.20.9137.012; Tue, 23 Sep 2025
 21:52:12 +0000
Date: Tue, 23 Sep 2025 14:52:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 05/11] cxl/region: Add @range argument to function
 cxl_calc_interleave_pos()
Message-ID: <aNMWhG5Ftu8ETYwk@aschofie-mobl2.lan>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-6-rrichter@amd.com>
X-ClientProxiedBy: BYAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::46) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|CH0PR11MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 299d5f97-a557-4bb2-e28e-08ddfaeb7382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4nmSMe6g+sBzdR338HZzkEBa98YgARCwPIyaUaQ7OnPC8CzVZmPp/Og0uDMc?=
 =?us-ascii?Q?Gdu+588na7Wliv10oswk2lBdpkYcR+wIjMkhWbOFZeCgskHACZ6z8NqpOT7k?=
 =?us-ascii?Q?ubqyHfjr+t6YiL4cyDdODDlcznmge4qA1ZBWI8eEyv8CTrJvdX3IPAW7+SVb?=
 =?us-ascii?Q?gTe1JPnYpD9SOHUgy/g++DnLEp+9PdhJCmy4kppdHbd/HVTSaiPs2mEG08lm?=
 =?us-ascii?Q?wzlakbx+5KCh5tgwOiuJCo7U3fEwB/w8IWA9nCi6/6lVPh7aTGuQCR9++x4M?=
 =?us-ascii?Q?JQW3gGm+g2a5YkothoH98oHvwXNATTzApzZ8xxY0Vv2inPHDp0Qu1gjL/MgX?=
 =?us-ascii?Q?ozqkpuZOtH9LL0P/CA2PJKAC42Hewit5pMUoYxVx5OFaJA4AXUC2Uei6fIQ5?=
 =?us-ascii?Q?PM0QTcpD9Zg2zY8tgWJVubjCA4UsUrBvUHd565s0fxHhdi7kAyjVcLVszEBU?=
 =?us-ascii?Q?Cyqk1EqZ0C2YHi0uo7uas/keo9KxrBepCKAbFes34AkSFL+jqpeNC9uBbBI2?=
 =?us-ascii?Q?3BMGW8eFfxgtKsuW5R6y4+LVxEHnVxCmi0GXS58Xludca2r4hjHthHX1m+w3?=
 =?us-ascii?Q?uUla8HI/yjkU9BbUYFKX8iiOL4r6EftC83ZouEFnEtk0r/fEcIQjfmy5gbUt?=
 =?us-ascii?Q?K3pKQYyk9MBhUk1oFK8LIDQcA23hATW6nUsfeQN1XHyy2eo+s3NRchF0FMQi?=
 =?us-ascii?Q?fvwX55QjpyLphwj90v5dQkngoKH5GvHtg3W4muI3FYtJm6AKPNG20F57X0FD?=
 =?us-ascii?Q?vceCvvxrSkP+NKx5PbZgLhFAlChAxuBheKTlz56NEtIvDkcscXLgb5+Pau5U?=
 =?us-ascii?Q?lQdGR3XVDzzxOMyivhFtDjLHhr/NqRKtjW5znRecE99UMwJuJh6RNoZB85rD?=
 =?us-ascii?Q?OQfrGtfLxQAsb4OIDuujZISwQ70k3hLePcBHF662HG54/fg/XuiU2FwBu39O?=
 =?us-ascii?Q?YFK13gP+EP/WJLqDVwD2m90xY2wuvl+z0rAmZ1LSw0RgtRykSfvGz/oM2jgX?=
 =?us-ascii?Q?Q+hw8AljIHwIe+q25Civvn9k3O29y89Ia6ZcLP7BZoq29w4tL8UDcVRazBVG?=
 =?us-ascii?Q?kFAuIt1ah6zulPht9SV8JFxHjoyt/uWikh4MRaiHtLIzPwyHre4K2rDJ8Ut+?=
 =?us-ascii?Q?226c/msdBW/80eOxUY1ZKSVKTYJ5eLNKEwm5+nXdhifyf3T8YblSBi6U0yOY?=
 =?us-ascii?Q?y9JpoLDP3T4AYseuSGNeIfyxmoW6vSEMAneMjjuEjE/S6eofPBzvISOTzTAH?=
 =?us-ascii?Q?WIL0pry7KX1KM+FXQYTuYKzzHdjLFriXJKIjc3qg75s0r5mi9HgYh7ES/ZGS?=
 =?us-ascii?Q?XX+QWYjvzoGDuitlAySckyjwGfaL3WDeXCxxdcwgqFGgHMdcd/CYlElnT4wn?=
 =?us-ascii?Q?l3CR123fCeZrMzzo8plusuSCT7CegA1cDkmgSW7GYAIAU+vN1gDYbxE/sHSC?=
 =?us-ascii?Q?XjlA8e4gPXg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nQNHXxvVpaVnxxB+HP7nU/f8MisMmq70um4xp+lIrYCOEzv0bnQANTdPPJyj?=
 =?us-ascii?Q?o4HVeqd27nLI/w0P1j5gtBJpQYitEXCmoVT0wBtAX/a9UqfUjLrMHNwgtpug?=
 =?us-ascii?Q?w/p4g06qtyqUgc2bgPsL/C52Oqz1ae5AmLUjxrajPi3gJvh+98shi5YQKgEJ?=
 =?us-ascii?Q?3GiBouorqEiguxRS71S83Hml61vb282dRpNPMNXOkQz+vr3bXc0/z+yloEJm?=
 =?us-ascii?Q?UYZTQImkRBWFhSParaVcVRFKTkThOdS9HjjUPe89m9iW15xHDhKSX+IyF1W6?=
 =?us-ascii?Q?8OGE4J09qNKVuluAnfHWUs3CdjKL/xL3FESE0FN95W1Hi4o6axwG7XvoaCFf?=
 =?us-ascii?Q?5ldH/5IX8rfgJosdpQbgsnxhA58LiMeYXpsyDP7c7ncKG7RJbUL3VFh8ijZF?=
 =?us-ascii?Q?K3rpi+6GpT1yXip5czYQdYOoncebmXIdsHl0PHRMl0Z+rArZ977rnBkBNZhC?=
 =?us-ascii?Q?QJBQ4LdCQdolfN2OF18i0o9ruwH6aJzzvT/vE2d5T32sAAHpLuaqwCxlt2FN?=
 =?us-ascii?Q?rAPzlEUDpVc6K7QNWOe+Gu9SKrXuJu/LSPTyDOW8b4fJBkps/m1YVFbiOq7P?=
 =?us-ascii?Q?zuA3EPTf5O+fO1C2FRSj+aIYL4JWMDjnrv/Lqj7KXElQIyRAkzvQTrTaQ86a?=
 =?us-ascii?Q?zNikEU8DZEmaNg1Ry8czqmaOzJzffDwnxv+8V8dy5HPMhMBFw96DIC8wU6Yo?=
 =?us-ascii?Q?zok6V3wjytfnbj0r6XJW78SrjgNzAOL+xuaCLveCbOhDywInC3MuM8r7btym?=
 =?us-ascii?Q?0AULddYlxA3glqr14mzdm5+IuB6s1QblkCwzZGBR843//zOjWWom9qWjzAyy?=
 =?us-ascii?Q?bf3swmjS+LrGxcUTGe3Vx70kd933r/bgQhM8MkHxcELh/24kaIYs1muOf67z?=
 =?us-ascii?Q?EUXe6vf7C6zQbXvqFGO15eNTA/ZERLF5NECnDNuCYYdpww/AalaaFLNZKHBl?=
 =?us-ascii?Q?COnoQSA/uoijWuIgSu2VvhFTpMLZpJg8a7DWE5EL6a7rVYBu+GHn0EgX9EaQ?=
 =?us-ascii?Q?kgEx5rhr4zfy7gA7e2NgA0AofZ+JBd/M0oIS2nBpu8ew14KKombp/xNTvvas?=
 =?us-ascii?Q?u26DUEB97hg8skK+SKo4zJ3np+zLTeMFHS6ZY0IZZ0zYmuapaW5it5JIlbtl?=
 =?us-ascii?Q?9wMknkD6zpvWtfmTB3XeTYyyP0vHAcVHC0t3cRetQMBExqS5k5QYigUDC3hn?=
 =?us-ascii?Q?z9t48IsowrMZ4P3yLqnEJtyYUf5kqui5edZ7BPyNXAEj30KdphFpeg/NlAwc?=
 =?us-ascii?Q?kAhd/KUr7g7+aafvU3YkFKvHfMwFZRSu5ZNGhNkYPOjCI3lGb51/k1szEpny?=
 =?us-ascii?Q?eN+0UmHVNXU7xzNpzQUCyj1Oa+yY7hpMfTChdYdYjQsJ6yfZL9VmQvv2pzPG?=
 =?us-ascii?Q?h1d3c1zG5ixvgGofWuC/GgsB6mejEpoN5Tr92qBGRUJybyOO9XJBYt/SKVDM?=
 =?us-ascii?Q?FdDi01zvIRFwO5wdrES4VnoiNyVS6nOQAkZWSEKfX6SUSYCtpiSGcEFZ0eaQ?=
 =?us-ascii?Q?zuv4FfQFKerm3JbOWEapKJVs+1kf5mRH9KCKzwFRRCAJLhptDCwZB4PtK8rl?=
 =?us-ascii?Q?axonHQqFo5ZdsP/z+pyirddjY9NVNmPxP9eIzmemeFpx8j7eSePAEiA8wwoe?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 299d5f97-a557-4bb2-e28e-08ddfaeb7382
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 21:52:12.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkf1OqGkC/yiMhGG5b3zyA2W1A6VtIi6voJf35d4Bk+Z4bCj327mjudKLpWhU9shkg3UMryGD4EhrO0Rr8y54YlzhlrygI79Snh3T55hW44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com

On Fri, Sep 12, 2025 at 04:45:07PM +0200, Robert Richter wrote:
> cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> determine its interleaving position. This requires the endpoint
> decoders to be an SPA, which is not the case for systems that need
> address translation.
> 
> Add a separate @range argument to function cxl_calc_interleave_pos()
> to specify the address range. Now it is possible to pass the SPA
> translated address range of an endpoint decoder to function
> cxl_calc_interleave_pos().
> 
> Patch is a prerequisite to implement address translation.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8ccc171ac724..106692f1e310 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1844,11 +1844,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
> -static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> +				   struct range *range)
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *range = &cxled->cxld.hpa_range;
>  	int parent_ways = 0, parent_pos = 0, pos = 0;
>  	int rc;

Will this work? Change the assignment rather than adding a parameter:

-       struct range *range = &cxled->cxld.hpa_range;
+       struct range *range = &cxled->cxld.region->hpa_range;



>  
> @@ -1909,7 +1909,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
> +		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -2093,7 +2093,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(cxled);
> +		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>  		dev_dbg(&cxled->cxld.dev,
>  			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
>  			(test_pos == cxled->pos) ? "success" : "fail",
> -- 
> 2.39.5
> 
