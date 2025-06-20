Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F61137E;
	Fri, 20 Jun 2025 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750453385; cv=fail; b=Eg9vC4GZah8xerbABYQXW5GLvnKGWwWNQV3a2zXvaH7KYRJhsVaJbb5Hu65Mh/x/dpy8/qa0iR5ejgnjkFF6wpSoEokVtd3v2cCsr0Xl1V0WAJBEXdAm+spMokScYZyICRKRxdsQaC2hxVOUwJPikp3/xDzrtTmEJh0Cvrw0Rvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750453385; c=relaxed/simple;
	bh=Jpb29KvFj6a9xVAVBzRND71lcEiWBvb4rb5/fOsY+Yc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mAP8BmNCM5BOElF49A8j4iTE4iEsKf88jfGz7YtjZEeZJ6mwNYCwbYeFDwRZHivRlMfgXSYq29uZ4XyqW8NbL03i+6XWRIaOmpJ4Zk2cFlCpf4pFZxMuYd0ptubM/CB4j/jJBMzLo84GDVlnh/sv0hBUgE8XsGMh8zPOFdsZ45I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMWguGp1; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMWguGp1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750453384; x=1781989384;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jpb29KvFj6a9xVAVBzRND71lcEiWBvb4rb5/fOsY+Yc=;
  b=dMWguGp1o1f/26xFuBWoYTI06uqUSArK4HkOVD66wlVzR9ntz1zev/kQ
   rvfv5gN3vbzR6h1/vvylSmrFpT9fwuTIRsDT8pncKG4WzI/FvCxsZ02C8
   Y+aJl5XMchbIvsipe+7/pS+hkZYonAz6iHyVnl6RDjrKi5t1ZgS12UX5+
   bZGuchcKU8ngq7M6Fnxb98/rfqC3bEgM/Geap0T67aUHz8HHgjM946aQJ
   em+fEi6yovyGLYt7L3+VK+Zgh6CBZYXTWqAKUPr+VB453pC/gMP4Fglj1
   cgmVlzOLsgSircpTsbu9f3VqHR1fnWGB8BMveu/fCUPHfm9hOY1Vt4XxR
   g==;
X-CSE-ConnectionGUID: ETikx+caTniwFCKNvZIKHw==
X-CSE-MsgGUID: OF+9we3FQWqxf8Sk6iRqpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56523854"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="56523854"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 14:03:04 -0700
X-CSE-ConnectionGUID: VfeM5C/US8mvP+4k0mgZQA==
X-CSE-MsgGUID: NGjX1onnT2SLlUp4HUSWSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="150601393"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 14:03:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 14:03:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 20 Jun 2025 14:03:02 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.86)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Jun 2025 14:03:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4I20TYR597a7fiWyYkH/ScTZ9Lm1VqC/kzYKxrYGiwbTVu5uWtkv+OlzjikSWeSaY9tos33lO/c9YeN+1l4PrwgZuFmLd5ONG//Lha6GZNXoiLoCFiaDsTFzWSkAdsugzrEzWigzZ/oXJMRZbEOnKdsFSa/lfklCsfRHcfX9KPcJejNBldwqUOrTzmgwm9UTLmXXlF2Bcv468c0p+JhqhVCIVLNxH33yb9ZYcxnK4fUIMRsweeNi6l6Dl1KRBPE+xYSPDS8fZMLk8vC2Tj4AA4W/v45zJ4yc2Re7BR3w6glVwdkCjwgW14F4m9BGfChdVl+35mzNRSuJgMP4j2pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpkvW4aRQ8lDRf8QVzH/aRkVuLKZZJyIEUD/HDNF0T8=;
 b=CfhuPR3kF0Uuvbimgrx7Nal5qIUeOmLL/eV/4vaSGhqCHy62R603RGcWPNAz05hxYpxylDZ0Tt54ePVaCB2Q2usJjhQknehCzfdfKO/UiOSJ0OIun5+XdMc9oZdfPuirdcsoNS/Lpned9U3V/9gIESUZ2GGwpyDSOJKbSFjDwmPHsT7Sx2aPcgZXlaLFvETJ/Pvrao1y26zfY9Yd+kMNNXLiLULUcXnrjpPcm5NOmYPFHlDlgUBNvuxiwa8ZBI/c0khW37bJ6DjsN073+HiQN+jTvzLlBS3Z2KK0A/IoY+frXj8PiVdfxI8R+uyFMdIgIL43bqTz7Dngx+5RznL2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM3PPF4C5964328.namprd11.prod.outlook.com (2603:10b6:f:fc00::f1e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 20 Jun
 2025 21:02:54 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%6]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 21:02:54 +0000
