Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9F113AA53
	for <linux-cxl@vger.kernel.org>; Sat, 12 Jul 2025 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752294208; cv=fail; b=K+LH6Hrw+ngg9jBx0pcSYHhFmvEuS34AoEHcTQwdWXi4HTf3yuy/JrjfuKSN0tZgyFJA6cHVKLVZ/E+1kyZ1/u+INGBQp2kzDUUimO++/KLOYGUe0M4KHfmyglT9I6cFevA5DX+nANNsIlIFGW95js9fc5ywOadHy+M+s6n3iYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752294208; c=relaxed/simple;
	bh=8T14gIJ2/0Ye7x1xW2HMCfr0Lhjw3/aJBWoGlQrJqSI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UD1NrcDqE5cKs6VhQ0jPWTQRCLuIaLuZqaNBlH6Cb8+jjzMGCR+ylTio92JtwqmZO2o3CkQh7a/HF9TQxPlwItPowjKWoUNU//OhLL0jcfaWA38Ik9LgyLJBctCClYnAk5bjB/9v1PDo1xFBFk5xU0qtVV79e9dCbZ/kZwHu7ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lu7HLBdu; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lu7HLBdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752294207; x=1783830207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8T14gIJ2/0Ye7x1xW2HMCfr0Lhjw3/aJBWoGlQrJqSI=;
  b=lu7HLBdufeP241vn1LTdCVpUkGS2EDvT21GRvi7WvVNgChBS0E/wwGAY
   uWMJbhnj45JjhQ6f9RLG1zHxMFtgPtjWjvtkAQy+WpETK7h3hBAPfmyvm
   nnlTH37MjuU3Xx+H2UfNBISGqaUuqj0zu2UYZo0VZKW0ejGzFmiMumRzW
   ZPHuGkWsPVGX0GEvdCnPhYcpe3YeeGyhL+uUuIgmQGxugOqewi0WpR8G1
   VB4fh75VG6e1ABUEnIeBWMvAVCgLDNwgLhpgEiND6UjnJKI27VcF48tQb
   gB1zNp1zgNCg5tNpmq4nPRZXjj++aljKUuEzCtQ8hwLg3VxMnrmPSVdQL
   Q==;
X-CSE-ConnectionGUID: MpwWS6cYS0yrzjmGAhSx+A==
X-CSE-MsgGUID: BCdS12T0RUqnFQI67bbJHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58350867"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="58350867"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:23:26 -0700
X-CSE-ConnectionGUID: UYOHBR3AQeWHlFUCmlT8rA==
X-CSE-MsgGUID: I5UUzHFiQb2jEWzIw3h0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="187486372"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 21:23:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 21:23:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 21:23:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 21:23:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8q15lNr/2hWDxjd/ruLuUMsbeJ92pg6AAcB16tDuNr15Xkp6ULkMIkW1Ssbesn6jXTP2UqWAOXlXvRyR0SpLBpuWAyIwebd0gbTXCHk+Qb0I6tQPgNnJp6KX6qjCGxoRvQRqDVL8lxS/MG4toCvucJTCsW2sfjan8YuIE5AhnbekRrW/hlEWv6QrKgbvMic8rMDXYbk7CPnqaFeEF/Dybdm6uzJRY1uTbtXJQHCSxcKcuDYKBSgble6T5XfISpyg6vO3kK23mJ4wmpGqu5yPmSRT7ifrZQWhnVWswn6+PRSyAFtdU/f9aSt6V6/5A31uWVvUn01flJzvhRUsAvk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5y+MeVdrXXK8Vw3Vhu7qwLWnFPQC9XqJcz8rB8eOkY=;
 b=mvGkA/ZXjGR6PKmSlc5AgeHhggowfUKpAJ13QvaJumkWu8l3kFnzaVQxpq9IuJG+4+1dSyptLaMdEpobUnpZCCQCTXfceVyxYU9f0pC3lL3hm26miZQ2u0v+4ZfF2/QCRCgJAOiUcMJJzyubPh1grdqUUpxW56Gje5Pk3hP/+r0l1GKSg6B4GUcPpFNJUxSiRciBlApOD9534rUHCPTpfVzMT/zGYwLFNQbSYlIFB3KF4X6Xo9gYI2REqeTC6n5T7iF62wdlFoBpy/RKfAVtS1wfkUJyFvq3mQCyx8NG8xY2ekA0qgCUr6k+/GBN2J7C2O0dCozYhZYI55COMVKAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CH0PR11MB8144.namprd11.prod.outlook.com (2603:10b6:610:18d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Sat, 12 Jul
 2025 04:23:04 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::8254:d7be:8a06:6efb%7]) with mapi id 15.20.8769.022; Sat, 12 Jul 2025
 04:23:04 +0000