Date: Fri, 20 Jun 2025 14:02:51 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/decoder: Drop pointless locking
Message-ID: <aFXMe8eMZKpMsvQ2@aschofie-mobl2.lan>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-5-dan.j.williams@intel.com>
X-ClientProxiedBy: SJ0PR13CA0155.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::10) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM3PPF4C5964328:EE_
X-MS-Office365-Filtering-Correlation-Id: ce04c8a9-f0ce-46de-1707-08ddb03dd366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jlt4sRdMZAs47c14/GAl1dcsd9FNiEpJe7ztx0jg5spJB5FQND4XUKjwFEj3?=
 =?us-ascii?Q?aolhMpJrJoAvbA7I4jSrPUdJUp2/NrkZpEBLksKn9UPT19u2EzNvCBT2TAvk?=
 =?us-ascii?Q?c3JiynFyWGpgIRDOEOWzaRZ1UT28MnPRbQCP5/XxLVXzTJ8p1Xi7HbODsRvf?=
 =?us-ascii?Q?ZvMOTklDqi9g7yk9QJj5ghNQea2emHwYIg/CVca0PUqH+AK17zbVVTuZu21G?=
 =?us-ascii?Q?4mhex0Ygjq+abQxIgdMKZ9xjooXYMdcUhna3r5yQ8VhFs5qsF11GhpVtLUpi?=
 =?us-ascii?Q?WrBTVcovjKhuL1ydwVSwNqSSIUScPwZXk/JxQ0ppsBJogRX9+KnYT8tA26uF?=
 =?us-ascii?Q?AV7JFIQaBsZIQyAMH3uKmbk6v9Vj/W5ps7RRLQWJBqoW23+zvkj/x8hOwJKc?=
 =?us-ascii?Q?D1qrGX+x1EMs3Mf5vjTUMqzWiYRrujGVlhg+9+InDi2OlRze9yQM7+MeTxm0?=
 =?us-ascii?Q?fFUZ4SjeyQzyWS9qAcf++4qHV4gqNF7iRPUB/x8wznOVwkv9qdh7gHwLlwY3?=
 =?us-ascii?Q?PUF3f36yedSzpbogVnPjpcWPeQdoiR4FlxY5ThhNrA2rcMswFZmkpWIDBPDK?=
 =?us-ascii?Q?J43qSMh5gdNxgYfsIL54o7yJlMNxPUZePMZaVzx5LWgZkw6Npwcn7n5og7f5?=
 =?us-ascii?Q?WQOzrq9ZVqmjHjGFBvh9OHR/xaGh9p8IcqPAuqNqRLh+RgpD4YW5oobT1IdI?=
 =?us-ascii?Q?q1swkfvuYx7PgRObwRYBbid53tcRyVeT6JGBGFHMomOj4VvGeVFJnKKAwck3?=
 =?us-ascii?Q?EwH7tDxRhX2CpK16+8yXANA3/3N3wjT46JaTdFpvcP6dotSIlYln2GFmsVkD?=
 =?us-ascii?Q?TwjfOEIUQ+mSTJLZoGyiGJEfJVU6f2TUb9YUWogzv2USkdSdt3+Yicdc69QX?=
 =?us-ascii?Q?TUGH35u/19afH3S4gLcdy16K07o81DYaUzHQgui/PmMbjCL3YqejDzhDndK6?=
 =?us-ascii?Q?Hb9eHUputp96atbyu87agTWHt/tlJnjC5tHAxt73S0Z5o9qGWHeySaBkqcbc?=
 =?us-ascii?Q?bRqM3IYapoGOPwaVLLIhuDOZVugIOgjkztJKJRcR5WVU6pJqwT1pMFcrf8xl?=
 =?us-ascii?Q?lOdQ7vOM9E6DJUQ1SPyTxaBln5Krs4IegiJvfFKU3Ccb0GKE7LpDEQf9mRnu?=
 =?us-ascii?Q?4F4ryYfsWt7J3X+yzXfKPz66Mbd5nzBjOJHxtC8SOUHaTGHLT9xv39OT4zH9?=
 =?us-ascii?Q?f2PN4L2MzC4AdAVajObmyDp50aYprKPPbHkHOztWPt9HJ4YLiYvurJwHIOty?=
 =?us-ascii?Q?Xan67VHJK3V1B8n1Gv11GcVxKeT+a12OQottgJh9O1JxNI/Vkf2y0M9hwjeH?=
 =?us-ascii?Q?DANw2ZKSc3uwQ8CfFVN4hVkjTE2zC+fawgfqWLYbLDVmqAG5S/q43zwK+vFl?=
 =?us-ascii?Q?Aro6FvGptZ14musSZviaRra6a+KtWTju3zDgpZN7+310KP7MGeFN5vGLnEvB?=
 =?us-ascii?Q?sQwNa7/yIFw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVDJeMLPzddzxmepFnzDp5LfYCT3vjzbwvLvjCku7Vg5GZCOIv0P5WQe+T7u?=
 =?us-ascii?Q?QAUudlyhlgwxDiUiZtkL4bp4Ae3Tr0Ju+sUjYIq8XzHB8WPTfK9VqZlSvrss?=
 =?us-ascii?Q?teE9CmlcAgnis5QknWldeVOnuO5gkJLGCks+JdOVkn+f7euNFIlxqKRGmws8?=
 =?us-ascii?Q?q0fKNo5foW6r4+b2DrXPDdDQ+VUmWcF0LuumO2vXkgU22Dawe7gN73ZTzQaS?=
 =?us-ascii?Q?mYlTj3PnFWuXJhXb5eeqUvcqJQbWlyXCTqjw4DaB77veBVWVG14Ha9gfl6+m?=
 =?us-ascii?Q?0XIAppCU/YM6dLRXAMQm8nV04xArkcqg1yMJn2ZDqd83MLLXVhM6ydosSSBz?=
 =?us-ascii?Q?hwd/VTh28idXj2sMgsA+mEENs/Dyc4Zigd04+AuvZBoviIdpJH2RZuyLJgtG?=
 =?us-ascii?Q?+vpvbtToBYfjt9te4dpRtSxq5z/Q3jgLwYHST2mRuxYW/8rDUFot9rlqdUni?=
 =?us-ascii?Q?I5PZUtf7yrrMR4G5hRzdMPN+yVMhuzHbirOFT94+LyzIb6GraMO91YnZEelv?=
 =?us-ascii?Q?jl7ne7SBR9H1EI19p4X1/59VI9pq9iS8oS7BFGgDjctURxKptgdbbPaKQxit?=
 =?us-ascii?Q?wNHYZVaw+FVQBaNDlxijcHUQv0ID0AQJ2hXjHjWXQ4SJSvXJL6PH4ajwPex6?=
 =?us-ascii?Q?BqaYJe73fYJ100KFWEw1d7nEWQ9U+v/UrIV/mePXlqPVDpo4Ypz+DhBp1U+y?=
 =?us-ascii?Q?CVuv9oxZvgSOxMLtTMz6L1YI2n5NSgXXKGeDEpkqx9my862XNSkRpwS+ve5B?=
 =?us-ascii?Q?skYWe4dqlT9GGII16nDuAwzzy7uh6QGLnOS5a+hKnnex102hWtFnXF0/Z/q0?=
 =?us-ascii?Q?m0cQUaptBSk/zLfezFh7h/I98I4e6A3sU3XB1zCBwAv8HTtprjcj7eih49pO?=
 =?us-ascii?Q?MU1SLmGpYLGGqHyHldYxK/SWOeK5OOPj49h4dfkCYG0E2Dxkan9QEgDaWh3b?=
 =?us-ascii?Q?j/89Z7QnVgjCa2aUpBEK4p6m9OV4xNa+83P06BjlT8YrP+HXgbWdDe0lriuY?=
 =?us-ascii?Q?VGoKVQe4S0kPMkq/w0bAjZ0wzMYylTtk7wyYCpmbKSYor/RXWC7o03tPIFXB?=
 =?us-ascii?Q?2Fs3GwXUSDddQ/sH6XB02A1FZ1cIyhsXyVyVUzGO+3qBowZCyjN/5Okw7uxe?=
 =?us-ascii?Q?IwxWEP9kmAVEGYyWwEj5b3+T7Xdyg4TDOgR01F77q0UJ5toaj7wal4beZnh0?=
 =?us-ascii?Q?jAoKZnJ2e4sQ3NwW4rl6F/QkgZzNvpEW7KRZkeeAqh/RnkOF2UhN5AVONKcT?=
 =?us-ascii?Q?0W0BZX7NLvarSxBiL0busOKJ8P/2nWyybPr4m7D64+Go1MLYdbBVQ/f34e/L?=
 =?us-ascii?Q?mbRgHRAOdBh5oQy9HREiwDov5ZYCBoGS4nS8noE5xbirfrm3fDBFkifhQU67?=
 =?us-ascii?Q?I4sIMHwUDqXvyOuEEvRZ0Ix4ysJ/KWklckxB15FHi6uGvj6mHi5HfGJ1n5Pu?=
 =?us-ascii?Q?5IDPpiIfsOmSth/s/J/dtta98F4drSSoG2SMi+nB+rm2mn5vNtHwfl2uMyAn?=
 =?us-ascii?Q?qTxGtIO3gAm9zp83m2XW7YRnjnOyV8O+kE1HbD6U8y1V2utI3i1YU/WJYspP?=
 =?us-ascii?Q?IBM32xJNK+2y9VDpK21RghAzGoJMpfaT3PLekYCNEaqv6IGRk5XB5GkaGaue?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce04c8a9-f0ce-46de-1707-08ddb03dd366
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 21:02:54.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYWcKp7eeT0NEsIUiXgHcA4Go2rw2ziQPWEwULrZzzcD27fpQdim6zFBwDNxhlQ1HZ9KbDFVA58UdcZHut8wjA2Z31lg2JwkhCvFlsXPWy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4C5964328
X-OriginatorOrg: intel.com

On Wed, Jun 18, 2025 at 10:04:12PM -0700, Dan Williams wrote:
> cxl_dpa_rwsem coordinates changes to dpa allocation settings for a given
> decoder. cxl_decoder_reset() has no need for a consistent snapshot of the
> dpa settings since it is merely clearing out whatever was there previously.
> 
> Otherwise, cxl_region_rwsem protects against 'reset' racing 'setup'.
> 
> In preparationg for converting to rw_semaphore_acquire semantics, drop this
> locking.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