Date: Fri, 11 Jul 2025 21:23:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] cxl/core: Add locked variants of the poison
 inject and clear funcs
Message-ID: <aHHjJAFu1tgMULt9@aschofie-mobl2.lan>
References: <cover.1751513505.git.alison.schofield@intel.com>
 <2b713ef8bc5e090ec5da61157749bb6ac315ed3c.1751513505.git.alison.schofield@intel.com>
 <20250703152534.00001b5c@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703152534.00001b5c@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0184.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CH0PR11MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0a5064-604b-4deb-b804-08ddc0fbcb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UPvL3x+sYEqYbFmEyLDqKzuU7mrh9WETJO8ahyphokf1dDDFdd/rgl9BImnX?=
 =?us-ascii?Q?RlKHHUzoPXGQRoDALMVBOA7MrfUhNGfa2voOgjU+PlrfoAn6KYNUYHE3jJW8?=
 =?us-ascii?Q?SfJx/YFLk9nFn3J9CJm6D145pUdV3bdTBNKDokXuUkDXNgGy5yqrFUhzpd1j?=
 =?us-ascii?Q?D/YoWSIwdtMCrPGqsY/KUMtjhC9/TLTVJ5YViIHHIx3GRPQ8+7Ctz3ZGRdw1?=
 =?us-ascii?Q?Gp550V2jRj38qbICTkWqAK9KBdAd6Kq3tLuWV9AZcaSXsbqvtSJpZ6A/i5w/?=
 =?us-ascii?Q?0tzYFbgrpbv0rSG7HiALNdEhOkWx4FX0U4szCt1FQX3FPlIIQcaAa2LdHycN?=
 =?us-ascii?Q?bn724pYYsH5CAJFWTWpLDE0d1eUK3bNRASDyvNyvf73z3B7du5FJ1YEXiLEU?=
 =?us-ascii?Q?OlDMkev3eNvkU6fY//QyNAxx9ZwE9ZktBQToaS0DaTagX1EBx4l6/sDtwAS3?=
 =?us-ascii?Q?j/cI2L2lnt/6dE6IEBHZcmz9HeYRGxuDFCH3/NJSDHvZ+5dl4ep7+qi0JtKl?=
 =?us-ascii?Q?v5CTmhRPQ9ADq3J7kFss0/PWsA+XbUIwcUyHrKqLEcyY2O8s2p1aRb2TrvG2?=
 =?us-ascii?Q?K5N44C3+AmaNmE7BdeiQV7YoEwaeU83aZwVYtDrInzCABCvVnvlbAO0qetsZ?=
 =?us-ascii?Q?KIljc6AP2OYn8t6YNJXAtQGblSFTD7xQ6lcst6UwadyEbodh/cTw/Y1JlHSW?=
 =?us-ascii?Q?NrY6iBmFe1jP0wgaQruRt80+tmcusY7wqVsUCyFN+uidg2krG6AL0fPjlwb+?=
 =?us-ascii?Q?UyQiVkfsHc2hDCajjXHAPmqkKvdiMARiM79q2JtBaMmo69kf2rIdRzgP30ZG?=
 =?us-ascii?Q?ID3B459b555L08RZnMQaR/3CqxJpSrjkJ+ymCSP4v83RjuJf9emu1PJ+7jEn?=
 =?us-ascii?Q?h5iFNVhMstYFXgGStetwnhIMlJdYABGqOrZ5nxA/eDgZ/mOKflxSy6PsPdcf?=
 =?us-ascii?Q?RqmwikReb+j4sDAcffHijOPKci77GT+Sz6V/EgUVegSKj4oCyQHMZU3l0jGy?=
 =?us-ascii?Q?chxI3iracq7EkAONwpGrxzVCx2ncQ/LN27poptSD0b7AYfUVz88Z5rPzNPr7?=
 =?us-ascii?Q?L49h9JukTycXnEtELA4WDurXP10ErssA9vFRj9HXw6dDU5Te3dpNPBrZTpw1?=
 =?us-ascii?Q?k2eav/g8RwR1Zcs6zJyqE7yTDe2mhTniNxuC/8PcDL64RjyZxtQ8HjMi4PvS?=
 =?us-ascii?Q?GW/67T30xrInb8bTcYLpYF48Lbh6xmEYDveqe0Da5M4Jl50Jh7XD1zF9GcCu?=
 =?us-ascii?Q?jeJ8DpSTVNHaZ8AQlHcrmliQaPD5B5K9k0n7DEkkEqkjoU8rLgdJSfxLU6xb?=
 =?us-ascii?Q?g2oe23EGiUsllQqTML28jk7MIJhPhgvmBGZa8SnqcNsSg6F+CREjEfPXWQS4?=
 =?us-ascii?Q?YtQsUmvl+85u+xuk3dYtasGymsJOBu/z4SKX6EhBc54e+aWWKtvmTWUD/Luy?=
 =?us-ascii?Q?hAiEETl4CSI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cmpdlAr8laQFvteceKsTXQNCZxBn4gOdS9VVhBsthK8ZaUptddIPAcvfsIjW?=
 =?us-ascii?Q?GLc0NINAvq6k1lubkjgrm8UdQgLtUnq8FlXF21tIV0wT8fl+kApg5DE0WEyY?=
 =?us-ascii?Q?85NLcx5fblgldrxXWqymP7cvDggrnmwFNDxnosxPh6ttL+CFmQ4zLVjsgdsv?=
 =?us-ascii?Q?C9Wx7xgVYh31VQL7j5PkSoB2V/D3DHsTMfdOY/FxASWrc6IfWdR2au3bTlBm?=
 =?us-ascii?Q?MJdoydEiiPHRC8/Qd7FRn8dLIZiQgX9Xh4IfO2/Y6s9OCeTV+Rx9h25IXLsF?=
 =?us-ascii?Q?6W4/lZZGsJ4Ra8j8X998D+ywupwuNvUGi0/iljxMKQlYExm8UDyfU/b4/YdY?=
 =?us-ascii?Q?Wjjcro+KicBDK0IgZpwvhM24WEcOd6qXrymBdMyFfa8FQ8QiTrD6f96ltnt3?=
 =?us-ascii?Q?Lk8JLiTBWvY+HS309oXz7NXZHzPDOrH8/ZA+ffE6lG8ibr9XW7SEqQmtWwzs?=
 =?us-ascii?Q?g5wNIY1jhiexuuXpnQFo5faR41wQarHE3YNpMapIa0SyJPp5KJsrSAEj2uYz?=
 =?us-ascii?Q?d6FFHecPZ7dbrArQaN9/5jZAEGgZZWP7nPxISmRR9FcFjn9pynuSMj3Yld06?=
 =?us-ascii?Q?p/C7TymGWFhGM/32ULdIQGxkyALHYynkCW7A5C8EYotYpM8zE3rHEdlXyMjh?=
 =?us-ascii?Q?vr9W1227Fr06DFvSY1tI3Zv4o08eoYmN+nEmBA7WoFe+j5f44gdCOVCzEKod?=
 =?us-ascii?Q?AG6rM+/2mSzNdWl67lSHa1kkcpFhtYW0zM5j5yUFivFDlEkhiDuAI95OBxfS?=
 =?us-ascii?Q?3FJYV71wLP2CeFAi8c4ZaLLZe4LfcG+7M4LTiqeU3Klu+S1tJvTv9+Q+tBqs?=
 =?us-ascii?Q?ZEhoZ3u9M18RpKT0DL0bIoElk7nCinEvTDPkm/cLF6F5ztNU5L1ZF9pKnIrn?=
 =?us-ascii?Q?BqW+tqGzjps4oW415M5JmWhCfW0i51/7o9bXy8Q1n1HLB7zbx1SC3atnQQbi?=
 =?us-ascii?Q?0/cnbRFw5DoDKESpSTaTqLTRTnT6rhMjYP21e0L9jQ35sswx3xIfI+sXmRxH?=
 =?us-ascii?Q?XyVV2PxWuF6FjMFbakaXGTI7pS5+kJzhd1pkr4Yk84+qzDNpVrK1Y344+m2B?=
 =?us-ascii?Q?VNSCdMJGKix6mkRDOzLFF01AJRMS7s6j8HMoEZqIogfjNoTEnjeTv5qAVux2?=
 =?us-ascii?Q?1L7u6fvwhHIX0E77Fnmwh9MJaBf2x9RQMiSe2aYYVzwY0wfYikZuhoXGr923?=
 =?us-ascii?Q?IOCjith3MsCgs8ZC/agETP7QflJfpdASxsSOMbfmqZeMURw+xzyH5vsLOrfe?=
 =?us-ascii?Q?o/ZrT8AHfMX02hPgq6kWdSAAD9rlU47DupXJ8dNow5ggosRwysw52lPM3pkD?=
 =?us-ascii?Q?YwNKOWxVQi2eYcBeBbs9ZNjI0ZjgMo1e1CDQkZ911TEAF48oZacwsupjNXP6?=
 =?us-ascii?Q?ySqs8noEm2zMtjdeON8+HfbjX1XOGx/d+/tWLj300/LJ80l7MAVkcymL2cIv?=
 =?us-ascii?Q?k4uh53KgXRm6vOKqhh5xaAKjylju/znKbkqrt12aEFXLjJLUGbSDZNIx3dcu?=
 =?us-ascii?Q?QnLJvj52ryF20eMCdDBq8ZFS8QMneXWRKE3///20GC8XhnGD1P0jF8mBMW5U?=
 =?us-ascii?Q?74wsds3QpzLJ55fIo5w7NYELlA6K/yOHLadT2lf3lTRfxQ2/GGnVVd2G94qB?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0a5064-604b-4deb-b804-08ddc0fbcb7f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 04:23:04.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVmChQ90CCzOHg8KGSiNscFOGYbwAWYvovZMC/w3+/9E2fhTAs2ux2TK4N7OMXmefWJs6iYd4AuilljBjEAkhvbxqf8WsB+JM19Z6tkuyXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8144
X-OriginatorOrg: intel.com

On Thu, Jul 03, 2025 at 03:25:34PM +0100, Jonathan Cameron wrote:
> On Wed,  2 Jul 2025 21:03:22 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The core functions that validate and send inject and clear commands
> > to the memdev devices require holding both the dpa_rwsem and the
> > region_rwsem.
> > 
> > In preparation for another caller of these functions that must hold
> > the locks upon entry, split the work into a locked and unlocked pair.
> > 
> > Consideration was given to moving the locking to both callers,
> > however, the existing caller is not in the core (mem.c) and cannot
> > access the locks.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> A few minor things inline.
> 
> > ---
> > 
> > Changes in v2:
> > Return the rc from locked variants in cxl_clear/inject_poison

Undid ^

> > Remove the not customary __ prefix from locked variants
> > 
> > 
> >  drivers/cxl/core/memdev.c | 60 +++++++++++++++++++++++++++------------
> >  drivers/cxl/cxlmem.h      |  2 ++
> >  2 files changed, 44 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c

snip

> >  
> > -	return 0;
> > +	return rc;
> 
> Why this change?  Nothing locally visible seems to make rc != 0 in
> a fashion that wasn't true before.

Yeah, that was a late hasty add that I didn't think through.
Undone.

snip
